Return-Path: <bpf+bounces-53297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F00A4F9DF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BD67A5389
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77492204866;
	Wed,  5 Mar 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdH9WHlI"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C15202969;
	Wed,  5 Mar 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166645; cv=none; b=gqkguHY0iSZN3ETSPUCusyasuQB3+hAjLsDr8BBoMP1wYDyFm8fqQJggLdxzkCMih6XPwGxZwPNW1200OD4PigFIEcHSx0doy5E3ef1t/XBj3tbXMTr4X2otYC/oJ4qGDr/XishURLYCLOx5psZwFWbJee59K0ZKg6oA4UxhaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166645; c=relaxed/simple;
	bh=e9IpE0SGBvr7XdB1PmYTB+n+O/yPUsQGkJTr/yP4p20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NKj2Wun1gVzv3qMVxekwcSoNZ0ol35oJw+vL0MFfAm7KgvbSm/lsd7SeMfHwQx0IgzEy9NTmY2vEhBEojRlp4yfj5MmRzgc+ayCqdyhdCnNwJSRsWPZgua8Bu8f5JBcw1Lwu5hFSfYYCxlpNFeNoBti9Neap4f5n1k9UnNkCROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IdH9WHlI; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5259NFLA3262869
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 03:23:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741166595;
	bh=Z5/W8wdKEN5TGq6ACfVJI7RQYE+f+XWAUXgCuHkULso=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IdH9WHlIAXAT3d1R8hRkJzkWi8CWZL2syf2CHxChgi8SfA7NLD8s/AdPEfIXn3XHl
	 jZKg9wPMq4FKO/RT6gpiLY8pcd1tjfW+pAfWyZq/Q+JAT+yEssjTQF7lyX+lR5fbDQ
	 JhL4jrsqYPcdbeqpXT6n0b9p7fCiufEri48wcNbc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5259NF0R048075
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 03:23:15 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 03:23:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 03:23:14 -0600
Received: from [172.24.31.59] (lt9560gk3.dhcp.ti.com [172.24.31.59])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5259N7TW044885;
	Wed, 5 Mar 2025 03:23:08 -0600
Message-ID: <fd989751-e7f6-40bb-a0bf-058c752cc7bc@ti.com>
Date: Wed, 5 Mar 2025 14:53:07 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add
 XDP support
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <u.kleine-koenig@baylibre.com>,
        <matthias.schiffer@ew.tq-group.com>, <schnelle@linux.ibm.com>,
        <diogo.ivo@siemens.com>, <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
 <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
 <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>
 <61117a07-35b5-48c0-93d9-f97db8e15503@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <61117a07-35b5-48c0-93d9-f97db8e15503@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dan,

On 3/3/2025 7:38 PM, Dan Carpenter wrote:
> What I mean is just compile the .o file with and without the unlikely(). 
> $ md5sum drivers/net/ethernet/ti/icssg/icssg_common. o* 
> 2de875935222b9ecd8483e61848c4fc9 drivers/net/ethernet/ti/icssg/ 
> icssg_common. o. annotation 2de875935222b9ecd8483e61848c4fc9
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uldq3TevVoc7KuXEXHnDf- 
> TXtuZ0bON9iO0jTE7PyIS1jjfs_CzpvIiMi93PVt0MVDzjHGQSK__vY_-6rO7q86rFmBMGW4SSqK5pvNE$>
> ZjQcmQRYFpfptBannerEnd
> 
> What I mean is just compile the .o file with and without the unlikely().
> 
> $ md5sum drivers/net/ethernet/ti/icssg/icssg_common.o*
> 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.annotation
> 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.no_anotation
> 
> Generally the rule is that you should leave likely/unlikely() annotations
> out unless it's going to make a difference on a benchmark.  I'm not going
> to jump down people's throat about this, and if you want to leave it,
> it's fine.  But it just struct me as weird so that's why I commented on
> it.
> 

I have done some performance tests to see if unlikely() is gonna make 
any impact and I see around ~9000 pps and 6Mbps drop without unlikely() 
for small packet sizes (60 Bytes)

You can see summary of the tests here:

packet size   with unlikely(pps)  without unlikely(pps)   regression

       60        462377                453251                 9126

       80        403020                399372                 3648

       96        402059                396881                 5178

      120        392725                391312                 4413

      140        327706                327099                 607

packet size  with unlikely(Mbps)  without unlikely(Mbps)  regression

      60         311                   305                    6

      80         335                   332                    3

      96         386                   381                    5

      120        456                   451                    5

      140        430                   429                    1

For more details on the logs, please 
refer:https://gist.github.com/MeghanaMalladiTI/cc6cc7709791376cb486eb1222de67be

Regards,
Meghana Malladi

> regards,
> dan carpenter
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 34d16e00c2ec..3db5bae44e61 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -672,7 +672,7 @@ static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
>   	case XDP_TX:
>   		/* Send packet to TX ring for immediate transmission */
>   		xdpf = xdp_convert_buff_to_frame(xdp);
> -		if (unlikely(!xdpf))
> +		if (!xdpf)
>   			goto drop;
>   
>   		q_idx = smp_processor_id() % emac->tx_ch_num;
> 


