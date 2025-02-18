Return-Path: <bpf+bounces-51825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F96A39C22
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2BC166446
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76225241C84;
	Tue, 18 Feb 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EWO1en5z"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17E9479;
	Tue, 18 Feb 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881753; cv=none; b=Wums2w867m61NE+1zp9jhiX7fK+S8yJ7Vi+BBbS57vCG9p3XX3I40JTTWq+xXIGUjwTbcVT85C4Cjya18dlADKYtAKjpyM3kB+4c/B8hMjPf5Qve8bT9+kpSZsRBdAr0njt4yKyStg3y8zo9Ruo2cIhWCNlYn0aMqUbNCLELSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881753; c=relaxed/simple;
	bh=efmpp9iVcKx6fv05L3Xyb5BwKMnnItOAh1S/HkWfiVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WrohTGnTW20xE2/+6/KtPGL7jlRlBFEmJR8XnJWLuRlJc0lLgZ1Gxyq+MFVXPM7lEi3xIINXLD+avjHDNhim9JGhbcWUPQULsZyUP2MMKPxoMel8YrHWVf6rvY2o1h7H6LaslY49uNfNypfmpuTmRe7wJZrA0v2W1zKbzoj0seU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EWO1en5z; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ICSafl1670795
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 06:28:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739881716;
	bh=SGEjmL6AiEaHGdfRsy6AnNrW7FJmxRmggnhRMW4Zow0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EWO1en5zq8n48cQ7K/SNm/cWwkLYpAsYEFSKDuKUnCZqj/sR5zBrFl5R/+ERQ5hYN
	 SY8+qykzvzgQq0iUOjy7WUSJ3azkEvoD+cd4lJgbUW1seHxtZrtAgUc9C7VRoVGJQR
	 NYP0saM4W5NLD+Y2FkRiRjHC5HQZx7wk7GF5d+Jw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ICSacM070600
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 06:28:36 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 06:28:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 06:28:35 -0600
Received: from [172.24.20.199] (lt9560gk3.dhcp.ti.com [172.24.20.199])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ICSSYE102530;
	Tue, 18 Feb 2025 06:28:28 -0600
Message-ID: <94425bfd-7f2b-4fc4-86f8-a56e56173d22@ti.com>
Date: Tue, 18 Feb 2025 17:58:27 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Use
 page_pool API for RX buffer allocation
To: Diogo Ivo <diogo.ivo@siemens.com>, Roger Quadros <rogerq@kernel.org>,
        <danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <schnelle@linux.ibm.com>,
        <glaroque@baylibre.com>, <rdunlap@infradead.org>,
        <jan.kiszka@siemens.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
 <20250210103352.541052-2-m-malladi@ti.com>
 <152b032e-fcd9-4d49-8154-92a475c0670c@kernel.org>
 <615a2e1f-5ee5-4d80-a499-8ff06596a2fc@ti.com>
 <c8bdd93d-5690-4b8a-819f-853756b57a71@siemens.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <c8bdd93d-5690-4b8a-819f-853756b57a71@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Diogo,

On 2/18/2025 5:54 PM, Diogo Ivo wrote:
> Hi Meghana, On 2/18/25 10: 10 AM, Malladi, Meghana wrote: > On 2/12/2025 
> 7: 26 PM, Roger Quadros wrote: >> Can we get rid of SKB entirely from 
> the management channel code? >> The packet received on this channel is 
> never passed to
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uvdgfB3F_Ow7QIXEnBKj3ybYT8I9yL0CM5RLkel44YW99zMeqk_TnCBkOwR0q45N5dLjtBz49EalJyUJ1-U1lPk6DIBve_3-$>
> ZjQcmQRYFpfptBannerEnd
> 
> Hi Meghana,
> 
> On 2/18/25 10:10 AM, Malladi, Meghana wrote:
>> On 2/12/2025 7:26 PM, Roger Quadros wrote:
>>> Can we get rid of SKB entirely from the management channel code?
>>> The packet received on this channel is never passed to user space so
>>> I don't see why SKB is required.
>>>
>> 
>> Yes I do agree with you on the fact the SKB here is not passed to the 
>> network stack, hence this is redundant. But honestly I am not sure how 
>> that can be done, because the callers of this function access skb->data
>> from the skb which is returned and the same can't be done with page (how 
>> to pass the same data using page?)
>> Also as you are aware we are not currently supporting SR1 devices 
>> anymore, hence I don't have any SR1 devices handy to test these changes 
>> and ensure nothing is broken if I remove SKB entirely.
> 
> I have some SR1 devices available and would be happy to test these
> proposed changes in case they are feasible.
> 

That's awesome. Once the changes have been aligned with Roger, I will 
share the changes with you for testing before posting v3. Thanks for 
your support.

> Best regards,
> Diogo
> 


