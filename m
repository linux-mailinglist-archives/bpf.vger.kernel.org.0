Return-Path: <bpf+bounces-18793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640C8221AA
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902461F21550
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A316431;
	Tue,  2 Jan 2024 19:01:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60DD16406
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZJRX002349
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:32 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vc9pavjqg-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:31 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8F9973DF01658; Tue,  2 Jan 2024 11:01:08 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 5/9] libbpf: use stable map placeholder FDs
Date: Tue, 2 Jan 2024 11:00:51 -0800
Message-ID: <20240102190055.1602698-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102190055.1602698-1-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8sYC0epKEQ4YgOrGrh4RoBvkTeUtCHNh
X-Proofpoint-GUID: 8sYC0epKEQ4YgOrGrh4RoBvkTeUtCHNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

Move map creation to later during BPF object loading by pre-creating
stable placeholder FDs (initially pointing to /dev/null). Use dup2()
syscall to then atomically make those placeholder FDs point to real
kernel BPF map objects.

This change allows to delay BPF map creation to after all the BPF
program relocations. That, in turn, allows to delay BTF finalization and
loading into kernel to after all the relocations as well. We'll take
advantage of the latter in subsequent patches to allow libbpf to adjust
BTF in a way that helps with BPF global function usage.

Clean up a few places where we close map->fd, which now shouldn't
happen, because map->fd should be a valid FD regardless of whether map
was created or not. Surprisingly and nicely it simplifies a bunch of
error handling code. If this change doesn't backfire, I'm tempted to
pre-create such stable FDs for other entities (progs, maybe even BTF).
We previously did some manipulations to make gen_loader work with fake
map FDs, with stable map FDs this hack is not necessary for maps (we
still have it for BTF, but I left it as is for now).

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 91 +++++++++++++++++++--------------
 tools/lib/bpf/libbpf_internal.h | 24 +++++++++
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f29cfb344f80..e0085aef17d7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1510,7 +1510,21 @@ static struct bpf_map *bpf_object_add_map(struct b=
pf_object *obj)
=20
 	map =3D &obj->maps[obj->nr_maps++];
 	map->obj =3D obj;
-	map->fd =3D -1;
+	/* Preallocate map FD without actually creating BPF map just yet.
+	 * These map FD "placeholders" will be reused later without changing
+	 * FD value when map is actually created in the kernel.
+	 *
+	 * This is useful to be able to perform BPF program relocations
+	 * without having to create BPF maps before that step. This allows us
+	 * to finalize and load BTF very late in BPF object's loading phase,
+	 * right before BPF maps have to be created and BPF programs have to
+	 * be loaded. By having these map FD placeholders we can perform all
+	 * the sanitizations, relocations, and any other adjustments before we
+	 * start creating actual BPF kernel objects (BTF, maps, progs).
+	 */
+	map->fd =3D create_placeholder_fd();
+	if (map->fd < 0)
+		return ERR_PTR(map->fd);
 	map->inner_map_fd =3D -1;
 	map->autocreate =3D true;
=20
@@ -2600,7 +2614,9 @@ static int bpf_object_init_user_btf_map(struct bpf_=
object *obj,
 		map->inner_map =3D calloc(1, sizeof(*map->inner_map));
 		if (!map->inner_map)
 			return -ENOMEM;
-		map->inner_map->fd =3D -1;
+		map->inner_map->fd =3D create_placeholder_fd();
+		if (map->inner_map->fd < 0)
+			return map->inner_map->fd;
 		map->inner_map->sec_idx =3D sec_idx;
 		map->inner_map->name =3D malloc(strlen(map_name) + sizeof(".inner") + =
1);
 		if (!map->inner_map->name)
@@ -4536,14 +4552,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd=
)
 		goto err_free_new_name;
 	}
=20
-	err =3D zclose(map->fd);
-	if (err) {
-		err =3D -errno;
-		goto err_close_new_fd;
-	}
+	err =3D reuse_fd(map->fd, new_fd);
+	if (err)
+		goto err_free_new_name;
+
 	free(map->name);
=20
-	map->fd =3D new_fd;
 	map->name =3D new_name;
 	map->def.type =3D info.type;
 	map->def.key_size =3D info.key_size;
@@ -4557,8 +4571,6 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
=20
 	return 0;
=20
-err_close_new_fd:
-	close(new_fd);
 err_free_new_name:
 	free(new_name);
 	return libbpf_err(err);
