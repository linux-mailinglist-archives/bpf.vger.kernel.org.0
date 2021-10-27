Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622343C5DB
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbhJ0JBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbhJ0JA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259DC061224
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iWzmW9PZvJMFGANq1nkUYS4d7bVo3JwiDO79gwcxJuE=; b=XRDmTJqBTFG+Oxk2a2ms/t3vSj
        oZKilZ4pD6cgc4H0CxjO+dbjgRxUWcJq5DiXtWt5evUSiEJ58GcRLFel/w6uM0jYOHP39X1Gy12QP
        iSrDn4ded7Cfe5ZWzDt3g7tzGuaQHB3L3EMP4MdULwcSm8a2Dauhr2ZNKDiDELT3pKpQk8/nhFyyh
        8Yptc0qL3fsqQixv4PwFt4LG8k6eHtvBMgerp8lg2SM/dsQQxtwn6h3Uw59rxMB+A+ud627JQgMWc
        WPMHG59VFx43u5+fv/gHqqSYK0arR7Z5nrXISltM+z85SjAXf5H4W95u6ey2VX84aDv+0Ejb04tPj
        4GIvXSIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelT-00CWWJ-5Z
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B216A301995
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A30CC236E43D8; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.902633586@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 13/17] x86/alternative: Try inline spectre_v2=retpoline,amd
References: <20211027085243.008677168@infradead.org>
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


