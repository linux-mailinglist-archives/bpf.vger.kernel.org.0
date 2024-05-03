Return-Path: <bpf+bounces-28552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8988BB652
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 23:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0231F21EF3
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F85CDFA;
	Fri,  3 May 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l5AZ0+Rn"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984931EB21;
	Fri,  3 May 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772477; cv=none; b=rRWtayDfFayAUjTkwoKAFpUkFAta4xwKTwTfkqSC7gz0G3Jb7HCVeiYaAOWOLKhir7wKOoUbRFfS2fP4mjXgJyBn5O4X2/6SAjcMl+Obsg1rftbs6DVv5VyKnknap/iOw0WCe7TmkdmAJpTervMPRsXKGJJrtg9ZKjiNHuGkrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772477; c=relaxed/simple;
	bh=5Ie0VfWEVEhTaPq2tuo8Tm98X78hh2rfQuYKbrLkDTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPGVcO0/DmPS6vR8gsNvKKaRvPqiqhoWop7mREefYeTMryI0gqMnv/dEisaP7XxLRjgtgZ0wL6M4L+VqzUjrg3bp0pETxF4iURQ2z9E/PvqviASx7xMC4eKUZORz+DjnCgBw6DYhpqPi4XQ8eBI/aPSvB7ZtaqFrJhRK4E/8FTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l5AZ0+Rn; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8376c566-14a4-4b11-89ba-bb544ee5f8e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714772472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/Q/2B8nlKGo4p9HVJI/N3QC9LbWf3C4w9luKfxzv9s=;
	b=l5AZ0+RnzYYlybEQotGfzh4XVbQDt7zU3J4piKdbNzJrVsWee6Ytrv97Z62cDJVbVu/Aaw
	1zj+kQNI1WZ2HpFhqTBmQ0lC2+Z8lYHghuEjV/ljuTa89ZTz0zmpjIjaEQlUW6Y8XLy3WV
	8j1d/wmf+7oZgbgvR7Qp6PPck6jCt3w=
Date: Fri, 3 May 2024 14:41:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
 <0f88ec53-6c92-434d-81c8-538b31a2385e@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0f88ec53-6c92-434d-81c8-538b31a2385e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/3/24 2:33 PM, Abhishek Chauhan (ABC) wrote:
> 
>> BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>>             u64, tstamp, u32, tstamp_type)
>> {
>>      /* ... */
>>      case BPF_SKB_CLOCK_TAI:
>>          if (!tstamp)
>>              return -EINVAL;
>>          skb->tstamp = tstamp;
>>          skb->tstamp_type = SKB_CLOCK_TAI;
>>          break;
>>          case BPF_SKB_CLOCK_REALTIME:
>>          skb->tstamp = tstamp;
>>          skb->tstamp_type = SKB_CLOCK_REALTIME;
>>          break;
>>
>>      /* ... */
>> }
>>
>>>                return -EINVAL;
>>
>>> @@ -9388,17 +9394,17 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>    {
>>>        __u8 value_reg = si->dst_reg;
>>>        __u8 skb_reg = si->src_reg;
>>> -    /* AX is needed because src_reg and dst_reg could be the same */
>>> -    __u8 tmp_reg = BPF_REG_AX;
>>> -
>>> -    *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>> -                  SKB_BF_MONO_TC_OFFSET);
>>> -    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>> -                SKB_MONO_DELIVERY_TIME_MASK, 2);
>>> -    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>> -    *insn++ = BPF_JMP_A(1);
>>> -    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>> -
>>> +    BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>>
>> Add these also:
>>
>>      BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>>      BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != BPF_SKB_CLOCK_MONOTONIC);
>>      BUILD_BUG_ON(SKB_CLOCK_TAI != BPF_SKB_CLOCK_TAI);
>>
> 
> Martin, The above suggestion of adding BUILD_BUG_ON always gives me a warning stating the following.
> 
> Some systems considers warning as error if compiler flags are enabled. I believe this requires your suggestion before i raise RFC v6 patchset to either keep the
> BUILD_BUG_ON or remove it completely.

cast it?

> 
> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9395:34: warning: comparison between ‘enum skb_tstamp_type’ and ‘enum <anonymous>’ [-Wenum-compare]
>   9395 |  BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>        |                                  ^~
> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:451:9: note: in definition of macro ‘__compiletime_assert’
>    451 |   if (!(condition))     \
>        |         ^~~~~~~~~
> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:471:2: note: in expansion of macro ‘_compiletime_assert’
>    471 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |  ^~~~~~~~~~~~~~~~~~~
> /local/mnt/workspace/kernel_master/linux-next/include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> /local/mnt/workspace/kernel_master/linux-next/include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>     50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>        |  ^~~~~~~~~~~~~~~~
> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9395:2: note: in expansion of macro ‘BUILD_BUG_ON’
>   9395 |  BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
>        |  ^~~~~~~~~~~~
> /local/mnt/workspace/kernel_master/linux-next/net/core/filter.c:9396:35: warning: comparison between ‘enum skb_tstamp_type’ and ‘enum <anonymous>’ [-Wenum-compare]
>   9396 |  BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != BPF_SKB_CLOCK_MONOTONIC);
>        |                                   ^~
> /local/mnt/workspace/kernel_master/linux-next/include/linux/compiler_types.h:451:9: note: in definition of macro ‘__compiletime_assert’
>    451 |   if (!(condition))     \
>        |         ^~~~~~~~~
> 
>           |                                      ^~
> 
> 
> 


