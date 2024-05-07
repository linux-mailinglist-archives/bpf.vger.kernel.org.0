Return-Path: <bpf+bounces-28948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B878BECBD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53F61F23EF8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F716E870;
	Tue,  7 May 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtspuWq3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2C7350C;
	Tue,  7 May 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110758; cv=none; b=naxSiac4rr0MRjfKjCBVezV4TtMQeeHjYHCu7Wce0qlqidQBL29AtZC56XCVdZIvtRbQ5grXLfjZojwqwxdgC1k3hK79A/Snl/wNVYA2x5kvfHsozVv4GlJ9pgs+22fDJhAZd8oboKusoDiqOL/5X5aPvuLu+dLgX5kK1RihmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110758; c=relaxed/simple;
	bh=mv1uSj5Kq4YcblH7Tz4McLmQNmcq+h6m2ps+PPU3mMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aPIdojKcVpY+rJWBZSVOiYp46pKa+WhEQFzGcBRpd1Zek4Vx7nq5WwXS9DqvBkwlHl8oBoocQr8CRBTVyb2+E0QD21eqR9S6fhL+SpIkDUkhMPfNNGLBsbuecifSbau0cumgqdeEmpbbCGI0BOpM/G437IcQpxmD/ROwxCHsT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XtspuWq3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447IgltP007564;
	Tue, 7 May 2024 19:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jCFHp8W259KAmupqm+5dmy2ouOi8pkhAE6sb3LDJp+c=; b=Xt
	spuWq3dFAY8G1hA5LmYlv/MzMQKcD5COPXhRkXmszpUjhCWeul6pDBezTy5ly0YJ
	UKQbr0DulLlUeFabm2Q90cT5zmitV9GXW/xNzQb7zUWlnt/Oo3VcCU09X1TenaRq
	q10mUG1xCMF+GJhEXPUGpaZzRFP8y85zDccY9trtDYhB5yAkEjrlly/+nQrMw4fT
	Gl66YVSCpKzZrQxD+mQWoXUBdQ8UFy52/rCGCJAY0j193NOXY7kadS/B53c810jp
	DZLqLW2hmhyq0VBhcdRoTBS7J2MA9kjL1qGQ7XFD8lAgYFktCoNKPJk75Rn9pr+K
	QFbaCEQOhMSdEcHWiJCg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyste03ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 19:38:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447Jcu3N029224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:38:56 GMT
Received: from [10.110.127.27] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 12:38:52 -0700
Message-ID: <69c55618-931a-48f4-a25c-0d5666bcb5cb@quicinc.com>
Date: Tue, 7 May 2024 12:38:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support
 clockid_t timestamp type
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
 <cab0c7ba-90bf-49e2-908d-ecd879160667@linux.dev>
 <663a12f089b81_726ea29426@willemb.c.googlers.com.notmuch>
 <fc8334a6-6961-41f4-affc-28bdfc3dd697@quicinc.com>
 <663a7e7e1f5b5_cc75c294c0@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <663a7e7e1f5b5_cc75c294c0@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J5C4MZW2Ei4xKG093PaksBBJHC0lxS63
X-Proofpoint-ORIG-GUID: J5C4MZW2Ei4xKG093PaksBBJHC0lxS63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405070136



On 5/7/2024 12:18 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 5/7/2024 4:39 AM, Willem de Bruijn wrote:
>>> Martin KaFai Lau wrote:
>>>> On 5/3/24 8:13 PM, Abhishek Chauhan wrote:
>>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>>> index fe86cadfa85b..c3d852eecb01 100644
>>>>> --- a/net/ipv4/ip_output.c
>>>>> +++ b/net/ipv4/ip_output.c
>>>>> @@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>>>   
>>>>>   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>>>>>   	skb->mark = cork->mark;
>>>>> -	skb->tstamp = cork->transmit_time;
>>>>> +	if (sk_is_tcp(sk))
>>>>
>>>> This seems not catching all IPPROTO_TCP case. In particular, the percpu 
>>>> "ipv4_tcp_sk" is SOCK_RAW. sk_is_tcp() is checking SOCK_STREAM:
>>>>
>>>> void __init tcp_v4_init(void)
>>>> {
>>>>
>>>> 	/* ... */
>>>> 	res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
>>>> 				   IPPROTO_TCP, &init_net);
>>>>
>>>> 	/* ... */
>>>> }
>>>>
>>>> "while :; do ./test_progs -t tc_redirect/tc_redirect_dtime || break; done" 
>>>> failed pretty often exactly in this case.
>>>>
>>>
>>> Interesting. The TCP stack opens non TCP sockets.
>>>
>>> Initializing sk->sk_clockid for this socket should address that.
>>>
>> Willem, Are you suggesting your point from the previous patch ? 
>>
> 
> No, just for this custom socket to initialize the sk_clockid. It is
> not a TCP socket, but only used by TCP.
Thanks Willem, 
Noted! Which means there are only two places these custom RAW tcp socket 
are getting called 

1. tcp_ipv4.c 
2. tcp_ipv6.c 

I will take care of initializing sk_clockid to monotonic in the next patch 
in the above two files. 

Let me know if i missed out anything. 

