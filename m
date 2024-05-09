Return-Path: <bpf+bounces-29227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45928C1569
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E3E282A5E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6C7F7E4;
	Thu,  9 May 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BKFyxaE6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FF58AD0;
	Thu,  9 May 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282711; cv=none; b=cnUK8f3qpqWd+N+KdZbuy7rKKauK27RxgsXd2YuqBYxzBM8btNHBempBpjOlbOsmElRVOb7jTuY0V+VARtFZgExOHVVrt0uOclDeuM3OemcfoyVhc8dBeW8bO4y2B7WPyXfgeh4Da2wTvGsobYjJ3n6BVgygO05IDQZ8FR3zqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282711; c=relaxed/simple;
	bh=5aqb0P387QZx1UosCoAcJMRfHFMgFslVT6Dmc7NgopE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJskJYHUvz3m7XeuudpUemO8t5sRuDCgkUuOJOS9h9HRt/eZfFMDl5ed5juLMSLFdf2wMvV6QGL8UsnwLe90YQi7PmPmCbL8gWOwNG/OkTZNd4ZZmDkkz+FqulOpuBid/XTA5mULWgo6UosdK2yoCWEyPqvndlPH6DRbySvEztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BKFyxaE6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449Ic6Kr017606;
	Thu, 9 May 2024 19:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bTk++dJUPn75cMEYvh7SMilpRzMGtp7tcM8WVq8ziEM=; b=BK
	FyxaE6USt7Klr0U72mi90iytCaSYEX2aCoRiC60ix5P0qGWRKN/9GOjB18MjBV1V
	3q5taTjKpYv4ncCHTTqL5HdYqnovvpxr9jfI60Jdt5m6MaZvLiIzMgAAmmB+7fTm
	90oqnno4l1XdKp9GvOpvZ+DJdn9zN/b+iT/r23OZls+CjYjnTJlIfaWmG5UmOUSh
	4dklr+vWwiINkrixpTnIWQJvr3lLN17rMFQm+Hp/WFaqFLicb/jsKxNhq0QPT1AY
	b63Dj4NGEkhTtW0BcLGsU4AeZvtr51wxejhUAw4W8NCmex3czvyYdi1/P29e/qy3
	Qff67ioQYq+y4F2Ydj0w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y0930uh7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 19:24:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449JOfL7031869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 19:24:41 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 12:24:37 -0700
Message-ID: <3b9b51d4-95c5-4f31-afb1-246dd9b00467@quicinc.com>
Date: Thu, 9 May 2024 12:24:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v7 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf
	<bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240508215842.2449798-1-quic_abchauha@quicinc.com>
 <20240508215842.2449798-4-quic_abchauha@quicinc.com>
 <c929dced-e70e-4f49-b812-026b2677bfd9@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <c929dced-e70e-4f49-b812-026b2677bfd9@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MoiFAyQTWuqt_PDZPNwIprIcsPZj5aCO
X-Proofpoint-ORIG-GUID: MoiFAyQTWuqt_PDZPNwIprIcsPZj5aCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_11,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090137



