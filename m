Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA853D22C
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348810AbiFCTGk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbiFCTG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:06:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0130F78
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:06:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmHI2028305
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:06:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gf4pap1j5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:06:24 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:06:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E03B71AC9C444; Fri,  3 Jun 2022 12:03:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 13/15] selftests/bpf: remove last tests with legacy BPF map definitions
Date:   Fri, 3 Jun 2022 12:01:53 -0700
Message-ID: <20220603190155.3924899-14-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 55MSPCDWz71lz0Xm8ZWR2Xxdghu7eq_Z
X-Proofpoint-ORIG-GUID: 55MSPCDWz71lz0Xm8ZWR2Xxdghu7eq_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf 1.0 stops support legacy-style BPF map definitions. Selftests has
been migrated away from using legacy BPF map definitions except for two
selftests, to make sure that legacy functionality still worked in
pre-1.0 libbpf. Now it's time to let those tests go as libbpf 1.0 is
imminent.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bpf_legacy.h      |  9 ----
 tools/testing/selftests/bpf/prog_tests/btf.c  |  1 -
 .../selftests/bpf/progs/test_btf_haskv.c      | 51 -------------------
 .../selftests/bpf/progs/test_btf_newkv.c      | 18 -------
 4 files changed, 79 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_btf_haskv.c

diff --git a/tools/testing/selftests/bpf/bpf_legacy.h b/tools/testing/selftests/bpf/bpf_legacy.h
index 719ab56cdb5d..845209581440 100644
--- a/tools/testing/selftests/bpf/bpf_legacy.h
+++ b/tools/testing/selftests/bpf/bpf_legacy.h
@@ -2,15 +2,6 @@
 #ifndef __BPF_LEGACY__
 #define __BPF_LEGACY__
 
-#define BPF_ANNOTATE_KV_PAIR(name, type_key, type_val)		\
-	struct ____btf_map_##name {				\
-		type_key key;					\
-		type_val value;					\
-	};							\
-	struct ____btf_map_##name				\
-	__attribute__ ((section(".maps." #name), used))		\
-		____btf_map_##name = { }
-
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
  */
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ba5bde53d418..2961926e1051 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4636,7 +4636,6 @@ struct btf_file_test {
 };
 
 static struct btf_file_test file_tests[] = {
-	{ .file = "test_btf_haskv.o", },
 	{ .file = "test_btf_newkv.o", },
 	{ .file = "test_btf_nokv.o", .btf_kv_notfound = true, },
 };
diff --git a/tools/testing/selftests/bpf/progs/test_btf_haskv.c b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
deleted file mode 100644
index 07c94df13660..000000000000
--- a/tools/testing/selftests/bpf/progs/test_btf_haskv.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2018 Facebook */
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include "bpf_legacy.h"
-
-struct ipv_counts {
-	unsigned int v4;
-	unsigned int v6;
-};
-
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-struct bpf_map_def SEC("maps") btf_map = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(struct ipv_counts),
-	.max_entries = 4,
-};
-#pragma GCC diagnostic pop
-
-BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
-
-__attribute__((noinline))
-int test_long_fname_2(void)
-{
-	struct ipv_counts *counts;
-	int key = 0;
-
-	counts = bpf_map_lookup_elem(&btf_map, &key);
-	if (!counts)
-		return 0;
-
-	counts->v6++;
-
-	return 0;
-}
-
-__attribute__((noinline))
-int test_long_fname_1(void)
-{
-	return test_long_fname_2();
-}
-
-SEC("dummy_tracepoint")
-int _dummy_tracepoint(void *arg)
-{
-	return test_long_fname_1();
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_btf_newkv.c b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
index 762671a2e90c..251854a041b5 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_newkv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
@@ -9,19 +9,6 @@ struct ipv_counts {
 	unsigned int v6;
 };
 
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-/* just to validate we can handle maps in multiple sections */
-struct bpf_map_def SEC("maps") btf_map_legacy = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(long long),
-	.max_entries = 4,
-};
-#pragma GCC diagnostic pop
-
-BPF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
-
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__uint(max_entries, 4);
@@ -41,11 +28,6 @@ int test_long_fname_2(void)
 
 	counts->v6++;
 
-	/* just verify we can reference both maps */
-	counts = bpf_map_lookup_elem(&btf_map_legacy, &key);
-	if (!counts)
-		return 0;
-
 	return 0;
 }
 
-- 
2.30.2

