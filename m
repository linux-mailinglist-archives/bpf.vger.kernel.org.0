Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571243C5D5
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhJ0JBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbhJ0JA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC31C061348
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kFBT6QgbcG/LBwkHyhOSvgLp0AwadD5kRS2Ijy8PyTg=; b=B3P+2cVgKvFjTcLUCugS1VRym2
        vwtrWYuaDN9B3pFb7VoTGU04L7rR0NgvNlgvsBwOdNqfMZqYpVxXMfKpZIezLGWn468TkE9ok9Z/X
        TC06Qt8tB+kiMuNcFDXzcRVTFMrKKKy01K/qOpGbl3SBLVFRcTNEEsm6vMcM3GmaI/HlOm2JmFPWV
        X2F+kbsuOogHMm8kxMZDaMjlyAXiXYkSzzf40+n0FlNLVC0qsfvcergi5lfKjmcVPWvz1GqBRbkLN
        IMqSqghsxIVxYSNTvlx/ktFw0+qAGwdZXhe1GtzkJrWrOudT1guioFI7dOhsyVNHi1PYIHJ/oSFvr
        2LsQ6McQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelQ-00CWW8-4r
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99ADF300B7B
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8AC25236E43D8; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.613752336@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 09/17] x86/retpoline: Move the retpoline thunk declarations to nospec-branch.h
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Because it makes no sense to split the retpoline gunk over multiple
headers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |    8 --------
 arch/x86/include/asm/nospec-branch.h  |    7 +++++++
 arch/x86/net/bpf_jit_comp.c           |    1 -
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -17,11 +17,3 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
-#ifdef CONFIG_RETPOLINE
-
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-#undef GEN
-
-#endif /* CONFIG_RETPOLINE */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -5,6 +5,7 @@
 
 #include <linux/static_key.h>
 #include <linux/objtool.h>
+#include <linux/linkage.h>
 
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
@@ -118,6 +119,12 @@
 	".popsection\n\t"
 
 #ifdef CONFIG_RETPOLINE
+
+#define GEN(reg) \
+	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
 #ifdef CONFIG_X86_64
 
 /*
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,7 +15,6 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
-#include <asm/asm-prototypes.h>
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {


