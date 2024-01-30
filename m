Return-Path: <bpf+bounces-20758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6A842B2F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B52886D8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13014E2D5;
	Tue, 30 Jan 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFA4WTT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA514E2C6;
	Tue, 30 Jan 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636971; cv=none; b=IMjAhaHisUO1ccTbg01jxkmAGdr3haUT81Y7TyFBpLVYFgAHUPg/Scsd4NDRtiNwUaGJYUyhdjA58G5m0+2nZUWW4f/+HXXbpaCayMtZDAwMJb5EsOAbDWrICzGiGizE7LF712XICBzO0Udfi1MAGlEsknFL1PMdOKYQWA2bVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636971; c=relaxed/simple;
	bh=OYumdxXhyXFNrpTnjPuyVJJC5+19XtuMmzsdSuo82Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpi7iEJlBq+oJvgTEgiaB1waikarswQlgLsKZTwQZtyH3D9cZWVFchJzfUkj80CwzMQ6PLTfeE2seRDwUXjrchOwfkr03o9agWVO4nVzzXyl6jCj6gVAqwDUn6FMSQSdE4uyhgjTNVQ8AvIIk7hKqExt+EhNw5pj5EEDuRk+lRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFA4WTT/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6432ee799so4289813276.0;
        Tue, 30 Jan 2024 09:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706636969; x=1707241769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELR7zHCCPfH1FtIz7LAHyE/HzjDEzixfdKr1qjQ9D4Y=;
        b=SFA4WTT/UtFsZyJ6vmnlUV9w4MIonBtGYuLsrn/c0Ep/zoCh4TVS+2N5sWtmYZ1eCc
         vf4Hm1ZCXXNF2QoiBrH2m1FegwkU+15shXZQ0DHwQCxa9KRHQSE7no6P8MiCqX4OE+Fy
         +2/x4QHWxyuAwPNPgIU0pJ7UAD0pYrRiANE3q3prDSRB5BUeP7P24OIV+VsOfFjRkv53
         b3TrZb42Fw1yVbUYDUvgWg8yRZ4700Rxo1kePD1uLmXDmeIC+r1rlyE1pq5w304X7K7E
         fZAyYqCeSz2npZr4KtV8fU5s52ebqJ1/E9xGJsMDf/FYQg6gEsz3bRW8F9rcZFghui/z
         iP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706636969; x=1707241769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELR7zHCCPfH1FtIz7LAHyE/HzjDEzixfdKr1qjQ9D4Y=;
        b=JLjnEhp062Bdpq3tmcBTxvWJMpYMf5UYWjzKfpQsZBFlC69AnreHR95cq02sq+kUnh
         VDF7HhzZFSMFtFxV2Bn8ITgQFPa3DENvsJWMdVABKnR+zeKykqCHObzyEW9zB5nz2vFN
         5hWczUMaPK6aUFyhBAed0JKvrNGjgod283ZSVLlca64gU/G5/qNPdLbLXnx6b615/E72
         YZ6jjeV3z3tBdSUFFBhudIpitmH925mSaW6VgOu8daY0n0ERq6bd/N15JjktwuaCg8/r
         qXei6GHpt6YUvpAVfCgcJ2ZpSPZB3o4l63ya8lMJglJjGNRXcdcQiHuCO6U4Mctp11Et
         hkwg==
X-Gm-Message-State: AOJu0YwbY3YEjhnGW5S54rjjJquHpKVF3UuEnsH4Tkx9e2OQbpk5IrX+
	ebFA3oNSIwX6+1rZiMa48s7nEDlIDaHaMiM+0ivXNS8PRynifYYy
X-Google-Smtp-Source: AGHT+IFMeTJEgALTPGO91oHqLXTFvleiwbnR4ngooQcY55xavAcEM5y9SaXRXJArrVbUac5pzyLnlQ==
X-Received: by 2002:a05:6902:1005:b0:dc2:3e3f:afd7 with SMTP id w5-20020a056902100500b00dc23e3fafd7mr8244401ybt.54.1706636968926;
        Tue, 30 Jan 2024 09:49:28 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:3c9e:c544:4041:5027? ([2600:1700:6cf8:1240:3c9e:c544:4041:5027])
        by smtp.gmail.com with ESMTPSA id 81-20020a250154000000b00dbed74597cesm3093886ybb.16.2024.01.30.09.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:49:28 -0800 (PST)
