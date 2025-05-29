Return-Path: <bpf+bounces-59226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEEAC756A
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE65A410F6
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562C1AA7BF;
	Thu, 29 May 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SI9oJffr"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25661E4AE
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748482571; cv=none; b=blZbJ+sZScXuZkF+AlsIqXmo8tshugjJ3CbkBn3o5Lv5u8P9iNCM6gKSqzHfgesAP2MBaRRZBmQsx/ubBKrXbCbbRmUx1ByaEkvKkXN0hoPDRiNW6bJDE2y3kPYgFSOG236URqXjx9LK6hhJtunZQdW4YbvH7xD1FQsfUZzUVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748482571; c=relaxed/simple;
	bh=vqlhIQ+CCmN9RLqe0/Tyd2Y7ZpgweKpBe0mtM3DcFc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhSgjK/I5NnC1ahGnx2weu6rZJ/sT7WB2gkv03FHpnABn6ZXYc6xy5gDfkR7sa2cd+ZYS1/xgsEjZb3R21aKrf8mMWrcfGPdH5q25ESSDrvf0cxybw6M4myqzd2KH/yM3nuzK6GOAKEULPK/hbQAWQu+sSKBY/n0OEhVkGHSm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SI9oJffr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51768fa6-007e-4f30-ac1f-eed01ae1a3c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748482557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPvO5ea4bJ3AEPNPYkVWBmgC2/crRwDDiQRw7JYiRc0=;
	b=SI9oJffrQhJFzwVRI6hy+E981adGUz2hteYYf8fv/sQWmJIRMo03ZeEUEayJQ+OSmrRmQF
	aL9NacS00yCzFi3hTqHqhiFDvIg6tNPvYNsbL6ljM5L9GHmyrx+Ck8QTLLd5LilVp/5q6n
	PVLBXK9IeoWaseY3eISs0IaVaHE3LY4=
Date: Thu, 29 May 2025 09:35:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/28/25 8:04 AM, Abhishek Chauhan (ABC) 写道:
> 
> 
> On 2/7/2025 3:18 PM, Jitendra Vegiraju wrote:
>> Hi Abhishek,
>>
>> On Fri, Feb 7, 2025 at 10:21 AM Abhishek Chauhan (ABC) <
>> quic_abchauha@quicinc.com> wrote:
>>
>>>
>>>
>>> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
>>>> Hi netdev team,
>>>>
>>>> On Fri, Oct 18, 2024 at 1:53 PM <jitendra.vegiraju@broadcom.com> wrote:
>>>>>
>>>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>>>>
>>>>> This patchset adds basic PCI ethernet device driver support for Broadcom
>>>>> BCM8958x Automotive Ethernet switch SoC devices.
>>>>>
>>>>
>>>> I would like to seek your guidance on how to take this patch series
>>> forward.
>>>> Thanks to your feedback and Serge's suggestions, we made some forward
>>>> progress on this patch series.
>>>> Please make any suggestions to enable us to upstream driver support
>>>> for BCM8958x.
>>>
>>> Jitendra,
>>>           Have we resent this patch or got it approved ? I dont see any
>>> updates after this patch.
>>>
>>>
>> Thank you for inquiring about the status of this patch.
>> As stmmac driver is going through a maintainer transition, we wanted to
>> wait until a new maintainer is identified.
>> We would like to send the updated patch as soon as possible.
>> Thanks,
>> Jitendra
> Thanks Jitendra, I am sorry but just a follow up.
> 
> Do we know if stmmac maintainer are identified now ?

I'm curious why such a precondition is added？


Thanks,
Yanteng

