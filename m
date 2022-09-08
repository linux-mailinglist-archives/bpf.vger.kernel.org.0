Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C75B12B8
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIHDB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiIHDBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 23:01:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E0CC6B6C
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 20:01:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v128so2015614ioe.12
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=17LmB6FoXve8s1ZsTw7PK25DWwPXJeYoD21NWCUtcTA=;
        b=PBOKkThWkmCJpocgdnHl1gDNBt7e1fiFRncGvGvgNNnUcMU720Auy3KCwrawcJUaO1
         a568JBSw9xOkYSYw5lsxRtsyRLWYEKs9sleZYBqTIuVkejQIsp2a5TJzTzxGxeQorkNl
         +ko+gApbA/ilrnBOKWD30aL5EKhdYqhYRldwELZrEP1b0lw/fCB/ECc5q+MmSKAzPB9j
         sYMgxGkIK9M2fpbHJX4BKjamy7EcTm931X4d+tjPBs4+95sOAr7Wgx+EuzMOUoZV0OXq
         fUKpTe5Et8vCzqoR/Age3Hn1s6BhMx56W0i7aej00eYfUTuduoM6kaL6hgJ7R6y4wSYr
         rtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=17LmB6FoXve8s1ZsTw7PK25DWwPXJeYoD21NWCUtcTA=;
        b=xvv52WBriSP1rbE/5ir2VPJ4ujfnN57bJPAUdu7hn3FGh+rq/LQdgN2bwfNumsRGRa
         oknUXGrv4BkCfzKCm8KwFf7/MmCw94nErK9f1ZZFjve1v2lRTBoJTQz9Af7c3lh94ItZ
         3adsSfqzlhj715Lbeyf5AkADwp2of6VjFUWFP4RADlxikq1CXq1ymmpE5cOWJZZS3HYe
         crIVkl2HRhsynmjJOfNFk1NTEFVxhG1GeJoeuFcaAAAYT8oWnqcHfDX3bGjKvJORtdIq
         7PjIaAxnhzjZd9T7W7nUre9pZDULQsajGoK5aSdOALTyv+7VYhPVotCDwnWytIul5tnY
         IuaQ==
X-Gm-Message-State: ACgBeo1e7PMESQ+1MgEkEbShPEtQkPdC6+aubrBRug8wDPKOr1a/oC16
        PrbhYAxHTP1E2/ANhCAeo+edZVKxKa3sxk+qsCc=
X-Google-Smtp-Source: AA6agR40XZYSHpe/XheYd1Mp/BcG+PnLCC7dvSyCcRaRnn+rx6zWyIrWElrD11LMjPfeMiJac5ousdfngFGqUyJBNjM=
X-Received: by 2002:a05:6638:16cf:b0:34a:263f:966d with SMTP id
 g15-20020a05663816cf00b0034a263f966dmr3588561jat.124.1662606112365; Wed, 07
 Sep 2022 20:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-15-memxor@gmail.com>
 <20220907233023.x3uclwlnjuhftvtb@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220907233023.x3uclwlnjuhftvtb@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 05:01:16 +0200
Message-ID: <CAP01T77n8pt8CP2N936L4bTHo1acqA7wrdjg2TXkV4m9fLHamg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 14/32] bpf: Introduce bpf_kptr_alloc helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
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

