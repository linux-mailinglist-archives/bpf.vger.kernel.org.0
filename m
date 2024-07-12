Return-Path: <bpf+bounces-34684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD060930133
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415F5B22C2D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739293BBE3;
	Fri, 12 Jul 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gx7VB3Od"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CA20DC5
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815059; cv=none; b=IdGf6gdNdz+fYdiwXhzw8BHQ/zwrHHFokJf1i1cNKt12gVlb0tBvbd/4VZturEiqzBvVmgnMNby+J4qms5n78HrisAZXY5a9J+h+pEUV6GF8q6fkebJscfpI+hUJHbo3uMJF3ED3XAHtxoFaNm8aYpVq04kymWBWb9DFKZcc5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815059; c=relaxed/simple;
	bh=owdFW7jw2+WnhAtd9IP+MMnIylaI2pZ7Dj8v02qqJH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1fm/jSMVdwaYq+3N2Gc9yBxx3MHbCwlbYK/Ry5JN7MiCn/wrtpcmzSEgO81y/J0DMgT9jludO9tqjTScKz9o8EewM3NIgYRptZwDztvL038wQPUZ3f+dsNsTt3rBg3ql2KxdkhhywIiJX1YWc0vyYgeLah6V8Bj5AJbIw8OFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gx7VB3Od; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720815054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFcfz7PAyt2irINgfSYAHSUVAwd7Y5qkH5duYS/N8u8=;
	b=gx7VB3OdrDM7R0OoLIBOu3GIjqv3/AG61q7scZFU6VklX062ddOLSGpZ25otvdHqO0aaqM
	ymAv52q71ZzWm6wURRcoBMG+0rFID1OZ2j/CjgSi1/eu+7pi9RnGBIJJlahiBhabra2oZU
	RoShKQwJjWZWr1uxZkMp+3KP28vr2xM=
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <d310580d-6121-4fa1-8654-e9151acc8fd5@linux.dev>
Date: Fri, 12 Jul 2024 13:10:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240710042915.1211933-1-yonghong.song@linux.dev>
 <de03d550a466ef98d4adec4778cdfd12bb247ac3.camel@gmail.com>
 <d0040ec5-608d-4fc0-903d-0c5e10dfdedc@linux.dev>
 <CAADnVQK-=4UY5W+91MUbUgjb7h3QDw2j6FJ88neh5N4hKjOmKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK-=4UY5W+91MUbUgjb7h3QDw2j6FJ88neh5N4hKjOmKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 11:30 AM, Alexei Starovoitov wrote:
> On Thu, Jul 11, 2024 at 10:07 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>     Here we would like to handle a special case after sign extending load,
>>>     when upper bits for a 64-bit range are all 1s or all 0s.
>>>
>>>     Upper bits are all 1s when register is in a rage:
>>>       [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
>>>     Upper bits are all 0s when register is in a range:
>>>       [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
>>>     Together this forms are continuous range:
>>>       [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
>>>
>>>     Now, suppose that register range is in fact tighter:
>>>       [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
>>>     Also suppose that it's 32-bit range is positive,
>>>     meaning that lower 32-bits of the full 64-bit register
>>>     are in the range:
>>>       [0x0000_0000, 0x7fff_ffff] (W)
>>>
>>>     It so happens, that any value in a range:
>>>       [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
>>>     is smaller than a lowest bound of the range (R):
>>>        0xffff_ffff_8000_0000
>>>     which means that upper bits of the full 64-bit register
>>>     can't be all 1s, when lower bits are in range (W).
>>>
>>>     Note that:
>>>     - 0xffff_ffff_8000_0000 == (s64)S32_MIN
>>>     - 0x0000_0000_ffff_ffff == (s64)S32_MAX
>>>     These relations are used in the conditions below.
>> Sounds good. I will add some comments like the above in v2.
> I would add Ed's explanation verbatim as a comment to verifier.c
>
>>>> +    if (reg->s32_min_value >= 0) {
>>>> +            if ((reg->smin_value == S32_MIN && reg->smax_value <= S32_MAX) ||
>>>> +                (reg->smin_value == S16_MIN && reg->smax_value <= S16_MAX) ||
>>>> +                (reg->smin_value == S8_MIN && reg->smax_value <= S8_MAX)) {
>>> The explanation above also lands a question, would it be correct to
>>> replace the checks above by a single one?
>>>
>>>     reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX
>> You are correct, the range check can be better. The following is the related
>> description in the commit message:
>>
>>> This patch fixed the issue by adding additional register deduction after 32-bit compare
>>> insn such that if the signed 32-bit register range is non-negative and 64-bit smin is
>>> {S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
>>> Here, we check smin with {S32/S16/S8}_MIN since this is the most common result related to
>>> signed extension load.
>> The corrent code simply represents the most common pattern.
>> Since you mention this, I will resive it as below in v2:
>>      reg->smin_value >= S32_MIN && reg->smin_value < 0 && reg->smax_value <= S32_MAX
> Why add smin_value < 0 check ?
>
> I'd think
> if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN &&
>      reg->smax_value <= S32_MAX)
>
> is enough?

This is enough and correct. As you mentioned below, if smin_value >= 0 it is just
a redundant work but no hurt.

I will do as you suggested.

>
> If smin_value is >=0 it's fine to reassign it with s32_min_value
> which is positive as well.

