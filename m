Return-Path: <bpf+bounces-38276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5C962980
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D381C23BBF
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857716C859;
	Wed, 28 Aug 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PZQOVl3n"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D31C69C;
	Wed, 28 Aug 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853533; cv=none; b=ZlLnQQcOV4YL01elk/MPd2yEsWeqYWgn78+X9XkrfzrMmqNZrhGenMQCHt9LTgYQ/srbzZvqwudiNOMwGgxGKnrGW6dJgLuACwseO6BahCuYr9vu4yNxhsUkPJF3is9ZiscIwJd7f9kb4j7BJdvADoQcLyEjSQwsGg9gEC5wkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853533; c=relaxed/simple;
	bh=D/QwnR7xfk7AmyRNSdHLddBpqIZ6b6ckbSM2sk7O7lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqpLd3lbyKZ0y8iAUJOyFhCZcc4pZKHuETmD8YFr56rzWMmTvs6IEfjNLlI63dFp/Yzwfw19VgD8409ZeiTIs26PxDQ8QygxjlPVS0RFPYnL8L/v96FlwosNcVu5NikF8fZtlrvRDDjpljhv/0j/y7vUHs8+Sn/qOa0ufxXu95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PZQOVl3n; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724853529;
	bh=D/QwnR7xfk7AmyRNSdHLddBpqIZ6b6ckbSM2sk7O7lE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZQOVl3nDbtcbNtTV2me4c4cb3fCC/PvdCi+Cpvb9ExqVzKiWG/1ULbjpS/okLNef
	 71op6CsPEgj+6tmzUZa3bjIWjyNyb11wxy7O2eH/9YeOb9ACpDmYLNx24IdUKWS9LA
	 +1PcU9wQfRScHoB7MF3eznr7nSN40JWbMXUXwg+Q+0Qfk1ct44hB9kEDeHyHGbdf+6
	 DFR+UwCi6dUihWU5LUAK+BD3AOnrdkhV8wrGC4nzORJLurACiAsD9Sd/FKfMhQfYrv
	 0LLrm2H1zlADDK5vy/ERFB4gsKQ7wbPGV0H2y8Ppor3OWVrnKx3HA5cvI3c74DYUGc
	 ddG2/23u6Humg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv5c94Q3hz1JcN;
	Wed, 28 Aug 2024 09:58:49 -0400 (EDT)
Message-ID: <c262fb90-2a3f-49a2-b89d-467f493088cb@efficios.com>
Date: Wed, 28 Aug 2024 09:58:25 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
 <20240627152340.82413-4-mathieu.desnoyers@efficios.com>
 <20240819190014.31ab74d8@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240819190014.31ab74d8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-20 01:00, Steven Rostedt wrote:
> On Thu, 27 Jun 2024 11:23:35 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> To cover scenarios where the scope of the guard differs from the scope
>> of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().
>>
>> Here is an example use for a conditionally activated guard variable:
>>
>> void func(bool a)
>> {
>> 	DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);
>>
>> 	[...]
>> 	if (a) {
>> 		might_sleep();
>> 		activate_guard(preempt_notrace, myguard)();
>> 	}
>> 	[ protected code ]
>> }
>>
> 
> Hi Mathieu,
> 
> The three cleanup patches fail to apply (I believe one has already been
> fixed by Ingo too). Could you have the clean up patches be a separate
> series that is likely to get in, especially since it's more of a moving
> target.

Then it would make sense to split this into two series: one for the
guard stuff, and one for tracing which depends on the first one.

I'll do that.

Mathieu

> 
> Thanks,
> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


