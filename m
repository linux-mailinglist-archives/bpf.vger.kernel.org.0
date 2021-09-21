Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB47B413BF4
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhIUVGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:06:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232718AbhIUVGf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:06:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LHAuef009458
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cRrjDAfVQasB8VZWTfA0fXLxj2ftoQtSP0ny/Dz1LfE=;
 b=mxvVOEjxBRaxuz3i7rsoz6tVjYpqmrY6ysjZIjdj4ur7qm7pB4FtD6RF3C7VyAa/JDe5
 daTLdFSW1guv5NVivPWwW0WIZlUUdEOt5zo2AV0AMFtEG51IRGKyjXf94B3P6RHlsRsz
 JEXUaOc9p/pDNf39wggM3HSTHLcqsrbCTgo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7d744kc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:06 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:05:05 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 6556C2AC13AF; Tue, 21 Sep 2021 14:05:01 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v3 bpf-next 2/5] libbpf: Allow the number of hashes in bloom filter maps to be configurable
Date:   Tue, 21 Sep 2021 14:02:22 -0700
Message-ID: <20210921210225.4095056-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921210225.4095056-1-joannekoong@fb.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ky-0mTr-Jl9_DJy07ZWpR4hBHwSSLp41
X-Proofpoint-GUID: ky-0mTr-Jl9_DJy07ZWpR4hBHwSSLp41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the libbpf infrastructure that will allow the user to
specify a configurable number of hash functions to use for the bloom
filter map.

