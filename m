Return-Path: <bpf+bounces-28290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8088B805D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 21:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194ED283637
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E1194C9E;
	Tue, 30 Apr 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NZu4yp0/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B647710B;
	Tue, 30 Apr 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504622; cv=none; b=pD2L4yENHxQeAnMYFV54fTqsbejT1KJPHnzELi7lsYNHWwlYXcc8bMtTpLbf9MeR1rAPb2dGzRFmWb6tvbkzkPNvXeH3pFqtrFTI3d2dU7l2AnX5dDjSDu6QXMGXrk52//Mx+Z3rt2HkNmRtNzU2qjqoJ/mayGg963yPOZ7tfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504622; c=relaxed/simple;
	bh=RdFfCjNbgzIvSlpEj8Die0XDDORC4D/jlYBq+Mn5u/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gqDMHTa1WBihETz7GZDJOeinQHv4UNkPmHIM2CNLdZJYeHSR3GlbKXSSBA8bt5ACxAGwg1WiLsIICu52e07RAspbuFQEtbM0DnCpynLqPqO8ax4W6kFDpjdFw88h1HdSH4UsKejqAgWwIosdh9KlReAoAb2IY81MZQm+Ms/tkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NZu4yp0/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UFlrGY029101;
	Tue, 30 Apr 2024 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h1aRhctW+hflPZhe4iXejsBdSGqN0UtQR9Cwo3lKjq0=; b=NZ
	u4yp0/wDWTElzpCautSiDsDUz4whkBxjpPa2caB+n03jig6kJPGcQXrjj6TcCDWa
	oWpOeRlgZcMkTHFxH871v42UbdG/AQXExC30HQP+OPAVOv0fqlIfLaAiQ12ubCsc
	nRumVMOffsJGJbmdj+zVFmNZi/IWndLev83iv9Eh49JmjeCu0SLz3xc4RguEjZ9k
	RiOQPjvSw7Jey0AhXwvcmXJdyQL9Ai1To0qq64ONJ+KGy2c0rABoxtHt3ozE4d5o
	EWozTG3/1vstI0R+x5JX5mcK9qqUVrRyJMa6L3coghZJhK6Oha6BoNMm7tzkW9iE
	68sbReJe6NsTOyokzkVQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvv00r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:16:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJGdhi017136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:16:39 GMT
Received: from [10.110.24.18] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:16:35 -0700
Message-ID: <6eb5b283-a9bd-4081-8bce-a60d72af430c@quicinc.com>
Date: Tue, 30 Apr 2024 12:16:35 -0700
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
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <379558fe-a6e2-444b-a6a7-ef233efa8311@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pCjJTonkyvEVCMMeRHtr9PNDpOvoV3h1
X-Proofpoint-GUID: pCjJTonkyvEVCMMeRHtr9PNDpOvoV3h1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=982 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300138



On 4/26/2024 4:50 PM, Martin KaFai Lau wrote:
> On 4/26/24 11:46 AM, Abhishek Chauhan (ABC) wrote:
>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>> index 591226dcde26..f195b31d6e75 100644
>>>> --- a/net/ipv4/ip_output.c
>>>> +++ b/net/ipv4/ip_output.c
>>>> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>>          skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>>>>        skb->mark = cork->mark;
>>>> -    skb->tstamp = cork->transmit_time;
>>>> +    skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
>>> hmm... I think this will break for tcp. This sequence in particular:
>>>
>>> tcp_v4_timewait_ack()
>>>    tcp_v4_send_ack()
>>>      ip_send_unicast_reply()
>>>        ip_push_pending_frames()
>>>          ip_finish_skb()
>>>            __ip_make_skb()
>>>              /* sk_clockid is REAL but cork->transmit_time should be in mono */
>>>              skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);;
>>>
>>> I think I hit it from time to time when running the test in this patch set.
>>>
>> do you think i need to check for protocol type here . since tcp uses Mono and the rest according to the new design is based on
>> sk->sk_clockid
>> if (iph->protocol == IPPROTO_TCP)
>>     skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, CLOCK_MONOTONIC);
>> else
>>     skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
> 
> Looks ok. iph->protocol is from sk->sk_protocol. I would defer to Willem input here.
> 
> There is at least one more place that needs this protocol check, __ip6_make_skb().

Sounds good. I will wait for Willem to comment here. 

