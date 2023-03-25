Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774996C8A75
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCYC4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCYC4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857D1ADEF
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so3829082wmq.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCIIAC2jyon+d87iqHfdqYT4l6Gflhiku2BAZbmg87U=;
        b=EOdnvhfz1bCWNg09mVzblWUuzW51Qd1Ycagk+hMhW0njW6m6dnQsmmdTGT6OoQTVdh
         udGRp4hUZ6Fn/LFSxDgTYOV62nGbF/C522VAaAfDq0Ks3W9tMld9z2Qao4djiXnCR/bw
         Kgw7OwzISGyVaU4XATLAs23PPaHrbj37KH67iOdP5XrEugMYqMFnrMEJgzwCd2JnbfkE
         5mb9gFml35tp/YJRA4bhEjxCGb6eQNRu3SQ2RWp+eh5PR+dIoCO3HVat329B40sXCior
         +PqU3UnC6lMVK1F66EEU7fC6HlSsQmpkptoD848jCwMzYaC0L0wtb13+iAfgVfWJ/v+B
         TLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCIIAC2jyon+d87iqHfdqYT4l6Gflhiku2BAZbmg87U=;
        b=DY6aRsxypABEg8nTDC9lycanofQoEkeYZpN7FWmDw1MOgjENK7sb2Vdg23ke9nB1XD
         QeD5dFirvI08MdHJ3ZPhO/SS3Twf4xTJtEUaW2cc6hdft3HYp9kjTGzemhhhcaXxVThl
         JmuXP1Y8JtypTEdpFCxPZIH4LdM0eV5Q9wj84+RWUU0hcLwmTu/s7KHVnGG4EvUrfOVn
         MfiVwaBMQabQqlH0AiuaobSNU+7G8shm1/u9hIrGVHYokmHXTJ4eXA+vLLkFXsADe9Jm
         TiOFECW6UORc1RHw9szfa12DYSiXljwAOaXp3IXSJDhlqNMTPluBgC6tPA+SriKsbZfD
         lmKg==
X-Gm-Message-State: AO0yUKUuUrmuIuYY2ncM2rPytM3vECr/p2B09rFt4MqvFE48qkUeVHgT
        AnkiCu7vOKfW2mMtDHEiL56HA6rg6pE=
X-Google-Smtp-Source: AK7set8D7ubyYyIsgsfYYOpnFiOq0PKd+ENJDmv9X25NfpT4Z4e1cqZeTUz04TLar0V7zca5XS5J5Q==
X-Received: by 2002:a05:600c:1c29:b0:3ed:de03:7f0a with SMTP id j41-20020a05600c1c2900b003edde037f0amr6784670wms.10.1679712990500;
        Fri, 24 Mar 2023 19:56:30 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:30 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 27/43] selftests/bpf: verifier/map_ptr.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:08 +0200
Message-Id: <20230325025524.144043-28-eddyz87@gmail.com>
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

Test verifier/map_ptr.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_map_ptr.c    | 159 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  99 -----------
 3 files changed, 161 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f8b3b6beba3f..d2f3bff0e942 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -24,6 +24,7 @@
 #include "verifier_int_ptr.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_leak_ptr.skel.h"
+#include "verifier_map_ptr.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -70,3 +71,4 @@ void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
+void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
new file mode 100644
index 000000000000..11a079145966
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/map_ptr.c */
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
+} map_array_48b SEC(".maps");
+
+struct other_val {
+	long long foo;
+	long long bar;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct other_val);
+} map_hash_16b SEC(".maps");
+
+SEC("socket")
+__description("bpf_map_ptr: read with negative offset rejected")
+__failure __msg("R1 is bpf_array invalid negative access: off=-8")
+__failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__naked void read_with_negative_offset_rejected(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 = %[map_array_48b] ll;			\
+	r6 = *(u64*)(r1 - 8);				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bpf_map_ptr: write rejected")
+__failure __msg("only read from bpf_array is supported")
+__failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__naked void bpf_map_ptr_write_rejected(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	*(u64*)(r1 + 0) = r2;				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bpf_map_ptr: read non-existent field rejected")
+__failure
+__msg("cannot access ptr member ops with moff 0 in struct bpf_map with off 1 size 4")
+__failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void read_non_existent_field_rejected(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+	r1 = %[map_array_48b] ll;			\
+	r6 = *(u32*)(r1 + 1);				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bpf_map_ptr: read ops field accepted")
+__success __failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__retval(1)
+__naked void ptr_read_ops_field_accepted(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+	r1 = %[map_array_48b] ll;			\
+	r6 = *(u64*)(r1 + 0);				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bpf_map_ptr: r = 0, map_ptr = map_ptr + r")
+__success __failure_unpriv
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__retval(0)
+__naked void map_ptr_map_ptr_r(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r0 = 0;						\
+	r1 = %[map_hash_16b] ll;			\
+	r1 += r0;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bpf_map_ptr: r = 0, r = r + map_ptr")
+__success __failure_unpriv
+__msg_unpriv("R0 has pointer with unsupported alu operation")
+__retval(0)
+__naked void _0_r_r_map_ptr(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	r0 = %[map_hash_16b] ll;			\
+	r1 += r0;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testing/selftests/bpf/verifier/map_ptr.c
deleted file mode 100644
index 17ee84dc7766..000000000000
--- a/tools/testing/selftests/bpf/verifier/map_ptr.c
+++ /dev/null
@@ -1,99 +0,0 @@
-{
-	"bpf_map_ptr: read with negative offset rejected",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
-	.result = REJECT,
-	.errstr = "R1 is bpf_array invalid negative access: off=-8",
-},
-{
-	"bpf_map_ptr: write rejected",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
-	.result = REJECT,
-	.errstr = "only read from bpf_array is supported",
-},
-{
-	"bpf_map_ptr: read non-existent field rejected",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
-	.result = REJECT,
-	.errstr = "cannot access ptr member ops with moff 0 in struct bpf_map with off 1 size 4",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"bpf_map_ptr: read ops field accepted",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"bpf_map_ptr: r = 0, map_ptr = map_ptr + r",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 4 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.result = ACCEPT,
-},
-{
-	"bpf_map_ptr: r = 0, r = r + map_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 4 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 has pointer with unsupported alu operation",
-	.result = ACCEPT,
-},
-- 
2.40.0