Please note that this patch does not enforce that a pinned bloom filter
map may only be reused if the number of hash functions is the same. If
they are not the same, the number of hash functions used will be the one
that was set for the pinned map.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/uapi/linux/bpf.h        |  5 ++++-
 tools/include/uapi/linux/bpf.h  |  5 ++++-
 tools/lib/bpf/bpf.c             |  2 ++
 tools/lib/bpf/bpf.h             |  1 +
 tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h          |  2 ++
 tools/lib/bpf/libbpf.map        |  1 +
 tools/lib/bpf/libbpf_internal.h |  4 +++-
 8 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fec9fcfe0629..2e3048488feb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1262,7 +1262,10 @@ union bpf_attr {
 		__u32	map_flags;	/* BPF_MAP_CREATE related
 					 * flags defined above.
 					 */
-		__u32	inner_map_fd;	/* fd pointing to the inner map */
+		union {
+			__u32	inner_map_fd;	/* fd pointing to the inner map */
+			__u32	nr_hash_funcs;  /* or number of hash functions */
+		};
 		__u32	numa_node;	/* numa node (effective only if
 					 * BPF_F_NUMA_NODE is set).
 					 */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index fec9fcfe0629..2e3048488feb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1262,7 +1262,10 @@ union bpf_attr {
 		__u32	map_flags;	/* BPF_MAP_CREATE related
 					 * flags defined above.
 					 */
-		__u32	inner_map_fd;	/* fd pointing to the inner map */
+		union {
+			__u32	inner_map_fd;	/* fd pointing to the inner map */
+			__u32	nr_hash_funcs;  /* or number of hash functions */
+		};
 		__u32	numa_node;	/* numa node (effective only if
 					 * BPF_F_NUMA_NODE is set).
 					 */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2401fad090c5..8a9dd4f6d6c8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -100,6 +100,8 @@ int bpf_create_map_xattr(const struct bpf_create_map_=
attr *create_attr)
 	if (attr.map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
 		attr.btf_vmlinux_value_type_id =3D
 			create_attr->btf_vmlinux_value_type_id;
+	else if (attr.map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER)
+		attr.nr_hash_funcs =3D create_attr->nr_hash_funcs;
 	else
 		attr.inner_map_fd =3D create_attr->inner_map_fd;
=20
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6fffb3cdf39b..1194b6f01572 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -49,6 +49,7 @@ struct bpf_create_map_attr {
 	union {
 		__u32 inner_map_fd;
 		__u32 btf_vmlinux_value_type_id;
+		__u32 nr_hash_funcs;
 	};
 };
=20
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index da65a1666a5e..e51e68a07aaf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -378,6 +378,7 @@ struct bpf_map {
 	char *pin_path;
 	bool pinned;
 	bool reused;
+	__u32 nr_hash_funcs;
 };
=20
 enum extern_type {
@@ -1291,6 +1292,11 @@ static bool bpf_map_type__is_map_in_map(enum bpf_m=
ap_type type)
 	return false;
 }
=20
+static inline bool bpf_map__is_bloom_filter(const struct bpf_map *map)
+{
+	return map->def.type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER;
+}
+
 int bpf_object__section_size(const struct bpf_object *obj, const char *n=
ame,
 			     __u32 *size)
 {
@@ -2238,6 +2244,10 @@ int parse_btf_map_def(const char *map_name, struct=
 btf *btf,
 			}
 			map_def->pinning =3D val;
 			map_def->parts |=3D MAP_DEF_PINNING;
+		} else if (strcmp(name, "nr_hash_funcs") =3D=3D 0) {
+			if (!get_map_field_int(map_name, btf, m, &map_def->nr_hash_funcs))
+				return -EINVAL;
+			map_def->parts |=3D MAP_DEF_NR_HASH_FUNCS;
 		} else {
 			if (strict) {
 				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
@@ -2266,6 +2276,7 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 	map->numa_node =3D def->numa_node;
 	map->btf_key_type_id =3D def->key_type_id;
 	map->btf_value_type_id =3D def->value_type_id;
+	map->nr_hash_funcs =3D def->nr_hash_funcs;
=20
 	if (def->parts & MAP_DEF_MAP_TYPE)
 		pr_debug("map '%s': found type =3D %u.\n", map->name, def->map_type);
@@ -2290,6 +2301,8 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 		pr_debug("map '%s': found pinning =3D %u.\n", map->name, def->pinning)=
;
 	if (def->parts & MAP_DEF_NUMA_NODE)
 		pr_debug("map '%s': found numa_node =3D %u.\n", map->name, def->numa_n=
ode);
+	if (def->parts & MAP_DEF_NR_HASH_FUNCS)
+		pr_debug("map '%s': found nr_hash_funcs =3D %u.\n", map->name, def->nr=
_hash_funcs);
=20
 	if (def->parts & MAP_DEF_INNER_MAP)
 		pr_debug("map '%s': found inner map definition.\n", map->name);
@@ -4616,10 +4629,6 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
 		create_attr.max_entries =3D def->max_entries;
 	}
=20
-	if (bpf_map__is_struct_ops(map))
-		create_attr.btf_vmlinux_value_type_id =3D
-			map->btf_vmlinux_value_type_id;
-
 	create_attr.btf_fd =3D 0;
 	create_attr.btf_key_type_id =3D 0;
 	create_attr.btf_value_type_id =3D 0;
@@ -4629,7 +4638,12 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id =3D map->btf_value_type_id;
 	}
=20
-	if (bpf_map_type__is_map_in_map(def->type)) {
+	if (bpf_map__is_struct_ops(map)) {
+		create_attr.btf_vmlinux_value_type_id =3D
+			map->btf_vmlinux_value_type_id;
+	} else if (bpf_map__is_bloom_filter(map)) {
+		create_attr.nr_hash_funcs =3D map->nr_hash_funcs;
+	} else if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
 			err =3D bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
@@ -8610,6 +8624,14 @@ int bpf_map__set_value_size(struct bpf_map *map, _=
_u32 size)
 	return 0;
 }
=20
+int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_hash_funcs)
+{
+	if (map->fd >=3D 0)
+		return libbpf_err(-EBUSY);
+	map->nr_hash_funcs =3D nr_hash_funcs;
+	return 0;
+}
+
 __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
 {
 	return map ? map->btf_key_type_id : 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d0bedd673273..5c441744f766 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -550,6 +550,8 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const str=
uct bpf_map *map);
 /* get/set map if_index */
 LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
+/* set nr_hash_funcs */
+LIBBPF_API int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_=
hash_funcs);
=20
 typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9e649cf9e771..ee0e1e7648f4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -385,6 +385,7 @@ LIBBPF_0.5.0 {
 		btf__load_vmlinux_btf;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
+		bpf_map__set_nr_hash_funcs;
 } LIBBPF_0.4.0;
=20
 LIBBPF_0.6.0 {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index ceb0c98979bc..95dbbeba231f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -186,8 +186,9 @@ enum map_def_parts {
 	MAP_DEF_NUMA_NODE	=3D 0x080,
 	MAP_DEF_PINNING		=3D 0x100,
 	MAP_DEF_INNER_MAP	=3D 0x200,
+	MAP_DEF_NR_HASH_FUNCS	=3D 0x400,
=20
-	MAP_DEF_ALL		=3D 0x3ff, /* combination of all above */
+	MAP_DEF_ALL		=3D 0x7ff, /* combination of all above */
 };
=20
 struct btf_map_def {
@@ -201,6 +202,7 @@ struct btf_map_def {
 	__u32 map_flags;
 	__u32 numa_node;
 	__u32 pinning;
+	__u32 nr_hash_funcs;
 };
=20
 int parse_btf_map_def(const char *map_name, struct btf *btf,
--=20
2.30.2

