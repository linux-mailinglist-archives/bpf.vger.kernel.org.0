Return-Path: <bpf+bounces-49574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088AA1A397
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D98163BC9
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17220F060;
	Thu, 23 Jan 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PIQTGdD0"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA729B0;
	Thu, 23 Jan 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633067; cv=none; b=KI+LFRLr1gluFaHw0q91wgiqEalpLR51TVTkkKMWEXEMzK59XA6baguPYCvyyK/Vt2RutFFgvc5LhM+RAgXSSiMEZJkAYxGydpkB+0QSkYayvjJw99/0FmUV4VY7CWKNIKdPK7Uo/aL11dOZzM3d4uroEKOA004VI7THUA7Csmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633067; c=relaxed/simple;
	bh=alOHbp1ghKH8XHuwSZ8JYmTr6m68l+UY4qmDmMM0ijA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MHwPbNK5gsawBfHOr3orxffB4vYqGNlVdj+gyRHrI5CTGmuq47u8sT3Sh/sAYI9wwskEMu1qz2FjWSHCPpgg1eWpbq/BOjDc4/3R4nxlv5RBkz3K03reTpcfglvYamZ70xOERChQUioLSAhPqpnVbh1ohRRQvsYVtSDVjuFW9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PIQTGdD0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50NBoEvq1193662
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 05:50:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737633014;
	bh=BMsgE4cTOvGu1oHN2jPXinLwurlF8Y91utoENFVkqYo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PIQTGdD0zerWx/dHLYjUCcDjoAEz+GBDXpI17vGfhHrA5NGrmok0w438APiNoBOAg
	 8jsc/s+7p0tdHxD2E2GmKW3gldTWSZb2VfHhqt6CBqjGuw1Sm/XfGPytf0pY5K8DWn
	 KdBAJkHHnBLXuIvaPABQA5nXPo0kZ6FCLByvTRRY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50NBoED8054261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jan 2025 05:50:14 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Jan 2025 05:50:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Jan 2025 05:50:14 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50NBo7bw107089;
	Thu, 23 Jan 2025 05:50:08 -0600
Message-ID: <f1bdd422-5034-4390-95b1-36cd04109fb3@ti.com>
Date: Thu, 23 Jan 2025 17:20:07 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] Add native mode XDP support
To: Simon Horman <horms@kernel.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <dan.carpenter@linaro.org>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122131341.GH390877@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20250122131341.GH390877@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 22/01/25 18:43, Simon Horman wrote:
> On Wed, Jan 22, 2025 at 06:19:48PM +0530, Meghana Malladi wrote:
>> This series adds native XDP support using page_pool.
>> XDP zero copy support is not included in this patch series.
>>
>> Patch 1/3: Replaces skb with page pool for Rx buffer allocation
>> Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
>> Patch 3/3: Introduces native mode XDP support
> 
> Hi Meghana,
> 
> Unless I am mistaken this patchset should be targeted at net-next,
> as a new feature, rather than net, as bug fixes.
> 

Yes Indeed. Thanks for pointing this to me. I will be more vigilant next 
time I am posting to avoid such mistakes. :)

> With that in mind:
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.14 has begun. Therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after Feb 3rd.
> 

My bad for not checking this before posting. I will re-post it after Feb 
3rd. Thanks a lot.

> RFC patches sent for review only are obviously welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> 
> --
> pw-bot: deferred

