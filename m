Return-Path: <bpf+bounces-54528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC676A6B5BC
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D6118998B7
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A361EFF8D;
	Fri, 21 Mar 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CuIyKFbs"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7C1E5B67;
	Fri, 21 Mar 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544137; cv=none; b=NNSRaV4c315FZ65Hs1CRsYr2GQkmdA15SkNF4ux6nkfUWV3he5iT7oaFY2t+PyXQpxriJkgxh+I0YRk9BrMa4Y1rRkqShl7vucwKJVvLh3bsG6w2vttdjYm+viZ1yjHf+9orGmM5bse4C8bZ727yaEivzv+ZvXBYC2A1iKFrcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544137; c=relaxed/simple;
	bh=qwa6a+2FSKObC7POn6jD/SygueU+uOQsl+xTVPOkE4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n+SpMA7Poz6vf5GXo5aoDaUzEPfq6VqZQh4TtJ0ElTVxpXcnLJxVqBcIvu2R46pd8C/qmPYMXiK+Fez70z3wXsjJvdVAPMShtO2nMNL8xr3Ajm2Fa5hLG7xpqkBcmNNHf0SPaMQW7VNUY4Mqtvc6WlDq2W7i3GDO8Ff/MQbdqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CuIyKFbs; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52L81aQZ257023
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 03:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742544097;
	bh=Axdj0QnFgjxfraWinlzlf+n30BytYhrhTX2isoRR1xs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CuIyKFbscqKOjmXrH91k9s8t7OXo3P8jAqitsCtKup3PkMQDhDHqpcDl9maXUkTgx
	 LqogDkZUthqCdXKeM530PWhXw85t1MCQgxcer+T2av/4vPKLgZ6TazhqFwcJYPkXef
	 rKQQC8AtMWn100ZzBBD/xytYBaMtGbE/CE93Pd+0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52L81aBj008848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Mar 2025 03:01:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Mar 2025 03:01:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Mar 2025 03:01:36 -0500
Received: from [172.24.19.92] (lt9560gk3.dhcp.ti.com [172.24.19.92])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L81UVH114513;
	Fri, 21 Mar 2025 03:01:31 -0500
Message-ID: <48519536-6756-4d3d-9bb1-09197248df36@ti.com>
Date: Fri, 21 Mar 2025 13:31:29 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ti: prueth: Fix kernel warning while
 bringing down network interface
To: Simon Horman <horms@kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kory.maincent@bootlin.com>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250317101551.1005706-1-m-malladi@ti.com>
 <20250317101551.1005706-2-m-malladi@ti.com>
 <20250320125349.GN280585@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250320125349.GN280585@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Simon,
Thanks for reviewing the patch series.

On 3/20/2025 6:23 PM, Simon Horman wrote:
> On Mon, Mar 17, 2025 at 03:45:48PM +0530, Meghana Malladi wrote:
>> During network interface initialization, the NIC driver needs to register
>> its Rx queue with the XDP, to ensure the incoming XDP buffer carries a
>> pointer reference to this info and is stored inside xdp_rxq_info.
>>
>> While this struct isn't tied to XDP prog, if there are any changes in
>> Rx queue, the NIC driver needs to stop the Rx queue by unregistering
>> with XDP before purging and reallocating memory. Drop page_pool destroy
>> during Rx channel reset and this is already handled by XDP during
>> xdp_rxq_info_unreg (Rx queue unregister), failing to do will cause the
>> following warning:
>>
>> [  271.494611] ------------[ cut here ]------------
>> [  271.494629] WARNING: CPU: 0 PID: 2453 at /net/core/page_pool.c:1108 0xffff8000808d5f60
> 
> I think it would be nice to include a bit more of the stack trace here.
> 

Sure, I will attach a link to the warning logs in v2.

>>
>> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> 
> It is a shame that we now have more asymmetry regarding
> the allocation of the pool and unwind on error prueth_prepare_rx_chan().
> 
> But if I see things correctly the freeing of the pool via
> xdp_rxq_info_unreg() is unconditional. And with that in mind
> I agree the approach taken by this patch makes sense.
> 

Agreed on the asymmetry part, but I am not quite convinced on why 
xdp_rxq_info_unreg() is freeing the pool unconditionally, when the 
driver is the one which is allocating the pool. If xdp_rxq_info_unreg() 
is freeing it, then shouldn't xdp_rxq_info_reg() be allocating it ?

> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...


