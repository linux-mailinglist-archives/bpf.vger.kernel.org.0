Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A359948D
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiHSFcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiHSFcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 01:32:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CCE0FC4
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 22:32:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z13so1841520ilq.9
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=l7VK7oGiipwMw6fWcPIWf6sQUHRsvaeQYT01DercdtY=;
        b=gChXkwxidpiAokUCMZ8XbwyxgEIoEDYwPjtS/f6VWyZVUVNagNid1Lt9fs9ebpGyRt
         TO6SZ7jCBczrlRzEqotWgVFlTdUHxP173gEzSIx9172OnE+I7zjlf5ZO/5YQD00R2KN6
         AD8Rix3igVH7Z0i2fm/N8iOEATbfA+CiQXAbkl3r9QfjjpVU2Gb0P4k4WGaEW9W6AxMu
         BNp2y6epEYdeQtaj4n+RWE3TZTKCfi/Y3ET+2UBYsvi7rihHVBmX7k/3XAdk5u656nV2
         qU6H0i7MASOVcw2Iyaf97pYi8WcXnYIbYpKXbK5UfDi/+n9WpJ/FB+3S0sQB1ixHsKkD
         ersQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l7VK7oGiipwMw6fWcPIWf6sQUHRsvaeQYT01DercdtY=;
        b=hOvF2NAYDWcz/Up5GBR6kk9lEh7Z1G2gsMHSj0dZGidRAn4MV3poqQovD16b9kMzDF
         0eLGuPYA1AZ3ZAjKj4BOBhnNp9wQB/FuZODySaFrpQRX+bAyelE/9GttzeNeMZxDasSs
         7j/BflvtkIlIbCEGsb774W+XXSMfkMY/ZIEhm7vXzwRIqQPt2cc+scUDrRwuYjX9MPst
         PjmdReeZ3NO/bTKDAgYwVrF9ITdYrYTlXAvRlC/81nz0h5IxKGn9oexeCM0f6BPUOhMY
         clHF/WrwTNOdCxgBxnm7JL26x8g8gGiNyEzAQ6d1ehrXNcL0uhiDLX2zhyEUtsCMRUSk
         cfXg==
X-Gm-Message-State: ACgBeo3Hb09X/zrlfAWlxkWMbbrXUkonO4jmnI0D+tEW39umQAbxDLAK
        6v+NLbkFKgr4hJHLP/9M/BpMiR3lWQdOCOtbjE2+KtbO
X-Google-Smtp-Source: AA6agR41QYo8ZMbzsYx7Toh3Be/gd5nOVGfxLVw2X1pv7ADN2wtiW80R2tHEaHgbLE12L3PlZY56h6K+DqQc4vXnnM0=
X-Received: by 2002:a05:6e02:1d16:b0:2e5:813b:d172 with SMTP id
 i22-20020a056e021d1600b002e5813bd172mr2985976ila.164.1660887120678; Thu, 18
 Aug 2022 22:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220815051540.18791-1-memxor@gmail.com> <20220815051540.18791-3-memxor@gmail.com>
 <CAADnVQ+Y161JHT2sN-r-g3CHevtwiS2WLW=VW+mx5bekaewGGQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Y161JHT2sN-r-g3CHevtwiS2WLW=VW+mx5bekaewGGQ@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 19 Aug 2022 07:31:24 +0200
Message-ID: <CAP01T74hq946TnsPbLiQ1==BDH=i8Mze5Sz5ar+iH6sS=2V4Gw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf v1 2/3] bpf: Fix reference state management for
 synchronous callbacks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Fri, 19 Aug 2022 at 02:51, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Aug 14, 2022 at 10:15 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, verifier verifies callback functions (sync and async) as if
