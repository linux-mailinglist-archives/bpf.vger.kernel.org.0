Return-Path: <bpf+bounces-13350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F87D8889
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE06B21285
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF23AC03;
	Thu, 26 Oct 2023 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fwt/DxYO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B14426
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:46:32 +0000 (UTC)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD91A7
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:46:30 -0700 (PDT)
Message-ID: <a14a83e9-e159-3ee0-782b-c4caf7c25428@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698345988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAOutKU0dRgjaArlSvoMKoZP5sLfxgykIX7jMCl+meE=;
	b=Fwt/DxYOuroGcnlgBmJxFEWzuLE4DJO/xLQRgtcMXNQiWpeLhNpGHLCsWPVerwheDb/01a
	dU3WkRGvNNzYbm1UjNmCWNpofk/pK7zqHeuJ8DyaEP/mDbJMmA/7xdALw8wSEED/iUQRxQ
	PllARdj+5/+PFcPEg5eCElqvQCSUCyI=
Date: Thu, 26 Oct 2023 11:46:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
 <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
 <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
 <8e5e26e8-52c7-40a8-bf49-98ac2c330db9@gmail.com>
 <28a19c46-2ee0-01db-cf88-6c9007e97c82@iogearbox.net>
 <d61d1de0-b8d9-42c2-bc6d-bcdd9bef2abf@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d61d1de0-b8d9-42c2-bc6d-bcdd9bef2abf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/26/23 10:47 AM, Kui-Feng Lee wrote:
> 
> 
> On 10/25/23 23:20, Daniel Borkmann wrote:
>> Hi Kui-Feng,
>>
>> On 10/26/23 3:18 AM, Kui-Feng Lee wrote:
>>> On 10/25/23 18:15, Kui-Feng Lee wrote:
>>>> On 10/25/23 15:09, Martin KaFai Lau wrote:
>>>>> On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
>>>>>> On 10/24/23 14:48, Daniel Borkmann wrote:
>>>>>>> This work adds a new, minimal BPF-programmable device called "netkit"
>>>>>>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>>>>>>> core idea is that BPF programs are executed within the drivers xmit routine
>>>>>>> and therefore e.g. in case of containers/Pods moving BPF processing closer
>>>>>>> to the source.
>>>>>>
>>>>>> Sorry for intruding into this discussion! Although it is too late to
>>>>>> mentioned this since this patchset have been v4 already.
>>>>>>
>>>>>> I notice netkit has introduced a new attach type. I wonder if it
>>>>>> possible to implement it as a new struct_ops type.
>>>>>
>>>>> Could your elaborate more about what does this struct_ops type do and how 
>>>>> is it different from the SCHED_CLS bpf prog that the netkit is running?
>>>>
>>>> I found the code has been landed.
>>>> Basing on the landed code and
>>>> the patchset of registering bpf struct_ops from modules that I
>>>> am working on, it will looks like what is done in following patch.
>>>> No changes on syscall, uapi and libbpf are required.
>>>>
>>>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>>>> index 7e484f9fd3ae..e4eafaf397bf 100644
>>>> --- a/drivers/net/netkit.c
>>>> +++ b/drivers/net/netkit.c
>>>> @@ -20,6 +20,7 @@ struct netkit {
>>>>       struct bpf_mprog_entry __rcu *active;
>>>>       enum netkit_action policy;
>>>>       struct bpf_mprog_bundle    bundle;
>>>> +    struct hlist_head ops_list;
>>>>
>>>>       /* Needed in slow-path */
>>>>       enum netkit_mode mode;
>>>> @@ -27,6 +28,13 @@ struct netkit {
>>>>       u32 headroom;
>>>>   };
>>>>
>>>> +struct netkit_ops {
>>>> +    struct hlist_node node;
>>>> +    int ifindex;
>>>> +
>>>> +    int (*xmit)(struct sk_buff *skb);
>>>> +};
>>>> +
>>>>   struct netkit_link {
>>>>       struct bpf_link link;
>>>>       struct net_device *dev;
>>>> @@ -46,6 +54,22 @@ netkit_run(const struct bpf_mprog_entry *entry, struct 
>>>> sk_buff *skb,
>>>>           if (ret != NETKIT_NEXT)
>>>>               break;
>>>>       }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static __always_inline int
>>>> +netkit_run_st_ops(const struct netkit *nk, struct sk_buff *skb,
>>>> +       enum netkit_action ret)
>>>> +{
>>>> +    struct netkit_ops *ops;
>>>> +
>>>> +    hlist_for_each_entry_rcu(ops, &nk->ops_list, node) {
>>>> +        ret = ops->xmit(skb);
>>>> +        if (ret != NETKIT_NEXT)
>>>> +            break;
>>>> +    }
>>>> +
>>>>       return ret;
>>>>   }
>>>>
>>>> @@ -80,6 +104,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, 
>>>> struct net_device *dev)
>>>>       entry = rcu_dereference(nk->active);
>>>>       if (entry)
>>>>           ret = netkit_run(entry, skb, ret);
>>>> +    if (ret == NETKIT_NEXT)
>>>> +        ret = netkit_run_st_ops(nk, skb, ret);
>>>>       switch (ret) {
>>>>       case NETKIT_NEXT:
>>>>       case NETKIT_PASS:
>>
>> I don't think it makes sense to cramp struct ops in here for what has been
>> solved already with the bpf_mprog interface in a more efficient way and with
>> control dependencies for the insertion (before/after relative programs/links).
>> The latter is in particular crucial for a multi-user interface when dealing
>> with network traffic (think for example: policy, forwarder, observability
>> prog, etc).
>>
> 
> I don't mean to cramp two implementations together
> and don't notice this patchset is already landed at beginning.

There are a few ways to track this. patchwork bot will send a landing message to 
the list. There is a few mins lag time but I don't think this lags matter here. 
You may want to check your inbox and ensure it gets through.

git always has the source of true also.

> This patch is just for explanation of how it likes if it is implemented
> with just struct_ops (without bpf_mprog).

Thanks for sharing a struct_ops code snippet. It is an interesting idea to embed 
ifindex and other details in the struct.

Leaving it still needs verifier changes to make the PTR_TO_BTF_ID skb in 
struct_ops to work like tc __sk_buff such that all existing tc-bpf prog will 
work as is. Daniel has already mentioned the ordering API (bpf_mprog) that has 
been discussed for a year and has already been used in tc-link which I hope it 
will be extended to solve the xdp ordering also. I am also not convinced saving 
two attach types (note the prog type is the same here) deserve to re-create 
something in-parallel to tc-link and then require the same "skb" bpf dataplane 
program to be administrated (attach/introspect...etc) differently.

