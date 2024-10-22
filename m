Return-Path: <bpf+bounces-42819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F699AB76A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D04BB22959
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73921CBE94;
	Tue, 22 Oct 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ndzwbot2"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AB1C9ED2;
	Tue, 22 Oct 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627598; cv=none; b=eZA5q+vNIMdqKQV/Lh0stccEu8bm9KtJwOTKtg+2shuPwNTEpyo0xX3hc6dBtC+v3TwgiVosKTJusDMpltUaGpBOGjgyiLzCy/2v6yBkov+SSMKGwSVt4L/HPL9dawUJ9GDE/PKnzKYS8xnPuscmN3rGYIjLQVwRE2oag5MP5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627598; c=relaxed/simple;
	bh=drK3eYYnJyoywUvF3r02TIDWaPZHQ8aA0CUG3R0HUiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG6ZhLlKlnzWz/svJ175lcpfJ+4KXBP6DvdEM7HySnD994j6oobVAaDhTNPg3kSuLkJTsmLV3BbzVBnV8Zjr21xSbxoG0qR7r/30qA3dm1duNn6BXd9PogqzunOT4MeuxRl2QUF7AUB8dGZHvJBfaF/OcTm5Pqg6QJPO2ZmS9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Ndzwbot2; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729627593;
	bh=drK3eYYnJyoywUvF3r02TIDWaPZHQ8aA0CUG3R0HUiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ndzwbot2E0Pi1n7eCyEi4HOE/bJBXQcpmVezyCZbLmzpcuTwc7Bxp4bPOoTucS/V6
	 0OqvJVWdHQfmqQWAZQOMbS8F9RqBlGpAn7ut3uCIG0i5aprX742NZ8htLcOtrmdwZf
	 48Myj/g9O/Ip95bTB7GN6fmGN19H9xUWpM1wnWLlumxdr3icfA3b/BGp/K83oQDcU0
	 bhbIxQ11L4QDdZTYv8/64l9XZfmJavxXDBqU5qNELXaUg1ylRtB6hQhAfvxZamqG3U
	 w7L2D1LXaqEqhLF2eFaeXmh4imlPvEn/gEpMg9gIqYWsThhvXqB3+DU+XDYDD8DRcj
	 Gxni1Nj1Y9Cag==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XY3951TMQzSQX;
	Tue, 22 Oct 2024 16:06:33 -0400 (EDT)
Message-ID: <1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com>
Date: Tue, 22 Oct 2024 16:04:49 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jordan Rife <jrife@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
 <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
 <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-22 15:53, Andrii Nakryiko wrote:
> On Tue, Oct 22, 2024 at 10:55 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-10-22 12:14, Jordan Rife wrote:
>>> I assume this patch isn't meant to fix the related issues with freeing
>>> BPF programs/links with call_rcu?
>>
>> No, indeed. I notice that bpf_link_free() uses a prog->sleepable flag to
>> choose between:
>>
>>                   if (sleepable)
>>                           call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
>>                   else
>>                           call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
>>
>> But the faultable syscall tracepoint series does not require syscall programs
>> to be sleepable. So some changes may be needed on the ebpf side there.
> 
> Your fix now adds a chain of call_rcu -> call_rcu_tasks_trace ->
> kfree, which should work regardless of sleepable/non-sleepable. For
> the BPF-side, yes, we do different things depending on prog->sleepable
> (adding extra call_rcu_tasks_trace for sleepable, while still keeping
> call_rcu in the chain), so the BPF side should be good, I think.
> 
>>
>>>
>>> On the BPF side I think there needs to be some smarter handling of
>>> when to use call_rcu or call_rcu_tasks_trace to free links/programs
>>> based on whether or not the program type can be executed in this
>>> context. Right now call_rcu_tasks_trace is used if the program is
>>> sleepable, but that isn't necessarily the case here. Off the top of my
>>> head this would be BPF_PROG_TYPE_RAW_TRACEPOINT and
>>> BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, but may extend to
>>> BPF_PROG_TYPE_TRACEPOINT? I'll let some of the BPF folks chime in
>>> here, as I'm not entirely sure.
>>
> 
>  From the BPF standpoint, as of right now, neither of RAW_TRACEPOINT or
> TRACEPOINT programs are sleepable. So a single RCU grace period is
> fine. But even if they were (and we'll allow that later on), we handle
> sleepable programs with the same call_rcu_tasks_trace -> call_rcu
> chain.

Good points, in this commit:

commit 4aadde89d8 ("tracing/bpf: disable preemption in syscall probe")
I took care to disable preemption around use of the bpf program attached
to a syscall tracepoint, which makes this change a no-op from the
tracers' perspective.

It's only when you'll decide to remove this preempt-off and allow
syscall tracepoints to sleep in bpf that you'll need to tweak that.

> 
> That's just to say that I don't think that we need any BPF-specific
> fix beyond what Mathieu is doing in this patch, so:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

Mathieu

> 
> 
>> A big hammer solution would be to make all grace periods waited for after
>> a bpf tracepoint probe unregister chain call_rcu and call_rcu_tasks_trace.
>>
>> Else, if we properly tag all programs attached to syscall tracepoints as
>> sleepable, then keeping the call_rcu_tasks_trace() only for those would
>> work.
>>
>> Thanks,
>>
>> Mathieu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


