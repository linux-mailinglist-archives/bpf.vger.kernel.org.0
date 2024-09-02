Return-Path: <bpf+bounces-38728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60D968D23
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C371F22CEE
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BE1C62C5;
	Mon,  2 Sep 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UfPtcApD"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE219F127;
	Mon,  2 Sep 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300889; cv=none; b=ZkiiI5lq37rtem5jJHvtRNzTWXmc2Uj0kW9qwTzHaG/6TFp5t3KSwNsErndHPDNrMhqzPltL5gSTyPx9JIFctiNHLq3eSMDer0BTF7OL9ATUndrX0D8UASASCHpZmU9oLXW5OfL4l+98dwpM6BOu3Firx38XfKjD2RVIbTGMFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300889; c=relaxed/simple;
	bh=8uyHUZeOmd4UOmgEXNT5ZG8aChZN4UjqzNfyOYiOS6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7PGqrkFltraTTzHoY/6k2eRrxTuXeZ91TDjdXkMBciejmR2Wtxr1eimRnsjB/rFse0dVLPJcBSl42hnI8NpzAJBWrF+KMRpH1jB1G12+RZAIb1NHrfvEBX5Naz42HcfsuOfcSG7SPgdYDEmw/SjX6PCSW3VTRcWaYIEIwZX5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UfPtcApD; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725300886;
	bh=8uyHUZeOmd4UOmgEXNT5ZG8aChZN4UjqzNfyOYiOS6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UfPtcApDDzyzOFJavT2qsGtbCmG42ir2h5al77oQtSfLAM+QGtzr/aFRAuLAxeVWY
	 quIB/5Y/9dEsEvkbeSVRV1VyD604mN30ljleddyJ6s8Dma7x9He+kp/uVl0jrDvfKV
	 4vawSjoNwYVGVxt5F4Xe6RTSfZ2/MMFf+p7s9B3b58L7KQGWmzzPm0rO/3SEkwyzN0
	 WMoNpcPnN8JbWDaHffEW1AReHiMYpHMqbzG4G8ix0BQRGKpuSAdhZDYE6Ifytzwwz+
	 yWEdozJ92cIyVBF6BsEXJEtNpuN0wnLGx7OhLN5W2Ohga/ahOFoma8BJqi8HSq57ON
	 MeEqxLUtPkyOw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WyH3B16xRz1JpH;
	Mon,  2 Sep 2024 14:14:46 -0400 (EDT)
Message-ID: <025ea126-f6db-4988-b500-5fbee0a65a3e@efficios.com>
Date: Mon, 2 Sep 2024 14:14:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
 <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-02 14:10, Linus Torvalds wrote:
> On Mon, 2 Sept 2024 at 08:43, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> and Linus took objection to similar patterns. But perhaps my naming
>> wasn't right.
> 
> Well, more of a "this stuff is new, let's start very limited and very clear".
> 
> I'm not loving the inactive guard, but I did try to think of a better
> model for it, and I can't.  I absolutely hate the *example*, though:
> 
>    void func(bool a)
>    {
>          DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);
> 
>          [...]
>          if (a) {
>                  might_sleep();
>                  activate_guard(preempt_notrace, myguard)();
>          }
>          [ protected code ]

Fair. I should have written something more like

   [ conditionally protected code ]

>    }
> 
> because that "protected code" obviously is *NOT* protected code. It's
> conditionally protected only in one situation.
> 
> Honestly, I still think the guard macros are new enough that we should
> strive to avoid them in complicated cases like this. And this *is*
> complicated. It *looks* simple, but when even the example that was
> given was pure and utter garbage, it's clearly not *actually* simple.
> 
> Once some code is sometimes protected, and sometimes isn't, and you
> have magic compiler stuff that *hides* it, I'm not sure we should use
> the magic compiler stuff.

I've tried my best to come up with a scheme which would be cleaner
than the "guard_if()" proposed by Peter, because I really hate it.

I'm perfectly fine going back to goto/labels for that function if we
cannot agree on a clean way to express what is needed there.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


