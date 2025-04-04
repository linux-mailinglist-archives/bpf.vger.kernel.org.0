Return-Path: <bpf+bounces-55320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB7A7B994
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3123BC9BA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017B1A2860;
	Fri,  4 Apr 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a1xOuNoT"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E819D8BC;
	Fri,  4 Apr 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757411; cv=none; b=RJNAr7FBt++NgWuOhzGR9bcXCr7y+N+znUsZWwbskgNiYNUtQ1VG4CaGdYz++y0ib9pkZouFZiK2zfDgXAlK5HaQahRhqjiQv4LyPhatz50DumJAIuyCfeZQe49S+3Ldg8gxzrV3R71hKu2SdextX0XDO52X2PZGXY26wNeCn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757411; c=relaxed/simple;
	bh=08remofodMl9NndC97QoQQcun+/9trhhteGAAv+OQ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JwatXotCNyLrm9Eo9C6uyUAEwVi/fQX2ykRw73W1DbXvku/g8xQKqPrSScUZaK4wSwQ0tfxdlhyA0EQ/O1JGv7uj2Vv0/HxtFivPtDSysdFPriOZ+1hJNnnKyIs60ZOzHt6GdzbecEjWqGp4MBkSzfCV/4M2o1NSNtMIQMi+Lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a1xOuNoT; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53492efm3905742
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Apr 2025 04:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743757360;
	bh=9r3rjhSZYe9kTQKj1A2IGsaMEllubj0HxqoQkvuRJWA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=a1xOuNoTOoGYlZq8rwTVaFTaCB9vZW/Pr91RqeQ5DLIC7EI/3kJgwJYpt/m3CcAF2
	 8tNw1JqKIhy9HKS2uItCSiGMsnqUxO23c9kCfumfDatr/a2sBfu91H1vlwu+RKXZFJ
	 5shN6Sh448Drw63Gu7dCbf87KyHnkZj0lEPv/X3g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53492enC068812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Apr 2025 04:02:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Apr 2025 04:02:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Apr 2025 04:02:39 -0500
Received: from [172.24.23.235] (lt9560gk3.dhcp.ti.com [172.24.23.235])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53492XVJ083733;
	Fri, 4 Apr 2025 04:02:34 -0500
Message-ID: <fccd824b-58dc-4ab1-91c0-77c2436914c9@ti.com>
Date: Fri, 4 Apr 2025 14:32:33 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        <dan.carpenter@linaro.org>, <kuba@kernel.org>, <edumazet@google.com>,
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
 <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
 <469fd8d0-c72e-4ca6-87a9-2f42b180276b@redhat.com>
 <58d26423-04da-4491-9318-d4a7a1f12005@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <58d26423-04da-4491-9318-d4a7a1f12005@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Roger,

On 4/4/2025 1:17 PM, Roger Quadros wrote:
> 
> 
> On 03/04/2025 14:25, Paolo Abeni wrote:
>> On 4/2/25 2:37 PM, Malladi, Meghana wrote:
>>> On 4/2/2025 5:58 PM, Roger Quadros wrote:
>>>> On 28/03/2025 12:24, Meghana Malladi wrote:
>>>>> ICSS IEP driver has flags to check if perout or pps has been enabled
>>>>> at any given point of time. Whenever there is request to enable or
>>>>> disable the signal, the driver first checks its enabled or disabled
>>>>> and acts accordingly.
>>>>>
>>>>> After bringing the interface down and up, calling PPS/perout enable
>>>>> doesn't work as the driver believes PPS is already enabled,
>>>>
>>>> How? aren't we calling icss_iep_pps_enable(iep, false)?
>>>> wouldn't this disable the IEP and clear the iep->pps_enabled flag?
>>>>
>>>
>>> The whole purpose of calling icss_iep_pps_enable(iep, false) is to clear
>>> iep->pps_enabled flag, because if this flag is not cleared it hinders
>>> generating new pps signal (with the newly loaded firmware) once any of
>>> the interfaces are up (check icss_iep_perout_enable()), so instead of
>>> calling icss_iep_pps_enable(iep, false) I am just clearing the
>>> iep->pps_enabled flag.
>>
>> IDK what Roger thinks, but the above is not clear to me. I read it as
>> you are stating that icss_iep_pps_enable() indeed clears the flag, so i
>> don't see/follow the reasoning behind this change.
>>
>> Skimmir over the code, icss_iep_pps_enable() could indeed avoid clearing
>> the flag under some circumstances is that the reason?
>>
>> Possibly a more describing commit message would help.
> 
> I would expect that modifying the xxx_enabled flag should be done only
> in the icss_iep_xxx_enable() function. Doing it anywhere else will be difficult
> to track/debug in the long term.
> 

There is no problem with calling icss_iep_pps_enable() for clearing the 
pps_enable flag. Problem comes with icss_iep_perout_enable(), causing 
null pointer dereference for the NULL perout request argument we are 
passing just for clearing the perout_enable flag.

> I don't see why the flag needs to be set anywhere else. Maye better to
> improve logic inside icss_iep_pps_enable() like Paolo suggests.
> 

Ok, one thing I can do is create a ptp_perout_request to disable perout 
instead of passing NULL to icss_iep_perout_enable(). What are your 
thoughts on this ?

>>
>>>> And, what if you brought 2 interfaces of the same ICSS instances up
>>>> but put only 1 interface down and up?
>>>>
>>>
>>> Then the flag need not be disabled if only one interface is brought down
>>> because the IEP is still alive and all the IEP configuration (including
>>> pps/perout) is still valid.
>>
>> I read the above as stating this fix is not correct in such scenario,
>> leading to the wrong final state.
>>
>> I think it would be better to either give a better reasoning about this
>> change in the commit message or refactor it to handle even such scenario,
>>
>> Thanks,
>>
>> Paolo
>>
> 


