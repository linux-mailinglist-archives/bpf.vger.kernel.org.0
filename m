Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5661A1CB
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 21:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKDUB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKDUB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0894AF22
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:01:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so9111562edd.13
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sXraAtl4oTeqRKsNUF6AOFznfXB55x6Ui/B+dUBONuk=;
        b=nc6KBJxfnhbHJ4ALhbywojXrhkK1UgLDJhMrREoxZWf4BSLxgH6CrAzq7Brf/v1YVe
         jbkF9g8TvSJCvLQzZk7UX4/tk2FjW2moUiqjDnEVeE/wYkcZdxcjSg+h+XYC35fFfJW1
         sVqgyEgnmKm2rRhcvlfljex3vLX0Hky0+55BQ72TQSonEcsLL+H0lwPPZgO99vRnHz2q
         I8KcKZcchPeAgGs0tDYP5yE/I2k+l4OCIddbaSdmmWEZy5zHdMEkzJGrxwHpU2dgvgLN
         ZcyEKgxOgqkpbd6bs5EFLjTUa3X483X2/kQ3M2O9wyu1RK4qZY/WRq6ghIvxcUnQi1y4
         LebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXraAtl4oTeqRKsNUF6AOFznfXB55x6Ui/B+dUBONuk=;
        b=7jDDROgXlqJIsYu1AHpAHawMUh5lojW0yXu/Mnqu97tDyn0IZnJJ2dM1kP+y5nS3mG
         7DV2l6PgiPbOmeZUfeQEC+CCYhH6WZ95YlXNg5vtf/k7jOzkJGcrP7rLFY/v9XjJGZHU
         eHITGRg2oDB0fuNcyJABNiVttm3EYulAthvY1ydUvVh7F3B+KwYv52c7zpKGxTZvF2nH
         5pfvnVUHel3g35hYP546YqZSFNNrLc68kl3Y1c9g5k8TOkArTxuiZdstVSfoSlrqMN6k
         atbMkSvqRbVSkw8hmHc8zzfm0QpOf+ejmjr1KZvJ45GwmmDuBKWdjXfEmBtgTTpvlZPz
         pHBw==
X-Gm-Message-State: ACrzQf2Qbg+8hYmeViei9riQ2ZDp5U7GRb0LlPCKF4Zmq4VQmGLK39x7
        rDahLU8MzT8V1IlMyPn5N16DgUrru179RLgbVuZ5srMh
X-Google-Smtp-Source: AMsMyM41ArxFU+ey/neDSpS+38St461ruGqSJAG5/Pxbu4J8qgsiRCe+4+GpgttOIg7AFCRn+w7DMyKpZxQ2gCZIiD4=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr37774585edb.333.1667592079365; Fri, 04
 Nov 2022 13:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221102062221.2019833-1-andrii@kernel.org> <20221102062221.2019833-4-andrii@kernel.org>
 <20221103014115.x6kbehg2ongf6wof@MacBook-Pro-5.local.dhcp.thefacebook.com> <CAEf4BzbUofKU=-XzYYTn4O2YHKX1RsVZAZxDiB9-ROmkp9qrHQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbUofKU=-XzYYTn4O2YHKX1RsVZAZxDiB9-ROmkp9qrHQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Nov 2022 13:01:07 -0700
Message-ID: <CAADnVQ+0099j9WXePNThdBYFUAhrZHnFKrASnX99dUtmbM_V3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: allow precision tracking for programs
 with subprogs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Nov 4, 2022 at 9:32 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 2, 2022 at 6:41 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 01, 2022 at 11:22:18PM -0700, Andrii Nakryiko wrote:
