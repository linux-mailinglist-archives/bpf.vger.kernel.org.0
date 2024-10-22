Return-Path: <bpf+bounces-42810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79799AB585
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D014B2291D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93C1C7B73;
	Tue, 22 Oct 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dZLhVVx3"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07491C6F7A;
	Tue, 22 Oct 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619749; cv=none; b=CbPkM61Vlbkr96zVVve96QkMAwQx36RToJ3ZCJkxDK3rdeFoZDNnNJkzJ0AiJtEARmbK0hfNxg9xhrIDi+pQZsdIwsHKRoR6+5qAimg/SePlTZqp5ATM4AeJgBk8VjxS8YJTONgnT01d/j21GazqCbUeY6Gz+U54GOkl0UWroMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619749; c=relaxed/simple;
	bh=Vaf0w7i/nQ6+pn4pXvNq//bDCD4PZWv1QLzVeflMW1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6ZX6Q94+aPQvFZ6K/Srpmk7qUv9j9e0ABZILDz7c/CPg7E/JBTLBnMT46Bzc18Jkxi9nM77sNaIQjOLIpFqLynt4h6PhgdG3TBIRzrFoQDRBR1mSg0dBgHWTPyU4Y9bcGBCf/3GlXhaVK5xAA+MR9PCrCH2C1vkojENkcjuir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dZLhVVx3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729619745;
	bh=Vaf0w7i/nQ6+pn4pXvNq//bDCD4PZWv1QLzVeflMW1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dZLhVVx3IwTxuLXEoUv0axoYfG8RlbazapiWDPoN1Ll0NwOwg6u9XKFpobHj0cO3f
	 2eG0DbIW+vmG4aW2GIYYn4ngIDmSKqltZIMKvB/OAA+lNCKNf+3bjtJNxwPWMDhppS
	 4Xi5XQkwz9pbZiY2Ky/TwzfEAm+A9pAkShUpCCBFePJ0FlGM7VTrC68naKmpnvMKOE
	 mYN5p/NnJGftUlT7WNETbDw0ss0uOdpn1e9/Y+aR8/4GvZrrR1wSl1BK7g97Vs5153
	 W/BWyerfywavQ5a725izW4qtK6gP9YYXDi6s/+Cj1zFJIJBr1hhr0B5FHPWww3NPqK
	 Qp3POfi4jqJGw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XY0G91j46zS5v;
	Tue, 22 Oct 2024 13:55:45 -0400 (EDT)
Message-ID: <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
Date: Tue, 22 Oct 2024 13:54:01 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Jordan Rife <jrife@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Alexei Starovoitov <ast@kernel.org>
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-22 12:14, Jordan Rife wrote:
> I assume this patch isn't meant to fix the related issues with freeing
> BPF programs/links with call_rcu?

No, indeed. I notice that bpf_link_free() uses a prog->sleepable flag to
choose between:

                 if (sleepable)
                         call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
                 else
                         call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);

But the faultable syscall tracepoint series does not require syscall programs
to be sleepable. So some changes may be needed on the ebpf side there.

> 
> On the BPF side I think there needs to be some smarter handling of
> when to use call_rcu or call_rcu_tasks_trace to free links/programs
> based on whether or not the program type can be executed in this
> context. Right now call_rcu_tasks_trace is used if the program is
> sleepable, but that isn't necessarily the case here. Off the top of my
> head this would be BPF_PROG_TYPE_RAW_TRACEPOINT and
> BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, but may extend to
> BPF_PROG_TYPE_TRACEPOINT? I'll let some of the BPF folks chime in
> here, as I'm not entirely sure.

A big hammer solution would be to make all grace periods waited for after
a bpf tracepoint probe unregister chain call_rcu and call_rcu_tasks_trace.

Else, if we properly tag all programs attached to syscall tracepoints as
sleepable, then keeping the call_rcu_tasks_trace() only for those would
work.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


