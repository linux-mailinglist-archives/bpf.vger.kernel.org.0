Return-Path: <bpf+bounces-28942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BCF8BEC69
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAF1C2430C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A416DEBD;
	Tue,  7 May 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HDG4RCQR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A816E88E;
	Tue,  7 May 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109345; cv=none; b=VbU9o3Iv/war8KwDpZrP3YMWRML3awnnH6pa8+wgxntLIE7TF3WhAOiN7WIEfAtbSU3NpzjOstXTN4TBPO+rv5njERWM+JVKRge7uAMjM7lTh0AWlCOguLd/OESESWPPKqW2PJqs9+J6dkdRpD9b9B8KJZcSHqLcwJ2OOjJihpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109345; c=relaxed/simple;
	bh=H0OrEbKkNSluiLf/r1ab0wfVjhBJw5DKB5glHgKQknw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qCx5vbnBTSJdTT/B3vLWnw796Pt6uihH0klbnfCxp19u6nhDe9iy+oq4/Rl9U5M2mUfs2pd8XwVcmZ95V/gjW1Exlejs7mgbEHjRsTIB6CdQw4xfuNqP733x1l5Vnfynye46jE683ljF16FP63jfBZofLYjs8BbEuHop5Q4wSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HDG4RCQR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447IjSBp013292;
	Tue, 7 May 2024 19:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1ozfY6ERltqf/Cq7PFYWt9JbiYqu96TtyBwLN6d8sHs=; b=HD
	G4RCQRkTUOY17Aggc4oDtV5vUNg4CZ53qHvHVEAGShQ58AlUsEuIjGVQDCFKd8D1
	lVvpk9sIj6CIsCKNE86qlCpMuQtbOM6RDHVNIGZFXI+1JbVyPBwL+HzKxeke5qfT
	eyqpBXxX9CQp5svBWkNKnEZDFWW6GU4S8M7Nw9lgaA2uoq4CPsOrETXRU985F4xT
	N/+5UoZRHI1xhWqPUb6BYhb4weH7YUXj3mKFlBCb+1iBfB6qVm95AOFqHJitCCkv
	A3B6Wo+O/9aK10lVscWTKfD4npwX8lUaLUVxYZZ9HZWOkT/lMfj3qTYfv9tW1nn6
	rlqTmyCZBEE4iNXoRumw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyste024e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 19:15:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447JFLO6030978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:15:21 GMT
Received: from [10.110.127.27] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 12:15:18 -0700
Message-ID: <8569f47c-0c59-49f6-8b93-09bc0defb670@quicinc.com>
Date: Tue, 7 May 2024 12:15:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v6 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-4-quic_abchauha@quicinc.com>
 <663929b249143_516de2945@willemb.c.googlers.com.notmuch>
 <d613c5a6-5081-4760-8a86-db1107bdc207@quicinc.com>
 <a4957aaf-6b3f-45e8-8c18-a9f74213d0f3@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <a4957aaf-6b3f-45e8-8c18-a9f74213d0f3@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k5pvUtUAARjbwZE0Nl3U4YmBMIwdPprY
X-Proofpoint-ORIG-GUID: k5pvUtUAARjbwZE0Nl3U4YmBMIwdPprY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405070134



