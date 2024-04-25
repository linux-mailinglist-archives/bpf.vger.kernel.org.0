Return-Path: <bpf+bounces-27871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB48B2DCB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998C2B20D29
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4513156F26;
	Thu, 25 Apr 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kl+M83De"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE112BF22;
	Thu, 25 Apr 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714089353; cv=none; b=i89rNzpy6a9SBWTPy0SxX4llF94JMo7QVWW7dw99Jjsin3+cZwwPU4JgO9aVRcruD9HAlBla6meFNwQO6gC6/mVv6NSdsr4waHGn4Y2fvFEBa50VojG7fs4fEudfIwn05rexSWChjShpKF927K00Q0py78OIzhMlagZnyhMmVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714089353; c=relaxed/simple;
	bh=DXF40Aou5AWOgF5C6k2hVzTbaKJBidJ18v1nMg/VIPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eyApVkH0riAqI7zj0XWPv3bSYCnCIyEsDMF3Tr0+PXJ6nvtWJlStAunCtuYarh84sn8CG1uPu4Q1veTB3VjnLpbyCPQ8hT5wn74lZNJv61G+e/a+dDi4P7Wdgmg85ecsfvXm4uSxAZS2Lqziv8d8a+S7P7oWgG8c8QkGD4rFBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kl+M83De; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PJf030002323;
	Thu, 25 Apr 2024 23:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MUUjl+/YT9sSum+ImRa9WRqc6yccVpa6DoToWYHMQY8=; b=Kl
	+M83DelwMjUzsbO834cy+nPXTSX+6gR1z70ajOxkdp0205MMW+eL1te0pJtRwdOk
	W4ZSBwVA328WOyKLXGMu0h5lzQ06isuiX8vkTNBmZQ+9L+K2ge/JeT2zdgFOZf+3
	mVGDuY+nNTKsKiMjVkgnhH33YPWaI+k076pGbCB0BKvGf3xm8Vlxc+HZbj6Liz9S
	Y5hB0OabOOFnNWBTB2T7Txv6cab1VPOFWNZcxRK6E8K5HLFKk8J4vlYkAnDSaxQj
	o4ReDLlOAystN5lbvbIu3xH9cLWeLNDJH7pymLTnGi3ocovR5bztt3n0vx5j+yj0
	OtAN+uzZUtjZ84EsKlAQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenpbwhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:55:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PNtSme020585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:55:28 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 16:55:24 -0700
Message-ID: <6976b7ea-a7d4-41fc-93ac-fd5972466520@quicinc.com>
Date: Thu, 25 Apr 2024 16:55:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v5 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-2-quic_abchauha@quicinc.com>
 <662a69475869_1de39b29415@willemb.c.googlers.com.notmuch>
 <a84d314a-fca4-4317-9d33-0c7d3213c612@quicinc.com>
 <6cebfd92-7ad0-496a-9f31-f4c696fb5cb8@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <6cebfd92-7ad0-496a-9f31-f4c696fb5cb8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lHliPMGmVVlL_Bf7--AuHBaVnaMz5Nwj
X-Proofpoint-ORIG-GUID: lHliPMGmVVlL_Bf7--AuHBaVnaMz5Nwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_22,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=832 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250176



On 4/25/2024 4:50 PM, Martin KaFai Lau wrote:
> On 4/25/24 12:02 PM, Abhishek Chauhan (ABC) wrote:
>>>>> @@ -9444,7 +9444,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>>                       TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>>>           *insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>>>                       TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>> -        /* skb->tc_at_ingress && skb->mono_delivery_time,
>>>> +        /* skb->tc_at_ingress && skb->tstamp_type:1,
>>> Is the :1 a stale comment after we discussed how to handle the 2-bit
>> This is first patch which does not add tstamp_type:2 at the moment.
>> This series is divided into two patches
>> 1. One patchset => Just rename (So the comment is still skb->tstamp_type:1)
>> 2. Second patchset => add another bit (comment is changed to skb->tstamp_type:2)
> 
> I would suggest to completely avoid the ":1" or ":2" part in patch 1. Just use "... && skb->tstamp_type". The number of bits does not matter. The tstamp_type will still be considered as a whole even if it would become 3 bits (unlikely) in the future.

Okay i will just keep it as skb->tstamp_type instead of adding bitfields. 

