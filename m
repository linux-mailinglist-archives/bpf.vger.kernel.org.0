Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772BB5076A9
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiDSRi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDSRi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 13:38:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370027170
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 10:35:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w19so30643239lfu.11
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzJyUKcTsQVUoRD1VDxhvoRsFEIphxf4RfWVgFSY5Q4=;
        b=N5qyEfico62hyPNL1++3H8EKROP7Fc5+egT9jlyULb52S2DaKvJh/MRD0xto2Tby9O
         ARcsyroeSD9RKkBBIubV3/EiNZGzF8KEHNoPEGQIbo43V3vhAXs6BuFHGVEVr2CEbEGn
         VqWwtxWTp7BsDUa4NjK57rXvpZveGGlDpg98gReninwQertVJ4VsyAic8C6ER8Eaotvx
         7qGpG0iF8Q56iMl+BuudmJAYNqwlR9pOa57Ie1ks93zXxBFwtyrxZ8f9iamiR5Th11xN
         toy4gVSEwyrvWQ/3jLqLMr0/I71+t2WN9t0ENpdUOsXRNYUpsfpuo8qj5CcmBLj1k0mL
         MbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzJyUKcTsQVUoRD1VDxhvoRsFEIphxf4RfWVgFSY5Q4=;
        b=6HhztWiR730992nFpIQbo/4Bmc9WoOwD48znRYmmCJQBBcmmCPKNLDuRk9YXvvdBLT
         h1md2AvfgBPJe7O+BhbygG9kUQQaO0LAaLVXZqzJxHtPlRCHPugkEfzUo5ll+y8UsPGY
         uvs66H6JblFizT1QyjUKHdlBg788/ttzQfsEZQkagQfnLDwogkgAW5YMTYpJXGLB9lYa
         TIWiThR97Y7iqIosnogQ3+tC9zCHWNl9ZBhC2Eo47NFI2zKcvFHA4CmH4hWkSq2kCMLx
         PCtM2zCqQGXst1w7NLZEXmxUxXL6rDtKntUJX+45/s6GJTv8A5VpBtgH4wupfERIrp37
         5/eQ==
X-Gm-Message-State: AOAM532lh+C12VFkE0+VAE9Uhoq/dRBDVsPjV4qIrENcBKFYuRV2mDoT
        UZK+OOy/JtHk+i37LwdlWVoacdZ2Nt8je5xRPW4=
X-Google-Smtp-Source: ABdhPJxRhLm8/oLK+tUXfm0zkbnLprvux6R1HYAUwXJQbW4lKFjGTrHKgTxhkvRbHAtLM9fiykE5dAVoybg5eEMmSjc=
X-Received: by 2002:a05:6512:10c5:b0:471:924f:1eed with SMTP id
 k5-20020a05651210c500b00471924f1eedmr7467826lfg.641.1650389739930; Tue, 19
 Apr 2022 10:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220415160354.1050687-1-memxor@gmail.com> <20220415160354.1050687-7-memxor@gmail.com>
 <CAJnrk1YBi+DMZVu3Bpq+74OnFCjkc_fAgv_P-ANgpDrrfGOukQ@mail.gmail.com> <20220419024703.qyv6n4dfpdf4p3ot@apollo.legion>
In-Reply-To: <20220419024703.qyv6n4dfpdf4p3ot@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 19 Apr 2022 10:35:28 -0700
Message-ID: <CAJnrk1bq+LmXjeEb-xTsZ7DBqKKxQb3ub1n=BbGyi+Z6bmohOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/13] bpf: Prevent escaping of kptr loaded
 from maps
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

