Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177EF4D8823
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiCNPez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCNPey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 11:34:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546166572;
        Mon, 14 Mar 2022 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xs4X/y59tj7HCyhkvEPkeSgLjnXIhqNwdO4FVnEL+Lk=; b=RlpyCy17AC9KU1bMeyX9gDjqxL
        hhCYrshZ+ckxB66p0f2s35xypYHgvQDc2EhLIK7PdoZPSo2wQp0/uqOQbAADx6So/uuxagyHHv5P6
        XdYiargvDKJqFlXE8nk3voaoMbmn+MzDqvbdwT4+Erf64fMsfg1FQiDWako7LIN6Cl5xkMx6MEG/B
        ND17scnQT5kPv+cGQV8cUG/gQgJMtgSZyAm2Lb4v2QwdJfZeOYRMNuh6AEj/Ub5p6jhhIaBJN5liD
        FSUETzkzk0feqLsiTGeB47ZK26DoSp30lXMAECxM8B/LXEymhokHpV/R6syZjxTYQhqnquNeFEloW
        SRHIhZLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTmh9-000svL-FV; Mon, 14 Mar 2022 15:33:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9109C3003BC;
        Mon, 14 Mar 2022 16:33:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50B833041324E; Mon, 14 Mar 2022 16:33:13 +0100 (CET)
Date:   Mon, 14 Mar 2022 16:33:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
References: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313085214.GK28057@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 13, 2022 at 09:52:14AM +0100, Peter Zijlstra wrote:

> > and:
> > vmlinux.o: warning: objtool: ksys_unshare()+0x626: unreachable instruction
> > which stays even after make clean.
> 
> Humm, I shall have to dig out gcc-8.5 then.

Ha!, I could reproduce using the bpf-selftest .config for x86_64. Fixing
that (the __noreturn on __invalid_creds) immediately yields another one
on that .config in asm_exc_double_fault. And a missing ENDBR if you
don't build 32bit compat.

I'll go clean up ...


--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -551,6 +551,14 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
+	/*
+	 * For some configurations exc_double_fault() is a noreturn
+	 */
+1:
+	.pushsection .discard.reachable
+	.long	1b - .
+	.popsection
+
 	jmp	paranoid_exit
 
 _ASM_NOKPROBE(\asmsym)
@@ -1440,6 +1448,7 @@ SYM_CODE_END(asm_exc_nmi)
  */
 SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	mov	$-ENOSYS, %eax
 	sysretl
 SYM_CODE_END(ignore_sysret)
diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc6885cc09..9ed9232af934 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -176,7 +176,7 @@ extern int set_cred_ucounts(struct cred *);
  * check for validity of credentials
  */
 #ifdef CONFIG_DEBUG_CREDENTIALS
-extern void __invalid_creds(const struct cred *, const char *, unsigned);
+extern void __noreturn __invalid_creds(const struct cred *, const char *, unsigned);
 extern void __validate_process_creds(struct task_struct *,
 				     const char *, unsigned);
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 933155c96922..e10c15f51c1f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -870,7 +870,7 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 /*
  * report use of invalid credentials
  */
-void __invalid_creds(const struct cred *cred, const char *file, unsigned line)
+void __noreturn __invalid_creds(const struct cred *cred, const char *file, unsigned line)
 {
 	printk(KERN_ERR "CRED: Invalid credentials\n");
 	printk(KERN_ERR "CRED: At %s:%u\n", file, line);
