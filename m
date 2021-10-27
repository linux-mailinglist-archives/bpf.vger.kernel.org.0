Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E333043D7B2
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhJ0Xrs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 19:47:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhJ0Xrs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 19:47:48 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RLfVco030843
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:45:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VewP2ugAmHaymqCAkT4JsxFyHPwRIO25qZhAfsI36Ko=;
 b=lsWWviJdr/+IuS/Sqx5u847f18B6yj/cesZ7en/d4x3dofwmke5QaNSpgyfjXrB0v+dP
 Whbwah0UChQVC6tBux38jcNEGuWw4+k8azeK3fcY+OIbP2pwLWUPAx1QyqsgSt/bDbp0
 dsYG/5Z+FdTmVukNzgCriDngHdvoVed3COw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3by9w84f9k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:45:21 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 16:45:20 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 8C535421C738; Wed, 27 Oct 2021 16:45:18 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v6 bpf-next 2/5] libbpf: Add "map_extra" as a per-map-type extra flag
Date:   Wed, 27 Oct 2021 16:45:01 -0700
Message-ID: <20211027234504.30744-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027234504.30744-1-joannekoong@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ePFQ1KOdruco7bjy4awJibI75lvl4VXg
X-Proofpoint-ORIG-GUID: ePFQ1KOdruco7bjy4awJibI75lvl4VXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the libbpf infrastructure for supporting a
per-map-type "map_extra" field, whose definition will be
idiosyncratic depending on map type.

For example, for the bloom filter map, the lower 4 bits of
map_extra is used to denote the number of hash functions.

Please note that until libbpf 1.0 is here, the
"bpf_create_map_params" struct is used as a temporary
means for propagating the map_extra field to the kernel.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/lib/bpf/bpf.c              | 27 ++++++++++++++++++++++-
 tools/lib/bpf/bpf_gen_internal.h |  2 +-
 tools/lib/bpf/gen_loader.c       |  3 ++-
 tools/lib/bpf/libbpf.c           | 38 +++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h           |  3 +++
 tools/lib/bpf/libbpf.map         |  2 ++
 tools/lib/bpf/libbpf_internal.h  | 25 ++++++++++++++++++++-
 7 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 7d1741ceaa32..fe4b6ebc9b8f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -77,7 +77,7 @@ static inline int sys_bpf_prog_load(union bpf_attr *att=
r, unsigned int size)
 	return fd;
 }
=20
-int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
+int libbpf__bpf_create_map_xattr(const struct bpf_create_map_params *cre=
ate_attr)
 {
 	union bpf_attr attr;
 	int fd;
@@ -102,11 +102,36 @@ int bpf_create_map_xattr(const struct bpf_create_ma=
p_attr *create_attr)
 			create_attr->btf_vmlinux_value_type_id;
 	else
 		attr.inner_map_fd =3D create_attr->inner_map_fd;
+	attr.map_extra =3D create_attr->map_extra;
=20
 	fd =3D sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
 }
=20
+int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
+{
+	struct bpf_create_map_params p =3D {};
+
+	p.map_type =3D create_attr->map_type;
+	p.key_size =3D create_attr->key_size;
+	p.value_size =3D create_attr->value_size;
+	p.max_entries =3D create_attr->max_entries;
+	p.map_flags =3D create_attr->map_flags;
+	p.name =3D create_attr->name;
+	p.numa_node =3D create_attr->numa_node;
+	p.btf_fd =3D create_attr->btf_fd;
+	p.btf_key_type_id =3D create_attr->btf_key_type_id;
+	p.btf_value_type_id =3D create_attr->btf_value_type_id;
+	p.map_ifindex =3D create_attr->map_ifindex;
+	if (p.map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
+		p.btf_vmlinux_value_type_id =3D
+			create_attr->btf_vmlinux_value_type_id;
+	else
+		p.inner_map_fd =3D create_attr->inner_map_fd;
+
+	return libbpf__bpf_create_map_xattr(&p);
+}
+
 int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
 			int key_size, int value_size, int max_entries,
 			__u32 map_flags, int node)
diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_int=
ernal.h
index 70eccbffefb1..b8d41d6fbc40 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -43,7 +43,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level);
 int bpf_gen__finish(struct bpf_gen *gen);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 =
raw_size);
-void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_attr=
 *map_attr, int map_idx);