On Mon, Apr 18, 2022 at 7:46 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Apr 19, 2022 at 05:18:38AM IST, Joanne Koong wrote:
> > On Fri, Apr 15, 2022 at 9:04 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > While we can guarantee that even for unreferenced kptr, the object
> > > pointer points to being freed etc. can be handled by the verifier's
> > > exception handling (normal load patching to PROBE_MEM loads), we still
> > > cannot allow the user to pass these pointers to BPF helpers and kfunc,
> > > because the same exception handling won't be done for accesses inside
> > > the kernel. The same is true if a referenced pointer is loaded using
> > > normal load instruction. Since the reference is not guaranteed to be
> > > held while the pointer is used, it must be marked as untrusted.
> > >
> > > Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
> > > all registers loading unreferenced and referenced kptr from BPF maps,
> > > and ensure they can never escape the BPF program and into the kernel by
> > > way of calling stable/unstable helpers.
> > To me, it seems more clear / straightforward if loads are prohibited
> > altogether and the only way to get a referenced kptr from a BPF map is
> > through the *_kptr_get function, instead of allowing loads but
> > prohibiting the loaded value from going to bpf helpers + kfuncs. To me
> > it seems like 1) using the kptr in kfuncs / helper funcs will be a
> > significant portion of use cases, 2) as a user, I think it's
> > non-intuitive that I'm able to retrieve it and get a direct reference
> > to it but not be able to use it in a kfunc/helper func, and 3) this
> > would simplify this logic in the verifier where we don't need to add
> > PTR_UNTRUSTED.
> > What are your thoughts?
> >
>
> Given this is atleast needed for the unreferenced case, so the flag needs to
> stay, but considering just referenced kptr:
>
Oh I see. I was thinking about the referenced case mostly and wasn't
considering the unreferenced kptr in map case. I agree then - we'll
need it for the unreferenced case so we might as well also have it for
the referenced case.

