Return-Path: <bpf+bounces-66185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB69B2F59C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12867A4C36
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94789307AFC;
	Thu, 21 Aug 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kvtVQWY4"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD93307AD5;
	Thu, 21 Aug 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773352; cv=none; b=JB7TnT99V9L1b6b1/w/H5TJru9nhFkE95cW10Tbh1vL/KDq8ESrU/KsnFtjrlDY+f5fRxT2lfxvBoX1sIqwVt0Wu19++8V3HCyJEOfo5SB0UmfugJmtbxtkxcLBrJzAG8mQA/fP0yEUiFektcpMZ+tiFEnm1AiH9y0ch3F4DbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773352; c=relaxed/simple;
	bh=rG5esXl5MyyU9ccbkRzn255OdRwlFHNiQdQoQp112nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rVOdyLNEHUyZjwcVKgkqePmyzga3zY1yQ73Mq22IxFJD02z7RU03CKsNr5jDGXPP3gE6uuoRHsWba1G2ySUCI29LDlu7ypEKSrT7ugt7+lSGJUc5HAdKjRNROewVa9gtN291uflANujAN8UJ2jzC+nsrYT+Mnl3uzTXOnSYsqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kvtVQWY4; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LAmFE23352350;
	Thu, 21 Aug 2025 05:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755773295;
	bh=ZdcQq0ODeLvFcyZ8c1y1bdz85c9KQB/TPqgiMZRTnJo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kvtVQWY40B45uP1NmaZBuN+EuM78tEdP7xLQ47B+vp4LKGI78Io5SaBPkCqJ+Z+wV
	 W8nk7I5i+I3rRLA8ddtPkKMkx9rO/yrAOGXKsHUHmjnGXGEX2mXXHw6gFAdzq63b5a
	 +RcjA8x5Rb48WrKrmNNPxDoweF4ily0EFQPOIJTE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LAmFl81899798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 05:48:15 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 05:48:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 05:48:14 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LAm7OG2038086;
	Thu, 21 Aug 2025 05:48:08 -0500
Message-ID: <d2015724-416b-4222-aa85-88c0c5f9160c@ti.com>
Date: Thu, 21 Aug 2025 16:18:07 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: ti: icssg-prueth: Add AF_XDP zero copy
 for RX
To: Jakub Kicinski <kuba@kernel.org>
CC: <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250818112424.3068643-1-m-malladi@ti.com>
 <20250818112424.3068643-6-m-malladi@ti.com>
 <20250819073558.2c996b6d@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20250819073558.2c996b6d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 8/19/25 20:05, Jakub Kicinski wrote:
> On Mon, 18 Aug 2025 16:54:23 +0530 Meghana Malladi wrote:
>> @@ -1332,6 +1350,13 @@ static int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
>>   		}
>>   	}
>>   
>> +	if (flags & XDP_WAKEUP_RX) {
>> +		if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
>> +			if (likely(napi_schedule_prep(&emac->napi_rx)))
>> +				__napi_schedule(&emac->napi_rx);
>> +		}
>> +	}
>> +
>>   	return 0;
> 
> I suspect this series is generated against old source or there's
> another conflicting series in flight, because git ends up applying
> this chunk to prueth_xsk_pool_disable() :S
> 

That's interesting. I have directly applied these patches locally on the 
tip of net-next (62a2b3502573 "net: openvswitch: Use for_each_cpu() 
where appropriate") And everything gets applied cleanly and I couldn't 
reproduce the issue you mentioned above. Can you tell me on top of which 
commit you tried applying this series ? Or I wonder if this happened 
because I posted this series from my net tree instead of net-next. Does 
it make sense to re-post the same patches from net-next tree ?

> Before you proceed with AF_XDP could you make this driver build under
> COMPILE_TEST on x86? This is very easy to miss, luckily we got an off
> list report but its pure luck. And obviously much more effort for the
> maintainers to investigate than if it was caught by the CI.

I have tried what you have suggested and these are the logs for the 
same: 
https://gist.github.com/MeghanaMalladiTI/8a3f64773d96e58aec48aca78c1bc98c

ICSSG driver as a module has been compiled without any errors but 
encountered few linking errors due to some missing symbols from another 
module (CONFIG_TI_K3_UDMA). I included this module in the next iteration 
and tried compiling but facing some build failures, logs: 
https://gist.github.com/MeghanaMalladiTI/f7ed3958b5ab2b2be479151254015ff0

I think it is safe to assume ICSSG as a driver build on x86 doesn't have 
build regressions, thoughts ? Also is this something which needs to be 
done by us everytime we are posting some feature upstream or does Kernel 
CI take care of it ?


