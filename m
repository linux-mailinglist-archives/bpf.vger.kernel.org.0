Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8A4FEEC7
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiDMF4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiDMF4W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 01:56:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA238DB5
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 22:54:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p8so1068220pfh.8
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 22:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THKqEaw9VUv1HtRC2O8anfvfF2DlvGLHHedgDNmJ8sI=;
        b=i0s7qDfm1y6pROB4WLgfJY/tSwgqDnOub9rfvZQMPPe5bhSHNIWgU5xPRARbiLhFE7
         uKDp8bBii5GYVFfUnCkYRauSYFTUZ1iRtwb6hC3nXmRWQBqhYkCrPEDRAZMC8vvgsDQM
         pU32uq4EGMq6Ia0OGXEBivdhspoP36KaQMprS94soOmm48ycFQ0I163H+TWtEju7DbHj
         L3PMJ1wwu1Av3JMqxHj343HAYcepxOkjuMoL3ix/91decEpF3PTilMU1pXCCd1B8OKkN
         24XLU61DKaNymlk2UJZhTps5SREoRPHfd7Lj08wem/70ZWRaxmzfJqSS6pq33v9b8GYO
         8IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THKqEaw9VUv1HtRC2O8anfvfF2DlvGLHHedgDNmJ8sI=;
        b=nVy4WOZDbn7O5QSa+3IwDiFkYdsWHStIOZaIaQmuBfkOlR+64rDq13FB/7QV8ftbwg
         W+42kY3rI5TOmbR7B1bgI9vE3co6gzaXIGn8NomZiC6r0DYU8iMm34fFkLL7GDJtX/dN
         szebtEzkGyNE4s/Y4S/a9CxMHZcO51eNQYXZqpcABlWoRdwzjMbbDqo99ceJCBv8BJP3
         ZnqbN/6MLikzdki562SPkE/0eMiAvPecSmcvS/cxMAc/8vd52pnDpLGQs+fn36/vdovv
         //RE8lk+RloZSOA8GLNTipkilpncvUITbmGdYM6jTwOXuukr+ToJlqAcPHWPDKZm/8pd
         57gg==
X-Gm-Message-State: AOAM5336nlR0pXXI6HTEqhxXtXxJRHtHUi70MetTU5F4L3x1rIzmShlx
        TTyBsnCJpgoUjR0wDswyNMM=
X-Google-Smtp-Source: ABdhPJzP8t1kRhDDnoz95DdWhTaP7h4o2Kx0/zXw3U4cGmp6GbT1fLHQh/hbe0tFTzJhST8AGFfeqg==
X-Received: by 2002:a63:e051:0:b0:382:6aff:229a with SMTP id n17-20020a63e051000000b003826aff229amr33498663pgj.493.1649829241121;
        Tue, 12 Apr 2022 22:54:01 -0700 (PDT)
Received: from localhost ([112.79.166.120])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b001c7b10fe359sm1493940pjb.5.2022.04.12.22.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:54:00 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:24:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220413055400.dic7boz6axh3hzqo@apollo.legion>
References: <20220409093303.499196-1-memxor@gmail.com>
 <20220409093303.499196-6-memxor@gmail.com>
 <CAJnrk1YkUDDLiLBiwb8UtpjqhBRkNdq0C22z3yVo=7RyLOXn1A@mail.gmail.com>
 <20220413053604.c4nhjeb7mmmcfxod@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413053604.c4nhjeb7mmmcfxod@apollo.legion>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 13, 2022 at 11:06:04AM IST, Kumar Kartikeya Dwivedi wrote:
