Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF896EB0E6
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjDURne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjDURnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27E755A8
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f917585b26so1860548f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098984; x=1684690984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRHPP5NjIYXdfWG6cP3BDnYCeq0/V3aalZnC0tGQQAQ=;
        b=AaK182RYJ5UmwpJLKJf3bdoU0KgAq+gktRM5cTsWcReNR4lbxRZYWjbZrqyAS5+OTX
         jjknxYBbjoz18DiscmB6k9hfzuySEIiZvK8DPPZ4WOgfhjPUhzCTQushU/US2ZFgXbeX
         jDBGx5YrbNsOwQ/BPpJnEmoFPlTqt3cEzUgGRYzkr45aePcbb4Q/IEverE81Ru8x+yWF
         rF1tvV8MR4IwdA1G6YsJSIPHjdyLXT7O/V3Ghz1mGy9/OBzQR3Ze6GTFrDyrkHWcAMcy
         8CIJ2ZKN5oJf+m5ZELdu4hIp3gq8ftPFVt7Vk9bud0B5hJb4/ebh4oXRaXHinoBaczWS
         n/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098984; x=1684690984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRHPP5NjIYXdfWG6cP3BDnYCeq0/V3aalZnC0tGQQAQ=;
        b=d83fp8wPT2AhmijlASVT5bEBD9DT5m263IbUWfWZ0TEuEGyg1uBPr6IcBqQruysxLA
         u9911XCzTVAdLCBNdcIDpI3L1e6r/uPUJuQwaLEfNzMo7XIKUUEhaCAUMf8js43Cmg23
         J/HsTfpytMnNjAvcYRaodGpjTgey+Kq0pV8Gbs0JCh6ZNys5lAgvV9svGlkjM5YnNIoR
         mztq4FL8hkU7L4nx0tJLCcHmr2YlLzb1SGXR7am3L1QcDY83leBeqG1es2T1bXPHWpJ0
         kc+I6HeRaeUCsRBPw8HM7arZjxQzvA1BBeK+5bikJ5rx6BOK2bxNXRSaU3Z1CwURZBw2
         FncQ==
X-Gm-Message-State: AAQBX9f/ysIzzKRb5SHnHyttBLZlmNhCfIsI1/a2oFV6XQ2sM0YMjoSz
        M2dfKyriAwgeZZ4xrs56pPDxv30SuBd6IQ==
X-Google-Smtp-Source: AKy350ZOxCwhEBKWnOQDqY0K2rTiI+kTxdPdjepL9OpY4LxNKodPCYvWFrmtDri2xTUmOi1meB0CyA==
X-Received: by 2002:a5d:684e:0:b0:2ce:a8d5:4a89 with SMTP id o14-20020a5d684e000000b002cea8d54a89mr4389484wrw.37.1682098983059;
        Fri, 21 Apr 2023 10:43:03 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 15/24] selftests/bpf: verifier/ref_tracking converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:25 +0300
Message-Id: <20230421174234.2391278-16-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
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

