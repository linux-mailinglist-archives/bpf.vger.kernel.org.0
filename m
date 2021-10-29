Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C685440598
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2WwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:52:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231530AbhJ2WwR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:52:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhcm6014057
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dD1W9FqyFcS7kRi2aSDpkcEQj4gJXMz3DhOSdVYzDFQ=;
 b=gy3IOEcl96rlErOof7CbIc0mZZRw+McRJfh+qEgpnHfLgxPp7S4BAohWjb12mJ9yH65P
 GXWuKsSuxG0STc5Q51OwxvgzPNBZZB0yRAdU5QZURhbsyC8wr0DqeUXiJkq/F5zzSYWB
 LhLLwfIFDGo3NmWdd1fxAGClZPEsCpdsKeM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0pyjhndm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:47 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:49:45 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 6E89A437304B; Fri, 29 Oct 2021 15:49:36 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>, <yhs@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Bloom filter map naming fixups
Date:   Fri, 29 Oct 2021 15:49:07 -0700
Message-ID: <20211029224909.1721024-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029224909.1721024-1-joannekoong@fb.com>
References: <20211029224909.1721024-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 1uTDs5BpdcPbsa850RqfIfpv3wpBGsgh
X-Proofpoint-GUID: 1uTDs5BpdcPbsa850RqfIfpv3wpBGsgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=757
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch has two changes in the kernel bloom filter map
implementation:

1) Change the names of map-ops functions to include the
"bloom_map" prefix.

As Martin pointed out on a previous patchset, having generic
map-ops names may be confusing in tracing and in perf-report.

2) Drop the "& 0xF" when getting nr_hash_funcs, since we
already ascertain that no other bits in map_extra beyond the
first 4 bits can be set.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 kernel/bpf/bloom_filter.c | 49 +++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 7c50232b7571..073c2f2cab8b 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -40,7 +40,7 @@ static u32 hash(struct bpf_bloom_filter *bloom, void *v=
alue,
 	return h & bloom->bitset_mask;
 }
=20
-static int peek_elem(struct bpf_map *map, void *value)
+static int bloom_map_peek_elem(struct bpf_map *map, void *value)
 {
 	struct bpf_bloom_filter *bloom =3D
 		container_of(map, struct bpf_bloom_filter, map);
@@ -55,7 +55,7 @@ static int peek_elem(struct bpf_map *map, void *value)
 	return 0;
 }
=20
-static int push_elem(struct bpf_map *map, void *value, u64 flags)
+static int bloom_map_push_elem(struct bpf_map *map, void *value, u64 fla=
gs)
 {
 	struct bpf_bloom_filter *bloom =3D
 		container_of(map, struct bpf_bloom_filter, map);
@@ -72,12 +72,12 @@ static int push_elem(struct bpf_map *map, void *value=
, u64 flags)
 	return 0;
 }
=20
-static int pop_elem(struct bpf_map *map, void *value)
+static int bloom_map_pop_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
 }
=20
-static struct bpf_map *map_alloc(union bpf_attr *attr)
+static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
@@ -90,11 +90,13 @@ static struct bpf_map *map_alloc(union bpf_attr *attr=
)
 	    attr->max_entries =3D=3D 0 ||
 	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
 	    !bpf_map_flags_access_ok(attr->map_flags) ||
+	    /* The lower 4 bits of map_extra (0xF) specify the number
+	     * of hash functions
+	     */
 	    (attr->map_extra & ~0xF))
 		return ERR_PTR(-EINVAL);
=20
-	/* The lower 4 bits of map_extra specify the number of hash functions *=
/
-	nr_hash_funcs =3D attr->map_extra & 0xF;
+	nr_hash_funcs =3D attr->map_extra;
 	if (nr_hash_funcs =3D=3D 0)
 		/* Default to using 5 hash functions if unspecified */
 		nr_hash_funcs =3D 5;
@@ -150,7 +152,7 @@ static struct bpf_map *map_alloc(union bpf_attr *attr=
)
 	return &bloom->map;
 }
=20
-static void map_free(struct bpf_map *map)
+static void bloom_map_free(struct bpf_map *map)
 {
 	struct bpf_bloom_filter *bloom =3D
 		container_of(map, struct bpf_bloom_filter, map);
@@ -158,38 +160,39 @@ static void map_free(struct bpf_map *map)
 	bpf_map_area_free(bloom);
 }
=20
-static void *lookup_elem(struct bpf_map *map, void *key)
+static void *bloom_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	/* The eBPF program should use map_peek_elem instead */
 	return ERR_PTR(-EINVAL);
 }
=20
-static int update_elem(struct bpf_map *map, void *key,
-		       void *value, u64 flags)
+static int bloom_map_update_elem(struct bpf_map *map, void *key,
+				 void *value, u64 flags)
 {
 	/* The eBPF program should use map_push_elem instead */
 	return -EINVAL;
 }
=20
-static int check_btf(const struct bpf_map *map, const struct btf *btf,
-		     const struct btf_type *key_type,
-		     const struct btf_type *value_type)
+static int bloom_map_check_btf(const struct bpf_map *map,
+			       const struct btf *btf,
+			       const struct btf_type *key_type,
+			       const struct btf_type *value_type)
 {
 	/* Bloom filter maps are keyless */
 	return btf_type_is_void(key_type) ? 0 : -EINVAL;
 }
=20
-static int bpf_bloom_btf_id;
+static int bpf_bloom_map_btf_id;
 const struct bpf_map_ops bloom_filter_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
-	.map_alloc =3D map_alloc,
-	.map_free =3D map_free,
-	.map_push_elem =3D push_elem,
-	.map_peek_elem =3D peek_elem,
-	.map_pop_elem =3D pop_elem,
-	.map_lookup_elem =3D lookup_elem,
-	.map_update_elem =3D update_elem,
-	.map_check_btf =3D check_btf,
+	.map_alloc =3D bloom_map_alloc,
+	.map_free =3D bloom_map_free,
+	.map_push_elem =3D bloom_map_push_elem,
+	.map_peek_elem =3D bloom_map_peek_elem,
+	.map_pop_elem =3D bloom_map_pop_elem,
+	.map_lookup_elem =3D bloom_map_lookup_elem,
+	.map_update_elem =3D bloom_map_update_elem,
+	.map_check_btf =3D bloom_map_check_btf,
 	.map_btf_name =3D "bpf_bloom_filter",
-	.map_btf_id =3D &bpf_bloom_btf_id,
+	.map_btf_id =3D &bpf_bloom_map_btf_id,
 };
--=20
2.30.2