> > > Stop forcing precise=true for SCALAR registers when BPF program has any
> > > subprograms. Current restriction means that any BPF program, as soon as
> > > it uses subprograms, will end up not getting any of the precision
> > > tracking benefits in reduction of number of verified states.
> > >
> > > This patch keeps the fallback mark_all_scalars_precise() behavior if
> > > precise marking has to cross function frames. E.g., if subprogram
> > > requires R1 (first input arg) to be marked precise, ideally we'd need to
> > > backtrack to the parent function and keep marking R1 and its
> > > dependencies as precise. But right now we give up and force all the
> > > SCALARs in any of the current and parent states to be forced to
> > > precise=true. We can lift that restriction in the future.
> > >
> > > But this patch fixes two issues identified when trying to enable
> > > precision tracking for subprogs.
> > >
> > > First, prevent "escaping" from top-most state in a global subprog. While
> > > with entry-level BPF program we never end up requesting precision for
> > > R1-R5 registers, because R2-R5 are not initialized (and so not readable
> > > in correct BPF program), and R1 is PTR_TO_CTX, not SCALAR, and so is
> > > implicitly precise. With global subprogs, though, it's different, as
> > > global subprog a) can have up to 5 SCALAR input arguments, which might
> > > get marked as precise=true and b) it is validated in isolation from its
> > > main entry BPF program. b) means that we can end up exhausting parent
> > > state chain and still not mark all registers in reg_mask as precise,
> > > which would lead to verifier bug warning.
> > >
> > > To handle that, we need to consider two cases. First, if the very first
> > > state is not immediately "checkpointed" (i.e., stored in state lookup
> > > hashtable), it will get correct first_insn_idx and last_insn_idx
> > > instruction set during state checkpointing. As such, this case is
> > > already handled and __mark_chain_precision() already handles that by
> > > just doing nothing when we reach to the very first parent state.
> > > st->parent will be NULL and we'll just stop. Perhaps some extra check
> > > for reg_mask and stack_mask is due here, but this patch doesn't address
> > > that issue.
> > >
> > > More problematic second case is when global function's initial state is
> > > immediately checkpointed before we manage to process the very first
> > > instruction. This is happening because when there is a call to global
> > > subprog from the main program the very first subprog's instruction is
> > > marked as pruning point, so before we manage to process first
> > > instruction we have to check and checkpoint state. This patch adds
> > > a special handling for such "empty" state, which is identified by having
> > > st->last_insn_idx set to -1. In such case, we check that we are indeed
> > > validating global subprog, and with some sanity checking we mark input
> > > args as precise if requested.
> > >
> > > Note that we also initialize state->first_insn_idx with correct start
> > > insn_idx offset. For main program zero is correct value, but for any
> > > subprog it's quite confusing to not have first_insn_idx set. This
> > > doesn't have any functional impact, but helps with debugging and state
> > > printing. We also explicitly initialize state->last_insns_idx instead of
> > > relying on is_state_visited() to do this with env->prev_insns_idx, which
> > > will be -1 on the very first instruction. This concludes necessary
> > > changes to handle specifically global subprog's precision tracking.
> > >
> > > Second identified problem was missed handling of BPF helper functions
> > > that call into subprogs (e.g., bpf_loop and few others). From precision
> > > tracking and backtracking logic's standpoint those are effectively calls
> > > into subprogs and should be called as BPF_PSEUDO_CALL calls.
> > >
> > > This patch takes the least intrusive way and just checks against a short
> > > list of current BPF helpers that do call subprogs, encapsulated in
> > > is_callback_calling_function() function. But to prevent accidentally
> > > forgetting to add new BPF helpers to this "list", we also do a sanity
> > > check in __check_func_call, which has to be called for each such special
> > > BPF helper, to validate that BPF helper is indeed recognized as
> > > callback-calling one. This should catch any missed checks in the future.
> > > Adding some special flags to be added in function proto definitions
> > > seemed like an overkill in this case.
> > >
> > > With the above changes, it's possible to remove forceful setting of
> > > reg->precise to true in __mark_reg_unknown, which turns on precision
> > > tracking both inside subprogs and entry progs that have subprogs. No
> > > warnings or errors were detected across all the selftests, but also when
> > > validating with veristat against internal Meta BPF objects and Cilium
> > > objects. Further, in some BPF programs there are noticeable reduction in
> > > number of states and instructions validated due to more effective
> > > precision tracking, especially benefiting syncookie test.
> > >
>
> [...]
>
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 61 ++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 60 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 7a71154de32b..cf9e20da8f6b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -511,6 +511,15 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> > >       return func_id == BPF_FUNC_dynptr_data;
> > >  }
> > >
> > > +static bool is_callback_calling_function(enum bpf_func_id func_id)
> > > +{
> > > +     return func_id == BPF_FUNC_for_each_map_elem ||
> > > +            func_id == BPF_FUNC_timer_set_callback ||
> > > +            func_id == BPF_FUNC_find_vma ||
> > > +            func_id == BPF_FUNC_loop ||
> > > +            func_id == BPF_FUNC_user_ringbuf_drain;
> > > +}
> > > +
> > >  static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
> > >                                       const struct bpf_map *map)
> > >  {
> > > @@ -1684,7 +1693,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> > >       reg->type = SCALAR_VALUE;
> > >       reg->var_off = tnum_unknown;
> > >       reg->frameno = 0;
> > > -     reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
> > > +     reg->precise = !env->bpf_capable;
> > >       __mark_reg_unbounded(reg);
> > >  }
> > >
> > > @@ -2653,6 +2662,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
> > >               if (opcode == BPF_CALL) {
> > >                       if (insn->src_reg == BPF_PSEUDO_CALL)
> > >                               return -ENOTSUPP;
> > > +                     /* BPF helpers that invoke callback subprogs are
> > > +                      * equivalent to BPF_PSEUDO_CALL above
> > > +                      */
> > > +                     if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
> > > +                             return -ENOTSUPP;
> > >                       /* regular helper call sets R0 */
> > >                       *reg_mask &= ~1;
> > >                       if (*reg_mask & 0x3f) {
> > > @@ -2816,10 +2830,39 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >               return 0;
> > >       if (!reg_mask && !stack_mask)
> > >               return 0;
> > > +
> > >       for (;;) {
> > >               DECLARE_BITMAP(mask, 64);
> > >               u32 history = st->jmp_history_cnt;
> > >
> > > +             if (last_idx < 0) {
> > > +                     /* we are at the entry into subprog, which
> > > +                      * is expected for global funcs, but only if
> > > +                      * requested precise registers are R1-R5
> > > +                      * (which are global func's input arguments)
> > > +                      */
> > > +                     if (st->curframe == 0 &&
> > > +                         st->frame[0]->subprogno > 0 &&
> > > +                         st->frame[0]->callsite == BPF_MAIN_FUNC &&
> > > +                         stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
> > > +                             bitmap_from_u64(mask, reg_mask);
> > > +                             for_each_set_bit(i, mask, 32) {
> > > +                                     reg = &st->frame[0]->regs[i];
> > > +                                     if (reg->type != SCALAR_VALUE) {
> > > +                                             reg_mask &= ~(1u << i);
> > > +                                             continue;
> > > +                                     }
> > > +                                     reg->precise = true;
> > > +                             }
> > > +                             return 0;
> > > +                     }
> > > +
> > > +                     verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
> > > +                             st->frame[0]->subprogno, reg_mask, stack_mask);
> > > +                     WARN_ONCE(1, "verifier backtracking bug");
> > > +                     return -EFAULT;
> > > +             }
> > > +
> > >               if (env->log.level & BPF_LOG_LEVEL2)
> > >                       verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
> >
> > Minor nit: maybe move above if (last_idx < 0) after this verbose() print?
> >
>
> yep, done
>
> > st->parent should be == NULL once we detected global func, right?
>
> yep, if there are no bugs
>
> >
> > If so (and considering next patches) doing reg->precise = true for this state
> > is unnecessary...
> > and then doing reg_mask &=
> > is also unnecessary since there is no st->parent to go next and no insns to backtrack, right?
> >
> > Probably worth to keep all this code anyway...
> > just for clarity and documentation purpose.
>
> You are right, there shouldn't be any more parent states. TBH, even
> this "empty" state with last_idx == -1 is quite surprising.
>
> But I thought I'd do correct precision handling just in case there is
> some jump back to first instruction, at which point we'll do state
> comparison to detect infinite loops and stuff like that. I haven't
> analyzed much if precision markings are important for such use case,
> but theoretically we can use this empty state in is_state_visited(),
> so best make sure that we don't shortcut any logic.
>
> I was actually thinking that maybe a better way to handle all this
> would be to prevent having a global func's first instruction marked as
> prune_point. But all this requires some more careful analysis and
> testing. So maybe I'll get back to this as I work on next patch set.
> It touches prune points anyways.
>
> For now, if this doesn't look wrong, let's land it as is, and I'll
> work on it some more later.
>
> Oh, one more thing. We currently don't have a check at the very end
> that reg_mask and stack_mask is zero, which should be the case for the
> main program. We probably should add it. But then global func will be
> a special case, as it could have R1-R5 as scalar input args, so those
> might end up being set in reg_mask. And we can check that using BTF.
> But I left it also for follow up, there are enough tricky changes in
> one patch set :)

Yep. Agree on all points.
This set is already tricky and it's a great improvement
for precision logic.
Though it's pushed to bpf-next I hope folks who reviewed
the precision in the past (Kumar, Daniel, others?) will
spend time carefully analyzing the patches.
