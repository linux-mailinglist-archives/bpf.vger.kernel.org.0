Return-Path: <bpf+bounces-8109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B0781668
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E181C20BDA
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72A655;
	Sat, 19 Aug 2023 01:25:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B7634
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 01:25:01 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0014A4205
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:24:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-5255da974c4so1794182a12.3
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692408297; x=1693013097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pgdY2VWTkeBxVSxNCsnP8jvaCaUsJnGRfWqr+2l7S6E=;
        b=ilYi5b8HhkraujJfOYHljE4Qdi3BN4a/SSAy4Cd7QtBjWQ9rHTU5yIDY8997dlCrdY
         mPhVdtI3ON7nOms7rqdb7Du3PX5/10nnzpl3nsEtAdKvZq0xT5NHXrYiEaHKzcHlPhfv
         FkKBaDhTeUsmiL44wA43re+Ax38fejwrXqw13oAAraKc0isHVZKY77iSOCQJmP6rdet3
         snEpqVMoanMQXwz5eAC69C1c+K9bi8cxb4bU1uQT3JR12GozXz1mqX2UaArm6X/APRtX
         jkO25bs8B+vJTOx/t4LS6fimsqEVux246e+O9S0lRJfZLlvFt1n+PM2eZhKeG+YuSeXq
         irPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692408297; x=1693013097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgdY2VWTkeBxVSxNCsnP8jvaCaUsJnGRfWqr+2l7S6E=;
        b=g5gO5wQpRfPWa+2CY22TWnqSnViGcgYmDBGM+IpXZmzwrCUgDIBF6SMzZWwSH5zl0u
         8cN2RA0Ojpr5tUg2O79TKBpSA6Ol0YQUVpiBEqMn9bmJS07a920CBeCdsueeo566MIvn
         H6T8z/w4SHEvUm1fTwN8NVpB7DSzHRCs4+6N6vMm/GfzcsZa7ZjA+1FDbKJaRLgukTz7
         j/c3OF0ut7uSemlMTTS0glpl6ns3Gaq+g0LZW0osN0DnsNkRCYAj5/L3z/4fo7bivvYa
         eCPIQHUGC4yVtPZEQKeLlAhtjHIWr+xyo4yG8UzRYFU7C7a6aM11H7e7aUcqbZ5ndZ8D
         nWsQ==
X-Gm-Message-State: AOJu0Yzn9W1iHAvbXi7Bsvzbq30/Vh6nceH28Es81PxT1puRmSS5Bs/J
	QGIQCaq+C2m2sqFCdK1sGCxJSxdO5li73khhcxoJBHfrHYimhA==
X-Google-Smtp-Source: AGHT+IE7FP3hOsCZyYfbVGE2WTf9w1/pS+v+abfOrtqhu/8Eqoo22LlETYOuZ5R6XjU3zadVgm5kD3N+0RsxXqYIBgo=
X-Received: by 2002:aa7:d502:0:b0:521:7ab6:b95d with SMTP id
 y2-20020aa7d502000000b005217ab6b95dmr655711edq.29.1692408297093; Fri, 18 Aug
 2023 18:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814172809.1361446-1-yonghong.song@linux.dev> <20230814172825.1363378-1-yonghong.song@linux.dev>
In-Reply-To: <20230814172825.1363378-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 19 Aug 2023 06:54:20 +0530
Message-ID: <CAP01T756RSWSveq_SqfhFWJguT+gpwYU7iRtMGCgSFNf-x+JLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/15] bpf: Add alloc/xchg/direct_access support
 for local percpu kptr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 14 Aug 2023 at 22:59, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> Add two new kfunc's, bpf_percpu_obj_new_impl() and
> bpf_percpu_obj_drop_impl(), to allocate a percpu obj.
> Two functions are very similar to bpf_obj_new_impl()
> and bpf_obj_drop_impl(). The major difference is related
> to percpu handling.
>
>     bpf_rcu_read_lock()
>     struct val_t __percpu *v = map_val->percpu_data;
>     ...
>     bpf_rcu_read_unlock()
>
> For a percpu data map_val like above 'v', the reg->type
> is set as
>         PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU
> if inside rcu critical section.
>
> MEM_RCU marking here is similar to NON_OWN_REF as 'v'
> is not a owning referenace. But NON_OWN_REF is

typo: reference

