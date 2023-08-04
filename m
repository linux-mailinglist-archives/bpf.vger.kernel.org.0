Return-Path: <bpf+bounces-6949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7076FA64
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB241C2176B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76256D19;
	Fri,  4 Aug 2023 06:48:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD641FC8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:48:08 +0000 (UTC)
Received: from out-121.mta1.migadu.com (out-121.mta1.migadu.com [95.215.58.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5E46A8
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 23:47:52 -0700 (PDT)
Message-ID: <e040f58a-4505-9333-2250-57df8ab7290e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691131670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAntEyEuIvrmHUubXQvMHmLAPvvg3wl3uHiSMvKczp8=;
	b=Ez/WzA5xQIfBk6dxPQ+ORrKIRTrihvWIM1z4BlOO5LT3Yuboce0pVUzuuCZOXQa46ZtKrU
	7mz1ykVSdZOE/Praw5rCYAABHTLfbPK8npPaN+kzOyaSvTlzS93lUSJXqN7fY6vB0Lh4B9
	5VWL1uldVrXt+pZb+FJw6yVNQJAgQvU=
Date: Fri, 4 Aug 2023 02:47:47 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 5/7] bpf: Consider non-owning refs to
 refcounted nodes RCU protected
Content-Language: en-US
To: yonghong.song@linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-6-davemarchevsky@fb.com>
 <eda219c8-88ef-0907-377c-eb965c3f1008@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <eda219c8-88ef-0907-377c-eb965c3f1008@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 1:59 AM, Yonghong Song wrote:
> 
> 
> On 8/1/23 1:36 PM, Dave Marchevsky wrote:
>> The previous patch in the series ensures that the underlying memory of
>> nodes with bpf_refcount - which can have multiple owners - is not reused
>> until RCU Tasks Trace grace period has elapsed. This prevents
>> use-after-free with non-owning references that may point to
>> recently-freed memory. While RCU read lock is held, it's safe to
>> dereference such a non-owning ref, as by definition RCU GP couldn't have
>> elapsed and therefore underlying memory couldn't have been reused.
>>
>>  From the perspective of verifier "trustedness" non-owning refs to
>> refcounted nodes are now trusted only in RCU CS and therefore should no
>> longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
>> MEM_RCU in order to reflect this new state.
>>
>> Similarly to bpf_spin_unlock being a non-owning ref invalidation point,
>> where non-owning ref reg states are clobbered so that they cannot be
>> used outside of the critical section, currently all MEM_RCU regs are
>> marked untrusted after bpf_rcu_read_unlock. This patch makes
>> bpf_rcu_read_unlock a non-owning ref invalidation point as well,
>> clobbering the non-owning refs instead of marking untrusted. In the
>> future we may want to allow untrusted non-owning refs in which case we
>> can remove this custom logic without breaking BPF programs as it's more
>> restrictive than the default. That's a big change in semantics, though,
>> and this series is focused on fixing the use-after-free in most
>> straightforward way.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>   include/linux/bpf.h   |  3 ++-
>>   kernel/bpf/verifier.c | 17 +++++++++++++++--
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ceaa8c23287f..37fba01b061a 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -653,7 +653,8 @@ enum bpf_type_flag {
>>       MEM_RCU            = BIT(13 + BPF_BASE_TYPE_BITS),
>>         /* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
>> -     * Currently only valid for linked-list and rbtree nodes.
>> +     * Currently only valid for linked-list and rbtree nodes. If the nodes
>> +     * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
> 
> What does 'must' here mean?
> 

Meaning that if there's any NON_OWN_REF-flagged
PTR_TO_BTF_ID which points to a struct with a bpf_refcount field,
it should also be flagged with MEM_RCU. If it isn't, it's a
verifier error. 

>>        */
>>       NON_OWN_REF        = BIT(14 + BPF_BASE_TYPE_BITS),
>>   diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9014b469dd9d..4bda365000d3 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -469,7 +469,8 @@ static bool type_is_ptr_alloc_obj(u32 type)
>>     static bool type_is_non_owning_ref(u32 type)
>>   {
>> -    return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
>> +    return type_is_ptr_alloc_obj(type) &&
>> +        type_flag(type) & NON_OWN_REF;
> 
> There is no code change here.
> 

Yep, will undo in v2.

>>   }
>>     static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>> @@ -8012,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>       case PTR_TO_BTF_ID | PTR_TRUSTED:
>>       case PTR_TO_BTF_ID | MEM_RCU:
>>       case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
>> +    case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
>>           /* When referenced PTR_TO_BTF_ID is passed to release function,
>>            * its fixed offset must be 0. In the other cases, fixed offset
>>            * can be non-zero. This was already checked above. So pass
>> @@ -10478,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
>>   static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>>   {
>>       struct bpf_verifier_state *state = env->cur_state;
>> +    struct btf_record *rec = reg_btf_record(reg);
>>         if (!state->active_lock.ptr) {
>>           verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
>> @@ -10490,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
>>       }
>>         reg->type |= NON_OWN_REF;
>> +    if (rec->refcount_off >= 0)
>> +        reg->type |= MEM_RCU;
> 
> Should we check whether the state is in rcu cs before marking MEM_RCU?
> 

I think this is implicitly being enforced.
Rbtree/list kfuncs must be called under bpf_spin_lock,
and this series requires bpf_spin_{lock,unlock} helpers
to called in RCU CS if the BPF prog is sleepable.

>> +
>>       return 0;
>>   }
>>   @@ -11327,10 +11333,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>           struct bpf_func_state *state;
>>           struct bpf_reg_state *reg;
>>   +        if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
>> +            verbose(env, "can't rcu read {lock,unlock} in rbtree cb\n");
>> +            return -EACCES;
>> +        }
>> +
>>           if (rcu_lock) {
>>               verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>>               return -EINVAL;
>>           } else if (rcu_unlock) {
>> +            invalidate_non_owning_refs(env);
> 
> If we have both spin lock and rcu like
> 
>      bpf_rcu_read_lock()
>      ...
>      bpf_spin_lock()
>      ...
>      bpf_spin_unlock()  <=== invalidate all non_owning_refs
>      ...                <=== MEM_RCU type is gone
>      bpf_rcu_read_unlock()
> 
> Maybe we could fine tune here to preserve MEM_RCU after bpf_spin_unlock()?
> 

IIUC, you're saying that we should no longer
have non-owning refs get clobbered after bpf_spin_unlock,
and instead just have rcu_read_unlock do its default
"MEM_RCU refs become PTR_UNTRUSTED" logic.

In the cover letter I mention that this is probably
the direction we want to go in in the long term, on
the comments on patch 3:

  This might
  allow custom non-owning ref lifetime + invalidation logic to be
  entirely subsumed by MEM_RCU handling.

But I'm hesitant to do that in this fixes series
as I'd like to minimize changes that could introduce
additional bugs. This series' current changes keep the
clobbering rules effectively unchanged - can always
loosen them in the future. Also, I think we should
make this change for _all_ non-owning refs, (w/ and w/o
bpf_refcount field). Otherwise the verifier lifetime
of non-owning refs would change if BPF program writer
adds bpf_refcount field to their struct, or removes it.
 

>>               bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>>                   if (reg->type & MEM_RCU) {
>>                       reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>> @@ -16679,7 +16691,8 @@ static int do_check(struct bpf_verifier_env *env)
>>                       return -EINVAL;
>>                   }
>>   -                if (env->cur_state->active_rcu_lock) {
>> +                if (env->cur_state->active_rcu_lock &&
>> +                    !in_rbtree_lock_required_cb(env)) {
>>                       verbose(env, "bpf_rcu_read_unlock is missing\n");
>>                       return -EINVAL;
>>                   }

