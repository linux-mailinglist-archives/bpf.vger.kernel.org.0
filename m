Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A66EB0E0
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDURn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjDURnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106523C0D
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1958d3a85so6074115e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098977; x=1684690977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdSJ7QNaxCCf8E/q7TTuV1MRzT2kE3PDVLFsNdsykUE=;
        b=J5qwdrtXlmuQKu+vSSMc4uI+8xiJbAZKPJ1YNkrw6Hgmih0fM7ESCOGBRgmPIEmHKh
         Xf3gErxPIzslbxISRacI74e2oOhuaZcGGbnBDDO7dv7b5W9r+4Gcd2LJi79HgzqvN4O+
         r2T2HtwlbMpkdlOUd9CYeqBrPk7gmlpRpiesWIU2/zbmSzbNbMLGg2k4qTNiypiCM07E
         /fB6sOGO/W9zvj765oNoVIhxguyeFLlbdnj5oxC1g6ld62pMlglNy7XpGXE4wgMzB/1a
         v4Hu75BndHj3hVH0Jl733jgIejTryBf98RY6MBtbNXQDB0ikr0SrKKDhekqWtnWn4Vcm
         Popw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098977; x=1684690977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdSJ7QNaxCCf8E/q7TTuV1MRzT2kE3PDVLFsNdsykUE=;
        b=SoxOV/+ZGtP2dhogEagQYmDN49tyAIB0CWbYOosZN+G+Uevtgl/MRB7UlTSPbTsZOq
         1OkkOWwxwl5cdKHyh8YpkAN56qiZTEUJmC1Qfvxg9FBnA3q5+yBqXrA0nmQfVhuep+yE
         X4HuQ07TnL5k3lZ61XLbkEraqeS7VUfAkKICuH95ce838YgxMIzgQNAHXJL25ovzgKM2
         5bmpFEu8ZQ3M2HTwCabJ/vrFD+gzq22fmJZy/blQe4H49veCgM00SZJR9ODT4nV+9IsB
         Xal9u+Y64lKOnJqksGFWZU57U934FYgb+tCOqZN+x9zQjKxjaXuGJh94e5r/PJddI3BU
         +S7A==
X-Gm-Message-State: AAQBX9cneq50Cv4z8PeUysssZdk8W1KnQlm3qXlYhf82Oeb27rQr7wTD
        Sz7PaHBPRIYnRgVYu40hNPkEVpThlii7KA==
X-Google-Smtp-Source: AKy350YOjfG+/3B0zlmjr6QJ7TNqN7zByFm33BVIqKu/eQxwRTfGWsVGxdw68brROtffMzLPv6AMKQ==
X-Received: by 2002:a1c:4c09:0:b0:3f0:49b5:f0ce with SMTP id z9-20020a1c4c09000000b003f049b5f0cemr2501931wmf.12.1682098977098;
        Fri, 21 Apr 2023 10:42:57 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:56 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 10/24] selftests/bpf: verifier/lwt converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:20 +0300
Message-Id: <20230421174234.2391278-11-eddyz87@gmail.com>
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

Test verifier/lwt automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_lwt.c        | 234 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/lwt.c    | 189 --------------
 3 files changed, 236 insertions(+), 189 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lwt.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/lwt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 33a50dbc2321..54c30fe1b693 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -33,6 +33,7 @@
 #include "verifier_ld_ind.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_loops1.skel.h"
