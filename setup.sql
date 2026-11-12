-- À coller une seule fois dans Supabase → SQL Editor → Run

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'photos-claudia', 'photos-claudia', true, 15728640,
  array['image/jpeg','image/png','image/webp','image/heic','image/heif']
)
on conflict (id) do nothing;

-- Les invités (anonymes) peuvent AJOUTER des photos...
create policy "invites_ajoutent_photos_claudia"
on storage.objects for insert to anon
with check (bucket_id = 'photos-claudia');

-- ...et la page « mur » peut les LISTER. Personne ne peut modifier ni supprimer.
create policy "lecture_photos_claudia"
on storage.objects for select to anon
using (bucket_id = 'photos-claudia');
