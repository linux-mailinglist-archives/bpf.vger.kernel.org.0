Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928659A54D
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349937AbiHSSjD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350236AbiHSSjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:39:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B365666A66
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:39:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso8327682pjl.1
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CUnIJocWHBIi2XPaPZqqRa7FWUxWCJElZXzxHYjxZ4I=;
        b=na+bSCEtiARwPW43llEneLYlBtHNy0hQOPkh/JzdhWEF6etz/uJebJws/16L5uIE4j
         yVJkWr997EmPIxPCfWbucpFmYoOCTMLqiS6fbfBKnRI0b9Gl4cAB3VUSfuj+qPdqNM/r
         pUndTv3WN3udfAUe1e+kFhGy4fwX2+0H1J731vUTm4M2OvD3ot8aMvC1B0JBcKSfCtIT
         HB0AjhBW3SawjJipiRAS9WqcagpHLNPjm9QVGzivcYX7/iiVwbvP8UZQbwyQxDJfKVK4
         mlHSI1IOOMk08khGiTNYZFhHUM1PhnCb0cadrcm7k3jF6JrYxy3gSUF7/tONrWq4KPPB
         inWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CUnIJocWHBIi2XPaPZqqRa7FWUxWCJElZXzxHYjxZ4I=;
        b=xpbA0EWExGreeRzpbMm5aoEiFHagbzROEP/e6/iEf+C7NdKM3dvIbncYKLYAG9s97s
         QSXAeOXKFE1504kNLJby2Ue+wCEjF2//UlLg7YM6IYL30EiimUjKK0enHHX9V8CjCPAy
         fLI2Z2a/hA0JDTfp+zbUIRXT83LmcE4gXiJIHolu7cnUbNceMBHVWtSxREQrxHwtwgOM
         aUybjy2Q/cCIzk/DvSrb8CBMTmECb4z0rT0M2m26SVSQBK/IsLX+d3Hc65cz1KVfk5A4
         tPJJ92IHzVu7SG+Hr5J6/A4w0HnxwW3REnp/6nVDtgdldqL9w/J/V2fzFUMsRnjsWFFD
         9/3w==
X-Gm-Message-State: ACgBeo3b6l5uTrvxO5DWwGeONWFRT3FcPeoGwOsD/4/DpVfQZu1TxK0q
        2oUKgVUjtrR5WvWID3HQznE=
X-Google-Smtp-Source: AA6agR7Uj6clBRAISTurE/OQFBJQN0d6FV0TGpfY4ENIDy2wwuyVnbBv9nYt2BfWAsWPh9yv4p/rVw==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr8636698pll.56.1660934341128;
        Fri, 19 Aug 2022 11:39:01 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b00172913c0e3dsm3503968plb.157.2022.08.19.11.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:39:00 -0700 (PDT)
Date:   Fri, 19 Aug 2022 11:38:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC bpf v1 2/3] bpf: Fix reference state management for
 synchronous callbacks
Message-ID: <20220819183858.sxgdg2ymlmqvios2@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <20220815051540.18791-1-memxor@gmail.com>
 <20220815051540.18791-3-memxor@gmail.com>
 <CAADnVQ+Y161JHT2sN-r-g3CHevtwiS2WLW=VW+mx5bekaewGGQ@mail.gmail.com>
 <CAP01T74hq946TnsPbLiQ1==BDH=i8Mze5Sz5ar+iH6sS=2V4Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74hq946TnsPbLiQ1==BDH=i8Mze5Sz5ar+iH6sS=2V4Gw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 07:31:24AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 19 Aug 2022 at 02:51, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Aug 14, 2022 at 10:15 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Currently, verifier verifies callback functions (sync and async) as if
