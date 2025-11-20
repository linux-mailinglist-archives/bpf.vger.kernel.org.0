Return-Path: <bpf+bounces-75124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2744C71C05
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D175D4E2EC2
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060C266EFC;
	Thu, 20 Nov 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dtnLOmxS"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7627212B2F;
	Thu, 20 Nov 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604449; cv=none; b=J1ZrBsZfBVP8Hon8UtQJAGWr5EfnZKGzSA7u2yhRhVypHja2bDbLp8piQzg2aI+K4uQUhVJg+4pMxmYGRmIC5lYf0r8ics3X0DUtzxOBKSTlls07CmBFUmLtgISuasQyC5OQxAs0ENTKgLFm4YDeCTU0b7j/YUsEDsvIq+Il3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604449; c=relaxed/simple;
	bh=/ftLSrdr8eAetRBLD8rAAX188EzfR+1NEmpRDh80vuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4hWdbeFp8LoWP/74XPKVABauEgV8jVnPMqz+i1uOLG34N55uOzC1qEc3fY0W5yXKLuyt8FzjMIeA4PY3JYZf+qbwK8uPy9FwX/qSveyVJ4wTaUipPXio7pcBHi5fagqaSsb8EUCMajEH9U3exT1KduVZ7rWOWn6FyVfFcNaeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dtnLOmxS; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3c8daef-5267-4dda-9009-209a94224374@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763604445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsNeURvdWU5NooTIGD7U4RWyVYbCK1aZ9kuId3BP1E0=;
	b=dtnLOmxS23PaM1hVBEMFOCcVoTpn7n8slQLS9oGk3vTbiUk/YGMyuOrbmMlLzYJ2vZt0EZ
	2mDmz3KtWaysXizll11Cwey93q3l94kVOLrzSxmxyYA9on0RYIslCK7EuC0jvNTy4CQ/yS
	nufPYt0Dc89tfqE1AoERn3eBOCpo7IY=
Date: Thu, 20 Nov 2025 10:07:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>,
 Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
 <8606158.T7Z3S40VBb@7950hx> <97c8e49c-ca27-40ec-8ff6-18b1b9061240@linux.dev>
 <5f4d0bf9-9c74-44ce-8f29-c43fa5e8810a@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5f4d0bf9-9c74-44ce-8f29-c43fa5e8810a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 19/11/25 20:36, Xu Kuohai wrote:
> On 11/19/2025 10:55 AM, Leon Hwang wrote:
>>
>>
>> On 19/11/25 10:47, Menglong Dong wrote:
>>> On 2025/11/19 08:28, Alexei Starovoitov wrote:
>>>> On Tue, Nov 18, 2025 at 4:36 AM Menglong Dong
>>>> <menglong8.dong@gmail.com> wrote:
>>>>>
>>>>> As we can see above, the performance of fexit increase from
>>>>> 80.544M/s to
>>>>> 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.
>>>>
>>>> Nice! Now we're talking.
>>>>
>>>> I think arm64 CPUs have a similar RSB-like return address predictor.
>>>> Do we need to do something similar there?
>>>> The question is not targeted to you, Menglong,
>>>> just wondering.
>>>
>>> I did some research before, and I find that most arch
>>> have such RSB-like stuff. I'll have a look at the loongarch
>>> later(maybe after the LPC, as I'm forcing on the English practice),
>>> and Leon is following the arm64.
>>
>> Yep, happy to take this on.
>>
>> I'm reviewing the arm64 JIT code now and will experiment with possible
>> approaches to handle this as well.
>>
> 
> Unfortunately, the arm64 trampoline uses a tricky approach to bypass BTI
> by using ret instruction to invoke the patched function. This conflicts
> with the current approach, and seems there is no straightforward solution.
> 
Hi Kuohai,

Thanks for the explanation.

Do you recall the original reason for using a ret instruction to bypass
BTI in the arm64 trampoline? I'm trying to understand whether that
constraint is fundamental or historical.

I'm wondering if we could structure the control flow like this:

foo "bl" bar -> bar:
  bar "br" trampoline -> trampoline:
    trampoline "bl" -> bar func body:
      bar func body "ret" -> trampoline
    trampoline "ret" -> foo

This would introduce two "bl"s and two "ret"s, keeping the RAS balanced
in a way similar to the x86 approach.

With this structure, we could also shrink the frame layout:

	 * SP + retaddr_off [ self ip           ]
	 *                  [ FP                ]

And then store the "self" return address elsewhere on the stack.

Do you think something along these lines could work?

Thanks,
Leon

