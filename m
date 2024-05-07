Return-Path: <bpf+bounces-28750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31888BD8C3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2ECB24427
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6D4688;
	Tue,  7 May 2024 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LkK5+wzm"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E00138C
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043264; cv=none; b=LSlOeN28f6CVho4IysxKvObeTnQEdzRS+TsR/JvWHqc5t+gVso3Lz6WHw5+dc8Z3JeKXTqXLIaVQFgyDxcDsddyACk7lzu5IyQMhCNfNaBYjxo7GQ1iJJIFx8TXMg1dwsp2Luu8Z9b0aOUZk6/940zVqSGdVwpiDyF3OI+39eXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043264; c=relaxed/simple;
	bh=o8Bc5Ez/6YqYURlwwo5HZX/zfkTVwJuvYFnD3wNE9ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7/Xkifh/0gz7WRn9s6noHN7bXrz95TswyrWv+bXwIr7Q6Cu21QyG2BmZXoJ3F2p5A+xRHexUWyUaBqZEuKx5itt2JgLhSci+MTaw5BYcOK7ZPndbmHKQhHo4oCTfnF+khMhIXA80liTWW0rzht/ioV/JkZvG+DGcb1g6yTFHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LkK5+wzm; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4957aaf-6b3f-45e8-8c18-a9f74213d0f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715043258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkN5x92xDG37kTOdUdSnJWPAN51eOIj86lnHKaDFNr0=;
	b=LkK5+wzmXqo5sFsIhsMoTy0VapcDfqDuxZ3bfxSNryi85yj7zKlSdh+mFCFFcQCLYMRSJj
	TcSTdH1wcZC4ssayEtP5BM1mvNQEMHg029Xyq2bFVaS8lOF544saj0ciaq1yvd1nR/v0JP
	OZAckBjKAHxAuJT5NGL77nQS9sWwcN0=
Date: Mon, 6 May 2024 17:54:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v6 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-4-quic_abchauha@quicinc.com>
 <663929b249143_516de2945@willemb.c.googlers.com.notmuch>
 <d613c5a6-5081-4760-8a86-db1107bdc207@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d613c5a6-5081-4760-8a86-db1107bdc207@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 1:50 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 5/6/2024 12:04 PM, Willem de Bruijn wrote:
>> Abhishek Chauhan wrote:
>>> With changes in the design to forward CLOCK_TAI in the skbuff
>>> framework,  existing selftest framework needs modification
>>> to handle forwarding of UDP packets with CLOCK_TAI as clockid.
>>>
>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>> ---
>>>   tools/include/uapi/linux/bpf.h                | 15 ++++---
>>>   .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>>>   .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>>>   .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>>>   4 files changed, 34 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>> index 90706a47f6ff..25ea393cf084 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -6207,12 +6207,17 @@ union {					\
>>>   	__u64 :64;			\
>>>   } __attribute__((aligned(8)))
>>>   
>>> +/* The enum used in skb->tstamp_type. It specifies the clock type
>>> + * of the time stored in the skb->tstamp.
>>> + */
>>>   enum {
>>> -	BPF_SKB_TSTAMP_UNSPEC,
>>> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
>>> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>>> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>>> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
>>> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
>>> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
>>> +	BPF_SKB_CLOCK_REALTIME = 0,
>>> +	BPF_SKB_CLOCK_MONOTONIC = 1,
>>> +	BPF_SKB_CLOCK_TAI = 2,
>>> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
>>> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>>>   	 */
>>>   };
>>>   
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> index 3b7c57fe55a5..71940f4ef0fb 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>>>   	{
>>>   		N(SCHED_CLS, struct __sk_buff, tstamp),
>>>   		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>> -			 "w11 &= 3;"
>>> -			 "if w11 != 0x3 goto pc+2;"
>>> +			 "if w11 == 0x4 goto pc+1;"
>>> +			 "goto pc+4;"
>>> +			 "if w11 == 0x3 goto pc+1;"
>>> +			 "goto pc+2;"
>>
>> Not an expert on this code, and I see that the existing code already
>> has this below, but: isn't it odd and unnecessary to jump to an
>> unconditional jump statement?
>>
> I am closely looking into your comment and i will evalute it(Martin can correct me
> if the jumps are correct or not as i am new to BPF as well) but i found out that
> JSET = "&" and not "==". So the above two ins has to change from -

Yes, this should be bitwise "&" instead of "==".

The bpf CI did report this: 
https://github.com/kernel-patches/bpf/actions/runs/8947652196/job/24579927178

Please monitor the bpf CI test result.

Do you have issue running the test locally?

> 
> "if w11 == 0x4 goto pc+1;" ==>(needs to be corrected to) "if w11 & 0x4 goto pc+1;"
>   "if w11 == 0x3 goto pc+1;" ==> (needs to be correct to) "if w11 & 0x3 goto pc+1;"
> 
> 
>>>   			 "$dst = 0;"
>>>   			 "goto pc+1;"
>>>   			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>>>   		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>> -			 "if w11 & 0x2 goto pc+1;"
>>> +			 "if w11 & 0x4 goto pc+1;"
>>>   			 "goto pc+2;"
>>> -			 "w11 &= -2;"
>>> +			 "w11 &= -3;"
> Martin,
> Also i am not sure why the the dissembly complains because the value of SKB_TSTAMP_TYPE_MASK = 3 and we are
> negating it ~3 = -3.
> 
>    Can't match disassembly(left) with pattern(right):
>    r11 = *(u8 *)(r1 +129)  ;  r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset)
>    if w11 & 0x4 goto pc+1  ;  if w11 & 0x4 goto pc+1
>    goto pc+2               ;  goto pc+2
>    w11 &= -4               ;  w11 &= -3
> 
>>>   			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>>>   			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>>>   	},


