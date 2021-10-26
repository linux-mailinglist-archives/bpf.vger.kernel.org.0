Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AF43B1EB
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhJZMK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhJZMKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:10:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C7C061348;
        Tue, 26 Oct 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kFBT6QgbcG/LBwkHyhOSvgLp0AwadD5kRS2Ijy8PyTg=; b=mwt6ve+v4P0j599IwkmLKQjVgQ
        fG9+270F7BXIFR4eNiBG2/yLHIV9cGPzNq9GnYrky+3sCihIIUhd7Pp1LysCQ7DIY8GtpBiioa+ML
        E9BOSl422gyc8cEOPR1PbH2QpngEwJqA4OlB3DJu2LBtKsz9gMxxLL8HiTgmZPEkH6Ff3QjajfQKI
        J+TyhpCVUsppHxX9sqgxtXfv06cdkGxuFbbVAeFg2Sx9TBSKelgx6aooTa/WWHwcXfEX5ALDAMVCf
        Pr2/wK9oO+oiBmTGVScVmijyIrAwDGCwqWR8yNzj9N5VbQWgIfkzuGQcmr5yIqkDSh/mUZ5xoIThG
        xfyN4Mdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCe-00GprG-6x; Tue, 26 Oct 2021 12:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CACD300950;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D1F225E57E5D; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120310.106290934@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 08/16] x86/retpoline: Move the retpoline thunk declarations to nospec-branch.h
References: <20211026120132.613201817@infradead.org>
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


