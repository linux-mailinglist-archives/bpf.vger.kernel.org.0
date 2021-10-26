Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64443B1F3
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhJZMKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhJZMKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:10:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C8C061225;
        Tue, 26 Oct 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qUqGcUhtjch3gOosIbsiXehXzfcMa4DDk2c6yMYFjSQ=; b=GpQGOHjWvmryqZC5Vbkz63WSju
        WYrLQ9Obt/D7KHn6JSwZU8B/VOnk1L00nefJ74gSd/E8fxLnoGUk3DIcik+RQ0PZQ7o0weE9fbXlz
        BmnLZKHqp6lCpyDmkw2xY8l404A9AA9yna0rgKQrRtm1gZ6T7izSTW+LRTJQBPvcncNSFB/HI6j+u
        g/h+ubyUFNL70pheVO0pIMibeVN2SzdptFZxP1rQHMvV28RBerj1uqLXV/JzgJ7w4h8NziPUec6uH
        y4Dcd75SoSVtQIdR+L3kiEjffx7j8uEm6EB9+AjrGdSqlhR87SMiCP50rEEHEcVpVT3Uesw8PzcBd
        MH8eYNEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCe-00GprI-7Q; Tue, 26 Oct 2021 12:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CB1C300982;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EA5B25E57E57; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120309.915051744@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 05/16] x86/retpoline: Remove unused replacement symbols
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that objtool no longer creates alternatives, these replacement
symbols are no longer needed, remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |   10 --------
 arch/x86/lib/retpoline.S              |   42 ----------------------------------
 2 files changed, 52 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -24,14 +24,4 @@ extern void cmpxchg8b_emu(void);
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -41,36 +41,6 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 .endm
 
 /*
- * This generates .altinstr_replacement symbols for use by objtool. They,
- * however, must not actually live in .altinstr_replacement since that will be
- * discarded after init, but module alternatives will also reference these
- * symbols.
- *
- * Their names matches the "__x86_indirect_" prefix to mark them as retpolines.
- */
-.macro ALT_THUNK reg
-
-	.align 1
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	call	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_call_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	jmp	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
-
-.endm
-
-/*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
  * only see one instance of "__x86_indirect_thunk_\reg" rather
@@ -92,15 +62,3 @@ STACK_FRAME_NON_STANDARD(__x86_indirect_
 #undef GEN
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) ALT_THUNK reg
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
-#include <asm/GEN-for-each-reg.h>


