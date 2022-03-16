Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F54DAEB5
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355244AbiCPLOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345082AbiCPLOA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 07:14:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273E64BE0;
        Wed, 16 Mar 2022 04:12:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t5so3644679pfg.4;
        Wed, 16 Mar 2022 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCxpSBs3Gx6ynfc4UHzJ++m/rIraYosWSpTUGwQPXIk=;
        b=hYB0QIH3TFBnwMq4um2DykqO+IY6LgrkypF/Vro++4c+V6P5d28O8oBBGRq3RXmf9Y
         HE0rtJIZeIoqO0zCzPRgYvaDGHlGNB3m0F6XTkPwZ3iHfYkvsZqCEs7mj3vHO2PZr/vG
         CljBkQQf2leIlM1J/xhtnbUHA0yfuhHbPDUmeySsXdneK+Uno3lN/ICBQTjd9OgzAkvC
         crea+AZcrU5DpFHcQCwOLE4uR84FsZAFS7+T6P4u2kHhxrw9xi6sBsJ6auhtfGz2z8p7
         62j8yXTAEEFrlR2iG6eItka7cWI97nvLnyL0H7M+56SQdPDn1y80MDaEzHHhOkxHQNLW
         cdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCxpSBs3Gx6ynfc4UHzJ++m/rIraYosWSpTUGwQPXIk=;
        b=3OF7t+xR5EF4rIY1uTn0fh6fYHfGawSlDD5xi0RsFQovJA5lVDWklTpLhfiTbqU1w7
         DZkwJed6/bMzwiSYMpQzxF52GBGN/JzwwMM08jK/cMbGAEyazVwddR2e6Ol/fBvYkvsO
         2gGUpE2qcwY02D8aw/iGYS+vfybjEat4mU/tXlYrVIqorp3fvxTyRQD3BZJvD1vRGZbR
         U2saOyBLbecdWoJrjgTvcsfii/Bfa7EF2kpHMgj2/ay3no7UUC5FBFhOQssoESquteqw
         vB7AljyezMrahq9NZFv2fP2twRA8j7MxCvz7bO9bof7I6LSgo78kAjn3xCBB+tUtWUuk
         KfbQ==
X-Gm-Message-State: AOAM533PVB+UOc21iHGqE5MWfMcQ/pVwxMHGcS8VOmObQP1sfPpUgyyD
        hlpMMZmwxwHuFlA8/u1bVGg=
X-Google-Smtp-Source: ABdhPJyxKGN12lCU/AXvlqPAwPWGQi/P2zrhizPyPbnWOBVLNh/X/FsxvMhdVoA92DE2xgCF8FwmnQ==
X-Received: by 2002:a05:6a00:1894:b0:4f7:288:9844 with SMTP id x20-20020a056a00189400b004f702889844mr32841290pfh.28.1647429165675;
        Wed, 16 Mar 2022 04:12:45 -0700 (PDT)
Received: from localhost ([157.51.0.106])
        by smtp.gmail.com with ESMTPSA id y32-20020a056a001ca000b004fa201a613fsm2368084pfw.196.2022.03.16.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 04:12:45 -0700 (PDT)
Date:   Wed, 16 Mar 2022 16:42:41 +0530
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
Message-ID: <20220316111241.ru77bmspycbar7dx@apollo>
References: <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
 <20220315090043.GB8939@worktop.programming.kicks-ass.net>
 <YjGvauc0NYh2XXoc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjGvauc0NYh2XXoc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 03:05:38PM IST, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 10:00:43AM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 15, 2022 at 02:14:02AM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > > [ Note: I have no experience with trampoline code or IBT so what follows might
> > > 	be incorrect. ]
> > >
> > > In case of fexit and fmod_ret, we call original function (but skip
> > > X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
> > > cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
> > > (gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.
> > >
> > > This means for do_init_module module, orig_call += X86_PATCH_SIZE +
> > > ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
> > > function, which explains why I was seeing crash in the middle of
> > > 'mov edx, 0x10' instruction.
> > >
> > > The diff below fixes the problem for me, and allows the test to pass.
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index b98e1c95bcc4..760c9a3c075f 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >
> > >         ip_off = stack_size;
> > >
> > > -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > > +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > >                 /* skip patched call instruction and point orig_call to actual
> > >                  * body of the kernel function.
> > >                  */
> > > -               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
> > > +               if (is_endbr(*(u32 *)orig_call))
> > > +                       orig_call += ENDBR_INSN_SIZE;
> > > +               orig_call += X86_PATCH_SIZE;
> > > +       }
> > >
> > >         prog = image;
> >
> > Hmm, so I was under the impression that this was targeting the NOP from
> > emit_prologue(), and that has an unconditional ENDBR. If this is instead
> > targeting the 'start of random kernel function' then yes, what you
> > propose will work.
>
> Can you confirm that orig_call can be any kernel function? Because if
> so, I'm thinking it will still do the wrong thing for a notrace
> function, that will not have a __fentry__ site, so unconditionally
> skipping those 5 bytes will place you somewhere non-sensible.
>

It fails for notrace functions, e.g. considering fentry prog, when
bpf_trampoline_link_prog -> bpf_trampoline_update eventually calls
register_fentry -> bpf_arch_text_poke, old_addr is NULL, so nop_insn is copied
to old_insn, and then that memcmp(ip, old_insn, X86_PATCH_SIZE) should fail, so
it would return -EBUSY. If you consider modify_fentry case, then register_fentry
for earlier prog must have succeeded, so it must not be notrace function.

The orig_call adjustment is only done for fexit and fmod_ret (they set CALL_ORIG
and SKIP_FRAME flags), because in case of just fentry we just continue after
ret, instead of emitting call to original function in trampoline, for those too
the bpf_arch_text_poke should fail, for the same reason as above.

> This would not be a new issue; but perhaps it should be clarified and or
> fixed.

Based on my inspection it looks fine, others can correct me if I'm wrong.

--
Kartikeya
