Return-Path: <bpf+bounces-35473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417893AC06
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AF01C22CB6
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD233998;
	Wed, 24 Jul 2024 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqtjKtaM"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100612421D
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796431; cv=none; b=WvyTn7nl0mZgl1dlGNvOOkxAbNpSrS/eBjs9fvSMDtpqLQ8OBDsLPLb4KXT+P/kpwA9BnB0R3KgQZYH0i6QtL0vISrFq6H08FCJShzT8Jh5pVhcMRXzmJL8THTB2jG7z0HpXSvUdLdbKmFTe9L+RBB0o9h+2P1XSoiTlRFokGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796431; c=relaxed/simple;
	bh=pK57vQIgn2Flg2saocBinokFP/k1uaBM3NJumDCzLec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWq2VqPNijcEAoNi83X0qvwjZIzNKgg6KTwSVKgAqJk5VWfGIOhDCuzvRs7gj1W5/0u7oGvdRU+N4ibl8Ih+1PEy0pXkTq0nYS1AitBJxv5UxArHwU/7h+l3kwY2ln14md/S/TcrRt8kYWhg7lwIWO14GFBe3yJH33e2wxXzhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqtjKtaM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d858120-d07f-4fd5-af1b-6243c1b7d6f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721796426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKiHKVl9/9SdIlGq9ZJqdTest7IXOTDtNO1p28XneMw=;
	b=NqtjKtaM6qVxAU3UWJTS93GG5PQDWiOZbLxEUtI0KBz9RDKzwnLlKiLLCdNUHu8nyptijX
	DiFKUrloCkVuTavBMBngIE0c1acUodL/v2fwGatlRj5G7Mp/V2sglTD68XpzlvxL57ycz7
	rQlPCiAJH+iIf8RnJKtkdIdlR1Bx+9A=
Date: Tue, 23 Jul 2024 21:46:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
 <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
 <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com>
 <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
 <CAEf4BzbtBDeVeFntNznFBSXMxZOgQj7v4-EzRVsNkEj0A-uxgg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbtBDeVeFntNznFBSXMxZOgQj7v4-EzRVsNkEj0A-uxgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/23/24 9:06 PM, Andrii Nakryiko wrote:
> On Tue, Jul 23, 2024 at 8:17 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Mon, Jul 22, 2024 at 8:27 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>>> We *need to support recursion* is my main point.
>>>> Not quite.
>>>> It's not a recursion. The stack collapsed/gone/wiped out before tail_call.
>>> Only of subprog(), not of handle_tp(). See all those "ENTRY - AFTER"
>>> messages. We do return to all the nested handle_tp() calls and
>>> continue just fine.
>>>
>>> I put the log into [0] for a bit easier visual inspection.
>>>
>>>    [0] https://gist.github.com/anakryiko/6ccdfc62188f8ad4991641fb637d954c
>> Argh. So the pathological prog can consume 512*33 of stack.
>> We have to reject it somehow in the verifier or tailor private stack
>> to support it. Then private stack will be a feature and a fix for this issue.
>> But then it would need to preallocate 512*33 per cpu per program.
>> Which is too much.
>> Maybe we can preallocate _aligned_ 512 or 1k per cpu per prog,
>> then adjust r9 before call or tail_call and if r9 is about to cross
>> alignment before tail_call fail the tail call (like tail call cnt was
>> over limit).
> This is close to what I proposed to Yonghong offline. One approach I
> had in mind was as follows. If we know that a BPF program can do a
> tail call, then allocate some larger private stack (1KB, 4KB, 8KB,
> don't know), compared what the BPF program itself would need. Then in
> bpf_tail_call() helper's inlining itself check whether R9 +
> <max_prog_stack_size> is larger than the private stack's size. And if
> yes, then don't do tail call (as if we reached max number of tail
> calls). Tail call interface allows for that.
>
> This way we don't slow down typical non-tail call cases and don't pay
> unnecessary memory price, but we still make tail call work just fine
> in most cases, except some pathological ones like my example. I think
> the expected situation for tail call is to replace main program with
> another main program, so the typical case will work perfectly fine.

Indeed, this is an approach we could use. Based on recursion 'cnt',
we could calculate the frame pointer properly based on original
allocated frame pointer. Currently, private stack only supports
tracing programs. It should be extremely rare for a tracing program
to self recurse with tail call. So we could allocate smaller amount
of memory e.g. 1KB or 2KB and add runtime checking against the private stack
size to prevent stack overflow.

>
>> Hopefully there are better ideas, since it's all quite messy.

