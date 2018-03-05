UPDATE wp_options SET option_value = replace(option_value, 'CHANGEME', 'localhost') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET guid = replace(guid, 'CHANGEME', 'localhost');
UPDATE wp_posts SET post_content = replace(post_content, 'CHANGEME', 'localhost');
UPDATE wp_postmeta SET meta_value = replace(meta_value, 'CHANGEME', 'localhost');
commit;