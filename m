Return-Path: <bpf+bounces-6948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6476FA11
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA3C1C2173F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA25257;
	Fri,  4 Aug 2023 06:27:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3621FC2
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:27:19 +0000 (UTC)
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 23:27:16 PDT
Received: from out-103.mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D045319B0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 23:27:16 -0700 (PDT)
Message-ID: <b0bdcf5f-deee-e6fb-6d2c-808064a112e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691129842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=facB79gP8zMoDCwIzO3lx5Qzuo8oermdSQ/FV17YeAY=;
	b=ICxwu2IZLonHMQYKe74UuvvenPIaqvaRqay6n/DyMdXkJb3z1L32xOlMBaXJP0O4R4dGBB
	ZDOKcJ5ZEPDpvtAllt3NzXkJ+8824P5dzw2+4z2MD/LDOrE0TH9QGl+74NBB4m191QBGyg
	cAHLZWIT320NbJGBEF6w+GGzFKh1Cio=
Date: Fri, 4 Aug 2023 02:17:17 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/7] bpf: Ensure kptr_struct_meta is non-NULL
 for collection insert and refcount_acquire
Content-Language: en-US
To: yonghong.song@linux.dev, Dave Marchevsky <davemarchevsky@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-2-davemarchevsky@fb.com>
 <9643d04f-8102-b5b3-1edf-34b4e08485df@linux.dev>
 <a139645d-7949-30c7-5a6d-00f288babd81@gmail.com>
 <269b5c18-69ac-a9c4-3596-84ddc82b8877@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <269b5c18-69ac-a9c4-3596-84ddc82b8877@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 5:41 PM, Yonghong Song wrote:
> 
> 
> On 8/2/23 12:23 PM, Dave Marchevsky wrote:
>>
>>
>> On 8/1/23 11:57 PM, Yonghong Song wrote:
>>>
>>>
>>> On 8/1/23 1:36 PM, Dave Marchevsky wrote:
>>>> It's straightforward to prove that kptr_struct_meta must be non-NULL for
>>>> any valid call to these kfuncs:
>>>>
>>>>     * btf_parse_struct_metas in btf.c creates a btf_struct_meta for any
>>>>       struct in user BTF with a special field (e.g. bpf_refcount,
>>>>       {rb,list}_node). These are stored in that BTF's struct_meta_tab.
>>>>
>>>>     * __process_kf_arg_ptr_to_graph_node in verifier.c ensures that nodes
>>>>       have {rb,list}_node field and that it's at the correct offset.
>>>>       Similarly, check_kfunc_args ensures bpf_refcount field existence for
>>>>       node param to bpf_refcount_acquire.
>>>>
>>>>     * So a btf_struct_meta must have been created for the struct type of
>>>>       node param to these kfuncs
>>>>
>>>>     * That BTF and its struct_meta_tab are guaranteed to still be around.
>>>>       Any arbitrary {rb,list} node the BPF program interacts with either:
>>>>       came from bpf_obj_new or a collection removal kfunc in the same
>>>>       program, in which case the BTF is associated with the program and
>>>>       still around; or came from bpf_kptr_xchg, in which case the BTF was
>>>>       associated with the map and is still around
>>>>
>>>> Instead of silently continuing with NULL struct_meta, which caused
>>>> confusing bugs such as those addressed by commit 2140a6e3422d ("bpf: Set
>>>> kptr_struct_meta for node param to list and rbtree insert funcs"), let's
>>>> error out. Then, at runtime, we can confidently say that the
>>>> implementations of these kfuncs were given a non-NULL kptr_struct_meta,
>>>> meaning that special-field-specific functionality like
>>>> bpf_obj_free_fields and the bpf_obj_drop change introduced later in this
>>>> series are guaranteed to execute.
>>>
>>> The subject says '... for collection insert and refcount_acquire'.
>>> Why picks these? We could check for all kptr_struct_meta use cases?
>>>
>>
>> fixup_kfunc_call sets kptr_struct_meta arg for the following kfuncs:
>>
>>    - bpf_obj_new_impl
>>    - bpf_obj_drop_impl
>>    - collection insert kfuncs
>>      - bpf_rbtree_add_impl
>>      - bpf_list_push_{front,back}_impl
>>    - bpf_refcount_acquire_impl
>>
>> A ﻿btf_struct_meta is only created for a struct if it has a non-null btf_record,
>> which in turn only happens if the struct has any special fields (spin_lock,
>> refcount, {rb,list}_node, etc.). Since it's valid to call bpf_obj_new on a
>> struct type without any special fields, the kptr_struct_meta arg can be
>> NULL. The result of such bpf_obj_new allocation must be bpf_obj_drop-able, so
>> the same holds for that kfunc.
>>
>> By definition rbtree and list nodes must be some struct type w/
>> struct bpf_{rb,list}_node field, and similar logic for refcounted, so if there's
>> no kptr_struct_meta for their node arg, there was some verifier-internal issue.
>>
>>
>>>>
>>>> This patch doesn't change functionality, just makes it easier to reason
>>>> about existing functionality.
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> ---
>>>>    kernel/bpf/verifier.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index e7b1af016841..ec37e84a11c6 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -18271,6 +18271,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>            struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>>>>            struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>>>>    +        if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
>>>
>>> Why check for KF_bpf_refcount_acquire_impl? We can cover all cases in this 'if' branch, right?
>>>
>>
>> The body of this 'else if' also handles kptr_struct_meta setup for bpf_obj_drop,
>> for which NULL kptr_struct_meta is valid.
>>
>>>> +            !kptr_struct_meta) {
>>>> +            verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
>>>> +                insn_idx);
>>>> +            return -EFAULT;
>>>> +        }
>>>> +
>>>>            insn_buf[0] = addr[0];
>>>>            insn_buf[1] = addr[1];
>>>>            insn_buf[2] = *insn;
>>>> @@ -18278,6 +18285,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>        } else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>>>>               desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>>>>               desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>>>> +        struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>>>>            int struct_meta_reg = BPF_REG_3;
>>>>            int node_offset_reg = BPF_REG_4;
>>>>    @@ -18287,6 +18295,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>                node_offset_reg = BPF_REG_5;
>>>>            }
>>>>    +        if (!kptr_struct_meta) {
>>>> +            verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
>>>> +                insn_idx);
>>>> +            return -EFAULT;
>>>> +        }
>>>> +
>>>>            __fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
>>>>                            node_offset_reg, insn, insn_buf, cnt);
>>>>        } else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>>>
>>> In my opinion, such selective defensive programming is not necessary. By searching kptr_struct_meta in the code, it is reasonably easy to find
>>> whether we have any mismatch or not. Also self test coverage should
>>> cover these cases (probably already) right?
>>>
>>> If the defensive programming here is still desirable to warn at verification time, I think we should just check all of uses for kptr_struct_meta.
>>
>> Something like this patch probably should've been included with the series
>> containing 2140a6e3422d ("bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs"),
>> since that commit found that kptr_struct_meta wasn't being set for collection
>> insert kfuncs and fixed the issue. It was annoyingly hard to root-cause
>> because, among other things, many of these kfunc impls check that
>> the btf_struct_meta is non-NULL before using it, with some fallback logic.
>> I don't like those unnecessary NULL checks either, and considered removing
>> them in this patch, but decided to leave them in since we already had
>> a case where struct_meta wasn't being set.
>>
>> On second thought, maybe it's better to take the unnecessary runtime checks
>> out and leave these verification-time checks in. If, at runtime, those kfuncs
>> see a NULL btf_struct_meta, I'd rather they fail loudly in the future
>> with a NULL deref splat, than potentially leaking memory or similarly
>> subtle failures. WDYT?
> 
> Certainly I agree with you that verification failure is much better than
> debugging runtime.
> 
> Here, we covered a few kfunc which always requires non-NULL kptr_struct_meta. But as you mentioned in the above, we also have
> cases where for a kfunc, the kptr_struct_meta could be NULL or non-NULL.
> 
> Let us say, kfunc bpf_obj_new_impl, for some cases, the kptr_struct_meta
> cannot be NULL based on bpf prog, but somehow, the verifier passes
> a NULL ptr to the program. Should we check this at fixup_kfunc_call()
> as well?
> 

