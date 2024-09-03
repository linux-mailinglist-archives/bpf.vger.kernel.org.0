Return-Path: <bpf+bounces-38774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06093969F48
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC481C23FE5
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424658C06;
	Tue,  3 Sep 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cy4DtCHf"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A163D5;
	Tue,  3 Sep 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370970; cv=none; b=sMGfVS2zsgXSkk0m5pKiRF9mO7YDx5BK8vuuPON6M932humj6s0gLdaWnGViWhX9Uc/6mbv5f91dIpNfDGlXwSmndVeSlVl0v5Mc35aj9ppYH16Rxtg2NdHRGzSdxH7aj2gh3mqMvKBuWcwoh9v8Y86ZFOspFdCjdWMIz6I0f2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370970; c=relaxed/simple;
	bh=JB05xMLPsdUezJcX1yqsii5vEJZBS0NXDev2u07aXkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEsDc/VHe8Sev/4Qu81gTLD4EDkKL5BTgfQ6hMwZtN801V/PlLfwEnJEEQY+CrHNbWLWpir5QDgoz+0DJPY0Km+4nmUx6Dpg1nfTECvLhV2EB5ajJnYvsdNyIohSeFJJbKBCMtfjVliCDDSYO8wDD3upj7RNcVOIkJ6Pa2iY+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cy4DtCHf; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725370961;
	bh=JB05xMLPsdUezJcX1yqsii5vEJZBS0NXDev2u07aXkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cy4DtCHffGxggkIM+WxqhfVxvZgm+Ni2luIlMGyLX4sWER3/3FowlZcJk3A7SYw0F
	 JovJGuDm33nA+E7UPa3kXtQk6fX5j41HW8U6zOATVjNNUbm2+G4jQi7Y8lIbOK2jHY
	 5EF9X+YdNcuOMRP7+sKfm5ExwsIDjlp6+RcIi9ea/4s2/cZWsTzs705PVwuYX3D0xx
	 ZWFP53MLGHvTO7EKys2l153usCOuonXDPDEqT1CH6Nt6ob+d9VMyzZuI8agKLumA7A
	 4DxlPLs1rI3cN6xg7E0Y8RB4mZGVRsLMvqPKU/BZ2LPTNjGddjdONIYYMCprJeo9vx
	 Ml7Q3mYJc0PTA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wymyn0sGhz1JkZ;
	Tue,  3 Sep 2024 09:42:41 -0400 (EDT)
Message-ID: <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
Date: Tue, 3 Sep 2024 09:42:22 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson
 <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
 <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
 <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-02 14:46, Linus Torvalds wrote:
[...]
> IOW, that code should just have been something like this:
> 
>      #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)    \
>      static notrace void                                         \
>      __bpf_trace_##call(void *__data, proto)                     \
>      {                                                           \
>                                                                  \
>          if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                \
>                  might_fault();                                  \
>                  guard(preempt_notrace)();                       \
>                  CONCATENATE(bpf_trace_run, ...                  \
>                  return;                                         \
>          }                                                       \
>          CONCATENATE(bpf_trace_run, ...                          \
>      }
> 
> instead.

If we look at perf_trace_##call(), with the conditional guard, it looks
like the following. It is not clear to me that code duplication would
be acceptable here.

I agree with you that the conditional guard is perhaps not something we
want at this stage, but in this specific case perhaps we should go back
to goto and labels ?

One alternative is to add yet another level of macros to handle the
code duplication.

#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
static notrace void                                                     \
perf_trace_##call(void *__data, proto)                                  \
{                                                                       \
         struct trace_event_call *event_call = __data;                   \
         struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
         struct trace_event_raw_##call *entry;                           \
         struct pt_regs *__regs;                                         \
         u64 __count = 1;                                                \
         struct task_struct *__task = NULL;                              \
         struct hlist_head *head;                                        \
         int __entry_size;                                               \
         int __data_size;                                                \
         int rctx;                                                       \
                                                                         \
         DEFINE_INACTIVE_GUARD(preempt_notrace, trace_event_guard);      \
                                                                         \
         if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
                 might_fault();                                          \
                 activate_guard(preempt_notrace, trace_event_guard)();   \
         }                                                               \
                                                                         \
         __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                                                                         \
         head = this_cpu_ptr(event_call->perf_events);                   \
         if (!bpf_prog_array_valid(event_call) &&                        \
             __builtin_constant_p(!__task) && !__task &&                 \
             hlist_empty(head))                                          \
                 return;                                                 \
                                                                         \
         __entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
                              sizeof(u64));                              \
         __entry_size -= sizeof(u32);                                    \
                                                                         \
         entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);     \
         if (!entry)                                                     \
                 return;                                                 \
                                                                         \
         perf_fetch_caller_regs(__regs);                                 \
                                                                         \
         tstruct                                                         \
                                                                         \
         { assign; }                                                     \
                                                                         \
         perf_trace_run_bpf_submit(entry, __entry_size, rctx,            \
                                   event_call, __count, __regs,          \
                                   head, __task);                        \
}

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


