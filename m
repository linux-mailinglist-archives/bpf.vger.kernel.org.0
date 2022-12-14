Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7264CEDA
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiLNRZQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 12:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiLNRZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 12:25:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0323380
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:25:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i15so23527972edf.2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jl6PXSImh8DubxYCRaGUB4eeu/jdr00rmfSplM8n8+c=;
        b=lgwz49803wpzFjND1o5t5m3NK9l8Di7clzmysqYR/ZLIXXy5waNUG5x5D7AkAil6kS
         j2JakLR3pdfgLjY6pS5qzqOy4GTdRRC47BKNAXnaYheO+NBheXmWOEjAUSUG2SgahQWt
         sgKEQh8/7MRrQLps10Eyb4doQNIi1800ThO3//raEIar8QsnYz3TTfNwbF7o4CPpmnjn
         Bjrgwv29CMMHdOWEDisQtL0WB2ogXJiGa9Y4xFiEX3nN64zAbuqOTWyp+EMWr/MPZgwv
         uoovqGWUIZpowvFprd4q17Ot7ceMEn8Oy3iAjUy4RhMwwN4562pxpdTYcZI9XlDggicJ
         fWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl6PXSImh8DubxYCRaGUB4eeu/jdr00rmfSplM8n8+c=;
        b=i73rtNMHkx9h8uJnn4WgqBmWYkF/+pgxQHj2xBfrzJqgMB6qiBMqjELOMhe2U9xc2Z
         5pawctkwVNMzMd9cAhViK8bbLxXHvBs55MuBPEtwhIn5Gp/2K50ckMNbwOVdE2y29S08
         ZTa1WOK8eJk+//2d35JkBTKlKZS+E8HWARiuwkKThw45dVQAavYbr/Y+Ig7IdTae/fwa
         qBNKxaFt71rcmdrwIUVKB0nYzu2sSFSJNt6/iayIAPj8cemRA44MLUrlTSVbMaRLk43o
         ty5irXnmoqxLK0xioH+9i+FiQ50Ma4nnGjZfm7H0Cwf4BiDc9i5GlYm1bBdhN02yQynW
         lewg==
X-Gm-Message-State: ANoB5pnIAeId0eCVYK7nxlJqm5Osps3nOF7gBMujPoXGUC/vUpNh6vyF
        sLlr41XXSs/FDC9LV8yM4G8jn3XpGuXKnKhR9ZQ=
X-Google-Smtp-Source: AA0mqf5d+3Q2KoMNK0VIcPekmLSO6kKCll74hqu2ZLOVhJ1z/JEhQNoAidAsJgR7bONFuUF+Z8/9pcBzJ5sii7ZSpmk=
X-Received: by 2002:aa7:d8d5:0:b0:46b:4156:76d2 with SMTP id
 k21-20020aa7d8d5000000b0046b415676d2mr43266227eds.224.1671038712205; Wed, 14
 Dec 2022 09:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-4-eddyz87@gmail.com>
 <CAEf4BzZRx8XaD4fvSA04U2iRDnmWiYzbAGTiB_MDS1RqWXztBQ@mail.gmail.com> <bcca335872185eff732dd9b11f661cc1d872cfea.camel@gmail.com>
