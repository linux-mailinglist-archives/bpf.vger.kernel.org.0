Return-Path: <bpf+bounces-27164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D187B8AA393
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012551C2143B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265E18133C;
	Thu, 18 Apr 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hbBiCr+R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A317B4F8;
	Thu, 18 Apr 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470308; cv=none; b=OOx1i2Bt+8onerg2RLDw33Z7ZgKDYR2BcJGI4iKpJc97sAlUay42sLKo9J2tClrqRr2ee0yA45FS0tXL4+FW3bhl0mXRk/26k9vmWZCjwt9KRIqnPbsCBHzKzwTy5Ra67ixjYjyyqrcfvCprIJsbEu5T9ajKxpZ4xYgSAfZHbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470308; c=relaxed/simple;
	bh=tisi65k+YGyhsUQNNBAR+SpVnahnqmqz5uWVgPGomCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tkmm0I14IfOyYDDUq+KBu1DNtTSL7UsHtugA+XLS3NbNeBfbmc1V4p8zBhdL+lGnQWNe4avBbCC7YNIiaXBy6ngvAZCQ0JwbvTaJRdg1lYeo1I8wqtw9Zw7DaUL1eCv44HfivSBk+fYY7/gJYLUkHbpoMzJ8yo7IAR/Gv2VnmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hbBiCr+R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IJh1AK031009;
	Thu, 18 Apr 2024 19:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G3e6TiNghqcS7ahLIcRBHCG1AFPyU/zwTm2IKBSzs74=; b=hb
	BiCr+RYNWzNqrj21IoJXwa9hI4rYocdHbwS7e5mb/1yo66HEWzb4YPO6/6lB4SST
	l9Koi3R4FtXlaJI22zSyyOjURgBvGX7SgZ5+NT/s2Kt0TpXhBfRhgVAtEPIKl83c
	U8gKu/Q3u56M6y1FcUAekqeEn4ScNVvWSr9FLEgHc9JZY6NDjeMHHKPaI71ccDXH
	zbLmJrGl5QGrpWlphh06KSK7+kB1w41TodPybcnKjguJfAQqiC4wtEwIM7Q4V9i8
	FMQJCV2IAH3bGqGjdn4+elPzbRGdo9e3ww1jYY2G0Qg+oRpIhoCMjjXQJR+9s7nT
	BOFMKw0zznVRfkVithoQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk4vm8une-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 19:58:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IJw4qL030491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 19:58:04 GMT
Received: from [10.110.72.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 12:58:00 -0700
Message-ID: <9a1f8011-2156-4855-8724-fea89d73df11@quicinc.com>
Date: Thu, 18 Apr 2024 12:58:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v4 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <66216adc8677c_f648a294aa@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AcgPrii5VN7hizySZenTQUQVW40I3_Bw
X-Proofpoint-GUID: AcgPrii5VN7hizySZenTQUQVW40I3_Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=956 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180144



On 4/18/2024 11:47 AM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> mono_delivery_time was added to check if skb->tstamp has delivery
>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
>> timestamp in ingress and delivery_time at egress.
>>
>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
>> extensibilty for other timestamps such as userspace timestamp
>> (i.e. SO_TXTIME) set via sock opts.
>>
>> As we are renaming the mono_delivery_time to tstamp_type, it makes
>> sense to start assigning tstamp_type based on enum defined
>> in this commit.
>>
>> Earlier we used bool arg flag to check if the tstamp is mono in
>> function skb_set_delivery_time, Now the signature of the functions
>> accepts tstamp_type to distinguish between mono and real time.
>>
>> In future tstamp_type:1 can be extended to support userspace timestamp
>> by increasing the bitfield.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> 
>> +/**
>> + * tstamp_type:1 can take 2 values each
>> + * represented by time base in skb
>> + * 0x0 => real timestamp_type
>> + * 0x1 => mono timestamp_type
>> + */
>> +enum skb_tstamp_type {
>> +	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
>> +	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
>> +};
>> +
> 
> Can drop the comments. These names are self documenting.

Noted! . I will take care of this
> 
>>  /**
>>   * DOC: Basic sk_buff geometry
>>   *
>> @@ -819,7 +830,7 @@ typedef unsigned char *sk_buff_data_t;
>>   *	@dst_pending_confirm: need to confirm neighbour
>>   *	@decrypted: Decrypted SKB
>>   *	@slow_gro: state present at GRO time, slower prepare step required
>> - *	@mono_delivery_time: When set, skb->tstamp has the
>> + *	@tstamp_type: When set, skb->tstamp has the
>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>   *		skb->tstamp has the (rcv) timestamp at ingress and
>>   *		delivery_time at egress.
> 
> Is this still correct? I think all egress does now annotate correctly
> as SKB_CLOCK_MONO. So when not set it always is SKB_CLOCK_REAL.
> 
That is correct. 

>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 61119d42b0fd..a062f88c47c3 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>  	tp = tcp_sk(sk);
>>  	prior_wstamp = tp->tcp_wstamp_ns;
>>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
>> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
>> +	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
> 
> Multiple references to CLOCK_MONOTONIC left
> 
I think i took care of all the references. Apologies if i didn't understand your comment here. 


> 
> 

