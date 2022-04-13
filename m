Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49E4FFE0A
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiDMSmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiDMSmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 14:42:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACD21D
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:39:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y32so5116085lfa.6
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjjzzeYBlbYnqI/jJ0fILQtPpnAb2yHmCfmWPf+5/oM=;
        b=lGFyMwhDDFOHHY5EOCh9Y58ELWy8PHW3vpuopX5tMqBcY/vuA2UVaYmG26rqQaCeN6
         8eN0BJyuw3FXEL4G+3dWbbqEy3sBUSMAzYyR6KLzJVC4SOh9AnCW+nzXRDBaQgn/pwm0
         +6DQt7VvYECY58BsHhQBzdN2rSM3+GBHjIeqBGIC6i9EJPtXPU5HyhV/gXXTGPr4SRKp
         ZVkfTvF+FCZFlMAQ4jyjVfTwA2pIqnmFdhvaRNy39s+9wUFt+ARupaRKcPRCbl0zPkLj
         E+oE+TjuF0wgUOjSCsOdZgA2cvGj42N44YAwjSu4Quvmy4WpZ5ZvUQfhe0gWQB06GP4C
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjjzzeYBlbYnqI/jJ0fILQtPpnAb2yHmCfmWPf+5/oM=;
        b=g8KjIIVboaNgEPfWv7orl+7B8DliL1uMdk/Vp1cSen8LpyBCLjCqsDm6MXW3YcFrna
         liWIP4nfpIl35xEDLzAQcdqMXPViguJBZgp6scSge+pD4DsxfaFRmfnpFlV0ru6CEwBu
         DAszrNuWBlurrwudsZUrFIFNFtbDsR5VAm6bpNNj03iNk0sq0ghOOgrAysB7gybjg++8
         7zncFTmrgTOXdH47U0p3B//kbd9+zm7GcVdTarOixSuDyQVLeIF/k0a4Dt1MHeqiKAj7
         pUikl2xSQwoLhXHPsoK1LRJBHwWVBtL5V7fJ+A1LXMvDjIYKiTU+TPcJqpK/wLEbpuFX
         88kw==
X-Gm-Message-State: AOAM532NZE+e6S09gmBSY6pJZx3M+5UiOxY2Nb8qASB1yfS00+/b98i6
        V3gIYYO2XKs3LvC+UhiARw1Sw90qg9KE7Ze5214Vj23I
X-Google-Smtp-Source: ABdhPJwFC/8/vxilfoRz9Il/waeJ3z6ptKa4djDqGF4YZYUW7I/SzVxQbe4T4p18hZylUXyb40elOUDQvrmAbWjsJ6Q=
X-Received: by 2002:a05:6512:a86:b0:44a:7d2d:b763 with SMTP id
 m6-20020a0565120a8600b0044a7d2db763mr30244422lfu.540.1649875183815; Wed, 13
 Apr 2022 11:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220409093303.499196-1-memxor@gmail.com> <20220409093303.499196-5-memxor@gmail.com>
 <CAJnrk1ZJpbsO54J9jGKFdW9Li5WHTbK=rCrL0FYUb-0X1yq_AA@mail.gmail.com>
 <20220412201121.xsel4y57ffmpyx47@apollo.legion> <CAJnrk1Z2ZRk7jF3hq0g+JpykS2hny3he9kbEMVEOEATrKVjLWg@mail.gmail.com>
