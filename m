Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2536C8A6B
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCYC4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjCYC4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE308FF27
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso4164523wms.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbRr/2JcwXKlQDytSTkBSNVGzQlQKD3rqdzf6wLrgpc=;
        b=bx988wahix/BQdVfkThRSED/jV5FsqitbAxe46wqX6Pt9+EL9hVq5Hi//oM/B9hLXv
         frR7HpXJ1fyz4/NEEWm73A6zTOt5qUqQpbakNDN4K3h1MXk4QxkaK5qSrQYxcCXo0gQ7
         xS+T5jHOGoZNOz1wAVZBjhttM40niz9oT/BrAfe+rcKxJyZkZm9kPMeFTkYsIaft/M01
         aetZAsUg/SQ6apxMODlYuONgnQbKUJNWTsTu28azBfCeVlu7E9+GbhrLgno/yBApuqE7
         QJu7CetLdxJlubZK7wD2aO0NtgS9YTpUc5pHYAyp/E0CWhh5oRbmZFv3Le3W8AyhsVZ4
         uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbRr/2JcwXKlQDytSTkBSNVGzQlQKD3rqdzf6wLrgpc=;
        b=3Xg/fSQ4+TkGzszSLVdOM3TbeGX5EMZYioDSPefjQ5+gmZu01Xq3Tek0/m80ixrOUt
         G3cKU+Ywt2b1mGHnhl4t5n8glpjd8o3ocRzeSf+t0Mq8xoTEmRQKqxuPvHU2irn3SgmV
         gB+77nRGwzylxdAgJa2WAej7+UFZgZ4VDLttGObEv1z1dnkXnAGdapImRrW+mJS0R87A
         4T5wyTLAFEnblYTtnJ3/HAKgImUgi6YtZEO5OpjykNLO4sVVhS7idzf2zh+OOGjqBjRl
         5AtH2n3u9W+iqo8tUgwMSsyS3dTFxYZWRpbTrHtFEByfJvfUvu9kB1D+BDCd8N5xTmpe
         GTtg==
X-Gm-Message-State: AO0yUKUmIp3SwplG/M3wjYpKfLKvsUCrTiKrYMzR/kvz3D0eOENSpg0h
        hJ5vs2K6x2qIEYTexiNVFqzk3CpzYf4=
X-Google-Smtp-Source: AK7set+5hXbwjbZynofCvXAjzG2IS2ZreXzwTQFezbUOOgJoa1f/aEen8nVfnpJDCz2/eyVcWE588w==
X-Received: by 2002:a05:600c:210d:b0:3ed:418a:ec06 with SMTP id u13-20020a05600c210d00b003ed418aec06mr3935197wml.28.1679712976028;
        Fri, 24 Mar 2023 19:56:16 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:15 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 16/43] selftests/bpf: verifier/ctx_sk_msg.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:57 +0200
Message-Id: <20230325025524.144043-17-eddyz87@gmail.com>
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

Test verifier/ctx_sk_msg.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ctx_sk_msg.c | 228 ++++++++++++++++++
 .../selftests/bpf/verifier/ctx_sk_msg.c       | 181 --------------
 3 files changed, 230 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_sk_msg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ctx_sk_msg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 36fdede7dcab..29351c774ee2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -13,6 +13,7 @@
 #include "verifier_cgroup_skb.skel.h"
 #include "verifier_cgroup_storage.skel.h"
 #include "verifier_const_or.skel.h"
