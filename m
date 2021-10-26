Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F072443B1F0
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhJZMK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhJZMKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:10:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0CC061243;
        Tue, 26 Oct 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2v3uIvVPHvF6X4QD+1Tv1yg25b3qVdoNykrE8xV5weA=; b=A8SulDwX1eGTB0V4PPlfEa+L+o
        2bOCW1LNZ59qMSYeBXr93awOfFrmqPjdPft1u9vNM9yE3HOD2EtLJCla0V3M0p27SzU5DynpNkKy4
        Lf3tK9yEF7webT7cYmZUlAob37ZTTYuwGNxVszuKj33lrMqgKIJUjdC98uQPNlxVBNNKTZiCegRLN
        qHAWQ6ehL6/uYtG47UhTOtPnSa/9eSG0RFwtLUCCVLo5jHO8TitggwiMqKAEvpwYYjbpaeCigRUUq
        RGFTFb7iU/TA+WhqkXB0dywb5NQCmfCCHDHpgelNDr8YmWXXCLL1amQJvQ/Fpu3aE9OQ67uErEDKG
        mas7+gfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCe-00GprJ-7d; Tue, 26 Oct 2021 12:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43C8E30198B;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2788925E57E60; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120310.296470217@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 11/16] x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Handle the rare cases where the compiler (clang) does an indirect
conditional tail-call using:

  Jcc __x86_indirect_thunk_\reg

For the !RETPOLINE case this can be rewritten to fit the original (6
byte) instruction like:

  Jncc.d8	1f
  JMP		*%\reg
  NOP
1:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,7 +393,8 @@ static int emit_indirect(int op, int reg
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
 	retpoline_thunk_t *target;
-	int reg, i = 0;
+	int reg, ret, i = 0;
+	u8 op, cc;
 
 	target = addr + insn->length + insn->immediate.value;
 	reg = target - __x86_indirect_thunk_array;
@@ -407,9 +408,34 @@ static int patch_retpoline(void *addr, s
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
 		return -1;
 
-	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
-	if (i < 0)
-		return i;
+	op = insn->opcode.bytes[0];
+
+	/*
+	 * Convert:
+	 *
+	 *   Jcc.d32 __x86_indirect_thunk_\reg
+	 *
+	 * into:
+	 *
+	 *   Jncc.d8 1f
+	 *   JMP *%\reg
+	 *   NOP
+	 * 1:
+	 */
+	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
+		cc = insn->opcode.bytes[1] & 0xf;
+		cc ^= 1; /* invert condition */
+
+		bytes[i++] = 0x70 + cc; /* Jcc.d8 */
+		bytes[i++] = insn->length - 2;
+
+		op = JMP32_INSN_OPCODE;
+	}
+
+	ret = emit_indirect(op, reg, bytes + i);
+	if (ret < 0)
+		return ret;
+	i += ret;
 
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
@@ -443,6 +469,10 @@ void __init_or_module noinline apply_ret
 		case JMP32_INSN_OPCODE:
 			break;
 
+		case 0x0f: /* escape */
+			if (op2 >= 0x80 && op2 <= 0x8f)
+				break;
+			fallthrough;
 		default:
 			WARN_ON_ONCE(1);
 			continue;