On 5/9/2024 12:17 PM, Martin KaFai Lau wrote:
> On 5/8/24 2:58 PM, Abhishek Chauhan wrote:
>> With changes in the design to forward CLOCK_TAI in the skbuff
>> framework,  existing selftest framework needs modification
>> to handle forwarding of UDP packets with CLOCK_TAI as clockid.
> 
> The set lgtm. I have a few final nits on the test.
> 
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>> Changes since v7
>> - Fixed  issues in the ctx_rewrite.c
>>    with respect to dissembly in both
>>    .read and .write
>>
>> Changes since v6
>> - Moved all the selftest to another patch
>>
>> Changes since v1 - v5
>> - Patch was not present
>>
>>   tools/include/uapi/linux/bpf.h                | 15 ++++---
>>   .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>>   .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>>   .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>>   4 files changed, 34 insertions(+), 33 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 90706a47f6ff..25ea393cf084 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
> 
> nit. Please move this bpf.h sync changes to patch 2 where the uapi changes happen.
> 
>> @@ -6207,12 +6207,17 @@ union {                    \
>>       __u64 :64;            \
>>   } __attribute__((aligned(8)))
>>   +/* The enum used in skb->tstamp_type. It specifies the clock type
>> + * of the time stored in the skb->tstamp.
>> + */
>>   enum {
>> -    BPF_SKB_TSTAMP_UNSPEC,
>> -    BPF_SKB_TSTAMP_DELIVERY_MONO,    /* tstamp has mono delivery time */
>> -    /* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>> -     * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>> -     * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
>> +    BPF_SKB_TSTAMP_UNSPEC = 0,        /* DEPRECATED */
>> +    BPF_SKB_TSTAMP_DELIVERY_MONO = 1,    /* DEPRECATED */
>> +    BPF_SKB_CLOCK_REALTIME = 0,
>> +    BPF_SKB_CLOCK_MONOTONIC = 1,
>> +    BPF_SKB_CLOCK_TAI = 2,
>> +    /* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
>> +     * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>>        */
>>   };
>>   diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>> index 3b7c57fe55a5..08b6391f2f56 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>>       {
>>           N(SCHED_CLS, struct __sk_buff, tstamp),
>>           .read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>> -             "w11 &= 3;"
>> -             "if w11 != 0x3 goto pc+2;"
>> +             "if w11 & 0x4 goto pc+1;"
>> +             "goto pc+4;"
>> +             "if w11 & 0x3 goto pc+1;"
>> +             "goto pc+2;"
>>                "$dst = 0;"
>>                "goto pc+1;"
>>                "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>>           .write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>> -             "if w11 & 0x2 goto pc+1;"
>> +             "if w11 & 0x4 goto pc+1;"
>>                "goto pc+2;"
>> -             "w11 &= -2;"
>> +             "w11 &= -4;"
>>                "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>>                "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>>       },
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> index b1073d36d77a..327d51f59142 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> @@ -890,9 +890,6 @@ static void test_udp_dtime(struct test_tc_dtime *skel, int family, bool bpf_fwd)
>>         ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
>>             dtime_cnt_str(t, INGRESS_FWDNS_P100));
>> -    /* non mono delivery time is not forwarded */
>> -    ASSERT_EQ(dtimes[INGRESS_FWDNS_P101], 0,
>> -          dtime_cnt_str(t, INGRESS_FWDNS_P101));
>>       for (i = EGRESS_FWDNS_P100; i < SET_DTIME; i++)
>>           ASSERT_GT(dtimes[i], 0, dtime_cnt_str(t, i));
>>   diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
>> index 74ec09f040b7..21f5be202e4b 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
>> @@ -222,13 +222,19 @@ int egress_host(struct __sk_buff *skb)
>>           return TC_ACT_OK;
>>         if (skb_proto(skb_type) == IPPROTO_TCP) {
>> -        if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
>> +        if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
>> +            skb->tstamp)
>> +            inc_dtimes(EGRESS_ENDHOST);
>> +        else
>> +            inc_errs(EGRESS_ENDHOST);
>> +    } else if (skb_proto(skb_type) == IPPROTO_UDP) {
>> +        if (skb->tstamp_type == BPF_SKB_CLOCK_TAI &&
>>               skb->tstamp)
>>               inc_dtimes(EGRESS_ENDHOST);
>>           else
>>               inc_errs(EGRESS_ENDHOST);
>>       } else {
>> -        if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
>> +        if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
>>               skb->tstamp)
> 
> Since the UDP+TAI can be handled properly in the above "else if" case now, I would like to further tighten the bolt on detecting the non-zero REALTIME skb->tstamp here since it should not happen at egress. Something like:
> 
>     } else {
>         if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
>             skb->tstamp)
>             inc_errs(EGRESS_ENDHOST);
>     }
> 
> I ran the test (w or w/o the above inc_errs changes) in a loop and it consistently passes now.
> 
> Other than the above small nits, in the next re-spin, please remove the RFC tag and you can carry my reviewed-by to all 3 patches. Thanks.
> 
Noted! 
Thank you Martin and Willem for helping me with this series. 
And all the design discussion we had throughout the series. 
Appreciate all the comments from yourside. 
I will raise the last series with no RFC tag 
1. carry Reviewed-by: 
2. Fix all the above comments 



> Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
>>               inc_dtimes(EGRESS_ENDHOST);
>>           else
> 

