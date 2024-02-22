START TRANSACTION;

SELECT b.id,
       COALESCE(b.name, '(without broker)') as broker,
       COUNT(a.id)                                         as broker_applications
FROM applications a
         LEFT JOIN brokers b on a.broker_id = b.id
GROUP BY a.broker_id, b.id
ORDER BY COALESCE(b.id, 0);

SELECT b.id,
       COALESCE(b.name, '(without broker)') as broker,
       json_arrayagg(
               JSON_OBJECT(
                       'application_id', a.id,
                       'current_status', a.status,
                       'status_transitions', COALESCE(
                               (SELECT json_array(JSON_OBJECT('prev_status', ash.status, 'timestamp', ash.created_at))
                                FROM application_status_history ash
                                WHERE ash.application_id = a.id),
                               '[]'
                                             )
               )
       )                                    AS applications
FROM applications a
         LEFT JOIN brokers b ON b.id = a.broker_id
GROUP BY a.broker_id, b.id
ORDER BY COALESCE(b.id, 0);

/* Actually, I didn't get what does it mean 'incomplete address history' */
SELECT c.* FROM customers c
                    LEFT JOIN customer_address_history cah on c.id = cah.customer_id
                    LEFT JOIN customer_address_history acah on c.id = acah.customer_id AND acah.status = 'DISABLED'
WHERE cah.id IS NULL OR acah.status IS NULL;

COMMIT;