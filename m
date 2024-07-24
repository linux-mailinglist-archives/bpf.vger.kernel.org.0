Return-Path: <bpf+bounces-35471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2A93ABF4
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A951F2383A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCF22EF0;
	Wed, 24 Jul 2024 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLP4a3eL"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F10EC0
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721795559; cv=none; b=IVcLz+9Tw7ZaD7J3BwfnfJnhxWvd0sOGytKix66lRYK7faXogKwC7LQcS+gUmnyDhl7LvgTnkOTLlJf7WuoNQEYelgJP4rf0wVbpjYsyrqnfECJX+p1YDYJ6BGhRUMKKt6X47uRN++6vHoJkcYJf7kWkuSUbR1I6rp1ijfMmJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721795559; c=relaxed/simple;
	bh=R/KVyoermDGSGSKUKntdsqPrvij/P7c5FMw4tLrNhyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9IbZ+vW5SbF8njeT+8ZFO6THho2bbPTeExQcXFm2yQrjCIIGMH7+qtWAmKQJ3KRK8dBHjlq4fR0SVMU0+1HgBivZofLtBW+Hk43DUwp4MzhppYaLMTAQ5nMa3NO66zNqpism/Go55dXkCEWR7SEwCgRNap1HhSWn7Q7B8tLqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLP4a3eL; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78edbafd-ecca-4ed6-97d5-a557b4b2bcf4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721795554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL48kMPLC5r66MWP7DXgdTseXF+4OhkHgdWp3BB07q0=;
	b=LLP4a3eLmh07kWjEH7eHeVLT9xO5ep56EEp+OarS2zbTKhkWc8DBioysjw3qh1R/UlH/Sb
	opWyenDs1rmCJLpnTcjHaLLGiv+qs1dxKFrR1r8Nh0JL80/HKaEoHM+dfnI/cJ7rEPY0Ur
	49tBxghWAFnwZZgtqEMvgcA3Mxtnrp8=
Date: Tue, 23 Jul 2024 21:32:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
 <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
 <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com>
 <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/23/24 8:17 PM, Alexei Starovoitov wrote:
> On Mon, Jul 22, 2024 at 8:27 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>>> We *need to support recursion* is my main point.
>>> Not quite.
>>> It's not a recursion. The stack collapsed/gone/wiped out before tail_call.
>> Only of subprog(), not of handle_tp(). See all those "ENTRY - AFTER"
>> messages. We do return to all the nested handle_tp() calls and
>> continue just fine.
>>
>> I put the log into [0] for a bit easier visual inspection.
>>
>>    [0] https://gist.github.com/anakryiko/6ccdfc62188f8ad4991641fb637d954c
> Argh. So the pathological prog can consume 512*33 of stack.

We have a check in verifier like below:

         if (idx && subprog[idx].has_tail_call && depth >= 256) {
                 verbose(env,
                         "tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
                         depth);
                 return -EACCES;
         }

So the maximum stack size could be around 256 * 33 which is a little bit more than 8KB.

> We have to reject it somehow in the verifier or tailor private stack
> to support it. Then private stack will be a feature and a fix for this issue.
> But then it would need to preallocate 512*33 per cpu per program.
> Which is too much.
> Maybe we can preallocate _aligned_ 512 or 1k per cpu per prog,
> then adjust r9 before call or tail_call and if r9 is about to cross
> alignment before tail_call fail the tail call (like tail call cnt was
> over limit).
> Hopefully there are better ideas, since it's all quite messy.

