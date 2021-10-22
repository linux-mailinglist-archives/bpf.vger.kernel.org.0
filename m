Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330C6438040
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhJVWe4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 18:34:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhJVWe4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:34:56 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MLCbBv020913
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:38 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bum5j0mg4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:38 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:32:37 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 04EC570D5F63; Fri, 22 Oct 2021 15:32:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: normalize selftest entry points
Date:   Fri, 22 Oct 2021 15:32:25 -0700
Message-ID: <20211022223228.99920-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223228.99920-1-andrii@kernel.org>
References: <20211022223228.99920-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: oRBnpYjJUz-QikE_BQabT_Zi9pd5ZZvh
X-Proofpoint-ORIG-GUID: oRBnpYjJUz-QikE_BQabT_Zi9pd5ZZvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that all test entry points are global void functions with no
input arguments. Mark few subtest entry points as static.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c      |  2 +-
 .../testing/selftests/bpf/prog_tests/resolve_btfids.c  | 10 ++++------
 .../testing/selftests/bpf/prog_tests/signal_pending.c  |  2 +-
 tools/testing/selftests/bpf/prog_tests/snprintf.c      |  4 ++--
 .../testing/selftests/bpf/prog_tests/xdp_adjust_tail.c |  6 +++---
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c       |  4 ++--
 6 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 12f457b6786d..d8961054c05b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -133,7 +133,7 @@ static char *dump_buf;
 static size_t dump_buf_sz;
 static FILE *dump_buf_file;
 
-void test_btf_dump_incremental(void)
+static void test_btf_dump_incremental(void)
 {
 	struct btf *btf = NULL;
 	struct btf_dump *d = NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index f62361306f6d..c7cb25334d78 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -117,14 +117,14 @@ static int resolve_symbols(void)
 	return 0;
 }
 
-int test_resolve_btfids(void)
+void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
 	unsigned int i, j;
 	int ret = 0;
 
 	if (resolve_symbols())
-		return -1;
+		return;
 
 	/* Check BTF_ID_LIST(test_list_local) and
 	 * BTF_ID_LIST_GLOBAL(test_list_global) IDs
@@ -138,7 +138,7 @@ int test_resolve_btfids(void)
 				    test_symbols[i].name,
 				    test_list[i], test_symbols[i].id);
 			if (ret)
-				return ret;
+				return;
 		}
 	}
 
@@ -161,9 +161,7 @@ int test_resolve_btfids(void)
 
 		if (i > 0) {
 			if (!ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check"))
-				return -1;
+				return;
 		}
 	}
-
-	return ret;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
index dfcbddcbe4d3..fdfdcff6cbef 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -42,7 +42,7 @@ static void test_signal_pending_by_type(enum bpf_prog_type prog_type)
 	signal(SIGALRM, SIG_DFL);
 }
 
-void test_signal_pending(enum bpf_prog_type prog_type)
+void test_signal_pending(void)
 {
 	test_signal_pending_by_type(BPF_PROG_TYPE_SOCKET_FILTER);
 	test_signal_pending_by_type(BPF_PROG_TYPE_FLOW_DISSECTOR);
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 8fd1b4b29a0e..394ebfc3bbf3 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -33,7 +33,7 @@
 
 #define EXP_NO_BUF_RET 29
 
-void test_snprintf_positive(void)
+static void test_snprintf_positive(void)
 {
 	char exp_addr_out[] = EXP_ADDR_OUT;
 	char exp_sym_out[]  = EXP_SYM_OUT;
@@ -103,7 +103,7 @@ static int load_single_snprintf(char *fmt)
 	return ret;
 }
 
-void test_snprintf_negative(void)
+static void test_snprintf_negative(void)
 {
 	ASSERT_OK(load_single_snprintf("valid %d"), "valid usage");
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index d5c98f2cb12f..f529e3c923ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
-void test_xdp_adjust_tail_shrink(void)
+static void test_xdp_adjust_tail_shrink(void)
 {
 	const char *file = "./test_xdp_adjust_tail_shrink.o";
 	__u32 duration, retval, size, expect_sz;
@@ -30,7 +30,7 @@ void test_xdp_adjust_tail_shrink(void)
 	bpf_object__close(obj);
 }
 
-void test_xdp_adjust_tail_grow(void)
+static void test_xdp_adjust_tail_grow(void)
 {
 	const char *file = "./test_xdp_adjust_tail_grow.o";
 	struct bpf_object *obj;
@@ -58,7 +58,7 @@ void test_xdp_adjust_tail_grow(void)
 	bpf_object__close(obj);
 }
 
-void test_xdp_adjust_tail_grow2(void)
+static void test_xdp_adjust_tail_grow2(void)
 {
 	const char *file = "./test_xdp_adjust_tail_grow.o";
 	char buf[4096]; /* avoid segfault: large buf to hold grow results */
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index d4e9a9972a67..3079d5568f8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -8,7 +8,7 @@
 
 #define IFINDEX_LO 1
 
-void test_xdp_with_devmap_helpers(void)
+static void test_xdp_with_devmap_helpers(void)
 {
 	struct test_xdp_with_devmap_helpers *skel;
 	struct bpf_prog_info info = {};
@@ -60,7 +60,7 @@ void test_xdp_with_devmap_helpers(void)
 	test_xdp_with_devmap_helpers__destroy(skel);
 }
 
-void test_neg_xdp_devmap_helpers(void)
+static void test_neg_xdp_devmap_helpers(void)
 {
 	struct test_xdp_devmap_helpers *skel;
 
-- 
2.30.2