Test verifier/ref_tracking automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../bpf/progs/verifier_ref_tracking.c         | 1495 +++++++++++++++++
 .../selftests/bpf/verifier/ref_tracking.c     | 1082 ------------
 3 files changed, 1497 insertions(+), 1082 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ref_tracking.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7627893dd849..5941ef59ed76 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -45,6 +45,7 @@
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
+#include "verifier_ref_tracking.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
@@ -132,6 +133,7 @@ void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup)
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
+void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
new file mode 100644
index 000000000000..c4c6da21265e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -0,0 +1,1495 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/ref_tracking.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#define BPF_SK_LOOKUP(func) \
+	/* struct bpf_sock_tuple tuple = {} */ \
+	"r2 = 0;"			\
+	"*(u32*)(r10 - 8) = r2;"	\
+	"*(u64*)(r10 - 16) = r2;"	\
+	"*(u64*)(r10 - 24) = r2;"	\
+	"*(u64*)(r10 - 32) = r2;"	\
+	"*(u64*)(r10 - 40) = r2;"	\
+	"*(u64*)(r10 - 48) = r2;"	\
+	/* sk = func(ctx, &tuple, sizeof tuple, 0, 0) */ \
+	"r2 = r10;"			\
+	"r2 += -48;"			\
+	"r3 = %[sizeof_bpf_sock_tuple];"\
+	"r4 = 0;"			\
+	"r5 = 0;"			\
+	"call %[" #func "];"
+
+struct bpf_key {} __attribute__((preserve_access_index));
+
+extern void bpf_key_put(struct bpf_key *key) __ksym;
+extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+
+/* BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void __kfunc_btf_root(void)
+{
+	bpf_key_put(0);
+	bpf_lookup_system_key(0);
+	bpf_lookup_user_key(0, 0);
+}
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+void dummy_prog_42_tc(void);
+void dummy_prog_24_tc(void);
+void dummy_prog_loop1_tc(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 4);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog1_tc SEC(".maps") = {
+	.values = {
+		[0] = (void *)&dummy_prog_42_tc,
+		[1] = (void *)&dummy_prog_loop1_tc,
+		[2] = (void *)&dummy_prog_24_tc,
+	},
+};
+
+SEC("tc")
+__auxiliary
+__naked void dummy_prog_42_tc(void)
+{
+	asm volatile ("r0 = 42; exit;");
+}
+
+SEC("tc")
+__auxiliary
+__naked void dummy_prog_24_tc(void)
+{
+	asm volatile ("r0 = 24; exit;");
+}
+
+SEC("tc")
+__auxiliary
+__naked void dummy_prog_loop1_tc(void)
+{
+	asm volatile ("			\
+	r3 = 1;				\
+	r2 = %[map_prog1_tc] ll;	\
+	call %[bpf_tail_call];		\
+	r0 = 41;			\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_tc)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak potential reference")
+__failure __msg("Unreleased reference")
+__naked void reference_tracking_leak_potential_reference(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;		/* leak reference */	\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak potential reference to sock_common")
+__failure __msg("Unreleased reference")
+__naked void potential_reference_to_sock_common_1(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_skc_lookup_tcp)
+"	r6 = r0;		/* leak reference */	\
+	exit;						\
+"	:
+	: __imm(bpf_skc_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak potential reference on stack")
+__failure __msg("Unreleased reference")
+__naked void leak_potential_reference_on_stack(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r4 = r10;					\
+	r4 += -8;					\
+	*(u64*)(r4 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak potential reference on stack 2")
+__failure __msg("Unreleased reference")
+__naked void potential_reference_on_stack_2(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r4 = r10;					\
+	r4 += -8;					\
+	*(u64*)(r4 + 0) = r0;				\
+	r0 = 0;						\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: zero potential reference")
+__failure __msg("Unreleased reference")
+__naked void reference_tracking_zero_potential_reference(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r0 = 0;			/* leak reference */	\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: zero potential reference to sock_common")
+__failure __msg("Unreleased reference")
+__naked void potential_reference_to_sock_common_2(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_skc_lookup_tcp)
+"	r0 = 0;			/* leak reference */	\
+	exit;						\
+"	:
+	: __imm(bpf_skc_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: copy and zero potential references")
+__failure __msg("Unreleased reference")
+__naked void copy_and_zero_potential_references(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r7 = r0;					\
+	r0 = 0;						\
+	r7 = 0;			/* leak reference */	\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: acquire/release user key reference")
+__success
+__naked void acquire_release_user_key_reference(void)
+{
+	asm volatile ("					\
+	r1 = -3;					\
+	r2 = 0;						\
+	call %[bpf_lookup_user_key];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_key_put];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_key_put),
+	  __imm(bpf_lookup_user_key)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: acquire/release system key reference")
+__success
+__naked void acquire_release_system_key_reference(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	call %[bpf_lookup_system_key];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_key_put];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_key_put),
+	  __imm(bpf_lookup_system_key)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: release user key reference without check")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__naked void user_key_reference_without_check(void)
+{
+	asm volatile ("					\
+	r1 = -3;					\
+	r2 = 0;						\
+	call %[bpf_lookup_user_key];			\
+	r1 = r0;					\
+	call %[bpf_key_put];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_key_put),
+	  __imm(bpf_lookup_user_key)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: release system key reference without check")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__naked void system_key_reference_without_check(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	call %[bpf_lookup_system_key];			\
+	r1 = r0;					\
+	call %[bpf_key_put];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_key_put),
+	  __imm(bpf_lookup_system_key)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: release with NULL key pointer")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__naked void release_with_null_key_pointer(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call %[bpf_key_put];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_key_put)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: leak potential reference to user key")
+__failure __msg("Unreleased reference")
+__naked void potential_reference_to_user_key(void)
+{
+	asm volatile ("					\
+	r1 = -3;					\
+	r2 = 0;						\
+	call %[bpf_lookup_user_key];			\
+	exit;						\
+"	:
+	: __imm(bpf_lookup_user_key)
+	: __clobber_all);
+}
+
+SEC("lsm.s/bpf")
+__description("reference tracking: leak potential reference to system key")
+__failure __msg("Unreleased reference")
+__naked void potential_reference_to_system_key(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	call %[bpf_lookup_system_key];			\
+	exit;						\
+"	:
+	: __imm(bpf_lookup_system_key)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference without check")
+__failure __msg("type=sock_or_null expected=sock")
+__naked void tracking_release_reference_without_check(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	/* reference in r0 may be NULL */		\
+	r1 = r0;					\
+	r2 = 0;						\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference to sock_common without check")
+__failure __msg("type=sock_common_or_null expected=sock")
+__naked void to_sock_common_without_check(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_skc_lookup_tcp)
+"	/* reference in r0 may be NULL */		\
+	r1 = r0;					\
+	r2 = 0;						\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_release),
+	  __imm(bpf_skc_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference")
+__success __retval(0)
+__naked void reference_tracking_release_reference(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference to sock_common")
+__success __retval(0)
+__naked void release_reference_to_sock_common(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_skc_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_release),
+	  __imm(bpf_skc_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference 2")
+__success __retval(0)
+__naked void reference_tracking_release_reference_2(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference twice")
+__failure __msg("type=scalar expected=sock")
+__naked void reference_tracking_release_reference_twice(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	r6 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference twice inside branch")
+__failure __msg("type=scalar expected=sock")
+__naked void release_reference_twice_inside_branch(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	r6 = r0;					\
+	if r0 == 0 goto l0_%=;		/* goto end */	\
+	call %[bpf_sk_release];				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: alloc, check, free in one subbranch")
+__failure __msg("Unreleased reference")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void check_free_in_one_subbranch(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 16;					\
+	/* if (offsetof(skb, mark) > data_len) exit; */	\
+	if r0 <= r3 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = *(u32*)(r2 + %[__sk_buff_mark]);		\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r6 == 0 goto l1_%=;		/* mark == 0? */\
+	/* Leak reference in R0 */			\
+	exit;						\
+l1_%=:	if r0 == 0 goto l2_%=;		/* sk NULL? */	\
+	r1 = r0;					\
+	call %[bpf_sk_release];				\
+l2_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: alloc, check, free in both subbranches")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void check_free_in_both_subbranches(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 16;					\
+	/* if (offsetof(skb, mark) > data_len) exit; */	\
+	if r0 <= r3 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = *(u32*)(r2 + %[__sk_buff_mark]);		\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r6 == 0 goto l1_%=;		/* mark == 0? */\
+	if r0 == 0 goto l2_%=;		/* sk NULL? */	\
+	r1 = r0;					\
+	call %[bpf_sk_release];				\
+l2_%=:	exit;						\
+l1_%=:	if r0 == 0 goto l3_%=;		/* sk NULL? */	\
+	r1 = r0;					\
+	call %[bpf_sk_release];				\
+l3_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: free reference in subprog")
+__success __retval(0)
+__naked void call_free_reference_in_subprog(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;	/* unchecked reference */	\
+	call call_free_reference_in_subprog__1;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void call_free_reference_in_subprog__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+	r2 = r1;					\
+	if r2 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_release)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: free reference in subprog and outside")
+__failure __msg("type=scalar expected=sock")
+__naked void reference_in_subprog_and_outside(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;	/* unchecked reference */	\
+	r6 = r0;					\
+	call reference_in_subprog_and_outside__1;	\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void reference_in_subprog_and_outside__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+	r2 = r1;					\
+	if r2 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_release)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: alloc & leak reference in subprog")
+__failure __msg("Unreleased reference")
+__naked void alloc_leak_reference_in_subprog(void)
+{
+	asm volatile ("					\
+	r4 = r10;					\
+	r4 += -8;					\
+	call alloc_leak_reference_in_subprog__1;	\
+	r1 = r0;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void alloc_leak_reference_in_subprog__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+	r6 = r4;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	/* spill unchecked sk_ptr into stack of caller */\
+	*(u64*)(r6 + 0) = r0;				\
+	r1 = r0;					\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: alloc in subprog, release outside")
+__success __retval(POINTER_VALUE)
+__naked void alloc_in_subprog_release_outside(void)
+{
+	asm volatile ("					\
+	r4 = r10;					\
+	call alloc_in_subprog_release_outside__1;	\
+	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_release)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void alloc_in_subprog_release_outside__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	exit;				/* return sk */	\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: sk_ptr leak into caller stack")
+__failure __msg("Unreleased reference")
+__naked void ptr_leak_into_caller_stack(void)
+{
+	asm volatile ("					\
+	r4 = r10;					\
+	r4 += -8;					\
+	call ptr_leak_into_caller_stack__1;		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void ptr_leak_into_caller_stack__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+	r5 = r10;					\
+	r5 += -8;					\
+	*(u64*)(r5 + 0) = r4;				\
+	call ptr_leak_into_caller_stack__2;		\
+	/* spill unchecked sk_ptr into stack of caller */\
+	r5 = r10;					\
+	r5 += -8;					\
+	r4 = *(u64*)(r5 + 0);				\
+	*(u64*)(r4 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void ptr_leak_into_caller_stack__2(void)
+{
+	asm volatile ("					\
+	/* subprog 2 */					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking in call: sk_ptr spill into caller stack")
+__success __retval(0)
+__naked void ptr_spill_into_caller_stack(void)
+{
+	asm volatile ("					\
+	r4 = r10;					\
+	r4 += -8;					\
+	call ptr_spill_into_caller_stack__1;		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void ptr_spill_into_caller_stack__1(void)
+{
+	asm volatile ("					\
+	/* subprog 1 */					\
+	r5 = r10;					\
+	r5 += -8;					\
+	*(u64*)(r5 + 0) = r4;				\
+	call ptr_spill_into_caller_stack__2;		\
+	/* spill unchecked sk_ptr into stack of caller */\
+	r5 = r10;					\
+	r5 += -8;					\
+	r4 = *(u64*)(r5 + 0);				\
+	*(u64*)(r4 + 0) = r0;				\
+	if r0 == 0 goto l0_%=;				\
+	/* now the sk_ptr is verified, free the reference */\
+	r1 = *(u64*)(r4 + 0);				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_release)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void ptr_spill_into_caller_stack__2(void)
+{
+	asm volatile ("					\
+	/* subprog 2 */					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: allow LD_ABS")
+__success __retval(0)
+__naked void reference_tracking_allow_ld_abs(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	r0 = *(u8*)skb[0];				\
+	r0 = *(u16*)skb[0];				\
+	r0 = *(u32*)skb[0];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: forbid LD_ABS while holding reference")
+__failure __msg("BPF_LD_[ABS|IND] cannot be mixed with socket references")
+__naked void ld_abs_while_holding_reference(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r0 = *(u8*)skb[0];				\
+	r0 = *(u16*)skb[0];				\
+	r0 = *(u32*)skb[0];				\
+	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: allow LD_IND")
+__success __retval(1)
+__naked void reference_tracking_allow_ld_ind(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	r7 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r7;					\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple)),
+	  __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: forbid LD_IND while holding reference")
+__failure __msg("BPF_LD_[ABS|IND] cannot be mixed with socket references")
+__naked void ld_ind_while_holding_reference(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r4 = r0;					\
+	r7 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r7;					\
+	r1 = r4;					\
+	if r1 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple)),
+	  __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: check reference or tail call")
+__success __retval(0)
+__naked void check_reference_or_tail_call(void)
+{
+	asm volatile ("					\
+	r7 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	/* if (sk) bpf_sk_release() */			\
+	r1 = r0;					\
+	if r1 != 0 goto l0_%=;				\
+	/* bpf_tail_call() */				\
+	r3 = 3;						\
+	r2 = %[map_prog1_tc] ll;			\
+	r1 = r7;					\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_tc),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: release reference then tail call")
+__success __retval(0)
+__naked void release_reference_then_tail_call(void)
+{
+	asm volatile ("					\
+	r7 = r1;					\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	/* if (sk) bpf_sk_release() */			\
+	r1 = r0;					\
+	if r1 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	/* bpf_tail_call() */				\
+	r3 = 3;						\
+	r2 = %[map_prog1_tc] ll;			\
+	r1 = r7;					\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_tc),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak possible reference over tail call")
+__failure __msg("tail_call would lead to reference leak")
+__naked void possible_reference_over_tail_call(void)
+{
+	asm volatile ("					\
+	r7 = r1;					\
+	/* Look up socket and store in REG_6 */		\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	/* bpf_tail_call() */				\
+	r6 = r0;					\
+	r3 = 3;						\
+	r2 = %[map_prog1_tc] ll;			\
+	r1 = r7;					\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	/* if (sk) bpf_sk_release() */			\
+	r1 = r6;					\
+	if r1 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_tc),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: leak checked reference over tail call")
+__failure __msg("tail_call would lead to reference leak")
+__naked void checked_reference_over_tail_call(void)
+{
+	asm volatile ("					\
+	r7 = r1;					\
+	/* Look up socket and store in REG_6 */		\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	/* if (!sk) goto end */				\
+	if r0 == 0 goto l0_%=;				\
+	/* bpf_tail_call() */				\
+	r3 = 0;						\
+	r2 = %[map_prog1_tc] ll;			\
+	r1 = r7;					\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	r1 = r6;					\
+l0_%=:	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_tc),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: mangle and release sock_or_null")
+__failure __msg("R1 pointer arithmetic on sock_or_null prohibited")
+__naked void and_release_sock_or_null(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	r1 += 5;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: mangle and release sock")
+__failure __msg("R1 pointer arithmetic on sock prohibited")
+__naked void tracking_mangle_and_release_sock(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 += 5;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: access member")
+__success __retval(0)
+__naked void reference_tracking_access_member(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r2 = *(u32*)(r0 + 4);				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: write to member")
+__failure __msg("cannot write into sock")
+__naked void reference_tracking_write_to_member(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 42 ll;					\
+	*(u32*)(r1 + %[bpf_sock_mark]) = r2;		\
+	r1 = r6;					\
+l0_%=:	call %[bpf_sk_release];				\
+	r0 = 0 ll;					\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_mark, offsetof(struct bpf_sock, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: invalid 64-bit access of member")
+__failure __msg("invalid sock access off=0 size=8")
+__naked void _64_bit_access_of_member(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r2 = *(u64*)(r0 + 0);				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: access after release")
+__failure __msg("!read_ok")
+__naked void reference_tracking_access_after_release(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r1 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+	r2 = *(u32*)(r1 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: direct access for lookup")
+__success __retval(0)
+__naked void tracking_direct_access_for_lookup(void)
+{
+	asm volatile ("					\
+	/* Check that the packet is at least 64B long */\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 64;					\
+	if r0 > r3 goto l0_%=;				\
+	/* sk = sk_lookup_tcp(ctx, skb->data, ...) */	\
+	r3 = %[sizeof_bpf_sock_tuple];			\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_sk_lookup_tcp];			\
+	r6 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r2 = *(u32*)(r0 + 4);				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use ptr from bpf_tcp_sock() after release")
+__failure __msg("invalid mem access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void bpf_tcp_sock_after_release(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r7 = r0;					\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u32*)(r7 + %[bpf_tcp_sock_snd_cwnd]);	\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(bpf_tcp_sock_snd_cwnd, offsetof(struct bpf_tcp_sock, snd_cwnd)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use ptr from bpf_sk_fullsock() after release")
+__failure __msg("invalid mem access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void bpf_sk_fullsock_after_release(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r7 = r0;					\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use ptr from bpf_sk_fullsock(tp) after release")
+__failure __msg("invalid mem access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void sk_fullsock_tp_after_release(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_fullsock];			\
+	r1 = r6;					\
+	r6 = r0;					\
+	call %[bpf_sk_release];				\
+	if r6 != 0 goto l2_%=;				\
+	exit;						\
+l2_%=:	r0 = *(u32*)(r6 + %[bpf_sock_type]);		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use sk after bpf_sk_release(tp)")
+__failure __msg("invalid mem access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void after_bpf_sk_release_tp(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u32*)(r6 + %[bpf_sock_type]);		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use ptr from bpf_get_listener_sock() after bpf_sk_release(sk)")
+__success __retval(0)
+__naked void after_bpf_sk_release_sk(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_get_listener_sock];			\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r1 = r6;					\
+	r6 = r0;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u32*)(r6 + %[bpf_sock_src_port]);	\
+	exit;						\
+"	:
+	: __imm(bpf_get_listener_sock),
+	  __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_src_port, offsetof(struct bpf_sock, src_port)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: bpf_sk_release(listen_sk)")
+__failure __msg("R1 must be referenced when passed to release function")
+__naked void bpf_sk_release_listen_sk(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_get_listener_sock];			\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u32*)(r6 + %[bpf_sock_type]);		\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_get_listener_sock),
+	  __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
+SEC("tc")
+__description("reference tracking: tp->snd_cwnd after bpf_sk_fullsock(sk) and bpf_tcp_sock(sk)")
+__failure __msg("invalid mem access")
+__naked void and_bpf_tcp_sock_sk(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	r1 = r6;					\
+	call %[bpf_tcp_sock];				\
+	r8 = r0;					\
+	if r7 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r8 + %[bpf_tcp_sock_snd_cwnd]);	\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(bpf_tcp_sock_snd_cwnd, offsetof(struct bpf_tcp_sock, snd_cwnd)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: branch tracking valid pointer null comparison")
+__success __retval(0)
+__naked void tracking_valid_pointer_null_comparison(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	r3 = 1;						\
+	if r6 != 0 goto l0_%=;				\
+	r3 = 0;						\
+l0_%=:	if r6 == 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: branch tracking valid pointer value comparison")
+__failure __msg("Unreleased reference")
+__naked void tracking_valid_pointer_value_comparison(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r6 = r0;					\
+	r3 = 1;						\
+	if r6 == 0 goto l0_%=;				\
+	r3 = 0;						\
+	if r6 == 1234 goto l0_%=;			\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: bpf_sk_release(btf_tcp_sock)")
+__success
+__retval(0)
+__naked void sk_release_btf_tcp_sock(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_skc_to_tcp_sock];			\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_skc_to_tcp_sock),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("reference tracking: use ptr from bpf_skc_to_tcp_sock() after release")
+__failure __msg("invalid mem access")
+__naked void to_tcp_sock_after_release(void)
+{
+	asm volatile (
+	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	call %[bpf_skc_to_tcp_sock];			\
+	if r0 != 0 goto l1_%=;				\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	exit;						\
+l1_%=:	r7 = r0;					\
+	r1 = r6;					\
+	call %[bpf_sk_release];				\
+	r0 = *(u8*)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm(bpf_skc_to_tcp_sock),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("reference tracking: try to leak released ptr reg")
+__success __failure_unpriv __msg_unpriv("R8 !read_ok")
+__retval(0)
+__naked void to_leak_released_ptr_reg(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u32*)(r10 - 4) = r0;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r9 = r0;					\
+	r0 = 0;						\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r8 = r0;					\
+	r1 = r8;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_discard];			\
+	r0 = 0;						\
+	*(u64*)(r9 + 0) = r8;				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
deleted file mode 100644
index 5a2e154dd1e0..000000000000
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ /dev/null
@@ -1,1082 +0,0 @@
-{
-	"reference tracking: leak potential reference",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0), /* leak reference */
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: leak potential reference to sock_common",
-	.insns = {
-	BPF_SK_LOOKUP(skc_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0), /* leak reference */
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: leak potential reference on stack",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: leak potential reference on stack 2",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: zero potential reference",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_IMM(BPF_REG_0, 0), /* leak reference */
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: zero potential reference to sock_common",
-	.insns = {
-	BPF_SK_LOOKUP(skc_lookup_tcp),
-	BPF_MOV64_IMM(BPF_REG_0, 0), /* leak reference */
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: copy and zero potential references",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_7, 0), /* leak reference */
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: acquire/release user key reference",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_user_key", 2 },
-		{ "bpf_key_put", 5 },
-	},
-	.result = ACCEPT,
-},
-{
-	"reference tracking: acquire/release system key reference",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_system_key", 1 },
-		{ "bpf_key_put", 4 },
-	},
-	.result = ACCEPT,
-},
-{
-	"reference tracking: release user key reference without check",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.errstr = "Possibly NULL pointer passed to trusted arg0",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_user_key", 2 },
-		{ "bpf_key_put", 4 },
-	},
-	.result = REJECT,
-},
-{
-	"reference tracking: release system key reference without check",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.errstr = "Possibly NULL pointer passed to trusted arg0",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_system_key", 1 },
-		{ "bpf_key_put", 3 },
-	},
-	.result = REJECT,
-},
-{
-	"reference tracking: release with NULL key pointer",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.errstr = "Possibly NULL pointer passed to trusted arg0",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_key_put", 1 },
-	},
-	.result = REJECT,
-},
-{
-	"reference tracking: leak potential reference to user key",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.errstr = "Unreleased reference",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_user_key", 2 },
-	},
-	.result = REJECT,
-},
-{
-	"reference tracking: leak potential reference to system key",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_LSM,
-	.kfunc = "bpf",
-	.expected_attach_type = BPF_LSM_MAC,
-	.flags = BPF_F_SLEEPABLE,
-	.errstr = "Unreleased reference",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_lookup_system_key", 1 },
-	},
-	.result = REJECT,
-},
-{
-	"reference tracking: release reference without check",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	/* reference in r0 may be NULL */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "type=sock_or_null expected=sock",
-	.result = REJECT,
-},
-{
-	"reference tracking: release reference to sock_common without check",
-	.insns = {
-	BPF_SK_LOOKUP(skc_lookup_tcp),
-	/* reference in r0 may be NULL */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "type=sock_common_or_null expected=sock",
-	.result = REJECT,
-},
-{
-	"reference tracking: release reference",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: release reference to sock_common",
-	.insns = {
-	BPF_SK_LOOKUP(skc_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: release reference 2",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: release reference twice",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "type=scalar expected=sock",
-	.result = REJECT,
-},
-{
-	"reference tracking: release reference twice inside branch",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3), /* goto end */
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "type=scalar expected=sock",
-	.result = REJECT,
-},
-{
-	"reference tracking: alloc, check, free in one subbranch",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 16),
-	/* if (offsetof(skb, mark) > data_len) exit; */
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1), /* mark == 0? */
-	/* Leak reference in R0 */
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking: alloc, check, free in both subbranches",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 16),
-	/* if (offsetof(skb, mark) > data_len) exit; */
-	BPF_JMP_REG(BPF_JLE, BPF_REG_0, BPF_REG_3, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 4), /* mark == 0? */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking in call: free reference in subprog",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking in call: free reference in subprog and outside",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "type=scalar expected=sock",
-	.result = REJECT,
-},
-{
-	"reference tracking in call: alloc & leak reference in subprog",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_4),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	/* spill unchecked sk_ptr into stack of caller */
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking in call: alloc in subprog, release outside",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_EXIT_INSN(), /* return sk */
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = POINTER_VALUE,
-	.result = ACCEPT,
-},
-{
-	"reference tracking in call: sk_ptr leak into caller stack",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
-	/* spill unchecked sk_ptr into stack of caller */
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_5, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	/* subprog 2 */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking in call: sk_ptr spill into caller stack",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	/* subprog 1 */
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 8),
-	/* spill unchecked sk_ptr into stack of caller */
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_5, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	/* now the sk_ptr is verified, free the reference */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_4, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-
-	/* subprog 2 */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: allow LD_ABS",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LD_ABS(BPF_B, 0),
-	BPF_LD_ABS(BPF_H, 0),
-	BPF_LD_ABS(BPF_W, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: forbid LD_ABS while holding reference",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_LD_ABS(BPF_B, 0),
-	BPF_LD_ABS(BPF_H, 0),
-	BPF_LD_ABS(BPF_W, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "BPF_LD_[ABS|IND] cannot be mixed with socket references",
-	.result = REJECT,
-},
-{
-	"reference tracking: allow LD_IND",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_7, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"reference tracking: forbid LD_IND while holding reference",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_7, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "BPF_LD_[ABS|IND] cannot be mixed with socket references",
-	.result = REJECT,
-},
-{
-	"reference tracking: check reference or tail call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	/* if (sk) bpf_sk_release() */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 7),
-	/* bpf_tail_call() */
-	BPF_MOV64_IMM(BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 17 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: release reference then tail call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	/* if (sk) bpf_sk_release() */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	/* bpf_tail_call() */
-	BPF_MOV64_IMM(BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 18 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: leak possible reference over tail call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	/* Look up socket and store in REG_6 */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	/* bpf_tail_call() */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	/* if (sk) bpf_sk_release() */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 16 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "tail_call would lead to reference leak",
-	.result = REJECT,
-},
-{
-	"reference tracking: leak checked reference over tail call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	/* Look up socket and store in REG_6 */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* if (!sk) goto end */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	/* bpf_tail_call() */
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 17 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "tail_call would lead to reference leak",
-	.result = REJECT,
-},
-{
-	"reference tracking: mangle and release sock_or_null",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "R1 pointer arithmetic on sock_or_null prohibited",
-	.result = REJECT,
-},
-{
-	"reference tracking: mangle and release sock",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "R1 pointer arithmetic on sock prohibited",
-	.result = REJECT,
-},
-{
-	"reference tracking: access member",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: write to member",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_LD_IMM64(BPF_REG_2, 42),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2,
-		    offsetof(struct bpf_sock, mark)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LD_IMM64(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "cannot write into sock",
-	.result = REJECT,
-},
-{
-	"reference tracking: invalid 64-bit access of member",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "invalid sock access off=0 size=8",
-	.result = REJECT,
-},
-{
-	"reference tracking: access after release",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "!read_ok",
-	.result = REJECT,
-},
-{
-	"reference tracking: direct access for lookup",
-	.insns = {
-	/* Check that the packet is at least 64B long */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 64),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
-	/* sk = sk_lookup_tcp(ctx, skb->data, ...) */
-	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct bpf_sock_tuple)),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: use ptr from bpf_tcp_sock() after release",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_tcp_sock, snd_cwnd)),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking: use ptr from bpf_sk_fullsock() after release",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking: use ptr from bpf_sk_fullsock(tp) after release",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, offsetof(struct bpf_sock, type)),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking: use sk after bpf_sk_release(tp)",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, offsetof(struct bpf_sock, type)),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"reference tracking: use ptr from bpf_get_listener_sock() after bpf_sk_release(sk)",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_listener_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, offsetof(struct bpf_sock, src_port)),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: bpf_sk_release(listen_sk)",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_listener_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, offsetof(struct bpf_sock, type)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "R1 must be referenced when passed to release function",
-},
-{
-	/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
-	"reference tracking: tp->snd_cwnd after bpf_sk_fullsock(sk) and bpf_tcp_sock(sk)",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_8, offsetof(struct bpf_tcp_sock, snd_cwnd)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-},
-{
-	"reference tracking: branch tracking valid pointer null comparison",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"reference tracking: branch tracking valid pointer value comparison",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 1234, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "Unreleased reference",
-	.result = REJECT,
-},
-{
-	"reference tracking: bpf_sk_release(btf_tcp_sock)",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "unknown func",
-},
-{
-	"reference tracking: use ptr from bpf_skc_to_tcp_sock() after release",
-	.insns = {
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "unknown func",
-},
-{
-	"reference tracking: try to leak released ptr reg",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-		BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_MOV64_IMM(BPF_REG_2, 8),
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-		BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_EMIT_CALL(BPF_FUNC_ringbuf_discard),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-
-		BPF_STX_MEM(BPF_DW, BPF_REG_9, BPF_REG_8, 0),
-		BPF_EXIT_INSN()
-	},
-	.fixup_map_array_48b = { 4 },
-	.fixup_map_ringbuf = { 11 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R8 !read_ok"
-},
-- 
2.40.0

