Return-Path: <bpf+bounces-57190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17EAA6AB1
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 08:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A74A3C24
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0331221544;
	Fri,  2 May 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPDN5om4"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA221FF20;
	Fri,  2 May 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166767; cv=none; b=VN6bkV0Fh4LvE8NtDhSk4abKPnmcTYqOwLfeN11ReLG7jrN1iHpBD9DwMJcz/2WaUG3+RhbVtje64rskNq3b0FXOjFkrMsP9k6dffcGJhTZVlCka+LoQJisvQwWG2SZ+6uG6bssQNX7pT00u3wwz6OavJhQITL1csGjcOr/LYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166767; c=relaxed/simple;
	bh=Nznyg0LG5io9vLtmVMBR4II8Mn63VTmHrHvN2HbmD/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sHRJGOkqnAtYsnqXnSrMD0FUlTWSpAXhUyvipR9EpizHrCg0Yv2gUQUoQYUJAEOQiTktxO8Ziv0PrzglNkvj15C/+LXi7Bn49BYlgwLi+zACKP1YI6TB4Mmatb7SAN9s1l9kd7PxBMwOhhiWM2sscbH876hK/pJmHQgz+iQT3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oPDN5om4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5426IsIj346797
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 May 2025 01:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746166734;
	bh=K0RNhMfK3sIBzFbukwC318fh71Ziu5vXXAkpvIWDZxI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oPDN5om4VdiNS9FHLM0mQHoXcY1TMVEPLCYYtP4ccAerBHC7wM0LQ3pbfQCwJvMpj
	 1+/FoT5lVgrky8w2nFwSuTeougZmyvZXCLlMgtsoLneMQ66CpZtqHk0rIh/DnP62Of
	 Utwy567detCy+Xg2uBg5MFrj9tBqiUd4CYxcQ4fA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5426IsJO022218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 01:18:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 01:18:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 01:18:53 -0500
Received: from [172.24.30.16] (lt9560gk3.dhcp.ti.com [172.24.30.16])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5426IlMR072250;
	Fri, 2 May 2025 01:18:48 -0500
Message-ID: <64396b06-5ea7-4da9-b854-b3d42f2b9bde@ti.com>
Date: Fri, 2 May 2025 11:48:47 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] net: ti: icssg-prueth: Report BQL before sending
 XDP packets
To: Jakub Kicinski <kuba@kernel.org>
CC: <dan.carpenter@linaro.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
 <20250428120459.244525-3-m-malladi@ti.com>
 <20250501075357.37f2dc4f@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250501075357.37f2dc4f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 5/1/2025 8:23 PM, Jakub Kicinski wrote:
> On Mon, 28 Apr 2025 17:34:57 +0530 Meghana Malladi wrote:
>> When sending out any kind of traffic, it is essential that the driver
>> keeps reporting BQL of the number of bytes that have been sent so that
>> BQL can track the amount of data in the queue and prevents it from
>> overflowing. If BQL is not reported, the driver may continue sending
>> packets even when the queue is full, leading to packet loss, congestion
>> and decreased network performance. Currently this is missing in
>> emac_xmit_xdp_frame() and this patch fixes it.
> 
> The ordering of patches in the series is a bit off.
> The order should be something like:
> 
>    net: ti: icssg-prueth: Set XDP feature flags for ndev
>    net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue ...
>    net: ti: icssg-prueth: Fix race condition for traffic from different ...
>    net: ti: icssg-prueth: Report BQL before sending XDP packets
> 
> This patch is not correct without the extra locking in place.

Actually the order of bug fixes which I posted, is the order in which I 
fixed the bugs, while running xdp-trafficgen:
1. ndo_xdp_xmit() wasn't getting called because of missing XDP feature 
flags check.
2. kernel crash: kernel BUG at lib/dynamic_queue_limits.c:99! and was 
fixed by reporting BQL for packet transmission.My bad, I forgot  to add 
this in the commit message.
3. kernel crash: kernel BUG at lib/genalloc.c:508! due to memory 
corruption in DMA descriptors and fixed it with spinlock
4. kernel crash: kernel BUG at lib/dynamic_queue_limits.c:99! due to 
race condition in netif_txq and fixed it with __netif_tx_lock()

But yeah I think the order you suggested makes more sense. Let me try 
that and post v2.

-- 
Thanks,
Meghana Malladi


