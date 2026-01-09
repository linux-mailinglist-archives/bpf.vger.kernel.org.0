Return-Path: <bpf+bounces-78373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B2D0C0E0
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B69530963F9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04752E974D;
	Fri,  9 Jan 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vttmsl0D"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4F23EA9B
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986414; cv=none; b=t1sPHCOkB4Pdc4rec1TtMlRhcCYHprtVTKijeOXbeuSYHW1qoi59icMIG3eYr2RAXGi1p8SdpoGQF1ehA7kkv/u0Pc6jIACD1CGTxTSnE3iW3/9xiKqKCY9K0bwH6uB/v9qFz2nsHnVKekxgn0Y8x2cRgr88U1fUX9S0v2QOFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986414; c=relaxed/simple;
	bh=UA1W3ffSHy7mmLgxQmLPlqFxO0jlzVXsdLrfVgn9j0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMQ3oTk/8/SmLuPMUV3LXrwDdazfb/V4RUCejxyeFewOThKQjZ98UnCds6e7AeqpmwfA6+j6tlkP/mB2C+fge4D7BZVfJU5/ACRME2TeLP0+hK+zyzBkysixyd507Q/NePOuRZPv6dxj/Y2wXjIcniK2JhNDg9AaUYTItx7gOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vttmsl0D; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dcc3a509-d8fd-4f46-8051-683d7277fde7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767986400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA1W3ffSHy7mmLgxQmLPlqFxO0jlzVXsdLrfVgn9j0g=;
	b=Vttmsl0DV1JUxe2J1IX2yXZn0oMFTmNsr0ZW1XJKtM/WQGp/gwI+E52GE0zK5yP6JfadOM
	sw78Cdxe3/6bazMgiHftgF8t4uwBnxNmPRqjgnbQruZ+KbB9q9RTy5SHTkrQiLNTB1l4gF
	wklC42gZp+4Ln5jS2V7V6iCt5ZfdwF0=
Date: Fri, 9 Jan 2026 11:19:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/9/26 11:10 AM, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 6:45 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> On 2026-01-08 22:05, Steven Rostedt wrote:
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>> [...]
>>
>> I disagree with many elements of the proposed approach.
>>
>> On one end we have BPF wanting to hook on arbitrary tracepoints without
>> adding significant latency to PREEMPT RT kernels.
>>
>> One the other hand, we have high-speed tracers which execute very short
>> critical sections to serialize trace data into ring buffers.
>>
>> All of those users register to the tracepoint API.
>>
>> We also have to consider that migrate disable is *not* cheap at all
>> compared to preempt disable.
> Looks like your complaint comes from lack of engagement in kernel
> development.
> migrate_disable _was_ not cheap.
> Try to benchmark it now.
> It's inlined. It's a fraction of extra overhead on top of preempt_disable.
>
The following are related patches to inline migrate_disable():

35561bab768977c9e05f1f1a9bc00134c85f3e28 arch: Add the macro COMPILE_OFFSETS to all the asm-offsets.c
88a90315a99a9120cd471bf681515cc77cd7cdb8 rcu: Replace preempt.h with sched.h in include/linux/rcupdate.h
378b7708194fff77c9020392067329931c3fcc04 sched: Make migrate_{en,dis}able() inline


