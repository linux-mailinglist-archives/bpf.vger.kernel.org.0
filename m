Return-Path: <bpf+bounces-27849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C398B28AE
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761D31C21D44
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6651514D9;
	Thu, 25 Apr 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZsDIeNga"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D238FB6;
	Thu, 25 Apr 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071797; cv=none; b=ccNipz0WwzBxzWHCmCusjNIYCB3zsDy5rOZzsxemDQHKLleUMTrh1Eom2LCG1zryI7kkYzuQKQdU0E34XqeJQJqKjKEbOWw86En64ilqgnnpb0UqVQKSVjE14qqxOo8OsWC2QfBj1aX1LPvIfp1i5jG0ZJ8v6bH3NM9ybFhH8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071797; c=relaxed/simple;
	bh=fQMju6pl3GAVTlWaCN8Cg4LCisN2oyIKCLp10Fy+GBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k/QPUKoKnwgn4gWDLlkyzNIYQNeVfk9he2pKrbDZvT0kpVgoxjKWGvP4YkVL/kLw/wOn9l2QNQOOiHtTQ8IbGaudI5LPPaEHM3gvD7CohJnnQmIxfERkzwqUBqF5yRDCbevk15o4Q3x8MbUUqGP5/dS8BiIEqNPNilbfA83LVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZsDIeNga; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PGFjPS017155;
	Thu, 25 Apr 2024 19:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=v/PYIYzkJqGqylQaGpFlLt9ov7N8tLZ1LAEa89j9rUs=; b=Zs
	DIeNga0zJxjgmzCblBnMaF9ZEfEWMXe5nm6pm4l9X5/o93nTRJqjSe2Mr+lZw1xA
	d7tsXWUN8bqkRyeJCPPB2G6AdsIsPM1hh3tM1CxlmOi1ScswdZXRTl5nIyfQX8gk
	Qfx6fT0y0T6daog7pKpDNPLcqi2HU64/RsDvK+sCtWiV0xgN7FE+HN8F0wNGJc16
	CpxVcrC+ObE+756UzEamZV/y2y0mlCijYsLoZLwh4FDTyiGB3Kjalq/2PFmRv9Fz
	tYjQA9k6wg6B1F3W68ciT4xKy5yAcqtlbdU74/wtv+7mI3V4btGHusHqUEc1gUEN
	q8ehRsacSc3i1p0sOL2Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqthv0c4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:02:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PJ2lrL001630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:02:47 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 12:02:43 -0700
Message-ID: <a84d314a-fca4-4317-9d33-0c7d3213c612@quicinc.com>
Date: Thu, 25 Apr 2024 12:02:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v5 1/2] net: Rename mono_delivery_time to
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
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-2-quic_abchauha@quicinc.com>
 <662a69475869_1de39b29415@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <662a69475869_1de39b29415@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qWVlQCgbGNXPkuCTwWrIqa3G5YnBTx2i
X-Proofpoint-GUID: qWVlQCgbGNXPkuCTwWrIqa3G5YnBTx2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=898 malwarescore=0
 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250136



On 4/25/2024 7:31 AM, Willem de Bruijn wrote:
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
>> Introduce a new function to set tstamp_type based on clockid. 
>>
>> In future tstamp_type:1 can be extended to support userspace timestamp
>> by increasing the bitfield.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> 
>> +static inline void skb_set_tstamp_type_frm_clkid(struct sk_buff *skb,
>> +						  ktime_t kt, clockid_t clockid)
>> +{
> 
> Please don't garble words to save a few characters: .._from_clockid.
> 
Noted and apologies for using garble words here. I will correct it. 
> And this is essentially skb_set_delivery_type, just taking another
> type. So skb_set_delivery_type_(by|from)_clockid.
> 
> Also, instead of reimplementing the same logic with a different
> type, could implement as a conversion function that calls the main
> function. It won't save lines. But will avoid duplicate logic that
> needs to be kept in sync whenever there are future changes (fragile).
> 

I thought about doing this but as you remember that some places in the network stack, 
we are passing tstamp_type and some places we are passing clockid. 

So in the previous patchset we decided with two variants. 
1. One that assigns the tstamp_type directly 
2. Other one which computes tstamp_type based on clockid

But i agree on the above comment that if we implement two different variants 
then in future it requires maintenance to both functions. 

I will make sure i handle both cases in one func.   


> static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
> 						    ktime_t kt, clockid_t clockid)
> {
> 	u8 tstamp_type = SKB_CLOCK_REAL;
> 
> 	switch(clockid) {
> 	case CLOCK_REALTIME:
> 		break;
> 	case CLOCK_MONOTONIC:
> 		tstamp_type = SKB_CLOCK_MONO;
> 		break;
> 	default:
> 		WARN_ON_ONCE(1);
> 		kt = 0;
> 	};
> 
> 	skb_set_delivery_type(skb, kt, tstamp_type);
> }
> 
> 
>> +	skb->tstamp = kt;
>> +
>> +	if (!kt) {
>> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
>> +		return;
>> +	}
>> +
>> +	switch (clockid) {
>> +	case CLOCK_REALTIME:
>> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
>> +		break;
>> +	case CLOCK_MONOTONIC:
>> +		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
>> +		break;
>> +	}
>> +}
>> +
>>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>> -					 bool mono)
>> +					  u8 tstamp_type)
> 
> Indentation change: error?
>>> @@ -9444,7 +9444,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>  		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>> -		/* skb->tc_at_ingress && skb->mono_delivery_time,
>> +		/* skb->tc_at_ingress && skb->tstamp_type:1,
> 
> Is the :1 a stale comment after we discussed how to handle the 2-bit
This is first patch which does not add tstamp_type:2 at the moment. 
This series is divided into two patches 
1. One patchset => Just rename (So the comment is still skb->tstamp_type:1)
2. Second patchset => add another bit (comment is changed to skb->tstamp_type:2)

> field going forward? I.e., not by ignoring the second bit.
> 
> 

