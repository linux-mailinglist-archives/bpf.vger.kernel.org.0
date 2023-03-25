Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0D6C8A70
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjCYC4a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYC43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAA1ADFA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so2093043wmr.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBDbn7tGP1SUZfbRNNiRXWBj71K6/BcDGvYH+3Q/RXE=;
        b=K/CROrnIYqlvV3NZSUjLevS5fz2CBoilSf58tP3iS7aZ3729D8neZ3dkVlJKfxdTFf
         /MBMn5PD20ctlbvjTzFHiMHECS2wTp4ug/Gc8Pso8xo1NGdaSH0cuJgu0JQq+a4e/PlC
         CYUilbpDoLJutg9FGchAc3A6puX4gXkSn5GBr65SQnIjtf8bhKiYm1b/lCp7CXyWw3/o
         Caq0LrZw85clMrVapiKekCrRNxEB6/yhGI0wUjqJrWIjq5zkV6qjidKTVigoXKHdcfnA
         SneoUjAM9UiitlJS0yAeXrNTrM5n/vqEnmQHT/XAjpagF/2XbNjbGbN1kXQbDKteztsS
         KoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBDbn7tGP1SUZfbRNNiRXWBj71K6/BcDGvYH+3Q/RXE=;
        b=E3Kc+sC4uMMk0Fh/lInJzN9L3lGe7uonhCN+kZA0yWXncLCjo6koDA1aCsax+53hQM
         ZPQ2khvAUKJ80LjAANKsvRE+qAdXRPJQPt5UxA6KV+D8BVdVfVqgQJr7CtvzjzEgQEHg
         kjjJmN82C42EVJlxOkOpBb2SQQHXnv2qhdtRX2UITKEOcxWNg/INhAPPd12AvIQy+BQK
         Bo711+qOT7iqhHtjGzHEWqWh+6/B0XugziwYsjR8xFiEQvHUb5pwbSy8YDlxNzhAycpE
         jd0tFEBU/vV02BlWQ3F75EHVdh7IVV47p0VY3PIQ/7vpL7G8hqiECPBtzkud74kiGznp
         x6bg==
X-Gm-Message-State: AO0yUKWEBvnZdD7E/ILBJByneDgSR8L6OYC8GK7Y8RG8VtsVWQUvejKj
        7cxC96kCBYqb7eIh1gv8z5yhEvxNxMY=
X-Google-Smtp-Source: AK7set/SCYp+l0dCPZXjueF8pchePM9q19cHftHYLQvQXrMij30pQBNfJXNf4UIpHNXwtCAHDIDshQ==
X-Received: by 2002:a05:600c:2101:b0:3ee:7e12:f50 with SMTP id u1-20020a05600c210100b003ee7e120f50mr3633017wml.8.1679712984110;
        Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:23 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 22/43] selftests/bpf: verifier/helper_restricted.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:03 +0200
Message-Id: <20230325025524.144043-23-eddyz87@gmail.com>
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

Test verifier/helper_restricted.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_helper_restricted.c    | 279 ++++++++++++++++++
 .../bpf/verifier/helper_restricted.c          | 196 ------------
 3 files changed, 281 insertions(+), 196 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_restricted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 1cd162daf150..02983d1de218 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -19,6 +19,7 @@
 #include "verifier_div_overflow.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
