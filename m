Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB93FCFB3
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHaWva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 18:51:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18354 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240993AbhHaWva (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 18:51:30 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VMiZBm018602
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nMSV6xqe6sFUGXnI7CQMCJaerezXi2CyPcg+SS6JC2s=;
 b=HwlczGvU99RMMqnaP4gY6dYbLQahTK4icazDMdN1t/vrv9jwmf41EpjjmDIfdn6B13B5
 +d8QAXHs2XF/xNKBLQ4nKf0b+igHlyyTFwMtotOU0U5GJLnM0Wq97sXBlIvHMl3HkSUM
 qGT1yo7iOwnYJL4IwedL7zgoKLWlZtROcc0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3asscrt39g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:34 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 15:50:33 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 6F74B1C88BCD; Tue, 31 Aug 2021 15:50:25 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 2/5] libbpf: Allow the number of hashes in bloom filter maps to be configurable
Date:   Tue, 31 Aug 2021 15:50:02 -0700
Message-ID: <20210831225005.2762202-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831225005.2762202-1-joannekoong@fb.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xH5ZKM4mlO7gZh_ccCs9yfcbpwvhDRfs
X-Proofpoint-ORIG-GUID: xH5ZKM4mlO7gZh_ccCs9yfcbpwvhDRfs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the libbpf infrastructure that will allow the user to
specify the number of hash functions to use for the bloom filter map.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/lib/bpf/bpf.c             |  2 ++
 tools/lib/bpf/bpf.h             |  1 +
 tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h          |  3 +++
 tools/lib/bpf/libbpf.map        |  2 ++
 tools/lib/bpf/libbpf_internal.h |  4 +++-
 6 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2401fad090c5..cc928c5b92a4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -100,6 +100,8 @@ int bpf_create_map_xattr(const struct bpf_create_map_=
attr *create_attr)
 	if (attr.map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
 		attr.btf_vmlinux_value_type_id =3D
 			create_attr->btf_vmlinux_value_type_id;
+	else if (attr.map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER)
+		attr.nr_hashes =3D create_attr->nr_hashes;
 	else
 		attr.inner_map_fd =3D create_attr->inner_map_fd;
=20
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6fffb3cdf39b..ea29d6647e20 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -49,6 +49,7 @@ struct bpf_create_map_attr {
 	union {
 		__u32 inner_map_fd;
 		__u32 btf_vmlinux_value_type_id;
+		__u32 nr_hashes; /* used for bloom filter maps */
 	};
 };
=20
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..ac03404aeb57 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -377,6 +377,7 @@ struct bpf_map {
 	char *pin_path;
 	bool pinned;
 	bool reused;
+	__u32 nr_hashes; /* used for bloom filter maps */
 };
=20
 enum extern_type {
@@ -1290,6 +1291,11 @@ static bool bpf_map_type__is_map_in_map(enum bpf_m=
ap_type type)
 	return false;
 }
=20
+static bool bpf_map_type__is_bloom_filter(enum bpf_map_type type)
+{
+	return type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER;
+}
+
 int bpf_object__section_size(const struct bpf_object *obj, const char *n=
ame,
 			     __u32 *size)
 {
@@ -2080,6 +2086,10 @@ int parse_btf_map_def(const char *map_name, struct=
 btf *btf,
 			if (!get_map_field_int(map_name, btf, m, &map_def->map_flags))
 				return -EINVAL;
 			map_def->parts |=3D MAP_DEF_MAP_FLAGS;
+		} else if (strcmp(name, "nr_hashes") =3D=3D 0) {
+			if (!get_map_field_int(map_name, btf, m, &map_def->nr_hashes))
+				return -EINVAL;
+			map_def->parts |=3D MAP_DEF_NR_HASHES;
 		} else if (strcmp(name, "numa_node") =3D=3D 0) {
 			if (!get_map_field_int(map_name, btf, m, &map_def->numa_node))
 				return -EINVAL;
@@ -2264,6 +2274,7 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 	map->numa_node =3D def->numa_node;
 	map->btf_key_type_id =3D def->key_type_id;
 	map->btf_value_type_id =3D def->value_type_id;
+	map->nr_hashes =3D def->nr_hashes;
=20
 	if (def->parts & MAP_DEF_MAP_TYPE)
 		pr_debug("map '%s': found type =3D %u.\n", map->name, def->map_type);
@@ -2288,6 +2299,8 @@ static void fill_map_from_def(struct bpf_map *map, =
const struct btf_map_def *def
 		pr_debug("map '%s': found pinning =3D %u.\n", map->name, def->pinning)=
;
 	if (def->parts & MAP_DEF_NUMA_NODE)
 		pr_debug("map '%s': found numa_node =3D %u.\n", map->name, def->numa_n=
ode);
+	if (def->parts & MAP_DEF_NR_HASHES)
+		pr_debug("map '%s': found nr_hashes =3D %u.\n", map->name, def->nr_has=
hes);
=20
 	if (def->parts & MAP_DEF_INNER_MAP)
 		pr_debug("map '%s': found inner map definition.\n", map->name);
@@ -3979,6 +3992,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	map->btf_key_type_id =3D info.btf_key_type_id;
 	map->btf_value_type_id =3D info.btf_value_type_id;
 	map->reused =3D true;
+	map->nr_hashes =3D info.nr_hashes;
=20
 	return 0;
=20
@@ -4473,7 +4487,8 @@ static bool map_is_reuse_compat(const struct bpf_ma=
p *map, int map_fd)
 		map_info.key_size =3D=3D map->def.key_size &&
 		map_info.value_size =3D=3D map->def.value_size &&
 		map_info.max_entries =3D=3D map->def.max_entries &&
-		map_info.map_flags =3D=3D map->def.map_flags);
+		map_info.map_flags =3D=3D map->def.map_flags &&
+		map_info.nr_hashes =3D=3D map->nr_hashes);
 }
=20
 static int
@@ -4611,6 +4626,8 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 		}
 		if (map->inner_map_fd >=3D 0)
 			create_attr.inner_map_fd =3D map->inner_map_fd;