+void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_para=
ms *map_attr, int map_idx);
 struct bpf_prog_load_params;
 void bpf_gen__prog_load(struct bpf_gen *gen, struct bpf_prog_load_params=
 *load_attr, int prog_idx);
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *va=
lue, __u32 value_size);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 937bfc7db41e..e552484ae4a4 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -431,7 +431,7 @@ void bpf_gen__load_btf(struct bpf_gen *gen, const voi=
d *btf_raw_data,
 }
=20
 void bpf_gen__map_create(struct bpf_gen *gen,
-			 struct bpf_create_map_attr *map_attr, int map_idx)
+			 struct bpf_create_map_params *map_attr, int map_idx)
 {
 	int attr_size =3D offsetofend(union bpf_attr, btf_vmlinux_value_type_id=
);
 	bool close_inner_map_fd =3D false;
@@ -443,6 +443,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	attr.key_size =3D map_attr->key_size;
 	attr.value_size =3D map_attr->value_size;
 	attr.map_flags =3D map_attr->map_flags;
+	attr.map_extra =3D map_attr->map_extra;
 	memcpy(attr.map_name, map_attr->name,
 	       min((unsigned)strlen(map_attr->name), BPF_OBJ_NAME_LEN - 1));
 	attr.numa_node =3D map_attr->numa_node;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index db6e48014839..7cb017d486d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -400,6 +400,7 @@ struct bpf_map {
 	char *pin_path;
 	bool pinned;
 	bool reused;
+	__u64 map_extra;
 };
=20
 enum extern_type {
@@ -2313,6 +2314,13 @@ int parse_btf_map_def(const char *map_name, struct=
 btf *btf,
 			}
 			map_def->pinning =3D val;
 			map_def->parts |=3D MAP_DEF_PINNING;
+		} else if (strcmp(name, "map_extra") =3D=3D 0) {
+			__u32 map_extra;
+
+			if (!get_map_field_int(map_name, btf, m, &map_extra))
+				return -EINVAL;
+			map_def->map_extra =3D map_extra;
+			map_def->parts |=3D MAP_DEF_MAP_EXTRA;
 		} else {
 			if (strict) {
 				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
@@ -2337,6 +2345,7 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 	map->def.value_size =3D def->value_size;
 	map->def.max_entries =3D def->max_entries;
 	map->def.map_flags =3D def->map_flags;
+	map->map_extra =3D def->map_extra;
=20
 	map->numa_node =3D def->numa_node;
 	map->btf_key_type_id =3D def->key_type_id;
@@ -2360,7 +2369,10 @@ static void fill_map_from_def(struct bpf_map *map,=
 const struct btf_map_def *def
 	if (def->parts & MAP_DEF_MAX_ENTRIES)
 		pr_debug("map '%s': found max_entries =3D %u.\n", map->name, def->max_=
entries);
 	if (def->parts & MAP_DEF_MAP_FLAGS)
-		pr_debug("map '%s': found map_flags =3D %u.\n", map->name, def->map_fl=
ags);
+		pr_debug("map '%s': found map_flags =3D 0x%x.\n", map->name, def->map_=
flags);
+	if (def->parts & MAP_DEF_MAP_EXTRA)
+		pr_debug("map '%s': found map_extra =3D 0x%llx.\n", map->name,
+			 (unsigned long long)def->map_extra);
 	if (def->parts & MAP_DEF_PINNING)
 		pr_debug("map '%s': found pinning =3D %u.\n", map->name, def->pinning)=
;
 	if (def->parts & MAP_DEF_NUMA_NODE)
@@ -4199,6 +4211,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	map->btf_key_type_id =3D info.btf_key_type_id;
 	map->btf_value_type_id =3D info.btf_value_type_id;
 	map->reused =3D true;
+	map->map_extra =3D info.map_extra;
=20
 	return 0;
=20
@@ -4713,7 +4726,8 @@ static bool map_is_reuse_compat(const struct bpf_ma=
p *map, int map_fd)
 		map_info.key_size =3D=3D map->def.key_size &&
 		map_info.value_size =3D=3D map->def.value_size &&
 		map_info.max_entries =3D=3D map->def.max_entries &&
-		map_info.map_flags =3D=3D map->def.map_flags);
+		map_info.map_flags =3D=3D map->def.map_flags &&
+		map_info.map_extra =3D=3D map->map_extra);
 }
=20
 static int
@@ -4796,7 +4810,7 @@ static void bpf_map__destroy(struct bpf_map *map);
=20
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map=
 *map, bool is_inner)
 {
-	struct bpf_create_map_attr create_attr;
+	struct bpf_create_map_params create_attr;
 	struct bpf_map_def *def =3D &map->def;
 	int err =3D 0;
=20
@@ -4810,6 +4824,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 	create_attr.key_size =3D def->key_size;
 	create_attr.value_size =3D def->value_size;
 	create_attr.numa_node =3D map->numa_node;
+	create_attr.map_extra =3D map->map_extra;
=20
 	if (def->type =3D=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY && !def->max_entries=
) {
 		int nr_cpus;
@@ -4884,7 +4899,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 		 */
 		map->fd =3D 0;
 	} else {
-		map->fd =3D bpf_create_map_xattr(&create_attr);
+		map->fd =3D libbpf__bpf_create_map_xattr(&create_attr);
 	}
 	if (map->fd < 0 && (create_attr.btf_key_type_id ||
 			    create_attr.btf_value_type_id)) {
@@ -4899,7 +4914,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id =3D 0;
 		map->btf_key_type_id =3D 0;
 		map->btf_value_type_id =3D 0;
-		map->fd =3D bpf_create_map_xattr(&create_attr);
+		map->fd =3D libbpf__bpf_create_map_xattr(&create_attr);
 	}
=20
 	err =3D map->fd < 0 ? -errno : 0;
@@ -8853,6 +8868,19 @@ int bpf_map__set_map_flags(struct bpf_map *map, __=
u32 flags)
 	return 0;
 }
