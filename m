Return-Path: <bpf+bounces-58709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35867AC02A6
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 04:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69849E4CF6
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123A4086A;
	Thu, 22 May 2025 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukfVB9y0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975614A82
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747882442; cv=none; b=gjnleqr8sajpogAfUyWNEtyl7PvFrVHJXAV1kPB8NeON5km+r9Q1YIfmJCC2zYAaB6ch3ySnfWlyy4FvltsB8VI6Yltb41URSGNyL1i/kXUeRbQH+HdoxsrTmXTPghtSQ+l97gp2XPLzYJdXhD95F2azsYeMu56edyk+d9WX0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747882442; c=relaxed/simple;
	bh=fVBut4rSUuwC0y97IQDbnoY68VR8mygrpY2TjF0ZL98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpDLKIZiRBFZfYkchIPEOFmIsPfsAx1CUlbQxW1t7ihGsn/j5kM0mdetAlPlwpxUU0pBOhT0h2PdC8FJB9PCQhz//aSUtUzQWUxjpIo/ndpM9VQnMwEvJap75VCzlOBCNatE4dl4TOSmrmpPdEsMWGB+UF67CqF7dLwyQg7tAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukfVB9y0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93df65a6-e8b6-4e75-8918-f6ae0b12779a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747882437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPE3GLVjuaMooql902Vz4dJkMFBqprM34CQ+CXoy3CQ=;
	b=ukfVB9y0qijRWJan+aI6qMfjjxIc+FWt/AmuL1Sllo3BBMOZf0Vlotd8gSZ0GVMA1QQaxk
	VMVhdgSkYu/4GzS4Fzu8FweIcY9SoKQWy1TF88umHIt+Xkjbc8H1b5ogAmwaGMTn94FP6b
	JMAulykVsdmb8xBwhMNnx+bwKTC5xWs=
Date: Wed, 21 May 2025 19:53:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
 <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
 <CAEf4Bzbx6xHc2LMCWpY_yQExgjauo0UaDmF4rDuFjefNvOhqRg@mail.gmail.com>
 <m2jz69bmui.fsf@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <m2jz69bmui.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/21/25 3:49 PM, Eduard Zingerman wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>> On Wed, May 21, 2025 at 1:35 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>
>>>
>>> On 5/21/25 11:55 AM, Eduard Zingerman wrote:
>>>> [...]
>>>>
>>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>>> index 78c97e12ea4e..e73a910e4ece 100644
>>>>> --- a/include/linux/bpf_verifier.h
>>>>> +++ b/include/linux/bpf_verifier.h
>>>>> @@ -357,6 +357,10 @@ enum {
>>>>>        INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>>>>>          INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
>>>>> +
>>>>> +    INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
>>>>> +    INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
>>>> INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
>>>> and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
>>>> to track these flags instead. So, can be one less flag/bit.
>>> You are correct, we could have BIT(9) for both INSN_F_STACK_ACCESS and INSN_F_DST_REG_STACK,
>>> and BIT(10) for INSN_F_SRC_REG_STACK. But it makes code a little bit
>>> complicated. I am okay with this if Andrii also thinks it is
>>> worthwhile to do this.
>> I originally wanted to replace INSN_F_STACK_ACCESS with either
>> INSN_F_DST_REG_STACK or INSN_F_SRC_REG_STACK depending on STX/LDX. But
>> then I realized that INSN_F_STACK_ACCESS implies the use of that spi
>> mask, while xxx_REG_STACK doesn't. So it might be a bit simpler if we
>> keep them distinct, and for LDX/STX we'll set either just
>> INSN_F_STACK_ACCESS or INSN_F_STACK_ACCESS|INSN_F_xxx_REG_STACK
>> (whichever makes most sense).
>>
>> We have enough bits, so I'd probably use two new bits and keep the
>> existing STACK_ACCESS one as is. Unless Eduard thinks that this setup
>> is actually more confusing?
> Idk, I don't see much difference between these flags for LDX/STX or JMP.
> In both cases it's a signal PTR_TO_STACK on the left / PTR_TO_STACK on
> the right. So, having two ways to express the same thing seems a bit
> confusing to me.
>
> Defer to your best judgement.

Thanks for all discusions. I would like to use two new bits for now.


