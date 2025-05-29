Return-Path: <bpf+bounces-59274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E349AC77A1
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 07:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4184E7567
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD3253B64;
	Thu, 29 May 2025 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gfuFudMP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31C212B3D;
	Thu, 29 May 2025 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496355; cv=none; b=Mh7dxuAK1Ikt2VWwcT4TSyMKtLqQaKiMzW+In4QobaQjD8cSAH/O78GYSOc1L9r9xdfMl7RQC8mhwh52R+PjuHcE0+NUxtxKy9KWTqAtwdZo+XGa8QTD/gXyR2liT8SHCYYcAgupsHyJDQdp5LMulm1lecwu2pt86vUjgitbQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496355; c=relaxed/simple;
	bh=iZVBJrkksb1yJxQ0iRCSBWW4c1nVnbLOB4xN8Bu0ES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jxkbeZnVvXzTFYowglW3ex5Mz4GrbMHlcZ7Dd/uN9EHgeZ4K0C0iOlkrpTRtoiVUCSBmL4Z7T6FJHCtZHS4Knkt3irBnrcMHr4679WTQJupiJCyDU/AbIrA0mAxmG6cTXG6LGEg8z0vL1SQHEHK5FIv4b/lgcyBv6EQUr9fsgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gfuFudMP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T1v4g6027799;
	Thu, 29 May 2025 05:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bclMJflGoDpC6u6S0sgwywANy1Dvb6NmfRTSgcnga8=; b=gfuFudMPZX8QmICH
	lK/MDFO/urA3YUB7PUkY9heR7oKbGEVLtf/b4GZ/NbXAIR7ZHy5ppV/RahbmZdFj
	rCke3UDlY78wOEyOkxWI3AtXI70LKoZPWPwqnjAeYm/gfXFU+Z0NblKGhOyKs45z
	3ACa6+JHjmhD17+sr52YSr7IQBEVWj4+XmizShblWHk3q3aNp1uPFNJA1LerWMf4
	q8XKkwcvzKOF0sFXt/D6jxA+w1Dqz5TbfIJv7U4a4azrXBKyd5KXzVWDpZTK9owa
	Whgi431bc1xvNaAkk6F4srEOTIKl1yO4gYHOrCrQwvYTUsaTYrqILCr3w2qvxZCC
	Z+HbiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w992pn2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 05:25:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54T5P2KF001100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 05:25:02 GMT
Received: from [10.110.61.81] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 May
 2025 22:24:59 -0700
Message-ID: <4a2d8151-9dfe-4876-8216-85211bc393bf@quicinc.com>
Date: Wed, 28 May 2025 22:24:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: Yanteng Si <si.yanteng@linux.dev>,
        Jitendra Vegiraju
	<jitendra.vegiraju@broadcom.com>
CC: Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>,
        <netdev@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <richardcochran@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <fancer.lancer@gmail.com>,
        <ahalaney@redhat.com>, <xiaolei.wang@windriver.com>,
        <rohan.g.thomas@intel.com>, <Jianheng.Zhang@synopsys.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>,
        <linux@armlinux.org.uk>, <horms@kernel.org>,
        <florian.fainelli@broadcom.com>,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
 <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
 <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
 <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
 <51768fa6-007e-4f30-ac1f-eed01ae1a3c5@linux.dev>
 <CAMdnO-KNfH79PG1=21Dbyaart2JN_e1XcF+tTG93BG5BobX+Gg@mail.gmail.com>
 <eb591c65-0106-45f4-9e57-434dac54e923@linux.dev>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <eb591c65-0106-45f4-9e57-434dac54e923@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA1MiBTYWx0ZWRfX9bwkRqe3K7hG
 kT3bBMtM8uLQJVSK417IAU/yZF63z2rQ9MKu6HMC1yx4K1qKM8kM0pesMcTFWNz7JPBOHiLiSoL
 6MuctcgekxCHSeBUTXfkWOkgurqK9WssRnT45uQaqyAWl41mkdp3hsg93TZ//s5OVDusK1x5plv
 APDKLiOkUiB9WmsCUGsvDWHtPf4ZYzDJt4/4qB6I0GToxwOdFR+WAJJ3umMVrGE3UDb+qtuAyF/
 TVSLWVyY/G+8+LXCW9Z0I2IUo0jNdOJa7ardbZKN/75/iUEiwfTPrAD8G/nVWYRGKfGAnUXdoka
 EwOrPWtHoA88mt+u1YJmoGD5/YWwqaR6Q6vf5epjIHh5b0MneOOjIamii5K4BpJcEmY9jHfbcuK
 3fnxSdsHlkvDI6cd60spXD+eDbyTlOlWaPHSy06FPitmU8yZVaTi+8rx22GBtjbI1hL1agtK