On 5/6/2024 5:54 PM, Martin KaFai Lau wrote:
> On 5/6/24 1:50 PM, Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 5/6/2024 12:04 PM, Willem de Bruijn wrote:
>>> Abhishek Chauhan wrote:
>>>> With changes in the design to forward CLOCK_TAI in the skbuff
>>>> framework,  existing selftest framework needs modification
>>>> to handle forwarding of UDP packets with CLOCK_TAI as clockid.
>>>>
>>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>> ---
>>>>   tools/include/uapi/linux/bpf.h                | 15 ++++---
>>>>   .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>>>>   .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>>>>   .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>>>>   4 files changed, 34 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>>> index 90706a47f6ff..25ea393cf084 100644
>>>> --- a/tools/include/uapi/linux/bpf.h
>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>> @@ -6207,12 +6207,17 @@ union {                    \
>>>>       __u64 :64;            \
>>>>   } __attribute__((aligned(8)))
>>>>   +/* The enum used in skb->tstamp_type. It specifies the clock type
>>>> + * of the time stored in the skb->tstamp.
>>>> + */
>>>>   enum {
>>>> -    BPF_SKB_TSTAMP_UNSPEC,
>>>> -    BPF_SKB_TSTAMP_DELIVERY_MONO,    /* tstamp has mono delivery time */
>>>> -    /* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>>>> -     * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>>>> -     * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
>>>> +    BPF_SKB_TSTAMP_UNSPEC = 0,        /* DEPRECATED */
>>>> +    BPF_SKB_TSTAMP_DELIVERY_MONO = 1,    /* DEPRECATED */
>>>> +    BPF_SKB_CLOCK_REALTIME = 0,
>>>> +    BPF_SKB_CLOCK_MONOTONIC = 1,
>>>> +    BPF_SKB_CLOCK_TAI = 2,
>>>> +    /* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
>>>> +     * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>>>>        */
>>>>   };
>>>>   diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>>> index 3b7c57fe55a5..71940f4ef0fb 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>>> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>>>>       {
>>>>           N(SCHED_CLS, struct __sk_buff, tstamp),
>>>>           .read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>>> -             "w11 &= 3;"
>>>> -             "if w11 != 0x3 goto pc+2;"
>>>> +             "if w11 == 0x4 goto pc+1;"
>>>> +             "goto pc+4;"
>>>> +             "if w11 == 0x3 goto pc+1;"
>>>> +             "goto pc+2;"
>>>
>>> Not an expert on this code, and I see that the existing code already
>>> has this below, but: isn't it odd and unnecessary to jump to an
>>> unconditional jump statement?
>>>
>> I am closely looking into your comment and i will evalute it(Martin can correct me
>> if the jumps are correct or not as i am new to BPF as well) but i found out that
>> JSET = "&" and not "==". So the above two ins has to change from -
> 
> Yes, this should be bitwise "&" instead of "==".
> 
> The bpf CI did report this: https://github.com/kernel-patches/bpf/actions/runs/8947652196/job/24579927178
> 
> Please monitor the bpf CI test result.
> 
> Do you have issue running the test locally?
> 
Yes, To be honest. I am facing compilation issues when i follow the documentation to Make BPF on latest kernel. 

This is slowing down my development with this patch. 

Very similar to the problem described here :- https://github.com/jsitnicki/ebpf-summit-2020/issues/1

local/mnt/workspace/kernel_master/linux-next/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:379:26: note: expanded from macro '___arrow2'
#define ___arrow2(a, b) a->b
                        ~^
skeleton/pid_iter.bpf.c:19:9: note: forward declaration of 'struct bpf_link'
        struct bpf_link link;
               ^
skeleton/pid_iter.bpf.c:105:7: error: incomplete definition of type 'struct bpf_link'
                if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~

>>
>> "if w11 == 0x4 goto pc+1;" ==>(needs to be corrected to) "if w11 & 0x4 goto pc+1;"
>>   "if w11 == 0x3 goto pc+1;" ==> (needs to be correct to) "if w11 & 0x3 goto pc+1;"
>>
>>
>>>>                "$dst = 0;"
>>>>                "goto pc+1;"
>>>>                "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>>>>           .write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>>> -             "if w11 & 0x2 goto pc+1;"
>>>> +             "if w11 & 0x4 goto pc+1;"
>>>>                "goto pc+2;"
>>>> -             "w11 &= -2;"
>>>> +             "w11 &= -3;"
>> Martin,
>> Also i am not sure why the the dissembly complains because the value of SKB_TSTAMP_TYPE_MASK = 3 and we are
>> negating it ~3 = -3.
>>
>>    Can't match disassembly(left) with pattern(right):
>>    r11 = *(u8 *)(r1 +129)  ;  r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset)
>>    if w11 & 0x4 goto pc+1  ;  if w11 & 0x4 goto pc+1
>>    goto pc+2               ;  goto pc+2
>>    w11 &= -4               ;  w11 &= -3
>>
>>>>                "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>>>>                "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>>>>       },
> 

