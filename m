Return-Path: <bpf+bounces-56492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF5A98D49
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4D43B2C45
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5E27F4CA;
	Wed, 23 Apr 2025 14:36:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8B27CCD7;
	Wed, 23 Apr 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419002; cv=none; b=MfRf/77F2Qv4QD/6eM2F3cerNWBr7FnSYXJ23JhT6dVtwx6Ksmsj9fGHv4Aovp4mcc3bGcpTWkmNin1v4+2GvTOqQYTRagKLJp3gMgSWH2Hf3vJ+rtxybnsQmgUDMaRtqMSC5x4RvOZoWWBA/ioVGpUq0Atjmrs++vGNnl7YJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419002; c=relaxed/simple;
	bh=jXWH4gWpIEVt9GSvwo7tXrMiNKO8lNf34sBHJdv6D40=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=gwoQGPyPIEbfrDWamOsYAXX2dInhOLMUe8IbdbxK+8Kr4NFxDyOqBRfM9sPAJ0du/ugASnWFhDbcA7XZEYaNBe9JTwWqqYhib7RAEMxF5RSriOtSPnq0/iP/Kgya+9fefgDpLtidlAQn4YDYVwvj+PfIoFVJlZgEDKxAcRArLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1u7axS-000G3T-Eh; Wed, 23 Apr 2025 16:20:14 +0200
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1u7axS-000BTG-1f;
	Wed, 23 Apr 2025 16:20:14 +0200
Message-ID: <b06ede77-541b-453f-9e7a-79f3e5591f66@hetzner-cloud.de>
Date: Wed, 23 Apr 2025 16:20:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Jay Vosburgh
 <jv@jvosburgh.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
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
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
In-Reply-To: <aAEUcXIRnWolGWnA@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27617/Wed Apr 23 10:38:53 2025)

Am 17.04.25 um 16:47 schrieb Maciej Fijalkowski:
> On Fri, Apr 11, 2025 at 10:14:57AM +0200, Michal Kubiak wrote:
>> On Thu, Apr 10, 2025 at 04:54:35PM +0200, Marcus Wichelmann wrote:
>>> Am 10.04.25 um 16:30 schrieb Michal Kubiak:
>>>> On Wed, Apr 09, 2025 at 05:17:49PM +0200, Marcus Wichelmann wrote:
>>>>> Hi,
>>>>>
>>>>> in a setup where I use native XDP to redirect packets to a bonding interface
>>>>> that's backed by two ixgbe slaves, I noticed that the ixgbe driver constantly
>>>>> resets the NIC with the following kernel output:
>>>>>
>>>>>   ixgbe 0000:01:00.1 ixgbe-x520-2: Detected Tx Unit Hang (XDP)
>>>>>     Tx Queue             <4>
>>>>>     TDH, TDT             <17e>, <17e>
>>>>>     next_to_use          <181>
>>>>>     next_to_clean        <17e>
>>>>>   tx_buffer_info[next_to_clean]
>>>>>     time_stamp           <0>
>>>>>     jiffies              <10025c380>
>>>>>   ixgbe 0000:01:00.1 ixgbe-x520-2: tx hang 19 detected on queue 4, resetting adapter
>>>>>   ixgbe 0000:01:00.1 ixgbe-x520-2: initiating reset due to tx timeout
>>>>>   ixgbe 0000:01:00.1 ixgbe-x520-2: Reset adapter
>>>>>
>>>>> This only occurs in combination with a bonding interface and XDP, so I don't
>>>>> know if this is an issue with ixgbe or the bonding driver.
>>>>> I first discovered this with Linux 6.8.0-57, but kernel 6.14.0 and 6.15.0-rc1
>>>>> show the same issue.
>>>>>
>>>>>
>>>>> I managed to reproduce this bug in a lab environment. Here are some details
>>>>> about my setup and the steps to reproduce the bug:
>>>>>
>>>>> [...]
>>>>>
>>>>> Do you have any ideas what may be causing this issue or what I can do to
>>>>> diagnose this further?
>>>>>
>>>>> Please let me know when I should provide any more information.
>>>>>
>>>>>
>>>>> Thanks!
>>>>> Marcus
>>>>>
>>>>
>> [...]
>>
>> Hi Marcus,
>>
>>> thank you for looking into it. And not even 24 hours after my report, I'm
>>> very impressed! ;)
>>
>> Thanks! :-)
>>
>>> Interesting. I just tried again but had no luck yet with reproducing it
>>> without a bonding interface. May I ask how your setup looks like?
>>
>> For now, I've just grabbed the first available system with the HW
>> controlled by the "ixgbe" driver. In my case it was:
>>
>>   Ethernet controller: Intel Corporation Ethernet Controller X550
>>
>> Also, for my first attempt, I didn't use the upstream kernel - I just tried
>> the kernel installed on that system. It was the Fedora kernel:
>>
>>   6.12.8-200.fc41.x86_64
>>
>>
>> I think that may be the "beauty" of timing issues - sometimes you can change
>> just one piece in your system and get a completely different replication ratio.
>> Anyway, the higher the repro probability, the easier it is to debug
>> the timing problem. :-)
> 
> Hi Marcus, to break the silence could you try to apply the diff below on
> your side?

Hi, thank you for the patch. We've tried it and with your changes we can no
longer trigger the error and the NIC is no longer being reset.

> We see several issues around XDP queues in ixgbe, but before we
> proceed let's this small change on your side.

How confident are you that this patch is sufficient to make things stable enough
for production use? Was it just the Tx hang detection that was misbehaving for
the XDP case, or is there an underlying issue with the XDP queues that is not
solved by disabling the detection for it?

With our current setup we cannot verify accurately, that we have no packet loss 
or stuck queues. We can do additional tests to verify that. 
 
> Additional question, do you have enabled pause frames on your setup?

Pause frames were enabled, but we can also reproduce it after disabling them,
without your patch.

Thanks!
Marcus