> trusted and typically inside the spinlock while
> MEM_RCU is under rcu read lock. RCU is preferred here
> since percpu data structures mean potential concurrent
> access into its contents.
>
> Also, bpf_percpu_obj_new_impl() is restricted to only accept
> scalar struct which means nested kptr's are not allowed
> but some other special field, e.g., bpf_list_head, bpf_spin_lock, etc.
> could be nested (nested 'struct'). Later patch will improve verifier to
> handle such nested special fields.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  3 +-
>  kernel/bpf/helpers.c  | 49 +++++++++++++++++++++++
>  kernel/bpf/syscall.c  | 21 +++++++---
>  kernel/bpf/verifier.c | 90 ++++++++++++++++++++++++++++++++++---------
>  4 files changed, 137 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e6348fd0a785..a2cb380c43c7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -197,7 +197,8 @@ struct btf_field_kptr {
>         struct btf *btf;
>         struct module *module;
>         /* dtor used if btf_is_kernel(btf), otherwise the type is
> -        * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
> +        * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl
> +        * or __bpf_percpu_drop_impl is used
>          */
>         btf_dtor_kfunc_t dtor;
>         u32 btf_id;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb91cae0612a..dd14cb7da4af 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1900,6 +1900,29 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>         return p;
>  }
>
> +__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +{
> +       struct btf_struct_meta *meta = meta__ign;
> +       const struct btf_record *rec;
> +       u64 size = local_type_id__k;
> +       void __percpu *pptr;
> +       void *p;
> +       int cpu;
> +
> +       p = bpf_mem_alloc(&bpf_global_percpu_ma, size);
> +       if (!p)
> +               return NULL;
> +       if (meta) {
> +               pptr = *((void __percpu **)p);
> +               rec = meta->record;
> +               for_each_possible_cpu(cpu) {
> +                       bpf_obj_init(rec, per_cpu_ptr(pptr, cpu));
> +               }
> +       }
> +
> +       return p;
> +}
> +
>  /* Must be called under migrate_disable(), as required by bpf_mem_free */
>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>  {
> @@ -1924,6 +1947,30 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>         __bpf_obj_drop_impl(p, meta ? meta->record : NULL);
>  }
>
> +/* Must be called under migrate_disable(), as required by bpf_mem_free_rcu */
> +void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record *rec)
> +{
> +       void __percpu *pptr;
> +       int cpu;
> +
> +       if (rec) {
> +               pptr = *((void __percpu **)p);
> +               for_each_possible_cpu(cpu) {
> +                       bpf_obj_free_fields(rec, per_cpu_ptr(pptr, cpu));

Should this loop be done after we have waited for the RCU grace period?
Otherwise any other CPU can reinitialize a field after this is done,
move objects into lists/rbtree, and leak memory.
Please correct me if I'm mistaken.

> +               }
> +       }
> +
> +       bpf_mem_free_rcu(&bpf_global_percpu_ma, p);
> +}
> +
> +__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
> +{
> +       struct btf_struct_meta *meta = meta__ign;
> +       void *p = p__alloc;
> +
> +       __bpf_percpu_obj_drop_impl(p, meta ? meta->record : NULL);
> +}
> +
>  __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>  {
>         struct btf_struct_meta *meta = meta__ign;
> @@ -2436,7 +2483,9 @@ BTF_SET8_START(generic_btf_ids)
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1c30b6ee84d4..9ceb6fd9a0e2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -627,6 +627,7 @@ void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
>  }
>
>  extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
> +extern void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record *rec);
>
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
> @@ -660,13 +661,21 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>                         if (!btf_is_kernel(field->kptr.btf)) {
>                                 pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
>                                                                            field->kptr.btf_id);
> -                               if (field->type != BPF_KPTR_PERCPU_REF)
> +
> +                               if (field->type == BPF_KPTR_PERCPU_REF) {
> +                                       migrate_disable();
> +                                       __bpf_percpu_obj_drop_impl(xchgd_field, pointee_struct_meta ?
> +                                                                               pointee_struct_meta->record :
> +                                                                               NULL);
> +                                       migrate_enable();
> +                               } else {
>                                         WARN_ON_ONCE(!pointee_struct_meta);
> -                               migrate_disable();
> -                               __bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
> -                                                                pointee_struct_meta->record :
> -                                                                NULL);
> -                               migrate_enable();
> +                                       migrate_disable();
> +                                       __bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
> +                                                                        pointee_struct_meta->record :
> +                                                                        NULL);
> +                                       migrate_enable();
> +                               }
>                         } else {
>                                 field->kptr.dtor(xchgd_field);
>                         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ccca1f6c998..a985fbf18a11 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -304,7 +304,7 @@ struct bpf_kfunc_call_arg_meta {
>         /* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
>          * generally to pass info about user-defined local kptr types to later
>          * verification logic
> -        *   bpf_obj_drop
> +        *   bpf_obj_drop/bpf_percpu_obj_drop
>          *     Record the local kptr type to be drop'd
>          *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
>          *     Record the local kptr type to be refcount_incr'd and use
> @@ -4997,13 +4997,20 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>         if (kptr_field->type == BPF_KPTR_UNREF)
>                 perm_flags |= PTR_UNTRUSTED;
>
> +       if (kptr_field->type == BPF_KPTR_PERCPU_REF)
> +               perm_flags |= MEM_PERCPU | MEM_ALLOC;
> +

I think just this would permit PTR_TO_BTF_ID | MEM_ALLOC for percpu kptr?
It would probably be good to include negative selftests for kptr_xchg
type matching with percpu_kptr to prevent things like these.

Alexei already said map_kptr_match_type is not being invoked for
MEM_ALLOC kptr_xchg, so that is also an existing bug.

>         if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
>                 goto bad_type;
>
> [...]
>         /* We need to verify reg->type and reg->btf, before accessing reg->btf */
>         reg_name = btf_type_name(reg->btf, reg->btf_id);
>
> @@ -5084,7 +5091,17 @@ static bool rcu_safe_kptr(const struct btf_field *field)
>  {
>         const struct btf_field_kptr *kptr = &field->kptr;
>
> -       return field->type == BPF_KPTR_REF && rcu_protected_object(kptr->btf, kptr->btf_id);
> +       return field->type == BPF_KPTR_PERCPU_REF ||
> +              (field->type == BPF_KPTR_REF && rcu_protected_object(kptr->btf, kptr->btf_id));
> +}
> +
> +static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr_field)
> +{
> +       if (!rcu_safe_kptr(kptr_field) || !in_rcu_cs(env))
> +               return PTR_MAYBE_NULL | PTR_UNTRUSTED;
> +       if (kptr_field->type != BPF_KPTR_PERCPU_REF)
> +               return PTR_MAYBE_NULL | MEM_RCU;
> +       return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;

The inverted conditions are a bit hard to follow. Maybe better to
explicitly check for both RCU cases, and default to untrusted
otherwise?

>  }
>
> [...]
>

