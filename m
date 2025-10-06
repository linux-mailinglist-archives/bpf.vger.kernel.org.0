Return-Path: <bpf+bounces-70435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFFBBF08D
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D24EE4BF
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7F2DE6F7;
	Mon,  6 Oct 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E7+aom7i"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58374186284;
	Mon,  6 Oct 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776959; cv=none; b=sl0mIS0Qsyihg7IObiMtFN31Gkbwa8stB8RwXa5SLCdfJQW5mvG81nYv9NRBgHmQpct54goojbI50VMsGRKxcPi/m+supgJ1NbXYxjGJ/njDQubitFcUOaFIIuUPsRyAowkkttyVUmpNG40H7mU1EVEH0beywA9VsvxOawU6N74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776959; c=relaxed/simple;
	bh=NeO5M1g+CzpVBBZQ4Gkp2EgJHk7iaNVsdWR81NyG55w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DKNuagUmAV/3gvZ61aPaNUFCaAYHZ1JGKyt0DXC2e5ylfxfjdwn3fKFekvwK2n1MMQTbSzZD9/mlhVnX8Fucm9TM2+JGXJxuXq4pkMRxoXd+wTfp3/jKWg/3ipKu6uuDaHj8/wSzB3Gev24kT9J+jA+rr+l/Zy5u6WT9aCHJDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E7+aom7i; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596It2SX4119639;
	Mon, 6 Oct 2025 13:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759776902;
	bh=f6pZT5lucgMcs99wvMibFb9xDLLP+hxuIJ4a3foUSyk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E7+aom7iEB0KO+84LbOgCmjQEvWalHvTBxZspZXJNuIHfYKoIkaEgSNVC1Ud1VvDw
	 FW0KnpoiqnJ3w+jyQjkEm8kgXbllSgAY2O4SDpM4jq+TEnPgkR8lUOFLD0EFtZ41OT
	 lVvVHRj2FBwtxJzi8tdV0kS+dzu9H3CyWndZKQy0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596It219128164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 6 Oct 2025 13:55:02 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 13:55:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 13:55:01 -0500
Received: from [10.249.131.66] ([10.249.131.66])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596IsrfM3895037;
	Mon, 6 Oct 2025 13:54:54 -0500
Message-ID: <53cbd465-6925-4003-a13b-11fa1034819d@ti.com>
Date: Tue, 7 Oct 2025 00:24:53 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/6] net: ti: icssg-prueth: Add functions to
 create and destroy Rx/Tx queues
To: Jakub Kicinski <kuba@kernel.org>
CC: <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250901100227.1150567-1-m-malladi@ti.com>
 <20250901100227.1150567-2-m-malladi@ti.com>
 <20250903174847.5d8d1c9f@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250903174847.5d8d1c9f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 9/4/2025 6:18 AM, Jakub Kicinski wrote:
> On Mon, 1 Sep 2025 15:32:22 +0530 Meghana Malladi wrote:
>>   	if (!emac->xdpi.prog && !prog)
>>   		return 0;
>>   
>> -	WRITE_ONCE(emac->xdp_prog, prog);
>> +	if (netif_running(emac->ndev)) {
>> +		prueth_destroy_txq(emac);
>> +		prueth_destroy_rxq(emac);
>> +	}
>> +
>> +	old_prog = xchg(&emac->xdp_prog, prog);
>> +	if (old_prog)
>> +		bpf_prog_put(old_prog);
>> +
>> +	if (netif_running(emac->ndev)) {
>> +		ret = prueth_create_rxq(emac);
> 
> shutting the device down and freeing all rx memory for reconfig is not
> okay. If the system is low on memory the Rx buffer allocations may fail
> and system may drop off the network. You must either pre-allocate or
> avoid freeing the memory, and just restart the queues.

So I have been working on trying to address this comment and maintain 
parity with the existing support provided by this series but looks like 
I might be missing something which is causing some regressions.

I am facing an issue with zero copy Rx, where there is some active 
traffic being received by the DUT (running in copy mode - default state)
and I switch to zero copy mode using AF-XDP_example [1], I am not able 
to receive any packets because I observe that the napi_rx_poll is not 
getting scheduled for whatever reason, ending up draining the rx 
descriptors and leading to memory leak. But if I first switch from copy 
to zero copy mode and then try sending traffic I am able to receive 
traffic on long runs without any failure or crash. I am not able to 
figure out why is this happening, so sharing my changes [2] on top of 
this series, which I made to address your comment. I am wondering if you 
could have a look and give me some pointers here. Thank you.

[1] https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

[2] 
https://gist.github.com/MeghanaMalladiTI/4c1cb106aee5bef4489ab372938d62d9

> 
>> +		if (ret) {
>> +			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = prueth_create_txq(emac);
>> +		if (ret) {
>> +			netdev_err(emac->ndev, "Failed to create TX queue: %d\n", ret);
>> +			prueth_destroy_rxq(emac);
>> +			emac->xdp_prog = NULL;
>> +			return ret;
>> +		}
>> +	}
>>   
>>   	xdp_attachment_setup(&emac->xdpi, bpf);

-- 
Thanks,
Meghana Malladi


