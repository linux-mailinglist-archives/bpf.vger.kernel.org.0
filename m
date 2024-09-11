Return-Path: <bpf+bounces-39587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE3974C64
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA68B255EE
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0C15688F;
	Wed, 11 Sep 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dpzPP3kY"
X-Original-To: bpf@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A441547CE;
	Wed, 11 Sep 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042657; cv=none; b=IbsxcBrf6MS8ntYlP3nwVY0FO2txb6g56ia27JryjX8UQs/fofXdR26DDtFpA2HuBb3/h/RuCGGjdY74zyLe2X0b54wwbX/lBx9cgeV8Wg1RFqDKdlvZ5kWcHIJSsAxLCs4+hU4gxMFNvXTPdmaqDSYpUk0OOmYdweXd+4sKA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042657; c=relaxed/simple;
	bh=8p0fmiYJzSluh0/52Jvo6+8VCrS1gb2q9YlhMWECExQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fdOGE5euM5WwzwaLnoLpNQHYc+svPLQj1zjY1C3jC8ZuBsC1U9hoGSQK7VWpNOR69c9UC+B79uO8Eqfv0BRSu/JyemNGBQ9CR9vkHtAsCNJMKDLTSnbXplQXmxov+74xEtY9SrDO+jd/jUFxxZh2nHgPtaVA1qwECXD4u2SzJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dpzPP3kY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8HC9G103591;
	Wed, 11 Sep 2024 03:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726042632;
	bh=m8xqCn97m2MiGWxQkQ3F8+Cp3fnXugqSgp+evdIQ3Eo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dpzPP3kY9GQY/NKdfJyZnTxpejLORYrLE+gS8Uy1sj9NDSke2Lwixk5XO+YEwOpqr
	 tzLERrU4CamQLVAE+TswFgp1KXr45148RnNRUBrqIuWW3oqbNokGbnIg3N9OdcVOc/
	 CEfwbxMr2U7BSpFJkvs9TXVaWfEw6hM3Es/SjLa4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48B8HCHh020644
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Sep 2024 03:17:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:17:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:17:12 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8H67n012696;
	Wed, 11 Sep 2024 03:17:06 -0500
Message-ID: <27447854-6a79-4153-a1b3-6ff86911de26@ti.com>
Date: Wed, 11 Sep 2024 13:47:05 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/6] net: ethernet: ti: am65-cpsw: Add multi
 queue RX support
To: Roger Quadros <rogerq@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
CC: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Joe Damato
	<jdamato@fastly.com>, <srk@ti.com>, <vigneshr@ti.com>,
        pekka Varis
	<p-varis@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 10/09/24 2:53 pm, Roger Quadros wrote:
> Hi,
> 
> am65-cpsw can support up to 8 queues at Rx. So far we have
> been using only one queue (i.e. default flow) for all RX traffic.
> 
> This series adds multi-queue support. The driver starts with
> 1 RX queue by default. User can increase the RX queues via ethtool,
> e.g. 'ethtool -L ethx rx <N>'
> 
> The series also adds regmap and regfield support to some of the
> ALE registers. It adds Policer/Classifier registers and fields.
> 
> Converting the existing ALE control APIs to regfields can be a separate
> exercise.
> 
> Some helper functions are added to read/write to the Policer/Classifier
> registers and a default Classifier setup function is added that
> routes packets based on their PCP/DSCP priority to different RX queues.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Changes in v4:
> - Use single macro AM65_CPSW_MAX_QUEUES for both TX and RX queues
>   to simplify code
> - reuse am65_cpsw_get/set_per_queue_coalesce for am65_cpsw_get/set_coalesce.
> - return -EINVAL if unsupported tx/rx_coalesce_usecs in
>   am65_cpsw_set_coalesce.
> - reverse Xmas tree declaration order fixes in cpsw_ale
> - Link to v3: https://lore.kernel.org/r/20240703-am65-cpsw-multi-rx-v3-0-f11cd860fd72@kernel.org
> 
> Changes in v3:
> - code style fixes
> - squashed patches 5 and 6
> - added comment about priority to thread mapping table.
> - Added Reviewed-by Simon Horman.
> - Link to v2: https://lore.kernel.org/r/20240628-am65-cpsw-multi-rx-v2-0-c399cb77db56@kernel.org
> 
> Changes in v2:
> - rebase to net/next
> - fixed RX stall issue during iperf
> - Link to v1: https://lore.kernel.org/r/20240606-am65-cpsw-multi-rx-v1-0-0704b0cb6fdc@kernel.org
> 
> ---
> Roger Quadros (6):
>       net: ethernet: ti: am65-cpsw: Introduce multi queue Rx
>       net: ethernet: ti: cpsw_ale: use regfields for ALE registers
>       net: ethernet: ti: cpsw_ale: use regfields for number of Entries and Policers
>       net: ethernet: ti: cpsw_ale: add Policer and Thread control register fields
>       net: ethernet: ti: cpsw_ale: add policer/classifier helpers and setup defaults
>       net: ethernet: ti: am65-cpsw: setup priority to flow mapping
> 
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  75 +++---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 388 ++++++++++++++++------------
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  39 +--
>  drivers/net/ethernet/ti/cpsw_ale.c          | 287 ++++++++++++++++++--
>  drivers/net/ethernet/ti/cpsw_ale.h          |  62 ++++-
>  5 files changed, 594 insertions(+), 257 deletions(-)
> ---
> base-commit: bfba7bc8b7c2c100b76edb3a646fdce256392129
> change-id: 20240606-am65-cpsw-multi-rx-fb6cf8dea5eb
> 
> Best regards,

For this series,
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