In-Reply-To: <CAJnrk1Z2ZRk7jF3hq0g+JpykS2hny3he9kbEMVEOEATrKVjLWg@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 13 Apr 2022 11:39:32 -0700
Message-ID: <CAJnrk1b6sFiys22TSnxUkL5Ye7rGNh0hdiugoM4eF47pR8uOxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Tag argument to be released in bpf_func_proto
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Wed, Apr 13, 2022 at 11:33 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Tue, Apr 12, 2022 at 1:11 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 11:46:14PM IST, Joanne Koong wrote:
> > > On Sun, Apr 10, 2022 at 11:58 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Add a new type flag for bpf_arg_type that when set tells verifier that
> > > > for a release function, that argument's register will be the one for
> > > > which meta.ref_obj_id will be set, and which will then be released
> > > > using release_reference. To capture the regno, introduce a new field
> > > > release_regno in bpf_call_arg_meta.
> > > >
> > > > This would be required in the next patch, where we may either pass NULL
> > > > or a refcounted pointer as an argument to the release function
> > > > bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
> > > > enough, as there is a case where the type of argument needed matches,
> > > > but the ref_obj_id is set to 0. Hence, we must enforce that whenever
> > > > meta.ref_obj_id is zero, the register that is to be released can only
> > > > be NULL for a release function.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h   |  5 ++++-
> > > >  kernel/bpf/ringbuf.c  |  4 ++--
> > > >  kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++-------
> > > >  net/core/filter.c     |  2 +-
> > > >  4 files changed, 46 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index e267db260cb7..a6d1982e8118 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -364,7 +364,10 @@ enum bpf_type_flag {
> > > >          */
> > > >         MEM_PERCPU              = BIT(4 + BPF_BASE_TYPE_BITS),
> > > >
> > > > -       __BPF_TYPE_LAST_FLAG    = MEM_PERCPU,
> > > > +       /* Indicates that the pointer argument will be released. */
> > > > +       PTR_RELEASE             = BIT(5 + BPF_BASE_TYPE_BITS),
> > > > +
> > > > +       __BPF_TYPE_LAST_FLAG    = PTR_RELEASE,
> > > >  };
> > > >
> > > >  /* Max number of base types. */
> > > > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > > > index 710ba9de12ce..a22c21c0a7ef 100644
> > > > --- a/kernel/bpf/ringbuf.c
> > > > +++ b/kernel/bpf/ringbuf.c
> > > > @@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
> > > >  const struct bpf_func_proto bpf_ringbuf_submit_proto = {
> > > >         .func           = bpf_ringbuf_submit,
> > > >         .ret_type       = RET_VOID,
> > > > -       .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> > > > +       .arg1_type      = ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> > > >         .arg2_type      = ARG_ANYTHING,
> > > >  };
> > > >
> > > > @@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
> > > >  const struct bpf_func_proto bpf_ringbuf_discard_proto = {
> > > >         .func           = bpf_ringbuf_discard,
> > > >         .ret_type       = RET_VOID,
> > > > -       .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> > > > +       .arg1_type      = ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> > > >         .arg2_type      = ARG_ANYTHING,
> > > >  };
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 01d45c5010f9..6cc08526e049 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
> > > >         struct bpf_map *map_ptr;
> > > >         bool raw_mode;
> > > >         bool pkt_access;
> > > > +       u8 release_regno;
> > > >         int regno;
> > > >         int access_size;
> > > >         int mem_size;
> > > > @@ -5300,6 +5301,11 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> > > >                type == ARG_PTR_TO_LONG;
> > > >  }
> > > >
> > > > +static bool arg_type_is_release_ptr(enum bpf_arg_type type)
> > > > +{
> > > > +       return type & PTR_RELEASE;
> > > > +}
> > > > +
> > > Now that we have PTR_RELEASE as a bpf arg type descriptor, why do we
> > > still need is_release_function() in the verifier? I think we should
> > > just remove is_release_function() altogether - is_release_function()
> > > isn't functionally necessary now that we have PTR_RELEASE, and I don't
> > > think it's great that is_release_function() hardcodes specific
> > > functions into the verifier. What are your thoughts?
> >
> > We need it to (atleast) guard the meta.ref_obj_id release, otherwise you have to
> > check for PTR_RELEASE in all arguments to determine it is a release function.
> > I guess we could record whether function is release function in meta, then
> > looping over arguments won't be needed each time (probably best to do in
> > check_release_regno, and set it there).
> >
> I elaborated a bit more on this in my next comment, but I think we
> should just get rid of is_release_function() and use
> meta.release_regno to track in check_func_arg() if the function is a
> release function.
> > >
> > > >  static int int_ptr_type_to_size(enum bpf_arg_type type)
> > > >  {
> > > >         if (type == ARG_PTR_TO_INT)
> > > > @@ -5532,7 +5538,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > >                 /* Some of the argument types nevertheless require a
> > > >                  * zero register offset.
> > > >                  */
> > > > -               if (arg_type != ARG_PTR_TO_ALLOC_MEM)
> > > > +               if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> > > >                         return 0;
> > > >                 break;
> > > >         /* All the rest must be rejected, except PTR_TO_BTF_ID which allows
> > >
> > > Later on in this check_func_arg_reg_off() function, I think we can get
> > > rid of the hacky workaround for the PTR_TO_BTF_ID case where it relies
> > > on whether the function is a release function and reg->ref_obj_id is
> > > set, to determine whether the argument is a release arg or not. The
> > > arg type is passed directly to check_func_arg_reg_off(), so I think we
> > > could just use arg_type_is_release_ptr(arg_type) instead, which will
> > > also be more robust when/if we support having multiple release args in
> > > the future.
> >
> > Ok, sounds good.
> >
> > >
> > > > @@ -6124,12 +6130,31 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
> > > >         return true;
> > > >  }
> > > >
> > > > -static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
> > > > +static bool check_release_regno(const struct bpf_func_proto *fn, int func_id,
> > > > +                               struct bpf_call_arg_meta *meta)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> > > > +               if (arg_type_is_release_ptr(fn->arg_type[i])) {
> > > > +                       if (!is_release_function(func_id))
> > > > +                               return false;
> > > > +                       if (meta->release_regno)
> > > > +                               return false;
> > > > +                       meta->release_regno = i + 1;
> > > > +               }
> > > > +       }
> > > > +       return !is_release_function(func_id) || meta->release_regno;
> > > > +}
> > > Is this check needed? There's already a check in check_func_arg that
> > > there can't be two arg registers with ref_obj_ids set. I think this
> > > already checks against the case where the user tries to pass in two
> > > release registers as arguments.
> >
> > This is different, this is about preventing the case where some func_id is
> > listed as release function, but none of its arguments were tagged as
> > PTR_RELEASE. It also doubles as a way to record the regno being released,
> > since we need to loop anyway.
> Why do we need to prevent the case where a release kernel helper
> function doesn't have any of its arguments tagged as PTR_RELEASE or
> conversely, that a non-release helper function has one of its
> arguments tagged with PTR_RELEASE? That would be a bug in the kernel
> then. I think we can just assume that this will never be the case.
>
> Given that, I'm in favor of just removing check_release_regno()
> altogether, and doing the meta->release_regno assignment + check for
> multiple PTR_MEM args in check_func_arg() right after the
> skip_type_check: goto. We already do the assignment + multiple
> instances check there for meta->ref_obj_id. That to me looks like the
> cleanest approach.
> >
> > If we are removing is_release_function, we can just make sure PTR_RELEASE is
> > only seen once, and consider such functions as release functions (and set
> > meta.release_function to true).
> I don't think you even need meta->release_function, since you already
> have meta->release_regno, no? You can just check whether
> meta->release_regno is non-zero.
> >
> > > > +
> > > > +static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
> > > > +                           struct bpf_call_arg_meta *meta)
> > > >  {
> > > >         return check_raw_mode_ok(fn) &&
> > > >                check_arg_pair_ok(fn) &&
> > > >                check_btf_id_ok(fn) &&
> > > > -              check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
> > > > +              check_refcount_ok(fn, func_id) &&
> > > > +              check_release_regno(fn, func_id, meta) ? 0 : -EINVAL;
> > > >  }
> > > >
> > > >  /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
> > > > @@ -6808,7 +6833,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > >         memset(&meta, 0, sizeof(meta));
> > > >         meta.pkt_access = fn->pkt_access;
> > > >
> > > > -       err = check_func_proto(fn, func_id);
> > > > +       err = check_func_proto(fn, func_id, &meta);
> > > >         if (err) {
> > > >                 verbose(env, "kernel subsystem misconfigured func %s#%d\n",
> > > >                         func_id_name(func_id), func_id);
> > > > @@ -6841,8 +6866,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > >                         return err;
> > > >         }
> > > >
> > > > +       regs = cur_regs(env);
> > > > +
> > > >         if (is_release_function(func_id)) {
> > > > -               err = release_reference(env, meta.ref_obj_id);
> > > > +               err = -EINVAL;
> > > > +               if (meta.ref_obj_id)
> > > > +                       err = release_reference(env, meta.ref_obj_id);
> > > > +               /* meta.ref_obj_id can only be 0 if register that is meant to be
> > > > +                * released is NULL, which must be > R0.
> > > > +                */
> > > > +               else if (meta.release_regno && register_is_null(&regs[meta.release_regno]))
> > > > +                       err = 0;
> > > >                 if (err) {
> > > >                         verbose(env, "func %s#%d reference has not been acquired before\n",
> > > >                                 func_id_name(func_id), func_id);
>
> Also, I forgot to mention this earlier, but I think we also need to
> check here that meta.release_regno == meta.ref_obj_id; otherwise there
> could be the case where if a helper function takes in at least two
> parameters one of which is PTR_RELEASE, the program could pass in
> something with no ref obj id as the PTR_RELEASE arg, and a ref obj id
> arg as one of the other args.
Not meta.release_regno == meta.ref_obj_id, but some way of checking
that the release arg is the one that has the ref obj id set. I think
the easiest way to do this is to just check that the reg also has a
valid ref obj id when we do the meta.release_regno assignment.
>
> > > > @@ -6850,8 +6884,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > >                 }
> > > >         }
> > > >
> > > > -       regs = cur_regs(env);
> > > > -
> > > >         switch (func_id) {
> > > >         case BPF_FUNC_tail_call:
> > > >                 err = check_reference_leak(env);
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 143f442a9505..8eb01a997476 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
> > > >         .func           = bpf_sk_release,
> > > >         .gpl_only       = false,
> > > >         .ret_type       = RET_INTEGER,
> > > > -       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> > > > +       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_RELEASE,
> > > >  };
> > > >
> > > >  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> > > > --
> > > > 2.35.1
> > > >
> >
> > --
> > Kartikeya
