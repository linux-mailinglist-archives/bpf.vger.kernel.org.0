Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0824FE998
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiDLUq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiDLUR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 16:17:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DA51E7D
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 13:15:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z16so31818pfh.3
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzT8M4EgVSOmjqiUmLC4yKoe5I8Njwb2XZQH1P9w+2k=;
        b=XmJjssnsA0n3w4MTHNSxLZsXDrI3pNuHq5QZ5zJ7CW8zkxkkdul0qtJqBqg6FVTYqT
         75MJ4JPIK6hdlbeoN58MYAU12bliUZZjVJxjymu8BG6I5u5dq2HncZd8VrJSYo6HZ2dP
         3WFQUe96q6lXQNVYphXiUYECP3/fIG9V2Q0zY4umTHpB9E5FHfnaWWwCRBuBKzAr+nrH
         2mREJwrYIkYpjbCY+gqQz+YbtPzbW7s76eEI00wfiC7jOKS/snIRzGjzp4agoAyTNY8r
         mZkZtSSvki6tPo9rhfCQkt0GG4MPb49XyRLdie+t6reDsTqojzGspEiSqp/bpPFCLEAG
         lAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzT8M4EgVSOmjqiUmLC4yKoe5I8Njwb2XZQH1P9w+2k=;
        b=bt5+jxFvFQtWkWEmPCNsnSGTvj5E2NSHjBjQYyEBODl+LYieXp3bJJvEl7hZdLayAB
         FGjMVGB8tl3tuAd79BIgU3NK39REGfbMC6WF2GxhYxrVqrvZHcPUF08LXz3+OiPBpEIg
         8v4qu0IIAdVZ89hPBNX0YhlYjqoM0gghNCqky/KkO7I+PEmfHDhbVq2uda4bUSVt+YKJ
         TU8lhTaiGetuzQ5Rz0JWnPsLQAXS/zlgA0UzhOzy97csfZSGhXIvm+EFlokLzyeFIE1/
         bTMTErkEH6UWGRlNOvgB3aIWPLVZ4MdUXVuHof75d/kBR5vFAMa9im7a77noodwRTTRE
         qPPg==
X-Gm-Message-State: AOAM533RQ7xE6WS6u3Rq6JhfAoEEYb6hYOHSgSRAy/DgZH7p15T6Sf21
        l2I0ocd0CYvgqBSaZAjyU44=
X-Google-Smtp-Source: ABdhPJxsmSy6M/pKpiAYXnpbsEshtCxE8IA2xGQajRifM9jk9FJqCQJK1sBPaguzJoYstzSfjgQ1Zg==
X-Received: by 2002:a65:4249:0:b0:39d:88f5:6bac with SMTP id d9-20020a654249000000b0039d88f56bacmr5462529pgq.561.1649794282129;
        Tue, 12 Apr 2022 13:11:22 -0700 (PDT)
Received: from localhost ([112.79.143.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00230a00b004faa0f67c3esm39130336pfh.23.2022.04.12.13.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:11:21 -0700 (PDT)
Date:   Wed, 13 Apr 2022 01:41:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Tag argument to be released in
 bpf_func_proto
Message-ID: <20220412201121.xsel4y57ffmpyx47@apollo.legion>
References: <20220409093303.499196-1-memxor@gmail.com>
 <20220409093303.499196-5-memxor@gmail.com>
 <CAJnrk1ZJpbsO54J9jGKFdW9Li5WHTbK=rCrL0FYUb-0X1yq_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZJpbsO54J9jGKFdW9Li5WHTbK=rCrL0FYUb-0X1yq_AA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 11:46:14PM IST, Joanne Koong wrote:
> On Sun, Apr 10, 2022 at 11:58 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Add a new type flag for bpf_arg_type that when set tells verifier that
> > for a release function, that argument's register will be the one for
> > which meta.ref_obj_id will be set, and which will then be released
> > using release_reference. To capture the regno, introduce a new field
> > release_regno in bpf_call_arg_meta.
> >
> > This would be required in the next patch, where we may either pass NULL
> > or a refcounted pointer as an argument to the release function
> > bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
> > enough, as there is a case where the type of argument needed matches,
> > but the ref_obj_id is set to 0. Hence, we must enforce that whenever
> > meta.ref_obj_id is zero, the register that is to be released can only
> > be NULL for a release function.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   |  5 ++++-
> >  kernel/bpf/ringbuf.c  |  4 ++--
> >  kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++-------
> >  net/core/filter.c     |  2 +-
> >  4 files changed, 46 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e267db260cb7..a6d1982e8118 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -364,7 +364,10 @@ enum bpf_type_flag {
> >          */
> >         MEM_PERCPU              = BIT(4 + BPF_BASE_TYPE_BITS),
> >
> > -       __BPF_TYPE_LAST_FLAG    = MEM_PERCPU,
> > +       /* Indicates that the pointer argument will be released. */
> > +       PTR_RELEASE             = BIT(5 + BPF_BASE_TYPE_BITS),
> > +
> > +       __BPF_TYPE_LAST_FLAG    = PTR_RELEASE,
> >  };
> >
> >  /* Max number of base types. */
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index 710ba9de12ce..a22c21c0a7ef 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
> >  const struct bpf_func_proto bpf_ringbuf_submit_proto = {
> >         .func           = bpf_ringbuf_submit,
> >         .ret_type       = RET_VOID,
> > -       .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> > +       .arg1_type      = ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> >         .arg2_type      = ARG_ANYTHING,
> >  };
> >
> > @@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
> >  const struct bpf_func_proto bpf_ringbuf_discard_proto = {
> >         .func           = bpf_ringbuf_discard,
> >         .ret_type       = RET_VOID,
> > -       .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> > +       .arg1_type      = ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> >         .arg2_type      = ARG_ANYTHING,
> >  };
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 01d45c5010f9..6cc08526e049 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
> >         struct bpf_map *map_ptr;
> >         bool raw_mode;
> >         bool pkt_access;
> > +       u8 release_regno;
> >         int regno;
> >         int access_size;
> >         int mem_size;
> > @@ -5300,6 +5301,11 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> >                type == ARG_PTR_TO_LONG;
> >  }
> >
> > +static bool arg_type_is_release_ptr(enum bpf_arg_type type)
> > +{
> > +       return type & PTR_RELEASE;
> > +}
> > +
> Now that we have PTR_RELEASE as a bpf arg type descriptor, why do we
> still need is_release_function() in the verifier? I think we should
> just remove is_release_function() altogether - is_release_function()
> isn't functionally necessary now that we have PTR_RELEASE, and I don't
> think it's great that is_release_function() hardcodes specific
> functions into the verifier. What are your thoughts?

We need it to (atleast) guard the meta.ref_obj_id release, otherwise you have to
check for PTR_RELEASE in all arguments to determine it is a release function.
I guess we could record whether function is release function in meta, then
looping over arguments won't be needed each time (probably best to do in
check_release_regno, and set it there).

