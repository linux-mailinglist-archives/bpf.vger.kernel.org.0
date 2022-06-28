Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DC55E5FB
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348289AbiF1QDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348302AbiF1QCv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:51 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE373631D
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:02:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7168F240110
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432128; bh=AznzVodV6W1TIBgBIeYvAsbZY2RoSPYRQLforYYonYE=;
        h=From:To:Cc:Subject:Date:From;
        b=IMHYvPqOHFUn5OsSRlDK4xWpETgNQ3Q0LJ44x62PQZyNqpZRZ95CL+eKp0Znt9gId
         SpK/QK8V2AD3FAWLgCppztDni9kd9PJHGH9EnKuHaxfTgf7EWgDLsYvJi+EnHECIq/
         B20TNcQ9uVNLt4pxgDt6qhZIdSa9PvYExWVSzFT8iOgZjZ9kq6gATk0+ahtxoTn2RH
         eqYeut0LNnqMpQE6/LeImMmbFIbnTTTqf8T8EYjrC8hkAJJ64/oKMPZDJbO4iHpMVk
         ErelbVFyv+pixJgkjfS/85d1Zvsb88Zh5qAut61RnYLQDeki0oqfcf3V9yw7YwqvO+
         d7EVJXGhMvNCw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqz1s0jz6tmW;
        Tue, 28 Jun 2022 18:02:07 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: Add type match test against kernel's task_struct
Date:   Tue, 28 Jun 2022 16:01:27 +0000
Message-Id: <20220628160127.607834-11-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change extends the existing core_reloc/kernel test to include a
type match check of a local task_struct against the kernel's definition
-- which we assume to succeed.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/core_reloc.c     |  1 +
 .../selftests/bpf/progs/core_reloc_types.h    |  1 +
 .../bpf/progs/test_core_reloc_kernel.c        | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 8882c9c..a6f65e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -555,6 +555,7 @@ static const struct core_reloc_test_case test_cases[] = {
 			.valid = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
 			.comm = "test_progs",
 			.comm_len = sizeof("test_progs"),
+			.local_task_struct_matches = true,
 		},
 		.output_len = sizeof(struct core_reloc_kernel_output),
 		.raw_tp_name = "sys_enter",
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 474411..7ef91d 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -13,6 +13,7 @@ struct core_reloc_kernel_output {
 	int valid[10];
 	char comm[sizeof("test_progs")];
 	int comm_len;
+	bool local_task_struct_matches;
 };
 
 /*
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
index 145028..a17dd8 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
@@ -21,6 +21,7 @@ struct core_reloc_kernel_output {
 	/* we have test_progs[-flavor], so cut flavor part */
 	char comm[sizeof("test_progs")];
 	int comm_len;
+	bool local_task_struct_matches;
 };
 
 struct task_struct {
@@ -30,11 +31,25 @@ struct task_struct {
 	struct task_struct *group_leader;
 };
 
+struct mm_struct___wrong {
+    int abc_whatever_should_not_exist;
+};
+
+struct task_struct___local {
+    int pid;
+    struct mm_struct___wrong *mm;
+};
+
 #define CORE_READ(dst, src) bpf_core_read(dst, sizeof(*(dst)), src)
 
 SEC("raw_tracepoint/sys_enter")
 int test_core_kernel(void *ctx)
 {
+	/* Support for the BPF_TYPE_MATCHES argument to the
+	 * __builtin_preserve_type_info builtin was added at some point during
+	 * development of clang 15 and it's what we require for this test.
+	 */
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 	struct task_struct *task = (void *)bpf_get_current_task();
 	struct core_reloc_kernel_output *out = (void *)&data.out;
 	uint64_t pid_tgid = bpf_get_current_pid_tgid();
@@ -93,6 +108,10 @@ int test_core_kernel(void *ctx)
 		group_leader, group_leader, group_leader, group_leader,
 		comm);
 
+	out->local_task_struct_matches = bpf_core_type_matches(struct task_struct___local);
+#else
+	data.skip = true;
+#endif
 	return 0;
 }
 
-- 
2.30.2

