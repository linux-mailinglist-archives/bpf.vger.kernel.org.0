Return-Path: <bpf+bounces-76464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49ECB5977
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 12:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88ED6301EFB4
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE3305044;
	Thu, 11 Dec 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LVqOR9CA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18423EA86;
	Thu, 11 Dec 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450895; cv=none; b=dPjXqDJi5iO/bRlqMK6qU6AZNceKwXpUJ+gkgtLb9I8dSFPsaHR2te/9LKRb32pGLQrjUNbPrTspwOlazXk1hntfcRjxR/8h1hcHI0oCQrxWXWQgXs09XPRpeDGBCgRVNUY+qMB47N28PWICo0cW9LveVC5p2Aw6e/VUgbpLoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450895; c=relaxed/simple;
	bh=bXHQ+EVUUCjMqSYEV7Ix5o6PmAcBXqUtnTQzAimry8E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REn9q5gLhYsI7r/s3NldBX3hkpz1xKKeDmANAOODPnOMUQizcNKVX60zAEMIdk3w3t+jBBIoO2iEz2RdUx2MjdBu6ZDpjjIdABFYa9nQRgwgTl+e5Lyt8ZX0oljMG2WGkbgmcqwN3+QTLt5EXaTshNdq/zA9+wF70B/vGzSFt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LVqOR9CA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAnr8j1714663;
	Thu, 11 Dec 2025 03:00:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IKb5SuuXOLje6jDhYClC4zYsO
	z1AyChW8koXznoMu5I=; b=LVqOR9CA0t66Kub7neOgIslA+bmc7GyUwLM79INMZ
	FDCjHQrHwjGPQl7ytBHJbCqk2DEkz+XCr+bfCva6RbyH9+1hxbvBAYSYl8JswKR3
	hlHBqSCDfng8cXSDT761FltSWnjyEY8VpjpqwZjZfXhyneEQ71iNcYSseaLKKgNL
	ekvUa2gQMO2vPzt3SCTmcvgVkvQzv6Sc3iWD45XD71eMn8NPA3PTWziCVAiDiUBG
	2jy4GYmQbd/yKhZhUqYmSqlIJ3r6izr7WDKl6apPbubB3nSEN/9uHJELzAgpJwI4
	Esb9mjUNtpuIvUmIscfGkPV6JaqQ1o0Rlz5wEk7Bvqzvw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjc895eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 03:00:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Dec 2025 03:00:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Dec 2025 03:00:54 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 3A8F53F70B6;
	Thu, 11 Dec 2025 03:00:37 -0800 (PST)
Date: Thu, 11 Dec 2025 16:30:36 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
        <frank.li@nxp.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Message-ID: <aTqkVJGREUi/fZ4J@test-OptiPlex-Tower-Plus-7010>
References: <20251211020919.121113-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251211020919.121113-1-wei.fang@nxp.com>
X-Proofpoint-ORIG-GUID: egY815O-nHGTaDpco90nCwWS0QApy8fs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA4NCBTYWx0ZWRfX907vjOzoVmFi
 w+kkP93VvzaZETZHfZq9KTcCQ8HaFlt8urEaJqdDYJ3R/5BmFREhJA64cJmvX5GjkpXlVGmEF2D
 pllA2Ui+DB7bKvxhXr15D7F0pkZ5t58KccSumpUNd8T+aCwG9vwg/OBuOvXmHeHpHuPWS3DzE8F
 4A4o582RaWqX7Ma18hc4FLXyjBxy+mNSL1sYW2vvNx7Kl+BRAnBFKnOmJ06eBgCh0K/kLKvubL/
 tJKGx9/Rzjj0xFoGHn9tVF4aQesb270RwGd4nEBued1nbBlwdBv69OV+I5pU4tUGV/QCvKYU2w+
 0r/QuQi2fcmwNUPMzWorA9tgZLENfQ5/1xzUpU0sBOQiPDiG/6BxqhterKUcpbXMz/n3dLG5qdq
 R3bkLy5BSPixPPKmUGCuGHVDmeRMJw==
X-Proofpoint-GUID: egY815O-nHGTaDpco90nCwWS0QApy8fs
X-Authority-Analysis: v=2.4 cv=a+c9NESF c=1 sm=1 tr=0 ts=693aa45b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Nf0woPdXZSKWlNCM:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=M5GUcnROAAAA:8
 a=QFVnriqcIiwCJBnuFMsA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01

On 2025-12-11 at 07:39:19, Wei Fang (wei.fang@nxp.com) wrote:
> In the current implementation, the enetc_xdp_xmit() always transmits
> redirected XDP frames even if the link is down, but the frames cannot
> be transmitted from TX BD rings when the link is down, so the frames
> are still kept in the TX BD rings. If the XDP program is uninstalled,
> users will see the following warning logs.
> 
> fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> 
> More worse, the TX BD ring cannot work properly anymore, because the
> HW PIR and CIR are not equal after the re-initialization of the TX
> BD ring. At this point, the BDs between CIR and PIR are invalid,
> which will cause a hardware malfunction.
> 
> Another reason is that there is internal context in the ring prefetch
> logic that will retain the state from the first incarnation of the ring
> and continue prefetching from the stale location when we re-initialize
> the ring. The internal context is only reset by an FLR. That is to say,
> for LS1028A ENETC, software cannot set the HW CIR and PIR when
> initializing the TX BD ring.
> 
> It does not make sense to transmit redirected XDP frames when the link is
> down. Add a link status check to prevent transmission in this condition.
> This fixes part of the issue, but more complex cases remain. For example,
> the TX BD ring may still contain unsent frames when the link goes down.
> Those situations require additional patches, which will build on this
> one.
> 
> Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> v3 changes:
> 1. Improve the commit message
> 2. Collect Reviewed-by tag
> v2: https://lore.kernel.org/imx/20251209135445.3443732-1-wei.fang@nxp.com/
> v2 changes:
> Improve the commit message
> v1: https://lore.kernel.org/imx/20251205105307.2756994-1-wei.fang@nxp.com/
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 0535e92404e3..f410c245ea91 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	int xdp_tx_bd_cnt, i, k;
>  	int xdp_tx_frm_cnt = 0;
>  
> -	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
> +	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
> +		     !netif_carrier_ok(ndev)))
>  		return -ENETDOWN;
>  
>  	enetc_lock_mdio();
> -- 
> 2.34.1
> 
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com> 

