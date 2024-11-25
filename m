Return-Path: <bpf+bounces-45572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A19D87C1
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6334C28C4D0
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D01B87F8;
	Mon, 25 Nov 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QLJxDarv"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BB1B218E;
	Mon, 25 Nov 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544305; cv=none; b=lGtNNbQ3ggM7RMjb75FoXWV4/cGfYEGnGas34UlT3RlsUEvwKEFx1SDtoZ52rYIqdVycQ+phmRPLVyBEXj5nSZDN/BJD4oWuF5SFjFCYXvtn5sxuIzqi/Xy8KdeEDWkGDvhd0fio2KVZY5hoOs9FDaAK6piN1cSI/BzxrLEii5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544305; c=relaxed/simple;
	bh=oRAL0Zv98MtIkGgjkjv6eLyNst+zyD4K6hO99OMP7t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfv6ee3+CWqXv4iExkXSptebZyok4asM85XoMunTUr6m5vAlkLygBA5yUbRmO+cszXibkRVsCZ8tIH4RBqxgYCh71lXQA7ylgyXDqwA/SWSM2rROphprhCOVzmPGjmVNtPKHJS27jUGrmWT7HGYHbCtKMsrjy89rJJlNQHXX2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QLJxDarv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732544300;
	bh=oRAL0Zv98MtIkGgjkjv6eLyNst+zyD4K6hO99OMP7t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QLJxDarvUN6WqgnGSb3BMGONX+Rhq2xnE1BgqDed9xYFTLTMUUj3YCS3jra5NcUjs
	 7SAAIK7HB6q0006SOmSCWiN+4JqjfadxQhCpQiaZ4yxiU1WZOuzcvuxv6aizK8hLFN
	 9PiVrIVqyO2XMmvGek4AjHdKPvBWU6bzhSfB9nuds0HzgC/sfRsU+dMvxxSwqqa4lu
	 jLZpe8+X+1zH8tDlgVguEJ9yC/gztgqkuBWs5Uthy1e+z5rp0TFcD7zyCF5HvfLBJ4
	 xA2Zt8ipOswhFgneUHKsaO1b1rnZYcTQ/gUjBLE8iziboT6ReTFYVMB7CVziNBVZlZ
	 n/isbM/oS/cQA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xxnqb6x4vzy2R;
	Mon, 25 Nov 2024 09:18:19 -0500 (EST)
Message-ID: <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
Date: Mon, 25 Nov 2024 09:18:18 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson
 <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
 linux-trace-kernel@vger.kernel.org
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-23 12:38, Linus Torvalds wrote:
> On Sat, 23 Nov 2024 at 07:31, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>   include/linux/tracepoint.h | 45 ++++++++++----------------------------
>>   1 file changed, 12 insertions(+), 33 deletions(-)
> 
> Thanks. This looks much more straightforward, and obviously is smaller too.
> 
> Side note: I realize I was the one suggesting "scoped_guard()", but
> looking at the patch I do think that just unnecessarily added another
> level of indentation. Since you already wrote the
> 
>      if (cond) {
>          ..
>      }
> 
> part as a block statement, there's no upside to the guard having its
> own scoped block, so instead of
> 
>      if (cond) { \
>          scoped_guard(preempt_notrace)           \
>              __DO_TRACE_CALL(name, TP_ARGS(args)); \
>      }
> 
> this might be simpler as just a plain "guard()" and one less indentation:
> 
>      if (cond) { \
>          guard(preempt_notrace);           \
>          __DO_TRACE_CALL(name, TP_ARGS(args)); \
>      }
> 
> but by now this is just an unimportant detail.
> 
> I think I suggested scoped_guard() mainly because that would then just
> make the "{ }" in the if-statement superfluous, but that's such a
> random reason that it *really* doesn't matter.

I tried the following alteration to the code, which triggers an
unexpected compiler warning on master, but not on v6.12. I suspect
this is something worth discussing:

         static inline void trace_##name(proto)                          \
         {                                                               \
                 if (static_branch_unlikely(&__tracepoint_##name.key)) { \
                         if (cond)                                       \
                                 scoped_guard(preempt_notrace)           \
                                         __DO_TRACE_CALL(name, TP_ARGS(args)); \
                 }                                                       \
                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
                         WARN_ONCE(!rcu_is_watching(),                   \
                                   "RCU not watching for tracepoint");   \
                 }                                                       \
         }

It triggers this warning with gcc version 12.2.0 (Debian 12.2.0-14):

In file included from ./include/trace/syscall.h:5,
                  from ./include/linux/syscalls.h:94,
                  from init/main.c:21:
./include/trace/events/tlb.h: In function ‘trace_tlb_flush’:
./include/linux/tracepoint.h:261:28: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wdangling-else]
   261 |                         if (cond)                                       \
       |                            ^
./include/linux/tracepoint.h:446:9: note: in expansion of macro ‘__DECLARE_TRACE’
   446 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
       |         ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:584:9: note: in expansion of macro ‘DECLARE_TRACE’
   584 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
       |         ^~~~~~~~~~~~~
./include/trace/events/tlb.h:38:1: note: in expansion of macro ‘TRACE_EVENT’
    38 | TRACE_EVENT(tlb_flush,
       | ^~~~~~~~~~~

I suspect this is caused by the "else" at the end of the __scoped_guard() macro:

#define __scoped_guard(_name, _label, args...)                          \
         for (CLASS(_name, scope)(args);                                 \
              __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
              ({ goto _label; }))                                        \
                 if (0) {                                                \
_label:                                                                 \
                         break;                                          \
                 } else

#define scoped_guard(_name, args...)    \
         __scoped_guard(_name, __UNIQUE_ID(label), args)

AFAIU this is a new warning introduced by

commit fcc22ac5baf ("cleanup: Adjust scoped_guard() macros to avoid potential warning")

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


