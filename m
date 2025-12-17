Return-Path: <bpf+bounces-76858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E1CC73E4
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 673A6301B74B
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C21345CB5;
	Wed, 17 Dec 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eiT+qOKB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84333BBD1;
	Wed, 17 Dec 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969756; cv=none; b=LtLdHZtlZkLCbKWR35PV+nJ7JA5ACyplJmHXNskG01mioqRaregOEzsJITGT6oeFpWXlAUdFdc7DBRGmGCEeCh6pqafGzwUjqxCLpt7xIBL1p06qNnYndtygB9dfuoJNf2e+vs3y/5eIC1HCvFb2c9lH3A0x10S2CtzBSIOCFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969756; c=relaxed/simple;
	bh=hmqOoZZJvHvHQXt9UC424KsCOsv4Rx0pjW0fYiw28i4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joPa7sWPrUhjMfbsltPnugP+VVGdwKQVzpqGD2x7c/nQai823szr+3j1B0FFdPYaqK+fMy3lkXO9ciXO74oBGOIxKZEvgv1kWPEqTkM5CuDvdA8Lp3H3zibR5TbZ35fYY24fbMCZ/+/U+w+3c6iiKKXrwUnIHOrOkGE6qZ9L5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eiT+qOKB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6pd1S1394915;
	Wed, 17 Dec 2025 03:08:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=L5LfAcotcrApoC11pZx/JxZ2v
	PnVWo323nWO/uSuVGM=; b=eiT+qOKBKXFLUlfIJE/OqlHxxJzcxqdo3khktYh7M
	JJJoWnbK4zkGgbDEnQZs9zsorZZ/ePTPeyC0ddhc8GyBZ19Ei92iFcVXyZTUcAs1
	QDgWLJhQQOh5utJBw2FSHF7HrKnjFQvzVIuQNK+htF059FH59R1vDTBg/5tzhwK1
	VDkyGLnQonH294E6/vcOyUhLZ9xhGTXFW1xCx913kiNCEwjsUWCSyCGjD+GKyelB
	3fddBPeHhr8qJlJwKdjCzkos7Vk68j2iDkyARKqWVZLX4y2SPIc7g82GBuN+iJ90
	n6R5M6kdlfXnBYDgroEbEbHC8fGTH4nRzSronGt0zioqQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b3qm30dvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 03:08:21 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Dec 2025 03:08:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Dec 2025 03:08:33 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 1A6253F7063;
	Wed, 17 Dec 2025 03:08:13 -0800 (PST)
Date: Wed, 17 Dec 2025 16:38:13 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <sdf@fomichev.me>, <rmk+kernel@armlinux.org.uk>, <0x1207@gmail.com>,
        <hayashi.kunihiko@socionext.com>, <vladimir.oltean@nxp.com>,
        <boon.leong.ong@intel.com>, <imx@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: fix the crash issue for zero copy
 XDP_TX action
Message-ID: <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204071332.1907111-1-wei.fang@nxp.com>
X-Authority-Analysis: v=2.4 cv=d8j4CBjE c=1 sm=1 tr=0 ts=69428f25 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=w373o-ZMvzc93a0z:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=Kl3X-cPyiDMRo7OHHioA:9
 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: XdCkQVAvRv7gCtPhPvNC9ks__pJciWRQ
X-Proofpoint-ORIG-GUID: XdCkQVAvRv7gCtPhPvNC9ks__pJciWRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4OCBTYWx0ZWRfX4NQw4KFTQd+R
 vaaSpXxOppCubo56wif2WEVBU+MZIU384E0wV47reSde0d3PkVCNXxtBiMAhRaXiM1K+YXYKNrI
 7/8ZnckBz0Y/R+05DY1y1l0ISKdioUUnaEt2AEG6MmXubWc3FmsuIwafkJEGXnZvr4SkvCdU6eL
 LGnJsKisU3rQpLNFOXniyfLAdJZXZ+uplzOD+AM61lnQw2fm4+LXYyX5w2kG6M1mNiRMweaiLVc
 Ugrf9/Y9KgagUPwLEnNCdOuVWP210548nYgoXqH3FcJwk6rrSJUssqzcTSJbqZbPmnAAoGWE41M
 U84WjISbO9T+adVuTWQJh55aqyWtJ0b9vdqJn0obyyWmB4d9GMuUCJrvoU84kpTh5ka3AzKaUmw
 r9SSUybpcrocJDUwJbSGFNPmq/ifvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01

On 2025-12-04 at 12:43:32, Wei Fang (wei.fang@nxp.com) wrote:
> There is a crash issue when running zero copy XDP_TX action, the crash
> log is shown below.
> 
> [  216.122464] Unable to handle kernel paging request at virtual address fffeffff80000000
> [  216.187524] Internal error: Oops: 0000000096000144 [#1]  SMP
> [  216.301694] Call trace:
> [  216.304130]  dcache_clean_poc+0x20/0x38 (P)
> [  216.308308]  __dma_sync_single_for_device+0x1bc/0x1e0
> [  216.313351]  stmmac_xdp_xmit_xdpf+0x354/0x400
> [  216.317701]  __stmmac_xdp_run_prog+0x164/0x368
> [  216.322139]  stmmac_napi_poll_rxtx+0xba8/0xf00
> [  216.326576]  __napi_poll+0x40/0x218
> [  216.408054] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> For XDP_TX action, the xdp_buff is converted to xdp_frame by
> xdp_convert_buff_to_frame(). The memory type of the resulting xdp_frame
> depends on the memory type of the xdp_buff. For page pool based xdp_buff
> it produces xdp_frame with memory type MEM_TYPE_PAGE_POOL. For zero copy
> XSK pool based xdp_buff it produces xdp_frame with memory type
> MEM_TYPE_PAGE_ORDER0. However, stmmac_xdp_xmit_back() does not check the
> memory type and always uses the page pool type, this leads to invalid
> mappings and causes the crash. Therefore, check the xdp_buff memory type
> in stmmac_xdp_xmit_back() to fix this issue.
> 
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7b90ecd3a55e..a6664f300e4a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -88,6 +88,7 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
>  #define STMMAC_XDP_CONSUMED	BIT(0)
>  #define STMMAC_XDP_TX		BIT(1)
>  #define STMMAC_XDP_REDIRECT	BIT(2)
> +#define STMMAC_XSK_CONSUMED	BIT(3)
>  
>  static int flow_ctrl = 0xdead;
>  module_param(flow_ctrl, int, 0644);
> @@ -4988,6 +4989,7 @@ static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
>  static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
>  				struct xdp_buff *xdp)
>  {
> +	bool zc = !!(xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL);
>  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>  	int cpu = smp_processor_id();
>  	struct netdev_queue *nq;
> @@ -5004,9 +5006,18 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
>  	/* Avoids TX time-out as we are sharing with slow path */
>  	txq_trans_cond_update(nq);
>  
> -	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
> -	if (res == STMMAC_XDP_TX)
> +	/* For zero copy XDP_TX action, dma_map is true */
> +	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
	Seems stmmac_xdp_xmit_xdpf is using dma_map_single if we pass zc is true.
        Ideally in case of zc, driver can use page_pool_get_dma_addr, may be you
        need pass zc param as false. Please check

Thanks,
Hariprasad k
	

