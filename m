Return-Path: <bpf+bounces-59272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCAAC7784
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 07:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064EC3AA257
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C44253B64;
	Thu, 29 May 2025 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ObYYFteh"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D61253939
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495737; cv=none; b=Pjd6kgg28YBJ5T424RUShlF91sOc2OZoll3QrT3CRmq5xowA4RjtNpRoPFkE7B3cGqOPoVh7aLjA5m2rlAudR8QFqMD9mvjGYY0CE5M9UXAh9lC5w49xJiUyEENTLNuEVI7f74BHXSE8WXqP4TEkgtOOTAPfKmOpOLOVFBk9K2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495737; c=relaxed/simple;
	bh=6uzPCgDCXAss+gj9Kg5Yei58AazKHO/YAsRvsFALGvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZvxTiWk16Kqf+ZS/sobuVj1i3wMfOhbCm1+xMvGvgxjOrPLRh9ZaTEUHV5GXYti3YOasxikZ5V/0mmGQ0W9CKhlrXC0JSqAXzaZ8EAPyoWCH/gfMFpQbC58MgXy/uCORxlQd1dBdALQgBpUA7F1oHTzdFvgMcPm7EjumV65/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ObYYFteh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb591c65-0106-45f4-9e57-434dac54e923@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748495722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Pk1Eb2vSHZbYbbZLyo5U1NwioDIXYgsUp9ezTkNplY=;
	b=ObYYFtehliQgfdv9YsufkQYdreAjIYc0E64+xUmOXpyZAGLUi3KQ5qjBDKGKhGQbr2gXbl
	+Ckk8pCdISYyqIC+bjZEqZ7+pMCxl2Ism9o12gOkQVTM0OVV0O9pH/x0Izj/T+Ru3xfAPq
	s7AfyOVLoGxpdbAhyE7WWpwl1QlON9Q=
Date: Thu, 29 May 2025 13:14:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, fancer.lancer@gmail.com, ahalaney@redhat.com,
 xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
 Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com,
 Sagar Cheluvegowda <quic_scheluve@quicinc.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
 <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
 <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
 <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
 <51768fa6-007e-4f30-ac1f-eed01ae1a3c5@linux.dev>
 <CAMdnO-KNfH79PG1=21Dbyaart2JN_e1XcF+tTG93BG5BobX+Gg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAMdnO-KNfH79PG1=21Dbyaart2JN_e1XcF+tTG93BG5BobX+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 5/29/25 10:56 AM, Jitendra Vegiraju 写道:
> Hi Yanteng,
>
> On Wed, May 28, 2025 at 6:36 PM Yanteng Si <si.yanteng@linux.dev> wrote:
>> 在 5/28/25 8:04 AM, Abhishek Chauhan (ABC) 写道:
>>>
>>> On 2/7/2025 3:18 PM, Jitendra Vegiraju wrote:
>>>> Hi Abhishek,
>>>>
>>>> On Fri, Feb 7, 2025 at 10:21 AM Abhishek Chauhan (ABC) <
>>>> quic_abchauha@quicinc.com> wrote:
>>>>
>>>>>
>>>>> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
>>>>>> Hi netdev team,
>>>>>>
>>>>>> On Fri, Oct 18, 2024 at 1:53 PM <jitendra.vegiraju@broadcom.com> wrote:
>>>>>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>>>>>>
>>>>>>> This patchset adds basic PCI ethernet device driver support for Broadcom
>>>>>>> BCM8958x Automotive Ethernet switch SoC devices.
>>>>>>>
>>>>>> I would like to seek your guidance on how to take this patch series
>>>>> forward.
>>>>>> Thanks to your feedback and Serge's suggestions, we made some forward
>>>>>> progress on this patch series.
>>>>>> Please make any suggestions to enable us to upstream driver support
>>>>>> for BCM8958x.
>>>>> Jitendra,
>>>>>            Have we resent this patch or got it approved ? I dont see any
>>>>> updates after this patch.
>>>>>
>>>>>
>>>> Thank you for inquiring about the status of this patch.
>>>> As stmmac driver is going through a maintainer transition, we wanted to
>>>> wait until a new maintainer is identified.
>>>> We would like to send the updated patch as soon as possible.
>>>> Thanks,
>>>> Jitendra
>>> Thanks Jitendra, I am sorry but just a follow up.
>>>
>>> Do we know if stmmac maintainer are identified now ?
>> I'm curious why such a precondition is added？
>>
> It's not a precondition. Let me give some context.
> This patch series adds support for a new Hyper DMA(HDMA) MAC from Synopsis.
> Many of the netdev community members reviewed the patches at that time.
> Being the module maintainer at that time, Serge took the initiative to
> guide us through integrating the new MAC into the stmmac driver.
> We addressed all the review comments and submitted the last patch series.
> Without an official maintainer, we didn't get feedback on the last patch series.
> Because of this, we wanted to wait until a new maintainer is assigned
> to this module.
> As Abhishek expressed in his email, it appears the HDMA MAC is
> becoming more mainstream.
> We are hoping to rebase the patch series and resubmit for review if
> netdev team members show interest.


https://lore.kernel.org/netdev/20241018205332.525595-1-jitendra.vegiraju@broadcom.com/

In my opinion, the precondition for waiting for a maintainer is that

the patch set has passed the review. I checked lore and did not find

any R&B tags in the patch set, which means your patch set has not

yet met the merging requirements.

Therefore, I think you can continue to push forward with this patch

set and not let it stagnate. I will take some time to review the previous

versions (which may take a while) and hope to be helpful.

Thanks,

Yanteng

> Thanks,
> Jitendra
>> Thanks,
>> Yanteng

