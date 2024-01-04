Return-Path: <bpf+bounces-18982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6D823A44
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66E31F26180
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02E15CB;
	Thu,  4 Jan 2024 01:39:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60817F8
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiLdB020285
	for <bpf@vger.kernel.org>; Wed, 3 Jan 2024 17:39:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda7m3ve7-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 17:39:09 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 17:39:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 773E03DFAFE56; Wed,  3 Jan 2024 17:38:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 bpf-next 3/9] libbpf: don't rely on map->fd as an indicator of map being created
Date: Wed, 3 Jan 2024 17:38:41 -0800
Message-ID: <20240104013847.3875810-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104013847.3875810-1-andrii@kernel.org>
References: <20240104013847.3875810-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OycVnKEOeFLTY8xcXnRLbbZOvdEaYniU
X-Proofpoint-ORIG-GUID: OycVnKEOeFLTY8xcXnRLbbZOvdEaYniU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02

With the upcoming switch to preallocated placeholder FDs for maps,
switch various getters/setter away from checking map->fd. Use
map_is_created() helper that detect whether BPF map can be modified based
on map->obj->loaded state, with special provision for maps set up with
bpf_map__reuse_fd().

For backwards compatibility, we take map_is_created() into account in
bpf_map__fd() getter as well. This way before bpf_object__load() phase
bpf_map__fd() will always return -1, just as before the changes in
subsequent patches adding stable map->fd placeholders.

We also get rid of all internal uses of bpf_map__fd() getter, as it's
more oriented for uses external to libbpf. The above map_is_created()
check actually interferes with some of the internal uses, if map FD is
fetched through bpf_map__fd().

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3b678b617213..6b27edd47c84 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5200,6 +5200,11 @@ bpf_object__populate_internal_map(struct bpf_objec=
t *obj, struct bpf_map *map)
=20
 static void bpf_map__destroy(struct bpf_map *map);
=20
+static bool map_is_created(const struct bpf_map *map)
+{
+	return map->obj->loaded || map->reused;
+}
+
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map=
 *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -5231,7 +5236,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 					map->name, err);
 				return err;
 			}
-			map->inner_map_fd =3D bpf_map__fd(map->inner_map);
+			map->inner_map_fd =3D map->inner_map->fd;
 		}
 		if (map->inner_map_fd >=3D 0)
 			create_attr.inner_map_fd =3D map->inner_map_fd;
@@ -5314,7 +5319,7 @@ static int init_map_in_map_slots(struct bpf_object =
*obj, struct bpf_map *map)
 			continue;
=20
 		targ_map =3D map->init_slots[i];
-		fd =3D bpf_map__fd(targ_map);
+		fd =3D targ_map->fd;
=20
 		if (obj->gen_loader) {
 			bpf_gen__populate_outer_map(obj->gen_loader,
@@ -7135,7 +7140,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
 				if (map->libbpf_type !=3D LIBBPF_MAP_RODATA)
 					continue;
=20
-				if (bpf_prog_bind_map(ret, bpf_map__fd(map), NULL)) {
+				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
 					cp =3D libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 					pr_warn("prog '%s': failed to bind map '%s': %s\n",
 						prog->name, map->real_name, cp);
@@ -9601,7 +9606,11 @@ int libbpf_attach_type_by_name(const char *name,
=20
 int bpf_map__fd(const struct bpf_map *map)
 {
-	return map ? map->fd : libbpf_err(-EINVAL);
+	if (!map)
+		return libbpf_err(-EINVAL);
+	if (!map_is_created(map))
+		return -1;
+	return map->fd;
 }
=20
 static bool map_uses_real_name(const struct bpf_map *map)
@@ -9637,7 +9646,7 @@ enum bpf_map_type bpf_map__type(const struct bpf_ma=
p *map)
=20
 int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->def.type =3D type;
 	return 0;
@@ -9650,7 +9659,7 @@ __u32 bpf_map__map_flags(const struct bpf_map *map)
=20
 int bpf_map__set_map_flags(struct bpf_map *map, __u32 flags)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->def.map_flags =3D flags;
 	return 0;
@@ -9663,7 +9672,7 @@ __u64 bpf_map__map_extra(const struct bpf_map *map)
=20
 int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->map_extra =3D map_extra;
 	return 0;
@@ -9676,7 +9685,7 @@ __u32 bpf_map__numa_node(const struct bpf_map *map)
=20
 int bpf_map__set_numa_node(struct bpf_map *map, __u32 numa_node)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->numa_node =3D numa_node;
 	return 0;
@@ -9689,7 +9698,7 @@ __u32 bpf_map__key_size(const struct bpf_map *map)
=20
 int bpf_map__set_key_size(struct bpf_map *map, __u32 size)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->def.key_size =3D size;
 	return 0;
@@ -9773,7 +9782,7 @@ static int map_btf_datasec_resize(struct bpf_map *m=
ap, __u32 size)
=20
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
-	if (map->fd >=3D 0)
+	if (map->obj->loaded || map->reused)
 		return libbpf_err(-EBUSY);
=20
 	if (map->mmaped) {
@@ -9814,8 +9823,11 @@ __u32 bpf_map__btf_value_type_id(const struct bpf_=
map *map)
 int bpf_map__set_initial_value(struct bpf_map *map,
 			       const void *data, size_t size)
 {
+	if (map->obj->loaded || map->reused)
+		return libbpf_err(-EBUSY);
+
 	if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG ||
-	    size !=3D map->def.value_size || map->fd >=3D 0)
+	    size !=3D map->def.value_size)
 		return libbpf_err(-EINVAL);
=20
 	memcpy(map->mmaped, data, size);
@@ -9842,7 +9854,7 @@ __u32 bpf_map__ifindex(const struct bpf_map *map)
=20
 int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex)
 {
-	if (map->fd >=3D 0)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 	map->map_ifindex =3D ifindex;
 	return 0;
@@ -9947,7 +9959,7 @@ bpf_object__find_map_fd_by_name(const struct bpf_ob=
ject *obj, const char *name)
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 			   size_t value_sz, bool check_value_sz)
 {
-	if (map->fd <=3D 0)
+	if (!map_is_created(map)) /* map is not yet created */
 		return -ENOENT;
=20
 	if (map->def.key_size !=3D key_sz) {
@@ -12400,7 +12412,7 @@ int bpf_link__update_map(struct bpf_link *link, c=
onst struct bpf_map *map)
 	__u32 zero =3D 0;
 	int err;
=20
-	if (!bpf_map__is_struct_ops(map) || map->fd < 0)
+	if (!bpf_map__is_struct_ops(map) || !map_is_created(map))
 		return -EINVAL;
=20
 	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
@@ -13304,7 +13316,7 @@ int bpf_object__load_skeleton(struct bpf_object_s=
keleton *s)
 	for (i =3D 0; i < s->map_cnt; i++) {
 		struct bpf_map *map =3D *s->maps[i].map;
 		size_t mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max_e=
ntries);
-		int prot, map_fd =3D bpf_map__fd(map);
+		int prot, map_fd =3D map->fd;
 		void **mmaped =3D s->maps[i].mmaped;
=20
 		if (!mmaped)
--=20
2.34.1


