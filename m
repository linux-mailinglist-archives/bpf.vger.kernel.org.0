Return-Path: <bpf+bounces-2059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43172727375
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944441C20F43
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8CC1DCB4;
	Wed,  7 Jun 2023 23:54:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E983B419
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:21 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A932682
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:19 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357H82Cp004332
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2n4cxjqj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:18 -0700
Received: from twshared16556.03.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AE69E32857D8A; Wed,  7 Jun 2023 16:54:04 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 05/18] bpf: inline map creation logic in map_create() function
Date: Wed, 7 Jun 2023 16:53:39 -0700
Message-ID: <20230607235352.1723243-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0OUcjdyYEU16RiS2Mfn_qhYNlivG1WMT
X-Proofpoint-ORIG-GUID: 0OUcjdyYEU16RiS2Mfn_qhYNlivG1WMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently find_and_alloc_map() performs two separate functions: some
argument sanity checking and partial map creation workflow hanling.
Neither of those functions are self-sufficient and are augmented by
further checks and initialization logic in the caller (map_create()
function). So unify all the sanity checks, permission checks, and
creation and initialization logic in one linear piece of code in
map_create() instead. This also make it easier to further enhance
permission checks and keep them located in one place.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 57 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b7737405e1dd..20b373dce669 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -109,37 +109,6 @@ const struct bpf_map_ops bpf_map_offload_ops =3D {
 	.map_mem_usage =3D bpf_map_offload_map_mem_usage,
 };
=20
-static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
-{
-	const struct bpf_map_ops *ops;
-	u32 type =3D attr->map_type;
-	struct bpf_map *map;
-	int err;
-
-	if (type >=3D ARRAY_SIZE(bpf_map_types))
-		return ERR_PTR(-EINVAL);
-	type =3D array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
-	ops =3D bpf_map_types[type];
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
-	if (ops->map_alloc_check) {
-		err =3D ops->map_alloc_check(attr);
-		if (err)
-			return ERR_PTR(err);
-	}
-	if (attr->map_ifindex)
-		ops =3D &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
-		return ERR_PTR(-EINVAL);
-	map =3D ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return map;
-	map->ops =3D ops;
-	map->map_type =3D type;
-	return map;
-}
-
 static void bpf_map_write_active_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->writecnt);
@@ -1127,7 +1096,9 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
+	const struct bpf_map_ops *ops;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
+	u32 map_type =3D attr->map_type;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1157,6 +1128,25 @@ static int map_create(union bpf_attr *attr)
 	     !node_online(numa_node)))
 		return -EINVAL;
=20
+	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
+	map_type =3D attr->map_type;
+	if (map_type >=3D ARRAY_SIZE(bpf_map_types))
+		return -EINVAL;
+	map_type =3D array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
+	ops =3D bpf_map_types[map_type];
+	if (!ops)
+		return -EINVAL;
+
+	if (ops->map_alloc_check) {
+		err =3D ops->map_alloc_check(attr);
+		if (err)
+			return err;
+	}
+	if (attr->map_ifindex)
+		ops =3D &bpf_map_offload_ops;
+	if (!ops->map_mem_usage)
+		return -EINVAL;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
@@ -1166,10 +1156,11 @@ static int map_create(union bpf_attr *attr)
 	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
 		return -EPERM;
=20
-	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
-	map =3D find_and_alloc_map(attr);
+	map =3D ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
+	map->ops =3D ops;
+	map->map_type =3D map_type;
=20
 	err =3D bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
--=20
2.34.1


