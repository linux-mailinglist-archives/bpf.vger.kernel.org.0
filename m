Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF455286D
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbiFTXyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiFTXyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:54:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383F13D28
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ay16so4701874ejb.6
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0gJlAyr6iWp++zpBDPdS2GGhrkA349ug3a4vI2yiaw=;
        b=JtaD7B2aoT4+8Tl2TvLxMSB0ddeIgCjuHkDVDW7PZ3/A7FBHohW4Ucxaa/o7Jetm6L
         v6XiNXWiKCd/eCJnmHnNhAANG626FHbwtR9uBPsiRGW7AnECMyZcqai4O5+8Gz3F46a2
         asJlIvGY7N470afr/DT88rHP9SEbJgU4bZ2v2Q+MSG2ZmixSXAtMluXlYUk1kEy8Cnwo
         ojGsIe9/iTbngr0OEkUfI2XRq4U8vEnxmfNveudlAniKFK4CDz8QoB3UaJMV2Vaj0o1s
         lCFSxEgTwdy23WUTXFp7Yvq3MSiEtTR+D9/kTktQXn8HK/6NLAvkrav/WYbGERYl3nm/
         5Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0gJlAyr6iWp++zpBDPdS2GGhrkA349ug3a4vI2yiaw=;
        b=EMLzRD+G6KHZGlDPOQtka0iVDv3NJOYd0sUhOIUVvZ/mcQfmSHBRVa+n7d5FEk2KDO
         S4lF7HxAKmpj6tPnpd524EFD9afaFr94ijdmN2Pw1ytJYSl2b8eizhB4NF4g3wKIoOIO
         uLb0j0ZuLvsrq4UyVtPk9TeYSX6+IV4TfAqdmXofzNX3SIVri/8laVCTLBFcfrkEn/jC
         b84lf3lOKJFwKJNrSKY7ab12PDFsbr28z4muIFmUPhkBdSgh+22YG71pnnW7m9Xk/5+J
         d88S2noXKbIx6vwHROjKnIGCKBrf5+NLZayFzDKTW0w/ec4w0yFuehBlN5XNnCwtH1J8
         t2Ag==
X-Gm-Message-State: AJIora8V2AgIeGb6EtOfUKKmP/L7r0CwNBr4nT8VWwquuX4PrtNag1C6
        598l+vS1F8/v0RXqfsX9sp0OJVTHtB8YupaI
X-Google-Smtp-Source: AGRyM1vTbYoiRIXL2DV/2vIcwjCOO+hmaEIcHbuJ/d3ntBKmfp1yk0GEWVoERzNynwJMOqqcAqJU3Q==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr23493959ejv.79.1655769287937;
        Mon, 20 Jun 2022 16:54:47 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402105500b004356d08bbbasm7078560edu.40.2022.06.20.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 16:54:47 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v8 5/5] selftests/bpf: BPF test_prog selftests for bpf_loop inlining
Date:   Tue, 21 Jun 2022 02:53:44 +0300
Message-Id: <20220620235344.569325-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620235344.569325-1-eddyz87@gmail.com>
References: <20220620235344.569325-1-eddyz87@gmail.com>
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

