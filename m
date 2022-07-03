Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE175649EF
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGCV0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGCVZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF2325;
        Sun,  3 Jul 2022 14:25:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 45DC95C00AB;
        Sun,  3 Jul 2022 17:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883553; x=1656969953; bh=7L
        NZ2OJwmFx4tu69CLZFrliOhrnTXltiLtzEMLeXPkc=; b=MRi6d5uyZSacyDYNt2
        ecvwTTBgkzbT7hborJlsujr93OUXioVBQrBUf590ulHTuR5CChUiZi34zGvCsAtN
        SbNj4AKSV6NSqoN2Lk3OCvX2Kf9AeqYL3XNAcmZevHtlpBvW1V1fqEYw/yrxzSaB
        uWf4nSrnkAfuMqwjg3PZn/E7u6FpAW6O64jJYa4CSv8l/E2wQJFYBbOQ7c9lNLJP
        qzOQhFkf5bGy61mQo/S3KZK8ffUZPAQTeOVTbobxi7HS5FD6Zr3sjWkpNPyzdPe5
        7uoUFQIPtJMQjyg9ym0WdyUetCnwMpvU0u4lVJ7hjtoFsWlbbVbVAXVGM5jE1l3B
        d9hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883553; x=1656969953; bh=7LNZ2OJwmFx4t
        u69CLZFrliOhrnTXltiLtzEMLeXPkc=; b=Ba4/DiEWfWlWLLuUapUrUeG42EJhV
        SUNa/FOTjn6mDBBumVVwlOBxILBiQVQ0w/p5LYV0C92mbVCkj3prpGCz8Yu05ytX
        /9KQYRthtUprz73Y9UMPP2ilKXwhrYBUx6cGveiE+fVeMsSWa4cIZnhJ50+aYUSv
        4XECe8piS/d52GeMhhL0A1EQWpS9f8/cPUqHAlK493Ftwuzm4vnVJlsgoy7QhdoO
        D9bjVgc00h6aczmYAmQQofz9f96WL0uqDb9okbFO+DUrToz3pzHskasUmpiExg48
        XBb70hzWpzFwycXkiqXMLmaRNKIaPy2d0r2X+kzietsuUjxezfmamHAWA==
X-ME-Sender: <xms:YQnCYroNAagiSbk6tKpAonztGhwtg4Q306OV38R_ZZjST39yHOtL2Q>
    <xme:YQnCYloQNrZQCTo6QFGWoR4jnFTRWZU1zpKyJ-TpnwGiN2u_aZEiooXYTGpLifYTC
    XRaE2xruJ-f5xzxaw>
X-ME-Received: <xmr:YQnCYoMqDj7gpTs7PKeSw3WDOYAl3UWj52VrpXy1gpaiui4lBmY1jvD0uRdHVoy0Bcn02RGKCo-dxxdOZ4nQC8-muNeYcciw0CQj-cq036CwhbSdAMCpaAL4wr9L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YQnCYu434TXQU90NPWM6nK7CVaQNtr2AkYkQHuh72jg6IdjOhepS2w>
    <xmx:YQnCYq5o0Hje_BIPzWC512DJFbZ9jbZYdXckZqBjPlEzylJ7eJmBbw>
    <xmx:YQnCYmiCF5S24MP7lON4T1T-udBWC9vBs7zqGApPuv9kVz9ulp6NRg>
    <xmx:YQnCYntVFU7Q0BDRdVBmhRtT7Ye4qajCN4i1gL09Cs7n4D8s92YwVg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 17:25:52 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 4/5] tools bpf_jit_disasm: Fix compilation error with new binutils
Date:   Sun,  3 Jul 2022 14:25:50 -0700
Message-Id: <20220703212551.1114923-5-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220703212551.1114923-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

binutils changed the signature of init_disassemble_info(), which now causes
compilation to fail for tools/bpf/bpf_jit_disasm.c, e.g. on debian
unstable. Relevant binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

Wire up the feature test and switch to init_disassemble_info_compat(),
which were introduced in prior commits, fixing the compilation failure.

I verified that bpf_jit_disasm can still disassemble bpf programs, both
with the old and new dis-asm.h API. With old binutils there's no change in
output before/after this patch. When comparing the output from old
binutils (2.35) to new bintuils with the patch (upstream snapshot) there
are a few output differences, but they are unrelated to this patch. An
example hunk is:
   f4:	mov    %r14,%rsi
   f7:	mov    %r15,%rdx
   fa:	mov    $0x2a,%ecx
-  ff:	callq  0xffffffffea8c4988
+  ff:	call   0xffffffffea8c4988
  104:	test   %rax,%rax
  107:	jge    0x0000000000000110
  109:	xor    %eax,%eax
- 10b:	jmpq   0x0000000000000073
+ 10b:	jmp    0x0000000000000073
  110:	cmp    $0x16,%rax

However, I had to use an older kernel to generate the bpf_jit_enabled = 2
output, as that has been broken since 5.18 / 1022a5498f6f:
https://lore.kernel.org/20220703030210.pmjft7qc2eajzi6c@alap3.anarazel.de

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/Makefile         | 7 +++++--
 tools/bpf/bpf_jit_disasm.c | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index b11cfc86a3d0..9c4e61c3a92b 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -34,8 +34,8 @@ else
 endif
 
 FEATURE_USER = .bpf
-FEATURE_TESTS = libbfd disassembler-four-args
-FEATURE_DISPLAY = libbfd disassembler-four-args
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
+FEATURE_DISPLAY = libbfd disassembler-four-args disassembler-init-styled
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
@@ -56,6 +56,9 @@ endif
 ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
+ifeq ($(feature-disassembler-init-styled), 1)
+CFLAGS += -DDISASM_INIT_STYLED
+endif
 
 $(OUTPUT)%.yacc.c: $(srctree)/tools/bpf/%.y
 	$(QUIET_BISON)$(YACC) -o $@ -d $<
diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index c8ae95804728..a90a5d110f92 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <limits.h>
+#include <tools/dis-asm-compat.h>
 
 #define CMD_ACTION_SIZE_BUFFER		10
 #define CMD_ACTION_READ_ALL		3
@@ -64,7 +65,9 @@ static void get_asm_insns(uint8_t *image, size_t len, int opcodes)
 	assert(bfdf);
 	assert(bfd_check_format(bfdf, bfd_object));
 
-	init_disassemble_info(&info, stdout, (fprintf_ftype) fprintf);
+	init_disassemble_info_compat(&info, stdout,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	info.buffer = image;
-- 
2.37.0.3.g30cc8d0f14

