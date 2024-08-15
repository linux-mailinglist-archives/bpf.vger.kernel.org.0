Return-Path: <bpf+bounces-37341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2588953DED
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A701F22242
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC10156C62;
	Thu, 15 Aug 2024 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VJVWBe4u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C01AC897;
	Thu, 15 Aug 2024 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764695; cv=none; b=Kk/tx+Hloe2nAJ+LMk/ag2REF9in/9/NMrCqUdLVRjHruneoVVeva8Fh9G0UaRGaHzJ+peitxpOgWEX+yhIPkqKobMNvnPYBuhblbgVDgfoJti7YXUedT/06YMCiqr7Xvhsi/2YD6/KytLpj6snHG1ARxQCRDMrMDvJwAk0gWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764695; c=relaxed/simple;
	bh=qXz/ssZwDPPTCVUF9wgWuSXjbU0Ny93i6rKAEkva0kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ODvy9Ni72SEtnQJUEZ4UVW2lLVm3tMYWQxomOirvvnYTwRz0M6WM6cyhlEL0QyFjMpa1hENph1jvEGPruARpXJgTSzAl+V7NxER1paafZACSROAaKrJ5bhmzgVLGEJ9h3Zwg7jIGiNgRq+BD6zIpmKC+yEKAgPlZLfEwMqX5wXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VJVWBe4u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FKcADN017978;
	Thu, 15 Aug 2024 23:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xui2spjGje6pCXlMy7bJ20vZUsBjTeOYHBfaMs++FG4=; b=VJVWBe4uzzpmdLcp
	Ixt5Y6/P8L0MrOMviZ6DsB5GhUEcLgnTvL6g92676WJLLJwLblAAWqORwF7i7Y2x
	BprknDC52My8QxKXd1owzgSYZsEadxeB58Kz7R2JNe/eAHIqGvhU2YKBCLFvOrVF
	mh7GsJncoqeDppUS/UD5l1D+1tYA16YPqySZVUx84QFe7f3OFbeElBwpjwdqRtA4
	H2YhlKWxxl4cjmNSdfcXcBZ6zHh7OyWf2kCowR9HhytkqQqqMJmWtQxe1kpGbJx4
	AiUdOjtS0nn1RoFOR2x4TblGB3APo+Ahg7DrsoD0kR4YiRNWlz+mNsgAWtnz/7uZ
	JfhDEQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411rvr891p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 23:30:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47FNUfpX005445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 23:30:41 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 Aug
 2024 16:30:40 -0700
Message-ID: <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
Date: Thu, 15 Aug 2024 16:30:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 1/5] net: stmmac: Add HDMA mapping for dw25gmac
 support
To: <jitendra.vegiraju@broadcom.com>, <netdev@vger.kernel.org>
CC: <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <richardcochran@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <fancer.lancer@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ahalaney@redhat.com>,
        <xiaolei.wang@windriver.com>, <rohan.g.thomas@intel.com>,
        <Jianheng.Zhang@synopsys.com>, <leong.ching.swee@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>, <horms@kernel.org>,
        <florian.fainelli@broadcom.com>,
        Sagar Cheluvegowda
	<quic_scheluve@quicinc.com>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-2-jitendra.vegiraju@broadcom.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240814221818.2612484-2-jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D26Z6C0OL0tCkQUExsEuaABgFByfXNjD
X-Proofpoint-ORIG-GUID: D26Z6C0OL0tCkQUExsEuaABgFByfXNjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_15,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150171



On 8/14/2024 3:18 PM, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Add hdma configuration support in include/linux/stmmac.h file.
> The hdma configuration includes mapping of virtual DMAs to physical DMAs.
> Define a new data structure stmmac_hdma_cfg to provide the mapping.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  include/linux/stmmac.h | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 338991c08f00..1775bd2b7c14 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -89,6 +89,55 @@ struct stmmac_mdio_bus_data {
>  	bool needs_reset;
>  };
>  
> +/* DW25GMAC Hyper-DMA Overview
> + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
> + * channels using a smaller set of physical DMA channels(PDMA).
> + * This is supported by the  mapping of VDMAs to Traffic Class (TC)
> + * and PDMA to TC in each traffic direction as shown below.
> + *
> + *        VDMAs            Traffic Class      PDMA
> + *       +--------+          +------+         +-----------+
> + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
> + *TX     +--------+   |----->+------+         +-----------+
> + *Host=> +--------+   |      +------+         +-----------+ => MAC
> + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
> + *       +--------+          +------+    |    +-----------+
> + *       +--------+          +------+----+    +-----------+
> + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
> + *       +--------+          +------+         +-----------+
> + *            .                 .                 .
> + *       +--------+          +------+         +-----------+
> + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
> + *       +--------+          +------+         +-----------+
> + *
> + *       +------+          +------+         +------+
> + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
> + *       +------+   |----->+------+         +------+
> + *MAC => +------+   |      +------+         +------+
> + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  => Host
> + *       +------+          +------+    |    +------+
> + *            .                 .                 .
> + */
> +
> +#define STMMAC_DW25GMAC_MAX_NUM_TX_VDMA		128
> +#define STMMAC_DW25GMAC_MAX_NUM_RX_VDMA		128
> +
> +#define STMMAC_DW25GMAC_MAX_NUM_TX_PDMA		8
> +#define STMMAC_DW25GMAC_MAX_NUM_RX_PDMA		10
> +
I have a query here. 

Why do we need to hardcode the number of TX PDMA and RX PDMA to 8 an 10. On some platforms the number of supported TXPDMA and RXPDMA are 11 and 11 respectively ? 

how do we overcome this problem, do we increase the value in such case? 

> +#define STMMAC_DW25GMAC_MAX_TC			8
> +
> +/* Hyper-DMA mapping configuration
> + * Traffic Class associated with each VDMA/PDMA mapping
> + * is stored in corresponding array entry.
> + */
> +struct stmmac_hdma_cfg {
> +	u8 tvdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_VDMA];
> +	u8 rvdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_VDMA];
> +	u8 tpdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_PDMA];
> +	u8 rpdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_PDMA];
> +};
> +
>  struct stmmac_dma_cfg {
>  	int pbl;
>  	int txpbl;
> @@ -101,6 +150,7 @@ struct stmmac_dma_cfg {
>  	bool multi_msi_en;
>  	bool dche;
>  	bool atds;
> +	struct stmmac_hdma_cfg *hdma_cfg;
>  };
>  
>  #define AXI_BLEN	7

