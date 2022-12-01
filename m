Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913663FA47
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLAWF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLAWF1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 17:05:27 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B39BC582
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 14:05:26 -0800 (PST)
Message-ID: <71f4d953-fbfd-902f-bc8d-3894b7562eeb@linux.dev>
Date:   Thu, 1 Dec 2022 14:05:21 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221129023713.2216451-1-yhs@fb.com>
 <d46efd51-e6f5-dbb5-ab38-238b6d2ea314@linux.dev>
 <1a534022-5629-8f98-c8ad-f1c335652af5@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1a534022-5629-8f98-c8ad-f1c335652af5@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/1/22 9:47 AM, Yonghong Song wrote:
> 
> 
> On 11/30/22 11:05 PM, Martin KaFai Lau wrote:
>> On 11/28/22 6:37 PM, Yonghong Song wrote:
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>> index c05aa6e1f6f5..6f192dd9025e 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const struct 
>>> bpf_prog *prog)
>>>       }
>>>   }
>>> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
>>> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
>>
>> [ ... ]
>>
>>> +static bool is_rcu_reg(const struct bpf_reg_state *reg)
>>> +{
>>> +    return reg->type & MEM_RCU;
>>> +}
>>> +
>>>   static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
>>>                      const struct bpf_reg_state *reg,
>>>                      int off, int size, bool strict)
>>> @@ -4775,12 +4780,10 @@ static int check_ptr_to_btf_access(struct 
>>> bpf_verifier_env *env,
>>>           /* Mark value register as MEM_RCU only if it is protected by
>>>            * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
>>>            * itself can already indicate trustedness inside the rcu
>>> -         * read lock region. Also mark it as PTR_TRUSTED.
>>> +         * read lock region.
>>>            */
>>>           if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
>>>               flag &= ~MEM_RCU;
>>
>> How about dereferencing a PTR_TO_BTF_ID | MEM_RCU, like:
>>
>>      /* parent: PTR_TO_BTF_ID | MEM_RCU */
>>      parent = current->real_parent;
>>      /* gparent: PTR_TO_BTF_ID */
>>      gparent = parent->real_parent;
>>
>> Should "gparent" have MEM_RCU also?
> 
> Currently, no. We have logic in the code like
> 
>          if (flag & MEM_RCU) {
>                  /* Mark value register as MEM_RCU only if it is protected by
>                   * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
>                   * itself can already indicate trustedness inside the rcu
>                   * read lock region.
>                   */
>                  if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
>                          flag &= ~MEM_RCU;
>          }
> 
> Since 'parent' is not trusted, so it will not be marked as MEM_RCU.
> It can be marked as MEM_RCU if we do (based on the current patch)

or adding a is_rcu_trusted_reg() to consider both is_trusted_reg and MEM_RCU 
before cleaning ~MEM_RCU here.  It seems the check_kfunc_args() below will need 
a similar is_rcu_trusted_reg() test also.

> 
>      parent = current->real_parent;
>      parent2 = bpf_task_acquire_rcu(parent);
>      if (!parent2) goto out;
>      gparent = parent2->real_parent;
> 
> Now gparent will be marked as MEM_RCU.
> 
>>
>> Also, should PTR_MAYBE_NULL be added to "parent"?
> 
> I think we might need to do this. Although from kernel code,
> task->real_parent, current->cgroups seem not NULL. But for sure
> there are cases where the rcu ptr could be NULL. This might
> be conservative for some cases, and if it is absolutely
> performance critical, we later could tag related __rcu member
> with btf_decl_tag to indicate its non-null status.
> 
>>
>>> -        else
>>> -            flag |= PTR_TRUSTED;
>>>       } else if (reg->type & MEM_RCU) {
>>>           /* ptr (reg) is marked as MEM_RCU, but the struct field is not tagged
>>>            * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
>>> @@ -5945,7 +5948,7 @@ static const struct bpf_reg_types btf_ptr_types = {
>>>       .types = {
>>>           PTR_TO_BTF_ID,
>>>           PTR_TO_BTF_ID | PTR_TRUSTED,
>>> -        PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
>>> +        PTR_TO_BTF_ID | MEM_RCU,
>>>       },
>>>   };
>>>   static const struct bpf_reg_types percpu_btf_ptr_types = {
>>> @@ -6124,7 +6127,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>>       case PTR_TO_BTF_ID:
>>>       case PTR_TO_BTF_ID | MEM_ALLOC:
>>>       case PTR_TO_BTF_ID | PTR_TRUSTED:
>>> -    case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
>>> +    case PTR_TO_BTF_ID | MEM_RCU:
>>>       case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>>>           /* When referenced PTR_TO_BTF_ID is passed to release function,
>>>            * it's fixed offset must be 0.    In the other cases, fixed offset
>>> @@ -8022,6 +8025,11 @@ static bool is_kfunc_destructive(struct 
>>> bpf_kfunc_call_arg_meta *meta)
>>>       return meta->kfunc_flags & KF_DESTRUCTIVE;
>>>   }
>>> +static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>>> +{
>>> +    return meta->kfunc_flags & KF_RCU;
>>> +}
>>> +
>>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int 
>>> arg)
>>>   {
>>>       return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>>> @@ -8706,13 +8714,19 @@ static int check_kfunc_args(struct bpf_verifier_env 
>>> *env, struct bpf_kfunc_call_
>>>           switch (kf_arg_type) {
>>>           case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>>>           case KF_ARG_PTR_TO_BTF_ID:
>>> -            if (!is_kfunc_trusted_args(meta))
>>> +            if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
>>>                   break;
>>> -            if (!is_trusted_reg(reg)) {
>>> -                verbose(env, "R%d must be referenced or trusted\n", regno);
>>> +            if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
>>> +                verbose(env, "R%d must be referenced, trusted or rcu\n", 
>>> regno);
>>>                   return -EINVAL;
>>>               }
>>> +
>>> +            if (is_kfunc_rcu(meta) != is_rcu_reg(reg)) {
>>
>> I think is_trusted_reg(reg) should also be acceptable to bpf_task_acquire_rcu().
> 
> Yes, good point. trusted is a super set of rcu.
> 
>>
>> nit. bpf_task_acquire_not_zero() may be a better kfunc name.
> 
> Will use this one.

