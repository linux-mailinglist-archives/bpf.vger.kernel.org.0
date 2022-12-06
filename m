Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8F644F7F
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLFXTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:19:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5221CFFA
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:19:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id x22so9985102ejs.11
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TfYnZ/otmb8hn7xYZXW0YG63dzswQ5Z2DZH+NWQOtI=;
        b=P5vIneV8IVnQw5c9s95zOrZjju/POmELZMyQHgODfjiSztgztfcmpFS9vuBeM08oR9
         IDFQ+POz+1z44pLxXRMKBEjYKmdAX5Mgj7hMuveruFYXw37XlguYJZsesDYdUihwtBf9
         PbO/dHTNkfZs3Ldw2PGtfn4iKo1V+0Tw9lLgQn+ASFi7vHcRMwc0c+JpUmxl7Wk/iWEX
         afdUn8wM9GwUmcL2skjKifhGUH0MN7Uf9W70xZiyhFZX+RzQx+dLmAOs2iU6mPRo9HXl
         aPBjTyuwBPtmdUmOlESHKV872HAtObwGN5KFx/KYYeCcjozVsGzrVbGsHRKsjywDwO6u
         1bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TfYnZ/otmb8hn7xYZXW0YG63dzswQ5Z2DZH+NWQOtI=;
        b=iTWsBIKZ2qNMUG6iUaS71FwrSfXSFuhrNO8doqxW6lxLwVr0udkZKumHB2tXfV/Eye
         z0Z7hTEwutzWjTvKuhtCYFFupSw6ffiYdkGHnXZWGGV8SsfTvYtXOsCXSW4w7CGRJFQe
         Crb+Fy3q6i6IvJPlSTQmpM1eWSMMvVNDOYDFYM5hqDjUxa5/SoSzcLc+y3d4WsJx9FPF
         Ko9WASujlUn2lmRfUCJrItzdsTyxxabbDYpTxi6hDxLGYZPjfqxzt4Pb0kpFlGdKlnuq
         xJ7Fx+5zgrNv6CzU+NjAXE24DaPrA4sr0G7xAUq1wAdqHjfGTbCKX3rBDaTc6FccZFjV
         w0EA==
X-Gm-Message-State: ANoB5pkQhXWlV1yI5hNkL9Ms5TJXexXVnJzz5oPxzidL9c/jYiiB49hv
        Qau9xH/H+/zf6xBZAhpNj1ySOjjcgHZ64oa1JkjiSaEklt4=
X-Google-Smtp-Source: AA0mqf78jJ12jaciLg31S8xEx/V0qikwlFu3UXzoWJiyaBwduUdrCmg6aJ1l7uBjT/39QeEKdnm06kI3p63i5K+012U=
X-Received: by 2002:a17:906:3e53:b0:7c1:1f2b:945f with SMTP id
 t19-20020a1709063e5300b007c11f2b945fmr191393eji.302.1670368770641; Tue, 06
 Dec 2022 15:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20221202051030.3100390-1-andrii@kernel.org> <20221202051030.3100390-4-andrii@kernel.org>
 <638fbfe234d9b_8a91208f5@john.notmuch>
In-Reply-To: <638fbfe234d9b_8a91208f5@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 15:19:17 -0800
Message-ID: <CAEf4BzZUXqN=wSVoKoCuC3DT0pDwrWEOLg-A4=7m7DZ=pYdkPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: remove unnecessary prune and jump points
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Dec 6, 2022 at 2:19 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > Don't mark some instructions as jump points when there are actually no
> > jumps and instructions are just processed sequentially. Such case is
> > handled naturally by precision backtracking logic without the need to
> > update jump history.
> >
>
> Sorry having trouble matching up commit message with code below.

Sorry, not clear which part? I'm referring to the logic in
get_prev_insn_idx() here, where we go linearly one instruction
backwards, unless last jmp_history entry matches current instruction.
In the latter case we go to the st->jmp_history[cnt - 1].prev_idx
(non-linear case).

