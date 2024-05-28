Return-Path: <bpf+bounces-30766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359668D239E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44541F23493
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD917167A;
	Tue, 28 May 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aaIuOXAP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4392563;
	Tue, 28 May 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922741; cv=none; b=drpkl9y2xYY8u8ltwLSgbLKcL7B1yWX06rMGec2bU8Xd+156XIqk7MKVYu6bXWNoxweMLYqpCrJLeBziVvTIANU6YpxxTuldyNXQrs58TZ3W+wzTIyzL4MoPR2y0CdC1tNRo5eJH+GH94TXKwALkB4GH+xs1NxiWl5eE7N7HUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922741; c=relaxed/simple;
	bh=W7NINJAfUE5+sC2Emy6XSjc0tWE68CZdGq0aJ2UO3w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ar0FEu1dCRue1KYAdkjoNjD3hn5xEkkyEoSgRvVVI9qfKgAnhKTZvgfwmlKjRyYPkLsLyVBaF5WpCZguFqspGSd1ws/jbPTABwrGuZqAobxRSQUVxIUjYfsukFvQvgmS6s1ydE02xfTTmHYp5R9OZnbfixEaVaPxkBqe95lfoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aaIuOXAP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBk93T020271;
	Tue, 28 May 2024 18:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXaJLaXWX0TfB8EfTxrbz0twl+rwQq6aFudYwlaH1YY=; b=aaIuOXAPanto0XhG
	z0dDv1IVN4WIo6NqjaAvBfKLR9nmcdZL628jgXAr56y7q/nW1wcTuwbPpR4/+UIG
	qapT6Vy3w5bV6v7fVygIV81nmOfHRlaJIFcmM4G9HqUVGnljklyVQsX3gto3AvNZ
	io9hpANIs/M/fAsP0H9n9WXLrrSix0+Mc9af1L5/e/rrDLtJ3MIRb95lEPqI1j/h
	DQea/R2GRtKSvs91/tGIoAz5UFPbYYenHej92sr1iZlJNhSIExOJHHcg8jPHs4Za
	8iOfnBzBVoCuZV8ve0asuAItiFHhWw22/hyAib+2E66KLP+KuV/+Hh0i7/OYKJMQ
	q0GdQA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h71dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 18:58:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SIwacq005019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 18:58:36 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 11:58:33 -0700
Message-ID: <029a0d9c-7a8f-40d6-8296-7c6e9915a9cf@quicinc.com>
Date: Tue, 28 May 2024 11:58:32 -0700
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
CC: <kernel@quicinc.com>, Willem de Bruijn <willemb@google.com>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
 <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
 <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l9YZqY9o3Y-jhkalMgdDcau7VEpPvrJB
X-Proofpoint-ORIG-GUID: l9YZqY9o3Y-jhkalMgdDcau7VEpPvrJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=651 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280141



On 5/28/2024 10:24 AM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
> 
>>> +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
>>> +						    ktime_t kt, clockid_t clockid)
>>> +{
>>> +	u8 tstamp_type = SKB_CLOCK_REALTIME;
>>> +
>>> +	switch (clockid) {
>>> +	case CLOCK_REALTIME:
>>> +		break;
>>> +	case CLOCK_MONOTONIC:
>>> +		tstamp_type = SKB_CLOCK_MONOTONIC;
>>> +		break;
>>> +	default:
>>
>> Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn. 
>> So i think this might result in unnecessary crashes. 
>>
>> Let me know what you think. 
>>
>> Logs which are complaining. 
>> https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000
> 
> I received reports too. Agreed that we need to fix these reports.
> 
> The alternative is to limit sk_clockid to supported ones, by failing
> setsockopt SO_TXTIME on an unsupported clock.
> 
> That changes established ABI behavior. But I don't see how another
> clock can be used in any realistic way anyway.
> 
> Putting it out there as an option. It's riskier, but in the end I
> believe a better fix than just allowing this state to continue.
> 
I understand your thought process here, but i think doing this option means 
no application from userspace can use any other clocks except REALTIME, MONO and TAI.

That being said application which are using different sock options to set other clocks needs
to change and work with just REALTIME , MONO or TAI. (Meaning the above warning from google compute engine
would be gone because setsock option itself failed in the first place, I suspect here the clockid being used is 
CLOCK_BOOTTIME which is similar to CLOCK_MONOTONIC with system suspend time as well)

I feel that the options which are exposed by SO_TXTIME are limitless as of today the code 
lacks basic checks such as not checking if the userspace gave a correct input. Meaning if i set
value 100 as the clockid and write a small application in userspace to set SO_TXTIME. The funny part is the 
clockid is successfully set even though there is no clock id 100 in kernel 

example :- 

[root@auto-lvarm-004 ~]# ./a.out -4 -S 192.168.1.1 -D 192.168.1.10 a,10

value from getsockopt is 100 <== Which means the setsockopt was successful with clockid 100 (which is junk)


I also agree that even without my patch, the code in fragmentation case was defaulting it to CLOCK_REALTIME 
if the mono_delivery_time bool was not set. (So we tried to keep the logic as close to the one which was available in upstream today)


I can propose 2 solutions to this 
1. Have stricter checks in setsockopt functions to set only REALTIME, MONO and TAI 
OR
2. Allow all clock id but only set tstamp_type for TAI, MONO and REALTIME to be forwarded to userspace(logic) 

static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
						    ktime_t kt, clockid_t clockid)
{
	u8 tstamp_type = SKB_CLOCK_REALTIME;

	switch (clockid) {
	case CLOCK_REALTIME:
		break;
	case CLOCK_MONOTONIC:
		tstamp_type = SKB_CLOCK_MONOTONIC;
		break;
	case CLOCK_TAI:
		tstamp_type = SKB_CLOCK_TAI;
		break;
	default:
		WARN_ON_ONCE(1); <== remove this 
		kt = 0; <== remove this
	}

	skb_set_delivery_time(skb, kt, tstamp_type); <== pass kt as ease (as it is done previously too) and tstamp_type internally remains REAL
}

Let me know what you think. !

> A third option would be to not fail the system call, but silently
> fall back to CLOCK_REALTIME. Essentially what happens in the datapath
> in skb_set_delivery_type_by_clockid now. That is surprising behavior,
> we should not do that.