=20
+__u64 bpf_map__map_extra(const struct bpf_map *map)
+{
+	return map->map_extra;
+}
+
+int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra)
+{
+	if (map->fd >=3D 0)
+		return libbpf_err(-EBUSY);
+	map->map_extra =3D map_extra;
+	return 0;
+}
+
 __u32 bpf_map__numa_node(const struct bpf_map *map)
 {
 	return map->numa_node;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 89ca9c83ed4e..b8485db077ea 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -562,6 +562,9 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const str=
uct bpf_map *map);
 /* get/set map if_index */
 LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
+/* get/set map map_extra flags */
+LIBBPF_API __u64 bpf_map__map_extra(const struct bpf_map *map);
+LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_ext=
ra);
=20
 typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e6fb1ba49369..af550a279bf1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -389,6 +389,8 @@ LIBBPF_0.5.0 {
=20
 LIBBPF_0.6.0 {
 	global:
+		bpf_map__map_extra;
+		bpf_map__set_map_extra;
 		bpf_object__next_map;
 		bpf_object__next_program;
 		bpf_object__prev_map;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 13bc7950e304..a6dd7e25747f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -193,8 +193,9 @@ enum map_def_parts {
 	MAP_DEF_NUMA_NODE	=3D 0x080,
 	MAP_DEF_PINNING		=3D 0x100,
 	MAP_DEF_INNER_MAP	=3D 0x200,
+	MAP_DEF_MAP_EXTRA	=3D 0x400,
=20
-	MAP_DEF_ALL		=3D 0x3ff, /* combination of all above */
+	MAP_DEF_ALL		=3D 0x7ff, /* combination of all above */
 };
=20
 struct btf_map_def {
@@ -208,6 +209,7 @@ struct btf_map_def {
 	__u32 map_flags;
 	__u32 numa_node;
 	__u32 pinning;
+	__u64 map_extra;
 };
=20
 int parse_btf_map_def(const char *map_name, struct btf *btf,
@@ -303,6 +305,27 @@ struct bpf_prog_load_params {
=20
 int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr);
=20
+struct bpf_create_map_params {
+	const char *name;
+	enum bpf_map_type map_type;
+	__u32 map_flags;
+	__u32 key_size;
+	__u32 value_size;
+	__u32 max_entries;
+	__u32 numa_node;
+	__u32 btf_fd;
+	__u32 btf_key_type_id;
+	__u32 btf_value_type_id;
+	__u32 map_ifindex;
+	union {
+		__u32 inner_map_fd;
+		__u32 btf_vmlinux_value_type_id;
+	};
+	__u64 map_extra;
+};
+
+int libbpf__bpf_create_map_xattr(const struct bpf_create_map_params *cre=
ate_attr);
+
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 				const char **prefix, int *kind);
--=20
2.30.2

