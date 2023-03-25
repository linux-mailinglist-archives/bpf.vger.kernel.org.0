Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F86C8A77
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjCYC4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjCYC4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F191B308
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p34so2096908wms.3
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ySnXWUpNhErn2QsCMtGpgOSoumiNvY6TRDxV36XCbY=;
        b=TA8tF624qnNmAt2MhRRqbtfIH9tueZWD72nsekOF0WjPnQopc4VsZmc6z9gWlZsrai
         SKVvDFmn8pnVcbtZuPFmDT5Y9J65iuXvsHEp5kHjLivPof7wuPwg2GjhFJCYamS4Qt1Y
         yNEBOi7o/OMn1G7PdX9zrvlg7ZI06euwKnvaSjUUpclIMAyPZpj17e1HxvLJ1rjG8g00
         SAoakRjlmD17h7geifpweQ7cKmqVWGydWNaHwqII/bozfTaVjrsbuTOlQVRBQk9YtYhb
         1EGhjD0K0zHay80hZ9+9GNb8bntguaNmJ0pUBxrCguhIQ7NnEa3Qb90S+9Ss+RW/rlaa
         3NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ySnXWUpNhErn2QsCMtGpgOSoumiNvY6TRDxV36XCbY=;
        b=JV+v0XzSKwt0LcZ4scsQCuls1hqUwMAcof/MqZfJWTIiXZex22i1/ZWAj1Uu0EE9WZ
         0R6IrxLFoqqiZXQ28UMOvDqBq9Se9+7edgfTsgnXIADv5+NI1FBU64s4r4AWwS+AeTbJ
         9DYt+zkAD5fWfI22M8snTMSIjDo/hYb58HzTjCiUJpsFrphrW6dbWCU40C+BiGXWJIB/
         Igb5e08NISjKjfx/lOs3p7rCVIlm8DYNiGkc2ybEilmpxz2Mnq++Nomf/QUbkaVsmjRP
         EKzx3d1bcT4+JmeJwdoB74hKe2YbO+61B4hzVpn6nCJga5846bha6Y/Wu4prYqaU37vY
         l8ww==
X-Gm-Message-State: AO0yUKVBOW/Z8gHTwJqStN44uko4ym7WgPYyBp2ZIzSe9WlI5NQA7hrh
        5tTjYemZP6D6amyX4n66q6+QbsLPROU=
X-Google-Smtp-Source: AK7set/ogzJvstdswKNYm3O6BpxJOt0HWjRBis1xty2HGS8Bh9AYWEtXxrcrOWdWxNs1UsAiBUMMhw==
X-Received: by 2002:a05:600c:2312:b0:3ee:b3bf:5f7c with SMTP id 18-20020a05600c231200b003eeb3bf5f7cmr4003331wmo.23.1679712991869;
        Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 28/43] selftests/bpf: verifier/map_ret_val.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:09 +0200
Message-Id: <20230325025524.144043-29-eddyz87@gmail.com>
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

Test verifier/map_ret_val.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_map_ret_val.c          | 110 ++++++++++++++++++
 .../selftests/bpf/verifier/map_ret_val.c      |  65 -----------
 3 files changed, 112 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ret_val.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d2f3bff0e942..5131a73fd225 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_ld_ind.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_map_ptr.skel.h"
+#include "verifier_map_ret_val.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -72,3 +73,4 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
+void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
new file mode 100644
index 000000000000..1639628b832d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/map_ret_val.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("socket")
+__description("invalid map_fd for function call")
+__failure __msg("fd 0 is not pointing to valid bpf_map")
+__failure_unpriv
+__naked void map_fd_for_function_call(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	.8byte %[ld_map_fd];				\
+	.8byte 0;					\
+	call %[bpf_map_delete_elem];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_delete_elem),
+	  __imm_insn(ld_map_fd, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, BPF_PSEUDO_MAP_FD, 0, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("don't check return value before access")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__failure_unpriv
+__naked void check_return_value_before_access(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = 0;						\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("access memory with incorrect alignment")
+__failure __msg("misaligned value access")
+__failure_unpriv
+__flag(BPF_F_STRICT_ALIGNMENT)
+__naked void access_memory_with_incorrect_alignment_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r0 + 4) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sometimes access memory with incorrect alignment")
+__failure __msg("R0 invalid mem access")
+__msg_unpriv("R0 leaks addr")
+__flag(BPF_F_STRICT_ALIGNMENT)
+__naked void access_memory_with_incorrect_alignment_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+l0_%=:	r1 = 1;						\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_ret_val.c b/tools/testing/selftests/bpf/verifier/map_ret_val.c
deleted file mode 100644
index bdd0e8d18333..000000000000
--- a/tools/testing/selftests/bpf/verifier/map_ret_val.c
+++ /dev/null
@@ -1,65 +0,0 @@
-{
-	"invalid map_fd for function call",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "fd 0 is not pointing to valid bpf_map",
-	.result = REJECT,
-},
-{
-	"don't check return value before access",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 invalid mem access 'map_value_or_null'",
-	.result = REJECT,
-},
-{
-	"access memory with incorrect alignment",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "misaligned value access",
-	.result = REJECT,
-	.flags = F_LOAD_WITH_STRICT_ALIGNMENT,
-},
-{
-	"sometimes access memory with incorrect alignment",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 invalid mem access",
-	.errstr_unpriv = "R0 leaks addr",
-	.result = REJECT,
-	.flags = F_LOAD_WITH_STRICT_ALIGNMENT,
-},
-- 
2.40.0

