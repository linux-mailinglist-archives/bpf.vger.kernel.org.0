Return-Path: <bpf+bounces-59036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCBAC5DFF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78724A5724
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BED8F54;
	Wed, 28 May 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KPa9xkJn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038AA2D;
	Wed, 28 May 2025 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390747; cv=none; b=kJnPJysUI6O7bK8aKPSfXhR11EupY/4DlrxThmUvXnaRkwsxaY3RUCO2V/+SFQn+8/rtEw0a8GL2McOaqQ9+ByF4su59Yql0mQ/BM2JukVDs/KQlqJMle4kRE4LyNgf72BcVYTdee0Hu8MU/y2yzbiMmv/yPYfhIvQm8D6OxoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390747; c=relaxed/simple;
	bh=IpRdMgsILcpdxAO7E2U3/J/paPCQk9L6dsR5uiOHUGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YzhsGyPD6ZUjGHFHttxKSZEhsgphrcjMoM1jZrMyhhp9YRf4gwlGjOvljoS4c2lphRPqQ8k5yYkgMTKWqnTLu4MzBTtTdWJgN21hSzTVRgyTh+pDqmP8BtBD46LUvoAPDrDIzPWJ0lb7rRC2IJEnB66g/q83b00QzQoGBN3WyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KPa9xkJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHTw0m029872;
	Wed, 28 May 2025 00:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDUNQStuy0jRMfLgtZNwbSDgWxeyT3CWPdpJ9IflsOA=; b=KPa9xkJnirrwzekO
	bDz3gfL44EL6qyKyMqf8l+ZazG8GyQ+Pp+Q2VEW9BJK+Hrk++Vnco1Ch3P2Hr6aj
	y2+1FGK/8JQE4sOUa6aIl6dR9BS14FycJvUHzIdKiuiEu/YMnJ/6gVoj8dyIxNud
	PYmG99yMkuEOC4P5YhenxRTbg9f+g/1xMcxnKgdP8pqwpyWCROVfg3cvS6lmNWyu
	aRsgre5v8zia5HJlWjSrPuBgQ+32tmg2ZTiKhniIdKp8mCAKdezQVe3lPMEVo29/
	YcsC2kt0lYQFYlgVT5A5/oBiI8U8KSWMIuuAXsXOdYdlOY0+/PgK+rdGNxne2Ulg
	yPZZuA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf0v68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 00:04:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S04wpi029950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 00:04:58 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 May
 2025 17:04:58 -0700
Message-ID: <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
Date: Tue, 27 May 2025 17:04:52 -0700
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
        Andrew Lunn
	<andrew@lunn.ch>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <richardcochran@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <fancer.lancer@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ahalaney@redhat.com>,
        <xiaolei.wang@windriver.com>, <rohan.g.thomas@intel.com>,
        <Jianheng.Zhang@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>, <horms@kernel.org>,
        <florian.fainelli@broadcom.com>,
        Sagar Cheluvegowda
	<quic_scheluve@quicinc.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
 <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
 <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=6836532b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=Q-fNiiVtAAAA:8 a=GcoI09lhNaN5Dz-92OEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zpgw-8AFVHvXHtIYfQ8he9X3VaAn-d9R
X-Proofpoint-GUID: zpgw-8AFVHvXHtIYfQ8he9X3VaAn-d9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDIwNSBTYWx0ZWRfX8H1fR9ASfCTa
 ZlnZzyxxTeEKKwpoBS+icLkuaoKXs4Azv6NRGJGyRSh+Ov1Dgd8gUpITWQcc8f917X6MsQWXJq8
 DNiWojEgXqeKeMQ4jEMgKanGjYrxyECFJlj77JL2zanB+lj6nZJBW95l4BphnN2vvIlMiVmgwiG
 AqJX7RuCgI6rc+kZzA731mkW4JFsWNk7eazg4sZGM9zNctL3mnh3Es4qQD9rOEXN+PfGop+t8YK
 4PQvT7toq/X8Cuj+P45Z4i+lAXRLvdR/ZQJvDfl3uAXazTazV/Z/vG6s6ytO7h6LH0anFkC4EMp
 0bzre8YvTRSTEe/CQ5IcStqOjxZeBE6zyiQnvZzPxlrc58QS/arf2cuUmTGcfBvpuN5lQDEPlRC
 FRBsxV9WT+kO5VYpNEo/kls+YIB6bYXc3PQOoGZWTk6jxeRYgVk8T+OpApL1UpiHg9e822RW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270205



On 2/7/2025 3:18 PM, Jitendra Vegiraju wrote:
> Hi Abhishek,
> 
> On Fri, Feb 7, 2025 at 10:21 AM Abhishek Chauhan (ABC) <
> quic_abchauha@quicinc.com> wrote:
> 
>>
>>
>> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
>>> Hi netdev team,
>>>
>>> On Fri, Oct 18, 2024 at 1:53 PM <jitendra.vegiraju@broadcom.com> wrote:
>>>>
>>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>>>
>>>> This patchset adds basic PCI ethernet device driver support for Broadcom
>>>> BCM8958x Automotive Ethernet switch SoC devices.
>>>>
>>>
>>> I would like to seek your guidance on how to take this patch series
>> forward.
>>> Thanks to your feedback and Serge's suggestions, we made some forward
>>> progress on this patch series.
>>> Please make any suggestions to enable us to upstream driver support
>>> for BCM8958x.
>>
>> Jitendra,
>>          Have we resent this patch or got it approved ? I dont see any
>> updates after this patch.
>>
>>
> Thank you for inquiring about the status of this patch.
> As stmmac driver is going through a maintainer transition, we wanted to
> wait until a new maintainer is identified.
> We would like to send the updated patch as soon as possible.
> Thanks,
> Jitendra
Thanks Jitendra, I am sorry but just a follow up. 

Do we know if stmmac maintainer are identified now ?

Andrew/Russell - Can you please help us ? 

Best regards
ABC

> 