+#include "verifier_helper_restricted.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -60,3 +61,4 @@ void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
+void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
new file mode 100644
index 000000000000..0ede0ccd090c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/helper_restricted.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct val {
+	int cnt;
+	struct bpf_spin_lock l;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct val);
+} map_spin_lock SEC(".maps");
+
+struct timer {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer);
+} map_timer SEC(".maps");
+
+SEC("kprobe")
+__description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
+__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__naked void in_bpf_prog_type_kprobe_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_coarse_ns];		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_coarse_ns)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_TRACEPOINT")
+__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__naked void in_bpf_prog_type_tracepoint_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_coarse_ns];		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_coarse_ns)
+	: __clobber_all);
+}
+
+SEC("perf_event")
+__description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_PERF_EVENT")
+__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__naked void bpf_prog_type_perf_event_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_coarse_ns];		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_coarse_ns)
+	: __clobber_all);
+}
+
+SEC("raw_tracepoint")
+__description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
+__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__naked void bpf_prog_type_raw_tracepoint_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_coarse_ns];		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_coarse_ns)
+	: __clobber_all);
+}
+
+SEC("kprobe")
+__description("bpf_timer_init isn restricted in BPF_PROG_TYPE_KPROBE")
+__failure __msg("tracing progs cannot use bpf_timer yet")
+__naked void in_bpf_prog_type_kprobe_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_timer] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[map_timer] ll;				\
+	r3 = 1;						\
+l0_%=:	call %[bpf_timer_init];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_timer_init),
+	  __imm_addr(map_timer)
+	: __clobber_all);
+}
+
+SEC("perf_event")
+__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_PERF_EVENT")
+__failure __msg("tracing progs cannot use bpf_timer yet")
+__naked void bpf_prog_type_perf_event_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_timer] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[map_timer] ll;				\
+	r3 = 1;						\
+l0_%=:	call %[bpf_timer_init];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_timer_init),
+	  __imm_addr(map_timer)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_TRACEPOINT")
+__failure __msg("tracing progs cannot use bpf_timer yet")
+__naked void in_bpf_prog_type_tracepoint_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_timer] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[map_timer] ll;				\
+	r3 = 1;						\
+l0_%=:	call %[bpf_timer_init];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_timer_init),
+	  __imm_addr(map_timer)
+	: __clobber_all);
+}
+
+SEC("raw_tracepoint")
+__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
+__failure __msg("tracing progs cannot use bpf_timer yet")
+__naked void bpf_prog_type_raw_tracepoint_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_timer] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[map_timer] ll;				\
+	r3 = 1;						\
+l0_%=:	call %[bpf_timer_init];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_timer_init),
+	  __imm_addr(map_timer)
+	: __clobber_all);
+}
+
+SEC("kprobe")
+__description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_KPROBE")
+__failure __msg("tracing progs cannot use bpf_spin_lock yet")
+__naked void in_bpf_prog_type_kprobe_3(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_spin_lock];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_TRACEPOINT")
+__failure __msg("tracing progs cannot use bpf_spin_lock yet")
+__naked void in_bpf_prog_type_tracepoint_3(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_spin_lock];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("perf_event")
+__description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_PERF_EVENT")
+__failure __msg("tracing progs cannot use bpf_spin_lock yet")
+__naked void bpf_prog_type_perf_event_3(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_spin_lock];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("raw_tracepoint")
+__description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
+__failure __msg("tracing progs cannot use bpf_spin_lock yet")
+__naked void bpf_prog_type_raw_tracepoint_3(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	call %[bpf_spin_lock];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/helper_restricted.c b/tools/testing/selftests/bpf/verifier/helper_restricted.c
deleted file mode 100644
index a067b7098b97..000000000000
--- a/tools/testing/selftests/bpf/verifier/helper_restricted.c
+++ /dev/null
@@ -1,196 +0,0 @@
-{
-	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE",
-	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.errstr = "unknown func bpf_ktime_get_coarse_ns",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_KPROBE,
-},
-{
-	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_TRACEPOINT",
-	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.errstr = "unknown func bpf_ktime_get_coarse_ns",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_PERF_EVENT",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unknown func bpf_ktime_get_coarse_ns",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
-},
-{
-	"bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ktime_get_coarse_ns),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unknown func bpf_ktime_get_coarse_ns",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT,
-},
-{
-	"bpf_timer_init isn restricted in BPF_PROG_TYPE_KPROBE",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_EMIT_CALL(BPF_FUNC_timer_init),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_timer = { 3, 8 },
-	.errstr = "tracing progs cannot use bpf_timer yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_KPROBE,
-},
-{
-	"bpf_timer_init is forbidden in BPF_PROG_TYPE_PERF_EVENT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_EMIT_CALL(BPF_FUNC_timer_init),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_timer = { 3, 8 },
-	.errstr = "tracing progs cannot use bpf_timer yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
-},
-{
-	"bpf_timer_init is forbidden in BPF_PROG_TYPE_TRACEPOINT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_EMIT_CALL(BPF_FUNC_timer_init),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_timer = { 3, 8 },
-	.errstr = "tracing progs cannot use bpf_timer yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bpf_timer_init is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_EMIT_CALL(BPF_FUNC_timer_init),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_timer = { 3, 8 },
-	.errstr = "tracing progs cannot use bpf_timer yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT,
-},
-{
-	"bpf_spin_lock is forbidden in BPF_PROG_TYPE_KPROBE",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.errstr = "tracing progs cannot use bpf_spin_lock yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_KPROBE,
-},
-{
-	"bpf_spin_lock is forbidden in BPF_PROG_TYPE_TRACEPOINT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.errstr = "tracing progs cannot use bpf_spin_lock yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bpf_spin_lock is forbidden in BPF_PROG_TYPE_PERF_EVENT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.errstr = "tracing progs cannot use bpf_spin_lock yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
-},
-{
-	"bpf_spin_lock is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.errstr = "tracing progs cannot use bpf_spin_lock yet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT,
-},
-- 
2.40.0

