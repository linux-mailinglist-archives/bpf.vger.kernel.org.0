Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF953ED99
	for <lists+bpf@lfdr.de>; Mon,  6 Jun 2022 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiFFSJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jun 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiFFSJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jun 2022 14:09:01 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD023CFFD
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 11:08:58 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i186so14462127vsc.9
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pibQo/tiGUQ6ymwdg8FCpNzUuYEjXV80KiCU7mhYWE=;
        b=FmPacB2qlkXRaNfuaP7mchgALpy5TfmbECTCt5bIJCbTh0GqoYaw0pu64MxsR298wV
         VAFVkIPT/52yagku8biMdiC083Z60phFZRIJ/zGLFeLTvYxnKXuMFftPrBiUBIJ49Cdl
         on7aSal48RAX8PkuSfKFFzVfwj3ZbjoZjwJr4E1N/iFWvEXdiUW/+MsZDAMAE8hPNrKf
         EtzHv41XJHvCFaF3nGETs8OBaPyFPCeStYrvoeMy9BbvoVXPhbOUIu72YxM4NEJGR9l9
         NRQnr7RutLCVpYmFu7zx0VAx92SgAS8w0+FxuL4jREfpH0BwZpnchVuKJGemUH3I8BlT
         mq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pibQo/tiGUQ6ymwdg8FCpNzUuYEjXV80KiCU7mhYWE=;
        b=It2YbLQhejIgVRi4QFlnStyIbkeuZX3dWdwgiJeCOP+5ZLQqSYg8tHvWWA5fBL7hC5
         p53fGZRcLQpcPkUEbP+hKtCOn2YBhrI/Qt8bJtL0Pl+jjW+b1ZXoVbNX7/UfFmZjaM8r
         YyKv2Mx4GaO41i9xC+GUvJfTthCUQn4Fo3r0oFFDv3HNifUTM/Q0x9/iKCX7ud5ah2lw
         vlOVaHVf+xR485t2prta8Hb5kQbNZrU5EI6olHXCxL9kpsrnw0AKPh5SkoQqz4GkPZr+
         4rK94y0lkzmB2/DN/T5FjfIH2HOY1mNUB8eBas/mpXuVl8S0IcnRmoe475+iH3dea17o
         4D7A==
X-Gm-Message-State: AOAM531A1qMMrnHZHS4Vsm/4horHwkLYVMVP7Hcaw5GUHYNrTCGeBOUG
        nY27jsTWj3ZMPTV4KYUZZHHRVmyY9e5fkPRyEoDqT4zCRjz6uw==
X-Google-Smtp-Source: ABdhPJyMTMiTbmpws3f/Xy52ykJ+IWlMdYUrSGgbHCioSDck+1UJUhGBg1AFdt19Wg7Xj3QV8nReTzKqEWBQzam824I=
X-Received: by 2002:a05:6102:3f4b:b0:337:c02d:f5d7 with SMTP id
 l11-20020a0561023f4b00b00337c02df5d7mr10250442vsv.50.1654538937144; Mon, 06
 Jun 2022 11:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-4-eddyz87@gmail.com>
 <CAJnrk1YZB_9WNtUv1yU4VacDuMUSA_iB6=Nc14fR7sw9RadZ2Q@mail.gmail.com> <b6aa2c2c048cab8687bc22eb5ee14820cf6311f9.camel@gmail.com>
