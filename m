Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320E543CD6
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiFHT1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiFHT1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A24150B40
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 12:27:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w27so28375998edl.7
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ime0uBhl8dZtvwaLFuJZVd540nG432k7Ukxn9kp1Kvw=;
        b=avOAiY/Q7JFt+LCcHam9ROQrybpgXH50Nvl9ktPNdxY8Qpnl+lGiWlWlio/mo9SVYN
         K8WiaHyiEevaX1XMfE6HjZcZjuRQUvp0xJMIy2YDT2uWuxtcrn+L0KKld8F9xxFIqJs+
         ROaEJJZpzKssy4vaGb5Oq6TAv5nR28Zs3QtQq013DBwYCmmvTNM0uDOvVllWOr03ae0W
         SdqapZNPkBO40HLbTgRMRWwo74rzsRucCYa3Cf//r+5U3fAIY7dZpOa30qKMKpKsmaHl
         efbmClsxJMW+CSKnZ3BQ/NDQ6XSmQBmOMWM7vwsGRkvzqR79do4PPXuHem1JfZXC5M+I
         2ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ime0uBhl8dZtvwaLFuJZVd540nG432k7Ukxn9kp1Kvw=;
        b=mixyFLHHVfEBcjv2m0xvqZIAv6jlY/k0zZ1GlqQSIixNFyGfoNhGTxfkA4QTmZJbhH
         5ORYu2vhDAZwgxugJZBslgiZLqc9hGUHWZ/g0RDTAoKtU4bRwD9a/293C3EXbOo+rXYU
         oPnUo6DNL91MFtrboXsxoVkncJQg8ZpbcpW1e8C8EEN0snHEHaz1+CGnf1SrityJfxOy
         IEcXBZZXRP4i8UxcudJUxuIVHF/4zfDpKzWl9XY+AJ7Djh7msL6CBfmmwqqA5knIv+FZ
         1xQUarl6oIyOVAnn2CcfipGYPxevE82YaXNMn2Za585mjx+Fom872FBQ3RP76SCv7seI
         dzWg==
X-Gm-Message-State: AOAM5336vNCPkY7nf1Hq7CKgDdyGdGrdzcKZv5yRC8yZyZUrrR7fXPya
        9e69JLSdyrEFe0WtZsNlBQA31R5Ub7tMYg==
X-Google-Smtp-Source: ABdhPJyiu/2WqadWgYlGIt/RalX904VyTXTzp9p/YlKHRzXrHEz29Qmo8MtChpLwZsLB/NSh8tXUEg==
X-Received: by 2002:a05:6402:43c5:b0:42d:e4f6:d63e with SMTP id p5-20020a05640243c500b0042de4f6d63emr41148178edc.303.1654716463185;
        Wed, 08 Jun 2022 12:27:43 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm9596730ejj.152.2022.06.08.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:27:42 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: BPF test_prog selftests for bpf_loop inlining
Date:   Wed,  8 Jun 2022 22:26:30 +0300
Message-Id: <20220608192630.3710333-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608192630.3710333-1-eddyz87@gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two new test BPF programs for test_prog selftests checking bpf_loop
behavior. Both are corner cases for bpf_loop inlinig transformation:
 - check that bpf_loop behaves correctly when callback function is not
   a compile time constant
 - check that local function variables are not affected by allocating
   additional stack storage for registers spilled by loop inlining

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 ++++++++++
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 114 ++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
index 380d7a2072e3..4cd8a25afe68 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
@@ -120,6 +120,64 @@ static void check_nested_calls(struct bpf_loop *skel)
 	bpf_link__destroy(link);
 }
 
