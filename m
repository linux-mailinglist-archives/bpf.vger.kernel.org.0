Return-Path: <bpf+bounces-28298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C68B819C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333EA284124
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3FF1A0AFB;
	Tue, 30 Apr 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MU9s7/Kh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6337179B2;
	Tue, 30 Apr 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509638; cv=none; b=t8RWKFHx8lt68z7JO3Yhv8SmyfxXbQvwvonhcD0bbf5HGcnUEwzZY0HVZ1AMys11buaInXhYB1a+HpwxT06/TcA33V1g/SrM/j8EuC6t1w510eujbjss49PeqfYbAAbMp8uCeYkfPHBplEcxrCG+NM7u4d1oCAVcE6oIVUzwunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509638; c=relaxed/simple;
	bh=3nK5Ui9sg2OmqItymdG/qfwcqJTvCHuMV2+tRbOOeBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g76aN2qAg/U3QqXBrE3MoJ9co+6C5FICCQItsHwB6CVI9HZDTZOTft9evhEHTtFT45wT52oMb2ewUZNRPQVIR6PV9XHxw2OK5iJ4occvJ7QAcmdzTBkxDCNjYY3flfqcz0kt/sYTrvHzsU2yeqoDtnUPSz7ZV/PgI9e95sxVcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MU9s7/Kh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UKLEST003698;
	Tue, 30 Apr 2024 20:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mPJzl3A5Kcs7nbYIEug5FKpc7bZlBVlFz0whBlYR54M=; b=MU
	9s7/Khv9y/FDEyseO9V4RnANK7JqXX7hjHtQzQA6e+1oyNzhxuYwz1Qja5D678sB
	I6fEtjLMXYRtTv5Gi9PY0ZZlydkyCVAewIXWTCzQWt1FrxV7tDNKFs9xcxSu2egf
	AZMqijoMI/QDWYjodX7qCDKgUrF+BDH3c7lUi1mOn/SOSIPqloJIoFuKJRd0P5g2
	HkOSIBXQ6/NDO+FqoGXsanL8BPG3VepkAYscj0vPNSxOXbYASHLwAVKtnwfjTqF9
	0FRADEH9QxCUrs2jF0MUoua0rvG+c2LOsSzze5uDC88P3D1D1tjGk5U7foGl+ojA
	Yxw5fuhN/+209+XBRwhw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xttw3j5m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 20:40:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UKeEZS015877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 20:40:14 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 13:40:11 -0700
Message-ID: <30c91655-a1ba-44da-900b-f2a70ed9f961@quicinc.com>
Date: Tue, 30 Apr 2024 13:40:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
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
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
 <e761e1de-0e11-4541-a4db-a1b793a60674@quicinc.com>
 <379558fe-a6e2-444b-a6a7-ef233efa8311@linux.dev>
 <6eb5b283-a9bd-4081-8bce-a60d72af430c@quicinc.com>
 <663153f92a297_33210f29423@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <663153f92a297_33210f29423@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SYWLA4lxIeFd4K85nYS1coeXpLRNOhYm
X-Proofpoint-ORIG-GUID: SYWLA4lxIeFd4K85nYS1coeXpLRNOhYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300148



On 4/30/2024 1:26 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 4/26/2024 4:50 PM, Martin KaFai Lau wrote:
>>> On 4/26/24 11:46 AM, Abhishek Chauhan (ABC) wrote:
>>>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>>>> index 591226dcde26..f195b31d6e75 100644
>>>>>> --- a/net/ipv4/ip_output.c
>>>>>> +++ b/net/ipv4/ip_output.c
>>>>>> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>>>>          skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>>>>>>        skb->mark = cork->mark;
>>>>>> -    skb->tstamp = cork->transmit_time;
>>>>>> +    skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
>>>>> hmm... I think this will break for tcp. This sequence in particular:
> 
> Good catch, thanks!
> 
>>>>>
>>>>> tcp_v4_timewait_ack()
>>>>>    tcp_v4_send_ack()
>>>>>      ip_send_unicast_reply()
>>>>>        ip_push_pending_frames()
>>>>>          ip_finish_skb()
>>>>>            __ip_make_skb()
>>>>>              /* sk_clockid is REAL but cork->transmit_time should be in mono */
>>>>>              skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);;
>>>>>
>>>>> I think I hit it from time to time when running the test in this patch set.
>>>>>
>>>> do you think i need to check for protocol type here . since tcp uses Mono and the rest according to the new design is based on
>>>> sk->sk_clockid
>>>> if (iph->protocol == IPPROTO_TCP)
>>>>     skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, CLOCK_MONOTONIC);
>>>> else
>>>>     skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
>>>
>>> Looks ok. iph->protocol is from sk->sk_protocol. I would defer to Willem input here.
>>>
>>> There is at least one more place that needs this protocol check, __ip6_make_skb().
>>
>> Sounds good. I will wait for Willem to comment here. 
> 
> This would be sk_is_tcp(sk).
> 
> I think we want to avoid special casing if we can. Note the if.
> 
> If TCP always uses monotonic, we could consider initializing
> sk_clockid to CLOCK_MONONOTIC in tcp_init_sock.
> 
> I guess TCP logic currently entirely ignores sk_clockid. If we are to
> start using this, then setsocktop SO_TXTIME must explicitly fail or
> ignore for TCP sockets, or silently skip the write.
> 
> All of that is more complexity. Than is maybe warranted for this one
> case. So no objections from me to special casing using sk_is_tcp(sk)
> either.
> 
>

Thanks Willem and Martin for all the support and reviews. 
I will take care of this in the next RFC patch
- adding the sk_is_tcp check and setting tstamp_type to mono for tcp

> 
> 