> > they will be executed once, (i.e. it explores execution state as if the
> > function was being called once). The next insn to explore is set to
> > start of subprog and the exit from nested frame is handled using
> > curframe > 0 and prepare_func_exit. In case of async callback it uses a
> > customized variant of push_stack simulating a kind of branch to set up
> > custom state and execution context for the async callback.
> >
> > While this approach is simple and works when callback really will be
> > executed only once, it is unsafe for all of our current helpers which
> > are for_each style, i.e. they execute the callback multiple times.
> >
> > A callback releasing acquired references of the caller may do so
> > multiple times, but currently verifier sees it as one call inside the
> > frame, which then returns to caller. Hence, it thinks it released some
> > reference that the cb e.g. got access through callback_ctx (register
> > filled inside cb from spilled typed register on stack).
> >
> > Similarly, it may see that an acquire call is unpaired inside the
> > callback, so the caller will copy the reference state of callback and
> > then will have to release the register with new ref_obj_ids. But again,
> > the callback may execute multiple times, but the verifier will only
> > account for acquired references for a single symbolic execution of the
> > callback.
> >
> > Note that for async callback case, things are different. While currently
> > we have bpf_timer_set_callback which only executes it once, even for
> > multiple executions it would be safe, as reference state is NULL and
> > check_reference_leak would force program to release state before
> > BPF_EXIT. The state is also unaffected by analysis for the caller frame.
> > Hence async callback is safe.
> >
> > To fix this, we disallow callbacks to transfer acquired references back
> > to caller. They must be released before callback hits BPF_EXIT, since
> > the number of times callback is invoked is not known to the verifier, it
> > cannot reliably track how many references will be created. Likewise, it
> > is not allowed to release caller reference state, since we don't know
> > how many times the callback will be invoked.
> >
> > Lastly, now that callback function cannot change reference state it
> > copied from its parent, there is no need to copy reference state back to
> > the parent, since it won't change. It may be changed for the callee
> > frame but that state must match parent reference state by the time
> > callee exits, and it is going to be discarded anyway. So skip this copy
> > too. To be clear, it won't be incorrect if the copy was done, but it
> > would be inefficient and may be confusing to people reading the code.
> >
> > Fixes: 69c87ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h | 11 ++++++++++
> >  kernel/bpf/verifier.c        | 42 ++++++++++++++++++++++++++++--------
> >  2 files changed, 44 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 2e3bad8640dc..1fdddbf3546b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -212,6 +212,17 @@ struct bpf_reference_state {
> >          * is used purely to inform the user of a reference leak.
> >          */
> >         int insn_idx;
> > +       /* There can be a case like:
> > +        * main (frame 0)
> > +        *  cb (frame 1)
> > +        *   func (frame 3)
> > +        *    cb (frame 4)
> > +        * Hence for frame 4, if callback_ref just stored boolean, it would be
> > +        * impossible to distinguish nested callback refs. Hence store the
> > +        * frameno and compare that to callback_ref in check_reference_leak when
> > +        * exiting a callback function.
> > +        */
> > +       int callback_ref;
> >  };
> >
> >  /* state of the program:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 096fdac70165..3e885ba88b02 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1086,6 +1086,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
> >         id = ++env->id_gen;
> >         state->refs[new_ofs].id = id;
> >         state->refs[new_ofs].insn_idx = insn_idx;
> > +       state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
> >
> >         return id;
> >  }
> > @@ -1098,6 +1099,9 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
> >         last_idx = state->acquired_refs - 1;
> >         for (i = 0; i < state->acquired_refs; i++) {
> >                 if (state->refs[i].id == ptr_id) {
> > +                       /* Cannot release caller references in callbacks */
> > +                       if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> > +                               return -EINVAL;
> >                         if (last_idx && i != last_idx)
> >                                 memcpy(&state->refs[i], &state->refs[last_idx],
> >                                        sizeof(*state->refs));
> > @@ -6938,10 +6942,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
> >                 caller->regs[BPF_REG_0] = *r0;
> >         }
> >
> > -       /* Transfer references to the caller */
> > -       err = copy_reference_state(caller, callee);
> > -       if (err)
> > -               return err;
> > +       /* callback_fn frame should have released its own additions to parent's
> > +        * reference state at this point, or check_reference_leak would
> > +        * complain, hence it must be the same as the caller. There is no need
> > +        * to copy it back.
> > +        */
> > +       if (!callee->in_callback_fn) {
> > +               /* Transfer references to the caller */
> > +               err = copy_reference_state(caller, callee);
> > +               if (err)
> > +                       return err;
> > +       }
>
> This part makes sense.
>
> >
> >         *insn_idx = callee->callsite + 1;
> >         if (env->log.level & BPF_LOG_LEVEL) {
> > @@ -7065,13 +7076,20 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> >  static int check_reference_leak(struct bpf_verifier_env *env)
> >  {
> >         struct bpf_func_state *state = cur_func(env);
> > +       bool refs_lingering = false;
> >         int i;
> >
> > +       if (state->frameno && !state->in_callback_fn)
> > +               return 0;
> > +
> >         for (i = 0; i < state->acquired_refs; i++) {
> > +               if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> > +                       continue;
>
> This part I don't understand.
> Why remember callback_ref at all?
> if (state->in_callback_fn)
> and there is something in acquired_refs it means
> that callback acquired refs and since we're not transferring
> them then we can error right away.
>

Consider that a prog has 3 acquired_refs, with ids 1, 2, 3.

When you invoke the callback, you still want it to be able to load
pointers spilled to the stack with a ref_obj_id and pass them to
helpers. Hence, we do copy acquired_refs to the callback after
initializing bpf_func_state. However, since we don't know how many
times it will be invoked, it is unsafe to allow it to acquire refs it
doesn't release before its bpf_exit, or release the callers ref. The
former can lead to leaks (since if we only copy refs acquired in one
iteration, and if we release we only release refs released in one
iteration).

Hence, this patch completely disallows callback from mutating the
state of refs it copied from its parent. It can however acquire its
own refs and release them before bpf_exit. Hence, check_reference_leak
now errors if it sees we are in callback_fn and we have not released
callback_ref refs. Since there can be multiple nested callbacks, like
frame 0 -> cb1 -> cb2  etc. we need to also distinguish between
whether this particular ref belongs to this callback frame or parent,
and only error for our own, so we store state->frameno (which is
always non-zero for callbacks).

TLDR; callbacks can read parent reference_state, but cannot mutate it,
to be able to use pointers acquired by the caller. They must only undo
their changes (by releasing their own acquired_refs before bpf_exit)
on top of caller reference_state before returning (at which point the
caller and callback state will match anyway, so no need to copy back).