+static void check_non_constant_callback(struct bpf_loop *skel)
+{
+	struct bpf_link *link =
+		bpf_program__attach(skel->progs.prog_non_constant_callback);
+
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	skel->bss->callback_selector = 0x0F;
+	usleep(1);
+	ASSERT_EQ(skel->bss->g_output, 0x0F, "g_output #1");
+
+	skel->bss->callback_selector = 0xF0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->g_output, 0xF0, "g_output #2");
+
+	bpf_link__destroy(link);
+}
+
+static void check_stack(struct bpf_loop *skel)
+{
+	struct bpf_link *link = bpf_program__attach(skel->progs.stack_check);
+	const int max_key = 12;
+	int key;
+	int map_fd;
+
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.map1);
+
+	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd"))
+		goto out;
+
+	for (key = 1; key <= max_key; ++key) {
+		int val = key;
+		int err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
+
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto out;
+	}
+
+	usleep(1);
+
+	for (key = 1; key <= max_key; ++key) {
+		int val;
+		int err = bpf_map_lookup_elem(map_fd, &key, &val);
+
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+			goto out;
+		if (!ASSERT_EQ(val, key + 1, "bad value in the map"))
+			goto out;
+	}
+
+out:
+	bpf_link__destroy(link);
+}
+
 void test_bpf_loop(void)
 {
 	struct bpf_loop *skel;
@@ -140,6 +198,10 @@ void test_bpf_loop(void)
 		check_invalid_flags(skel);
 	if (test__start_subtest("check_nested_calls"))
 		check_nested_calls(skel);
+	if (test__start_subtest("check_non_constant_callback"))
+		check_non_constant_callback(skel);
+	if (test__start_subtest("check_stack"))
+		check_stack(skel);
 
 	bpf_loop__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing/selftests/bpf/progs/bpf_loop.c
index e08565282759..de1fc82d2710 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -11,11 +11,19 @@ struct callback_ctx {
 	int output;
 };
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 32);
+	__type(key, int);
+	__type(value, int);
+} map1 SEC(".maps");
+
 /* These should be set by the user program */
 u32 nested_callback_nr_loops;
 u32 stop_index = -1;
 u32 nr_loops;
 int pid;
+int callback_selector;
 
 /* Making these global variables so that the userspace program
  * can verify the output through the skeleton
@@ -111,3 +119,109 @@ int prog_nested_calls(void *ctx)
 
 	return 0;
 }
+
+static int callback_set_f0(int i, void *ctx)
+{
+	g_output = 0xF0;
+	return 0;
+}
+
+static int callback_set_0f(int i, void *ctx)
+{
+	g_output = 0x0F;
+	return 0;
+}
+
+/*
+ * non-constant callback is a corner case for bpf_loop inline logic
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int prog_non_constant_callback(void *ctx)
+{
+	struct callback_ctx data = {};
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	int (*callback)(int i, void *ctx);
+
+	g_output = 0;
+
+	if (callback_selector == 0x0F)
+		callback = callback_set_0f;
+	else
+		callback = callback_set_f0;
+
+	bpf_loop(1, callback, NULL, 0);
+
+	return 0;
+}
+
+static int stack_check_inner_callback(void *ctx)
+{
+	return 0;
+}
+
+static int map1_lookup_elem(int key)
+{
+	int *val = bpf_map_lookup_elem(&map1, &key);
+
+	return val ? *val : -1;
+}
+
+static void map1_update_elem(int key, int val)
+{
+	bpf_map_update_elem(&map1, &key, &val, BPF_ANY);
+}
+
+static int stack_check_outer_callback(void *ctx)
+{
+	int a = map1_lookup_elem(1);
+	int b = map1_lookup_elem(2);
+	int c = map1_lookup_elem(3);
+	int d = map1_lookup_elem(4);
+	int e = map1_lookup_elem(5);
+	int f = map1_lookup_elem(6);
+
+	bpf_loop(1, stack_check_inner_callback, NULL, 0);
+
+	map1_update_elem(1, a + 1);
+	map1_update_elem(2, b + 1);
+	map1_update_elem(3, c + 1);
+	map1_update_elem(4, d + 1);
+	map1_update_elem(5, e + 1);
+	map1_update_elem(6, f + 1);
+
+	return 0;
+}
+
+/* Some of the local variables in stack_check and
+ * stack_check_outer_callback would be allocated on stack by
+ * compiler. This test should verify that stack content for these
+ * variables is preserved between calls to bpf_loop (might be an issue
+ * if loop inlining allocates stack slots incorrectly).
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int stack_check(void *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	int a = map1_lookup_elem(7);
+	int b = map1_lookup_elem(8);
+	int c = map1_lookup_elem(9);
+	int d = map1_lookup_elem(10);
+	int e = map1_lookup_elem(11);
+	int f = map1_lookup_elem(12);
+
+	bpf_loop(1, stack_check_outer_callback, NULL, 0);
+
+	map1_update_elem(7,  a + 1);
+	map1_update_elem(8, b + 1);
+	map1_update_elem(9, c + 1);
+	map1_update_elem(10, d + 1);
+	map1_update_elem(11, e + 1);
+	map1_update_elem(12, f + 1);
+
+	return 0;
+}
-- 
2.25.1

