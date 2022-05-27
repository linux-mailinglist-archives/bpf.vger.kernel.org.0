Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D35536848
	for <lists+bpf@lfdr.de>; Fri, 27 May 2022 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354662AbiE0U4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354661AbiE0U4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 16:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EBCC14F;
        Fri, 27 May 2022 13:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDFE8B82643;
        Fri, 27 May 2022 20:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DE1C341C0;
        Fri, 27 May 2022 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653684992;
        bh=WRBJvERlKiPlNWdw9voASYpnH5n7FEc2E25EJ2PJsgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prQP79Y4oEuy1haH0RFnY8okD93eBmnj34OdMLwTxUpL0sR/dLix8HZN9/xoOOgu1
         1MruEmbgngJiMyPMut55TzlKfzIrcCMgh7A13uimuBfiMap9AHPidbv9K3C+IbPjVk
         xv8WrC6ZqcjadPqTsh1+/QeA1IvW5uRn3kBl3ezw4nobBrxywmEc2BUc3/w7ipLdFw
         qm8rYEmC3vLQ6CcYmrhurXFdGb1Lmc79Q84Y3JZlLeMyKc/9UN0mXlbiW+43tXsQGp
         oGyLosAK+dtCc8O+ABp6D8YLwJ13C4lWXsGyVDnKSpuJEiGj6jl2wH5YIsaHNwnm9J
         PTGRtDvpLvSjA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Shuffle cookies symbols in kprobe multi test
Date:   Fri, 27 May 2022 22:56:09 +0200
Message-Id: <20220527205611.655282-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220527205611.655282-1-jolsa@kernel.org>
References: <20220527205611.655282-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's a kernel bug that causes cookies to be misplaced and
the reason we did not catch this with this test is that we
provide bpf_fentry_test* functions already sorted by name.

Shuffling function bpf_fentry_test2 deeper in the list and
keeping the current cookie values as before will trigger
the bug.

The kernel fix is coming in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 78 +++++++++----------
 .../selftests/bpf/progs/kprobe_multi.c        | 24 +++---
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 83ef55e3caa4..2974b44f80fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -121,24 +121,24 @@ static void kprobe_multi_link_api_subtest(void)
 })
 
 	GET_ADDR("bpf_fentry_test1", addrs[0]);
-	GET_ADDR("bpf_fentry_test2", addrs[1]);
-	GET_ADDR("bpf_fentry_test3", addrs[2]);
-	GET_ADDR("bpf_fentry_test4", addrs[3]);
-	GET_ADDR("bpf_fentry_test5", addrs[4]);
-	GET_ADDR("bpf_fentry_test6", addrs[5]);
-	GET_ADDR("bpf_fentry_test7", addrs[6]);
+	GET_ADDR("bpf_fentry_test3", addrs[1]);
+	GET_ADDR("bpf_fentry_test4", addrs[2]);
+	GET_ADDR("bpf_fentry_test5", addrs[3]);
+	GET_ADDR("bpf_fentry_test6", addrs[4]);
+	GET_ADDR("bpf_fentry_test7", addrs[5]);
+	GET_ADDR("bpf_fentry_test2", addrs[6]);
 	GET_ADDR("bpf_fentry_test8", addrs[7]);
 
 #undef GET_ADDR
 
-	cookies[0] = 1;
-	cookies[1] = 2;
-	cookies[2] = 3;
-	cookies[3] = 4;
-	cookies[4] = 5;
-	cookies[5] = 6;
-	cookies[6] = 7;
-	cookies[7] = 8;
+	cookies[0] = 1; /* bpf_fentry_test1 */
+	cookies[1] = 2; /* bpf_fentry_test3 */
+	cookies[2] = 3; /* bpf_fentry_test4 */
+	cookies[3] = 4; /* bpf_fentry_test5 */
+	cookies[4] = 5; /* bpf_fentry_test6 */
+	cookies[5] = 6; /* bpf_fentry_test7 */
+	cookies[6] = 7; /* bpf_fentry_test2 */
+	cookies[7] = 8; /* bpf_fentry_test8 */
 
 	opts.kprobe_multi.addrs = (const unsigned long *) &addrs;
 	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
@@ -149,14 +149,14 @@ static void kprobe_multi_link_api_subtest(void)
 	if (!ASSERT_GE(link1_fd, 0, "link1_fd"))
 		goto cleanup;
 
-	cookies[0] = 8;
-	cookies[1] = 7;
-	cookies[2] = 6;
-	cookies[3] = 5;
-	cookies[4] = 4;
-	cookies[5] = 3;
-	cookies[6] = 2;
-	cookies[7] = 1;
+	cookies[0] = 8; /* bpf_fentry_test1 */
+	cookies[1] = 7; /* bpf_fentry_test3 */
+	cookies[2] = 6; /* bpf_fentry_test4 */
+	cookies[3] = 5; /* bpf_fentry_test5 */
+	cookies[4] = 4; /* bpf_fentry_test6 */
+	cookies[5] = 3; /* bpf_fentry_test7 */
+	cookies[6] = 2; /* bpf_fentry_test2 */
+	cookies[7] = 1; /* bpf_fentry_test8 */
 
 	opts.kprobe_multi.flags = BPF_F_KPROBE_MULTI_RETURN;
 	prog_fd = bpf_program__fd(skel->progs.test_kretprobe);
