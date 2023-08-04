Return-Path: <bpf+bounces-6951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F076FA9E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB69280A0E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6722749C;
	Fri,  4 Aug 2023 07:04:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2F6ADF
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 07:04:33 +0000 (UTC)
Received: from out-64.mta0.migadu.com (out-64.mta0.migadu.com [IPv6:2001:41d0:1004:224b::40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9722E1724
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 00:04:31 -0700 (PDT)
Message-ID: <cd3bb76b-0097-958c-4a01-565081f37833@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691132129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7il9Qei2ohMQiBJAKQcEkPl4CzToPctwdNkaO14OJKc=;
	b=Ac3Y6Jjw64hQuTmGqvMCvn+Awxmf/vtRCDF1MWiI/greEybcvYO+37QxkTG82zLaqKGYGu
	cXtAdjzwtzg/lyzz2Tomj9MPJvUXZmTWVZVh1E8bcW/c2vXKWi9xvgUM/cnsRKE3gxfFHP
	fYq6VUC4nKfyBk53NsrxsKkEqIwOh7Y=
Date: Fri, 4 Aug 2023 02:55:25 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 5/7] bpf: Consider non-owning refs to
 refcounted nodes RCU protected
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-6-davemarchevsky@fb.com>
 <20230802225054.ee6oadjgm6g2bdsl@MacBook-Pro-8.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230802225054.ee6oadjgm6g2bdsl@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 6:50 PM, Alexei Starovoitov wrote:
> On Tue, Aug 01, 2023 at 01:36:28PM -0700, Dave Marchevsky wrote:
>> The previous patch in the series ensures that the underlying memory of
>> nodes with bpf_refcount - which can have multiple owners - is not reused
>> until RCU Tasks Trace grace period has elapsed. This prevents
> 
> Here and in the cover letter... above should probably be "RCU grace period"
> and not "RCU tasks trace grace period".
> bpf progs will reuse objects after normal RCU.
> We're waiting for RCU tasks trace GP to free into slab.
> 

Will fix.

>> use-after-free with non-owning references that may point to
>> recently-freed memory. While RCU read lock is held, it's safe to
>> dereference such a non-owning ref, as by definition RCU GP couldn't have
>> elapsed and therefore underlying memory couldn't have been reused.
>>
>> From the perspective of verifier "trustedness" non-owning refs to
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
>>  include/linux/bpf.h   |  3 ++-
>>  kernel/bpf/verifier.c | 17 +++++++++++++++--
>>  2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ceaa8c23287f..37fba01b061a 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -653,7 +653,8 @@ enum bpf_type_flag {
>>  	MEM_RCU			= BIT(13 + BPF_BASE_TYPE_BITS),
>>  
>>  	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
>> -	 * Currently only valid for linked-list and rbtree nodes.
>> +	 * Currently only valid for linked-list and rbtree nodes. If the nodes
>> +	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
>>  	 */
>>  	NON_OWN_REF		= BIT(14 + BPF_BASE_TYPE_BITS),
>>  
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9014b469dd9d..4bda365000d3 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -469,7 +469,8 @@ static bool type_is_ptr_alloc_obj(u32 type)
>>  
>>  static bool type_is_non_owning_ref(u32 type)
>>  {
>> -	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
>> +	return type_is_ptr_alloc_obj(type) &&
>> +		type_flag(type) & NON_OWN_REF;
>>  }
>>  
>>  static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>> @@ -8012,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>  	case PTR_TO_BTF_ID | PTR_TRUSTED:
>>  	case PTR_TO_BTF_ID | MEM_RCU:
>>  	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
>> +	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
>>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>>  		 * its fixed offset must be 0. In the other cases, fixed offset
>>  		 * can be non-zero. This was already checked above. So pass
>> @@ -10478,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
>>  static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>>  {
>>  	struct bpf_verifier_state *state = env->cur_state;
>> +	struct btf_record *rec = reg_btf_record(reg);
>>  
>>  	if (!state->active_lock.ptr) {
>>  		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
>> @@ -10490,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
>>  	}
>>  
>>  	reg->type |= NON_OWN_REF;
>> +	if (rec->refcount_off >= 0)
>> +		reg->type |= MEM_RCU;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -11327,10 +11333,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  		struct bpf_func_state *state;
>>  		struct bpf_reg_state *reg;
>>  
>> +		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
>> +			verbose(env, "can't rcu read {lock,unlock} in rbtree cb\n");
>> +			return -EACCES;
>> +		}
> 
> I guess it's ok to prevent cb from calling bpf_rcu_read_lock(), since it's unnecessary,
> but pls make the message more verbose. Like:
>  verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> 
> so that users know why the verifier complains.
> Technically it's ok to do so. Unnecessary is not a safety issue.
> 

Well, for rcu_read_unlock it would be a safety issue, no?
Feels easier to reason about if we can just say "RCU lock is
held for the duration of the callback".

>> +
>>  		if (rcu_lock) {
>>  			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>>  			return -EINVAL;
>>  		} else if (rcu_unlock) {
>> +			invalidate_non_owning_refs(env);
> 
> I agree with Yonghong. It probably doesn't belong here.
> rcu lock/unlock and spin_lock/unlock are separate critical sections.
> Since ref_set_non_owning() adds extra MEM_RCU flag nothing extra needs to be done here.
> Below code will make the pointers untrusted.
> 

Will change. The desire here was to not loosen constraints
on non-owning ref lifetime in this series. As I mention in
my thoughts on Patch 3 in the cover letter, I do think we can
loosen that in the future, but would like to avoid doing so in this
fixes series. Regardless, because bpf_spin_unlock will
happen before this executes, this line can be removed.

>>  			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>>  				if (reg->type & MEM_RCU) {
>>  					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>> @@ -16679,7 +16691,8 @@ static int do_check(struct bpf_verifier_env *env)
>>  					return -EINVAL;
>>  				}
>>  
>> -				if (env->cur_state->active_rcu_lock) {
>> +				if (env->cur_state->active_rcu_lock &&
>> +				    !in_rbtree_lock_required_cb(env)) {
> 
> I'm not following here.
> Didn't you want to prevent bpf_rcu_read_lock/unlock inside cb? Why this change?
> >>  					verbose(env, "bpf_rcu_read_unlock is missing\n");
>>  					return -EINVAL;
>>  				}
>> -- 
>> 2.34.1
>>