@@ -5194,7 +5206,7 @@ static int bpf_object_create_map(struct bpf_object =
*obj, struct bpf_map *map, bo
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
 	struct bpf_map_def *def =3D &map->def;
 	const char *map_name =3D NULL;
-	int err =3D 0;
+	int err =3D 0, map_fd;
=20
 	if (kernel_supports(obj, FEAT_PROG_NAME))
 		map_name =3D map->name;
@@ -5253,17 +5265,19 @@ static int bpf_object_create_map(struct bpf_objec=
t *obj, struct bpf_map *map, bo
 		bpf_gen__map_create(obj->gen_loader, def->type, map_name,
 				    def->key_size, def->value_size, def->max_entries,
 				    &create_attr, is_inner ? -1 : map - obj->maps);
-		/* Pretend to have valid FD to pass various fd >=3D 0 checks.
-		 * This fd =3D=3D 0 will not be used with any syscall and will be rese=
t to -1 eventually.
+		/* We keep pretenting we have valid FD to pass various fd >=3D 0
+		 * checks by just keeping original placeholder FDs in place.
+		 * See bpf_object_prepare_maps() comments.
+		 * This placeholder fd will not be used with any syscall and
+		 * will be reset to -1 eventually.
 		 */
-		map->fd =3D 0;
+		map_fd =3D map->fd;
 	} else {
-		map->fd =3D bpf_map_create(def->type, map_name,
-					 def->key_size, def->value_size,
-					 def->max_entries, &create_attr);
+		map_fd =3D bpf_map_create(def->type, map_name,
+					def->key_size, def->value_size,
+					def->max_entries, &create_attr);
 	}
-	if (map->fd < 0 && (create_attr.btf_key_type_id ||
-			    create_attr.btf_value_type_id)) {
+	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value=
_type_id)) {
 		char *cp, errmsg[STRERR_BUFSIZE];
=20
 		err =3D -errno;
@@ -5275,13 +5289,11 @@ static int bpf_object_create_map(struct bpf_objec=
t *obj, struct bpf_map *map, bo
 		create_attr.btf_value_type_id =3D 0;
 		map->btf_key_type_id =3D 0;
 		map->btf_value_type_id =3D 0;
-		map->fd =3D bpf_map_create(def->type, map_name,
-					 def->key_size, def->value_size,
-					 def->max_entries, &create_attr);
+		map_fd =3D bpf_map_create(def->type, map_name,
+					def->key_size, def->value_size,
+					def->max_entries, &create_attr);
 	}
=20
-	err =3D map->fd < 0 ? -errno : 0;
-
 	if (bpf_map_type_is_map_in_map(def->type) && map->inner_map) {
 		if (obj->gen_loader)
 			map->inner_map->fd =3D -1;
@@ -5289,7 +5301,19 @@ static int bpf_object_create_map(struct bpf_object=
 *obj, struct bpf_map *map, bo
 		zfree(&map->inner_map);
 	}
=20
-	return err;
+	if (map_fd < 0)
+		return -errno;
+
+	/* obj->gen_loader case, prevent reuse_fd() from closing map_fd */
+	if (map->fd =3D=3D map_fd)
+		return 0;
+
+	/* Keep placeholder FD value but now point it to the BPF map object.
+	 * This way everything that relied on this map's FD (e.g., relocated
+	 * ldimm64 instructions) will stay valid and won't need adjustments.
+	 * map->fd stays valid but now point to what map_fd points to.
+	 */
+	return reuse_fd(map->fd, map_fd);
 }
=20
 static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map =
*map)
@@ -5373,10 +5397,8 @@ static int bpf_object_init_prog_arrays(struct bpf_=
object *obj)
 			continue;
=20
 		err =3D init_prog_array_slots(obj, map);
-		if (err < 0) {
-			zclose(map->fd);
+		if (err < 0)
 			return err;
-		}
 	}
 	return 0;
 }
@@ -5466,25 +5488,20 @@ static int bpf_object_create_maps(struct bpf_obje=
ct *obj)
=20
 			if (bpf_map__is_internal(map)) {
 				err =3D bpf_object_populate_internal_map(obj, map);
-				if (err < 0) {
-					zclose(map->fd);
+				if (err < 0)
 					goto err_out;
-				}
 			}
=20
 			if (map->init_slots_sz && map->def.type !=3D BPF_MAP_TYPE_PROG_ARRAY)=
 {
 				err =3D init_map_in_map_slots(obj, map);
-				if (err < 0) {
-					zclose(map->fd);
+				if (err < 0)
 					goto err_out;
-				}
 			}
 		}
=20
 		if (map->pin_path && !map->pinned) {
 			err =3D bpf_map__pin(map, NULL);
 			if (err) {
-				zclose(map->fd);
 				if (!retried && err =3D=3D -EEXIST) {
 					retried =3D true;
 					goto retry;
@@ -8049,8 +8066,8 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
 	err =3D err ? : bpf_object_sanitize_and_load_btf(obj);
 	err =3D err ? : bpf_object_sanitize_maps(obj);
 	err =3D err ? : bpf_object_init_kern_struct_ops_maps(obj);
-	err =3D err ? : bpf_object_create_maps(obj);
 	err =3D err ? : bpf_object_relocate(obj, obj->btf_custom_path ? : targe=
t_btf_path);
+	err =3D err ? : bpf_object_create_maps(obj);
 	err =3D err ? : bpf_object_load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
 	err =3D err ? : bpf_object_prepare_struct_ops(obj);
@@ -8059,8 +8076,6 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
 		/* reset FDs */
 		if (obj->btf)
 			btf__set_fd(obj->btf, -1);
-		for (i =3D 0; i < obj->nr_maps; i++)
-			obj->maps[i].fd =3D -1;
 		if (!err)
 			err =3D bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_ma=
ps);
 	}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index b5d334754e5d..662a3df1e29f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -555,6 +555,30 @@ static inline int ensure_good_fd(int fd)
 	return fd;
 }
=20
+static inline int create_placeholder_fd(void)
+{
+	int fd;
+
+	fd =3D ensure_good_fd(open("/dev/null", O_WRONLY | O_CLOEXEC));
+	if (fd < 0)
+		return -errno;
+	return fd;
+}
+
+/* Point *fixed_fd* to the same file that *tmp_fd* points to.
+ * Regardless of success, *tmp_fd* is closed.
+ * Whatever *fixed_fd* pointed to is closed silently.
+ */
+static inline int reuse_fd(int fixed_fd, int tmp_fd)
+{
+	int err;
+
+	err =3D dup2(tmp_fd, fixed_fd);
+	err =3D err < 0 ? -errno : 0;
+	close(tmp_fd); /* clean up temporary FD */
+	return err;
+}
+
 /* The following two functions are exposed to bpftool */
 int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		       size_t local_essent_len,
--=20
2.34.1


