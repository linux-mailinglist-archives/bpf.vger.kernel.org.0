Return-Path: <bpf+bounces-8131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE3781C52
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AD01C208A8
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC692EC5;
	Sun, 20 Aug 2023 04:07:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26EA5A
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 04:07:55 +0000 (UTC)
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475413AB5
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 21:04:58 -0700 (PDT)
Message-ID: <5b54fb06-3ce5-4219-a591-1a2d8ee77656@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692504294; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcP4cyjX3nWXKOBVhR0tXDN3xFPIvFr5cYYzdEgXx9A=;
	b=Gi0q0zyKvNL/ndZWe4N27+I3s8sRiAiNtIo70VDXc3whLKRjlUr/XFx7nuNSVBQHmr35wi
	a5/jnBg3c4H+NpCVb+zOyVCnGQSwd1XmXYWSlJ8pzFc5HULcxqEhND4rQ++Si3e6Kz3oaL
	92PnR+o0Cc9nI2MC9viGENJYSNvdAU8=
Date: Sat, 19 Aug 2023 21:04:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 03/15] bpf: Add alloc/xchg/direct_access support
 for local percpu kptr
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172825.1363378-1-yonghong.song@linux.dev>
 <CAP01T756RSWSveq_SqfhFWJguT+gpwYU7iRtMGCgSFNf-x+JLQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T756RSWSveq_SqfhFWJguT+gpwYU7iRtMGCgSFNf-x+JLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 6:24 PM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 14 Aug 2023 at 22:59, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Add two new kfunc's, bpf_percpu_obj_new_impl() and
>> bpf_percpu_obj_drop_impl(), to allocate a percpu obj.
>> Two functions are very similar to bpf_obj_new_impl()
>> and bpf_obj_drop_impl(). The major difference is related
>> to percpu handling.
>>
>>      bpf_rcu_read_lock()
>>      struct val_t __percpu *v = map_val->percpu_data;
>>      ...
>>      bpf_rcu_read_unlock()
>>
>> For a percpu data map_val like above 'v', the reg->type
>> is set as
>>          PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU
>> if inside rcu critical section.
>>
>> MEM_RCU marking here is similar to NON_OWN_REF as 'v'
>> is not a owning referenace. But NON_OWN_REF is
> 
> typo: reference

Ack.