+	} else if (bpf_map_type__is_bloom_filter(def->type)) {
+		create_attr.nr_hashes =3D map->nr_hashes;
 	}
=20
 	if (obj->gen_loader) {
@@ -8560,6 +8577,19 @@ int bpf_map__set_numa_node(struct bpf_map *map, __=
u32 numa_node)
 	return 0;
 }
=20
+__u32 bpf_map__nr_hashes(const struct bpf_map *map)
+{
+	return map->nr_hashes;
+}
+
+int bpf_map__set_nr_hashes(struct bpf_map *map, __u32 nr_hashes)
+{
+	if (map->fd >=3D 0)
+		return libbpf_err(-EBUSY);
+	map->nr_hashes =3D nr_hashes;
+	return 0;
+}
+
 __u32 bpf_map__key_size(const struct bpf_map *map)
 {
 	return map->def.key_size;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f177d897c5f7..497b84772be8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -538,6 +538,9 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const str=
uct bpf_map *map);
 /* get/set map if_index */
 LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
+/* get/set nr_hashes. used for bloom filter maps */
+LIBBPF_API __u32 bpf_map__nr_hashes(const struct bpf_map *map);
+LIBBPF_API int bpf_map__set_nr_hashes(struct bpf_map *map, __u32 nr_hash=
es);
=20
 typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index bbc53bb25f68..372c2478274f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -385,4 +385,6 @@ LIBBPF_0.5.0 {
 		btf__load_vmlinux_btf;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
+		bpf_map__nr_hashes;
+		bpf_map__set_nr_hashes;
 } LIBBPF_0.4.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 533b0211f40a..501ae042980d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -171,8 +171,9 @@ enum map_def_parts {
 	MAP_DEF_NUMA_NODE	=3D 0x080,
 	MAP_DEF_PINNING		=3D 0x100,
 	MAP_DEF_INNER_MAP	=3D 0x200,
+	MAP_DEF_NR_HASHES	=3D 0x400,
=20
-	MAP_DEF_ALL		=3D 0x3ff, /* combination of all above */
+	MAP_DEF_ALL		=3D 0x7ff, /* combination of all above */
 };
=20
 struct btf_map_def {
@@ -186,6 +187,7 @@ struct btf_map_def {
 	__u32 map_flags;
 	__u32 numa_node;
 	__u32 pinning;
+	__u32 nr_hashes; /* used for bloom filter maps */
 };
=20
 int parse_btf_map_def(const char *map_name, struct btf *btf,
--=20
2.30.2

