Return-Path: <bpf+bounces-37659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F955959104
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7E91F249D1
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B71C824A;
	Tue, 20 Aug 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eeVY0+BW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E9189BB6;
	Tue, 20 Aug 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195900; cv=none; b=eoJxPi/dQPParbiEb7LkFGJIQll534aF1sVU7RK2CjWKUSMDfsGBs29frstTRPrYba8gmXiSJ6idiHepa6je9a1ksowTJJZhL12ypLkJlvqm3E480+7Bp/72aX5nUdCwt0nKKyBstqtfML/3CCvnu8ZF6JUIURO3lS6uLvcbZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195900; c=relaxed/simple;
	bh=nPfBSobHC8+jfRoUOFOFdAJ50B5o+72hFzHIT5ZtUi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PUfxqHI/wc7ULC+G4JNUjSBDg2V1ddc16auA2XR6J9EGd5iuqKBqFU87Gr9xORjcBQ0IWr7a1vU4I/+KB63NZlJ4VJW9tlVySrEQB6PjaFWaQ894xWOscPHQBCC/YLlCkuzejVAI3BmKFXn8POt9UvIlDaieOx3EN0cgD7igcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eeVY0+BW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KJDEfS010532;
	Tue, 20 Aug 2024 23:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NprW64KSKzwOFF6jo1JC3Lh788yHamO3HdbBMZJQ/MI=; b=eeVY0+BW5Y003jD1
	wWZSdsM7V5k9PGOpndK7aMp2cq1IULmj4qA25ufm/M9+ubY5c3gSFwvjgd1ifgVU
	/qr4ZsdysYOCm3MedjKKDXVkdxhTmeK3tGKoyc1hg0aoTNEi07Q2VaYNFArRrezj
	Ubbgx9zUyGcpaYNfAOvdBrynBV/AP9lvxEFrYRoUXkQ9XdV59VJxyuRAMTJu/Em9
	5JIcyEcFZzVzjtlultQ05s23D3lE2MwigFLeHKSmRBILaqktepa8FHZqqLsdWC2Q
	2jm4WQIxZqBo/DQksue0niBfVQFxE4YEIV4Ttvx5H5ehXAWsnXSpd4pzLK38Foa0
	ob6v3w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg6vef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 23:12:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KNCref023267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 23:12:53 GMT
Received: from [10.110.47.196] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 16:12:52 -0700
Message-ID: <cab82577-9979-464f-84a2-02962b1641fc@quicinc.com>
Date: Tue, 20 Aug 2024 16:12:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 1/5] net: stmmac: Add HDMA mapping for dw25gmac
 support
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
CC: <netdev@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
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
 <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
 <CAMdnO-LH0xNeMO_Y+WhSmbyNrK33zb=AtVd9ZRTObQ-n8BWR6w@mail.gmail.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <CAMdnO-LH0xNeMO_Y+WhSmbyNrK33zb=AtVd9ZRTObQ-n8BWR6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZR126PUREwqS3M4XNHxBzJ3D4QSZwj2G
X-Proofpoint-GUID: ZR126PUREwqS3M4XNHxBzJ3D4QSZwj2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200170



On 8/20/2024 4:10 PM, Jitendra Vegiraju wrote:
> On Thu, Aug 15, 2024 at 4:30 PM Abhishek Chauhan (ABC)
> <quic_abchauha@quicinc.com> wrote:
>>
>>
>>
>> On 8/14/2024 3:18 PM, jitendra.vegiraju@broadcom.com wrote:
>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>>
>>> Add hdma configuration support in include/linux/stmmac.h file.
>>> The hdma configuration includes mapping of virtual DMAs to physical DMAs.
>>> Define a new data structure stmmac_hdma_cfg to provide the mapping.
>>>
>>> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>> ---
>>>  include/linux/stmmac.h | 50 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 50 insertions(+)
>>>
>>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>> index 338991c08f00..1775bd2b7c14 100644
>>> --- a/include/linux/stmmac.h
>>> +++ b/include/linux/stmmac.h
>>> @@ -89,6 +89,55 @@ struct stmmac_mdio_bus_data {
>>>       bool needs_reset;
>>>  };
>>>
>>> +/* DW25GMAC Hyper-DMA Overview
>>> + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
>>> + * channels using a smaller set of physical DMA channels(PDMA).
>>> + * This is supported by the  mapping of VDMAs to Traffic Class (TC)
>>> + * and PDMA to TC in each traffic direction as shown below.
>>> + *
>>> + *        VDMAs            Traffic Class      PDMA
>>> + *       +--------+          +------+         +-----------+
>>> + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
>>> + *TX     +--------+   |----->+------+         +-----------+
>>> + *Host=> +--------+   |      +------+         +-----------+ => MAC
>>> + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
>>> + *       +--------+          +------+    |    +-----------+
>>> + *       +--------+          +------+----+    +-----------+
>>> + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
>>> + *       +--------+          +------+         +-----------+
>>> + *            .                 .                 .
>>> + *       +--------+          +------+         +-----------+
>>> + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
>>> + *       +--------+          +------+         +-----------+
>>> + *
>>> + *       +------+          +------+         +------+
>>> + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
>>> + *       +------+   |----->+------+         +------+
>>> + *MAC => +------+   |      +------+         +------+
>>> + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  => Host
>>> + *       +------+          +------+    |    +------+
>>> + *            .                 .                 .
>>> + */
>>> +
>>> +#define STMMAC_DW25GMAC_MAX_NUM_TX_VDMA              128
>>> +#define STMMAC_DW25GMAC_MAX_NUM_RX_VDMA              128
>>> +
>>> +#define STMMAC_DW25GMAC_MAX_NUM_TX_PDMA              8
>>> +#define STMMAC_DW25GMAC_MAX_NUM_RX_PDMA              10
>>> +
>> I have a query here.
>>
>> Why do we need to hardcode the number of TX PDMA and RX PDMA to 8 an 10. On some platforms the number of supported TXPDMA and RXPDMA are 11 and 11 respectively ?
>>
>> how do we overcome this problem, do we increase the value in such case?
>>
> Hi Abhishek,
> Agreed, we can make the mapping tables more generic.
> We will replace static arrays with dynamically allocated memory by
> reading the TXPDMA and RXPDMA counts from hardware.
> Thanks

That's a great idea. Thanks Jitendra. This way we do not have to hard code anything. 

>>> +#define STMMAC_DW25GMAC_MAX_TC                       8
>>> +
>>> +/* Hyper-DMA mapping configuration
>>> + * Traffic Class associated with each VDMA/PDMA mapping
>>> + * is stored in corresponding array entry.
>>> + */
>>> +struct stmmac_hdma_cfg {
>>> +     u8 tvdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_VDMA];
>>> +     u8 rvdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_VDMA];
>>> +     u8 tpdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_PDMA];
>>> +     u8 rpdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_PDMA];
>>> +};
>>> +
>>>  struct stmmac_dma_cfg {
>>>       int pbl;
>>>       int txpbl;
>>> @@ -101,6 +150,7 @@ struct stmmac_dma_cfg {
>>>       bool multi_msi_en;
>>>       bool dche;
>>>       bool atds;
>>> +     struct stmmac_hdma_cfg *hdma_cfg;
>>>  };
>>>
>>>  #define AXI_BLEN     7

