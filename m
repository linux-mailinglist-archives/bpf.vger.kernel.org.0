Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE57F6C8A63
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCYC4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCYC4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA1FF27
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h17so3493583wrt.8
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx21bT454QjGxQQWglnh71+G5LDkOtMkZKCrJG9Inqo=;
        b=K1a7vg7pML+hj1HCpSjU2LxJUmdLHXEMIJMp+3aCbfj6rOqrHMhRrd9tBYZfVgYEgi
         7V7OBti+XIFucsNMTdUrZ1fWBIb9t7Z9wMxcwFk0R8UD7U0r2xLCYzgnQ4DkaPmdbF9G
         2a0dcgTpBw+ylN/I1FoCBKNaJUwH3q6KnRWZsL/++z4+vJr/r2ybwqJdiVf4LJq8C98a
         O2BU3CCmYzvdCkf0xMUZ+6vKY7qU5KMvnor8oRj3uH0+G/WObNf+DvKohP5PBRex0nt0
         yXxA6NyT17QziV+bqtoS5SxF66fgax1Dsa+mceS3/OxJF6XUtisUJXQxQ597tY31Udy5
         MI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx21bT454QjGxQQWglnh71+G5LDkOtMkZKCrJG9Inqo=;
        b=gjmo8uUoXMuE17QpzB5LJTpiqgxiJEttyRoSBNwOqLpiGtQEGiEgBU9TdwqjkUmjK9
         2X47s3/kNZLPPL348kRsxR/w5CfHWh+d/H+UMi5PExkBD66aEDDisGDxyRS8ma7KbepB
         BfQ7ITcnISD9hd4PG5KiejnR7GQPOQKCs301nQQ8YqiiUy6HLzw8/QM61ZaIC6utPIGk
         XDW6LHrIMy/Is7uYwUkqyr+suCK6GIYwZQJCOHxx7ccf1sCKPbCemZQ6900u/xYQEz+S
         Tp+87H6UtVMtDwzOEZQJ2Gvx4zcgL7qqOSHS028sXy1MEtn5t7tBLZZ0sMT937+ke580
         UOlg==
X-Gm-Message-State: AAQBX9ffcM2U85kT2Oyrei51F3H2fTuYIItQO0Nev74F3WBB7jMNlO4T
        4Cq3CqeFiGnRINnSMQya/HCSDG4zzTM=
X-Google-Smtp-Source: AKy350acsA9/ZhWvwSrWCZxqzGq5oXvNzqfCrJsH9aCmDKIrAp/qr7BSPnMoGLlI6S9t57SKrIwOBQ==
X-Received: by 2002:adf:edc8:0:b0:2ce:aa69:c9a7 with SMTP id v8-20020adfedc8000000b002ceaa69c9a7mr3989018wro.8.1679712962356;
        Fri, 24 Mar 2023 19:56:02 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 07/43] selftests/bpf: verifier/array_access.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:48 +0200
Message-Id: <20230325025524.144043-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/array_access.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_array_access.c         | 529 ++++++++++++++++++
 .../selftests/bpf/verifier/array_access.c     | 379 -------------
 3 files changed, 531 insertions(+), 379 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_array_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/array_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 34526f6d5ab1..60eb0f38ed92 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -4,6 +4,7 @@
 
 #include "cap_helpers.h"
 #include "verifier_and.skel.h"
