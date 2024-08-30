Return-Path: <bpf+bounces-38543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4D965E24
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C341F264A8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5617C22E;
	Fri, 30 Aug 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uRWJU92X"
X-Original-To: bpf@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28E17BB2E;
	Fri, 30 Aug 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012662; cv=none; b=e+zpODKJ01uwWBZQiF8HkfFZqKPq+N3zLoX/rKxnVg4PdGb2B//Re/4XFS5Ngz/X2mOYPk3iKHdMZn/e00+062mzUIUsXGLuy6jUlUcM792tazAEeO8BWMe3+g97uZar3Fxz/1jaU1/HHIqKirALhdVAQi4Fnr6gHJkXMUdrMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012662; c=relaxed/simple;
	bh=e3v/tfFr6OXQsMA4ArsK1IK9MbBAj7ozQ+7muAQoZ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fS3GpHWy3WSEZDMtN8KGLhFKwpOsbC0HiMjTwEUp4phjaX4illcOohNJK2uvk7d2cxtRZQpNr1B9tGS2iUEVEJnMoOrSJ2xkvjVRAIa4OdwNKrhiO/cZElhaWv55NoE6idA7Xx7YVrC74sUlb1pfMahbMK32PmGVe14T6vUDc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uRWJU92X; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UAAa12097929;
	Fri, 30 Aug 2024 05:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725012636;
	bh=80eadUWFezgr51akxOKkbvhUOSeToUTMrD8dy25iM0A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uRWJU92XaXopiajVDn0Yncp5WKe507Ryk7EPanXtU0amqE8VGHPyJXI8yWKqQdmVW
	 br3cH8eXHt0f3z+ou8fm9FCU4W3nAwAawIisJTZeYOx2XPpMaobBZoPG+DkvJiCHXr
	 zYZ918oaCysCZHSFAXXsXP/c7iFVyWFeILnkfLuI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UAAau4019078
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:10:36 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:10:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:10:35 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UAAUMT092473;
	Fri, 30 Aug 2024 05:10:31 -0500
Message-ID: <91d80afc-a911-4932-8f29-5697059efa8d@ti.com>
Date: Fri, 30 Aug 2024 15:40:30 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: Fix XDP
 implementation
To: Roger Quadros <rogerq@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Julien
 Panis <jpanis@baylibre.com>,
        Jacob Keller <jacob.e.keller@intel.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Govindarajan Sriramakrishnan <srk@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/08/24 5:33 pm, Roger Quadros wrote:
> The XDP implementation on am65-cpsw driver is broken in many ways
> and this series fixes it.
> 
> Below are the current issues that are being fixed:
> 
> 1)  The following XDP_DROP test from [1] stalls the interface after
>     250 packets.
>     ~# xdb-bench drop -m native eth0
>     This is because new RX requests are never queued. Fix that.
> 
> 2)  The below XDP_TX test from [1] fails with a warning
>     [  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
>     ~# xdb-bench tx -m native eth0
>     Fix that by using PAGE_SIZE during xdp_init_buf().
> 
> 3)  In XDP_REDIRECT case only 1 packet was processed in rx_poll.
>     Fix it to process up to budget packets.
>     ~# ./xdp-bench redirect -m native eth0 eth0
> 
> 4)  If number of TX queues are set to 1 we get a NULL pointer
>     dereference during XDP_TX.
>     ~# ethtool -L eth0 tx 1
>     ~# ./xdp-trafficgen udp -A <ipv6-src> -a <ipv6-dst> eth0 -t 2
>     Transmitting on eth0 (ifindex 2)
>     [  241.135257] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> 
> 5)  Net statistics is broken for XDP_TX and XDP_REDIRECT
> 
> [1] xdp-tools suite https://github.com/xdp-project/xdp-tools
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

This series looks good to me.

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

