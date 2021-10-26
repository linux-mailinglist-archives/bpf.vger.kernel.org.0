Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFF43B1D4
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhJZMHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhJZMHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:07:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7F5C061224;
        Tue, 26 Oct 2021 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iWzmW9PZvJMFGANq1nkUYS4d7bVo3JwiDO79gwcxJuE=; b=HWnNesBWq684cMlolAcPYP47aH
        gnhJ2sSXPI15+WYU8loZgUCYLDF0vWdnv9WSMctCCLyl2uNOo9pMpulvZOCsVFL7RI9PKw93lLT1i
        6mIhRw9Cw3TFA4xhOQ+WHSgCUb6fuvaCeDokJahfx/QbeUdlHk5Qm4DnwfxpV5kkW4SeplFCLfpAm
        SFfdRQEd3Cb3l0soRDJ66WvxoEmo1vSjRodk3/SIThxkLnjkYrd6DCapixSuCRYv+QwN5GMV6zPGu
        iLrlW27RosAn0UZn7BIg8Pj/vvrB55cfmgOCW+G9+seYlW617BDTKppXuBQbQBB5owR6u704R9Kgp
        mgPBO+Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCe-00CM17-8P; Tue, 26 Oct 2021 12:05:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46B9E301999;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2DF5525E57E62; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120310.359986601@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 12/16] x86/alternative: Try inline spectre_v2=retpoline,amd
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Try and replace retpoline thunk calls with:

  LFENCE
  CALL    *%\reg

for spectre_v2=retpoline,amd.

Specifically, the sequence above is 5 bytes for the low 8 registers,
but 6 bytes for the high 8 registers. This means that unless the
compilers prefix stuff the call with higher registers this replacement
will fail.

Luckily GCC strongly favours RAX for the indirect calls and most (95%+
for defconfig-x86_64) will be converted. OTOH clang strongly favours
R11 and almost nothing gets converted.

Note: it will also generate a correct replacement for the Jcc.d32
case, except unless the compilers start to prefix stuff that, it'll
never fit. Specifically:

  Jncc.d8 1f
  LFENCE
  JMP     *%\reg
1:

is 7-8 bytes long, where the original instruction in unpadded form is
only 6 bytes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -389,6 +389,7 @@ static int emit_indirect(int op, int reg
  *
  *   CALL *%\reg
  *
+ * It also tries to inline spectre_v2=retpoline,amd when size permits.
  */
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
@@ -405,7 +406,8 @@ static int patch_retpoline(void *addr, s
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD))
 		return -1;
 
 	op = insn->opcode.bytes[0];
@@ -418,8 +420,9 @@ static int patch_retpoline(void *addr, s
 	 * into:
 	 *
 	 *   Jncc.d8 1f
+	 *   [ LFENCE ]
 	 *   JMP *%\reg
-	 *   NOP
+	 *   [ NOP ]
 	 * 1:
 	 */
 	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
@@ -432,6 +435,15 @@ static int patch_retpoline(void *addr, s
 		op = JMP32_INSN_OPCODE;
 	}
 
+	/*
+	 * For RETPOLINE_AMD: prepend the indirect CALL/JMP with an LFENCE.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		bytes[i++] = 0x0f;
+		bytes[i++] = 0xae;
+		bytes[i++] = 0xe8; /* LFENCE */
+	}
+
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;


