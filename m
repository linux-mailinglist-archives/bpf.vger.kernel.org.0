Return-Path: <bpf+bounces-54847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01142A74822
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D546A3BD800
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05019ABC6;
	Fri, 28 Mar 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oltVO8Io"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365521018A;
	Fri, 28 Mar 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157436; cv=none; b=gpRdGB1i0J8TofN8L4ryn1/blsof2D6oBjWQJBeyiwgiZJFJYo6fjgc+ymmHZu4yq2/kW+31yTT210xwsrTUzdXCFR+T6M99W7HzWPqwsbDcVdVjLFYgYgbX8kR/bE6PcdVT3V9ym6DfyHy0WXRqR3MdvTMiTZ2f/w1xa3ET16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157436; c=relaxed/simple;
	bh=C/U+S652qlm2r87tvW9anppsOwBr8Xm8n/aC5Qkp9Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t1hdawoCzTrC9NIDAYavP1ckoRBj4X+p0XrfOet6GSeYlNqde7l5oVF874R2pmNaUZUQbP4IxDYtT2Q1ld2s4gNynJms2sLLTlUBYHte7RlgkwiQoX4T1qRKdK90ICyYtDK7WBduXKFIfQ81OXf8KKmnFpdMiSOG5W3mTMETJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oltVO8Io; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAN9k72125479
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 05:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743157389;
	bh=C54Jp/OXwn6pBr69apSdFNlJcGXa//mpbe0LaniyLCY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oltVO8IoBMg/hUAlimth67nyXuBFiEonnp1jULNpxyW40Wm+qowPdOv4DT3pU2cLV
	 WGQMw9m4nXvVEOm4233Sts4Z1FxRuSERUMzAU7oW6LkMW67wKjQPtRPvqJiT9geqjO
	 ZwYwTkXOxYduZP+fWoAc3ImHSPwRnGvagP6fBo3k=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAN9k6015681
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Mar 2025 05:23:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 05:23:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 05:23:08 -0500
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAN2I7002993;
	Fri, 28 Mar 2025 05:23:03 -0500
Message-ID: <de68dc95-25e3-4bed-a2ab-4736a83867a2@ti.com>
Date: Fri, 28 Mar 2025 15:53:02 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix
 possible NULL pointer dereference for perout request
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jakub Kicinski <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
 <20250321081313.37112-4-m-malladi@ti.com>
 <20250325104801.632ff98d@kernel.org>
 <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>
 <326ebaa2-7b8f-455c-bf22-12e95f32b71a@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <326ebaa2-7b8f-455c-bf22-12e95f32b71a@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 3/28/2025 1:32 PM, Dan Carpenter wrote:
> On Fri, Mar 28, 2025 at 11: 46: 49AM +0530, Malladi, Meghana wrote: > > 
>  > On 3/25/2025 11: 18 PM, Jakub Kicinski wrote: > > On Fri, 21 Mar 2025 
> 13: 43: 13 +0530 Meghana Malladi wrote: > > > Whenever there is a perout 
> request
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uldqfVdF3CcxCkXE1pKJH1UXrlua- 
> GvI0DSoHvw1l5Yyu6xCbgDWX8PlhMSuV5lCv48fT7ChvXbQ105c6PHChn2lWCWZMsMcoHjvVwM$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Fri, Mar 28, 2025 at 11:46:49AM +0530, Malladi, Meghana wrote:
>> 
>> 
>> On 3/25/2025 11:18 PM, Jakub Kicinski wrote:
>> > On Fri, 21 Mar 2025 13:43:13 +0530 Meghana Malladi wrote:
>> > > Whenever there is a perout request from the user application,
>> > > kernel receives req structure containing the configuration info
>> > > for that req.
>> > 
>> > This doesn't really explain the condition under which the bug triggers.
>> > Presumably when user request comes in req is never NULL?
>> > 
>> 
>> You are right, I have looked into what would trigger this bug but seems like
>> user request can never be NULL, but the contents inside the req can be
>> invalid, but that is already being handled by the kernel. So this bug fix
>> makes no sense and I will be dropping this patch for v3. Thanks.
>> 
> 
> I don't remember bug reports for more than a few hours so I had to dig
> this up on lore:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/ 
> all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/__;!!G3vK! 
> XPLUWNuB49W9FXpnac95FM8thR9_zMOBwt7JgYy8Yaf72LIm4Xt-3Yc8h1sEti5uVdguSWQhcfsnC1_ymQIMTg$ <https://urldefense.com/v3/__https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/__;!!G3vK!XPLUWNuB49W9FXpnac95FM8thR9_zMOBwt7JgYy8Yaf72LIm4Xt-3Yc8h1sEti5uVdguSWQhcfsnC1_ymQIMTg$>
> 
> This is definitely still a real bug on today's linux-next but yes, the
> fix is bad.
> 
> drivers/net/ethernet/ti/icssg/icss_iep.c
>     814  int icss_iep_exit(struct icss_iep *iep)
>     815  {
>     816          if (iep->ptp_clock) {
>     817                  ptp_clock_unregister(iep->ptp_clock);
>     818                  iep->ptp_clock = NULL;
>     819          }
>     820          icss_iep_disable(iep);
>     821
>     822          if (iep->pps_enabled)
>     823                  icss_iep_pps_enable(iep, false);
>     824          else if (iep->perout_enabled)
>     825                  icss_iep_perout_enable(iep, NULL, false);
>                                                      ^^^^
> A better fix probably to delete this function call instead of
> turning it into a no-op.

Yes agreed, current bug fix is bad. Will have a fix similar to this and 
post it soon. Thanks.

> 
>     826
>     827          return 0;
>     828  }
> 
> regards,
> dan carpenter
> 