>
> >  static int int_ptr_type_to_size(enum bpf_arg_type type)
> >  {
> >         if (type == ARG_PTR_TO_INT)
> > @@ -5532,7 +5538,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >                 /* Some of the argument types nevertheless require a
> >                  * zero register offset.
> >                  */
> > -               if (arg_type != ARG_PTR_TO_ALLOC_MEM)
> > +               if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> >                         return 0;
> >                 break;
> >         /* All the rest must be rejected, except PTR_TO_BTF_ID which allows
>
> Later on in this check_func_arg_reg_off() function, I think we can get
> rid of the hacky workaround for the PTR_TO_BTF_ID case where it relies
> on whether the function is a release function and reg->ref_obj_id is
> set, to determine whether the argument is a release arg or not. The
> arg type is passed directly to check_func_arg_reg_off(), so I think we
> could just use arg_type_is_release_ptr(arg_type) instead, which will
> also be more robust when/if we support having multiple release args in
> the future.

Ok, sounds good.

>
> > @@ -6124,12 +6130,31 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
> >         return true;
> >  }
> >
> > -static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
> > +static bool check_release_regno(const struct bpf_func_proto *fn, int func_id,
> > +                               struct bpf_call_arg_meta *meta)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> > +               if (arg_type_is_release_ptr(fn->arg_type[i])) {
> > +                       if (!is_release_function(func_id))
> > +                               return false;
> > +                       if (meta->release_regno)
> > +                               return false;
> > +                       meta->release_regno = i + 1;
> > +               }
> > +       }
> > +       return !is_release_function(func_id) || meta->release_regno;
> > +}
> Is this check needed? There's already a check in check_func_arg that
> there can't be two arg registers with ref_obj_ids set. I think this
> already checks against the case where the user tries to pass in two
> release registers as arguments.

This is different, this is about preventing the case where some func_id is
listed as release function, but none of its arguments were tagged as
PTR_RELEASE. It also doubles as a way to record the regno being released,
since we need to loop anyway.

If we are removing is_release_function, we can just make sure PTR_RELEASE is
only seen once, and consider such functions as release functions (and set
meta.release_function to true).

> > +
> > +static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
> > +                           struct bpf_call_arg_meta *meta)
> >  {
> >         return check_raw_mode_ok(fn) &&
> >                check_arg_pair_ok(fn) &&
> >                check_btf_id_ok(fn) &&
> > -              check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
> > +              check_refcount_ok(fn, func_id) &&
> > +              check_release_regno(fn, func_id, meta) ? 0 : -EINVAL;
> >  }
> >
> >  /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
> > @@ -6808,7 +6833,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >         memset(&meta, 0, sizeof(meta));
> >         meta.pkt_access = fn->pkt_access;
> >
> > -       err = check_func_proto(fn, func_id);
> > +       err = check_func_proto(fn, func_id, &meta);
> >         if (err) {
> >                 verbose(env, "kernel subsystem misconfigured func %s#%d\n",
> >                         func_id_name(func_id), func_id);
> > @@ -6841,8 +6866,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                         return err;
> >         }
> >
> > +       regs = cur_regs(env);
> > +
> >         if (is_release_function(func_id)) {
> > -               err = release_reference(env, meta.ref_obj_id);
> > +               err = -EINVAL;
> > +               if (meta.ref_obj_id)
> > +                       err = release_reference(env, meta.ref_obj_id);
> > +               /* meta.ref_obj_id can only be 0 if register that is meant to be
> > +                * released is NULL, which must be > R0.
> > +                */
> > +               else if (meta.release_regno && register_is_null(&regs[meta.release_regno]))
> > +                       err = 0;
> >                 if (err) {
> >                         verbose(env, "func %s#%d reference has not been acquired before\n",
> >                                 func_id_name(func_id), func_id);
> > @@ -6850,8 +6884,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 }
> >         }
> >
> > -       regs = cur_regs(env);
> > -
> >         switch (func_id) {
> >         case BPF_FUNC_tail_call:
> >                 err = check_reference_leak(env);
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 143f442a9505..8eb01a997476 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
> >         .func           = bpf_sk_release,
> >         .gpl_only       = false,
> >         .ret_type       = RET_INTEGER,
> > -       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> > +       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_RELEASE,
> >  };
> >
> >  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> > --
> > 2.35.1
> >

--
Kartikeya
