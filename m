Return-Path: <bpf+bounces-50797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA3A2CB6D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767F8188A39B
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CD1DF271;
	Fri,  7 Feb 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E03V5WVd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64F1A314E;
	Fri,  7 Feb 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952668; cv=none; b=Skx+Epa0GQJp3iWLGe9PpIv5Bw04XZV/8nxOlwfLbKNLK5V/UDoGuop8kDjPOPxlFz3F+sL8sjWjxIgihJHTYteHTfIbyWMY5mnlGoYzOjpp8FH58YzclB88+xXifdJDmp3pvPC0vOg3V+JJ4ma/ma7P3LT2EoVLhQCPx46dur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952668; c=relaxed/simple;
	bh=FhhB4c8kNy0sdg1h6MWe7LzbIqu9Q4gW5zAslqAxxYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qiYDqi5Lx1ZHbZ2oYEEIJoY2p36ZuLfDUkItc4AHA/MVhaOtKT93Ocd1tMvYf3D5LoNudqgAIw3lX7+okje4I4u2ja7qht8jet5htqdA1Zg4fg2eDhaiS4h4SH39Ugrs8yNsVI3JB9Gd0RsjHjIOVfZbqBK5mxql+WaRbooqPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E03V5WVd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517CT9pQ010620;
	Fri, 7 Feb 2025 18:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24vCB/Znf/TjzLM/rAbzJHPouiMnIdlOj3IaBxZTHOA=; b=E03V5WVdh1fY1DbW
	yBGjR8ooUk49Udw8Yr32oTNz88DdkkXzhfc4KbaBHW/INhjp6UGF0M5G/UAg7bCw
	S9AiqmeMDOSlhBQUMBp8rA+fLZOH2c+u9MLB6qy37fUeKdiH9NmFOFgkMGU+hXRk
	DQ90WmK62P4xV7Tryte3Dsuus4bSV2YEXKbDFX16lYR+nWN8WkgwZVffiKtWFxjA
	7vIqKvZ8015aTGkRDpuxE/TxwPNdNgi0HySfB75yl/t+FCk+wuvIdgrQga1jFG+v
	IjE2AbkHni6qP2AtopA/KGwkaBJieEKSxxwV7Wz90tGNC4+Kj8I+EbZm1kgg8gc2
	E4gLFg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nj6w8v2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 18:21:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517ILXDi023451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 18:21:33 GMT
Received: from [10.110.91.228] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Feb 2025
 10:21:32 -0800
Message-ID: <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
Date: Fri, 7 Feb 2025 10:21:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
        <netdev@vger.kernel.org>
CC: <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <richardcochran@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <fancer.lancer@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ahalaney@redhat.com>,
        <xiaolei.wang@windriver.com>, <rohan.g.thomas@intel.com>,
        <Jianheng.Zhang@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>, <horms@kernel.org>,
        <florian.fainelli@broadcom.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OOmFY7SmVHmL41lJG0u5sLFBwJ4eloTj
X-Proofpoint-GUID: OOmFY7SmVHmL41lJG0u5sLFBwJ4eloTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=832 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070137



On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
> Hi netdev team,
> 
> On Fri, Oct 18, 2024 at 1:53 PM <jitendra.vegiraju@broadcom.com> wrote:
>>
>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>
>> This patchset adds basic PCI ethernet device driver support for Broadcom
>> BCM8958x Automotive Ethernet switch SoC devices.
>>
>> This SoC device has PCIe ethernet MAC attached to an integrated ethernet
>> switch using XGMII interface. The PCIe ethernet controller is presented to
>> the Linux host as PCI network device.
>>
>> The following block diagram gives an overview of the application.
>>              +=================================+
>>              |       Host CPU/Linux            |
>>              +=================================+
>>                         || PCIe
>>                         ||
>>         +==========================================+
>>         |           +--------------+               |
>>         |           | PCIE Endpoint|               |
>>         |           | Ethernet     |               |
>>         |           | Controller   |               |
>>         |           |   DMA        |               |
>>         |           +--------------+               |
>>         |           |   MAC        |   BCM8958X    |
>>         |           +--------------+   SoC         |
>>         |               || XGMII                   |
>>         |               ||                         |
>>         |           +--------------+               |
>>         |           | Ethernet     |               |
>>         |           | switch       |               |
>>         |           +--------------+               |
>>         |             || || || ||                  |
>>         +==========================================+
>>                       || || || || More external interfaces
>>
>> The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
>> MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
>> scalability.
>>
>> Driver functionality specific to new MAC (DW25GMAC) is implemented in
>> new file dw25gmac.c.
>>
>> Management of integrated ethernet switch on this SoC is not handled by
>> the PCIe interface.
>> This SoC device has PCIe ethernet MAC directly attached to an integrated
>> ethernet switch using XGMII interface.
>>
>> v5->v6:
>>    Change summary to address comments/suggestions by Serge Semin.
>>    Patch1:
>>      Removed the comlexity of hdma mapping in previous patch series and
>>      use static DMA mapping.
>>      Renamed plat_stmmacenet_data::snps_dev_id as dev_id and moved to
>>      the beginning of the struct.
>>    Patch2:
>>      Added dw25gmac_get_hw_feature() for dw25gmac.
>>      Use static one-to-one VDMA-TC-PDMA mapping.
>>    Patch4:
>>      Remove usage of plat_stmmacenet_data::msi_*_vec variables for
>>      interrupt vector initialization.
>>      Change phy_interface type to XGMII.
>>      Cleanup unused macros.
>>
> 
> I would like to seek your guidance on how to take this patch series forward.
> Thanks to your feedback and Serge's suggestions, we made some forward
> progress on this patch series.
> Please make any suggestions to enable us to upstream driver support
> for BCM8958x.

Jitendra,
	 Have we resent this patch or got it approved ? I dont see any updates after this patch. 

> Thanks,
> Jitendra