In-Reply-To: <b6aa2c2c048cab8687bc22eb5ee14820cf6311f9.camel@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 6 Jun 2022 11:08:46 -0700
Message-ID: <CAJnrk1bSXoObt+b2YH+x5oyMSJYPE89pBUW7nJm2Upnumvs8ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        song@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 4, 2022 at 5:51 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hi Joanne, thanks for the review!
>
> > On Fri, 2022-06-03 at 17:06 -0700, Joanne Koong wrote:
[...]
>
> > > +
> > > +               if (fit_for_bpf_loop_inline(aux)) {
> > > +                       if (!subprog_updated) {
> > > +                               subprog_updated = true;
> > > +                               subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
> > > +                               stack_base = -subprogs[cur_subprog].stack_depth;
> > > +                       }
> > > +                       aux->loop_inline_state.stack_base = stack_base;
> > > +               }
> > > +               if (i == subprog_end - 1) {
> > > +                       subprog_updated = false;
> > > +                       cur_subprog++;
> > > +                       if (cur_subprog < env->subprog_cnt)
> > > +                               subprog_end = subprogs[cur_subprog + 1].start;
> > > +               }
> > > +       }
> > > +
> > > +       env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
> >
> > In the case where a subprogram that is not subprogram 0 is a fit for
> > the bpf loop inline and thus increases its stack depth, won't
> > env->prog->aux->stack_depth need to also be updated?
>
> As far as I understand the logic in `do_check_main` and `jit_subprogs`
> `env->prog->aux->stack_depth` always reflects the stack depth of the
> first sub-program (aka `env->subprog_info[0].stack_depth`). So the
> last line of `adjust_stack_depth_for_loop_inlining` merely ensures
> this invariant. The stack depth for each relevant subprogram is
> updated earlier in the function:
>
> static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
> {
>         ...
>         for (i = 0; i < insn_cnt; i++) {
>                 ...
>                 if (fit_for_bpf_loop_inline(aux)) {
>                         if (!subprog_updated) {
>                                 subprog_updated = true;
> here  ---->                     subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
>                                 ...
>                         }
>                         ...
>                 }
>                 if (i == subprog_end - 1) {
>                         subprog_updated = false;
>                         cur_subprog++;
>                         ...
>                 }
>         }
>         ...
> }
>
> Also, the patch v3 4/5 in a series has a test case "bpf_loop_inline
> stack locations for loop vars" which checks that stack offsets for
> spilled registers are assigned correctly for subprogram that is not a
> first subprogram.
>
Thanks for the explanation :) I misunderstood what
prog->aux->stack_depth is used for

Looking at arch/arm64/net/bpf_jit_comp.c, I see this diagram

        /*
         * BPF prog stack layout
         *
         *                         high
         * original A64_SP =>   0:+-----+ BPF prologue
         *                        |FP/LR|
         * current A64_FP =>  -16:+-----+
         *                        | ... | callee saved registers
         * BPF fp register => -64:+-----+ <= (BPF_FP)
         *                        |     |
         *                        | ... | BPF prog stack
         *                        |     |
         *                        +-----+ <= (BPF_FP - prog->aux->stack_depth)
         *                        |RSVD | padding
         * current A64_SP =>      +-----+ <= (BPF_FP - ctx->stack_size)
         *                        |     |
         *                        | ... | Function call stack
         *                        |     |
         *                        +-----+
         *                          low
         *
         */
It looks like prog->aux->stack_depth is used for the "BPF prog stack",
which is the stack for the main bpf program (subprog 0)

> > > @@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
> > >         if (ret == 0)
> > >                 ret = check_max_stack_depth(env);
> > >
> > > +       if (ret == 0)
> > > +               adjust_stack_depth_for_loop_inlining(env);
> >
> > Do we need to do this before the check_max_stack_depth() call above
> > since adjust_stack_depth_for_loop_inlining() adjusts the stack depth?
>
> This is an interesting question. I used the following reasoning
> placing `adjust_stack_depth_for_loop_inlining` after the
> `check_max_stack_depth`:
>
> 1. If `adjust_stack_depth_for_loop_inlining` is placed before
>    `check_max_stack_depth` some of the existing BPF programs might
>    stop loading, because of increased stack usage.
> 2. To avoid (1) it is possible to do `check_max_stack_depth` first,
>    remember actual max depth and apply
>    `adjust_stack_depth_for_loop_inlining` only when there is enough
>    stack space. However there are two downsides:
>    - the optimization becomes flaky, similarly simple changes to the
>      code of the BPF program might cause loop inlining to stop
>      working;
>    - the precise verification itself is non-trivial as each possible
>      stack trace has to be analyzed in terms of stack size with loop
>      inlining / stack size without loop inlining. If necessary, I will
>      probably use a simpler heuristic where stack budget for register
>      spilling would be computed as
>      `MAX_BPF_STACK - actual_max_stack_depth`
> 3. Things are simpler if MAX_BPF_STACK is a soft limit that ensures
>    that BPF programs consume limited amount of stack. In such case
>    current implementation is sufficient.
>
> So this boils down to the question what is `MAX_BPF_STACK`:
> - a hard limit for the BPF program stack size?
> - a soft limit used to verify that programs consume a limited amount
>   of stack while executing?
>
> If the answer is "hard limit" I'll proceed with implementation for
> option (2).
I'm not sure either whether MAX_BPF_STACK is a hard limit or a soft
limit. I'm curious to know as well.
>
> Thanks,
> Eduard
>