> On Wed, Apr 13, 2022 at 04:35:11AM IST, Joanne Koong wrote:
> > On Mon, Apr 11, 2022 at 12:25 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Extending the code in previous commit, introduce referenced kptr
> > > support, which needs to be tagged using 'kptr_ref' tag instead. Unlike
> > > unreferenced kptr, referenced kptr have a lot more restrictions. In
> > > addition to the type matching, only a newly introduced bpf_kptr_xchg
> > > helper is allowed to modify the map value at that offset. This transfers
> > > the referenced pointer being stored into the map, releasing the
> > > references state for the program, and returning the old value and
> > > creating new reference state for the returned pointer.
> > >
> > > Similar to unreferenced pointer case, return value for this case will
> > > also be PTR_TO_BTF_ID_OR_NULL. The reference for the returned pointer
> > > must either be eventually released by calling the corresponding release
> > > function, otherwise it must be transferred into another map.
> > >
> > > It is also allowed to call bpf_kptr_xchg with a NULL pointer, to clear
> > > the value, and obtain the old value if any.
> > >
> > > BPF_LDX, BPF_STX, and BPF_ST cannot access referenced kptr. A future
> > > commit will permit using BPF_LDX for such pointers, but attempt at
> > > making it safe, since the lifetime of object won't be guaranteed.
> > >
> > > There are valid reasons to enforce the restriction of permitting only
> > > bpf_kptr_xchg to operate on referenced kptr. The pointer value must be
> > > consistent in face of concurrent modification, and any prior values
> > > contained in the map must also be released before a new one is moved
> > > into the map. To ensure proper transfer of this ownership, bpf_kptr_xchg
> > > returns the old value, which the verifier would require the user to
> > > either free or move into another map, and releases the reference held
> > > for the pointer being moved in.
> > >
> > > In the future, direct BPF_XCHG instruction may also be permitted to work
> > > like bpf_kptr_xchg helper.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |   7 +++
> > >  include/uapi/linux/bpf.h       |  12 ++++
> > >  kernel/bpf/btf.c               |  10 ++-
> > >  kernel/bpf/helpers.c           |  21 +++++++
> > >  kernel/bpf/verifier.c          | 107 +++++++++++++++++++++++++++++----
> > >  tools/include/uapi/linux/bpf.h |  12 ++++
> > >  6 files changed, 155 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index a6d1982e8118..bd682c29883a 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -160,10 +160,15 @@ enum {
> > >         BPF_MAP_VALUE_OFF_MAX = 8,
> > >  };
> > >
> > > +enum {
> > > +       BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> > I personally find this name very confusing. What does the "f" in
> > "OFF_F_REF" stand for? Also, I think adding in a comment for this
> > would help out future readers.
>
> The f is for 'flag', similar to e.g. BPF_F_LOCK. I'll add a comment.
> Also it can probably be type rather than flag.
>
> > > +};
> > > +
> > >  struct bpf_map_value_off_desc {
> > >         u32 offset;
> > >         u32 btf_id;
> > >         struct btf *btf;
> > > +       int flags;
> > It's unclear from reading this what flags refers to. Maybe adding a
> > comment here that flags holds values from the enum above (and maybe we
> > should give the enum a more descriptive name?) would make it clearer?
>
> I'll give the enum a name and rename it to 'type'. Then, for dynptr case,
> you can add other types of dynptr that can be embedded in map value.
>
> > >  };
> > >
> > >  struct bpf_map_value_off {
> > > @@ -416,6 +421,7 @@ enum bpf_arg_type {
> > >         ARG_PTR_TO_STACK,       /* pointer to stack */
> > >         ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> > >         ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> > > +       ARG_PTR_TO_KPTR,        /* pointer to kptr */
> > This is only a "pointer to a referenced kptr", correct?
>
> Yes. I'll update the comment.
>
> > >         __BPF_ARG_TYPE_MAX,
> > >
> > >         /* Extended arg_types. */
> > > @@ -425,6 +431,7 @@ enum bpf_arg_type {
> > >         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
> > >         ARG_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
> > >         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
> > > +       ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
> > >
> > >         /* This must be the last entry. Its purpose is to ensure the enum is
> > >          * wide enough to hold the higher bits reserved for bpf_type_flag.
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index d14b10b85e51..444fe6f1cf35 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5143,6 +5143,17 @@ union bpf_attr {
> > >   *             The **hash_algo** is returned on success,
> > >   *             **-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
> > >   *             invalid arguments are passed.
> > > + *
> > > + * void *bpf_kptr_xchg(void *map_value, void *ptr)
> > > + *     Description
> > > + *             Exchange kptr at pointer *map_value* with *ptr*, and return the
> > > + *             old value. *ptr* can be NULL, otherwise it must be a referenced
> > > + *             pointer which will be released when this helper is called.
> > > + *     Return
> > > + *             The old value of kptr (which can be NULL). The returned pointer
> > > + *             if not NULL, is a reference which must be released using its
> > > + *             corresponding release function, or moved into a BPF map before
> > > + *             program exit.
> > >   */
> > >  #define __BPF_FUNC_MAPPER(FN)          \
> > >         FN(unspec),                     \
> > > @@ -5339,6 +5350,7 @@ union bpf_attr {
> > >         FN(copy_from_user_task),        \
> > >         FN(skb_set_tstamp),             \
> > >         FN(ima_file_hash),              \
> > > +       FN(kptr_xchg),                  \
> > >         /* */
> > >
> > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 28b1d9e9124e..43ea9ed5652e 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3177,6 +3177,7 @@ enum {
> > >  struct btf_field_info {
> > >         u32 type_id;
> > >         u32 off;
> > > +       int flags;
> > >  };
> > >
> > >  static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> > > @@ -3194,6 +3195,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > >                                u32 off, int sz, struct btf_field_info *info)
> > >  {
> > >         u32 res_id;
> > > +       int flags;
> > >
> > >         /* For PTR, sz is always == 8 */
> > >         if (!btf_type_is_ptr(t))
> > > @@ -3205,7 +3207,11 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > >         /* Reject extra tags */
> > >         if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> > >                 return -EINVAL;
> > > -       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > +       if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > +               flags = 0;
> > > +       else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off)))
> > > +               flags = BPF_MAP_VALUE_OFF_F_REF;
> > > +       else
> > >                 return -EINVAL;
> > >
> > >         /* Get the base type */
> > > @@ -3216,6 +3222,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > >
> > >         info->type_id = res_id;
> > >         info->off = off;
> > > +       info->flags = flags;
> > >         return BTF_FIELD_FOUND;
> > >  }
> > >
> > > @@ -3420,6 +3427,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> > >                 tab->off[i].offset = info_arr[i].off;
> > >                 tab->off[i].btf_id = id;
> > >                 tab->off[i].btf = off_btf;
> > > +               tab->off[i].flags = info_arr[i].flags;
> > >                 tab->nr_off = i + 1;
> > >         }
> > >         return tab;
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 315053ef6a75..a437d0f0458a 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1374,6 +1374,25 @@ void bpf_timer_cancel_and_free(void *val)
> > >         kfree(t);
> > >  }
> > >
> > > +BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
> > > +{
> > > +       unsigned long *kptr = map_value;
> > > +
> > > +       return xchg(kptr, (unsigned long)ptr);
> > > +}
> > > +
> > > +static u32 bpf_kptr_xchg_btf_id;
> > > +
> > > +const struct bpf_func_proto bpf_kptr_xchg_proto = {
> > > +       .func         = bpf_kptr_xchg,
> > > +       .gpl_only     = false,
> > > +       .ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
> > > +       .ret_btf_id   = &bpf_kptr_xchg_btf_id,
> > > +       .arg1_type    = ARG_PTR_TO_KPTR,
> > > +       .arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | PTR_RELEASE,
> > > +       .arg2_btf_id  = &bpf_kptr_xchg_btf_id,
> > > +};
> > > +
> > >  const struct bpf_func_proto bpf_get_current_task_proto __weak;
> > >  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
> > >  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> > > @@ -1452,6 +1471,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> > >                 return &bpf_timer_start_proto;
> > >         case BPF_FUNC_timer_cancel:
> > >                 return &bpf_timer_cancel_proto;
> > > +       case BPF_FUNC_kptr_xchg:
> > > +               return &bpf_kptr_xchg_proto;
> > >         default:
> > >                 break;
> > >         }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6cc08526e049..92efe6c3999c 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -258,6 +258,7 @@ struct bpf_call_arg_meta {
> > >         struct btf *ret_btf;
> > >         u32 ret_btf_id;
> > >         u32 subprogno;
> > > +       struct bpf_map_value_off_desc *kptr_off_desc;
> > >  };
> > >
> > >  struct btf *btf_vmlinux;
> > > @@ -480,7 +481,8 @@ static bool is_release_function(enum bpf_func_id func_id)
> > >  {
> > >         return func_id == BPF_FUNC_sk_release ||
> > >                func_id == BPF_FUNC_ringbuf_submit ||
> > > -              func_id == BPF_FUNC_ringbuf_discard;
> > > +              func_id == BPF_FUNC_ringbuf_discard ||
> > > +              func_id == BPF_FUNC_kptr_xchg;
> > >  }
> > >
> > >  static bool may_be_acquire_function(enum bpf_func_id func_id)
> > > @@ -500,7 +502,8 @@ static bool is_acquire_function(enum bpf_func_id func_id,
> > >         if (func_id == BPF_FUNC_sk_lookup_tcp ||
> > >             func_id == BPF_FUNC_sk_lookup_udp ||
> > >             func_id == BPF_FUNC_skc_lookup_tcp ||
> > > -           func_id == BPF_FUNC_ringbuf_reserve)
> > > +           func_id == BPF_FUNC_ringbuf_reserve ||
> > > +           func_id == BPF_FUNC_kptr_xchg)
> > >                 return true;
> > >
> > >         if (func_id == BPF_FUNC_map_lookup_elem &&
> > > @@ -3525,6 +3528,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >         /* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > >         reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > >
> > > +       /* For ref_ptr case, release function check should ensure we get one
> > > +        * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
> > I don't fully understand why the first sentence in this comment is
> > relevant to this function - this seems like it belongs more to
> > check_func_arg_reg_off() for the PTR_TO_BTF_ID case?
> >
>
> It is just meant to say that some of the checks that are required for referenced
> kptr case are already covered by those for normal release functions, so it is
> not required to redo them here. This function is called for both bpf_kptr_xchg
> and normal BPF insns.
>
> > > +        * normal store of unreferenced kptr, we must ensure var_off is zero.
> > > +        * Since ref_ptr cannot be accessed directly by BPF insns, checks for
> > > +        * reg->off and reg->ref_obj_id are not needed here.
> > > +        */
> >
> > >         if (__check_ptr_off_reg(env, reg, regno, true))
> > >                 return -EACCES;
> > >
> > > @@ -3557,6 +3566,12 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> > >         if (BPF_MODE(insn->code) != BPF_MEM)
> > >                 goto end;
> > >
> > > +       /* We cannot directly access kptr_ref */
> > > +       if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
> > > +               verbose(env, "accessing referenced kptr disallowed\n");
> > > +               return -EACCES;
> > > +       }
> > > +
> > >         if (class == BPF_LDX) {
> > >                 val_reg = reg_state(env, value_regno);
> > >                 /* We can simply mark the value_regno receiving the pointer
> > > @@ -5278,6 +5293,59 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
> > >         return 0;
> > >  }
> > >
> > > +static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> > > +                            struct bpf_call_arg_meta *meta)
> > > +{
> > > +       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > > +       struct bpf_map_value_off_desc *off_desc;
> > > +       struct bpf_map *map_ptr = reg->map_ptr;
> > > +       u32 kptr_off;
> > > +       int ret;
> > > +
> > > +       if (!tnum_is_const(reg->var_off)) {
> > > +               verbose(env,
> > > +                       "R%d doesn't have constant offset. kptr has to be at the constant offset\n",
> > > +                       regno);
> > > +               return -EINVAL;
> > > +       }
> > > +       if (!map_ptr->btf) {
> > > +               verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
> > > +                       map_ptr->name);
> > > +               return -EINVAL;
> > > +       }
> > > +       if (!map_value_has_kptrs(map_ptr)) {
> > > +               ret = PTR_ERR(map_ptr->kptr_off_tab);
> > > +               if (ret == -E2BIG)
> > > +                       verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
> > > +                               BPF_MAP_VALUE_OFF_MAX);
> > > +               else if (ret == -EEXIST)
> > > +                       verbose(env, "map '%s' has repeating kptr BTF tags\n", map_ptr->name);
> > > +               else
> > > +                       verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       meta->map_ptr = map_ptr;
> > > +       /* Check access for BPF_WRITE */
> > > +       meta->raw_mode = true;
> > > +       ret = check_helper_mem_access(env, regno, sizeof(u64), false, meta);
> > Do you need to check access here for both BPF_WRITE and BPF_READ since
> > you are also reading the map value when you do the xchg?
>
> I have a fix for this for the next version :). Actually it should be the
> opposite, that is we just need to check map is both read/write. So it should do
> a check with meta->raw_mode = false. We already prevent BPF_F_RDONLY_PROG from
> being set, so map is either BPF_F_WRONLY_PROG, or both read/write. In the first
> case, BPF_READ won't work, which is needed to support xchg, so we only need to
> reject that case.
>

