Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACC9567A62
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGEWuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 5 Jul 2022 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiGEWtw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 18:49:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9021F60B
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 15:48:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JJHLp016533
        for <bpf@vger.kernel.org>; Tue, 5 Jul 2022 15:48:43 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4ubusa64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 15:48:43 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 15:48:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 993891BF1EC04; Tue,  5 Jul 2022 15:48:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: fix few more compiler warnings
Date:   Tue, 5 Jul 2022 15:48:17 -0700
Message-ID: <20220705224818.4026623-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
References: <20220705224818.4026623-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hB85bzjYv-XGYEEB8IMB-rF46Ev7SUMP
X-Proofpoint-GUID: hB85bzjYv-XGYEEB8IMB-rF46Ev7SUMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling with -O2, GCC detects few problems with selftests/bpf, so
fix all of them. Two are real issues (uninitialized err and nums
out-of-bounds access), but two other uninitialized variables warnings
are due to GCC not being able to prove that variables are indeed
initialized under conditions under which they are used.

Fix all 4 cases, though.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/usdt.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 586dc52d6fb9..a8cb8a96ddaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -329,7 +329,7 @@ static int get_syms(char ***symsp, size_t *cntp)
 	struct hashmap *map;
 	char buf[256];
 	FILE *f;
-	int err;
+	int err = 0;
 
 	/*
 	 * The available_filter_functions contains many duplicates,
@@ -404,7 +404,7 @@ static void test_bench_attach(void)
 	double attach_delta, detach_delta;
 	struct bpf_link *link = NULL;
 	char **syms = NULL;
-	size_t cnt, i;
+	size_t cnt = 0, i;
 
 	if (!ASSERT_OK(get_syms(&syms, &cnt), "get_syms"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 5f733d50b0d7..9ad9da0f215e 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -12,7 +12,7 @@ int lets_test_this(int);
 
 static volatile int idx = 2;
 static volatile __u64 bla = 0xFEDCBA9876543210ULL;
-static volatile short nums[] = {-1, -2, -3, };
+static volatile short nums[] = {-1, -2, -3, -4};
 
 static volatile struct {
 	int x;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index fb77a123fe89..874a846e298c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -63,7 +63,7 @@ static bool expect_str(char *buf, size_t size, const char *str, const char *name
 static void test_synproxy(bool xdp)
 {
 	int server_fd = -1, client_fd = -1, accept_fd = -1;
-	char *prog_id, *prog_id_end;
+	char *prog_id = NULL, *prog_id_end;
 	struct nstoken *ns = NULL;
 	FILE *ctrl_file = NULL;
 	char buf[CMD_OUT_BUF_SIZE];
-- 
2.30.2

