Return-Path: <bpf+bounces-74409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CCC57BB4
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC58421AF0
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E102351FD5;
	Thu, 13 Nov 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ckybWbZ/"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A434FF6C;
	Thu, 13 Nov 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039813; cv=none; b=l1Vd9Goqn7rkAI4c8DbLLuNe2mPdFFGZ72h2opZFePc7c7D3+hOb7IGvT8u9Z9UPLq9B//JAGDgBCJxtUKVcah2BY9YXlkziet1erszJqYrA+kwwYzVnpcLbIzs+Z/FiUFtSzDVPkKJ3TXCKXtugFIFnyoyyuWoMXGRcNuB4On8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039813; c=relaxed/simple;
	bh=QNGOqLbAwoqstrsgcHwu7Y9gDhv7BY88AiOG8qIPNu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koR190feZOWmNgBgjFH4jETxsn92E04IUuCfbEUAmXVbkjC8DBt5pBtBmyPfQOoRHe9tCzeBPTvxdhIl6v4r0/yqO+bHo8Cd87aEzMfZJjQONayQ0EMSGvgm1nZZasgA32hUJahES9ScMrSsdCgyShCjZYwHFRU3Vfw6H9EQmRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ckybWbZ/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17a9444f-1151-44b4-b2ec-5cafd12bf2bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763039808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvsYg/suGuaRX0DZcS1SBS2h2LrKRFVpbG6edtKNjaU=;
	b=ckybWbZ/jvkG/c8u4NjG0nbicVD6AWkD5VuKlAtznklBjF3N4S6zwcwpfeFWSkkZarzWXM
	0mt6wNVZ2OvL1KLTv2fSDR/z65Ueh8XBOkXSGB2tB+RTUNG3/R6DPqVeQEsSWcL6gCLh15
	Y7Cq53I0I9lYTyU2czOF3XtXlJLsUpo=
Date: Thu, 13 Nov 2025 21:16:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add test to verify freeing
 the special fields when update [lru_,]percpu_hash maps
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251105151407.12723-1-leon.hwang@linux.dev>
 <20251105151407.12723-3-leon.hwang@linux.dev>
 <9f662e2c-7370-4f99-bdec-bc123495e1c5@linux.dev>
 <04c35045-ef5b-4e92-9da9-6710ce8fdabf@linux.dev>
 <22251785-789d-43f8-8031-86406cd4c12b@linux.dev>
 <6a2a6f41-f24a-4e87-94d0-8cb147725279@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <6a2a6f41-f24a-4e87-94d0-8cb147725279@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/12 05:58, Yonghong Song wrote:
>
>
> On 11/11/25 5:52 AM, Leon Hwang wrote:
>>
>> On 2025/11/11 21:38, Leon Hwang wrote:
>>>
>>> On 2025/11/7 10:00, Yonghong Song wrote:
>>>>
>>>> On 11/5/25 7:14 AM, Leon Hwang wrote:
[...]

>>>>> +
>>>>> +static int __insert_in_list(struct bpf_list_head *head, struct
>>>>> bpf_spin_lock *lock,
>>>>> +                struct node_data __kptr **node)
>>>>> +{
>>>>> +    struct node_data *node_new, *node_ref, *node_old;
>>>>> +
>>>>> +    node_new = bpf_obj_new(typeof(*node_new));
>>>>> +    if (!node_new)
>>>>> +        return -1;
>>>>> +
>>>>> +    node_ref = bpf_refcount_acquire(node_new);
>>>>> +    node_old = bpf_kptr_xchg(node, node_new);
>>>> Change the above to node_old = bpf_kptr_xchg(node, node_node_ref);
>>>> might
>>>> be better for reasoning although node_ref/node_new are the same.
>>>>
>>> Nope — node_ref and node_new are different for the verifier.
>> They are the same in theory.
>>
>> The verifier failure was likely caused by something else, but I'm not
>> sure of the exact reason.
>
> I did some analysis and your code works as expected:
>
>     node_ref = bpf_refcount_acquire(node_new);
>     node_old = bpf_kptr_xchg(node, node_new);
>     if (node_old) {
>             bpf_obj_drop(node_old);
>             bpf_obj_drop(node_ref);
>             return -2;
>     }
>
>     bpf_spin_lock(lock);
>     bpf_list_push_front(head, &node_ref->l);
>     ref = (u64)(void *) &node_ref->ref;
>     bpf_spin_unlock(lock);
>
> In the above, after the following insn:
>     node_old = bpf_kptr_xchg(node, node_new);
> the second argument 'node_new' will become a scalar since it
> may be changed by another bpf program accessing the same map.
>
> So your code is okay as node_ref still valid ptr_node_data
> and can be used in following codes.
>
>
> My suggestion to replace
>     node_old = bpf_kptr_xchg(node, node_new);
> with
>     node_old = bpf_kptr_xchg(node, node_ref);
> will not work since node_ref will be a scalar
> so subsequent bpf_obj_drop(node_ref) and bpf_list_push_front(...)
> won't work.
>
> In summary, your change look okay to me. Sorry for noise.
>

Hi Yonghong,

Thanks for your detailed analysis.

Indeed, in the case of
node_old = bpf_kptr_xchg(node, node_ref);,
the verifier marks node_ref as SCALAR_VALUE.

Here's the relevant part in check_helper_call():

static int check_helper_call(struct bpf_verifier_env *env, struct
bpf_insn *insn,
                             int *insn_idx_p)
{
        //...
        if (meta.release_regno) {
                err = -EINVAL;
                if (arg_type_is_dynptr(fn->arg_type[meta.release_regno -
BPF_REG_1])) {
                        err = unmark_stack_slots_dynptr(env,
&regs[meta.release_regno]);
                } else if (func_id == BPF_FUNC_kptr_xchg &&
meta.ref_obj_id) {
                        u32 ref_obj_id = meta.ref_obj_id;
                        bool in_rcu = in_rcu_cs(env);
                        struct bpf_func_state *state;
                        struct bpf_reg_state *reg;

                        err = release_reference_nomark(env->cur_state,
ref_obj_id);
                        if (!err) {

bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
                                        if (reg->ref_obj_id == ref_obj_id) {
                                                if (in_rcu && (reg->type
& MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
                                                        reg->ref_obj_id = 0;
                                                        reg->type &=
~MEM_ALLOC;
                                                        reg->type |=
MEM_RCU;
                                                } else {

mark_reg_invalid(env, reg);
                                                }
                                        }
                                }));
                        }
                } else if (meta.ref_obj_id) {
                        //...
        }
        //...
}

This logic matches your explanation — when the argument passed to
bpf_kptr_xchg() holds a reference (meta.ref_obj_id), that reference is
not a KPTR_PERCPU inside an RCU critical section.
As a result, node_ref is invalidated and becomes a scalar after the call.

So yes, your reasoning is correct, and this behavior explains why using
node_ref as the second argument doesn't work.

Thanks,
Leon

[...]

