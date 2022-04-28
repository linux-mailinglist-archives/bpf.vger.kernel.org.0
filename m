Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE7512A59
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 06:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiD1ES4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 00:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiD1ESu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 00:18:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E82898F
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:34 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RLlMeF009996
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:33 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fprsx9t1t-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:33 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:30 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B70A1192F88D5; Wed, 27 Apr 2022 21:15:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] libbpf: use libbpf_mem_ensure() when allocating new map
Date:   Wed, 27 Apr 2022 21:15:21 -0700
Message-ID: <20220428041523.4089853-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428041523.4089853-1-andrii@kernel.org>
References: <20220428041523.4089853-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: p_mj4jbylmKDGb6Mv_YwE1No0L-fRdCP
X-Proofpoint-ORIG-GUID: p_mj4jbylmKDGb6Mv_YwE1No0L-fRdCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reuse libbpf_mem_ensure() when adding a new map to the list of maps
inside bpf_object. It takes care of proper resizing and reallocating of
map array and zeroing out newly allocated memory.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a85d83390d67..ee43719a0376 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1433,36 +1433,19 @@ static int find_elf_var_offset(const struct bpf_object *obj, const char *name, _
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 {
-	struct bpf_map *new_maps;
-	size_t new_cap;
-	int i;
-
-	if (obj->nr_maps < obj->maps_cap)
-		return &obj->maps[obj->nr_maps++];
-
-	new_cap = max((size_t)4, obj->maps_cap * 3 / 2);
-	new_maps = libbpf_reallocarray(obj->maps, new_cap, sizeof(*obj->maps));
-	if (!new_maps) {
-		pr_warn("alloc maps for object failed\n");
-		return ERR_PTR(-ENOMEM);
-	}
+	struct bpf_map *map;
+	int err;
 
-	obj->maps_cap = new_cap;
-	obj->maps = new_maps;
+	err = libbpf_ensure_mem((void **)&obj->maps, &obj->maps_cap,
+				sizeof(*obj->maps), obj->nr_maps + 1);
+	if (err)
+		return ERR_PTR(err);
 
-	/* zero out new maps */
-	memset(obj->maps + obj->nr_maps, 0,
-	       (obj->maps_cap - obj->nr_maps) * sizeof(*obj->maps));
-	/*
-	 * fill all fd with -1 so won't close incorrect fd (fd=0 is stdin)
-	 * when failure (zclose won't close negative fd)).
-	 */
-	for (i = obj->nr_maps; i < obj->maps_cap; i++) {
-		obj->maps[i].fd = -1;
-		obj->maps[i].inner_map_fd = -1;
-	}
+	map = &obj->maps[obj->nr_maps++];
+	map->fd = -1;
+	map->inner_map_fd = -1;
 
-	return &obj->maps[obj->nr_maps++];
+	return map;
 }
 
 static size_t bpf_map_mmap_sz(const struct bpf_map *map)
-- 
2.30.2

