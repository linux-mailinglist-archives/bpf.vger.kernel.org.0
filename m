Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D2D63E677
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 01:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLAA1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLAA1O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3E5803E
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:27:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id o13so554649ejm.1
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9L2/o4DjNvsKtf4vJyCxsV908nQ9XgkKjPkf2rPK7g=;
        b=fjoL8uNkizLG4UtR5nwUFrXvqJ06CZswl34ol87rFPVFJB9YF9UEtCBkBww+RBeKo1
         Fdu65xZCSlXqMRA7vvTtdrQ9Cw6RwlVY4QZhsON7QK8CIFjLitWsbcFdBt2Twy3foNg4
         DXVmjgQpRyFvZAxLRf8zE+dqLdJvDJQ5Mq0mR9y5bX6TX5SKcpCglDD1pORZacXoXQTu
         ekne6fkmXUzeZIUAkcAuCrr1uOL3vqy4kJ5jmHfNAdwZJ9VUo2IRNOf9bOaSy+4XQWlU
         rWTZYVqUmaH9k2JuuWVEDLCx51JlViMUCxhXYOuhVNWWNOb7vh/vIvvKMdHqk3q2zjyP
         2aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9L2/o4DjNvsKtf4vJyCxsV908nQ9XgkKjPkf2rPK7g=;
        b=UqA6WUtx95fSXpf6DC4/cyTJal/kt0M9AV7H7fpfzGvMrViCukUZWBoA0/Q+1i3jJi
         RreNC7Kidd32FnQ8/pdHKoaNWJaH16HjgV7F/ZX5I0Lnu+T6qHjnCFGqARhfaJADzSj9
         7G8Ou2pQKQ2mSzorAKwXLPyhKRQd+HO5c2wmE7hb0kpkjjS6TqEarsb6k4br8XTrEKGt
         K6Y5Lk4J62RM9+BsSIzt3UlwGIZrvxYPEbnKxO8zuHP6kWQJdZpnwRDZaIMt92NwzHta
         /qPYU6uZAFQcSGxpJqOXF3zJLRE3wjjVnVhYHRlWYi5aMdcb/QBzRd3B6ewWTUL7f5U6
         cajw==
X-Gm-Message-State: ANoB5pk0zjXaoGt7TFigh++jNiaEuPBjwAlQfI4eQe/FlIMVHWDhFgin
        T7YOhQcif86SYseLURmwhMuHA4DuG0/VMNYxQOg=
X-Google-Smtp-Source: AA0mqf623ezpfhxD1LtSQUEQ+7xuUol9cxNZ+mDrpnZ8BUGG4uDDKZ/KDobNLkWtATi0jmQ+gFT65eaydBoyrpPM6Uo=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr39524381ejb.745.1669854431414; Wed, 30
 Nov 2022 16:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20221128163442.280187-1-eddyz87@gmail.com> <20221128163442.280187-2-eddyz87@gmail.com>
In-Reply-To: <20221128163442.280187-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 16:26:59 -0800
Message-ID: <CAEf4BzZBYQ2EXH4Rj8kmTFb08SkRpnpesjpj6X-AKAtsJnuV6g@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: verify scalar ids mapping in regsafe()
 using check_ids()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Mon, Nov 28, 2022 at 8:35 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Prior to this commit the following unsafe example passed verification:
>
> 1: r9 = ... some pointer with range X ...
> 2: r6 = ... unbound scalar ID=a ...
> 3: r7 = ... unbound scalar ID=b ...
> 4: if (r6 > r7) goto +1
> 5: r6 = r7
> 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created here
> 7: r9 += r7
> 8: *(u64 *)r9 = Y
>
> This example is unsafe because not all execution paths verify r7 range.
> Because of the jump at (4) the verifier would arrive at (6) in two states:
> I.  r6{.id=b}, r7{.id=b} via path 1-6;
> II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
>
> Currently regsafe() does not call check_ids() for scalar registers,
> thus from POV of regsafe() states (I) and (II) are identical. If the
> path 1-6 is taken by verifier first and checkpoint is created at (6)
> the path 1-4, 6 would be considered safe.
>
> This commit makes the following changes:
> - a call to check_ids() is added in regsafe() for scalar registers case;
> - a function mark_equal_scalars_as_read() is added to ensure that
>   registers with identical IDs are preserved in the checkpoint states
>   in case when find_equal_scalars() updates register range for several
>   registers sharing the same ID.
>

Fixes tag missing?

These are tricky changes with subtle details. Let's split check_ids()
change and all the liveness manipulations into separate patches? They
are conceptually completely independent, right?


> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6599d25dae38..8a5b7192514a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10638,10 +10638,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                                 /* case: R1 = R2
>                                  * copy register state to dest reg
>                                  */
> -                               if (src_reg->type == SCALAR_VALUE && !src_reg->id)
> +                               if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
> +                                   !tnum_is_const(src_reg->var_off))
>                                         /* Assign src and dst registers the same ID
>                                          * that will be used by find_equal_scalars()
>                                          * to propagate min/max range.
> +                                        * Skip constants to avoid allocation of useless ID.
>                                          */
>                                         src_reg->id = ++env->id_gen;
>                                 *dst_reg = *src_reg;
> @@ -11446,16 +11448,86 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
>         return true;
>  }
>
> +/* Scalar ID generation in check_alu_op() and logic of
> + * find_equal_scalars() make the following pattern possible:
> + *
> + * 1: r9 = ... some pointer with range X ...
> + * 2: r6 = ... unbound scalar ID=a ...
> + * 3: r7 = ... unbound scalar ID=b ...
> + * 4: if (r6 > r7) goto +1
> + * 5: r6 = r7
> + * 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created here
> + * 7: r9 += r7
> + * 8: *(u64 *)r9 = Y
> + *
> + * Because of the jump at (4) the verifier would arrive at (6) in two states:
> + * I.  r6{.id=b}, r7{.id=b}
> + * II. r6{.id=a}, r7{.id=b}
> + *
> + * Relevant facts:
> + * - regsafe() matches ID mappings for scalars using check_ids(), this makes
> + *   states (I) and (II) non-equal;
> + * - clean_func_state() removes registers not marked as REG_LIVE_READ from
> + *   checkpoint states;
> + * - mark_reg_read() modifies reg->live for reg->parent (and it's parents);
> + * - when r6 = r7 is process the bpf_reg_state is copied in full, meaning
> + *   that parent pointers are copied as well.

not too familiar with liveness handling, but is this correct and
expected? Should this be fixed instead of REG_LIVE_READ manipulations?

> + *
> + * Thus, for execution path 1-6:
> + * - both r6->parent and r7->parent point to the same register in the parent state (r7);
> + * - only *one* register in the checkpoint state would receive REG_LIVE_READ mark;

I'm trying to understand this. Clearly both r6 and r7 are read. r6 for
if (r6 > X) check, r7 for r9 manipulations. Why do we end up not
marking one of them as read using a normal logic?

I have this bad feeling I'm missing something very important here or
we have some bug somewhere else. So please help me understand which
one it is. This special liveness manipulation seems wrong.

My concern is that if I have some code like

r6 = r7;
r9 += r6;

and I never use r7 anymore after that, then we should be able to
forget r7 and treat it as NOT_INIT. But you are saying it's unsafe
right now and that doesn't make much sense to me.


> + * - clean_func_state() would remove r6 from checkpoint state (mark it NOT_INIT).
> + *
> + * Consequently, when execution path 1-4, 6 reaches (6) in state (II)
> + * regsafe() won't be able to see a mismatch in ID mappings.
> + *
> + * To avoid this issue mark_equal_scalars_as_read() conservatively
> + * marks all registers with matching ID as REG_LIVE_READ, thus
> + * preserving r6 and r7 in the checkpoint state for the example above.
> + */
> +static void mark_equal_scalars_as_read(struct bpf_verifier_state *vstate, int id)
> +{
> +       struct bpf_verifier_state *st;
> +       struct bpf_func_state *state;
> +       struct bpf_reg_state *reg;
> +       bool move_up;
> +       int i = 0;
> +
> +       for (st = vstate, move_up = true; st && move_up; st = st->parent) {
> +               move_up = false;
> +               bpf_for_each_reg_in_vstate(st, state, reg, ({
> +                       if (reg->type == SCALAR_VALUE && reg->id == id &&
> +                           !(reg->live & REG_LIVE_READ)) {
> +                               reg->live |= REG_LIVE_READ;
> +                               move_up = true;
> +                       }
> +                       ++i;
> +               }));
> +       }
> +}
> +
>  static void find_equal_scalars(struct bpf_verifier_state *vstate,
>                                struct bpf_reg_state *known_reg)
>  {
>         struct bpf_func_state *state;
>         struct bpf_reg_state *reg;
> +       int count = 0;
>
>         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -               if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
> +               if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
>                         *reg = *known_reg;
> +                       ++count;
> +               }
>         }));
> +
> +       /* Count equal to 1 means that find_equal_scalars have not
> +        * found any registers with the same ID (except self), thus
> +        * the range knowledge have not been transferred and there is
> +        * no need to preserve registers with the same ID in a parent
> +        * state.
> +        */
> +       if (count > 1)
> +               mark_equal_scalars_as_read(vstate->parent, known_reg->id);
>  }
>
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,
> @@ -12878,6 +12950,12 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                  */
>                 return equal && rold->frameno == rcur->frameno;
>
> +       /* even if two registers are identical the id mapping might diverge
> +        * e.g. rold{.id=1}, rcur{.id=1}, idmap{1->2}
> +        */
> +       if (equal && rold->type == SCALAR_VALUE && rold->id)
> +               return check_ids(rold->id, rcur->id, idmap);

nit: let's teach check_ids() to handle the id == 0 case properly
instead of guarding everything with `if (rold->id)`?

but also I think this applies not just to SCALARs, right? the memcmp()
check above has to be augmented with check_ids() for id and ref_obj_id

> +
>         if (equal)
>                 return true;
>
> @@ -12891,6 +12969,11 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                 if (env->explore_alu_limits)
>                         return false;
>                 if (rcur->type == SCALAR_VALUE) {
> +                       /* id relations must be preserved, see comment in
> +                        * mark_equal_scalars_as_read() for SCALAR_VALUE example.
> +                        */
> +                       if (rold->id && !check_ids(rold->id, rcur->id, idmap))
> +                               return false;
>                         if (!rold->precise)
>                                 return true;
>                         /* new val must satisfy old val knowledge */
> --
> 2.34.1
>