> 1) is true, but in many use cases just reading from the object is also enough,
> in those cases imposing the cost of kptr_get is too much, I think. If there are
> reasonable gurantees that the object won't go away, or some way to detect that
> the pointer changed (e.g. by detecting writer presence [0]), it should be safe
> to permit reads from such untrusted pointer without ensuring user holds a
> refcount. You can imagine case where you have programs attached to a callchain,
> and you stash a ref in a map in an invocation earlier in the chain, then inspect
> the data somewhere in the middle, and eventually drop the ref, etc. The fact
> that this can be made safe using the exception handling is a great feature IMO.
>
> 2) It can certainly be a bit surprising, but I think kptr_ref is already special
> enough that the user needs to carefully understand the semantics when making use
> of them. Even now, you will have to use kptr_get to be able to get a normal
> PTR_TO_BTF_ID they can pass to helpers, the untrusted pointer is for cases where
> you know what you are doing (and know that what you'll read is still valid at a
> later point, depending on how that data will be used).
>
> 3) We already need this flag, for this case and eventually also making this the
> default for majority of cases where we cannot prove PTR_TO_BTF_ID is safe (e.g.
> in tracing or LSM ctx). See [1] for some background. There are going to be a lot
> more cases going forward where dereference is safe (hence allowed) but passing
> to helpers or kfunc is not.
Gotcha. Thanks for the context.
>
>  [0]: https://lore.kernel.org/bpf/20220222082129.yivvpm6yo3474dp3@apollo.legion
>  [1]: https://lore.kernel.org/bpf/CAADnVQJF8yQgKRQH2CqXuB9JR-p3fQeiGRxB0+N_V7uTH2iOeA@mail.gmail.com
>
> > >
> > > In check_ptr_to_btf_access, the !type_may_be_null check to reject type
> > > flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
> > > MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
> > > two are checked inside the function and rejected using a proper error
> > > message, but we still want to allow dereference of untrusted case.
> > >
> > > Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
> > > walked, so that this flag is never dropped once it has been set on a
> > > PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
> > > direction).
> > >
> > > In convert_ctx_accesses, extend the switch case to consider untrusted
> > > PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
> > > conversion for BPF_LDX.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h   | 10 +++++++++-
> > >  kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++-------
> > >  2 files changed, 37 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 61f83a23980f..7e2ac2a26bdb 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -375,7 +375,15 @@ enum bpf_type_flag {
> > >         /* Indicates that the pointer argument will be released. */
> > >         PTR_RELEASE             = BIT(5 + BPF_BASE_TYPE_BITS),
> > >
> > > -       __BPF_TYPE_LAST_FLAG    = PTR_RELEASE,
> > > +       /* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
> > > +        * unreferenced and referenced kptr loaded from map value using a load
> > > +        * instruction, so that they can only be dereferenced but not escape the
> > > +        * BPF program into the kernel (i.e. cannot be passed as arguments to
> > > +        * kfunc or bpf helpers).
> > > +        */
> > > +       PTR_UNTRUSTED           = BIT(6 + BPF_BASE_TYPE_BITS),
> > > +
> > > +       __BPF_TYPE_LAST_FLAG    = PTR_UNTRUSTED,
> > >  };
> > >
> > >  /* Max number of base types. */
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index aa5c0d1c8495..3b89dc8d41ce 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> > >                 strncpy(prefix, "user_", 32);
> > >         if (type & MEM_PERCPU)
> > >                 strncpy(prefix, "percpu_", 32);
> > > +       if (type & PTR_UNTRUSTED)
> > > +               strncpy(prefix, "untrusted_", 32);
> > >
> > >         snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> > >                  prefix, str[base_type(type)], postfix);
> > > @@ -3504,9 +3506,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >                                struct bpf_reg_state *reg, u32 regno)
> > >  {
> > >         const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
> > > +       int perm_flags = PTR_MAYBE_NULL;
> > >         const char *reg_name = "";
> > >
> > > -       if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
> > > +       /* Only unreferenced case accepts untrusted pointers */
> > > +       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
> > > +               perm_flags |= PTR_UNTRUSTED;
> > > +
> > > +       if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
> > >                 goto bad_type;
> > >
> > >         if (!btf_is_kernel(reg->btf)) {
> > > @@ -3532,7 +3539,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >  bad_type:
> > >         verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> > >                 reg_type_str(env, reg->type), reg_name);
> > > -       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > > +       verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > > +       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
> > > +               verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
> > > +                       targ_name);
> > > +       else
> > > +               verbose(env, "\n");
> > >         return -EINVAL;
> > >  }
> > >
> > > @@ -3556,9 +3568,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> > >                 return -EACCES;
> > >         }
> > >
> > > -       /* We cannot directly access kptr_ref */
> > > -       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
> > > -               verbose(env, "accessing referenced kptr disallowed\n");
> > > +       /* We only allow loading referenced kptr, since it will be marked as
> > > +        * untrusted, similar to unreferenced kptr.
> > > +        */
> > > +       if (class != BPF_LDX && off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
> > > +               verbose(env, "store to referenced kptr disallowed\n");
> > >                 return -EACCES;
> > >         }
> > >
> > > @@ -3568,7 +3582,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> > >                  * value from map as PTR_TO_BTF_ID, with the correct type.
> > >                  */
> > >                 mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
> > > -                               off_desc->kptr.btf_id, PTR_MAYBE_NULL);
> > > +                               off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
> > >                 val_reg->id = ++env->id_gen;
> > >         } else if (class == BPF_STX) {
> > >                 val_reg = reg_state(env, value_regno);
> > > @@ -4336,6 +4350,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > +       /* If this is an untrusted pointer, all pointers formed by walking it
> > > +        * also inherit the untrusted flag.
> > > +        */
> > > +       if (type_flag(reg->type) & PTR_UNTRUSTED)
> > > +               flag |= PTR_UNTRUSTED;
> > > +
> > >         if (atype == BPF_READ && value_regno >= 0)
> > >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> > >
> > > @@ -13054,7 +13074,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> > >                 if (!ctx_access)
> > >                         continue;
> > >
> > > -               switch (env->insn_aux_data[i + delta].ptr_type) {
> > > +               switch ((int)env->insn_aux_data[i + delta].ptr_type) {
> > >                 case PTR_TO_CTX:
> > >                         if (!ops->convert_ctx_access)
> > >                                 continue;
> > > @@ -13071,6 +13091,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> > >                         convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
> > >                         break;
> > >                 case PTR_TO_BTF_ID:
> > > +               case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> > >                         if (type == BPF_READ) {
> > >                                 insn->code = BPF_LDX | BPF_PROBE_MEM |
> > >                                         BPF_SIZE((insn)->code);
> > > --
> > > 2.35.1
> > >
>
> --
> Kartikeya
