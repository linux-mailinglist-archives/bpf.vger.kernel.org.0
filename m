Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8334D9855
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiCOKHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 06:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346828AbiCOKHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 06:07:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B55B4D613;
        Tue, 15 Mar 2022 03:06:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h5so14434661plf.7;
        Tue, 15 Mar 2022 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e3GKHOfRQ4ORNpQrFF/avUlyssKD0FNxVc07wzqHEWI=;
        b=gRl8+UZVfoXnH/oXAfDIY1v4dcDaymUqDuf5uzlcfZ1K+eiFbXMl6QcJQxBETTA2OJ
         E38sL8kBw+66IUfMl+qahgizA7ThsjsZl/oM/aBCHfzoywAmL76ZebVl3rrGjamV7Xev
         K3jQc4FuP09qmvPwVpeZyGdV6W1x8TR/UIo3BOcf29PD4MNJMaWpq1SmWDdCMALMv4Qa
         lKryuQ69ostthFBq+WVgwvlw1PG2lbTwsia9av2EbjEQL3Q9mCkdtn5pJ9RIjAmTtXLn
         9s0JlNH7u/4uqpnhNiRQ/60IX7oL0nCvFrXMztQ208Htp26bZHZIKzf4XPaYLHCyl08Q
         +Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3GKHOfRQ4ORNpQrFF/avUlyssKD0FNxVc07wzqHEWI=;
        b=Sn3dHwhcCsjzYxJuPeZ6dkmgbgj7Ti9hGdYCIQXtn1SLGLOLh+dSwk3sJN2hPcCzks
         Amu8RtbbcFgz2KzQg6AZ1QP3vRDtySPoJo5jWvPMWlf2ppHHAWR35TV661dvvpicEk5A
         6GD7zd+tlQkGBaFjEzyJVHJzwxTe2ICkntVn8sMW4Ydhfi845gG8FmyTEi+bkxoHzZRL
         +X84nYsbIqSsIyDdxSiYOyK8NAMEIdHzQfm3Yt5riT336RRHhyprb0emHd341smG1urj
         iOpQL08tZis2kpThzh0Omp6l7KrMrolc5Fn0hT6mMOPv1Z53+jkNSr7yiUFh76e+1URN
         Ll/w==
X-Gm-Message-State: AOAM531Yg0djUqYA/MW8E37XGl1RPVO/dw37raDxvp0otmTcRnQ5ju0a
        PZ1/0g4vG+ebJD+i7sbL4OA=
X-Google-Smtp-Source: ABdhPJwZwT09z8iRY84DMQxj0BOKL97bGFmNqmR7miz89dP85eaYvwBOK1RR5T66sh2rJik6oI9h9A==
X-Received: by 2002:a17:902:f606:b0:14b:4c2d:e1fa with SMTP id n6-20020a170902f60600b0014b4c2de1famr27054696plg.24.1647338767910;
        Tue, 15 Mar 2022 03:06:07 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm6672058pfc.98.2022.03.15.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:06:07 -0700 (PDT)
Date:   Tue, 15 Mar 2022 15:35:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20220315100559.amhxiba3nqdyrkef@apollo>
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
 <20220315090043.GB8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315090043.GB8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 02:30:43PM IST, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 02:14:02AM +0530, Kumar Kartikeya Dwivedi wrote:
>
> > [ Note: I have no experience with trampoline code or IBT so what follows might
> > 	be incorrect. ]
> >
> > In case of fexit and fmod_ret, we call original function (but skip
> > X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
> > cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
> > (gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.
> >
> > This means for do_init_module module, orig_call += X86_PATCH_SIZE +
> > ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
> > function, which explains why I was seeing crash in the middle of
> > 'mov edx, 0x10' instruction.
> >
> > The diff below fixes the problem for me, and allows the test to pass.
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index b98e1c95bcc4..760c9a3c075f 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >
> >         ip_off = stack_size;
> >
> > -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> >                 /* skip patched call instruction and point orig_call to actual
> >                  * body of the kernel function.
> >                  */
> > -               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
> > +               if (is_endbr(*(u32 *)orig_call))
> > +                       orig_call += ENDBR_INSN_SIZE;
> > +               orig_call += X86_PATCH_SIZE;
> > +       }
> >
> >         prog = image;
>
> Hmm, so I was under the impression that this was targeting the NOP from
> emit_prologue(), and that has an unconditional ENDBR. If this is instead
> targeting the 'start of random kernel function' then yes, what you
> propose will work.
>
> (obviously, once we go do more complicated CFI schemes, all this needs
> revisiting yet again).
>
> I don't seem able to run this mod_race test, it keeps saying:
>
>   tgl-build# ./test_progs -v -t mod_race
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   Summary: 0/0 PASSED, 0 SKIPPED, 0 FAILED
>   Successfully unloaded bpf_testmod.ko.
>

`./test_progs -v -t bpf_mod_race` should work.

> Which I'm taking to mean I'm doing it wrong... so I can't immediately
> verify, but your proposal looks sane so I'll fold it in.
>
> Thanks!

--
Kartikeya
