Return-Path: <bpf+bounces-57346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31AAA97F3
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EE8189A27E
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7C25E46E;
	Mon,  5 May 2025 15:51:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D01F9F70;
	Mon,  5 May 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460303; cv=none; b=tJR58gqIgrytrNtUq+UxNIuwMrO4Xgt5XRfYvPtT1+BQmn1PFPlQACRfVZWrzBbHreCff8UxSWZYn++iheX0wKKEsN4uxGV0NxwCc3r29uKB5vBxVG0y7d1hyi5tSauymNJTvVNJSYcH5t6yBQTyXkop19+7kD37/JyHwVk1Qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460303; c=relaxed/simple;
	bh=qHjAcr3nYJoV5hBvliPhfYmGgK0qY2hPpf/DNDCyw3w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cwbu9Ly9PngMEjaScWFvp7DMMK0hZD7JJOSIFSf0AUpEoWUfOCz+9zdH7InxALa4yJf3vpVuWHJj6Mx0lO6Ux6WexTKXWLPs+Dpw04SPbg85sAp3xIHLqxD4AFCvzpBoQznzB77vX/wDDpFD4zvxyk0VM4LqV0a9YgZXQ/LaSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1uBxep-000NE8-6S; Mon, 05 May 2025 17:23:03 +0200
Received: from [2003:f6:af22:6538:f6a8:dff:fe1e:4c1d]
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1uBxeo-0003en-0Z;
	Mon, 05 May 2025 17:23:02 +0200
Message-ID: <1713bf39-2bcb-4a43-94c7-a61ff97e2522@hetzner-cloud.de>
Date: Mon, 5 May 2025 17:23:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 sdn@hetzner-cloud.de
References: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
 <Z/fWHYETBYQuCno5@localhost.localdomain>
 <ff7ca6ea-a122-4d7d-9ef2-d091cbdd96d2@hetzner-cloud.de>
 <Z/jPgceDT4gRu9/R@localhost.localdomain> <aAEUcXIRnWolGWnA@boxer>
 <b06ede77-541b-453f-9e7a-79f3e5591f66@hetzner-cloud.de>
 <aAkz/+Rx5w3OHH4/@boxer>
 <eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de>
Content-Language: en-US
Autocrypt: addr=tobias.boehm@hetzner-cloud.de; keydata=
 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
 p0ms75naziM=
Organization: Hetzner Cloud GmbH
In-Reply-To: <eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: tobias.boehm@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)

