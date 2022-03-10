Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A164D445B
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 11:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiCJKRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 05:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiCJKRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 05:17:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFB13D934;
        Thu, 10 Mar 2022 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QxtDdpYcf2JOJsi93GYP3dL8Ehp+16/1AcbmlLBV8SI=; b=DfaF72qUfGgARtmwcXdEeQaVt6
        +UkPOlx2TBKBhG5WEVjjZ5Nshc+6uAKuTHeqpCbhZjZVAngNTGN8APsy0tsHTocIhXGjaaCK+o4uj
        Ya7FMADf+iaWzf8fy9Qv93yuv+NWuxDKH44KMppwWWKQ18yW8ZNG8/9y1cNcTnSL1mPKzMDEJS9su
        HFy9JLFEIffeGJtgfcIDX/ANlFCZocLXeCXbrc5IE99qinD6DHKl4EswHu3DGQB0hJDOEQ3YKv1rp
        y+LSoMjDOkJKM5ntw6YEFwElx0Ewwi1fgDERMNJ39+9Jnp7BzX0Q4IwVTcpeqIWiLK/Tt+iVuSbpX
        YK09Y1Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSFq2-00H50N-2H; Thu, 10 Mar 2022 10:16:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7791C30027B;
        Thu, 10 Mar 2022 11:16:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AD152B52E224; Thu, 10 Mar 2022 11:16:03 +0100 (CET)
Date:   Thu, 10 Mar 2022 11:16:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YinP49gEl2zUVekz@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
 <Yim/QJhNBCDfuxsc@hirez.programming.kicks-ass.net>
 <184d593713ca4e289ddbd7590819eddc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184d593713ca4e289ddbd7590819eddc@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 09:22:59AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 10 March 2022 09:05
> > 
> > On Wed, Mar 09, 2022 at 04:30:28PM -0800, Nick Desaulniers wrote:
> > 
> > > I observed the following error when building with
> > > CONFIG_LTO_CLANG_FULL=y enabled:
> > >
> > > ld.lld: error: ld-temp.o <inline asm>:7:2: symbol 'ibt_selftest_ip' is
> > > already defined
> > >         ibt_selftest_ip:
> > >         ^
> > >
> > > Seems to come from
> > > commit a802350ba65a ("x86/ibt: Add IBT feature, MSR and #CP handling")
> > >
> > > Commenting out the label in the inline asm, I then observed:
> > > vmlinux.o: warning: objtool: identify_cpu()+0x6d0: sibling call from
> > > callable instruction with modified stack frame
> > > vmlinux.o: warning: objtool: identify_cpu()+0x6e0: stack state
> > > mismatch: cfa1=4+64 cfa2=4+8
> > > These seemed to disappear when I kept CONFIG_LTO_CLANG_FULL=y but then
> > > disabled CONFIG_X86_KERNEL_IBT. (perhaps due to the way I hacked out
> > > the ibt_selftest_ip label).
> > 
> > Urgh.. I'm thikning this is a clang bug :/
> > 
> > The code in question is:
> > 
> > 
> > void ibt_selftest_ip(void); /* code label defined in asm below */
> > 
> > DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> > {
> > 	/* ... */
> > 
> > 	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
> > 		regs->ax = 0;
> > 		return;
> > 	}
> > 
> > 	/* ... */
> > }
> > 
> > bool ibt_selftest(void)
> > {
> > 	unsigned long ret;
> > 
> > 	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
> > 	     ANNOTATE_RETPOLINE_SAFE
> > 	     "	jmp *%%rax\n\t"
> > 	     "ibt_selftest_ip:\n\t"
> > 	     UNWIND_HINT_FUNC
> > 	     ANNOTATE_NOENDBR
> > 	     "	nop\n\t"
> > 
> > 	     : "=a" (ret) : : "memory");
> > 
> > 	return !ret;
> > }
> > 
> > There is only a single definition of that symbol, the one in the asm.
> > The other is a declaration, which is used in the exception handler to
> > compare against regs->ip.
> 
> LTO has probably inlined it twice.

Indeed, adding noinline to ibt_selftest() makes it work.


---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d8bbc705efe5..0c737cc31ee5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -781,7 +781,8 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
 	return NOTIFY_STOP;
 }
 
-static void __init int3_selftest(void)
+/* Must be noinline to ensure uniqueness of int3_selftest_ip. */
+static noinline void __init int3_selftest(void)
 {
 	static __initdata struct notifier_block int3_exception_nb = {
 		.notifier_call	= int3_exception_notify,
@@ -794,9 +795,8 @@ static void __init int3_selftest(void)
 	/*
 	 * Basically: int3_magic(&val); but really complicated :-)
 	 *
-	 * Stick the address of the INT3 instruction into int3_selftest_ip,
-	 * then trigger the INT3, padded with NOPs to match a CALL instruction
-	 * length.
+	 * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
+	 * notifier above will emulate CALL for us.
 	 */
 	asm volatile ("int3_selftest_ip:\n\t"
 		      ANNOTATE_NOENDBR
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 837cc3c7d4f4..fb89a2f1011f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -214,7 +214,7 @@ DEFINE_IDTENTRY(exc_overflow)
 
 static __ro_after_init bool ibt_fatal = true;
 
-void ibt_selftest_ip(void); /* code label defined in asm below */
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
 
 enum cp_error_code {
 	CP_EC        = (1 << 15) - 1,
@@ -238,7 +238,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
 		return;
 
-	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
 		regs->ax = 0;
 		return;
 	}
@@ -252,7 +252,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	BUG();
 }
 
-bool ibt_selftest(void)
+/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
+noinline bool ibt_selftest(void)
 {
 	unsigned long ret;
 
