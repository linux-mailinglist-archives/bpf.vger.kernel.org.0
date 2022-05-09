Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3EA51F252
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiEIBao convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiEIAqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:46:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE36430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:16 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NgROB006751
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpfmns9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:16 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 98E0119A4AD77; Sun,  8 May 2022 17:42:05 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 8/9] libbpf: automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary
Date:   Sun, 8 May 2022 17:41:47 -0700
Message-ID: <20220509004148.1801791-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I_gVbL6uU2OqL_xbsWCY1LvOUwmTgHWk
X-Proofpoint-GUID: I_gVbL6uU2OqL_xbsWCY1LvOUwmTgHWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel imposes a pretty particular restriction on ringbuf map size. It
has to be a power-of-2 multiple of page size. While generally this isn't
hard for user to satisfy, sometimes it's impossible to do this
declaratively in BPF source code or just plain inconvenient to do at
runtime.

One such example might be BPF libraries that are supposed to work on
different architectures, which might not agree on what the common page
size is.

Let libbpf find the right size for user instead, if it turns out to not
satisfy kernel requirements. If user didn't set size at all, that's most
probably a mistake so don't upsize such zero size to one full page,
though. Also we need to be careful about not overflowing __u32
max_entries.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 63c0f412266c..15117b9a4d1e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4943,6 +4943,44 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
+static bool is_pow_of_2(size_t x)
+{
+	return x && (x & (x - 1));
+}
+
+static size_t adjust_ringbuf_sz(size_t sz)
+{
+	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
+	__u32 i, mul;
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
+	for (i = 0, mul = 1; ; i++, mul <<= 1) {
+		if (mul > UINT_MAX / page_sz) /* prevent __u32 overflow */
+			break;
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
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -4981,6 +5019,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	}
 
 	switch (def->type) {
+	case BPF_MAP_TYPE_RINGBUF:
+		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
+		/* fallthrough */
 	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_STACK_TRACE:
@@ -4994,7 +5035,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_QUEUE:
 	case BPF_MAP_TYPE_STACK:
-	case BPF_MAP_TYPE_RINGBUF:
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
-- 
2.30.2