>
> > Also remove both jump and prune point marking for instruction right
> > after unconditional jumps, as program flow can get to the instruction
> > right after unconditional jump instruction only if there is a jump to
> > that instruction from somewhere else in the program. In such case we'll
> > mark such instruction as prune/jump point because it's a destination of
> > a jump.
> >
> > This change has no changes in terms of number of instructions or states
> > processes across Cilium and selftests programs.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 75a56ded5aca..03c2cc116292 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12209,13 +12209,10 @@ static int visit_func_call_insn(int t, int insn_cnt,
> >       if (ret)
> >               return ret;
> >
> > -     if (t + 1 < insn_cnt) {
> > -             mark_prune_point(env, t + 1);
> > -             mark_jmp_point(env, t + 1);
> > -     }
> > +     mark_prune_point(env, t + 1);

I'm now thinking that maybe here we actually need to keep jmp_point,
as we don't record a jump point for the target of EXIT instruction in
subprog. I'll add this back.

> > +
> >       if (visit_callee) {
> >               mark_prune_point(env, t);
> > -             mark_jmp_point(env, t);
> >               ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env,
> >                               /* It's ok to allow recursion from CFG point of
> >                                * view. __check_func_call() will do the actual
> > @@ -12249,15 +12246,13 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
> >               return DONE_EXPLORING;
> >
> >       case BPF_CALL:
> > -             if (insns[t].imm == BPF_FUNC_timer_set_callback) {
> > +             if (insns[t].imm == BPF_FUNC_timer_set_callback)
> >                       /* Mark this call insn to trigger is_state_visited() check
>
> maybe fix the comment here?

It's not broken, but would you like me to explicitly state "Mark this
call insn as a prune point to trigger..."?

>
> >                        * before call itself is processed by __check_func_call().
> >                        * Otherwise new async state will be pushed for further
> >                        * exploration.
> >                        */
> >                       mark_prune_point(env, t);
> > -                     mark_jmp_point(env, t);
> > -             }
> >               return visit_func_call_insn(t, insn_cnt, insns, env,
> >                                           insns[t].src_reg == BPF_PSEUDO_CALL);
> >
> > @@ -12271,26 +12266,15 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
> >               if (ret)
> >                       return ret;
> >
> > -             /* unconditional jmp is not a good pruning point,
> > -              * but it's marked, since backtracking needs
> > -              * to record jmp history in is_state_visited().
> > -              */
> >               mark_prune_point(env, t + insns[t].off + 1);
> >               mark_jmp_point(env, t + insns[t].off + 1);
> > -             /* tell verifier to check for equivalent states
> > -              * after every call and jump
> > -              */
> > -             if (t + 1 < insn_cnt) {
> > -                     mark_prune_point(env, t + 1);
> > -                     mark_jmp_point(env, t + 1);
>
> This makes sense to me its unconditional jmp. So no need to
> add jmp point.
>

yep

> > -             }
> >
> >               return ret;
> >
> >       default:
> >               /* conditional jump with two edges */
> >               mark_prune_point(env, t);
> > -             mark_jmp_point(env, t);
>
>                  ^^^^^^^^^^^^^^^^^^^^^^^
>
> Specifically, try to see why we dropped this jmp_point?

Because there is nothing special about current instruction (which is a
conditional jump instruction). If we got here sequentially, no need to
record jmp_history. If we jumped here from somewhere non-linearly, we
should have already marked this instruction as jmp_point in push_insn
(with e == BRANCH).

So jmp_point is completely irrelevant, the goal here is to force state
checkpointing before we process jump instruction.

Also keep in mind that we mark *destination* of non-linear jump as a
jump point. So target of function call, jump, etc, but not call
instruction or jump instruction itself.


>
> > +
> >               ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
> >               if (ret)
> >                       return ret;
> > --
> > 2.30.2
> >
>
>
