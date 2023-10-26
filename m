Return-Path: <bpf+bounces-13300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9FC7D7CCD
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD642281E0E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18611C84;
	Thu, 26 Oct 2023 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IjO+h2aX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EDC8E8;
	Thu, 26 Oct 2023 06:20:33 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7F187;
	Wed, 25 Oct 2023 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z1mjbQsJ6uRSdwCB7sKsbSWDMZlOEsZ3uAoZGbDsd4U=; b=IjO+h2aXRhx9l3GqBR5+BpWj5Q
	SutMt2oP6WLYhiSHuzhIONMtvxgIUPRctp2KKBoVR/ITgwWWfX69sc8KhOUiUcV8eIYTB26vY353x
	GqN1TvyXgehgUkdbpK2h0Gin30oBJ/7ZNpA3C5vR/g4MbZJiJkPK0e+QJrnzSTiFRkMqkhPsVKzI4
	+dXvn7REhFMfQWpMWJ1Pknb0hduV+PBUEfcVeYOyNZ4WCHJOdF9XxgRCL+ZJY/Q9AadpARFT7uha6
	JdK1Yme8zTKEMlZ5sa1ReXkThuUJFJjeA5ogsggJH0jDxTwZ18+PJLYC0yj7VFu6Wku4TMs5Z7o0X
	NMeTrpFw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvtjF-0006rO-I4; Thu, 26 Oct 2023 08:20:25 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvtjF-000NEU-1d; Thu, 26 Oct 2023 08:20:25 +0200
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
To: Kui-Feng Lee <sinquersw@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
 <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
 <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
 <8e5e26e8-52c7-40a8-bf49-98ac2c330db9@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <28a19c46-2ee0-01db-cf88-6c9007e97c82@iogearbox.net>
Date: Thu, 26 Oct 2023 08:20:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e5e26e8-52c7-40a8-bf49-98ac2c330db9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27072/Wed Oct 25 09:45:37 2023)

Hi Kui-Feng,

On 10/26/23 3:18 AM, Kui-Feng Lee wrote:
> On 10/25/23 18:15, Kui-Feng Lee wrote:
>> On 10/25/23 15:09, Martin KaFai Lau wrote:
>>> On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
>>>> On 10/24/23 14:48, Daniel Borkmann wrote:
>>>>> This work adds a new, minimal BPF-programmable device called "netkit"
>>>>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>>>>> core idea is that BPF programs are executed within the drivers xmit routine
>>>>> and therefore e.g. in case of containers/Pods moving BPF processing closer
>>>>> to the source.
>>>>
>>>> Sorry for intruding into this discussion! Although it is too late to
>>>> mentioned this since this patchset have been v4 already.
>>>>
>>>> I notice netkit has introduced a new attach type. I wonder if it
>>>> possible to implement it as a new struct_ops type.
>>>
>>> Could your elaborate more about what does this struct_ops type do and how is it different from the SCHED_CLS bpf prog that the netkit is running?
>>
>> I found the code has been landed.
>> Basing on the landed code and
>> the patchset of registering bpf struct_ops from modules that I
>> am working on, it will looks like what is done in following patch.
>> No changes on syscall, uapi and libbpf are required.
>>
>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>> index 7e484f9fd3ae..e4eafaf397bf 100644
>> --- a/drivers/net/netkit.c
>> +++ b/drivers/net/netkit.c
>> @@ -20,6 +20,7 @@ struct netkit {
>>       struct bpf_mprog_entry __rcu *active;
>>       enum netkit_action policy;
>>       struct bpf_mprog_bundle    bundle;
>> +    struct hlist_head ops_list;
>>
>>       /* Needed in slow-path */
>>       enum netkit_mode mode;
>> @@ -27,6 +28,13 @@ struct netkit {
>>       u32 headroom;
>>   };
>>
>> +struct netkit_ops {
>> +    struct hlist_node node;
>> +    int ifindex;
>> +
>> +    int (*xmit)(struct sk_buff *skb);
>> +};
>> +
>>   struct netkit_link {
>>       struct bpf_link link;
>>       struct net_device *dev;
>> @@ -46,6 +54,22 @@ netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
>>           if (ret != NETKIT_NEXT)
>>               break;
>>       }
>> +
>> +    return ret;
>> +}
>> +
>> +static __always_inline int
>> +netkit_run_st_ops(const struct netkit *nk, struct sk_buff *skb,
>> +       enum netkit_action ret)
>> +{
>> +    struct netkit_ops *ops;
>> +
>> +    hlist_for_each_entry_rcu(ops, &nk->ops_list, node) {
>> +        ret = ops->xmit(skb);
>> +        if (ret != NETKIT_NEXT)
>> +            break;
>> +    }
>> +
>>       return ret;
>>   }
>>
>> @@ -80,6 +104,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>>       entry = rcu_dereference(nk->active);
>>       if (entry)
>>           ret = netkit_run(entry, skb, ret);
>> +    if (ret == NETKIT_NEXT)
>> +        ret = netkit_run_st_ops(nk, skb, ret);
>>       switch (ret) {
>>       case NETKIT_NEXT:
>>       case NETKIT_PASS:

I don't think it makes sense to cramp struct ops in here for what has been
solved already with the bpf_mprog interface in a more efficient way and with
control dependencies for the insertion (before/after relative programs/links).
The latter is in particular crucial for a multi-user interface when dealing
with network traffic (think for example: policy, forwarder, observability
prog, etc).

Thanks,
Daniel