I see what you mean. Since btf_struct_meta is a (btf_id, btf_record) tuple
currently, and btf_record is a view of a BTF type optimized for quickly
answering questions about special fields (existence / location / type), we
could certainly go look at the kfunc arg BTF types to confirm, as they're the
source of truth. But this would be redoing the work necessary to generate the
btf_record in the first place, which feels like it defeats the purpose of
having this view of the data at verification time. We definitely don't want
to push this BTF digging to runtime either.

Another approach: we could focus on the specific issue that caused the
bug which the commit I mentioned earlier fixes, and enforce the following
invariants:

   * All bpf_obj_new_impl calls for a particular type must use the same
     btf_struct_meta
   * Any kfunc or helper taking a user-allocated param must use the same
     btf_struct_meta as the bpf_obj_new_impl call that allocated it

Whole point of 'special' fields is to take special-field-specific action on
them, or due to their existence. This would ensure that all helpers use same
special field info. Then e.g. if bpf_obj_new's bpf_obj_init_fields does
something to a special field, bpf_obj_drop will have the same btf_struct_meta
and will have same field info for bpf_obj_free_fields.

Maybe instead of "bpf_obj_new_impl calls" above it's
more accurate to say "kfunc calls that acquire the
user-allocated type".

I think this second idea makes sense and is better than piecemeal checking.
Will think on it more and try to incorporate it into v2 of this series.

>>
>> I don't feel particularly strongly about these verification-time checks,
>> but the level of 'selective defensive programming' here feels similar to
>> other 'verifier internal error' checks sprinkled throughout verifier.c,
>> so that argument doesn't feel very persuasive to me.
> 
> I am okay with this patch but I wonder whether we can cover more
> cases.

