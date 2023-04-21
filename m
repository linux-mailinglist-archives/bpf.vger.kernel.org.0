Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBD6EB0E1
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDURn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjDURnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5066189
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so1948743f8f.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098978; x=1684690978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Vgv5RzTIEnETx4FU/RyC2oSCRdoeqOGp2zsM7CpEYc=;
        b=cwT15TGd1pbH+rwr1oqmCBvwvRHcQRuhQWeEOc7afNYIoi7MWOyvcuzPkzj00VVHPD
         +LbgsNlVhlp4oE1CizXdkSTh3vN8SpDQhVK7qKOXMso1gXueTGS5YXpeqEByn+XL5z98
         FhfkI8U7y0zy6VIC0nGrgfGEdPjgVW0aEZ8BtHQc3zoG8UYuAb64D1EDNEsYuOBlhqcO
         zWAIwDxPcO5zbi7Fe1mzNKfNrDRgMcWmldONoMV4ijNLF8H2+I8vzTuGvkv2dss8ItXS
         Uc4IKrEOUjpM5nrYllYf1tjeG7QWcKqseWHhJJ9FC2XEvXbavzOECOykZU9xa7bIUFNf
         vJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098978; x=1684690978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Vgv5RzTIEnETx4FU/RyC2oSCRdoeqOGp2zsM7CpEYc=;
        b=lEP7WvohBFyv3dQITje9oGm1ObWyZMzDqKCiiYyDFyDAr3pipMPRFBEvlfd7vQ9K+n
         CM1bOE/EjvZBOFSx0pwyoPz3pyG8TaT3BiXXvz+Y2gbuJ97Eskfrw1Q17i4+fWXdflcg
         nY3J6X1zWJI8v87FUsUlQr7RlFNSQo3uKROMyf7Nxn+O271n2dTbBTCCedEbhnNuqB//
         S2lg/zyUHYLE2Yoc8I9w4gXY+9Kx6cx6vtk0TtxOG7dFI5n2ug3ip/ua9Z4yTxnZQIiy
         jLqHbgB0F8KIht840I89q7BXNZH/enQG9x2+LH+gH8a5DwGTFBOtak1VMbW18knvgYlW
         SwwA==
X-Gm-Message-State: AAQBX9f4CQXkHydpSHvtEKbe+zvhHwKub2Car+ctdyXhgtmW3JQ0xk29
        4KsX65ts/FBPXDUdd8XGVBPqpsw54P1R6g==
X-Google-Smtp-Source: AKy350YXfJRlWXsga29Qo9Mh5gJBidg2zM6d54DvUH5Jemsu5guIUaymzeyPBaGcqf9rLw+MbjwH/A==
X-Received: by 2002:a5d:65c5:0:b0:2f0:2d92:e6fd with SMTP id e5-20020a5d65c5000000b002f02d92e6fdmr4701010wrw.50.1682098978373;
        Fri, 21 Apr 2023 10:42:58 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:57 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 11/24] selftests/bpf: verifier/map_in_map converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:21 +0300
Message-Id: <20230421174234.2391278-12-eddyz87@gmail.com>
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

Test verifier/map_in_map automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_map_in_map.c | 142 ++++++++++++++++++
 .../selftests/bpf/verifier/map_in_map.c       |  96 ------------
 3 files changed, 144 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_in_map.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_in_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 54c30fe1b693..95fc9cb231ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -34,6 +34,7 @@
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
+#include "verifier_map_in_map.skel.h"
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
@@ -117,6 +118,7 @@ void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
+void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
new file mode 100644
index 000000000000..4eaab1468eb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/map_in_map.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, int);
+		__type(value, int);
+	});
+} map_in_map SEC(".maps");
+
+SEC("socket")
+__description("map in map access")
+__success __success_unpriv __retval(0)
+__naked void map_in_map_access(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("map in map state pruning")
+__success __msg("processed 26 insns")
+__log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void map_in_map_state_pruning(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r6 = r10;					\
+	r6 += -4;					\
+	r2 = r6;					\
+	r1 = %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r2 = r6;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	r2 = r6;					\
+	r1 = %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l2_%=;				\
+	exit;						\
+l2_%=:	r2 = r6;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid inner map pointer")
+__failure __msg("R1 pointer arithmetic on map_ptr prohibited")
+__failure_unpriv
+__naked void invalid_inner_map_pointer(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = r0;					\
+	r1 += 8;					\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("forgot null checking on the inner map pointer")
+__failure __msg("R1 type=map_value_or_null expected=map_ptr")
+__failure_unpriv
+__naked void on_the_inner_map_pointer(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_in_map.c b/tools/testing/selftests/bpf/verifier/map_in_map.c
deleted file mode 100644
index 128a348b762d..000000000000
--- a/tools/testing/selftests/bpf/verifier/map_in_map.c
+++ /dev/null
@@ -1,96 +0,0 @@
-{
-	"map in map access",
-	.insns = {
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_in_map = { 3 },
-	.result = ACCEPT,
-},
-{
-	"map in map state pruning",
-	.insns = {
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 11),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_in_map = { 4, 14 },
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.result = VERBOSE_ACCEPT,
-	.errstr = "processed 25 insns",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"invalid inner map pointer",
-	.insns = {
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_in_map = { 3 },
-	.errstr = "R1 pointer arithmetic on map_ptr prohibited",
-	.result = REJECT,
-},
-{
-	"forgot null checking on the inner map pointer",
-	.insns = {
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_ST_MEM(0, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_in_map = { 3 },
-	.errstr = "R1 type=map_value_or_null expected=map_ptr",
-	.result = REJECT,
-},
-- 
2.40.0