On Thu, 8 Sept 2022 at 01:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:27PM +0200, Kumar Kartikeya Dwivedi wrote:
> > To allocate local kptr of types pointing into program BTF instead of
> > kernel BTF, bpf_kptr_alloc is a new helper that takes the local type's
> > BTF ID and returns a pointer to it. The size is automatically inferred
> > from the type ID by the BPF verifier, so user only passes the BTF ID and
> > flags, if any. For now, no flags are supported.
> >
> > First, we use the new constant argument type support for kfuncs that
> > enforces argument is a constant. We need to know the local type's BTF ID
> > statically to enforce safety properties for the allocation. Next, we
> > remember this and dynamically assign the return type. During that phase,
> > we also query the actual size of the structure being allocated, and
> > whether it is a struct type. If so, we stash the actual size for
> > do_misc_fixups phase where we rewrite the first argument to be size
> > instead of local type's BTF ID, which we can then pass on to the kernel
> > allocator.
> >
> > This needs some additional support for kfuncs as we were not doing
> > argument rewrites for them. The fixup has been moved inside
> > fixup_kfunc_call itself to avoid polluting the huge do_misc_fixups,
> > and delta, prog, and insn pointers are recalculated based on if any
> > instructions were patched.
> >
> > The returned pointer needs to be handled specially as well. While
> > normally, only struct pointers may be returned, a new internal kfunc
> > flag __KF_RET_DYN_BTF is used to indicate the BTF is ascertained from
> > arguments dynamically, hence it is now forced to be void * instead.
> > For now, bpf_kptr_alloc is the only user of this support.
> >
> > Hence, allocations using bpf_kptr_alloc are type safe. Later patches
> > will introduce constructor and destructor support to local kptrs
> > allocated from this helper. This would allow embedding kernel objects
> > like bpf_spin_lock, bpf_list_node, bpf_list_head inside a local kptr
> > allocation, and ensuring they are correctly initialized before use.
> >
> > A new type flag is associated with PTR_TO_BTF_ID returned from
> > bpf_kptr_alloc: MEM_TYPE_LOCAL. This indicates that the type of the
> > memory is of a local type coming from program's BTF.
> >
> > The btf_struct_access mechanism is tuned to allow BPF_WRITE access to
> > these allocated objects, so that programs can store data as usual in
> > them. On following a pointer type inside such PTR_TO_BTF_ID, WALK_PTR
> > sets the destination register as scalar instead. It would not be safe to
> > recognize pointer types in local types. This can be changed in the
> > future if it is allowed to embed kptrs inside such local kptrs.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  12 +-
> >  include/linux/bpf_verifier.h                  |   1 +
> >  include/linux/btf.h                           |   3 +
> >  kernel/bpf/btf.c                              |   8 +-
> >  kernel/bpf/helpers.c                          |  17 ++
> >  kernel/bpf/verifier.c                         | 156 +++++++++++++++---
> >  net/bpf/bpf_dummy_struct_ops.c                |   5 +-
> >  net/ipv4/bpf_tcp_ca.c                         |   5 +-
> >  .../testing/selftests/bpf/bpf_experimental.h  |  14 ++
> >  9 files changed, 191 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 35c2e9caeb98..5c8bfb0eba17 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -486,6 +486,12 @@ enum bpf_type_flag {
> >       /* Size is known at compile time. */
> >       MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +     /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > +      * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc, since they have
> > +      * entirely different semantics.
> > +      */
> > +     MEM_TYPE_LOCAL          = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >       __BPF_TYPE_FLAG_MAX,
> >       __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > @@ -757,7 +763,8 @@ struct bpf_verifier_ops {
> >                                const struct btf *btf,
> >                                const struct btf_type *t, int off, int size,
> >                                enum bpf_access_type atype,
> > -                              u32 *next_btf_id, enum bpf_type_flag *flag);
> > +                              u32 *next_btf_id, enum bpf_type_flag *flag,
> > +                              bool local_type);
> >  };
> >
> >  struct bpf_prog_offload_ops {
> > @@ -1995,7 +2002,8 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
> >  int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> >                     const struct btf_type *t, int off, int size,
> >                     enum bpf_access_type atype,
> > -                   u32 *next_btf_id, enum bpf_type_flag *flag);
> > +                   u32 *next_btf_id, enum bpf_type_flag *flag,
> > +                   bool local_type);
> >  bool btf_struct_ids_match(struct bpf_verifier_log *log,
> >                         const struct btf *btf, u32 id, int off,
> >                         const struct btf *need_btf, u32 need_type_id,
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index c4d21568d192..c6d550978d63 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -403,6 +403,7 @@ struct bpf_insn_aux_data {
> >                */
> >               struct bpf_loop_inline_state loop_inline_state;
> >       };
> > +     u64 kptr_alloc_size; /* used to store size of local kptr allocation */
> >       u64 map_key_state; /* constant (32 bit) key tracking for maps */
> >       int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
> >       u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 9b62b8b2117e..fc35c932e89e 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -52,6 +52,9 @@
> >  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> >  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> >
> > +/* Internal kfunc flags, not meant for general use */
> > +#define __KF_RET_DYN_BTF (1 << 7) /* kfunc returns dynamically ascertained PTR_TO_BTF_ID */
>
> Is there going to be another func that returns similar dynamic type?
> We have one such func already kptr_xhcg. I don't see why we need this flag.
> We can just compare func_id-s.
> In this patch it will be just fund_id == kfunc_ids[KF_kptr_alloc];
> When more kfuncs become alloc-like we will just add few ||.
>

There are, bpf_list_pop_{front,back}, even bpf_list_del, probably more
as we add more variants of lists.
But I don't mind keeping a list, they all need to be handled a bit
differently anyway to ascertain the type of PTR_TO_BTF_ID.

> > +
> >  struct btf;
> >  struct btf_member;
> >  struct btf_type;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0fb045be3837..17977e0f4e09 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5919,7 +5919,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
> >  int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> >                     const struct btf_type *t, int off, int size,
> >                     enum bpf_access_type atype __maybe_unused,
> > -                   u32 *next_btf_id, enum bpf_type_flag *flag)
> > +                   u32 *next_btf_id, enum bpf_type_flag *flag,
> > +                   bool local_type)
> >  {
> >       enum bpf_type_flag tmp_flag = 0;
> >       int err;
> > @@ -5930,6 +5931,11 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> >
> >               switch (err) {
> >               case WALK_PTR:
> > +                     /* For local types, the destination register cannot
> > +                      * become a pointer again.
> > +                      */
> > +                     if (local_type)
> > +                             return SCALAR_VALUE;
> >                       /* If we found the pointer or scalar on t+off,
> >                        * we're done.
> >                        */
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index fc08035f14ed..d417aa4f0b22 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1696,10 +1696,27 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >       }
> >  }
> >
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +               "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +void *bpf_kptr_alloc(u64 local_type_id__k, u64 flags)
> > +{
> > +     /* Verifier patches local_type_id__k to size */
> > +     u64 size = local_type_id__k;
> > +
> > +     if (flags)
> > +             return NULL;
> > +     return kmalloc(size, GFP_ATOMIC);
> > +}
> > +
> > +__diag_pop();
> > +
> >  BTF_SET8_START(tracing_btf_ids)
> >  #ifdef CONFIG_KEXEC_CORE
> >  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
> >  #endif
> > +BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
> >  BTF_SET8_END(tracing_btf_ids)
> >
> >  static const struct btf_kfunc_id_set tracing_kfunc_set = {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ab91e5ca7e41..8f28aa7f1e8d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> >       return type & PTR_MAYBE_NULL;
> >  }
> >
> > +static bool type_is_local(u32 type)
> > +{
> > +     return type & MEM_TYPE_LOCAL;
> > +}
> > +
> >  static bool is_acquire_function(enum bpf_func_id func_id,
> >                               const struct bpf_map *map)
> >  {
> > @@ -4556,17 +4561,22 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >               return -EACCES;
> >       }
> >
> > -     if (env->ops->btf_struct_access) {
> > +     /* For allocated PTR_TO_BTF_ID pointing to a local type, we cannot do
> > +      * btf_struct_access callback.
> > +      */
> > +     if (env->ops->btf_struct_access && !type_is_local(reg->type)) {
> >               ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
> > -                                               off, size, atype, &btf_id, &flag);
> > +                                               off, size, atype, &btf_id, &flag,
> > +                                               false);
> >       } else {
> > -             if (atype != BPF_READ) {
> > +             /* It is allowed to write to pointer to a local type */
> > +             if (atype != BPF_READ && !type_is_local(reg->type)) {
> >                       verbose(env, "only read is supported\n");
> >                       return -EACCES;
> >               }
> >
> >               ret = btf_struct_access(&env->log, reg->btf, t, off, size,
> > -                                     atype, &btf_id, &flag);
> > +                                     atype, &btf_id, &flag, type_is_local(reg->type));
>
> imo it's cleaner to pass 'reg' instead of 'reg->btf',
> so we don't have to pass another boolean.
> And check type_is_local(reg) inside btf_struct_access().
>

Yes, makes sense, will change in v1.

> >       }
> >
> >       if (ret < 0)
> > @@ -4630,7 +4640,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
> >               return -EACCES;
> >       }
> >
> > -     ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
> > +     ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag, false);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -7661,6 +7671,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_arg_meta *meta)
> >       return meta->kfunc_flags & KF_DESTRUCTIVE;
> >  }
> >
> > +static bool __is_kfunc_ret_dyn_btf(struct bpf_kfunc_arg_meta *meta)
> > +{
> > +     return meta->kfunc_flags & __KF_RET_DYN_BTF;
> > +}
> > +
> >  static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_arg_meta *meta, int arg)
> >  {
> >       return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> > @@ -7751,6 +7766,24 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> >  #endif
> >  };
> >
> > +BTF_ID_LIST(special_kfuncs)
> > +BTF_ID(func, bpf_kptr_alloc)
> > +
> > +enum bpf_special_kfuncs {
> > +     KF_SPECIAL_bpf_kptr_alloc,
> > +     KF_SPECIAL_MAX,
> > +};
> > +
> > +static bool __is_kfunc_special(const struct btf *btf, u32 func_id, unsigned int kf_sp)
> > +{
> > +     if (btf != btf_vmlinux || kf_sp >= KF_SPECIAL_MAX)
> > +             return false;
> > +     return func_id == special_kfuncs[kf_sp];
> > +}
> > +
> > +#define is_kfunc_special(btf, func_id, func_name) \
> > +     __is_kfunc_special(btf, func_id, KF_SPECIAL_##func_name)
>
> This looks like reinventing the wheel.
> I'd think similar to btf_tracing_ids[BTF_TRACING_TYPE_VMA] would work just as well.
> It's less magic. No need for above macro
> and btf != btf_vmlinux should really be explicit in the code
> and done early and once.
>

Ok.

> > +
> >  enum kfunc_ptr_arg_types {
> >       KF_ARG_PTR_TO_CTX,
> >       KF_ARG_PTR_TO_BTF_ID,        /* Also covers reg2btf_ids conversions */
> > @@ -8120,20 +8153,55 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >               mark_reg_unknown(env, regs, BPF_REG_0);
> >               mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> >       } else if (btf_type_is_ptr(t)) {
> > -             ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
> > -                                                &ptr_type_id);
> > -             if (!btf_type_is_struct(ptr_type)) {
> > -                     ptr_type_name = btf_name_by_offset(desc_btf,
> > -                                                        ptr_type->name_off);
> > -                     verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
> > -                             func_name, btf_type_str(ptr_type),
> > -                             ptr_type_name);
> > -                     return -EINVAL;
> > -             }
> > +             struct btf *ret_btf;
> > +             u32 ret_btf_id;
> > +
> > +             ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
> >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > -             regs[BPF_REG_0].btf = desc_btf;
> >               regs[BPF_REG_0].type = PTR_TO_BTF_ID;
> > -             regs[BPF_REG_0].btf_id = ptr_type_id;
> > +
> > +             if (__is_kfunc_ret_dyn_btf(&meta)) {
>
> just check meta.func_id == kfunc_ids[KF_kptr_alloc] instead?
>
> > +                     const struct btf_type *ret_t;
> > +
> > +                     /* Currently, only bpf_kptr_alloc needs special handling */
> > +                     if (!is_kfunc_special(meta.btf, meta.func_id, bpf_kptr_alloc) ||
>
> same thing.
>

Ack.

> > +                         !meta.arg_constant.found || !btf_type_is_void(ptr_type)) {
> > +                             verbose(env, "verifier internal error: misconfigured kfunc\n");
> > +                             return -EFAULT;
> > +                     }
> > +
> > +                     if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
> > +                             verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     ret_btf = env->prog->aux->btf;
> > +                     ret_btf_id = meta.arg_constant.value;
> > +
> > +                     ret_t = btf_type_by_id(ret_btf, ret_btf_id);
> > +                     if (!ret_t || !__btf_type_is_struct(ret_t)) {
> > +                             verbose(env, "local type ID %d passed to bpf_kptr_alloc does not refer to struct\n",
> > +                                     ret_btf_id);
> > +                             return -EINVAL;
> > +                     }
> > +                     /* Remember this so that we can rewrite R1 as size in fixup_kfunc_call */
> > +                     env->insn_aux_data[insn_idx].kptr_alloc_size = ret_t->size;
> > +                     /* For now, since we hardcode prog->btf, also hardcode
> > +                      * setting of this flag.
> > +                      */
> > +                     regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
> > +             } else {
> > +                     if (!btf_type_is_struct(ptr_type)) {
> > +                             ptr_type_name = btf_name_by_offset(desc_btf, ptr_type->name_off);
> > +                             verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
> > +                                     func_name, btf_type_str(ptr_type), ptr_type_name);
> > +                             return -EINVAL;
> > +                     }
> > +                     ret_btf = desc_btf;
> > +                     ret_btf_id = ptr_type_id;
> > +             }
> > +             regs[BPF_REG_0].btf = ret_btf;
> > +             regs[BPF_REG_0].btf_id = ret_btf_id;
> >               if (is_kfunc_ret_null(&meta)) {
> >                       regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
> >                       /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
> > @@ -14371,8 +14439,43 @@ static int fixup_call_args(struct bpf_verifier_env *env)
> >       return err;
> >  }
> >
> > +static int do_kfunc_fixups(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > +                        s32 imm, int insn_idx, int delta)
> > +{
> > +     struct bpf_insn insn_buf[16];
> > +     struct bpf_prog *new_prog;
> > +     int cnt;
> > +
> > +     /* No need to lookup btf, only vmlinux kfuncs are supported for special
> > +      * kfuncs handling. Hence when insn->off is zero, check if it is a
> > +      * special kfunc by hardcoding btf as btf_vmlinux.
> > +      */
> > +     if (!insn->off && is_kfunc_special(btf_vmlinux, insn->imm, bpf_kptr_alloc)) {
> > +             u64 local_type_size = env->insn_aux_data[insn_idx + delta].kptr_alloc_size;
> > +
> > +             insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, local_type_size);
> > +             insn_buf[1] = *insn;
> > +             cnt = 2;
> > +
> > +             new_prog = bpf_patch_insn_data(env, insn_idx + delta, insn_buf, cnt);
> > +             if (!new_prog)
> > +                     return -ENOMEM;
> > +
> > +             delta += cnt - 1;
> > +             insn = new_prog->insnsi + insn_idx + delta;
> > +             goto patch_call_imm;
> > +     }
> > +
> > +     insn->imm = imm;
> > +     return 0;
> > +patch_call_imm:
> > +     insn->imm = imm;
> > +     return cnt - 1;
> > +}
> > +
> >  static int fixup_kfunc_call(struct bpf_verifier_env *env,
> > -                         struct bpf_insn *insn)
> > +                         struct bpf_insn *insn,
> > +                         int insn_idx, int delta)
> >  {
> >       const struct bpf_kfunc_desc *desc;
> >
> > @@ -14391,9 +14494,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
> >               return -EFAULT;
> >       }
> >
> > -     insn->imm = desc->imm;
> > -
> > -     return 0;
> > +     return do_kfunc_fixups(env, insn, desc->imm, insn_idx, delta);
> >  }
> >
> >  /* Do various post-verification rewrites in a single program pass.
> > @@ -14534,9 +14635,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >               if (insn->src_reg == BPF_PSEUDO_CALL)
> >                       continue;
> >               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> > -                     ret = fixup_kfunc_call(env, insn);
> > -                     if (ret)
> > +                     ret = fixup_kfunc_call(env, insn, i, delta);
> > +                     if (ret < 0)
> >                               return ret;
> > +                     /* If ret > 0, fixup_kfunc_call did some instruction
> > +                      * rewrites. Increment delta, reload prog and insn,
> > +                      * env->prog is already set by it to the new_prog.
> > +                      */
> > +                     if (ret) {
> > +                             delta += ret;
> > +                             prog = env->prog;
> > +                             insn = prog->insnsi + i + delta;
> > +                     }
>
> See how Yonghong did it:
> https://lore.kernel.org/all/20220807175121.4179410-1-yhs@fb.com/
>
> It's cleaner to patch and adjust here instead of patch in one place
> and adjust in another.
>

Agreed, will fix it in v1.
