Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3B6AAD79
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCDX2G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCDX2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:28:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF280D52A
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:28:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so24220869edb.12
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68baPydZCe51unMAYxlqbk+QOjA3Npe/QCquvz3QFIc=;
        b=aWl5Zv+k9B4hnANb574klOoSee12WbbYD7O9y5K3hduxKC/HLL7EVb94U0Z7sDaH+0
         +bKLt7mOZOi7OndkkGtHCE7GAQlbgkZLYst/pPOPVDMAk+ZSgOWxq8D6WJ/Wc7Ws6WQZ
         8WHUXN7fC73iyYSrD6YsjMvySbUEkH7zTtMgKnzar5tEWS7T/qd+fGInEbvAYBQhsEZ0
         j+3Iu5UCZTCxIbdLnkTP/zJacdIYLOB32mcFUJr43oEF6MVmbYs+aSoM5tZRyC9XzRbW
         kYX/5kesHeqmx/eT2cf8ZbPZW+NtA0kj/J/SLlGu41l6Edq+GAh2jDpSVf8kDYPwYORx
         YwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68baPydZCe51unMAYxlqbk+QOjA3Npe/QCquvz3QFIc=;
        b=HwcqkMsWWHDyisXzE1ACIdeKI6U7KRpIDY0Q+Zwl1dJqyYEN9M4fLP5eWPgiajiVCN
         Ixv4cGVxVBacaoJrflzzWVtSshDuzadoVcNmaP4kP+/QlYcU9xJS8SZw5PWcD0KiY3mv
         hnGPrQ4SPQyVfdDAy+eILfhZEmjd5v1pxG+NLXO9ZFdrDFp1xOsZAfIusAV9ZTS2iYSl
         S6+yIsc+bl0UjW09uooHQtxmSnKkJvZaPebZJjzjMqyICquYlD+Zn6rr+vs3nYJzNkci
         i4G3lo0w9YVMxC4IT/+8X+dm34xQ9Gh+5ghzoPTf6bHs8PXkZmaLJRA95hR0KVnNecVT
         ZiZQ==
X-Gm-Message-State: AO0yUKWPLrsgI2eRmydINRq2Rhmy9G220SRRzgc9YOIAKyvovdlnMJ/q
        cYJJzGWelazJxi4602A5ArtbrlyAfYWUXRywJvU=
X-Google-Smtp-Source: AK7set8lXhfihqlltsPcbqm7GVfOl3mrbpJOHNcU/TQDQhz61egDi16BnaMaV3KKrgdWthX2awsrGTBN5diW407d6AM=
X-Received: by 2002:a50:9fa8:0:b0:4ae:e5f1:7c50 with SMTP id
 c37-20020a509fa8000000b004aee5f17c50mr3498284edf.5.1677972479627; Sat, 04 Mar
 2023 15:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-14-andrii@kernel.org>
 <20230304200232.ueac44amyhpptpay@MacBook-Pro-6.local>
In-Reply-To: <20230304200232.ueac44amyhpptpay@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:27:46 -0800
Message-ID: <CAEf4BzY70w2g5giMu+qWOE0YSGWKvy1hq-pKCvHHKLcez+R2Tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/17] bpf: add support for open-coded iterator loops
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 4, 2023 at 12:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 02, 2023 at 03:50:11PM -0800, Andrii Nakryiko wrote:
> > Teach verifier about the concept of open-coded (or inline) iterators.
> >
> > This patch adds generic iterator loop verification logic, new STACK_ITE=
R
> > stack slot type to contain iterator state, and necessary kfunc plumbing
> > for iterator's constructor, destructor and next "methods". Next patch
> > implements first specific version of iterator (number iterator for
> > implementing for loop). Such split allows to have more focused commits
> > for verifier logic and separate commit that we could point later to wha=
t
> > it takes to add new kind of iterator.
> >
> > First, we add new fixed-size opaque struct bpf_iter (24-byte long) to
> > contain runtime state of any possible iterator. struct bpf_iter state i=
s
>
> Looking at the verifier changes it seems that it should be possible to su=
pport
> any sized iterator and we don't have to fit all of them in 24-bytes.
> The same bpf_iter_<kind>_{new,next,destroy}() naming convention can apply
> to types and we can have 8-byte struct bpf_iter_num
> The bpf_for() macros would work with bpf_iter_<kind> too.
> iirc that was your plan earlier (to have different structs).
> What prompted you to change that plan?