Am 24.04.25 um 12:19 schrieb Tobias Böhm:
> Am 23.04.25 um 20:39 schrieb Maciej Fijalkowski:
>> On Wed, Apr 23, 2025 at 04:20:07PM +0200, Marcus Wichelmann wrote:
>>> Am 17.04.25 um 16:47 schrieb Maciej Fijalkowski:
>>>> On Fri, Apr 11, 2025 at 10:14:57AM +0200, Michal Kubiak wrote:
>>>>> On Thu, Apr 10, 2025 at 04:54:35PM +0200, Marcus Wichelmann wrote:
>>>>>> Am 10.04.25 um 16:30 schrieb Michal Kubiak:
>>>>>>> On Wed, Apr 09, 2025 at 05:17:49PM +0200, Marcus Wichelmann wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> in a setup where I use native XDP to redirect packets to a 
>>>>>>>> bonding interface
>>>>>>>> that's backed by two ixgbe slaves, I noticed that the ixgbe 
>>>>>>>> driver constantly
>>>>>>>> resets the NIC with the following kernel output:
>>>>>>>>
>>>>>>>>    ixgbe 0000:01:00.1 ixgbe-x520-2: Detected Tx Unit Hang (XDP)
>>>>>>>>      Tx Queue             <4>
>>>>>>>>      TDH, TDT             <17e>, <17e>
>>>>>>>>      next_to_use          <181>
>>>>>>>>      next_to_clean        <17e>
>>>>>>>>    tx_buffer_info[next_to_clean]
>>>>>>>>      time_stamp           <0>
>>>>>>>>      jiffies              <10025c380>
>>>>>>>>    ixgbe 0000:01:00.1 ixgbe-x520-2: tx hang 19 detected on queue 
>>>>>>>> 4, resetting adapter
>>>>>>>>    ixgbe 0000:01:00.1 ixgbe-x520-2: initiating reset due to tx 
>>>>>>>> timeout
>>>>>>>>    ixgbe 0000:01:00.1 ixgbe-x520-2: Reset adapter
>>>>>>>>
>>>>>>>> This only occurs in combination with a bonding interface and 
>>>>>>>> XDP, so I don't
>>>>>>>> know if this is an issue with ixgbe or the bonding driver.
>>>>>>>> I first discovered this with Linux 6.8.0-57, but kernel 6.14.0 
>>>>>>>> and 6.15.0-rc1
>>>>>>>> show the same issue.
>>>>>>>>
>>>>>>>>
>>>>>>>> I managed to reproduce this bug in a lab environment. Here are 
>>>>>>>> some details
>>>>>>>> about my setup and the steps to reproduce the bug:
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>> Do you have any ideas what may be causing this issue or what I 
>>>>>>>> can do to
>>>>>>>> diagnose this further?
>>>>>>>>
>>>>>>>> Please let me know when I should provide any more information.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>> Marcus
>>>>>>>>
>>>>>>>
>>>>> [...]
>>>>>
>>>>> Hi Marcus,
>>>>>
>>>>>> thank you for looking into it. And not even 24 hours after my 
>>>>>> report, I'm
>>>>>> very impressed! ;)
>>>>>
>>>>> Thanks! :-)
>>>>>
>>>>>> Interesting. I just tried again but had no luck yet with 
>>>>>> reproducing it
>>>>>> without a bonding interface. May I ask how your setup looks like?
>>>>>
>>>>> For now, I've just grabbed the first available system with the HW
>>>>> controlled by the "ixgbe" driver. In my case it was:
>>>>>
>>>>>    Ethernet controller: Intel Corporation Ethernet Controller X550
>>>>>
>>>>> Also, for my first attempt, I didn't use the upstream kernel - I 
>>>>> just tried
>>>>> the kernel installed on that system. It was the Fedora kernel:
>>>>>
>>>>>    6.12.8-200.fc41.x86_64
>>>>>
>>>>>
>>>>> I think that may be the "beauty" of timing issues - sometimes you 
>>>>> can change
>>>>> just one piece in your system and get a completely different 
>>>>> replication ratio.
>>>>> Anyway, the higher the repro probability, the easier it is to debug
>>>>> the timing problem. :-)
>>>>
>>>> Hi Marcus, to break the silence could you try to apply the diff 
>>>> below on
>>>> your side?
>>>
>>> Hi, thank you for the patch. We've tried it and with your changes we 
>>> can no
>>> longer trigger the error and the NIC is no longer being reset.
>>>
>>>> We see several issues around XDP queues in ixgbe, but before we
>>>> proceed let's this small change on your side.
>>>
>>> How confident are you that this patch is sufficient to make things 
>>> stable enough
>>> for production use? Was it just the Tx hang detection that was 
>>> misbehaving for
>>> the XDP case, or is there an underlying issue with the XDP queues 
>>> that is not
>>> solved by disabling the detection for it?
>>
>> I believe that correct way to approach this is to move the Tx hang
>> detection onto ixgbe_tx_timeout() as that is the place where this logic
>> belongs to. By doing so I suppose we would kill two birds with one stone
>> as mentioned ndo is called under netdev watchdog which is not a subject
>> for XDP Tx queues.
>>
>>>
>>> With our current setup we cannot verify accurately, that we have no 
>>> packet loss
>>> or stuck queues. We can do additional tests to verify that.
> 
> 
> Hi Maciej,
> 
> I'm a colleague of Marcus and involved in the testing as well.
>>>> Additional question, do you have enabled pause frames on your setup?
>>>
>>> Pause frames were enabled, but we can also reproduce it after 
>>> disabling them,
>>> without your patch.
>>
>> Please give your setup a go with pause frames enabled and applied patch
>> that i shared previously and let us see the results. As said above I do
>> not think it is correct to check for hung queues in Tx descriptor 
>> cleaning
>> routine. This is a job of ndo_tx_timeout callback.
>>
> 
> We have tested with pause frames enabled and applied patch and can not 
> trigger the error anymore in our lab setup.
> 
>>>
>>> Thanks!
>>
>> Thanks for feedback and testing. I'll provide a proper fix tomorrow 
>> and CC
>> you so you could take it for a spin.
>>
> 
> That sounds great. We'd be happy to test with the proper fix in our 
> original setup.

Hi,

During further testing with this patch applied we noticed new warnings 
that show up. We've also tested with the new patch sent ("[PATCH 
iwl-net] ixgbe: fix ndo_xdp_xmit() workloads") and see the same warnings.

I'm sending this observation to this thread because I'm not sure if it 
is related to those patches or if it was already present but hidden by 
the resets of the original issue reported by Marcus.

After processing test traffic (~10kk packets as described in Marcus' 
reproducer setup) and idling for a minute the following warnings keep 
being logged as long as the NIC idles:

   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 
60 sec
   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 
60 sec
   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 
120 sec
   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 
120 sec
   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 
181 sec
   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 
181 sec
   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 
241 sec
   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 
241 sec

Just sending a single packet makes the warnings stop being logged.

After sending heavy test traffic again new warnings start to be logged 
after a minute of idling:

   page_pool_release_retry() stalled pool shutdown: id 987, 2 inflight 
60 sec
   page_pool_release_retry() stalled pool shutdown: id 979, 2 inflight 
60 sec
   page_pool_release_retry() stalled pool shutdown: id 987, 2 inflight 
120 sec
   page_pool_release_retry() stalled pool shutdown: id 979, 2 inflight 
120 sec

Detaching the XDP program stops the warnings as well.

As before pause frames were enabled.

Just like with the original issue we were not always successful to 
reproduce those warnings. With more traffic chances seem to be higher to 
trigger it.

Please let me know if I should provide any further information.

Thanks,
Tobias

