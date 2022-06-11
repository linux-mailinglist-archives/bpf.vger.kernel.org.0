Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6477E54745B
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiFKLml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jun 2022 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiFKLmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jun 2022 07:42:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588D205DB
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h23so1637023ljl.3
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0gJlAyr6iWp++zpBDPdS2GGhrkA349ug3a4vI2yiaw=;
        b=Ufy2gtSKSQ8K/T8n1VBzY0ysVJlU9Xctml1rGWN0/S+2ECcDO/54iWS12ZOQyGDPM+
         C5LTeW43c3uasXiyu4S/uf8YLY7MWR5Nc/E0dfq+sH1uaMfL1+PVVZCzbaRkQzOqQxF6
         kLNUZAdvGU71ENTh3EjsYtu2/Jy3f+n7r//M+G+cmv3mEi3KeglN6RQzTCcpIpF2MK22
         kn4uA2CJXHJOEx9MU6+BT3oP+y40RbzGAzOB/NSxB6ozEoFvthKZSqlbmAuGH2Arg+nG
         z5dqs40CYpCJRCjH1dq9Vwac2/aUw9Mctv8qgjhCfQ+Nd/8k7/0s3B7rf9REmHmbcV8k
         3Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0gJlAyr6iWp++zpBDPdS2GGhrkA349ug3a4vI2yiaw=;
        b=tJLlSvhqHSziT61bs9ViQlEkwC+xB0UJCwV3EepfuXE9y4YHCzjjJvr4M2FHQrgB6H
         OngjkqkhUfJmdreslJXRwUyCh5J0M/3tNpzL01hsyaZq+/lvux6cBsUwEpR8dv6ulLTn
         GJ12L8ozftkPxzoHHdeVAoIzESEb+SdoDqyGNBjQPZqQF7D3KFb2vPMo+IYuJoOtyLMv
         sJp2RuSv2AXG07snEiUud94bd5rzQicYo19Mz/HoOj/hHkUuF6oE9J/9AJNxRNZPBHBO
         L2pfwh7x2gEZQ9b5xxJBaqSdsZEKKrg0joBhlh22VzzJY7I4QIIjduU60SyiRAUMr/IW
         FTPA==
X-Gm-Message-State: AOAM533fhHIe9AFaO/E/5VP+hQ6rG6tWu8sVFb5fUrKm7OqRZMsBqR1V
        ApT/DJgsdSgJd9swYutms/27p3O9lgvE5z2E
X-Google-Smtp-Source: ABdhPJyBZXxZjdUviw92Z7SRRlZhzR5TDyr1oATzaiwSbZ+Vup9E+VVHFGv88xrtu4ew3F4dMmyVVQ==
X-Received: by 2002:a05:651c:210b:b0:255:8278:b83e with SMTP id a11-20020a05651c210b00b002558278b83emr19848064ljq.217.1654947753968;
        Sat, 11 Jun 2022 04:42:33 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u18-20020ac25bd2000000b004795d64f37dsm229303lfn.105.2022.06.11.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:42:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: BPF test_prog selftests for bpf_loop inlining
Date:   Sat, 11 Jun 2022 14:40:21 +0300
Message-Id: <20220611114021.484408-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611114021.484408-1-eddyz87@gmail.com>
References: <20220611114021.484408-1-eddyz87@gmail.com>
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
Acked-by: Song Liu <songliubraving@fb.com>
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

