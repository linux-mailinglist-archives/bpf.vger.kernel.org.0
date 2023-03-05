Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA356AB390
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 00:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCEXqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 18:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCEXqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 18:46:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E816612BC9
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 15:46:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so7291911pja.5
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNWf9WoGPKSK/vUdfFFGZ3rAwk+isVn3ybDAKRIyUbs=;
        b=maK8o0/dOifKTjiITRfVI+AU8AqDKqPAANC6HgO8idatlEzbUHfi9sLil0HqFQrEvi
         fjWUa3+N+Ra+i2V7eMr0h9T/c9exmTUxssQo9vAus+wnIUUiKmWVIeecZItA+xCk5CKY
         zDdR/cXQdvYmSLY0aR8ORVBZKzRSayRmp+peyzUbjOLf+ELRwlDTSRPC/RZd20bKrlSw
         7mQJ3ArLbe0mtTNAhK8INS4EG/dcC4FZ3yIxpBq41wPOD324F4GDz1nw/eUNIcTKYMD/
         aTnE1ltbru8hs/zglf8WZNreO4bIi5emw/oBGUzMW/AcEXz2SB7qDH1b/2ts0gKK1cmD
         0SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNWf9WoGPKSK/vUdfFFGZ3rAwk+isVn3ybDAKRIyUbs=;
        b=EVOFbO03baq13Q9KSLmOTrsU73Fht14IbvBrzigJQtvlDwbZoK/eB5dIC6kSYxBccf
         NJrAlSMeiw1my/BHDrkTvYW98zV+xcNNQ2Ofxnt27QxIx0DNsvR05DBBSIjC244xnNOP
         OIoNA5mAv6FpCAFUjO3oTimg13j1PBHsbAHkdv0e8KyiRxdaeAUEunQGaGT4aBZfVx1M
         Nu4ka8GL/jjtuNsfk13e2kENmzko/fXaKJ+s6vHYYpOLDv+x78pCFvGrTvcBWLtrGdVH
         3rHL64aZ4ojPQnbK4uJZEbWDbMcqg718kiNEjEYNof4EHq4TpiyqEIg9PaScSs+HMOIg
         EJfQ==
X-Gm-Message-State: AO0yUKXp2JiJcgO2Dbndh211ahqXfKnSh4zRQdUYUi3CRakOJIqrvOxm
        M/zb9D/kZxgyiU/yNublh+U=
X-Google-Smtp-Source: AK7set+sXpAe8XQdXn/88xlgkAAdl3O8Dcm0nyEaZ3u9EU1d+WNwwxFi9Vvli1Xhi8RsVElkX3dnPA==
X-Received: by 2002:a17:903:11c8:b0:199:2a89:f912 with SMTP id q8-20020a17090311c800b001992a89f912mr10664562plh.20.1678059969002;
        Sun, 05 Mar 2023 15:46:09 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id ke13-20020a170903340d00b0019ea9e5815bsm3254763plb.45.2023.03.05.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 15:46:08 -0800 (PST)
Date:   Sun, 5 Mar 2023 15:46:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 13/17] bpf: add support for open-coded iterator
 loops
Message-ID: <20230305234605.q2aszlad5ow3ylkl@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-14-andrii@kernel.org>
 <20230304200232.ueac44amyhpptpay@MacBook-Pro-6.local>
 <CAEf4BzY70w2g5giMu+qWOE0YSGWKvy1hq-pKCvHHKLcez+R2Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY70w2g5giMu+qWOE0YSGWKvy1hq-pKCvHHKLcez+R2Tg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 04, 2023 at 03:27:46PM -0800, Andrii Nakryiko wrote:
> particular type. This will automatically work better for kfuncs as
> new/next/destroy trios will have the same `struct bpf_iter_<type> *`
> and it won't be possible to accidentally pass wrong bpf_iter_<type> to
> wrong new/next/destroy method.

Exactly.

