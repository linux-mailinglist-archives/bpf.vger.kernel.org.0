Return-Path: <bpf+bounces-27171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC298AA427
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52D5B22258
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5219DF4C;
	Thu, 18 Apr 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KgWJPvG+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5E199EBA;
	Thu, 18 Apr 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472710; cv=none; b=q6NQuWq1GI8ZI6VliVPGjkQoJms5wMpFNKYEgKg4f39CzUS70dwpF2UfQXlDGt3OTF7G8lzO5z8QKAmIkd/ERIDUNj2Jyy0Bwg5yrrB67umrZe3IwsAWl9g8LNHtUNtWaJiFlboKZoly+NMAOgZjjzcp6dudp+An471eM0v79uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472710; c=relaxed/simple;
	bh=U8Jdac4J7AbOYdOO7iaSyo1Pc4fD5186kqXjTCi5JXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eF6ABxvaozhJV+5HORurTS99u6RzC3bFdJuUPJwn/cCQMcbMrUcEvgT37VHhXEsRGZszW5yerIsn+w9Bw/nWQLivB39AkBg2+PIcztSkRCkygBmYUPy8kfuJQPH2zzmMXZGQLMdG/K+I/6b1W2c6BJq9spiQLdnJHfJ7npyMGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KgWJPvG+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IKZuNi030508;
	Thu, 18 Apr 2024 20:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KK0ofOdVlXP7XXsVIpp96JdiQ3FZc76aKMyRRIPwHNc=; b=Kg
	WJPvG+TC66/vLt70OcF5CEIbz8J1F+e/ezsjULGllWm2d9jjUypcvUrBN1yC+a1q
	HIX4nxA8RWX+VQpOnUHxAm5JNyczIQT4L3r0iGOhOfhKuPqPDPh/Qm+zSfu7rvoM
	wre6PP7Mcy+qCCV5YVRpy+nGQa3po38iqzQXV39pwQvixuw4K/NTXj/e4xL8b/Ju
	6mCxvSHhP5/3mV7/lE2tdtVNxEh4uOmmGvbI+Wr1+VOGEWCyGhBA05KHtMnFv3LN
	PnyxuMSS7hiMlRWI5QhI2b57znXkqm1Dx91KHJGkKiWV/qZWrogwWRECXavT0aw2
	0GWFtIGN9Vz1eUsiB+sg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk155hedd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:38:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IKc7Cx020072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:38:07 GMT
Received: from [10.110.72.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 13:38:03 -0700
Message-ID: <d25533d6-5d09-4c9f-8801-54ac35db98ed@quicinc.com>
Date: Thu, 18 Apr 2024 13:38:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v4 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
CC: <kernel@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-2-quic_abchauha@quicinc.com>
 <66216adc8677c_f648a294aa@willemb.c.googlers.com.notmuch>
 <9a1f8011-2156-4855-8724-fea89d73df11@quicinc.com>
 <66217e7ccb46b_f9d5d294b0@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <66217e7ccb46b_f9d5d294b0@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gDZKXrd7xPRM0cOdYqGIB6iqtzTdTHAH
X-Proofpoint-GUID: gDZKXrd7xPRM0cOdYqGIB6iqtzTdTHAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180149



On 4/18/2024 1:11 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 4/18/2024 11:47 AM, Willem de Bruijn wrote:
>>> Abhishek Chauhan wrote:
>>>> mono_delivery_time was added to check if skb->tstamp has delivery
>>>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
>>>> timestamp in ingress and delivery_time at egress.
>>>>
>>>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
>>>> extensibilty for other timestamps such as userspace timestamp
>>>> (i.e. SO_TXTIME) set via sock opts.
>>>>
>>>> As we are renaming the mono_delivery_time to tstamp_type, it makes
>>>> sense to start assigning tstamp_type based on enum defined
>>>> in this commit.
>>>>
>>>> Earlier we used bool arg flag to check if the tstamp is mono in
>>>> function skb_set_delivery_time, Now the signature of the functions
>>>> accepts tstamp_type to distinguish between mono and real time.
>>>>
>>>> In future tstamp_type:1 can be extended to support userspace timestamp
>>>> by increasing the bitfield.
>>>>
>>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>
>>>> +/**
>>>> + * tstamp_type:1 can take 2 values each
>>>> + * represented by time base in skb
>>>> + * 0x0 => real timestamp_type
>>>> + * 0x1 => mono timestamp_type
>>>> + */
>>>> +enum skb_tstamp_type {
>>>> +	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
>>>> +	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
>>>> +};
>>>> +
>>>
>>> Can drop the comments. These names are self documenting.
>>
>> Noted! . I will take care of this
>>>
>>>>  /**
>>>>   * DOC: Basic sk_buff geometry
>>>>   *
>>>> @@ -819,7 +830,7 @@ typedef unsigned char *sk_buff_data_t;
>>>>   *	@dst_pending_confirm: need to confirm neighbour
>>>>   *	@decrypted: Decrypted SKB
>>>>   *	@slow_gro: state present at GRO time, slower prepare step required
>>>> - *	@mono_delivery_time: When set, skb->tstamp has the
>>>> + *	@tstamp_type: When set, skb->tstamp has the
>>>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>>>   *		skb->tstamp has the (rcv) timestamp at ingress and
>>>>   *		delivery_time at egress.
>>>
>>> Is this still correct? I think all egress does now annotate correctly
>>> as SKB_CLOCK_MONO. So when not set it always is SKB_CLOCK_REAL.
>>>
>> That is correct. 
>>
>>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>>> index 61119d42b0fd..a062f88c47c3 100644
>>>> --- a/net/ipv4/tcp_output.c
>>>> +++ b/net/ipv4/tcp_output.c
>>>> @@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>>>  	tp = tcp_sk(sk);
>>>>  	prior_wstamp = tp->tcp_wstamp_ns;
>>>>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
>>>> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
>>>> +	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
>>>
>>> Multiple references to CLOCK_MONOTONIC left
>>>
>> I think i took care of all the references. Apologies if i didn't understand your comment here. 
> 
> On closer read, there is a type issue here.
> 
> skb_set_delivery_time takes a u8 tstamp_type. But it is often passed
> a clockid_t, and that is also what the switch expects.
> 
> But it does also get called with a tstamp_type in code like the
> following:
> 
> +       u8 tstamp_type = skb->tstamp_type;
>         unsigned int hlen, ll_rs, mtu;
>         ktime_t tstamp = skb->tstamp;
>         struct ip_frag_state state;
> @@ -82,7 +82,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
>                         if (iter.frag)
>                                 ip_fraglist_prepare(skb, &iter);
>   
> -                       skb_set_delivery_time(skb, tstamp, mono_delivery_time);
> +                       skb_set_delivery_time(skb, tstamp, tstamp_type);
> 
> So maybe we need two variants, one that takes a tstamp_type and one
> that tames a clockid_t?
> 
> The first can be simple, not switch needed. Just apply the two stores.
I agree to what you are saying but clockid_t => points to int itself. 

For example :- 
		void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qdisc,
				 clockid_t clockid)

		qdisc_watchdog_init_clockid(wd, qdisc, CLOCK_MONOTONIC); => sch_api.c
	       qdisc_watchdog_init_clockid(&q->watchdog, sch, q->clockid); =>sch_etf.c (q->clockid is int)
	
But i can change it to two new APIs one which accepts only clock_id (with switch) and other accepts u8 to directly store whatever is given. 

