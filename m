Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC34D533E
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiCJUup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 15:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiCJUuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 15:50:44 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8C186452
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 12:49:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n19so11538621lfh.8
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoJnjb1eTkY6RbpEBPOSq+mDiZAbj8l9xQTfBcxy8oU=;
        b=Y7FvDAJsL40Mo2PA9+bZiLPYtKMnLPXzXJ5HLFicNxmCzZdjJYLjv5yqpsyhCi7vOr
         CD+QPTbXobrKHAuNAA7EVyR6s5AJ2oTb3lHlMncdUyYPQ4ai6e5Om/5yCjw+F2P89/hF
         lzvVtisopmYw9PsQWFgxf4X1aLVZkcgRXPVxUBeu2A8j9m7lL4/+HuQTMMTU8yAuUPIr
         /9UskIi+Izx38o1RWUn/mGiOU115InWglwpA0y6MGBMTHlx/0TvsozCBTKVyaBjguFqC
         U25qw5VYUkLud9lfcYzlxnt+DNX0zT/h2pGf4bXY+rXL37GWa3nX4nAjILfxiBwfELTC
         y3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoJnjb1eTkY6RbpEBPOSq+mDiZAbj8l9xQTfBcxy8oU=;
        b=EqkxcJVUXQBajDhK+stwQewp2rNmasskB8rVh2kTPtbT51SMLlGGyiGBQHlY8ni6Lu
         HcujUcpOFfsotu8W+I/jv27MeE3OWy709Wnx90DopIBUjJkqPoRppGFUaKX2HpMoNXnw
         fQGa5PmTWVnF/j1cKdJ38zBKfIjYBmR8oxWC0j9sxw2tIdtdHJA/wklseBDhhSST9egp
         vOPRFOk0oBkmoQpj78jLjCd1mT+tlnQzzH9jJRqhPAj4l4gDf53lomKFm+jb4kJkhfop
         OQ2TDS/meQ0EosDdeKo8MGXSeShWMD+KYWMkqRQ/ys6P62XTMpRqgmNEjKOEXax/Du5i
         syFw==
X-Gm-Message-State: AOAM532s5oYT0E+TxUZdeBLudNGQRvR/IrGHaT+hHdzsPX4ozgap3Gpk
        gjwEyIQtv6ABxMcwWSaJt+goUwRp4WbI07oIOfjbNw==
X-Google-Smtp-Source: ABdhPJy8imNzaXNZDqs43TGptWccGDGO5gCC4bQU1a3VTUFE15BERAeVO8Mg8dbe5wwLt+vA1yx3Tir6Y+d/zYS/XIE=
X-Received: by 2002:a05:6512:31d4:b0:445:e4ef:c0f8 with SMTP id
 j20-20020a05651231d400b00445e4efc0f8mr4046529lfe.626.1646945381031; Thu, 10
 Mar 2022 12:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20220308153011.021123062@infradead.org> <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net> <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
 <Yim/QJhNBCDfuxsc@hirez.programming.kicks-ass.net> <184d593713ca4e289ddbd7590819eddc@AcuMS.aculab.com>
 <YinP49gEl2zUVekz@hirez.programming.kicks-ass.net>
In-Reply-To: <YinP49gEl2zUVekz@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Mar 2022 12:49:29 -0800
Message-ID: <CAKwvOdkyi1c9TvP_Bzn3+71kKsJzAbQZmgDzfDM8c7sce-V0Dw@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 2:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 10, 2022 at 09:22:59AM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 10 March 2022 09:05
> > >
> > > On Wed, Mar 09, 2022 at 04:30:28PM -0800, Nick Desaulniers wrote:
> > >
> > > > I observed the following error when building with
> > > > CONFIG_LTO_CLANG_FULL=y enabled:
> > > >
> > > > ld.lld: error: ld-temp.o <inline asm>:7:2: symbol 'ibt_selftest_ip' is
> > > > already defined
> > > >         ibt_selftest_ip:
> > > >         ^
> > > >
> > > > Seems to come from
> > > > commit a802350ba65a ("x86/ibt: Add IBT feature, MSR and #CP handling")
> > > >
> > > > Commenting out the label in the inline asm, I then observed:
> > > > vmlinux.o: warning: objtool: identify_cpu()+0x6d0: sibling call from
> > > > callable instruction with modified stack frame
> > > > vmlinux.o: warning: objtool: identify_cpu()+0x6e0: stack state
> > > > mismatch: cfa1=4+64 cfa2=4+8
> > > > These seemed to disappear when I kept CONFIG_LTO_CLANG_FULL=y but then
> > > > disabled CONFIG_X86_KERNEL_IBT. (perhaps due to the way I hacked out
> > > > the ibt_selftest_ip label).
> > >
> > LTO has probably inlined it twice.
>
> Indeed, adding noinline to ibt_selftest() makes it work.

Yep, that LGTM. If you end up sticking that as a patch on top:

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

For the kernel IBT series @ v4 plus this diff:

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # llvm build, non-IBT boot

>
>
> ---
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d8bbc705efe5..0c737cc31ee5 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -781,7 +781,8 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
>         return NOTIFY_STOP;
>  }
>
> -static void __init int3_selftest(void)
> +/* Must be noinline to ensure uniqueness of int3_selftest_ip. */
> +static noinline void __init int3_selftest(void)
>  {
>         static __initdata struct notifier_block int3_exception_nb = {
>                 .notifier_call  = int3_exception_notify,
> @@ -794,9 +795,8 @@ static void __init int3_selftest(void)
>         /*
>          * Basically: int3_magic(&val); but really complicated :-)
>          *
> -        * Stick the address of the INT3 instruction into int3_selftest_ip,
> -        * then trigger the INT3, padded with NOPs to match a CALL instruction
> -        * length.
> +        * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
> +        * notifier above will emulate CALL for us.
>          */
>         asm volatile ("int3_selftest_ip:\n\t"
>                       ANNOTATE_NOENDBR
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 837cc3c7d4f4..fb89a2f1011f 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -214,7 +214,7 @@ DEFINE_IDTENTRY(exc_overflow)
>
>  static __ro_after_init bool ibt_fatal = true;
>
> -void ibt_selftest_ip(void); /* code label defined in asm below */
> +extern void ibt_selftest_ip(void); /* code label defined in asm below */
>
>  enum cp_error_code {
>         CP_EC        = (1 << 15) - 1,
> @@ -238,7 +238,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>         if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
>                 return;
>
> -       if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
> +       if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {

(Though adding the address of operator & to the function name in the
comparisons isn't strictly necessary; functions used in expressions
"decay" into function pointers; I guess the standard calls these
"function designators." I see that's been added to be consistent
between the two...See 6.3.2.1.4 of
http://open-std.org/jtc1/sc22/wg14/www/docs/n2731.pdf pdf page
62/printed page 46.)

>                 regs->ax = 0;
>                 return;
>         }
> @@ -252,7 +252,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>         BUG();
>  }
>
> -bool ibt_selftest(void)
> +/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
> +noinline bool ibt_selftest(void)
>  {
>         unsigned long ret;
>


-- 
Thanks,
~Nick Desaulniers