@@ -181,12 +181,12 @@ static void kprobe_multi_attach_api_subtest(void)
 	struct kprobe_multi *skel = NULL;
 	const char *syms[8] = {
 		"bpf_fentry_test1",
-		"bpf_fentry_test2",
 		"bpf_fentry_test3",
 		"bpf_fentry_test4",
 		"bpf_fentry_test5",
 		"bpf_fentry_test6",
 		"bpf_fentry_test7",
+		"bpf_fentry_test2",
 		"bpf_fentry_test8",
 	};
 	__u64 cookies[8];
@@ -198,14 +198,14 @@ static void kprobe_multi_attach_api_subtest(void)
 	skel->bss->pid = getpid();
 	skel->bss->test_cookie = true;
 
-	cookies[0] = 1;
-	cookies[1] = 2;
-	cookies[2] = 3;
-	cookies[3] = 4;
-	cookies[4] = 5;
-	cookies[5] = 6;
-	cookies[6] = 7;
-	cookies[7] = 8;
+	cookies[0] = 1; /* bpf_fentry_test1 */
+	cookies[1] = 2; /* bpf_fentry_test3 */
+	cookies[2] = 3; /* bpf_fentry_test4 */
+	cookies[3] = 4; /* bpf_fentry_test5 */
+	cookies[4] = 5; /* bpf_fentry_test6 */
+	cookies[5] = 6; /* bpf_fentry_test7 */
+	cookies[6] = 7; /* bpf_fentry_test2 */
+	cookies[7] = 8; /* bpf_fentry_test8 */
 
 	opts.syms = syms;
 	opts.cnt = ARRAY_SIZE(syms);
@@ -216,14 +216,14 @@ static void kprobe_multi_attach_api_subtest(void)
 	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_kprobe_multi_opts"))
 		goto cleanup;
 
-	cookies[0] = 8;
-	cookies[1] = 7;
-	cookies[2] = 6;
-	cookies[3] = 5;
-	cookies[4] = 4;
-	cookies[5] = 3;
-	cookies[6] = 2;
-	cookies[7] = 1;
+	cookies[0] = 8; /* bpf_fentry_test1 */
+	cookies[1] = 7; /* bpf_fentry_test3 */
+	cookies[2] = 6; /* bpf_fentry_test4 */
+	cookies[3] = 5; /* bpf_fentry_test5 */
+	cookies[4] = 4; /* bpf_fentry_test6 */
+	cookies[5] = 3; /* bpf_fentry_test7 */
+	cookies[6] = 2; /* bpf_fentry_test2 */
+	cookies[7] = 1; /* bpf_fentry_test8 */
 
 	opts.retprobe = true;
 
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 93510f4f0f3a..08f95a8155d1 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -54,21 +54,21 @@ static void kprobe_multi_check(void *ctx, bool is_return)
 
 	if (is_return) {
 		SET(kretprobe_test1_result, &bpf_fentry_test1, 8);
-		SET(kretprobe_test2_result, &bpf_fentry_test2, 7);
-		SET(kretprobe_test3_result, &bpf_fentry_test3, 6);
-		SET(kretprobe_test4_result, &bpf_fentry_test4, 5);
-		SET(kretprobe_test5_result, &bpf_fentry_test5, 4);
-		SET(kretprobe_test6_result, &bpf_fentry_test6, 3);
-		SET(kretprobe_test7_result, &bpf_fentry_test7, 2);
+		SET(kretprobe_test2_result, &bpf_fentry_test2, 2);
+		SET(kretprobe_test3_result, &bpf_fentry_test3, 7);
+		SET(kretprobe_test4_result, &bpf_fentry_test4, 6);
+		SET(kretprobe_test5_result, &bpf_fentry_test5, 5);
+		SET(kretprobe_test6_result, &bpf_fentry_test6, 4);
+		SET(kretprobe_test7_result, &bpf_fentry_test7, 3);
 		SET(kretprobe_test8_result, &bpf_fentry_test8, 1);
 	} else {
 		SET(kprobe_test1_result, &bpf_fentry_test1, 1);
-		SET(kprobe_test2_result, &bpf_fentry_test2, 2);
-		SET(kprobe_test3_result, &bpf_fentry_test3, 3);
-		SET(kprobe_test4_result, &bpf_fentry_test4, 4);
-		SET(kprobe_test5_result, &bpf_fentry_test5, 5);
-		SET(kprobe_test6_result, &bpf_fentry_test6, 6);
-		SET(kprobe_test7_result, &bpf_fentry_test7, 7);
+		SET(kprobe_test2_result, &bpf_fentry_test2, 7);
+		SET(kprobe_test3_result, &bpf_fentry_test3, 2);
+		SET(kprobe_test4_result, &bpf_fentry_test4, 3);
+		SET(kprobe_test5_result, &bpf_fentry_test5, 4);
+		SET(kprobe_test6_result, &bpf_fentry_test6, 5);
+		SET(kprobe_test7_result, &bpf_fentry_test7, 6);
 		SET(kprobe_test8_result, &bpf_fentry_test8, 8);
 	}
 
-- 
2.35.3

