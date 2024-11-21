Return-Path: <bpf+bounces-45430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BA9D5676
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC6B282CFF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243D1D90BE;
	Thu, 21 Nov 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3PZmztI"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430161C9DC9
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233361; cv=none; b=t7Rh5SmADXEOH0L7u9AJ24ulaBri+IkUkcW5RfXenxQRYPK5cTUR0LKRZrBb1QYsKaICxxH/BPQFjaZ5vcYX+XMljs8BasFgRKTo5Cm0vmPiHYfnAsRfpquncgeEFEKUXF8bRAtdJWThncOTsCCd0a/JE8Myzi6D3tpmRkEiVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233361; c=relaxed/simple;
	bh=92B4Hjsqn8AMytofmY2y420WpgRZrJ9J9GxhG+UQ688=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIc/4jub7KWDCSieTtx5bUq2CqhSBVqCqWQrg3kUpnghdf6Er8u44Y/PhWypiBBaWBBaXOU/F2DbZSPQGN2ntPoZqU2jcTrPNshR7caapjTngZIy1UzQlX1RP1BSzTH3auv4LJspCwox5U9Xt4ZSm11C/btNKZrHVHcQzmD8/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3PZmztI; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14f3d0a2-04bd-4843-8ac3-51e4ca65bae2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732233356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIWyi37SiF76vM97yalqXgfo+AVSafmFww7OlNbRJo4=;
	b=R3PZmztIcd4OLGuXYt876dCXN7x7HsG1HjUOzpG/b8nWEH/RIUIrJrb/PtzuyHcu/XyXLj
	j0HfXg1KqlPUGVc9vLCw2G3oVYCbqQx95Qm4rrndfLG60wiVH5VdUG/LUmKqahBr7HXp9o
	SjMaYHJjygkGWnQ2F1s5/AZSSq/r3sE=
Date: Thu, 21 Nov 2024 15:55:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add bpf_get_cpu_time_counter kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241121000814.3821326-2-vadfed@meta.com>
 <20241121113202.GG24774@noisy.programming.kicks-ass.net>
 <482d32d5-2caa-4759-b3b1-765678ac42a2@linux.dev>
 <20241121153334.GN39245@noisy.programming.kicks-ass.net>
 <CAEf4BzZtph98_qR1CFpj5Fh_wVg=XaZQ75G44dS-oigLExUHSw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAEf4BzZtph98_qR1CFpj5Fh_wVg=XaZQ75G44dS-oigLExUHSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 21/11/2024 15:51, Andrii Nakryiko wrote:
> On Thu, Nov 21, 2024 at 7:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Nov 21, 2024 at 06:35:39AM -0800, Vadim Fedorenko wrote:
>>> On 21/11/2024 03:32, Peter Zijlstra wrote:
>>>> On Wed, Nov 20, 2024 at 04:08:11PM -0800, Vadim Fedorenko wrote:
>>>>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>>>>> it into rdtsc ordered call. Other architectures will get JIT
>>>>> implementation too if supported. The fallback is to
>>>>> __arch_get_hw_counter().
>>>>
>>>> Still not a single word as to *WHY* and what you're going to do with
>>>> those values.
>>>>
>>>> NAK
>>>
>>> Did you have a chance to read cover letter?
>>
>> Cover letter is disposable and not retained when applying patches, as
>> such I rarely read it.
> 
> It's not disposable for BPF trees. We preserve them as part of the
> merge commit for the patch set, e.g. [0]. Both bpf and netdev
> maintainers use a set of scripts to apply patches (pw-apply,
> specifically), that does all that automatically.

Yeah, was going to write the same...

> Vadim,
> 
> Please do another careful pass over commit messages and cover letter.
> I'd suggest moving the version history into cover letter (see other
> multi-version cover letter for an example). You can use an example
> from your BPF selftests as an intended use case (measuring the
> duration of some BPF piece of logic), and I'd also mention that this
> is useful to measure the duration of two related BPF events. E.g.,
> uprobe entry and exit, of kprobe entry/exit. kprobe.session and
> uprobe.session programs are especially well suited for that, as they
> allow to capture initial timestamp, store it in session cookie, then
> retrieve it in return probe and calculate the difference.

Sure, I'm on it already.

> 
> Please also update all the "cycles" references to "time counter",
> stuff like that.

Yeah, I've done it already in my local branch.

Thanks.

> 
> pw-bot: cr
> 
> 
>    [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?h=bpf-next-6.13&id=379d5ee624eda6a897d9e1f7f88c68ea482bd5fa
>    [1] https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/pw.git/