+#include "verifier_ctx_sk_msg.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -48,3 +49,4 @@ void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode)
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
+void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_sk_msg.c b/tools/testing/selftests/bpf/progs/verifier_ctx_sk_msg.c
new file mode 100644
index 000000000000..65edc89799f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_sk_msg.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/ctx_sk_msg.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("sk_msg")
+__description("valid access family in SK_MSG")
+__success
+__naked void access_family_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_family]);		\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_family, offsetof(struct sk_msg_md, family))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("valid access remote_ip4 in SK_MSG")
+__success
+__naked void remote_ip4_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_ip4]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_remote_ip4, offsetof(struct sk_msg_md, remote_ip4))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("valid access local_ip4 in SK_MSG")
+__success
+__naked void local_ip4_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_ip4]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_local_ip4, offsetof(struct sk_msg_md, local_ip4))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("valid access remote_port in SK_MSG")
+__success
+__naked void remote_port_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_port]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_remote_port, offsetof(struct sk_msg_md, remote_port))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("valid access local_port in SK_MSG")
+__success
+__naked void local_port_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_port]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_local_port, offsetof(struct sk_msg_md, local_port))
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("valid access remote_ip6 in SK_MSG")
+__success
+__naked void remote_ip6_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_ip6_0]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_ip6_1]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_ip6_2]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_remote_ip6_3]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_remote_ip6_0, offsetof(struct sk_msg_md, remote_ip6[0])),
+	  __imm_const(sk_msg_md_remote_ip6_1, offsetof(struct sk_msg_md, remote_ip6[1])),
+	  __imm_const(sk_msg_md_remote_ip6_2, offsetof(struct sk_msg_md, remote_ip6[2])),
+	  __imm_const(sk_msg_md_remote_ip6_3, offsetof(struct sk_msg_md, remote_ip6[3]))
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("valid access local_ip6 in SK_MSG")
+__success
+__naked void local_ip6_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_ip6_0]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_ip6_1]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_ip6_2]);	\
+	r0 = *(u32*)(r1 + %[sk_msg_md_local_ip6_3]);	\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_local_ip6_0, offsetof(struct sk_msg_md, local_ip6[0])),
+	  __imm_const(sk_msg_md_local_ip6_1, offsetof(struct sk_msg_md, local_ip6[1])),
+	  __imm_const(sk_msg_md_local_ip6_2, offsetof(struct sk_msg_md, local_ip6[2])),
+	  __imm_const(sk_msg_md_local_ip6_3, offsetof(struct sk_msg_md, local_ip6[3]))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("valid access size in SK_MSG")
+__success
+__naked void access_size_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[sk_msg_md_size]);		\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_size, offsetof(struct sk_msg_md, size))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("invalid 64B read of size in SK_MSG")
+__failure __msg("invalid bpf_context access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void of_size_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[sk_msg_md_size]);		\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_size, offsetof(struct sk_msg_md, size))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("invalid read past end of SK_MSG")
+__failure __msg("invalid bpf_context access")
+__naked void past_end_of_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__imm_0]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, offsetof(struct sk_msg_md, size) + 4)
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("invalid read offset in SK_MSG")
+__failure __msg("invalid bpf_context access")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void read_offset_in_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__imm_0]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, offsetof(struct sk_msg_md, family) + 1)
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("direct packet read for SK_MSG")
+__success
+__naked void packet_read_for_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[sk_msg_md_data]);		\
+	r3 = *(u64*)(r1 + %[sk_msg_md_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_data, offsetof(struct sk_msg_md, data)),
+	  __imm_const(sk_msg_md_data_end, offsetof(struct sk_msg_md, data_end))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("direct packet write for SK_MSG")
+__success
+__naked void packet_write_for_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[sk_msg_md_data]);		\
+	r3 = *(u64*)(r1 + %[sk_msg_md_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(sk_msg_md_data, offsetof(struct sk_msg_md, data)),
+	  __imm_const(sk_msg_md_data_end, offsetof(struct sk_msg_md, data_end))
+	: __clobber_all);
+}
+
+SEC("sk_msg")
+__description("overlapping checks for direct packet access SK_MSG")
+__success
+__naked void direct_packet_access_sk_msg(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[sk_msg_md_data]);		\
+	r3 = *(u64*)(r1 + %[sk_msg_md_data_end]);	\
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
+	: __imm_const(sk_msg_md_data, offsetof(struct sk_msg_md, data)),
+	  __imm_const(sk_msg_md_data_end, offsetof(struct sk_msg_md, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c b/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
deleted file mode 100644
index c6c69220a569..000000000000
--- a/tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
+++ /dev/null
@@ -1,181 +0,0 @@
-{
-	"valid access family in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, family)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"valid access remote_ip4 in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_ip4)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"valid access local_ip4 in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_ip4)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"valid access remote_port in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_port)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"valid access local_port in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_port)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"valid access remote_ip6 in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_ip6[0])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_ip6[1])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_ip6[2])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, remote_ip6[3])),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-},
-{
-	"valid access local_ip6 in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_ip6[0])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_ip6[1])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_ip6[2])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, local_ip6[3])),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-},
-{
-	"valid access size in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct sk_msg_md, size)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"invalid 64B read of size in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, size)),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid bpf_context access",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid read past end of SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, size) + 4),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid bpf_context access",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"invalid read offset in SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, family) + 1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid bpf_context access",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet read for SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data)),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"direct packet write for SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data)),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-{
-	"overlapping checks for direct packet access SK_MSG",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data)),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct sk_msg_md, data_end)),
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
-	.prog_type = BPF_PROG_TYPE_SK_MSG,
-},
-- 
2.40.0

