Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FF424989
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhJFWXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:23:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230236AbhJFWXY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:23:24 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 196M3cmV027614
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:21:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tpvrmC9X0utdZCbHTTYba8Xu1YZ66mzNHmJWWZpyfak=;
 b=JfjWvooHVbDpRSdoUt/BkSPg9vrNm+eVs37HDo/nNY1F2R+vDltcxgLQN+Q0zTIkwN5D
 DYhQvD0OrjWq+ZRhU+ZRm4E7sB0U2Bevxq6T/hR0QKd1AOsSHD14o9r98cLfo2EPO97v
 3ylaWU8FaJuZqtck8Cxyad4SFwbPLMHf0bw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3bhfn52fa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:21:31 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:21:30 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id B3230345188F; Wed,  6 Oct 2021 15:21:29 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next v4 2/5] libbpf: Add "map_extra" as a per-map-type extra flag
Date:   Wed, 6 Oct 2021 15:21:00 -0700
Message-ID: <20211006222103.3631981-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006222103.3631981-1-joannekoong@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: zbXo7tx_ot9QlfdsnPnFXsQjI2lOHLC_
X-Proofpoint-ORIG-GUID: zbXo7tx_ot9QlfdsnPnFXsQjI2lOHLC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110060139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the libbpf infrastructure for supporting a
per-map-type "map_extra" field, whose definition will be
idiosyncratic depending on map type.

For example, for the bitset map, the lower 4 bits of map_extra
is used to denote the number of hash functions.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/uapi/linux/bpf.h        |  1 +
 tools/include/uapi/linux/bpf.h  |  1 +
 tools/lib/bpf/bpf.c             |  1 +
 tools/lib/bpf/bpf.h             |  1 +
 tools/lib/bpf/bpf_helpers.h     |  1 +
 tools/lib/bpf/libbpf.c          | 25 ++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h          |  4 ++++
 tools/lib/bpf/libbpf.map        |  2 ++
 tools/lib/bpf/libbpf_internal.h |  4 +++-
 9 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b40fa1a72a75..a6f225e9c95a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5639,6 +5639,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 map_extra;
 } __attribute__((aligned(8)));
=20
 struct bpf_btf_info {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index b40fa1a72a75..a6f225e9c95a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5639,6 +5639,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 map_extra;
 } __attribute__((aligned(8)));
=20
 struct bpf_btf_info {
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 7d1741ceaa32..41e3e85e7789 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -97,6 +97,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_at=
tr *create_attr)
 	attr.btf_key_type_id =3D create_attr->btf_key_type_id;
 	attr.btf_value_type_id =3D create_attr->btf_value_type_id;
 	attr.map_ifindex =3D create_attr->map_ifindex;
+	attr.map_extra =3D create_attr->map_extra;
 	if (attr.map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
 		attr.btf_vmlinux_value_type_id =3D
 			create_attr->btf_vmlinux_value_type_id;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6fffb3cdf39b..c4049f2d63cc 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -50,6 +50,7 @@ struct bpf_create_map_attr {
 		__u32 inner_map_fd;
 		__u32 btf_vmlinux_value_type_id;
 	};
+	__u32 map_extra;
 };
=20
 LIBBPF_API int
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 963b1060d944..bce5a0090f3f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -133,6 +133,7 @@ struct bpf_map_def {
 	unsigned int value_size;
 	unsigned int max_entries;
 	unsigned int map_flags;
+	unsigned int map_extra;
 };
