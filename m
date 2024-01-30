Return-Path: <bpf+bounces-20687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD1841C08
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311BE287A4D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E438DFA;
	Tue, 30 Jan 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcQTd8kE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEE38394
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596797; cv=none; b=uzCZw0D+yK/mU8bAqtHW9jQO+G6EK0DMB7kGBso1zvUkE9pGGCtaBp1+ci7Dl1sXU4fLc57b9jT1JOzklGiO3q9GN1xyeg/pB/VrrLjYsxnBORLJXHXfsuQhaPGNJ7xxvU/9Eou59TQTbFT+2Cx9IDjhdL4OtHb8TI79Vv0vLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596797; c=relaxed/simple;
	bh=YgsutBjDiFG+CwUEbACRIe+DZgGlNRC2UsBC2S3qwJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZY92SGbPkg5DNELHkGQ/wWPQDjxeQ5aNf6vVWaNu6bvtlKWwNtpFb06AdemJyLuyS6fKO87rhYiKI2Wlhbpw6LEyW+oMeAOuPR1K6aSiAjNw3nERetlow8yJ5TtsP7/7LsRDVrKAOKiSg6GJb5jmXVKBOgEO2bzAKHxB9WdNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcQTd8kE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706596792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OPlh3xVeZ9URByeZmkqqrTCJuGOakMsJmIbL5ekhdI=;
	b=qcQTd8kEd7hVzkI4o9FBV+tUJ0g42JWCv0OOXpyP0NL+AXbysgrkCwsp9EHIY1yPhrGuwd
	dKGVSKFo8635vXHgrcSHWsbyQBZpxyb9HcfVp6Ty6NgM8LGv6mgzE3/Q+z1j6m67zPGfG4
	HgPboPF9yQA/0dYoB8LM9dk2CEgD5Mg=
Date: Mon, 29 Jan 2024 22:39:43 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/26/24 5:17 PM, Amery Hung wrote:
> On Thu, Jan 25, 2024 at 6:22 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/23/24 9:22 PM, Amery Hung wrote:
>>>> I looked at the high level of the patchset. The major ops that it wants to be
>>>> programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and ".reset" in
>>>> patch 4 and patch 5).
>>>>
>>>> This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach types (each for
>>>> ".enqueue", ".dequeue", ".init", and ".reset"), and a new "bpf_qdisc_ctx" in the
>>>> uapi. It is no long an acceptable way to add new bpf extension.
>>>>
>>>> Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely implemented
>>>> in bpf (with the help of new kfuncs if needed)? Then a struct_ops for Qdisc_ops
>>>> can be created. The bpf Qdisc_ops can be loaded through the existing struct_ops api.
>>>>
>>> Partially. If using struct_ops, I think we'll need another structure
>>> like the following in bpf qdisc to be implemented with struct_ops bpf:
>>>
>>> struct bpf_qdisc_ops {
>>>       int (*enqueue) (struct sk_buff *skb)
>>>       void (*dequeue) (void)
>>>       void (*init) (void)
>>>       void (*reset) (void)
>>> };
>>>
>>> Then, Qdisc_ops will wrap around them to handle things that cannot be
>>> implemented with bpf (e.g., sch_tree_lock, returning a skb ptr).
>>
>> We can see how those limitations (calling sch_tree_lock() and returning a ptr)
>> can be addressed in bpf. This will also help other similar use cases.
>>
> 
> For kptr, I wonder if we can support the following semantics in bpf if
> they make sense:

I think they are useful but they are not fully supported now.

Some thoughts below.

> 1. Passing a referenced kptr into a bpf program, which will also need
> to be released, or exchanged into maps or allocated objects.

"enqueue" should be the one considering here:

struct Qdisc_ops {
	/* ... */
	int                     (*enqueue)(struct sk_buff *skb,
					   struct Qdisc *sch,
					   struct sk_buff **to_free);

};

The verifier only marks the skb as a trusted kptr but does not mark its 
reg->ref_obj_id. Take a look at btf_ctx_access(). In particular:

	if (prog_args_trusted(prog))
		info->reg_type |= PTR_TRUSTED;

The verifier does not know the skb ownership is passed into the ".enqueue" ops 
and does not know the bpf prog needs to release it or store it in a map.

The verifier tracks the reference state when a KF_ACQUIRE kfunc is called (just 
an example, not saying we need to use KF_ACQUIRE kfunc). Take a look at 
acquire_reference_state() which is the useful one here.

Whenever the verifier is loading the ".enqueue" bpf_prog, the verifier can 
always acquire_reference_state() for the "struct sk_buff *skb" argument.

Take a look at a recent RFC: 
https://lore.kernel.org/bpf/20240122212217.1391878-1-thinker.li@gmail.com/
which is tagging the argument of an ops (e.g. ".enqueue" here). That RFC patch 
is tagging the argument could be NULL by appending "__nullable" to the argument 
name. The verifier will enforce that the bpf prog must check for NULL first.

The similar idea can be used here but with a different tagging (for example, 
"__must_release", admittedly not a good name). While the RFC patch is 
in-progress, for now, may be hardcode for the ".enqueue" ops in 
check_struct_ops_btf_id() and always acquire_reference_state() for the skb. This 
part can be adjusted later once the RFC patch will be in shape.


Then one more thing is to track when the struct_ops bpf prog is actually reading 
the value of the skb pointer. One thing is worth to mention here, e.g. a 
struct_ops prog for enqueue:

SEC("struct_ops")
int BPF_PROG(bpf_dropall_enqueue, struct sk_buff *skb, struct Qdisc *sch,
	     struct sk_buff **to_free)
{
	return bpf_qdisc_drop(skb, sch, to_free);
}

Take a look at the BPF_PROG macro, the bpf prog is getting a pointer to an array 
of __u64 as the only argument. The skb is actually in ctx[0], sch is in 
ctx[1]...etc. When ctx[0] is read to get the skb pointer (e.g. r1 = ctx[0]), 
btf_ctx_access() marks the reg_type to PTR_TRUSTED. It needs to also initialize 
the reg->ref_obj_id by the id obtained earlier from acquire_reference_state() 
during check_struct_ops_btf_id() somehow.


> 2. Returning a kptr from a program and treating it as releasing the reference.

e.g. for dequeue:

struct Qdisc_ops {
	/* ... */
	struct sk_buff *        (*dequeue)(struct Qdisc *);
};


Right now the verifier should complain on check_reference_leak() if the 
struct_ops bpf prog is returning a referenced kptr.

Unlike an argument, the return type of a function does not have a name to tag. 
It is the first case that a struct_ops bpf_prog returning a pointer. One idea is 
to assume it must be a trusted pointer (PTR_TRUSTED) and the verifier should 
check it is indeed with PTR_TRUSTED flag.

May be release_reference_state() can be called to assume the kernel will release 
it as long as the return pointer type is PTR_TRUSTED and the type matches the 
return type of the ops. Take a look at check_return_code().

