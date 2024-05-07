Return-Path: <bpf+bounces-28941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B98BEC56
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824021C246A7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7116EBED;
	Tue,  7 May 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WSXdBAtN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41616DEB6;
	Tue,  7 May 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108933; cv=none; b=paZfk9R9QExCwt+OeHVs67K+i9oekgxsdBD43hdzUvmVNZ9NpzLJ9ChGJDTEN0SGf0W8A0VRzV6jPPWf8rgzIeR1vMQ92ruBbEz8IjrWRrTqiIM9PPYVpAUEO7EdjaUoXvrTxqs0bfy4K4lqHYNnf1KJ6JdlUMZ9fT+gQruZYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108933; c=relaxed/simple;
	bh=NkCcFJMiI2fIuafu13ahaUzYsqra2h0cXjW2V5EMPoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cMeiL359RaOT3S9maomWHJuwZkcQTKz9HGtZoKL98xfgk97wPPiRytQwChEyiF1yKq0xkbAFuR84fJwuTvyVJUrVUPkA4+2lTPO3C7l6tKuiTRKWhDnDW4CO8KEa/LcWidl/BPHxSyHgk6j058yx2oSMWkCUYeoTgMS+W2IQcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WSXdBAtN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447IKEcg001484;
	Tue, 7 May 2024 19:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xVPphSKUlVh/m4wKeSY0WKuT3/YvZYGtZ2wCat41/zQ=; b=WS
	XdBAtNmpIka7OVy1BTfiJKJ8Xb0TtgXHs6hymdhDrjg+hbOSYCwMLspqfQmrhz3T
	Cafe5pms2mIMNS1akeWHk0xAzDLSJR4QGLrw3PP6CQUovSm0XdXY8hbzZ5zOmi6p
	8+3SvVwviKaB8arHAvQ5XkTMSgfjTEUKFAIwMi/ckvclTcWBBk8iD7+WCc8PvfDZ
	NyLlYVAU9xJP5qE38Ec/3Bqdm4Biw5lXeFqP0U5JApkesYRAvNzx9HbmsY9M3fja
	rU4O1M7Mx385YFoIBeNgaQm5MU4hLSrRH3tc9RgXd07pExPWO198LoWRXZujyQoU
	xW9HNKjNXcuITwWEctfg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg403g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 19:08:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447J8Sn8031305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:08:28 GMT
Received: from [10.110.127.27] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 12:08:24 -0700
Message-ID: <fc8334a6-6961-41f4-affc-28bdfc3dd697@quicinc.com>
Date: Tue, 7 May 2024 12:08:24 -0700
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <663a12f089b81_726ea29426@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0ZnVXcfSMYO1lo2QZkiXV9RYeAgI8NH3
X-Proofpoint-ORIG-GUID: 0ZnVXcfSMYO1lo2QZkiXV9RYeAgI8NH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405070135



On 5/7/2024 4:39 AM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 5/3/24 8:13 PM, Abhishek Chauhan wrote:
>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>> index fe86cadfa85b..c3d852eecb01 100644
>>> --- a/net/ipv4/ip_output.c
>>> +++ b/net/ipv4/ip_output.c
>>> @@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>   
>>>   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>>>   	skb->mark = cork->mark;
>>> -	skb->tstamp = cork->transmit_time;
>>> +	if (sk_is_tcp(sk))
>>
>> This seems not catching all IPPROTO_TCP case. In particular, the percpu 
>> "ipv4_tcp_sk" is SOCK_RAW. sk_is_tcp() is checking SOCK_STREAM:
>>
>> void __init tcp_v4_init(void)
>> {
>>
>> 	/* ... */
>> 	res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
>> 				   IPPROTO_TCP, &init_net);
>>
>> 	/* ... */
>> }
>>
>> "while :; do ./test_progs -t tc_redirect/tc_redirect_dtime || break; done" 
>> failed pretty often exactly in this case.
>>
> 
> Interesting. The TCP stack opens non TCP sockets.
> 
> Initializing sk->sk_clockid for this socket should address that.
> 
Willem, Are you suggesting your point from the previous patch ? 

"I think we want to avoid special casing if we can. Note the if.

If TCP always uses monotonic, we could consider initializing
sk_clockid to CLOCK_MONONOTIC in tcp_init_sock.

I guess TCP logic currently entirely ignores sk_clockid. If we are to
start using this, then setsocktop SO_TXTIME must explicitly fail or
ignore for TCP sockets, or silently skip the write.

All of that is more complexity. Than is maybe warranted for this one
case. So no objections from me to special casing using sk_is_tcp(sk)
either." 

Few places we need to initialize the clock base for tcp to monotonic 
1. tcp_init_sock 
2. void __init tcp_v4_init(void) in tcp_ipv4.c
3. static int __net_init tcpv6_net_init(struct net *net)
4. Ignore setsockopts for SO_TXTIME if the sk->protocol is tcp.  

Is it safe to assume the TCP will never use any other close base ? 


OR 


For now we can do just protocol level check in ip_make_skb and ip6_make_skb 
like 
if (iph->protocol == IPPROTO_TCP)
    /* ... */
else
    /* ... */






