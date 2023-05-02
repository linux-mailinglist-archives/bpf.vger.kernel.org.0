Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABE6F4D6A
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEBXJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEBXJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283FC3
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:12 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JWxVN013777
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qb7m19y21-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:12 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4EBCE2FD4BC9D; Tue,  2 May 2023 16:06:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 02/10] bpf: inline map creation logic in map_create() function
Date:   Tue, 2 May 2023 16:06:11 -0700
Message-ID: <20230502230619.2592406-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FIQ7Q1uEx-F4mzCxZigne9NiNh24PW61
X-Proofpoint-ORIG-GUID: FIQ7Q1uEx-F4mzCxZigne9NiNh24PW61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
 kernel/bpf/syscall.c | 54 ++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d5009fafe0f4..3ab6c0dc241a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -109,37 +109,6 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_mem_usage = bpf_map_offload_map_mem_usage,
 };
 
-static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
-{
-	const struct bpf_map_ops *ops;
-	u32 type = attr->map_type;
-	struct bpf_map *map;
-	int err;
-
-	if (type >= ARRAY_SIZE(bpf_map_types))
-		return ERR_PTR(-EINVAL);
-	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
-	ops = bpf_map_types[type];
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
-	if (ops->map_alloc_check) {
-		err = ops->map_alloc_check(attr);
-		if (err)
-			return ERR_PTR(err);
-	}
-	if (attr->map_ifindex)
-		ops = &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
-		return ERR_PTR(-EINVAL);
-	map = ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return map;
-	map->ops = ops;
-	map->map_type = type;
-	return map;
-}
-
 static void bpf_map_write_active_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->writecnt);
@@ -1127,7 +1096,9 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
+	const struct bpf_map_ops *ops;
 	int numa_node = bpf_map_attr_numa_node(attr);
+	u32 map_type = attr->map_type;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1169,9 +1140,28 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
-	map = find_and_alloc_map(attr);
+	map_type = attr->map_type;
+	if (map_type >= ARRAY_SIZE(bpf_map_types))
+		return -EINVAL;
+	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
+	ops = bpf_map_types[map_type];
+	if (!ops)
+		return -EINVAL;
+
+	if (ops->map_alloc_check) {
+		err = ops->map_alloc_check(attr);
+		if (err)
+			return err;
+	}
+	if (attr->map_ifindex)
+		ops = &bpf_map_offload_ops;
+	if (!ops->map_mem_usage)
+		return -EINVAL;
+	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
+	map->ops = ops;
+	map->map_type = map_type;
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-- 
2.34.1

