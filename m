Return-Path: <bpf+bounces-20992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB37846588
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B611F24780
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CB882F;
	Fri,  2 Feb 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hoxIVJGa"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0868814
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838474; cv=none; b=RsgBlXrDV9b354/7leRCpx7w5awZEJbKclVB9U/t2TCOuougn6wvZ5LmDgy5P7Ne7RCokuZWZqFhwRHKDEMYq6hLUPSPv8kaMSe2bkDJ38khBlFWODk2QC99l79uUvk/DitqMI2BTuH1kq6FmBKKF1IjqH1OJ050L8GHiRHF4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838474; c=relaxed/simple;
	bh=sELDC7Dq7jbJKZ94quhQrSYWfsMEiyh8Vu4uAAvvxiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPFLoFMuGu+S0cyQ0u0DIQ6faZL8OaA5ht3glltTqgmmIRdTHCUy7rYeO8wIHoVrn99M805D2L0QvYoRQPkb0D46tYWPmX08zwlX0a73xxwy5kAvo7HUfHBSFbW9Mw2sn05KB0MO3WxZnhOR6zJHw5yKgk+5pwqFGLWiS1IifcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hoxIVJGa; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a2e9cf6-ef36-4ba8-bb95-fb592bdce5db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706838469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqWkAdcNsywcgiK3l1QK5Act/UKUr9ykoatsuW2y9jY=;
	b=hoxIVJGaQd1Ldgldl9yOqOd/fs1wJO5yxMhDEcC5ja2omj2KpQNvfHNG9Nky7jC5ft/9V7
	wF7RPCGmAzIfzGKYU6Fwx/jCpMIpqrzEmHnVyGcFfPv2L9PhRs05cBeIX+mU+CqFTC4gNN
	Zn2NjMbDlXjjIrBfC6kEPkz9Fh1Wfe0=
Date: Thu, 1 Feb 2024 17:47:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, netdev@vger.kernel.org,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
 <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
 <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
 <CAMB2axOdeE5dPeFGvgM5QVd9a47srtvDFZd1VUYjSarNJC=T_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axOdeE5dPeFGvgM5QVd9a47srtvDFZd1VUYjSarNJC=T_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/31/24 8:23 AM, Amery Hung wrote:
>>> 1. Passing a referenced kptr into a bpf program, which will also need
>>> to be released, or exchanged into maps or allocated objects.
>> "enqueue" should be the one considering here:
>>
>> struct Qdisc_ops {
>>          /* ... */
>>          int                     (*enqueue)(struct sk_buff *skb,
>>                                             struct Qdisc *sch,
>>                                             struct sk_buff **to_free);
>>
>> };
>>
>> The verifier only marks the skb as a trusted kptr but does not mark its
>> reg->ref_obj_id. Take a look at btf_ctx_access(). In particular:
>>
>>          if (prog_args_trusted(prog))
>>                  info->reg_type |= PTR_TRUSTED;
>>
>> The verifier does not know the skb ownership is passed into the ".enqueue" ops
>> and does not know the bpf prog needs to release it or store it in a map.
>>
>> The verifier tracks the reference state when a KF_ACQUIRE kfunc is called (just
>> an example, not saying we need to use KF_ACQUIRE kfunc). Take a look at
>> acquire_reference_state() which is the useful one here.
>>
>> Whenever the verifier is loading the ".enqueue" bpf_prog, the verifier can
>> always acquire_reference_state() for the "struct sk_buff *skb" argument.
>>
>> Take a look at a recent RFC:
>> https://lore.kernel.org/bpf/20240122212217.1391878-1-thinker.li@gmail.com/
>> which is tagging the argument of an ops (e.g. ".enqueue" here). That RFC patch
>> is tagging the argument could be NULL by appending "__nullable" to the argument
>> name. The verifier will enforce that the bpf prog must check for NULL first.
>>
>> The similar idea can be used here but with a different tagging (for example,
>> "__must_release", admittedly not a good name). While the RFC patch is
>> in-progress, for now, may be hardcode for the ".enqueue" ops in
>> check_struct_ops_btf_id() and always acquire_reference_state() for the skb. This
>> part can be adjusted later once the RFC patch will be in shape.
>>
> Make sense. One more thing to consider here is that .enqueue is
> actually a reference acquiring and releasing function at the same
> time. Assuming ctx written to by a struct_ops program can be seen by
> the kernel, another new tag for the "to_free" argument will still be
> needed so that the verifier can recognize when writing skb to
> "to_free".

I don't think "to_free" needs special tagging. I was thinking the 
"bpf_qdisc_drop" kfunc could be a KF_RELEASE. Ideally, it should be like

__bpf_kfunc int bpf_qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
	                       struct sk_buff **to_free)
{
	return qdisc_drop(skb, sch, to_free);
}

However, I don't think the verifier supports pointer to pointer now. Meaning
"struct sk_buff **to_free" does not work.

If the ptr indirection spinning in my head is sound, one possible solution to 
unblock the qdisc work is to introduce:

struct bpf_sk_buff_ptr {
	struct sk_buff *skb;
};

and the bpf_qdisc_drop kfunc:

__bpf_kfunc int bpf_qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
                                struct bpf_sk_buff_ptr *to_free_list)

and the enqueue prog:

SEC("struct_ops/enqueue")
int BPF_PROG(test_enqueue, struct sk_buff *skb,
              struct Qdisc *sch,
              struct bpf_sk_buff_ptr *to_free_list)
{
	return bpf_qdisc_drop(skb, sch, to_free_list);
}

and the ".is_valid_access" needs to change the btf_type from "struct sk_buff **" 
to "struct bpf_sk_buff_ptr *" which is sort of similar to the bpf_tcp_ca.c that 
is changing the "struct sock *" type to the "struct tcp_sock *" type.

I have the compiler-tested idea here: 
https://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git/log/?h=qdisc-ideas


> 
>> Then one more thing is to track when the struct_ops bpf prog is actually reading
>> the value of the skb pointer. One thing is worth to mention here, e.g. a
>> struct_ops prog for enqueue:
>>
>> SEC("struct_ops")
>> int BPF_PROG(bpf_dropall_enqueue, struct sk_buff *skb, struct Qdisc *sch,
>>               struct sk_buff **to_free)
>> {
>>          return bpf_qdisc_drop(skb, sch, to_free);
>> }
>>
>> Take a look at the BPF_PROG macro, the bpf prog is getting a pointer to an array
>> of __u64 as the only argument. The skb is actually in ctx[0], sch is in
>> ctx[1]...etc. When ctx[0] is read to get the skb pointer (e.g. r1 = ctx[0]),
>> btf_ctx_access() marks the reg_type to PTR_TRUSTED. It needs to also initialize
>> the reg->ref_obj_id by the id obtained earlier from acquire_reference_state()
>> during check_struct_ops_btf_id() somehow.


