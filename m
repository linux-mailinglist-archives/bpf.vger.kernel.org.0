Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABE6C8A81
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCYC5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjCYC47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075D1B2C5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o32so2103862wms.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR0jilUmo7dz/wC4pByzZfJDXRDqH4pd949i8Opheqo=;
        b=X6fwXHWYDYC/jhjYeA2kex23D3gyz8dOP1wsL50+ENHh7LcZa6NnoGPrt5LM8OdSve
         q8G2eiag4LkeIGThgDm+tdzZOZHvXEo+kMhiF6Hl61XZJW5CzpoXc06ckP9zJN5atR6W
         f1wCN+d3lEI3KIAtEeQU+Tzt7lb0bOasMCN2VFjhWMZedNR0hsAUxDCHsmNcI3QXIoeN
         X7Wy4hCozG0lg/0J7swkAqVRs5gysz94x3dW1SXdgSUAxx+b4ROvRQ3uNCZYWTGY6d3q
         xjffK2hMAXS0g6Bpv1AeZC92lIh2Extkh3ZPUhBPmDBVP8Am648QKuUHneDR6lgPl6ou
         Aw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR0jilUmo7dz/wC4pByzZfJDXRDqH4pd949i8Opheqo=;
        b=QxHa/lT7cB+BGr8ZuisMKQrHzhknZoG8rhJQiRCDq0gDXrDUFJdeZZZ2d2xh8Ktie5
         Lgxkz963/8mSvLwWYdXxNdaGL2OQ560+kFyM41OiXFBZfZwIi2SqHijV/v69smbEefxE
         O+1qiSB5Rv0kXzaIYS8Vs/X3Ku0dokkRCpl6EMUnzFZdm/NbA5O/1CJmH6hwZM2c5gNi
         w9s6G1jCV5zRjuTAplSe93sr68xQnoklRRbpjTerLp//ApyS0I5iXhBrlTSfHJbKlGnE
         akFvcQe8vpq+nbK86QBb/ARHB8hU062sFbu6P2lD7Y5AF7qssq/q8g5d4TvfgVTZAgiR
         YD2w==
X-Gm-Message-State: AO0yUKW6EntLxKpj0yQubUSTK597E1HZR+/GtTYXwU/wgs8PLxX3NeAG
        HffcKupovzJ/RsVb2X0eL9QMIFfuB9g=
X-Google-Smtp-Source: AK7set9LKKgyiLAjGA9SR9B/yrgwFhka7W+HwQ4WXJ3tzl/9AENI5FHVKZmdrw5Xk5gZZ3kMkGzsIw==
X-Received: by 2002:a1c:4b13:0:b0:3ed:33a1:ba8e with SMTP id y19-20020a1c4b13000000b003ed33a1ba8emr3881494wma.1.1679713004012;
        Fri, 24 Mar 2023 19:56:44 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:43 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 37/43] selftests/bpf: verifier/value_adj_spill.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:18 +0200
Message-Id: <20230325025524.144043-38-eddyz87@gmail.com>
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

Test verifier/value_adj_spill.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_value_adj_spill.c      | 78 +++++++++++++++++++
 .../selftests/bpf/verifier/value_adj_spill.c  | 43 ----------
 3 files changed, 80 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_adj_spill.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_adj_spill.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c6e69b3827dc..825c8583fecf 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -34,6 +34,7 @@
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
+#include "verifier_value_adj_spill.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -90,3 +91,4 @@ void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
+void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_adj_spill.c b/tools/testing/selftests/bpf/progs/verifier_value_adj_spill.c
new file mode 100644
index 000000000000..d7a5ba9bbe6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_value_adj_spill.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/value_adj_spill.c */
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
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("map element value is preserved across register spilling")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void is_preserved_across_register_spilling(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 42;					\
+	*(u64*)(r0 + 0) = r1;				\
+	r1 = r10;					\
+	r1 += -184;					\
+	*(u64*)(r1 + 0) = r0;				\
+	r3 = *(u64*)(r1 + 0);				\
+	r1 = 42;					\
+	*(u64*)(r3 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value or null is marked on register spilling")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void is_marked_on_register_spilling(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r1 = r10;					\
+	r1 += -152;					\
+	*(u64*)(r1 + 0) = r0;				\
+	if r0 == 0 goto l0_%=;				\
+	r3 = *(u64*)(r1 + 0);				\
+	r1 = 42;					\
+	*(u64*)(r3 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/value_adj_spill.c b/tools/testing/selftests/bpf/verifier/value_adj_spill.c
deleted file mode 100644
index 7135e8021b81..000000000000
--- a/tools/testing/selftests/bpf/verifier/value_adj_spill.c
+++ /dev/null
@@ -1,43 +0,0 @@
-{
-	"map element value is preserved across register spilling",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -184),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_3, 0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-},
-{
-	"map element value or null is marked on register spilling",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -152),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_3, 0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-},
-- 
2.40.0

