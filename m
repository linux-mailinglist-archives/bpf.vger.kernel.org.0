Return-Path: <bpf+bounces-54844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92AA743F7
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 07:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0793D1799CB
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C32116FA;
	Fri, 28 Mar 2025 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gaRT3A2Z"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F821146D;
	Fri, 28 Mar 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743142651; cv=none; b=jmxSAZwCtGwpaWwJSk6ZRXMaut9fx48qOi4ucCW/kFLqReVHGygqVogVwArFPHgr4OCfth8C9NeOUvEELCLLaOzaXrMeIOUhtu02x52kBYAqrKvsSwWy8/riL/0wRClcIPXxQUo1gOVwVBl1YOllaAOvOE5YgjLI4rpHFr6kb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743142651; c=relaxed/simple;
	bh=+fhEr0vDM02scp3GYE0YAIaxvDoHZ7a1vdchyMIRHmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1g2hKYbIOWbeXfxevAREu6nJmUIS7WaxNhI3VkN7gfFspVZLoy/gTydVT1mwnspaKoI5kESRKJx58JtLTi1wTy2LtBjwBfBl1ou6qwRT7Me154PHQAfgeaoCAOV4v+5MRuz/DMo2q87/ij9x2moGLOEscOCL0VWUy7bQuTBDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gaRT3A2Z; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52S6Gv5g2081932
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 01:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743142617;
	bh=AKKKVZItBfHT3+7YvX1+qGAHQotvuTJsvf86filRI5U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gaRT3A2ZbMJXsh7hhAmcoeVP2sMA96wL8ENWPDMOivTUGrSJKvFGJ3Oktzsy6hMRY
	 Oj1/1DdBPvR+u2EbiGLPppaaBFlXzBrWWm/n0B5y8tSXa0VJh9Z/1QWyzOxUC+Cw2F
	 8G7xtZQ+rEXiVUI1P2hcGzcuuBRQJ7bDDP4TrBFk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52S6GvA3027969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Mar 2025 01:16:57 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 01:16:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 01:16:57 -0500
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52S6GnDw079192;
	Fri, 28 Mar 2025 01:16:50 -0500
Message-ID: <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>
Date: Fri, 28 Mar 2025 11:46:49 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix possible NULL
 pointer dereference for perout request
To: Jakub Kicinski <kuba@kernel.org>
CC: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kory.maincent@bootlin.com>,
        <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
 <20250321081313.37112-4-m-malladi@ti.com>
 <20250325104801.632ff98d@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250325104801.632ff98d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 3/25/2025 11:18 PM, Jakub Kicinski wrote:
> On Fri, 21 Mar 2025 13:43:13 +0530 Meghana Malladi wrote:
>> Whenever there is a perout request from the user application,
>> kernel receives req structure containing the configuration info
>> for that req.
> 
> This doesn't really explain the condition under which the bug triggers.
> Presumably when user request comes in req is never NULL?
> 

You are right, I have looked into what would trigger this bug but seems 
like user request can never be NULL, but the contents inside the req can 
be invalid, but that is already being handled by the kernel. So this bug 
fix makes no sense and I will be dropping this patch for v3. Thanks.

>> Add NULL pointer handling for perout request if
>> that req struct points to NULL.
>>
>> Fixes: e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for perout signal")
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> ---
>>
>> Changes from v1(v2-v1):
>> - Collected RB tag from Simon Horman <horms@kernel.org>
>>
>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index b4a34c57b7b4..aeebdc4c121e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -498,6 +498,10 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
>>   {
>>   	int ret = 0;
>>   
>> +	/* Return error if the req is NULL */
> 
> code is trivial here, explain the 'why' not the 'what'
> Why is this called with NULL?
> 
>> +	if (!req)
>> +		return -EINVAL;