> > > they will be executed once, (i.e. it explores execution state as if the
> > > function was being called once). The next insn to explore is set to
> > > start of subprog and the exit from nested frame is handled using
> > > curframe > 0 and prepare_func_exit. In case of async callback it uses a
> > > customized variant of push_stack simulating a kind of branch to set up
> > > custom state and execution context for the async callback.
> > >
> > > While this approach is simple and works when callback really will be
> > > executed only once, it is unsafe for all of our current helpers which
> > > are for_each style, i.e. they execute the callback multiple times.
> > >
> > > A callback releasing acquired references of the caller may do so
> > > multiple times, but currently verifier sees it as one call inside the
> > > frame, which then returns to caller. Hence, it thinks it released some
> > > reference that the cb e.g. got access through callback_ctx (register
> > > filled inside cb from spilled typed register on stack).
> > >
> > > Similarly, it may see that an acquire call is unpaired inside the
> > > callback, so the caller will copy the reference state of callback and
> > > then will have to release the register with new ref_obj_ids. But again,
> > > the callback may execute multiple times, but the verifier will only
> > > account for acquired references for a single symbolic execution of the
> > > callback.
> > >
> > > Note that for async callback case, things are different. While currently
> > > we have bpf_timer_set_callback which only executes it once, even for
> > > multiple executions it would be safe, as reference state is NULL and
> > > check_reference_leak would force program to release state before
> > > BPF_EXIT. The state is also unaffected by analysis for the caller frame.
> > > Hence async callback is safe.
> > >
> > > To fix this, we disallow callbacks to transfer acquired references back
> > > to caller. They must be released before callback hits BPF_EXIT, since
> > > the number of times callback is invoked is not known to the verifier, it
> > > cannot reliably track how many references will be created. Likewise, it
> > > is not allowed to release caller reference state, since we don't know
> > > how many times the callback will be invoked.
> > >
> > > Lastly, now that callback function cannot change reference state it
> > > copied from its parent, there is no need to copy reference state back to
> > > the parent, since it won't change. It may be changed for the callee
> > > frame but that state must match parent reference state by the time
> > > callee exits, and it is going to be discarded anyway. So skip this copy
> > > too. To be clear, it won't be incorrect if the copy was done, but it
> > > would be inefficient and may be confusing to people reading the code.
> > >
> > > Fixes: 69c87ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h | 11 ++++++++++
> > >  kernel/bpf/verifier.c        | 42 ++++++++++++++++++++++++++++--------
> > >  2 files changed, 44 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 2e3bad8640dc..1fdddbf3546b 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -212,6 +212,17 @@ struct bpf_reference_state {
> > >          * is used purely to inform the user of a reference leak.
> > >          */
> > >         int insn_idx;
> > > +       /* There can be a case like:
> > > +        * main (frame 0)
> > > +        *  cb (frame 1)
> > > +        *   func (frame 3)
> > > +        *    cb (frame 4)
> > > +        * Hence for frame 4, if callback_ref just stored boolean, it would be
> > > +        * impossible to distinguish nested callback refs. Hence store the
> > > +        * frameno and compare that to callback_ref in check_reference_leak when
> > > +        * exiting a callback function.
> > > +        */
> > > +       int callback_ref;
> > >  };
> > >
> > >  /* state of the program:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 096fdac70165..3e885ba88b02 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1086,6 +1086,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
> > >         id = ++env->id_gen;
> > >         state->refs[new_ofs].id = id;
> > >         state->refs[new_ofs].insn_idx = insn_idx;
> > > +       state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
> > >
> > >         return id;
> > >  }
> > > @@ -1098,6 +1099,9 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
> > >         last_idx = state->acquired_refs - 1;
> > >         for (i = 0; i < state->acquired_refs; i++) {
> > >                 if (state->refs[i].id == ptr_id) {
> > > +                       /* Cannot release caller references in callbacks */
> > > +                       if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> > > +                               return -EINVAL;
> > >                         if (last_idx && i != last_idx)
> > >                                 memcpy(&state->refs[i], &state->refs[last_idx],
> > >                                        sizeof(*state->refs));
> > > @@ -6938,10 +6942,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
> > >                 caller->regs[BPF_REG_0] = *r0;
> > >         }
> > >
> > > -       /* Transfer references to the caller */
> > > -       err = copy_reference_state(caller, callee);
> > > -       if (err)
> > > -               return err;
> > > +       /* callback_fn frame should have released its own additions to parent's
> > > +        * reference state at this point, or check_reference_leak would
> > > +        * complain, hence it must be the same as the caller. There is no need
> > > +        * to copy it back.
> > > +        */
> > > +       if (!callee->in_callback_fn) {
> > > +               /* Transfer references to the caller */
> > > +               err = copy_reference_state(caller, callee);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> >
> > This part makes sense.
> >
> > >
> > >         *insn_idx = callee->callsite + 1;
> > >         if (env->log.level & BPF_LOG_LEVEL) {
> > > @@ -7065,13 +7076,20 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> > >  static int check_reference_leak(struct bpf_verifier_env *env)
> > >  {
> > >         struct bpf_func_state *state = cur_func(env);
> > > +       bool refs_lingering = false;
> > >         int i;
> > >
> > > +       if (state->frameno && !state->in_callback_fn)
> > > +               return 0;
> > > +
> > >         for (i = 0; i < state->acquired_refs; i++) {
> > > +               if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> > > +                       continue;
> >
> > This part I don't understand.
> > Why remember callback_ref at all?
> > if (state->in_callback_fn)
> > and there is something in acquired_refs it means
> > that callback acquired refs and since we're not transferring
> > them then we can error right away.
> >
> 
> Consider that a prog has 3 acquired_refs, with ids 1, 2, 3.
> 
> When you invoke the callback, you still want it to be able to load
> pointers spilled to the stack with a ref_obj_id and pass them to
> helpers. Hence, we do copy acquired_refs to the callback after
> initializing bpf_func_state.

Ahh. I see. We do copy_reference_state() and the verifier state in the caller's
frame is indeed accessible through callback_ctx pointer passed into the callee.

> However, since we don't know how many
> times it will be invoked, it is unsafe to allow it to acquire refs it
> doesn't release before its bpf_exit, or release the callers ref. The
> former can lead to leaks (since if we only copy refs acquired in one
> iteration, and if we release we only release refs released in one
> iteration).

Right.

> 
> Hence, this patch completely disallows callback from mutating the
> state of refs it copied from its parent. It can however acquire its
> own refs and release them before bpf_exit. Hence, check_reference_leak
> now errors if it sees we are in callback_fn and we have not released
> callback_ref refs. Since there can be multiple nested callbacks, like
> frame 0 -> cb1 -> cb2  etc. we need to also distinguish between
> whether this particular ref belongs to this callback frame or parent,
> and only error for our own, so we store state->frameno (which is
> always non-zero for callbacks).

Right.

> TLDR; callbacks can read parent reference_state, but cannot mutate it,
> to be able to use pointers acquired by the caller. They must only undo
> their changes (by releasing their own acquired_refs before bpf_exit)
> on top of caller reference_state before returning (at which point the
> caller and callback state will match anyway, so no need to copy back).

Please add all these details to the commit log.
