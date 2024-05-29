Return-Path: <bpf+bounces-30850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1C8D3BC3
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE46F281FC0
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573F31836D2;
	Wed, 29 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYadAFve"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AD42044;
	Wed, 29 May 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998720; cv=none; b=Q7fefEVeGPvvQJgo+DERsqYs5BIHjuutXaGqd7j86T/srMKIDIUDuO2bCunil+eUDbLf3MgPdUNhRzkXO9Ud/8Tv6hmvgYvD+6fVhTePcIH+b8tmRJ9NHbJalnr4Jnms3AVdD0ulk3EnW/SxA9PYQzoXArfA+TrdybBhttqj2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998720; c=relaxed/simple;
	bh=gt5rwrr05fd8R3dFco0BPD0V9ATpbhhRHWZLtS9tMYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oa6OeyOJsyuDmmkUOODl6vZGuvINFMBwlSIbPPzVKUyWcfWfy00wzdUERQEAbWmk4hxoueBeihrZAgS1l/7cqy4tLVaE3BdLip5H5kmmAiRFtnYGiIAOkJCoDYDEF5l8lhis6U4t4Gwniw+MrHjNJFcZGc3hW3BqL6OLTcYZ3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYadAFve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TApiKD032629;
	Wed, 29 May 2024 16:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3y//tl+TCZv9BP/UPxsuXIME5LjiaLN+uQZckGjm1hQ=; b=OYadAFve3Ca9fuee
	9AtxgvdSj+51mfink7tiLiWLtNhAIqXRaNL/riJ4XBtSh1Q9+0ldwGsYLSiF2Q0i
	7lxjWBy3rnV5Bklhklo0a+Tn5w21MHyDUoXh0YB56LrIM55o81mGv8ebiwp9LshU
	HEXMu22zhMzrcf2sIW11wtc/CWfq3nQAR4hqSe3iREN1xba/dPS5QFpAoUdP8NUK
	tVetDBbhEd6FviEqod+hT27i/ofh9I0vJvyuP3c/zAjgzsi148la6XWSBWJsBHkw
	E2I/zWcQMPXY1EXafIlU9AZGcd5dGD+5bELGAAk+e+yDruNjdfoLY9sNcLBhse5t
	ogG7kA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0x9e09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:04:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TG4qCB012594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:04:52 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 09:04:47 -0700
Message-ID: <f27a87dd-52d3-460c-ae07-cf598eebcce4@quicinc.com>
Date: Wed, 29 May 2024 09:04:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from userspace
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
CC: <kernel@quicinc.com>,
        <syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com>,
        <syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com>
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
 <665734886e2a9_31b2672946e@willemb.c.googlers.com.notmuch>
 <3d04ff60-c01b-4718-ae3d-70d19ee2019a@quicinc.com>
 <6657510aa54a4_32016c29461@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <6657510aa54a4_32016c29461@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g2-mAer2FxIIp9H5zv9k4hWYkYH9BIeV
X-Proofpoint-ORIG-GUID: g2-mAer2FxIIp9H5zv9k4hWYkYH9BIeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290111



On 5/29/2024 9:00 AM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 5/29/2024 6:58 AM, Willem de Bruijn wrote:
>>> minor: double space before userspace
>>>
>>> Abhishek Chauhan wrote:
>>>> Currently there are no strict checks while setting SO_TXTIME
>>>> from userspace. With the recent development in skb->tstamp_type
>>>> clockid with unsupported clocks results in warn_on_once, which causes
>>>> unnecessary aborts in some systems which enables panic on warns.
>>>>
>>>> Add validation in setsockopt to support only CLOCK_REALTIME,
>>>> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
>>>>
>>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>>> Link: https://lore.kernel.org/lkml/20240509211834.3235191-1-quic_abchauha@quicinc.com/
>>>
>>> These discussions can be found directly from the referenced commit?
>>> If any, I'd like to the conversation we had that arrived at this
>>> approach.
>>>
>> Not Directly but from the patch series. 
>> 1. First link is for why we introduced skb->tstamp_type 
>> 2. Second link points to the series were we discussed on two approach to solve the problem 
>> one being limit the skclockid to just TAI,MONO and REALTIME. 
> 
> Ah, I missed that.
> Perhaps point directly to the start of that follow-up conversation?
> Thanks Willem, Let me do that when i raise the net-next patch. 
> https://lore.kernel.org/lkml/6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com/
> 
>>
>>
>>>> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
>>>> Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
>>>> Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>> ---
>>>>  net/core/sock.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>>> index 8629f9aecf91..f8374be9d8c9 100644
>>>> --- a/net/core/sock.c
>>>> +++ b/net/core/sock.c
>>>> @@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
>>>>  }
>>>>  EXPORT_SYMBOL(sockopt_capable);
>>>>  
>>>> +static int sockopt_validate_clockid(int value)
>>>
>>> sock_txtime.clockid has type __kernel_clockid_t.
>>>
>>
>>  __kernel_clockid_t is typedef of int.  
>> It is now, but the stricter type definition exists for a reason.
> Try to keep the strict types where possible. Besides aiding
> syntactic checks, it also helps self document code.
Okay i see what you are saying. Makes sense. I will change it to __kernel_clockid_t