Easiest would be to just reject BPF_F_WRONLY_PROG at MAP_CREATE, and just drop
check_helper_mem_access here completely.

> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       kptr_off = reg->off + reg->var_off.value;
> > > +       off_desc = bpf_map_kptr_off_contains(map_ptr, kptr_off);
> > > +       if (!off_desc) {
> > > +               verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
> > > +               return -EACCES;
> > > +       }
> > > +       if (!(off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
> > > +               verbose(env, "off=%d kptr isn't referenced kptr\n", kptr_off);
> > > +               return -EACCES;
> > > +       }
> > > +       meta->kptr_off_desc = off_desc;
> > > +       return 0;
> > > +}
> > > +
> > >  static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
> > >  {
> > >         return base_type(type) == ARG_PTR_TO_MEM ||
> > > @@ -5418,6 +5486,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > >  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> > > +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > >
> > >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >         [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> > > @@ -5445,11 +5514,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >         [ARG_PTR_TO_STACK]              = &stack_ptr_types,
> > >         [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> > >         [ARG_PTR_TO_TIMER]              = &timer_types,
> > > +       [ARG_PTR_TO_KPTR]               = &kptr_types,
> > >  };
> > >
> > >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >                           enum bpf_arg_type arg_type,
> > > -                         const u32 *arg_btf_id)
> > > +                         const u32 *arg_btf_id,
> > > +                         struct bpf_call_arg_meta *meta)
> > >  {
> > >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > >         enum bpf_reg_type expected, type = reg->type;
> > > @@ -5502,8 +5573,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >                         arg_btf_id = compatible->btf_id;
> > >                 }
> > >
> > > -               if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > -                                         btf_vmlinux, *arg_btf_id)) {
> > > +               if (meta->func_id == BPF_FUNC_kptr_xchg) {
> > > +                       if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
> > > +                               return -EACCES;
> > > +               } else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > +                                                btf_vmlinux, *arg_btf_id)) {
> > >                         verbose(env, "R%d is of type %s but %s is expected\n",
> > >                                 regno, kernel_type_name(reg->btf, reg->btf_id),
> > >                                 kernel_type_name(btf_vmlinux, *arg_btf_id));
> > > @@ -5613,7 +5687,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >                  */
> > >                 goto skip_type_check;
> > >
> > > -       err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg]);
> > > +       err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg], meta);
> > >         if (err)
> > >                 return err;
> > >
> > > @@ -5778,6 +5852,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >                         verbose(env, "string is not zero-terminated\n");
> > >                         return -EINVAL;
> > >                 }
> > > +       } else if (arg_type == ARG_PTR_TO_KPTR) {
> > > +               if (process_kptr_func(env, regno, meta))
> > > +                       return -EACCES;
> > >         }
> > >
> > >         return err;
> > > @@ -6120,10 +6197,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
> > >         int i;
> > >
> > >         for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> > > -               if (fn->arg_type[i] == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
> > > +               if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
> > >                         return false;
> > >
> > > -               if (fn->arg_type[i] != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
> > > +               if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
> > >                         return false;
> > >         }
> > >
> > > @@ -7007,21 +7084,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >                         regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> > >                 }
> > >         } else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
> > > +               struct btf *ret_btf;
> > >                 int ret_btf_id;
> > >
> > >                 mark_reg_known_zero(env, regs, BPF_REG_0);
> > >                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
> > > -               ret_btf_id = *fn->ret_btf_id;
> > > +               if (func_id == BPF_FUNC_kptr_xchg) {
> > > +                       ret_btf = meta.kptr_off_desc->btf;
> > > +                       ret_btf_id = meta.kptr_off_desc->btf_id;
> > > +               } else {
> > > +                       ret_btf = btf_vmlinux;
> > > +                       ret_btf_id = *fn->ret_btf_id;
> > > +               }
> > >                 if (ret_btf_id == 0) {
> > >                         verbose(env, "invalid return type %u of func %s#%d\n",
> > >                                 base_type(ret_type), func_id_name(func_id),
> > >                                 func_id);
> > >                         return -EINVAL;
> > >                 }
> > > -               /* current BPF helper definitions are only coming from
> > > -                * built-in code with type IDs from  vmlinux BTF
> > > -                */
> > > -               regs[BPF_REG_0].btf = btf_vmlinux;
> > > +               regs[BPF_REG_0].btf = ret_btf;
> > >                 regs[BPF_REG_0].btf_id = ret_btf_id;
> > >         } else {
> > >                 verbose(env, "unknown return type %u of func %s#%d\n",
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > > index d14b10b85e51..444fe6f1cf35 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -5143,6 +5143,17 @@ union bpf_attr {
> > >   *             The **hash_algo** is returned on success,
> > >   *             **-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
> > >   *             invalid arguments are passed.
> > > + *
> > > + * void *bpf_kptr_xchg(void *map_value, void *ptr)
> > > + *     Description
> > > + *             Exchange kptr at pointer *map_value* with *ptr*, and return the
> > > + *             old value. *ptr* can be NULL, otherwise it must be a referenced
> > > + *             pointer which will be released when this helper is called.
> > > + *     Return
> > > + *             The old value of kptr (which can be NULL). The returned pointer
> > > + *             if not NULL, is a reference which must be released using its
> > > + *             corresponding release function, or moved into a BPF map before
> > > + *             program exit.
> > >   */
> > >  #define __BPF_FUNC_MAPPER(FN)          \
> > >         FN(unspec),                     \
> > > @@ -5339,6 +5350,7 @@ union bpf_attr {
> > >         FN(copy_from_user_task),        \
> > >         FN(skb_set_tstamp),             \
> > >         FN(ima_file_hash),              \
> > > +       FN(kptr_xchg),                  \
> > >         /* */
> > >
> > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > --
> > > 2.35.1
> > >
>
> --
> Kartikeya

--
Kartikeya