=20
 enum libbpf_pin_type {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ed313fd491bd..12a9ecd45a78 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2274,6 +2274,10 @@ int parse_btf_map_def(const char *map_name, struct=
 btf *btf,
 			}
 			map_def->pinning =3D val;
 			map_def->parts |=3D MAP_DEF_PINNING;
+		} else if (strcmp(name, "map_extra") =3D=3D 0) {
+			if (!get_map_field_int(map_name, btf, m, &map_def->map_extra))
+				return -EINVAL;
+			map_def->parts |=3D MAP_DEF_MAP_EXTRA;
 		} else {
 			if (strict) {
 				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
@@ -2298,6 +2302,7 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 	map->def.value_size =3D def->value_size;
 	map->def.max_entries =3D def->max_entries;
 	map->def.map_flags =3D def->map_flags;
+	map->def.map_extra =3D def->map_extra;
=20
 	map->numa_node =3D def->numa_node;
 	map->btf_key_type_id =3D def->key_type_id;
@@ -2322,6 +2327,8 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 		pr_debug("map '%s': found max_entries =3D %u.\n", map->name, def->max_=
entries);
 	if (def->parts & MAP_DEF_MAP_FLAGS)
 		pr_debug("map '%s': found map_flags =3D %u.\n", map->name, def->map_fl=
ags);
+	if (def->parts & MAP_DEF_MAP_EXTRA)
+		pr_debug("map '%s': found map_extra =3D %u.\n", map->name, def->map_ex=
tra);
 	if (def->parts & MAP_DEF_PINNING)
 		pr_debug("map '%s': found pinning =3D %u.\n", map->name, def->pinning)=
;
 	if (def->parts & MAP_DEF_NUMA_NODE)
@@ -4017,6 +4024,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	map->def.value_size =3D info.value_size;
 	map->def.max_entries =3D info.max_entries;
 	map->def.map_flags =3D info.map_flags;
+	map->def.map_extra =3D info.map_extra;
 	map->btf_key_type_id =3D info.btf_key_type_id;
 	map->btf_value_type_id =3D info.btf_value_type_id;
 	map->reused =3D true;
@@ -4534,7 +4542,8 @@ static bool map_is_reuse_compat(const struct bpf_ma=
p *map, int map_fd)
 		map_info.key_size =3D=3D map->def.key_size &&
 		map_info.value_size =3D=3D map->def.value_size &&
 		map_info.max_entries =3D=3D map->def.max_entries &&
-		map_info.map_flags =3D=3D map->def.map_flags);
+		map_info.map_flags =3D=3D map->def.map_flags &&
+		map_info.map_extra =3D=3D map->def.map_extra);
 }
=20
 static int
@@ -4631,6 +4640,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 	create_attr.key_size =3D def->key_size;
 	create_attr.value_size =3D def->value_size;
 	create_attr.numa_node =3D map->numa_node;
+	create_attr.map_extra =3D def->map_extra;
=20
 	if (def->type =3D=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY && !def->max_entries=
) {
 		int nr_cpus;
@@ -8637,6 +8647,19 @@ int bpf_map__set_map_flags(struct bpf_map *map, __=
u32 flags)
 	return 0;
 }
=20
+__u32 bpf_map__map_extra(const struct bpf_map *map)
+{
+	return map->def.map_extra;
+}
+
+int bpf_map__set_map_extra(struct bpf_map *map, __u32 map_extra)
+{
+	if (map->fd >=3D 0)
+		return libbpf_err(-EBUSY);
+	map->def.map_extra =3D map_extra;
+	return 0;
+}
+
 __u32 bpf_map__numa_node(const struct bpf_map *map)
 {
 	return map->numa_node;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 89ca9c83ed4e..55e8dfe6f3e1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -486,6 +486,7 @@ struct bpf_map_def {
 	unsigned int value_size;
 	unsigned int max_entries;
 	unsigned int map_flags;
+	unsigned int map_extra;
 };
=20
 /**
@@ -562,6 +563,9 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const str=
uct bpf_map *map);
 /* get/set map if_index */
 LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
+/* get/set map map_extra flags */
+LIBBPF_API __u32 bpf_map__map_extra(const struct bpf_map *map);
+LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u32 map_ext=
ra);
=20
 typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f270d25e4af3..308378b3f20b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,6 @@ LIBBPF_0.6.0 {
 		bpf_object__prev_program;
 		btf__add_btf;
 		btf__add_tag;
+		bpf_map__map_extra;
+		bpf_map__set_map_extra;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index f7fd3944d46d..188db854d9c2 100644
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
+	__u32 map_extra;
 };
=20
 int parse_btf_map_def(const char *map_name, struct btf *btf,
--=20
2.30.2

