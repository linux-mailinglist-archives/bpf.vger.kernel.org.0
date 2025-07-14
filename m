Return-Path: <bpf+bounces-63216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E41B0449D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549A4173156
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CEB25C6E7;
	Mon, 14 Jul 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EySpEpw1"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445112E36F0;
	Mon, 14 Jul 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508148; cv=none; b=AoiiijyqUcSaSZ/hOsH/qDMEdu/Hq8ZL66mNrjmT4J3NvnuKN1Fi0Nq7o1obGxSRxOmUmjXZY8GP///7EeEbHm2c8v3/7eC5e45XvTY7CnagPuvf7ome+R3ulgdg2UYoUUNfnMlH2xiyWMuJ5rwJdDY4CMb8s2Z994MJZB+JGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508148; c=relaxed/simple;
	bh=gynR6U1af0ByDlmuzNPvrt9QOm6xRxe9HmvQRMgpo6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u80+sVQzM+LK+Xb8KMutMgqCnKmBhuJnHXIu10wS4GLi0eaFH9byvHNH6v89VSBzTlFOYWMpfqNpMd5YaBfB3sMtu8vM8BaKMZGidapSmEA1I0xPfEQh3eQ11SMUxr1sxqW90wgvwCrFCmXSyurqBo4QbOH6p0qhiL7Redt154s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EySpEpw1; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56EFmZeR2683833;
	Mon, 14 Jul 2025 10:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752508115;
	bh=nRDeHKQbWfbtGevuT6SkWvzndahOFJlTNEgxm+DCyBo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EySpEpw1IJFNOmD1QRnL/tWLJ/q2t+AT/TjHLhXJ1/4R6EQfo1oSxW8+9t8tiLW14
	 NDZ3t65tyxh7XiRY6mx2N2/hPdC+dENajLP7Ucs/19AZLFLRda5AESXsYZGqPUiT/c
	 8glO+OCjDDxbZEXNHfrtqCsrMkNhc/cn8Vd296zI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56EFmZfn3504193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 14 Jul 2025 10:48:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 10:48:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 10:48:34 -0500
Received: from [10.249.131.66] ([10.249.131.66])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56EFmShm1272637;
	Mon, 14 Jul 2025 10:48:29 -0500
Message-ID: <ea631e0e-9cf7-4fae-820a-43013adcd1ec@ti.com>
Date: Mon, 14 Jul 2025 21:18:27 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH RFC net-next 0/5] net: ethernet: ti:
 am65-cpsw: add AF_XDP zero copy support
To: Jakub Kicinski <kuba@kernel.org>
CC: Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        <srk@ti.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
References: <20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org>
 <268f6849-efc6-4663-af20-f6726bd4b78d@ti.com>
 <20250714080629.29aa7a2d@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250714080629.29aa7a2d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

Sorry for the duplicate mail.

On 7/14/2025 8:36 PM, Jakub Kicinski wrote:
> On Mon, 14 Jul 2025 14: 50: 05 +0530 Malladi, Meghana wrote: > > AF_XDP 
> performance using 64 byte packets in Kpps. > > Benchmark: XDP-SKB XDP- 
> Native XDP-Native(ZeroCopy) > > rxdrop 317 504 824 > > txonly 400 405 757 >
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uDdqXRfP1m37CoZlPNNDnQgOintsvKy- 
> cENuCwB1b5Qxa66rT1SFJDmyny6jsjalW7Wur6ukCSGrdQ$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, 14 Jul 2025 14:50:05 +0530 Malladi, Meghana wrote:
>> > AF_XDP performance using 64 byte packets in Kpps.
>> > Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
>> > rxdrop		317		504		824
>> > txonly		400		405		757
>> > l2fwd 		207		264		0
>> > 
>> > AF_XDP performance using 1500 byte packets in Kpps.
>> > Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
>> > rxdrop		82		82		82
>> > txonly		82		82		82
>> > l2fwd 		82		82		82
>> > 
>> > [1]: https://urldefense.com/v3/__https://github.com/xdp-project/bpf-examples/ 
> tree/master/AF_XDP-example__;!!G3vK!Sv1p-bFPBDlzD-YMO2sjo- 
> X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3d9m40aZg$ <https://urldefense.com/v3/__https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example__;!!G3vK!Sv1p-bFPBDlzD-YMO2sjo-X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3d9m40aZg$>
>> > 
>> > To:
>> > 
>> > Signed-off-by: Roger Quadros <rogerq@kernel.org>  
>> 
>> This series crashes Linux on am64xx-hsevm, when I tried nfs boot using 
>> AM65-CPSW-NUSS driver:
>> logs: 
>> https://urldefense.com/v3/__https://gist.github.com/MeghanaMalladiTI/ 
> d655a1c8ca88113ee7f5f57d6ab0ec4c__;!!G3vK!Sv1p-bFPBDlzD-YMO2sjo- 
> X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3ecuWN_dw$ <https://urldefense.com/v3/__https://gist.github.com/MeghanaMalladiTI/d655a1c8ca88113ee7f5f57d6ab0ec4c__;!!G3vK!Sv1p-bFPBDlzD-YMO2sjo-X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3ecuWN_dw$>
>> 
>> Seems like you have reverted the fix for the same bug which was reported 
>> by Siddharth and fixed by Julien: 
>> https://urldefense.com/v3/__https://lore.kernel.org/ 
> all/7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com/__;!!G3vK!Sv1p- 
> bFPBDlzD-YMO2sjo-X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3exh7VnCw$ <https://urldefense.com/v3/__https://lore.kernel.org/all/7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com/__;!!G3vK!Sv1p-bFPBDlzD-YMO2sjo-X2gv3CW5uHD_O771StRVzMR8Vr75k7tTGQJ27MRy_fz3exh7VnCw$>
>> 
>> reverted lines:
>> 		if (!common->ports[port].ndev)
>> 		/* FIXME should we BUG here? */
>> 			continue;
>> 
>> Can you please take a look at it.
> 
> Just to be clear -- you're reporting this problem to Roger so that its
> fixed before the series is reposted? I don't see this in the tree, I
> wanted to make sure it's not something I need to track as a regression.
> 

Yes you are right. This isn't a regression, I reported this as part of 
my testing for this RFC patch series.

-- 
Thanks,
Meghana Malladi