X-Authority-Analysis: v=2.4 cv=Fes3xI+6 c=1 sm=1 tr=0 ts=6837efaf cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=Q-fNiiVtAAAA:8 a=COk6AnOGAAAA:8 a=CyOmcBoVXlxtOUliTrsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ta8-0ys4Gq8QeTxmA8W3M6poBTkirC5h
X-Proofpoint-ORIG-GUID: ta8-0ys4Gq8QeTxmA8W3M6poBTkirC5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290052



On 5/28/2025 10:14 PM, Yanteng Si wrote:
> 
> 在 5/29/25 10:56 AM, Jitendra Vegiraju 写道:
>> Hi Yanteng,
>>
>> On Wed, May 28, 2025 at 6:36 PM Yanteng Si <si.yanteng@linux.dev> wrote:
>>> 在 5/28/25 8:04 AM, Abhishek Chauhan (ABC) 写道:
>>>>
>>>> On 2/7/2025 3:18 PM, Jitendra Vegiraju wrote:
>>>>> Hi Abhishek,
>>>>>
>>>>> On Fri, Feb 7, 2025 at 10:21 AM Abhishek Chauhan (ABC) <
>>>>> quic_abchauha@quicinc.com> wrote:
>>>>>
>>>>>>
>>>>>> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
>>>>>>> Hi netdev team,
>>>>>>>
>>>>>>> On Fri, Oct 18, 2024 at 1:53 PM <jitendra.vegiraju@broadcom.com> wrote:
>>>>>>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>>>>>>>>
>>>>>>>> This patchset adds basic PCI ethernet device driver support for Broadcom
>>>>>>>> BCM8958x Automotive Ethernet switch SoC devices.
>>>>>>>>
>>>>>>> I would like to seek your guidance on how to take this patch series
>>>>>> forward.
>>>>>>> Thanks to your feedback and Serge's suggestions, we made some forward
>>>>>>> progress on this patch series.
>>>>>>> Please make any suggestions to enable us to upstream driver support
>>>>>>> for BCM8958x.
>>>>>> Jitendra,
>>>>>>            Have we resent this patch or got it approved ? I dont see any
>>>>>> updates after this patch.
>>>>>>
>>>>>>
>>>>> Thank you for inquiring about the status of this patch.
>>>>> As stmmac driver is going through a maintainer transition, we wanted to
>>>>> wait until a new maintainer is identified.
>>>>> We would like to send the updated patch as soon as possible.
>>>>> Thanks,
>>>>> Jitendra
>>>> Thanks Jitendra, I am sorry but just a follow up.
>>>>
>>>> Do we know if stmmac maintainer are identified now ?
>>> I'm curious why such a precondition is added？
>>>
>> It's not a precondition. Let me give some context.
>> This patch series adds support for a new Hyper DMA(HDMA) MAC from Synopsis.
>> Many of the netdev community members reviewed the patches at that time.
>> Being the module maintainer at that time, Serge took the initiative to
>> guide us through integrating the new MAC into the stmmac driver.
>> We addressed all the review comments and submitted the last patch series.
>> Without an official maintainer, we didn't get feedback on the last patch series.
>> Because of this, we wanted to wait until a new maintainer is assigned
>> to this module.
>> As Abhishek expressed in his email, it appears the HDMA MAC is
>> becoming more mainstream.
>> We are hoping to rebase the patch series and resubmit for review if
>> netdev team members show interest.
> 
> 
> https://lore.kernel.org/netdev/20241018205332.525595-1-jitendra.vegiraju@broadcom.com/
> 
> In my opinion, the precondition for waiting for a maintainer is that
> 
> the patch set has passed the review. I checked lore and did not find
> 
> any R&B tags in the patch set, which means your patch set has not
> 
> yet met the merging requirements.
> 
> Therefore, I think you can continue to push forward with this patch
> 
> set and not let it stagnate. I will take some time to review the previous
> 
> versions (which may take a while) and hope to be helpful.
> 
> Thanks,
> 
> Yanteng
> 
I will review the patch in the coming few days as well. As this patch also helps Qualcomm to develop the 
HDMA arch for 25XGMAC EMAC controller. 
This patch is validated/verfied/tested on Qualcomm platform devices which are not PCIE based. 
>> Thanks,
>> Jitendra
>>> Thanks,
>>> Yanteng