Not really, single user-facing `struct bpf_iter` was what I was going
for from the very beginning, similar to single `struct bpf_dynptr`.
But I guess they are a bit different in that there are many generic
operations applicable across different types of dynptr
(bpf_dynptr_read, write, data, slice, etc), so it makes sense to
abstract it behind single type.

Here, with iterators, besides something like "is iterator exhausted"
(not that I'm planning to add something like that), there isn't much
generic to be shared, so yeah, we can switch to one public UAPI struct
per each type of iterator and then those can be tailored to each
particular type. This will automatically work better for kfuncs as
new/next/destroy trios will have the same `struct bpf_iter_<type> *`
and it won't be possible to accidentally pass wrong bpf_iter_<type> to
wrong new/next/destroy method.

>
> > Any other iterator implementation will have to implement at least these
> > three methods. It is enforced that for any given type of iterator only
> > applicable constructor/destructor/next are callable. I.e., verifier
> > ensures you can't pass number iterator into, say, cgroup iterator's nex=
t
> > method.
>
> is_iter_type_compatible() does that, right?

yep. Currently it also anticipates generic iterator functions, but as
I mentioned above, I don't think we'll have any common methods
anyways.

>
> > +
> > +static int mark_stack_slots_iter(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
> > +                              enum bpf_arg_type arg_type, int insn_idx=
)
> > +{
> > +     struct bpf_func_state *state =3D func(env, reg);
> > +     enum bpf_iter_type type;
> > +     int spi, i, j, id;
> > +
> > +     spi =3D iter_get_spi(env, reg);
> > +     if (spi < 0)
> > +             return spi;
> > +
> > +     type =3D arg_to_iter_type(arg_type);
> > +     if (type =3D=3D BPF_ITER_TYPE_INVALID)
> > +             return -EINVAL;
>
> Do we need destroy_if_dynptr_stack_slot() equivalent here?

no, because bpf_iter is always ref-counted, so we'll always have
explicit unmark_stack_slots_iter() call, which will reset slot types

destroy_if_dynptr_stack_slot() was added because LOCAL dynptr doesn't
require explicit destruction. I mentioned this difference
(simplification for bpf_iter case) somewhere in the commit message.

>
> > +     id =3D acquire_reference_state(env, insn_idx);
> > +     if (id < 0)
> > +             return id;
> > +
> > +     for (i =3D 0; i < BPF_ITER_NR_SLOTS; i++) {
> > +             struct bpf_stack_state *slot =3D &state->stack[spi - i];
> > +             struct bpf_reg_state *st =3D &slot->spilled_ptr;
> > +
> > +             __mark_reg_known_zero(st);
> > +             st->type =3D PTR_TO_STACK; /* we don't have dedicated reg=
 type */
> > +             st->live |=3D REG_LIVE_WRITTEN;
> > +             st->ref_obj_id =3D i =3D=3D 0 ? id : 0;
> > +             st->iter.type =3D i =3D=3D 0 ? type : BPF_ITER_TYPE_INVAL=
ID;
> > +             st->iter.state =3D BPF_ITER_STATE_ACTIVE;
> > +             st->iter.depth =3D 0;
> > +
> > +             for (j =3D 0; j < BPF_REG_SIZE; j++)
> > +                     slot->slot_type[j] =3D STACK_ITER;
> > +
> > +             mark_stack_slot_scratched(env, spi - i);
>
> dynptr needs similar mark_stack_slot_scratched() fix, right?

probably yes. destroy_if_dynptr_stack_slot() is scratching slots, but
we don't call that on OBJ_RELEASE (in unmark_stack_slots_dynptr), so
yeah, we should add this for dynptrs as well

>
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > @@ -3691,8 +3928,8 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >
> >               /* regular write of data into stack destroys any spilled =
ptr */
> >               state->stack[spi].spilled_ptr.type =3D NOT_INIT;
> > -             /* Mark slots as STACK_MISC if they belonged to spilled p=
tr. */
> > -             if (is_spilled_reg(&state->stack[spi]))
> > +             /* Mark slots as STACK_MISC if they belonged to spilled p=
tr/dynptr/iter. */
> > +             if (is_stack_slot_special(&state->stack[spi]))
> >                       for (i =3D 0; i < BPF_REG_SIZE; i++)
> >                               scrub_spilled_slot(&state->stack[spi].slo=
t_type[i]);
>
> It fixes something for dynptr, right?

It's convoluted, I think it might not have a visible effect. This is
the situation of partial (e.g., single byte) overwrite of
STACK_DYNPTR/STACK_ITER, and without this change we'll leave some
slot_types as STACK_MISC, while others as STACK_DYNPTP/STACK_ITER.
This is unexpected state, but I think existing code always checks that
for STACK_DYNPTR's all 8 slots are STACK_DYNPTR.

So I think it's a good clean up, but no consequences for dynptr
correctness. And for STACK_ITER I don't have to worry about such mix,
if any of the slot_type[i] is STACK_ITER, then it's a correct
iterator.

>
> > +static int process_iter_next_call(struct bpf_verifier_env *env, int in=
sn_idx,
> > +                               struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +     struct bpf_verifier_state *cur_st =3D env->cur_state, *queued_st;
> > +     struct bpf_func_state *cur_fr =3D cur_st->frame[cur_st->curframe]=
, *queued_fr;
> > +     struct bpf_reg_state *cur_iter, *queued_iter;
> > +     int iter_frameno =3D meta->iter.frameno;
> > +     int iter_spi =3D meta->iter.spi;
> > +
> > +     BTF_TYPE_EMIT(struct bpf_iter);
> > +
> > +     cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[iter_spi=
].spilled_ptr;
> > +
> > +     if (cur_iter->iter.state !=3D BPF_ITER_STATE_ACTIVE &&
> > +         cur_iter->iter.state !=3D BPF_ITER_STATE_DRAINED) {
> > +             verbose(env, "verifier internal error: unexpected iterato=
r state %d (%s)\n",
> > +                     cur_iter->iter.state, iter_state_str(cur_iter->it=
er.state));
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (cur_iter->iter.state =3D=3D BPF_ITER_STATE_ACTIVE) {
> > +             /* branch out active iter state */
> > +             queued_st =3D push_stack(env, insn_idx + 1, insn_idx, fal=
se);
> > +             if (!queued_st)
> > +                     return -ENOMEM;
> > +
> > +             queued_iter =3D &queued_st->frame[iter_frameno]->stack[it=
er_spi].spilled_ptr;
> > +             queued_iter->iter.state =3D BPF_ITER_STATE_ACTIVE;
> > +             queued_iter->iter.depth++;
> > +
> > +             queued_fr =3D queued_st->frame[queued_st->curframe];
> > +             mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
> > +     }
> > +
> > +     /* switch to DRAINED state, but keep the depth unchanged */
> > +     /* mark current iter state as drained and assume returned NULL */
> > +     cur_iter->iter.state =3D BPF_ITER_STATE_DRAINED;
> > +     __mark_reg_known_zero(&cur_fr->regs[BPF_REG_0]);
> > +     cur_fr->regs[BPF_REG_0].type =3D SCALAR_VALUE;
>
> __mark_reg_const_zero() instead?

sure, didn't know about it

>
> > +
> > +     return 0;
> > +}
> ...
> > +static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_i=
dx, int *reg_idx)
> > +{
> > +     struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
> > +     const struct btf_param *args;
> > +     const struct btf_type *t;
> > +     const struct btf *btf;
> > +     int nargs, i;
> > +
> > +     if (!bpf_pseudo_kfunc_call(insn))
> > +             return false;
> > +     if (!is_iter_next_kfunc(insn->imm))
> > +             return false;
> > +
> > +     btf =3D find_kfunc_desc_btf(env, insn->off);
> > +     if (IS_ERR(btf))
> > +             return false;
> > +
> > +     t =3D btf_type_by_id(btf, insn->imm);     /* FUNC */
> > +     t =3D btf_type_by_id(btf, t->type);       /* FUNC_PROTO */
> > +
> > +     args =3D btf_params(t);
> > +     nargs =3D btf_vlen(t);
> > +     for (i =3D 0; i < nargs; i++) {
> > +             if (is_kfunc_arg_iter(btf, &args[i])) {
> > +                     *reg_idx =3D BPF_REG_1 + i;
> > +                     return true;
> > +             }
> > +     }
>
> This is some future-proofing ?
> The commit log says that all iterators has to in the form:
> bpf_iter_<kind>_next(struct bpf_iter* it)
> Should we check for one and only arg here instead?

Yeah, a bit of generality. For a long time I had an assumption
hardcoded about first argument being struct bpf_iter *, but that felt
unclean, so I generalized that before submission.

But I can't think why we wouldn't just dictate (and enforce) that
`struct bpf_iter *` is first. It makes sense, it's clean, and we lose
nothing. This is another thing that differs between dynptr and iter,
for dynptr such restriction wouldn't make sense.

Where would be a good place to enforce this for iter kfuncs?

>
> > +
> > +     return false;
> > +}
> > +
> > +/* is_state_visited() handles iter_next() (see process_iter_next_call(=
) for
> > + * terminology) calls specially: as opposed to bounded BPF loops, it *=
expects*
> > + * state matching, which otherwise looks like an infinite loop. So whi=
le
> > + * iter_next() calls are taken care of, we still need to be careful an=
d
> > + * prevent erroneous and too eager declaration of "ininite loop", when
> > + * iterators are involved.
> > + *
> > + * Here's a situation in pseudo-BPF assembly form:
> > + *
> > + *   0: again:                          ; set up iter_next() call args
> > + *   1:   r1 =3D &it                      ; <CHECKPOINT HERE>
> > + *   2:   call bpf_iter_num_next        ; this is iter_next() call
> > + *   3:   if r0 =3D=3D 0 goto done
> > + *   4:   ... something useful here ...
> > + *   5:   goto again                    ; another iteration
> > + *   6: done:
> > + *   7:   r1 =3D &it
> > + *   8:   call bpf_iter_num_destroy     ; clean up iter state
> > + *   9:   exit
> > + *
> > + * This is a typical loop. Let's assume that we have a prune point at =
1:,
> > + * before we get to `call bpf_iter_num_next` (e.g., because of that `g=
oto
> > + * again`, assuming other heuristics don't get in a way).
> > + *
> > + * When we first time come to 1:, let's say we have some state X. We p=
roceed
> > + * to 2:, fork states, enqueue ACTIVE, validate NULL case successfully=
, exit.
> > + * Now we come back to validate that forked ACTIVE state. We proceed t=
hrough
> > + * 3-5, come to goto, jump to 1:. Let's assume our state didn't change=
, so we
> > + * are converging. But the problem is that we don't know that yet, as =
this
> > + * convergence has to happen at iter_next() call site only. So if noth=
ing is
> > + * done, at 1: verifier will use bounded loop logic and declare infini=
te
> > + * looping (and would be *technically* correct, if not for iterator "e=
ventual
> > + * sticky NULL" contract, see process_iter_next_call()). But we don't =
want
> > + * that. So what we do in process_iter_next_call() when we go on anoth=
er
> > + * ACTIVE iteration, we bump slot->iter.depth, to mark that it's a dif=
ferent
> > + * iteration. So when we detect soon-to-be-declared infinite loop, we =
also
> > + * check if any of *ACTIVE* iterator state's depth differs. If yes, we=
 pretend
> > + * we are not looping and wait for next iter_next() call.
>
> 'depth' part of bpf_reg_state will be checked for equality in regsafe(), =
right?

no, it is explicitly skipped (and it's actually stacksafe(), not
regsafe()). I can add explicit comment that we *ignore* depth

I was considering adding a flag to states_equal() whether to check
depth or not (that would make iter_active_depths_differ unnecessary),
but it doesn't feel right. Any preferences one way or the other?

> Everytime we branch out in process_iter_next_call() there is depth++
> So how come we're able to converge with:
>  +                     if (is_iter_next_insn(env, insn_idx, &iter_arg_reg=
_idx)) {
>  +                             if (states_equal(env, &sl->state, cur)) {
> That's because states_equal() is done right before doing process_iter_nex=
t_call(), right?

Yes, we check convergence before we process_iter_next_call. We do
converge because we ignore depth, as I mentioned above.

>
> So depth counts the number of times bpf_iter*_next() was processed.
> In other words it's a number of ways the body of the loop can be walked?

More or less, yes. It's a number of sequential unrolls of loop body,
each time with a different starting state. But all that only in the
current code path. So it's not like "how many different loop states we
could have" in total. It's number of loop unrols with the condition
"assuming current code path that led to start of iterator loop". Some
other code path could lead to the state (before iterator loop starts)
that converges faster or slower, which is why I'm pointing out the
distinction.

But I think "yes" would be the answer to the question you had in mind.

>
> > +                     if (is_iter_next_insn(env, insn_idx, &iter_arg_re=
g_idx)) {
> > +                             if (states_equal(env, &sl->state, cur)) {
> > +                                     struct bpf_func_state *cur_frame;
> > +                                     struct bpf_reg_state *iter_state,=
 *iter_reg;
> > +                                     int spi;
> > +
> > +                                     /* current state is valid due to =
states_equal(),
> > +                                      * so we can assume valid iter st=
ate, no need for extra
> > +                                      * (re-)validations
> > +                                      */
> > +                                     cur_frame =3D cur->frame[cur->cur=
frame];
> > +                                     iter_reg =3D &cur_frame->regs[ite=
r_arg_reg_idx];
> > +                                     spi =3D iter_get_spi(env, iter_re=
g);
> > +                                     if (spi < 0)
> > +                                             return spi;
> > +                                     iter_state =3D &func(env, iter_re=
g)->stack[spi].spilled_ptr;
> > +                                     if (iter_state->iter.state =3D=3D=
 BPF_ITER_STATE_ACTIVE)
> > +                                             goto hit;
> > +                             }
> > +                             goto skip_inf_loop_check;
>
> This goto is "optional", right?
> Meaning that if we remove it the states_maybe_looping() + states_equal() =
won't match anyway.
> The goto avoids wasting cycles.

yes, avoids doing this check again, but also felt cleaner to be
explicit about skipping infinite loop check

>
> > +                     }
> > +                     /* attempt to detect infinite loop to avoid unnec=
essary doomed work */
> > +                     if (states_maybe_looping(&sl->state, cur) &&
>
> Maybe cleaner is to remove above 'goto' and do '} else if (states_maybe_l=
ooping' here ?

I can undo this, it felt cleaner with explicit "skip infinite loop
check" both for new code and for that async_entry_cnt check above. But
I can revert to if/else if/else if pattern, though I find it harder to
follow, given all this code (plus comments) is pretty long, so it's
easy to lose track when reading


>
> > +                         states_equal(env, &sl->state, cur) &&
> > +                         !iter_active_depths_differ(&sl->state, cur)) =
{
> >                               verbose_linfo(env, insn_idx, "; ");
> >                               verbose(env, "infinite loop detected at i=
nsn %d\n", insn_idx);
> >                               return -EINVAL;
