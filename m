Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F843B1C9
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhJZMHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhJZMHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:07:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66ABC061745;
        Tue, 26 Oct 2021 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Wv6DImRgiySnGcSnXMjSSpGZmAPInIBJI58+RxSTgg=; b=Yt3Aw9C6KEdXdqbNXyYgUF3yuw
        gb2iG2QJWb9pK1gY6lZrTNbJk7YwG08RZQ87/33Q9T5gHZuVxZNwpvfeJSpFPwSvv9KXotW6hnfRQ
        4D9GPxGAP2iBZPqTdZFTRcEmEjfWgyXTMFcBrQNLQ246S7moQpHZUZ5f3xel26qD+T8PrzBNAO57v
        WXHVNen2DvfWkVlvOzDdfkL+Vrtn7l4LwbHD6PvcoeaG1swyx1FmlOsl7ymUQ+5dkqTDhqcwJiyjA
        tP5g5dqa9es3D+M81HjPmOeC1EyKXmgck5jkVmaYG8FAROEP3rax0v68ef+6545rHud48IiYQ2nZ/
        c3W7D/lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCe-00CM14-77; Tue, 26 Oct 2021 12:05:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CB32300996;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1913425E57E59; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120310.041792350@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 07/16] x86/asm: Fixup odd GEN-for-each-reg.h usage
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently GEN-for-each-reg.h usage leaves GEN defined, relying on any
subsequent usage to start with #undef, which is rude.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |    2 +-
 arch/x86/lib/retpoline.S              |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,9 +19,9 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 
-#undef GEN
 #define GEN(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
+#undef GEN
 
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -55,10 +55,10 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
-#undef GEN
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
+#undef GEN