+#include "verifier_lwt.skel.h"
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
@@ -115,6 +116,7 @@ void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null)
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
+void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_lwt.c b/tools/testing/selftests/bpf/progs/verifier_lwt.c
new file mode 100644
index 000000000000..5ab746307309
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lwt.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/lwt.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("lwt_in")
+__description("invalid direct packet write for LWT_IN")
+__failure __msg("cannot write into packet")
+__naked void packet_write_for_lwt_in(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_out")
+__description("invalid direct packet write for LWT_OUT")
+__failure __msg("cannot write into packet")
+__naked void packet_write_for_lwt_out(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_xmit")
+__description("direct packet write for LWT_XMIT")
+__success __retval(0)
+__naked void packet_write_for_lwt_xmit(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("direct packet read for LWT_IN")
+__success __retval(0)
+__naked void packet_read_for_lwt_in(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_out")
+__description("direct packet read for LWT_OUT")
+__success __retval(0)
+__naked void packet_read_for_lwt_out(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_xmit")
+__description("direct packet read for LWT_XMIT")
+__success __retval(0)
+__naked void packet_read_for_lwt_xmit(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_xmit")
+__description("overlapping checks for direct packet access")
+__success __retval(0)
+__naked void checks_for_direct_packet_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u16*)(r2 + 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("lwt_xmit")
+__description("make headroom for LWT_XMIT")
+__success __retval(0)
+__naked void make_headroom_for_lwt_xmit(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r2 = 34;					\
+	r3 = 0;						\
+	call %[bpf_skb_change_head];			\
+	/* split for s390 to succeed */			\
+	r1 = r6;					\
+	r2 = 42;					\
+	r3 = 0;						\
+	call %[bpf_skb_change_head];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_skb_change_head)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid access of tc_classid for LWT_IN")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void tc_classid_for_lwt_in(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_tc_classid]);	\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tc_classid, offsetof(struct __sk_buff, tc_classid))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid access of tc_classid for LWT_OUT")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void tc_classid_for_lwt_out(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_tc_classid]);	\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tc_classid, offsetof(struct __sk_buff, tc_classid))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid access of tc_classid for LWT_XMIT")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void tc_classid_for_lwt_xmit(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_tc_classid]);	\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tc_classid, offsetof(struct __sk_buff, tc_classid))
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("check skb->tc_classid half load not permitted for lwt prog")
+__failure __msg("invalid bpf_context access")
+__naked void not_permitted_for_lwt_prog(void)
+{
+	asm volatile (
+	"r0 = 0;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r0 = *(u16*)(r1 + %[__sk_buff_tc_classid]);"
+#else
+	"r0 = *(u16*)(r1 + %[__imm_0]);"
+#endif
+	"exit;"
+	:
+	: __imm_const(__imm_0, offsetof(struct __sk_buff, tc_classid) + 2),
+	  __imm_const(__sk_buff_tc_classid, offsetof(struct __sk_buff, tc_classid))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/lwt.c b/tools/testing/selftests/bpf/verifier/lwt.c
deleted file mode 100644
index 5c8944d0b091..000000000000
--- a/tools/testing/selftests/bpf/verifier/lwt.c
+++ /dev/null
@@ -1,189 +0,0 @@
-{
-	"invalid direct packet write for LWT_IN",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "cannot write into packet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"invalid direct packet write for LWT_OUT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "cannot write into packet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_OUT,
-},
-{
-	"direct packet write for LWT_XMIT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_XMIT,
-},
-{
-	"direct packet read for LWT_IN",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"direct packet read for LWT_OUT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_OUT,
-},
-{
-	"direct packet read for LWT_XMIT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_XMIT,
-},
-{
-	"overlapping checks for direct packet access",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 6),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_2, 6),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_XMIT,
-},
-{
-	"make headroom for LWT_XMIT",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_2, 34),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_skb_change_head),
-	/* split for s390 to succeed */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 42),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_skb_change_head),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_XMIT,
-},
-{
-	"invalid access of tc_classid for LWT_IN",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid)),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-},
-{
-	"invalid access of tc_classid for LWT_OUT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid)),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-},
-{
-	"invalid access of tc_classid for LWT_XMIT",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid)),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-},
-{
-	"check skb->tc_classid half load not permitted for lwt prog",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid)),
-#else
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid) + 2),
-#endif
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-- 
2.40.0