+#include "verifier_array_access.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -30,3 +31,4 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes)
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
+void test_verifier_array_access(void)         { RUN(verifier_array_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
new file mode 100644
index 000000000000..95d7ecc12963
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/array_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+	__uint(map_flags, BPF_F_RDONLY_PROG);
+} map_array_ro SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+} map_array_wo SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("valid map access into an array with a constant")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void an_array_with_a_constant_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into an array with a register")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void an_array_with_a_register_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 4;						\
+	r1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into an array with a variable")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void an_array_with_a_variable_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	if r1 >= %[max_entries] goto l0_%=;		\
+	r1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(max_entries, MAX_ENTRIES),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into an array with a signed variable")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void array_with_a_signed_variable(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	if w1 s> 0xffffffff goto l1_%=;			\
+	w1 = 0;						\
+l1_%=:	w2 = %[max_entries];				\
+	if r2 s> r1 goto l2_%=;				\
+	w1 = 0;						\
+l2_%=:	w1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(max_entries, MAX_ENTRIES),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with a constant")
+__failure __msg("invalid access to map value, value_size=48 off=48 size=8")
+__failure_unpriv
+__naked void an_array_with_a_constant_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + %[__imm_0]) = r1;			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, (MAX_ENTRIES + 1) << 2),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with a register")
+__failure __msg("R0 min value is outside of the allowed memory range")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void an_array_with_a_register_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = %[__imm_0];				\
+	r1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, MAX_ENTRIES + 1),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with a variable")
+__failure
+__msg("R0 unbounded memory access, make sure to bounds check any such access")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void an_array_with_a_variable_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	r1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with no floor check")
+__failure __msg("R0 unbounded memory access")
+__failure_unpriv __msg_unpriv("R0 leaks addr")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void array_with_no_floor_check(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r0 + 0);				\
+	w2 = %[max_entries];				\
+	if r2 s> r1 goto l1_%=;				\
+	w1 = 0;						\
+l1_%=:	w1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(max_entries, MAX_ENTRIES),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with a invalid max check")
+__failure __msg("invalid access to map value, value_size=48 off=44 size=8")
+__failure_unpriv __msg_unpriv("R0 leaks addr")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void with_a_invalid_max_check_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	w2 = %[__imm_0];				\
+	if r2 > r1 goto l1_%=;				\
+	w1 = 0;						\
+l1_%=:	w1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, MAX_ENTRIES + 1),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array with a invalid max check")
+__failure __msg("R0 pointer += pointer")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void with_a_invalid_max_check_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r8 = r0;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 += r8;					\
+	r0 = *(u32*)(r0 + %[test_val_foo]);		\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid read map access into a read-only array 1")
+__success __success_unpriv __retval(28)
+__naked void a_read_only_array_1_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_ro] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_ro)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("valid read map access into a read-only array 2")
+__success __retval(65507)
+__naked void a_read_only_array_2_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_ro] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 &= 0xffff;					\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_ro)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid write map access into a read-only array 1")
+__failure __msg("write into map forbidden")
+__failure_unpriv
+__naked void a_read_only_array_1_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_ro] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 42;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_ro)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("invalid write map access into a read-only array 2")
+__failure __msg("write into map forbidden")
+__naked void a_read_only_array_2_2(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_ro] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r0;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_skb_load_bytes),
+	  __imm_addr(map_array_ro)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid write map access into a write-only array 1")
+__success __success_unpriv __retval(1)
+__naked void a_write_only_array_1_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_wo] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 42;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_wo)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("valid write map access into a write-only array 2")
+__success __retval(0)
+__naked void a_write_only_array_2_1(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_wo] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r0;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_skb_load_bytes),
+	  __imm_addr(map_array_wo)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid read map access into a write-only array 1")
+__failure __msg("read from map forbidden")
+__failure_unpriv
+__naked void a_write_only_array_1_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_wo] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 = *(u64*)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_wo)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("invalid read map access into a write-only array 2")
+__failure __msg("read from map forbidden")
+__naked void a_write_only_array_2_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_wo] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_wo)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
deleted file mode 100644
index 1b138cd2b187..000000000000
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ /dev/null
@@ -1,379 +0,0 @@
-{
-	"valid map access into an array with a constant",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"valid map access into an array with a register",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"valid map access into an array with a variable",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 3),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"valid map access into an array with a signed variable",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP32_IMM(BPF_JSGT, BPF_REG_1, 0xffffffff, 1),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid map access into an array with a constant",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, (MAX_ENTRIES + 1) << 2,
-		   offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=48 size=8",
-	.result = REJECT,
-},
-{
-	"invalid map access into an array with a register",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, MAX_ENTRIES + 1),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 min value is outside of the allowed memory range",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid map access into an array with a variable",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 unbounded memory access, make sure to bounds check any such access",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid map access into an array with no floor check",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.errstr = "R0 unbounded memory access",
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid map access into an array with a invalid max check",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES + 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.errstr = "invalid access to map value, value_size=48 off=44 size=8",
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid map access into an array with a invalid max check",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3, 11 },
-	.errstr = "R0 pointer += pointer",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"valid read map access into a read-only array 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_ro = { 3 },
-	.result = ACCEPT,
-	.retval = 28,
-},
-{
-	"valid read map access into a read-only array 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-		     BPF_FUNC_csum_diff),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_array_ro = { 3 },
-	.result = ACCEPT,
-	.retval = 65507,
-},
-{
-	"invalid write map access into a read-only array 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_ro = { 3 },
-	.result = REJECT,
-	.errstr = "write into map forbidden",
-},
-{
-	"invalid write map access into a read-only array 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-		     BPF_FUNC_skb_load_bytes),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_array_ro = { 4 },
-	.result = REJECT,
-	.errstr = "write into map forbidden",
-},
-{
-	"valid write map access into a write-only array 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_wo = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"valid write map access into a write-only array 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-		     BPF_FUNC_skb_load_bytes),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_array_wo = { 4 },
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"invalid read map access into a write-only array 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_wo = { 3 },
-	.result = REJECT,
-	.errstr = "read from map forbidden",
-},
-{
-	"invalid read map access into a write-only array 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-		     BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_array_wo = { 3 },
-	.result = REJECT,
-	.errstr = "read from map forbidden",
-},
-- 
2.40.0

