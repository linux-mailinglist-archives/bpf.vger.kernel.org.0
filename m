Return-Path: <bpf+bounces-50669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3045A2AAA4
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5868B1889C6B
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68001FECB9;
	Thu,  6 Feb 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eCCp3949"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEB2500CD;
	Thu,  6 Feb 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850542; cv=none; b=aVoOwREKNhiUNDSs7gfh/7FOb9tnCnnRXTEWF+/W5GBm6NlaKfSnuTsFLD4Uid0hj9G1wD4DuF1iQl7XV1MpOvfz8Zm4Eoj8m249p/272eEMpFapdffgwVFQtAV98yLNXh9VwYVhtrl7HkHLIgg2EE/nwSZ5noQecsjZ/5y5xYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850542; c=relaxed/simple;
	bh=n+gmocS/ZLxcXEBU+870i8PwgKdxr7b+1ALHXPXijHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=re1GnDFiBjqqJ4wuVKnRhblC1KOw04JT6KskSjyxdyZ8aDUE3PDl5ZZTcizgplnMGhYoOlYMJcktrWSWUm8G+zVMkxzK8tER/mw08mEGAwndb6muY4ezxeSPTuQA/f0DRksi1Ti3C+AfiILXgYMDG3JEDO1ZFbJzGNhrEifEbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eCCp3949; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516E1Vbh2812418
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 08:01:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738850492;
	bh=88iRX8irqERVHqBMl74vPIF+rogOEUfOrJex91RNWYg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eCCp3949bwfLnkf8zD3DSkOK9WljWAwbZ1L/ni8wAQRp7eoOYixFjxg/Y61w9mHhu
	 k8S7s75de3G+P08aQBdYm31veRoBRac5Czz1ZbEb1+v91Y+oU9lcc9lO+oZQ3UMY+1
	 a+54Sf6OWM09GHBE+MJjPpkYPisjjRXZknApCiFY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 516E1VJD057574
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Feb 2025 08:01:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 08:01:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 08:01:31 -0600
Received: from [172.24.23.168] (lt9560gk3.dhcp.ti.com [172.24.23.168])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516E1N6m039077;
	Thu, 6 Feb 2025 08:01:24 -0600
Message-ID: <04ff4911-de4b-4d68-b72f-f03915baa9c9@ti.com>
Date: Thu, 6 Feb 2025 19:31:23 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net 3/3] net: ti: icssg-prueth: Add AF_XDP
 support
To: Ido Schimmel <idosch@idosch.org>
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
 <20250122124951.3072410-4-m-malladi@ti.com> <Z5J7kGFU_ZgneFAF@shredder>
 <f1cf5bfc-e767-4ced-9aad-76a578c53706@ti.com> <Z6Oj7eMRV9z9lF2I@shredder>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <Z6Oj7eMRV9z9lF2I@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/5/2025 11:16 PM, Ido Schimmel wrote:
> On Tue, Feb 04, 2025 at 11: 25: 39PM +0530, Malladi, Meghana wrote: > On 
> 1/23/2025 10: 55 PM, Ido Schimmel wrote: > > XDP program could have 
> changed the packet length, but driver seems to be > > This will be true 
> given, emac->xdp_prog
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> v9dnXdhkNoe0hkqlFZKoUhMAqXZwolk5zXhypw1qeZY8pxUHTuuleZBOKulyBnK9eA$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Tue, Feb 04, 2025 at 11:25:39PM +0530, Malladi, Meghana wrote:
>> On 1/23/2025 10:55 PM, Ido Schimmel wrote:
>> > XDP program could have changed the packet length, but driver seems to be
>> 
>> This will be true given, emac->xdp_prog is not NULL. What about when XDP is
>> not enabled ?
> 
> I don't understand the question. My point is that the packet doesn't
> necessarily look the same after XDP ran.
> 

emac_rx_packet() is a common function for both XDP and non-XDP use 
cases. XDP will only run when emac->xdp_prog is not NULL. I understand 
that when XDP ran, it can change the contents of the packet hence it is 
advisable to use "xdp_build_skb_from_buff(const struct xdp_buff *xdp)", 
but for cases when xdp doesn't run - the xdp struct has junk/zero value 
which cannot be converted into some valid skb. But I think I will do 
something like this:

if (emac->xdp_prog)
	xdp_build_skb_from_buff(xdp);
else
	skb = napi_build_skb(pa, PAGE_SIZE);

Hope this will address your comment.

>> 
>> > building the skb using original length read from the descriptor.
>> > Consider using xdp_build_skb_from_buff()
>> > 
>> 
> 


