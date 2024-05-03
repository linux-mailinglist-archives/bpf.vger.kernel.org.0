Return-Path: <bpf+bounces-28555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC58BB6F7
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 00:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1DDB21951
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AB5BAFC;
	Fri,  3 May 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YAhI14cz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131D4CDE0;
	Fri,  3 May 2024 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774530; cv=none; b=YBMwiBs+n6UwHA81o+6zbOevghY1EiL7o9Rtm1YJ8aR36WshPcd7d5FhuEOyp77bnyksxANWlqboGIZkjUwghBbMNsBaO5OnjYcpEcFwZyokbJzzYDf9B6DMzSOQPMB1gIIgbNg9Eg1GtgUQ5eRRWgZ+3ouLktmwnXFiusxIhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774530; c=relaxed/simple;
	bh=tinm9kKLjIgzgDjgzRP63S78uzv6+g+okkH6tiQvNeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FcravizNb82y6dDRog1pvkZ/e40LXRQcpupWXttUvTsmsZm8YWZrlTYSs6DZV/SMCBBIRp8viVcx1Ssg4rDTVQ4n5rXjkDKcBSlHmFocJOMKb9kZQ4ooLuThmwgmmVIf+gQ993qDnXwmeTPEL3bxT0hPBhGJIOtzNDWSjM73tIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YAhI14cz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443MAtcn019760;
	Fri, 3 May 2024 22:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qnN8WM7oIQTApTeqhyYdpQY0xLGjtq+AnFHwnO5eN7A=; b=YA
	hI14cz68GmOLsT0j9oVyZf+GpShiEOU2YGlQO8olnd6T35jb/3I8Z4H26NzJHR9z
	FhlQnLLdTErxgmdiiMjO1fqCzRMrfP/FSl4+FvSVMASmSGr3fxf0RwvA2AqcFZBF
	pBlKwEGMoqHzs/TvfA0UuXdhIG1JJLkwH/lPh3gZXafze4CR4dZkbtNoMS4wPdv1
	3DZLLPm3402uBmKKjBrg+CWe/P/9nfKWQxcf9dZokAcm8W3iOoxuheA6SvPks5DB
	dF45pR6BiE6gh2UXwMH1iiT9DLP3XXtaxa3Yh5j1L9487hAYjx5m86xpJxcV+jMM
	AG/VhNEl5Vm7iWjvs5mw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvpvma7ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 22:15:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443MF0Ja019885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 22:15:01 GMT
Received: from [10.110.77.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 15:14:57 -0700
Message-ID: <a3dd325c-a9f8-4146-8cfe-12e506cbf225@quicinc.com>
Date: Fri, 3 May 2024 15:14:57 -0700
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
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
 <0f88ec53-6c92-434d-81c8-538b31a2385e@quicinc.com>
 <8376c566-14a4-4b11-89ba-bb544ee5f8e2@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <8376c566-14a4-4b11-89ba-bb544ee5f8e2@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rBslkbOIYbBr0yCyhgIQniVXsp0vfHhz
X-Proofpoint-GUID: rBslkbOIYbBr0yCyhgIQniVXsp0vfHhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030159



On 5/3/2024 2:41 PM, Martin KaFai Lau wrote:
> On 5/3/24 2:33 PM, Abhishek Chauhan (ABC) wrote:
>>
>>> BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>>>             u64, tstamp, u32, tstamp_type)
>>> {
>>>      /* ... */
>>>      case BPF_SKB_CLOCK_TAI:
>>>          if (!tstamp)
>>>              return -EINVAL;
>>>          skb->tstamp = tstamp;
>>>          skb->tstamp_type = SKB_CLOCK_TAI;
>>>          break;
>>>          case BPF_SKB_CLOCK_REALTIME:
>>>          skb->tstamp = tstamp;
>>>          skb->tstamp_type = SKB_CLOCK_REALTIME;
>>>          break;
>>>
>>>      /* ... */
>>> }
>>>
>>>>                return -EINVAL;
>>>
>>>> @@ -9388,17 +9394,17 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>>    {
>>>>        __u8 value_reg = si->dst_reg;
>>>>        __u8 skb_reg = si->src_reg;
>>>> -    /* AX is needed because src_reg and dst_reg could be the same */
>>>> -    __u8 tmp_reg = BPF_REG_AX;
>>>> -
>>>> -    *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>>> -                  SKB_BF_MONO_TC_OFFSET);
>>>> -    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>> -                SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>> -    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>>> -    *insn++ = BPF_JMP_A(1);
>>>> -    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>>> -
>>>> +    BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>>>
>>> Add these also:
>>>
>>>      BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>>>      BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != BPF_SKB_CLOCK_MONOTONIC);
>>>      BUILD_BUG_ON(SKB_CLOCK_TAI != BPF_SKB_CLOCK_TAI);
>>>
>>
>> Martin, The above suggestion of adding BUILD_BUG_ON always gives me a warning stating the following.
>>
>> Some systems considers warning as error if compiler flags are enabled. I believe this requires your suggestion before i raise RFC v6 patchset to either keep the
>> BUILD_BUG_ON or remove it completely.
> 
> cast it?
> 
Thanks Martin. Will do the same. Casting worked for me!. 

>>
>> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9395:34: warning: comparison between ‘enum skb_tstamp_type’ and ‘enum <anonymous>’ [-Wenum-compare]
>>   9395 |  BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>>        |                                  ^~
>> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:451:9: note: in definition of macro ‘__compiletime_assert’
>>    451 |   if (!(condition))     \
>>        |         ^~~~~~~~~
>> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:471:2: note: in expansion of macro ‘_compiletime_assert’
>>    471 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>        |  ^~~~~~~~~~~~~~~~~~~
>> /local/mnt/workspace/kernel_master/linux-next/include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>        |                                     ^~~~~~~~~~~~~~~~~~
>> /local/mnt/workspace/kernel_master/linux-next/include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>     50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>        |  ^~~~~~~~~~~~~~~~
>> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9395:2: note: in expansion of macro ‘BUILD_BUG_ON’
>>   9395 |  BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>>        |  ^~~~~~~~~~~~
>> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9396:35: warning: comparison between ‘enum skb_tstamp_type’ and ‘enum <anonymous>’ [-Wenum-compare]
>>   9396 |  BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != BPF_SKB_CLOCK_MONOTONIC);
>>        |                                   ^~
>> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:451:9: note: in definition of macro ‘__compiletime_assert’
>>    451 |   if (!(condition))     \
>>        |         ^~~~~~~~~
>>
>>           |                                      ^~
>>
>>
>>
> 

