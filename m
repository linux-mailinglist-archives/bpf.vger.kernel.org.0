Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F88576762
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiGOT2r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiGOT2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 15:28:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3700C656A
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 12:28:41 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGGvLm013198
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 12:28:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hb892tkrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 12:28:40 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 12:28:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0409C1C63AFF2; Fri, 15 Jul 2022 12:28:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: make RINGBUF map size adjustments more eagerly
Date:   Fri, 15 Jul 2022 12:24:55 -0700
Message-ID: <20220715192456.1151015-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JqFjldU6AvX3vsUk-2qwaqUR8tiIEL7f
X-Proofpoint-GUID: JqFjldU6AvX3vsUk-2qwaqUR8tiIEL7f
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_10,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf adjust RINGBUF map size (rounding it up to closest power-of-2
of page_size) more eagerly: during open phase when initializing the map
and on explicit calls to bpf_map__set_max_entries().

Such approach allows user to check actual size of BPF ringbuf even
before it's created in the kernel, but also it prevents various edge
case scenarios where BPF ringbuf size can get out of sync with what it
would be in kernel. One of them (reported in [0]) is during an attempt
to pin/reuse BPF ringbuf.

Move adjust_ringbuf_sz() helper closer to its first actual use. The
implementation of the helper is unchanged.

  [0] Closes: https://github.com/libbpf/libbpf/issue/530

Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 77 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68da1aca406c..2767d1897b4f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2320,6 +2320,37 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 	return 0;
 }
 
+static size_t adjust_ringbuf_sz(size_t sz)
+{
+	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
+	__u32 mul;
+
+	/* if user forgot to set any size, make sure they see error */
+	if (sz == 0)
+		return 0;
+	/* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
+	 * a power-of-2 multiple of kernel's page size. If user diligently
+	 * satisified these conditions, pass the size through.
+	 */
+	if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
+		return sz;
+
+	/* Otherwise find closest (page_sz * power_of_2) product bigger than
+	 * user-set size to satisfy both user size request and kernel
+	 * requirements and substitute correct max_entries for map creation.
+	 */
+	for (mul = 1; mul <= UINT_MAX / page_sz; mul <<= 1) {
+		if (mul * page_sz > sz)
+			return mul * page_sz;
+	}
+
+	/* if it's impossible to satisfy the conditions (i.e., user size is
+	 * very close to UINT_MAX but is not a power-of-2 multiple of
+	 * page_size) then just return original size and let kernel reject it
+	 */
+	return sz;
+}
+
 static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
 {
 	map->def.type = def->map_type;
@@ -2333,6 +2364,10 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
 	map->btf_key_type_id = def->key_type_id;
 	map->btf_value_type_id = def->value_type_id;
 
+	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
+	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
+
 	if (def->parts & MAP_DEF_MAP_TYPE)
 		pr_debug("map '%s': found type = %u.\n", map->name, def->map_type);
 
@@ -4306,9 +4341,15 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
 
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
-	if (map->fd >= 0)
+	if (map->obj->loaded)
 		return libbpf_err(-EBUSY);
+
 	map->def.max_entries = max_entries;
+
+	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
+	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
+
 	return 0;
 }
 
@@ -4859,37 +4900,6 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
-static size_t adjust_ringbuf_sz(size_t sz)
-{
-	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
-	__u32 mul;
-
-	/* if user forgot to set any size, make sure they see error */
-	if (sz == 0)
-		return 0;
-	/* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
-	 * a power-of-2 multiple of kernel's page size. If user diligently
-	 * satisified these conditions, pass the size through.
-	 */
-	if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
-		return sz;
-
-	/* Otherwise find closest (page_sz * power_of_2) product bigger than
-	 * user-set size to satisfy both user size request and kernel
-	 * requirements and substitute correct max_entries for map creation.
-	 */
-	for (mul = 1; mul <= UINT_MAX / page_sz; mul <<= 1) {
-		if (mul * page_sz > sz)
-			return mul * page_sz;
-	}
-
-	/* if it's impossible to satisfy the conditions (i.e., user size is
-	 * very close to UINT_MAX but is not a power-of-2 multiple of
-	 * page_size) then just return original size and let kernel reject it
-	 */
-	return sz;
-}
-
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -4928,9 +4938,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	}
 
 	switch (def->type) {
-	case BPF_MAP_TYPE_RINGBUF:
-		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
-		/* fallthrough */
 	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_STACK_TRACE:
-- 
2.30.2

