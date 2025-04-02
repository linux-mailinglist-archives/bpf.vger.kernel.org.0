Return-Path: <bpf+bounces-55156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7094A78EB7
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933A37A5687
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5923BD1A;
	Wed,  2 Apr 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gDeoq9iu"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757823BCF2;
	Wed,  2 Apr 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597505; cv=none; b=WDVMCJ7cOqeUgZw53CvOa8iyp2ol/RIYDOSuDNgu+8PbKv27E4geEnVtcSFAA+JW1p52o/Xrs3erz/T7wYCky6yLn3f7Rv+sP8wwK1tHC5JchR3wxLZ9lpFV0oiEoeu6GZqiBabGeUtCsnpR8DIjM+FLup04rQN7rtuoJ/R4l/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597505; c=relaxed/simple;
	bh=dTjL5EFXoS0czJKKji+k4G9YaMQT5DMND5Dnr5uRJm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jgTyGYoyUuDtL+QbDSwFubVN6x7qOgquQsquD41/dwVKZU7KgIHgiCpN72oem0Eadw4yEyZ/AyCYKfmn4eWWhr3yNL0oLteD2jPiTDhy3/RUD518WNZkwRSKBNWEc91BeJNMb3E4ue9Aukrc15rv9b7uj9ZTwdwFHSIDROpgDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gDeoq9iu; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 532CbN0f3241854
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 07:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743597443;
	bh=4qOoA3LVJAeCTkVPfMbm4Vm9pRsN9xHcsiNmubFd1nM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gDeoq9iu0w5moioITpXaWzK1YWwZkMwmmrVhnKQM60yYkUx9zFlXdUoaRrIxuyxu3
	 0876/n+IAnhhIimjd/X49IGjjUrJI6o8G7PgO1bG3dvYdb7f1qXxe2mE+yFca+Nd9p
	 4qa2UqZOzY1pOof5+dgSWzCV+YknEskwRNCJ363U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 532CbNrc019560
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Apr 2025 07:37:23 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Apr 2025 07:37:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Apr 2025 07:37:22 -0500
Received: from [172.24.17.211] (lt9560gk3.dhcp.ti.com [172.24.17.211])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 532CbGDp101576;
	Wed, 2 Apr 2025 07:37:17 -0500
Message-ID: <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
Date: Wed, 2 Apr 2025 18:07:15 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: Roger Quadros <rogerq@kernel.org>, <dan.carpenter@linaro.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <namcao@linutronix.de>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <danishanwar@ti.com>
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-4-m-malladi@ti.com>
 <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 4/2/2025 5:58 PM, Roger Quadros wrote:
> Meghana,
> 
> On 28/03/2025 12:24, Meghana Malladi wrote:
>> ICSS IEP driver has flags to check if perout or pps has been enabled
>> at any given point of time. Whenever there is request to enable or
>> disable the signal, the driver first checks its enabled or disabled
>> and acts accordingly.
>>
>> After bringing the interface down and up, calling PPS/perout enable
>> doesn't work as the driver believes PPS is already enabled,
> 
> How? aren't we calling icss_iep_pps_enable(iep, false)?
> wouldn't this disable the IEP and clear the iep->pps_enabled flag?
> 

The whole purpose of calling icss_iep_pps_enable(iep, false) is to clear 
iep->pps_enabled flag, because if this flag is not cleared it hinders 
generating new pps signal (with the newly loaded firmware) once any of 
the interfaces are up (check icss_iep_perout_enable()), so instead of 
calling icss_iep_pps_enable(iep, false) I am just clearing the 
iep->pps_enabled flag.

> And, what if you brought 2 interfaces of the same ICSS instances up
> but put only 1 interface down and up?
> 

Then the flag need not be disabled if only one interface is brought down 
because the IEP is still alive and all the IEP configuration (including 
pps/perout) is still valid.

please refer for more details: 
https://lore.kernel.org/all/20241211135941.1800240-1-m-malladi@ti.com/

>> (iep->pps_enabled is not cleared during interface bring down)
>> and driver will just return true even though there is no signal.
>> Fix this by setting pps and perout flags to false instead of
>> disabling perout to avoid possible null pointer dereference.
>>
>> Fixes: 9b115361248d ("net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>
>> Changes from v2(v3-v2):
>> - Add Reported-by tag and link to the bug reported by Dan Carpenter <dan.carpenter@linaro.org>
>> - drop calling icss_iep_perout_enable() for disabling perout and set perout to false instead
>>
>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index b4a34c57b7b4..b70e4c482d74 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -820,9 +820,9 @@ int icss_iep_exit(struct icss_iep *iep)
>>   	icss_iep_disable(iep);
>>   
>>   	if (iep->pps_enabled)
>> -		icss_iep_pps_enable(iep, false);
>> +		iep->pps_enabled = false;
>>   	else if (iep->perout_enabled)
>> -		icss_iep_perout_enable(iep, NULL, false);
>> +		iep->perout_enabled = false;
>>   
>>   	return 0;
>>   }
> 


