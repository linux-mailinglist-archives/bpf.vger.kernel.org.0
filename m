Return-Path: <bpf+bounces-26877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A78A5CED
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52BE283763
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16D156F57;
	Mon, 15 Apr 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3ACQGsb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF2156236;
	Mon, 15 Apr 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216405; cv=none; b=OxKN03NJ8CEzbCqYibPrT4bNF7lyMjtuVVfiB+6kPqF7Z51rLqMAq+q8aw6Vpv+rdIo2uoRUGmKpB2zdS/WRVz1o+0TPLsww4j/2Lwq8JKaU+H9y9b81xkDEWgIe05yeCRK2FWgql/WFcsUIqBVyDyisQP6NiCjAcKGRTHYfFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216405; c=relaxed/simple;
	bh=zJtKB7O3/WvCqOnP2/g5NcTJPMuxI5QmR9+UIN4j/Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OcxfaV5BUSd+Tnsx1U3bdrDnblBFos5HBGNn1ymG8mcdHV70gp+e8xLbEBdJ7XlrAFXygEmm/k1zFCG40x+EYpqZfnB/gdGSfXt2xBC+vHrcDSvkGSaIn4CtjxH0QTtri3FwaV3iYKderuMektOq9C/qBcOLg+DlpQk1Rg0ZVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3ACQGsb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FKfUTV006457;
	Mon, 15 Apr 2024 21:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tOrMnghh2NCP6ZkuUqQk7otGncms/swKbAn60nOpyaQ=; b=j3
	ACQGsbXKUGv9+CSTk2GRX0G03ICqYhvtvoJ5Vf1sVMZo87NZXtAb+JdQLVXpg6zF
	+EFRgi4qjJqpKBPEMZ5ANaZIWzHlokVbRhpXfOt303PnJpFX1x/M6oyxe+rP+8E/
	dXK3I8WACQpJq5Rm/XODe5tsHyQH9Nz7p0vYyoxOGirQmFYFq7nykMEFEo9yxzi/
	eAktNFv2TAsM9HkrdoxPvbaN4vEZsivaIkXGytO3mgEb7MdbEXMFz8BZuzCQhknt
	rVbaqLonQ4c9joqRear1CYwkaSbyRM6N4YfNQmRxDmcO2ryZTBg6lJdeSPziXymo
	5FWlokwbjmWiWWLodBNg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbg882gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 21:26:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FLQFB7026132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 21:26:15 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 14:26:11 -0700
Message-ID: <83dbc057-be42-41d6-95a3-af4b01d64afb@quicinc.com>
Date: Mon, 15 Apr 2024 14:26:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to
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
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-2-quic_abchauha@quicinc.com>
 <661ad4f0e3766_3be9a7294a1@willemb.c.googlers.com.notmuch>
 <c992e03b-eee5-471a-9002-f35bdfa1be2d@quicinc.com>
 <661d92391de45_30101294f2@willemb.c.googlers.com.notmuch>
 <6bfee126-36f4-4595-950e-058d93303362@quicinc.com>
 <661d9a8bb862c_314dd2942c@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <661d9a8bb862c_314dd2942c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GXEKuWOz6boZJQfEpxUP9kMgRF79ZkN6
X-Proofpoint-ORIG-GUID: GXEKuWOz6boZJQfEpxUP9kMgRF79ZkN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150143



On 4/15/2024 2:22 PM, Willem de Bruijn wrote:
>>>>>>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>>>> -					 bool mono)
>>>>>> +					  u8 tstamp_type)
>>>>>>  {
>>>>>>  	skb->tstamp = kt;
>>>>>> -	skb->mono_delivery_time = kt && mono;
>>>>>> +
>>>>>> +	switch (tstamp_type) {
>>>>>> +	case CLOCK_REAL:
>>>>>> +		skb->tstamp_type = CLOCK_REAL;
>>>>>> +		break;
>>>>>> +	case CLOCK_MONO:
>>>>>> +		skb->tstamp_type = kt && tstamp_type;
>>>>>> +		break;
>>>>>> +	}
>>>>>
>>>>> Technically this leaves the tstamp_type undefined if (skb, 0, CLOCK_REAL)
>>>> Do you think i should be checking for valid value of tstamp before setting the tstamp_type ? Only then set it. 
>>>
>>> A kt of 0 is interpreted as resetting the type. That should probably
>>> be maintained.
>>>
>>> For SO_TIMESTAMPING, a mono delivery time of 0 does have some meaning.
>>> In __sock_recv_timestamp:
>>>
>>>         /* Race occurred between timestamp enabling and packet
>>>            receiving.  Fill in the current time for now. */
>>>         if (need_software_tstamp && skb->tstamp == 0) {
>>>                 __net_timestamp(skb);
>>>                 false_tstamp = 1;
>>>         }
>>
>> Well in that case the above logic still resets the tstamp and sets the tstamp_type to CLOCK_REAL(value 0). 
>> Anyway the tstamp_type will be 0 to begin with. 
>> The logic is still inline with previous implementation, because previously if kt was 0 then kt && mono sets the tstamp_type (previously called as mono_delivery_time) to 0 (i.e SKB_CLOCK_REAL). 
> 
> Sorry, I got my defaults confused. If we maintain that a zero tstamp
> resets the type, then here should be no case with skb->tstamp 0 and
> skb->tstamp_type SKB_CLOCK_REAL (or SKB_CLOCK_TAI or whatever). I
> think it's preferable to make that obvious in the
> skb_set_delivery_time implementation, rather than depend on knowledge
> of its callers.

Noted!. I will do the same as part of the next patchset. 