In-Reply-To: <bcca335872185eff732dd9b11f661cc1d872cfea.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 09:24:59 -0800
Message-ID: <CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: states_equal() must build idmap for all
 function frames
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 7:33 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > verifier.c:states_equal() must maintain register ID mapping across all
> > > function frames. Otherwise the following example might be erroneously
> > > marked as safe:
> > >
> > > main:
> > >     fp[-24] = map_lookup_elem(...)  ; frame[0].fp[-24].id == 1
> > >     fp[-32] = map_lookup_elem(...)  ; frame[0].fp[-32].id == 2
> > >     r1 = &fp[-24]
> > >     r2 = &fp[-32]
> > >     call foo()
> > >     r0 = 0
> > >     exit
> > >
> > > foo:
> > >   0: r9 = r1
> > >   1: r8 = r2
> > >   2: r7 = ktime_get_ns()
> > >   3: r6 = ktime_get_ns()
> > >   4: if (r6 > r7) goto skip_assign
> > >   5: r9 = r8
> > >
> > > skip_assign:                ; <--- checkpoint
> > >   6: r9 = *r9               ; (a) frame[1].r9.id == 2
> > >                             ; (b) frame[1].r9.id == 1
> > >
> > >   7: if r9 == 0 goto exit:  ; mark_ptr_or_null_regs() transfers != 0 info
> > >                             ; for all regs sharing ID:
> > >                             ;   (a) r9 != 0 => &frame[0].fp[-32] != 0
> > >                             ;   (b) r9 != 0 => &frame[0].fp[-24] != 0
> > >
> > >   8: r8 = *r8               ; (a) r8 == &frame[0].fp[-32]
> > >                             ; (b) r8 == &frame[0].fp[-32]
> > >   9: r0 = *r8               ; (a) safe
> > >                             ; (b) unsafe
> > >
> > > exit:
> > >  10: exit
> > >
> > > While processing call to foo() verifier considers the following
> > > execution paths:
> > >
> > > (a) 0-10
> > > (b) 0-4,6-10
> > > (There is also path 0-7,10 but it is not interesting for the issue at
> > >  hand. (a) is verified first.)
> > >
> > > Suppose that checkpoint is created at (6) when path (a) is verified,
> > > next path (b) is verified and (6) is reached.
> > >
> > > If states_equal() maintains separate 'idmap' for each frame the
> > > mapping at (6) for frame[1] would be empty and
> > > regsafe(r9)::check_ids() would add a pair 2->1 and return true,
> > > which is an error.
> > >
> > > If states_equal() maintains single 'idmap' for all frames the mapping
> > > at (6) would be { 1->1, 2->2 } and regsafe(r9)::check_ids() would
> > > return false when trying to add a pair 2->1.
> > >
> > > This issue was suggested in the following discussion:
> > > https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=rVoXfr_JVm8+1Q@mail.gmail.com/
> > >
> > > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h | 4 ++--
> > >  kernel/bpf/verifier.c        | 3 ++-
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 70d06a99f0b8..c1f769515beb 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -273,9 +273,9 @@ struct bpf_id_pair {
> > >         u32 cur;
> > >  };
> > >
> > > -/* Maximum number of register states that can exist at once */
> > > -#define BPF_ID_MAP_SIZE (MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE)
> > >  #define MAX_CALL_FRAMES 8
> > > +/* Maximum number of register states that can exist at once */
> > > +#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
> >
> > this is overly pessimistic, the total number of stack slots doesn't
> > change no matter how many call frames we have, it would be better to
> > define this as:
> >
> > #define BPF_ID_MAP_SIZE (MAX_BPF_REG * MAX_CALL_FRAMES + MAX_BPF_STACK
> > / BPF_REG_SIZE)
> >
> > Unless I missed something.
>
> Current bpf_check() mechanics looks as follows:
> - do_check_{subprogs,main}() (indirectly):
>   - when a pseudo-function is called the call is processed by
>     __check_func_call(), it allocates callee's struct bpf_func_state
>     using kzalloc() and does not update ->stack and ->allocated_stack fields;
>   - when a stack write is processed by check_mem_access():
>     - check_stack_access_within_bounds() verifies that offset is within
>       0..-MAX_BPF_STACK;
>     - check_stack_write_{fixed,var}_off() calls grow_stack_state() which uses
>       realloc_array() to increase ->stack as necessary;
>     - update_stack_depth() is used to increase
>       env->subprog_info[...].stack_depth as appropriate;
> - check_max_stack_depth() verifies that cumulative stack depth does not
>   exceed MAX_BPF_STACK using env->subprog_info[...].stack_depth values.
>
> This means that during do_check_*() we can have MAX_CALL_FRAMES functions
> each with a stack of size MAX_BPF_STACK. The following example could be
> used to verify the above assumptions:
>
> {
>         "check_max_depth",
>         .insns = {
>                 BPF_ST_MEM(BPF_DW, BPF_REG_FP, -512, 0),
>                 BPF_CALL_REL(2),
>                 BPF_MOV64_IMM(BPF_REG_0, 0),
>                 BPF_EXIT_INSN(),
>
>                 BPF_ST_MEM(BPF_DW, BPF_REG_FP, -512, 0),
>                 BPF_MOV64_IMM(BPF_REG_0, 0),
>                 BPF_EXIT_INSN(),
>         },
>         .result = REJECT,
> },
>
> Here is the verifier log that shows that two frames both of size
> MAX_BPF_STACK slots were present during verification:
>
> # ./test_verifier -vv 1030
> #1030/p check_max_depth FAIL
> Unexpected error message!
>         EXP: (null)
>         RES:
> func#0 @0
> func#1 @4
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (7a) *(u64 *)(r10 -512) = 0        ; R10=fp0 fp-512_w=mmmmmmmm
> 1: (85) call pc+2
> caller:
>  R10=fp0 fp-512_w=mmmmmmmm
> callee:
>  frame1: R1=ctx(off=0,imm=0) R10=fp0
> 4: (7a) *(u64 *)(r10 -512) = 0        ; frame1: R10=fp0 fp-512_w=mmmmmmmm
> 5: (b7) r0 = 0                        ; frame1: R0_w=0
> 6: (95) exit
> returning from callee:
>  frame1: R0_w=0 R1=ctx(off=0,imm=0) R10=fp0 fp-512_w=mmmmmmmm
> to caller at 2:
>  R0_w=0 R10=fp0 fp-512_w=mmmmmmmm
>
> from 6 to 2: R0_w=0 R10=fp0 fp-512_w=mmmmmmmm
> 2: (b7) r0 = 0                        ; R0_w=0
> 3: (95) exit
> combined stack size of 2 calls is 1024. Too large
> verification time 541 usec
> stack depth 512+512
>

It's all true, but I'm not clear on what point you are trying to make.
BPF program did get rejected after using so much stack trace, right?
So it should be ok to reduce idmap size.

It's the difference between maintaining 152 (which is already quite
overpesimisstic for any real application) vs 600 entries (1216 bytes
vs 4800 bytes). On each state equality check call. We can probably
just drop that WARN_ON_ONCE(1) in check_ids and reduce the size of
idmap, no more changes, right?

> >
> >
> >
> > >  struct bpf_verifier_state {
> > >         /* call stack tracking */
> > >         struct bpf_func_state *frame[MAX_CALL_FRAMES];
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index d05c5d0344c6..9188370a7ebe 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -13122,7 +13122,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
> > >  {
> > >         int i;
> > >
> > > -       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
> > >         for (i = 0; i < MAX_BPF_REG; i++)
> > >                 if (!regsafe(env, &old->regs[i], &cur->regs[i],
> > >                              env->idmap_scratch))
> > > @@ -13146,6 +13145,8 @@ static bool states_equal(struct bpf_verifier_env *env,
> > >         if (old->curframe != cur->curframe)
> > >                 return false;
> > >
> > > +       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
> > > +
> > >         /* Verification state from speculative execution simulation
> > >          * must never prune a non-speculative execution one.
> > >          */
> > > --
> > > 2.34.1
> > >
>