> >
> > > +
> > > +static int mark_stack_slots_iter(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > +                              enum bpf_arg_type arg_type, int insn_idx)
> > > +{
> > > +     struct bpf_func_state *state = func(env, reg);
> > > +     enum bpf_iter_type type;
> > > +     int spi, i, j, id;
> > > +
> > > +     spi = iter_get_spi(env, reg);
> > > +     if (spi < 0)
> > > +             return spi;
> > > +
> > > +     type = arg_to_iter_type(arg_type);
> > > +     if (type == BPF_ITER_TYPE_INVALID)
> > > +             return -EINVAL;
> >
> > Do we need destroy_if_dynptr_stack_slot() equivalent here?
> 
> no, because bpf_iter is always ref-counted, so we'll always have
> explicit unmark_stack_slots_iter() call, which will reset slot types
> 
> destroy_if_dynptr_stack_slot() was added because LOCAL dynptr doesn't
> require explicit destruction. I mentioned this difference
> (simplification for bpf_iter case) somewhere in the commit message.

I see. Makes sense.

> > >
> > >               /* regular write of data into stack destroys any spilled ptr */
> > >               state->stack[spi].spilled_ptr.type = NOT_INIT;
> > > -             /* Mark slots as STACK_MISC if they belonged to spilled ptr. */
> > > -             if (is_spilled_reg(&state->stack[spi]))
> > > +             /* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
> > > +             if (is_stack_slot_special(&state->stack[spi]))
> > >                       for (i = 0; i < BPF_REG_SIZE; i++)
> > >                               scrub_spilled_slot(&state->stack[spi].slot_type[i]);
> >
> > It fixes something for dynptr, right?
> 
> It's convoluted, I think it might not have a visible effect. This is
> the situation of partial (e.g., single byte) overwrite of
> STACK_DYNPTR/STACK_ITER, and without this change we'll leave some
> slot_types as STACK_MISC, while others as STACK_DYNPTP/STACK_ITER.
> This is unexpected state, but I think existing code always checks that
> for STACK_DYNPTR's all 8 slots are STACK_DYNPTR.
> 
> So I think it's a good clean up, but no consequences for dynptr
> correctness. And for STACK_ITER I don't have to worry about such mix,
> if any of the slot_type[i] is STACK_ITER, then it's a correct
> iterator.

agree. I was just curious.

> > > +static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx, int *reg_idx)
> > > +{
> > > +     struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> > > +     const struct btf_param *args;
> > > +     const struct btf_type *t;
> > > +     const struct btf *btf;
> > > +     int nargs, i;
> > > +
> > > +     if (!bpf_pseudo_kfunc_call(insn))
> > > +             return false;
> > > +     if (!is_iter_next_kfunc(insn->imm))
> > > +             return false;
> > > +
> > > +     btf = find_kfunc_desc_btf(env, insn->off);
> > > +     if (IS_ERR(btf))
> > > +             return false;
> > > +
> > > +     t = btf_type_by_id(btf, insn->imm);     /* FUNC */
> > > +     t = btf_type_by_id(btf, t->type);       /* FUNC_PROTO */
> > > +
> > > +     args = btf_params(t);
> > > +     nargs = btf_vlen(t);
> > > +     for (i = 0; i < nargs; i++) {
> > > +             if (is_kfunc_arg_iter(btf, &args[i])) {
> > > +                     *reg_idx = BPF_REG_1 + i;
> > > +                     return true;
> > > +             }
> > > +     }
> >
> > This is some future-proofing ?
> > The commit log says that all iterators has to in the form:
> > bpf_iter_<kind>_next(struct bpf_iter* it)
> > Should we check for one and only arg here instead?
> 
> Yeah, a bit of generality. For a long time I had an assumption
> hardcoded about first argument being struct bpf_iter *, but that felt
> unclean, so I generalized that before submission.
> 
> But I can't think why we wouldn't just dictate (and enforce) that
> `struct bpf_iter *` is first. It makes sense, it's clean, and we lose
> nothing. This is another thing that differs between dynptr and iter,
> for dynptr such restriction wouldn't make sense.
> 
> Where would be a good place to enforce this for iter kfuncs?

I would probably just remove is_iter_next_insn() completely, hard code BPF_REG_1
and add a big comment for now.

In the follow up we can figure out how to:
BUILD_BUG_ON(!__same_type(bpf_iter_num_next, some canonical proto for iter_next));

Like we do:
  BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
               (void *(*)(struct bpf_map *map, void *key))NULL));

> >
> > 'depth' part of bpf_reg_state will be checked for equality in regsafe(), right?
> 
> no, it is explicitly skipped (and it's actually stacksafe(), not
> regsafe()). I can add explicit comment that we *ignore* depth

Ahh. That's stacksafe() indeed.
Would be great to add a comment to:
+                       if (old_reg->iter.type != cur_reg->iter.type ||
+                           old_reg->iter.state != cur_reg->iter.state ||
+                           !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+                               return false;

that depth is explicitly not compared.

> I was considering adding a flag to states_equal() whether to check
> depth or not (that would make iter_active_depths_differ unnecessary),
> but it doesn't feel right. Any preferences one way or the other?

probably overkill. just comment should be enough.

> > Everytime we branch out in process_iter_next_call() there is depth++
> > So how come we're able to converge with:
> >  +                     if (is_iter_next_insn(env, insn_idx, &iter_arg_reg_idx)) {
> >  +                             if (states_equal(env, &sl->state, cur)) {
> > That's because states_equal() is done right before doing process_iter_next_call(), right?
> 
> Yes, we check convergence before we process_iter_next_call. We do
> converge because we ignore depth, as I mentioned above.
> 
> >
> > So depth counts the number of times bpf_iter*_next() was processed.
> > In other words it's a number of ways the body of the loop can be walked?
> 
> More or less, yes. It's a number of sequential unrolls of loop body,
> each time with a different starting state. But all that only in the
> current code path. So it's not like "how many different loop states we
> could have" in total. It's number of loop unrols with the condition
> "assuming current code path that led to start of iterator loop". Some
> other code path could lead to the state (before iterator loop starts)
> that converges faster or slower, which is why I'm pointing out the
> distinction.

got it. I know the comments are big and extensive already, but little bit more
won't hurt.

> >
> > > +                     }
> > > +                     /* attempt to detect infinite loop to avoid unnecessary doomed work */
> > > +                     if (states_maybe_looping(&sl->state, cur) &&
> >
> > Maybe cleaner is to remove above 'goto' and do '} else if (states_maybe_looping' here ?
> 
> I can undo this, it felt cleaner with explicit "skip infinite loop
> check" both for new code and for that async_entry_cnt check above. But
> I can revert to if/else if/else if pattern, though I find it harder to
> follow, given all this code (plus comments) is pretty long, so it's
> easy to lose track when reading

I'm fine whichever way. I just remembered that you typically try to avoid goto-s
and seeing goto here that could have easily been 'else' raised my internal alarm
that I could be missing something subtle in the code here.

> 
> >
> > > +                         states_equal(env, &sl->state, cur) &&
> > > +                         !iter_active_depths_differ(&sl->state, cur)) {
> > >                               verbose_linfo(env, insn_idx, "; ");
> > >                               verbose(env, "infinite loop detected at insn %d\n", insn_idx);
> > >                               return -EINVAL;
