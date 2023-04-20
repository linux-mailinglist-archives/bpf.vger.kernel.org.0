Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748C6E9FD2
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjDTXYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDTXYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:24:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EFA4EEF
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec816c9b62so993253e87.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033074; x=1684625074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAuXggJ3lgOocGa5UKypiuaKvz2jibuoBb0WOXcW4xQ=;
        b=MJsY2zv+8LFKzlj1qDlMZUknNPeaRdEWvJOV52Hs+XwokA1d6qhk87JKjZbhswn8zj
         p8cPnRuzfj21rzc74XQui3Dm+XIvASLdPH2ln+zPkE6AqHNYAIs0hFRqz1IHg1fOLTms
         17sU9yCrAVKoHgOgdU8Pl3r+Kgy8XUFOHY5DdIvWmEzpgcL1koH1tnbeQtfRdrVOBn9C
         wrenlWyd2mQOh2v5NmxV5FpzKU6TUcMrxfmJdlXSPTmw3MVw8TfsoZ7ZlHOwOxx53/01
         Y0WPis/N4HEfVNJ7B1SzguXG7QGirdPGLt+mFmPS4knmx2VTWh1vp6Yscm7e9b16Nlmc
         18dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033074; x=1684625074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAuXggJ3lgOocGa5UKypiuaKvz2jibuoBb0WOXcW4xQ=;
        b=lbIHqB2a5duNVbj0PB56VP/gJam0Hjr2vb3c63HwpLVI1Z6pgFMEHyjWgUGZjonkb0
         +/GdQXTm6ljrggPr3YQC/KMw4zOSE8nZ86DlzYD18Z5ER+7S4gawWLPUx5MYnffsdef5
         eNZTRMmFll82lczsxRerrNgV8slTu8m5x1Vjw6TMq8OjQfH2jviUsJcOdFN+nNLLhOWX
         aKdj9o9yPBBQuSbuE91YU4Pp4GXyXXOnw5mwNYs0Vpw0UpLiV1ia8+Fu3hqaRTn2+arD
         8dgTSEvVvTU+livgJP+M9bIARmRivF/GuT9VCtWlx8ZWsNqNzMDrmfe9kov2Z8rJWtzB
         LjWQ==
X-Gm-Message-State: AAQBX9dxa0fOBhofeGuKjMcGQIUvfVzmN1sbEhuR9j7v+B2YV3MCGOJ9
        BXdKcZzsqVr8/fAxnM3QHJj346+dONM=
X-Google-Smtp-Source: AKy350Zz3RQxQtlqfkiW/IS8v5Fb7uEVBiDs/+ieqj4d4bY4uOqHMOetyknJaOPpBjIHDeI6coV4tA==
X-Received: by 2002:ac2:490e:0:b0:4eb:2d47:603 with SMTP id n14-20020ac2490e000000b004eb2d470603mr834079lfi.47.1682033073864;
        Thu, 20 Apr 2023 16:24:33 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm360227lfq.155.2023.04.20.16.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:24:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: populate map_array_ro map for verifier_array_access test
Date:   Fri, 21 Apr 2023 02:23:17 +0300
Message-Id: <20230420232317.2181776-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420232317.2181776-1-eddyz87@gmail.com>
References: <20230420232317.2181776-1-eddyz87@gmail.com>
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

Two test cases:
- "valid read map access into a read-only array 1" and
- "valid read map access into a read-only array 2"

Expect that map_array_ro map is filled with mock data. This logic was
not taken into acount during initial test conversion.

This commit modifies prog_tests/verifier.c entry point for this test
to fill the map.

Fixes: a3c830ae0209 ("selftests/bpf: verifier/array_access.c converted to inline assembly")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 42 +++++++++++++++++--
 .../bpf/progs/verifier_array_access.c         |  4 +-
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 25bc8958dbfe..7c68d78da9ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -44,8 +44,17 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
 __maybe_unused
-static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
+static void run_tests_aux(const char *skel_name,
+			  skel_elf_bytes_fn elf_bytes_factory,
+			  pre_execution_cb pre_execution_cb)
 {
 	struct test_loader tester = {};
 	__u64 old_caps;
@@ -58,6 +67,7 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 		return;
 	}
 
+	test_loader__set_pre_execution_cb(&tester, pre_execution_cb);
 	test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
 	test_loader_fini(&tester);
 
@@ -66,10 +76,9 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
 }
 
-#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes)
+#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
-void test_verifier_array_access(void)         { RUN(verifier_array_access); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
@@ -108,3 +117,30 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+
+static int init_array_access_maps(struct bpf_object *obj)
+{
+	struct bpf_map *array_ro;
+	struct test_val value = {
+		.index = (6 + 1) * sizeof(int),
+		.foo[6] = 0xabcdef12,
+	};
+	int err, key = 0;
+
+	array_ro = bpf_object__find_map_by_name(obj, "map_array_ro");
+	if (!ASSERT_OK_PTR(array_ro, "lookup map_array_ro"))
+		return -EINVAL;
+
+	err = bpf_map_update_elem(bpf_map__fd(array_ro), &key, &value, 0);
+	if (!ASSERT_OK(err, "map_array_ro update"))
+		return err;
+
+	return 0;
+}
+
+void test_verifier_array_access(void)
+{
+	run_tests_aux("verifier_array_access",
+		      verifier_array_access__elf_bytes,
+		      init_array_access_maps);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index fceeeef78721..95d7ecc12963 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -330,7 +330,7 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("valid read map access into a read-only array 1")
-__success __success_unpriv /* __retval(28) temporarily disable */
+__success __success_unpriv __retval(28)
 __naked void a_read_only_array_1_1(void)
 {
 	asm volatile ("					\
@@ -351,7 +351,7 @@ l0_%=:	exit;						\
 
 SEC("tc")
 __description("valid read map access into a read-only array 2")
-__success /* __retval(65507) temporarily disable */
+__success __retval(65507)
 __naked void a_read_only_array_2_1(void)
 {
 	asm volatile ("					\
-- 
2.40.0

