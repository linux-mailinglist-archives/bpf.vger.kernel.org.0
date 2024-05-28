Return-Path: <bpf+bounces-30782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907578D2588
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3932CB2A94C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41247178CEA;
	Tue, 28 May 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p6XmlauK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11310A3E;
	Tue, 28 May 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927148; cv=none; b=pMo/u5lpny7AmjNq1DIGa+7gyGqSidVnGYI2ewuNJZKCACUcdw26J4oPT3LINiXnE15GXxa9ZUCc5T2b06ehcpoBuuEUiQIUFPN4VRXrnu9UyEwLX64AizmO4YgAyAtbQSxoJ8uhcW/7bIOXswzP3PJlgPXYSdmC4YA5aqKSnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927148; c=relaxed/simple;
	bh=GGwJig3ttNp4mKgisfe/j7TzC6TLTEs7rQFGlngtF3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q/IC9UhQZNR2jyDm4IeVS2cJA3rtPYIpmrXRICGBWfIhQaZ2LpP/ZICubu5j4A3s4aj8RAlB4rNv2TpQQsVT82Xg6vPrVkWA8drS1Rgzcdbds28C/a1xrnnjRQ7hZF+2DQuZdPnoph7C8/pBZP6McVAcLCKjVXuf74ii8/k/w3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p6XmlauK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SACrkJ012744;
	Tue, 28 May 2024 20:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+o+KTgBoYHGezPhddSl91Bs+jGgLlZo/k87fQRqZFY=; b=p6XmlauKZpBhcR5I
	tU2Lcj8NOAuUDxDADHzSwGfCL3bH1SJ9cDDvcn5WguMSsogkx1MFNageas/9CAtq
	a/WE/5rLlpZro2VDeXKuqGoHBX3YbIp1r1F5dGArjS68NEMhD0YZ0z6glOyMGrMt
	iUdXxJ+WBms2jdgJI/cRgVj/kdtpaTO34s/Y3VJ469krSvZDKb3TqzTRX1hAjdrl
	PpR0uhWe+6qK6lmqhUHn2YY7KAV3svmntlcu4r6R9zu57IPEcHgwjZlaOfo6bLGu
	B3/fIpDb+v5OzrP7FcHhRZI44R8G0QEFzvt/3rvWpRkQgZrAje7TENqTX6HsRjcE
	K2lOng==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k77yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:12:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SKC2uh032206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:12:02 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 13:11:58 -0700
Message-ID: <c7d66e70-0998-4e2b-94e8-8b19e65ec959@quicinc.com>
Date: Tue, 28 May 2024 13:11:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: <kernel@quicinc.com>, Willem de Bruijn <willemb@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney
	<ahalaney@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
 <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
 <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
 <d1c18889-ef48-4cb8-8b81-474b3b7ddd81@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <d1c18889-ef48-4cb8-8b81-474b3b7ddd81@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f-uzHP2IIrVrwzCH6mR_ErYeEBhi9fAF
X-Proofpoint-GUID: f-uzHP2IIrVrwzCH6mR_ErYeEBhi9fAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280151



On 5/28/2024 12:30 PM, Martin KaFai Lau wrote:
> On 5/28/24 10:24 AM, Willem de Bruijn wrote:
>> Abhishek Chauhan (ABC) wrote:
>>
>>>> +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
>>>> +                            ktime_t kt, clockid_t clockid)
>>>> +{
>>>> +    u8 tstamp_type = SKB_CLOCK_REALTIME;
>>>> +
>>>> +    switch (clockid) {
>>>> +    case CLOCK_REALTIME:
>>>> +        break;
>>>> +    case CLOCK_MONOTONIC:
>>>> +        tstamp_type = SKB_CLOCK_MONOTONIC;
>>>> +        break;
>>>> +    default:
>>>
>>> Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn.
>>> So i think this might result in unnecessary crashes.
>>>
>>> Let me know what you think.
>>>
>>> Logs which are complaining.
>>> https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000
>>
>> I received reports too. Agreed that we need to fix these reports.
>>
>> The alternative is to limit sk_clockid to supported ones, by failing
>> setsockopt SO_TXTIME on an unsupported clock.
>>
>> That changes established ABI behavior. But I don't see how another
>> clock can be used in any realistic way anyway.
>>
>> Putting it out there as an option. It's riskier, but in the end I
>> believe a better fix than just allowing this state to continue.
> 
> Failing early would be my preference also. The current ABI is arguably at least confusing (if not broken) considering other clockid is silently ignored by the kernel.
> 

Okay since we all agree to fix the setsockopt SO_TXTIME  to only limit sk_clockid be set to supported ones (MONO/TAI/REAL).
All other clocks needs to return -EINVAL for setsockopt. 

I will raise the patch and also add the fixes and reported-by tag accordingly. 

>>
>> A third option would be to not fail the system call, but silently
>> fall back to CLOCK_REALTIME. Essentially what happens in the datapath
>> in skb_set_delivery_type_by_clockid now. That is surprising behavior,
>> we should not do that.
> 
> Not sure if it makes sense to go back to this option only after there is breakage report with a legit usage?
> 

