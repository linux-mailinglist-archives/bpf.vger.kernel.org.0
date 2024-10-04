Return-Path: <bpf+bounces-40950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BED9906E1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8ED1C22158
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397502194A1;
	Fri,  4 Oct 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U2zvrrlm"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344A2178EE;
	Fri,  4 Oct 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053592; cv=none; b=r6WpMMOwyLjCMoCO/IRzosHytQPmufLu4CsM1LYBCLe6I2Hd6jKfeMJ7z6iOMcC5mFcWOIyLTXhxA5DUQWyZWCZ6MA1KjEhCG/iMMhxilRHq6igmiR6jAk2DeuW/1MhNaNm+so3upbO9NnDosZvLp2CSi9nwi0jUpWlviUecg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053592; c=relaxed/simple;
	bh=/0BTNw8kWV3H4WxLHUQFLCS5qRWe3+5tF8qYgCHvpDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBiFGEtpBf3i3WqEf7R9hGyBVARUPhkheQtSV5dhLnirxbQOjeRecx/cD6bn/jGEtq6XwF7hereuxuOYbfZgZzKd8P2Di5dZlGBi//fT4iaYnnCR5+Li1Qpb1wfrN9I5OKIdpN+JqZ6YImwkU8zbk+Vbp/mXEqLccLiOvH5+Xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=U2zvrrlm; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728053590;
	bh=/0BTNw8kWV3H4WxLHUQFLCS5qRWe3+5tF8qYgCHvpDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U2zvrrlm23NrOcN17I0VuFfw636MDAM7f3b4UBAnSSgUuzjBcK8M9puIxOcAC1G4C
	 vc1xfGRtproDYpvov9fWMVpdFouo9dPs6BLllEEFX0vDKqDIa6nn/HFWiSngsjbX3Q
	 +UH9b5xlofmQ6AMnZN8LMCzBMnRFweJ4xH+OCotF7uEXjPeDhHcU4ppuDxA/ppoL5n
	 dHc4jPt4GlZd9XGUMvMOMIW+cOMBbrXQVqqGwSSJSGLq/jRA08ELj7ge2dY2pZFndI
	 sMbGoNZGKTRLl64bv6+Lio0qV1QxcQEE/VBCH4WtMRwnzJWbicfYU3m47Hq/98W9e9
	 X+g7oPNogDFLg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKs3n6FmWzLRh;
	Fri,  4 Oct 2024 10:53:09 -0400 (EDT)
Message-ID: <4f1046e7-7b62-4db3-93d4-815dc8c27185@efficios.com>
Date: Fri, 4 Oct 2024 10:51:09 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
 <20241003182304.2b04b74a@gandalf.local.home>
 <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
 <20241003210403.71d4aa67@gandalf.local.home>
 <90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
 <20241004092619.0be53f90@gandalf.local.home>
 <e547819a-7993-4c80-b358-6719ca420cf8@efficios.com>
 <20241004105211.13ea45da@gandalf.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241004105211.13ea45da@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 16:52, Steven Rostedt wrote:
> On Fri, 4 Oct 2024 10:19:36 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> The eBPF people want to leverage this. When I last discussed this with
>> eBPF maintainers, they were open to adapt eBPF after this infrastructure
>> series is merged. Based on this eBPF attempt from 2022:
>>
>> https://lore.kernel.org/lkml/c323bce9-a04e-b1c3-580a-783fde259d60@fb.com/
> 
> Sorry, I wasn't part of that discussion.
> 
>>
>> The sframe code is just getting in shape (2024), but is far from being ready.
>>
>> Everyone appears to be waiting for this infrastructure work to go in
>> before they can build on top. Once this infrastructure is available,
>> multiple groups can start working on introducing use of this into their
>> own code in parallel.
>>
>> Four years into this effort, and this is the first time we're told we need
>> to adapt in-tree tracers to handle the page faults before this can go in.
>>
>> Could you please stop moving the goal posts ?
> 
> I don't think I'm moving the goal posts. I was mentioning to show an
> in-tree user. If BPF wants this, I'm all for it. The only thing I saw was a
> generalization in the cover letter about perf, bpf and ftrace using
> faultible tracepoints. I just wanted to see a path for that happening.

AFAIU eBPF folks are very eager to start making use of this, so we won't
have to wait long.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