> 
>> trusted and typically inside the spinlock while
>> MEM_RCU is under rcu read lock. RCU is preferred here
>> since percpu data structures mean potential concurrent
>> access into its contents.
>>
>> Also, bpf_percpu_obj_new_impl() is restricted to only accept
>> scalar struct which means nested kptr's are not allowed
>> but some other special field, e.g., bpf_list_head, bpf_spin_lock, etc.
>> could be nested (nested 'struct'). Later patch will improve verifier to
>> handle such nested special fields.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h   |  3 +-
>>   kernel/bpf/helpers.c  | 49 +++++++++++++++++++++++
>>   kernel/bpf/syscall.c  | 21 +++++++---
>>   kernel/bpf/verifier.c | 90 ++++++++++++++++++++++++++++++++++---------
>>   4 files changed, 137 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index e6348fd0a785..a2cb380c43c7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -197,7 +197,8 @@ struct btf_field_kptr {
>>          struct btf *btf;
>>          struct module *module;
>>          /* dtor used if btf_is_kernel(btf), otherwise the type is
>> -        * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
>> +        * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl
>> +        * or __bpf_percpu_drop_impl is used
>>           */
>>          btf_dtor_kfunc_t dtor;
>>          u32 btf_id;
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index eb91cae0612a..dd14cb7da4af 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1900,6 +1900,29 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>          return p;
>>   }
>>
>> +__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>> +{
>> +       struct btf_struct_meta *meta = meta__ign;
>> +       const struct btf_record *rec;
>> +       u64 size = local_type_id__k;
>> +       void __percpu *pptr;
>> +       void *p;
>> +       int cpu;
>> +
>> +       p = bpf_mem_alloc(&bpf_global_percpu_ma, size);
>> +       if (!p)
>> +               return NULL;
>> +       if (meta) {
>> +               pptr = *((void __percpu **)p);
>> +               rec = meta->record;
>> +               for_each_possible_cpu(cpu) {
>> +                       bpf_obj_init(rec, per_cpu_ptr(pptr, cpu));
>> +               }
>> +       }
>> +
>> +       return p;
>> +}
>> +
>>   /* Must be called under migrate_disable(), as required by bpf_mem_free */
>>   void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>>   {
>> @@ -1924,6 +1947,30 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>>          __bpf_obj_drop_impl(p, meta ? meta->record : NULL);
>>   }
>>
>> +/* Must be called under migrate_disable(), as required by bpf_mem_free_rcu */
>> +void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record *rec)
>> +{
>> +       void __percpu *pptr;
>> +       int cpu;
>> +
>> +       if (rec) {
>> +               pptr = *((void __percpu **)p);
>> +               for_each_possible_cpu(cpu) {
>> +                       bpf_obj_free_fields(rec, per_cpu_ptr(pptr, cpu));
> 
> Should this loop be done after we have waited for the RCU grace period?
> Otherwise any other CPU can reinitialize a field after this is done,
> move objects into lists/rbtree, and leak memory.
> Please correct me if I'm mistaken.

Thanks for spotting this. I think you are correct. The above scenario is
indeed possible. one cpu takes a direct reference of __percpu_kptr and
do a bunch of stuff, and the other cpu is doing a bpf_kptr_xchg to
get the __percpu_kptr and drops it. We should really drop the 
__percpu_kptr itself and the fields in its record after a rcu
grace period so the exist direct reference operation won't be
affected.

Will fix it in the v2.

> 
>> +               }
>> +       }
>> +
>> +       bpf_mem_free_rcu(&bpf_global_percpu_ma, p);
>> +}
>> +
>> +__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>> +{
>> +       struct btf_struct_meta *meta = meta__ign;
>> +       void *p = p__alloc;
>> +
>> +       __bpf_percpu_obj_drop_impl(p, meta ? meta->record : NULL);
>> +}
>> +
>>   __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>>   {
>>          struct btf_struct_meta *meta = meta__ign;
>> @@ -2436,7 +2483,9 @@ BTF_SET8_START(generic_btf_ids)
>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>   #endif
>>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
>> +BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
>>   BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>>   BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 1c30b6ee84d4..9ceb6fd9a0e2 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -627,6 +627,7 @@ void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
>>   }
>>
>>   extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
>> +extern void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record *rec);
>>
>>   void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>   {
>> @@ -660,13 +661,21 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>                          if (!btf_is_kernel(field->kptr.btf)) {
>>                                  pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
>>                                                                             field->kptr.btf_id);
>> -                               if (field->type != BPF_KPTR_PERCPU_REF)
>> +
>> +                               if (field->type == BPF_KPTR_PERCPU_REF) {
>> +                                       migrate_disable();
>> +                                       __bpf_percpu_obj_drop_impl(xchgd_field, pointee_struct_meta ?
>> +                                                                               pointee_struct_meta->record :
>> +                                                                               NULL);
>> +                                       migrate_enable();
>> +                               } else {
>>                                          WARN_ON_ONCE(!pointee_struct_meta);
>> -                               migrate_disable();
>> -                               __bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
>> -                                                                pointee_struct_meta->record :
>> -                                                                NULL);
>> -                               migrate_enable();
>> +                                       migrate_disable();
>> +                                       __bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
>> +                                                                        pointee_struct_meta->record :
>> +                                                                        NULL);
>> +                                       migrate_enable();
>> +                               }
>>                          } else {
>>                                  field->kptr.dtor(xchgd_field);
>>                          }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4ccca1f6c998..a985fbf18a11 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -304,7 +304,7 @@ struct bpf_kfunc_call_arg_meta {
>>          /* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
>>           * generally to pass info about user-defined local kptr types to later
>>           * verification logic
>> -        *   bpf_obj_drop
>> +        *   bpf_obj_drop/bpf_percpu_obj_drop
>>           *     Record the local kptr type to be drop'd
>>           *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
>>           *     Record the local kptr type to be refcount_incr'd and use
>> @@ -4997,13 +4997,20 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>>          if (kptr_field->type == BPF_KPTR_UNREF)
>>                  perm_flags |= PTR_UNTRUSTED;
>>
>> +       if (kptr_field->type == BPF_KPTR_PERCPU_REF)
>> +               perm_flags |= MEM_PERCPU | MEM_ALLOC;
>> +
> 
> I think just this would permit PTR_TO_BTF_ID | MEM_ALLOC for percpu kptr?
> It would probably be good to include negative selftests for kptr_xchg
> type matching with percpu_kptr to prevent things like these.
> 
> Alexei already said map_kptr_match_type is not being invoked for
> MEM_ALLOC kptr_xchg, so that is also an existing bug.

I will fix that bug first and this part of change probably not
needed any more.

> 
>>          if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
>>                  goto bad_type;
>>
>> [...]
>>          /* We need to verify reg->type and reg->btf, before accessing reg->btf */
>>          reg_name = btf_type_name(reg->btf, reg->btf_id);
>>
>> @@ -5084,7 +5091,17 @@ static bool rcu_safe_kptr(const struct btf_field *field)
>>   {
>>          const struct btf_field_kptr *kptr = &field->kptr;
>>
>> -       return field->type == BPF_KPTR_REF && rcu_protected_object(kptr->btf, kptr->btf_id);
>> +       return field->type == BPF_KPTR_PERCPU_REF ||
>> +              (field->type == BPF_KPTR_REF && rcu_protected_object(kptr->btf, kptr->btf_id));
>> +}
>> +
>> +static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr_field)
>> +{
>> +       if (!rcu_safe_kptr(kptr_field) || !in_rcu_cs(env))
>> +               return PTR_MAYBE_NULL | PTR_UNTRUSTED;
>> +       if (kptr_field->type != BPF_KPTR_PERCPU_REF)
>> +               return PTR_MAYBE_NULL | MEM_RCU;
>> +       return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;
> 
> The inverted conditions are a bit hard to follow. Maybe better to
> explicitly check for both RCU cases, and default to untrusted
> otherwise?

Okay. Will do.

> 
>>   }
>>
>> [...]
>>

