Return-Path: <bpf+bounces-29013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE6E8BF518
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 05:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3599B2815FE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08017557;
	Wed,  8 May 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LxVw5+ot"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE824B34;
	Wed,  8 May 2024 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140417; cv=none; b=FkuNJAfbPZMm0g1uWyqVeDDfQCo0p6rVn8mvaWM5OVKf7DFvt7pa4I99sAqZb/5XvcO8rHYJI+mfBBhTw4eZ2fwmkKbZ8VkNjyfUYaqQ0VDDxQEXzoKNk/VgB3qHMlt8/Vs6rgYNpgJhdEBC1Jg0fpCcKh+pCQNRlNHNePJ2lv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140417; c=relaxed/simple;
	bh=J2WRcifkgTTK2WyoFwQaw/xp648pJDvELfsC0xE8i6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hHyzJymdy8XqzeT6yDmbmvaEJVVmNKOolz61FJy4KtSPZ+oCCswCaUcszujgjPpj0wGTd1iItBigQaHSSXvgkCMHCEvudZh1KhVzZ3LnoTlzPaSSIqeRZuNTa//2RF4dQMju7h/Xw6O6Qx/cK/S98/Kt+gJhSJsJV/hEVyLUoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LxVw5+ot; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715140411; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=sD4L/2NZOlCbtlDmhnBNkK3tUAmTyh296u5gGEDFucA=;
	b=LxVw5+otY27y4yWW2VaK0xSOOwIY3l0b5S8mvBoEH0D1EAQRG3MLgYGtaGAr0Bx6qbsKqx4xRJV+I8xn3c1flwaSBp20JnYxifyPKQdKc9VSdzYWpGVkfZR9Jv8KpdWTlm47/vK7w4FDP4UYVwaqRLE471o3L3HC/f4RX7+VOzY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W625brA_1715140085;
Received: from 30.221.130.197(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W625brA_1715140085)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 11:48:06 +0800
Message-ID: <7f62c6fd-c193-45ba-9f8a-485f011c5c0d@linux.alibaba.com>
Date: Wed, 8 May 2024 11:48:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
 <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
 <2e34e4ea-b198-487e-be5b-ba854965dbeb@linux.alibaba.com>
 <ZjpSgWyHaNC/ikNP@pop-os.localdomain>
In-Reply-To: <ZjpSgWyHaNC/ikNP@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/8 00:10, Cong Wang wrote:
> On Tue, May 07, 2024 at 10:34:09PM +0800, Wen Gu wrote:
>>
>>
>> On 2024/4/28 23:49, Cong Wang wrote:
>>> On Sun, Apr 28, 2024 at 02:07:27PM +0800, Wen Gu wrote:
>>>> This patch set acts as the second part of the new version of [1] (The first
>>>> part can be referred from [2]), the updated things of this version are listed
>>>> at the end.
>>>>
>>>> - Background
>>>>
>>>> SMC-D is now used in IBM z with ISM function to optimize network interconnect
>>>> for intra-CPC communications. Inspired by this, we try to make SMC-D available
>>>> on the non-s390 architecture through a software-implemented Emulated-ISM device,
>>>> that is the loopback-ism device here, to accelerate inter-process or
>>>> inter-containers communication within the same OS instance.
>>>
>>> Just FYI:
>>>
>>> Cilium has implemented this kind of shortcut with sockmap and sockops.
>>> In fact, for intra-OS case, it is _very_ simple. The core code is less
>>> than 50 lines. Please take a look here:
>>> https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c
>>>
>>> Like I mentioned in my LSF/MM/BPF proposal, we plan to implement
>>> similiar eBPF things for inter-OS (aka VM) case.
>>>
>>> More importantly, even LD_PRELOAD is not needed for this eBPF approach.
>>> :)
>>>
>>> Thanks.
>>
>> Hi, Cong. Thank you very much for the information. I learned about sockmap
>> before and from my perspective smcd loopback and sockmap each have their own
>> pros and cons.
>>
>> The pros of smcd loopback is that it uses a standard process that defined
>> by RFC-7609 for negotiation, this CLC handshake helps smc correctly determine
>> whether the tcp connection should be upgraded no matter what middleware the
>> connection passes, e.g. through NAT. So we don't need to pay extra effort to
>> check whether the connection should be shortcut, unlike checking various policy
>> by bpf_sock_ops_ipv4() in sockmap. And since the handshake automatically select
>> different underlay devices for different scenarios (loopback-ism in intra-OS,
>> ISM in inter-VM of IBM z and RDMA in inter-VM of different hosts), various
>> scenarios can be covered through one smc protocol stack.
>>
>> The cons of smcd loopback is also related to the CLC handshake, one more round
>> handshake may cause smc to perform worse than TCP in short-lived connection
>> scenarios. So we basically use smc upgrade in long-lived connection scenarios
>> and are exploring IPPROTO_SMC[1] to provide lossless fallback under adverse cases.
> 
> You don't have to bother RFC's, since you could define your own TCP
> options. And, the eBPF approach could also use TCP options whenver
> needed. Cilium probably does not use them only because for intra-OS case
> it is too simple to bother TCP options, as everything can be shared via a
> shared socketmap.
> 
> In reality, the setup is not that complex. In many cases we already know
> whether we have VM or container (or mixed) setup before we develop (as
> a part of requirement gathering). And they rarely change.
> 
> Taking one step back, the discovery of VM or container or loopback cases
> could be done via TCP options too, to deal with complex cases like
> KataContainer. There is no reason to bother RFC's, maybe except the RDMA
> case.
> 
> In fact, this is an advantage to me. We don't need to argue with anyone
> on our own TCP option or eBPF code, we don't even have to share our own
> eBPF code here.
> 

Private TCP option could be a historical burden and a risk for compatibility,
so IMHO it doesn't work, at least for SMC. Besides, the smc handshake process
I mentioned is not just about TCP option, that is the first step. There are
another 3-way CLC handshake to choose right underlay for different cases
or safelly fallback to TCP, keep users out of bother. Lastly, the process was
designed for different cases and smcd loopback is one of the whole picture,
so simplicity of intra-OS case does not mean the existing handshake is meaningless
nor smcd loopback should give up using existing process but follow sockmap.

>>
>> And we are also working on other upgrade ways than LD_PRELOAD, e.g. using eBPF
>> hook[2] with IPPROTO_SMC, to enhance the usability.
> 
> That is wrong IMHO, because basically it just overwrites kernel modules
> with eBPF, not how eBPF is supposed to be used. IOW, you could not use
> it at all without SMC/MPTCP modules.
> 
Yes, it expects to be used for SMC/MPTCP modules.

> BTW, this approach does not work for kernel sockets, because you only
> hook __sys_socket().
> 
In fact the purpose of this is mainly to transparently upgrade applications'
TCP sockets, so kernel sockets are not the target.

> Of course, for sockmap or sockops, they could be used independently for
> any other purposes. I hope now you could see the flexiblities of eBPF
> over kernel modules.
> 
Yes, I agree with the pros of eBPF way, like flexiblities you mentioned.
As I said above, from my perspective they both have their own pros and cons.

> Thanks.

Thanks!