Message-ID: <845df264-adb3-4e00-bb8e-2a0ac1d331ae@gmail.com>
Date: Tue, 30 Jan 2024 09:49:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/29/24 22:39, Martin KaFai Lau wrote:
> On 1/26/24 5:17 PM, Amery Hung wrote:
>> On Thu, Jan 25, 2024 at 6:22 PM Martin KaFai Lau 
>> <martin.lau@linux.dev> wrote:
>>>
>>> On 1/23/24 9:22 PM, Amery Hung wrote:
>>>>> I looked at the high level of the patchset. The major ops that it 
>>>>> wants to be
>>>>> programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and 
>>>>> ".reset" in
>>>>> patch 4 and patch 5).
>>>>>
>>>>> This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach 
>>>>> types (each for
>>>>> ".enqueue", ".dequeue", ".init", and ".reset"), and a new 
>>>>> "bpf_qdisc_ctx" in the
>>>>> uapi. It is no long an acceptable way to add new bpf extension.
>>>>>
>>>>> Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely 
>>>>> implemented
>>>>> in bpf (with the help of new kfuncs if needed)? Then a struct_ops 
>>>>> for Qdisc_ops
>>>>> can be created. The bpf Qdisc_ops can be loaded through the 
>>>>> existing struct_ops api.
>>>>>
>>>> Partially. If using struct_ops, I think we'll need another structure
>>>> like the following in bpf qdisc to be implemented with struct_ops bpf:
>>>>
>>>> struct bpf_qdisc_ops {
>>>>       int (*enqueue) (struct sk_buff *skb)
>>>>       void (*dequeue) (void)
>>>>       void (*init) (void)
>>>>       void (*reset) (void)
>>>> };
>>>>
>>>> Then, Qdisc_ops will wrap around them to handle things that cannot be
>>>> implemented with bpf (e.g., sch_tree_lock, returning a skb ptr).
>>>
>>> We can see how those limitations (calling sch_tree_lock() and 
>>> returning a ptr)
>>> can be addressed in bpf. This will also help other similar use cases.
>>>
>>
>> For kptr, I wonder if we can support the following semantics in bpf if
>> they make sense:
> 
> I think they are useful but they are not fully supported now.
> 
> Some thoughts below.
> 
>> 1. Passing a referenced kptr into a bpf program, which will also need
>> to be released, or exchanged into maps or allocated objects.
> 
> "enqueue" should be the one considering here:
> 
> struct Qdisc_ops {
>      /* ... */
>      int                     (*enqueue)(struct sk_buff *skb,
>                         struct Qdisc *sch,
>                         struct sk_buff **to_free);
> 
> };
> 
> The verifier only marks the skb as a trusted kptr but does not mark its 
> reg->ref_obj_id. Take a look at btf_ctx_access(). In particular:
> 
>      if (prog_args_trusted(prog))
>          info->reg_type |= PTR_TRUSTED;
> 
> The verifier does not know the skb ownership is passed into the 
> ".enqueue" ops and does not know the bpf prog needs to release it or 
> store it in a map.
> 
> The verifier tracks the reference state when a KF_ACQUIRE kfunc is 
> called (just an example, not saying we need to use KF_ACQUIRE kfunc). 
> Take a look at acquire_reference_state() which is the useful one here.
> 
> Whenever the verifier is loading the ".enqueue" bpf_prog, the verifier 
> can always acquire_reference_state() for the "struct sk_buff *skb" 
> argument.
> 
> Take a look at a recent RFC: 
> https://lore.kernel.org/bpf/20240122212217.1391878-1-thinker.li@gmail.com/
> which is tagging the argument of an ops (e.g. ".enqueue" here). That RFC 
> patch is tagging the argument could be NULL by appending "__nullable" to 
> the argument name. The verifier will enforce that the bpf prog must 
> check for NULL first.
> 
> The similar idea can be used here but with a different tagging (for 
> example, "__must_release", admittedly not a good name). While the RFC 
> patch is in-progress, for now, may be hardcode for the ".enqueue" ops in 
> check_struct_ops_btf_id() and always acquire_reference_state() for the 
> skb. This part can be adjusted later once the RFC patch will be in shape.
> 
> 
> Then one more thing is to track when the struct_ops bpf prog is actually 
> reading the value of the skb pointer. One thing is worth to mention 
> here, e.g. a struct_ops prog for enqueue:
> 
> SEC("struct_ops")
> int BPF_PROG(bpf_dropall_enqueue, struct sk_buff *skb, struct Qdisc *sch,
>           struct sk_buff **to_free)
> {
>      return bpf_qdisc_drop(skb, sch, to_free);
> }
> 
> Take a look at the BPF_PROG macro, the bpf prog is getting a pointer to 
> an array of __u64 as the only argument. The skb is actually in ctx[0], 
> sch is in ctx[1]...etc. When ctx[0] is read to get the skb pointer (e.g. 
> r1 = ctx[0]), btf_ctx_access() marks the reg_type to PTR_TRUSTED. It 
> needs to also initialize the reg->ref_obj_id by the id obtained earlier 
> from acquire_reference_state() during check_struct_ops_btf_id() somehow.
> 
> 
>> 2. Returning a kptr from a program and treating it as releasing the 
>> reference.
> 
> e.g. for dequeue:
> 
> struct Qdisc_ops {
>      /* ... */
>      struct sk_buff *        (*dequeue)(struct Qdisc *);
> };
> 
> 
> Right now the verifier should complain on check_reference_leak() if the 
> struct_ops bpf prog is returning a referenced kptr.
> 
> Unlike an argument, the return type of a function does not have a name 
> to tag. It is the first case that a struct_ops bpf_prog returning a 

We may tag the stub functions instead, right?
Is the purpose here to return a referenced pointer from a struct_ops
operator without verifier complaining?

> pointer. One idea is to assume it must be a trusted pointer 
> (PTR_TRUSTED) and the verifier should check it is indeed with 
> PTR_TRUSTED flag.
> 
> May be release_reference_state() can be called to assume the kernel will 
> release it as long as the return pointer type is PTR_TRUSTED and the 
> type matches the return type of the ops. Take a look at 
> check_return_code().
> 

