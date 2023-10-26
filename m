Return-Path: <bpf+bounces-13343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905AB7D87C8
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD81C2102E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B838FAD;
	Thu, 26 Oct 2023 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SatJxK7J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF02E3E9;
	Thu, 26 Oct 2023 17:47:26 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665090;
	Thu, 26 Oct 2023 10:47:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2988d62eso750294a34.1;
        Thu, 26 Oct 2023 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698342445; x=1698947245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0u1b+zcKru80DQ2+fv77/cURwKIT9qGadWKxoVee/Hs=;
        b=SatJxK7JCiknBaaBLbgzr0fpy5mPgOdE7Uh8G82MDKXBY+kesLlGqw1LtTDiXAtbJP
         837fEeNod5N8iMD2qx62arYNZlgDyGNhRTP/9hXv/7umq/cXU/WIO2mh4B+BH7S3HOO+
         hrsRiP4xg5Xcp/yyjUsBkNgGfi4Uxp9PRD/zinN6kuH1VmumEF1fddsGp+gS3seEtTiR
         ozfBUhdxoVzCvzQtKH5itlXYWedELCIvrM1uCYHJu7Wm5KoYZdZO6QA7FtzGoE4JRq5O
         9OVL+bfyUOJJWzvPklw+WxM26PbMjLO+1f00JNXzHdQsXtsNQEqwChgXb4/vSLMxPd7n
         oK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342445; x=1698947245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0u1b+zcKru80DQ2+fv77/cURwKIT9qGadWKxoVee/Hs=;
        b=PIK43u3+mtStCGVmmYFeImWt/wToPjq/l73xzxk5QUSPXpeGi/7dKgOqpzJiD54duZ
         VCcXvllJkF0s/aek73k/w87JiCfZqWS+o0Qud8UKDG7oXtrRafgeud+byZX7VHID1bus
         Il0K9hytkll4LYjRjnANzKagdLawkUlaZ7+E3+zuluO3MECMCU7yOFxisHf07Zew/Xjl
         xehdVOgZMvLk7xNIB5IMvkjEgPVrLwPJFWNE3ifEGBpGXcJLw8HRobIPlVm1bWWW6fwp
         hE9YCtuIr7Pq68KcAV3LYR/ncP4zep5wui1HR7dAcUMjOrVeRan98rY6XXcaaLFDOgv0
         oySQ==
X-Gm-Message-State: AOJu0YzLLvtlwylxbjaYLzdKyAyeRFvbCvhgn8AwIwidv5oGBcXLpqh8
	NuiwqN7X+57bVpZTCo/qz2JWWQLIrq0=
X-Google-Smtp-Source: AGHT+IEiusY5xLGkN0/x3HK9/ac4NkMIl2Kg/UpHWUrfy6x+qnJBlnDMjnswtcNMbWH2b56xVXmRpw==
X-Received: by 2002:a9d:7f95:0:b0:6bc:b8d9:476e with SMTP id t21-20020a9d7f95000000b006bcb8d9476emr128939otp.16.1698342444737;
        Thu, 26 Oct 2023 10:47:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:c145:27c4:65c2:8d36? ([2600:1700:6cf8:1240:c145:27c4:65c2:8d36])
        by smtp.gmail.com with ESMTPSA id k33-20020a81ac21000000b0059adc0c4392sm1719025ywh.140.2023.10.26.10.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 10:47:24 -0700 (PDT)
Message-ID: <d61d1de0-b8d9-42c2-bc6d-bcdd9bef2abf@gmail.com>
Date: Thu, 26 Oct 2023 10:47:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
To: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
 <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
 <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
 <8e5e26e8-52c7-40a8-bf49-98ac2c330db9@gmail.com>
 <28a19c46-2ee0-01db-cf88-6c9007e97c82@iogearbox.net>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <28a19c46-2ee0-01db-cf88-6c9007e97c82@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/25/23 23:20, Daniel Borkmann wrote:
> Hi Kui-Feng,
> 
> On 10/26/23 3:18 AM, Kui-Feng Lee wrote:
>> On 10/25/23 18:15, Kui-Feng Lee wrote:
>>> On 10/25/23 15:09, Martin KaFai Lau wrote:
>>>> On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
>>>>> On 10/24/23 14:48, Daniel Borkmann wrote:
>>>>>> This work adds a new, minimal BPF-programmable device called "netkit"
>>>>>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. 
>>>>>> The
>>>>>> core idea is that BPF programs are executed within the drivers 
>>>>>> xmit routine
>>>>>> and therefore e.g. in case of containers/Pods moving BPF 
>>>>>> processing closer
>>>>>> to the source.
>>>>>
>>>>> Sorry for intruding into this discussion! Although it is too late to
>>>>> mentioned this since this patchset have been v4 already.
>>>>>
>>>>> I notice netkit has introduced a new attach type. I wonder if it
>>>>> possible to implement it as a new struct_ops type.
>>>>
>>>> Could your elaborate more about what does this struct_ops type do 
>>>> and how is it different from the SCHED_CLS bpf prog that the netkit 
>>>> is running?
>>>
>>> I found the code has been landed.
>>> Basing on the landed code and
>>> the patchset of registering bpf struct_ops from modules that I
>>> am working on, it will looks like what is done in following patch.
>>> No changes on syscall, uapi and libbpf are required.
>>>
>>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>>> index 7e484f9fd3ae..e4eafaf397bf 100644
>>> --- a/drivers/net/netkit.c
>>> +++ b/drivers/net/netkit.c
>>> @@ -20,6 +20,7 @@ struct netkit {
>>>       struct bpf_mprog_entry __rcu *active;
>>>       enum netkit_action policy;
>>>       struct bpf_mprog_bundle    bundle;
>>> +    struct hlist_head ops_list;
>>>
>>>       /* Needed in slow-path */
>>>       enum netkit_mode mode;
>>> @@ -27,6 +28,13 @@ struct netkit {
>>>       u32 headroom;
>>>   };
>>>
>>> +struct netkit_ops {
>>> +    struct hlist_node node;
>>> +    int ifindex;
>>> +
>>> +    int (*xmit)(struct sk_buff *skb);
>>> +};
>>> +
>>>   struct netkit_link {
>>>       struct bpf_link link;
>>>       struct net_device *dev;
>>> @@ -46,6 +54,22 @@ netkit_run(const struct bpf_mprog_entry *entry, 
>>> struct sk_buff *skb,
>>>           if (ret != NETKIT_NEXT)
>>>               break;
>>>       }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static __always_inline int
>>> +netkit_run_st_ops(const struct netkit *nk, struct sk_buff *skb,
>>> +       enum netkit_action ret)
>>> +{
>>> +    struct netkit_ops *ops;
>>> +
>>> +    hlist_for_each_entry_rcu(ops, &nk->ops_list, node) {
>>> +        ret = ops->xmit(skb);
>>> +        if (ret != NETKIT_NEXT)
>>> +            break;
>>> +    }
>>> +
>>>       return ret;
>>>   }
>>>
>>> @@ -80,6 +104,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff 
>>> *skb, struct net_device *dev)
>>>       entry = rcu_dereference(nk->active);
>>>       if (entry)
>>>           ret = netkit_run(entry, skb, ret);
>>> +    if (ret == NETKIT_NEXT)
>>> +        ret = netkit_run_st_ops(nk, skb, ret);
>>>       switch (ret) {
>>>       case NETKIT_NEXT:
>>>       case NETKIT_PASS:
> 
> I don't think it makes sense to cramp struct ops in here for what has been
> solved already with the bpf_mprog interface in a more efficient way and 
> with
> control dependencies for the insertion (before/after relative 
> programs/links).
> The latter is in particular crucial for a multi-user interface when dealing
> with network traffic (think for example: policy, forwarder, observability
> prog, etc).
> 

I don't mean to cramp two implementations together
and don't notice this patchset is already landed at beginning.
This patch is just for explanation of how it likes if it is implemented
with just struct_ops (without bpf_mprog).

