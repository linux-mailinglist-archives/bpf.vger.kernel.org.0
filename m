Return-Path: <bpf+bounces-43080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D99AEF96
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E001F22906
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D92003BD;
	Thu, 24 Oct 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oFvVjLuo"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D2B658;
	Thu, 24 Oct 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794001; cv=none; b=fisoYmhwqXj6xeequ5F6/J4n3synZSgVkDC0sAfBw8TGvN055V9/glaqtxlK+mlg0DhQWDOIzg8Na+riV+oGQOnkYmgq9pojXvPt8Nm/HERrDNJDe3wk7QoJFbOp1VY6J3JHr+IldpxpPtkg/RfHwfOLe1YVxXdCiH0OAvEGQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794001; c=relaxed/simple;
	bh=vJOZ077V7U7xL8fp19/FQuF9IoMjhGoJNSwoKDSLSmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjRnQKU5ws2kM/4qacFtAgFjmQSL4IAZ9pVE30XAlg0/67DjJvx6dI59+CyZPOUbNnrBEaKTBAjER58oCQys+UUpDmICRG7vFguEtNq8VbrzMOcCW+HoIIHB7ksf1c4pH5OTRFu/fOsJKD0HcQd3GGEV0EVYAhJgFKRNGN3NmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oFvVjLuo; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729793991;
	bh=vJOZ077V7U7xL8fp19/FQuF9IoMjhGoJNSwoKDSLSmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oFvVjLuo4iwDOrEJPr1OBS7yIqqvCElQrYnuWCkadYvwDiUNV2VpTFG+/RqI3zHwp
	 ndDF5hOry4uU1KKDjkhzypApsqklNTBA9Ml2wAMhiVxdGtaZcJcfWpQINf/uVIYU0g
	 O8yeh4ou5XzQiH864Hv/+HZjprnj6zBgjyOVvBnl58Z7vtOXIxNPJJktTcfhIfGKix
	 xkHZ9tQKk3vm8aG9D310+IYZ3X9chkqDanwkBXmxaGLqFUfe1VfRB+/kph3QizeiFC
	 UAZKFl6Tm5ek6XnNyl62t1CECVqpVvy2NNhTxAOXOsGbZ/FNxmX9B10prV0thKEQPT
	 4RwWwAVCY31Qg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XZDj26xJnzvS7;
	Thu, 24 Oct 2024 14:19:50 -0400 (EDT)
Message-ID: <d3ce751e-e694-4b1d-9503-7e46e28eecf4@efficios.com>
Date: Thu, 24 Oct 2024 14:18:08 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jordan Rife <jrife@google.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, LKML
 <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Yonghong Song <yhs@fb.com>
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com>
 <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
 <20241023220552.74ca0c3e@rorschach.local.home>
 <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-24 13:12, Andrii Nakryiko wrote:
[...]

> And as Alexei asked, where are the applied
> patches adding faultable tracepoints?
> 

On linux-next next-20241024 :

0850e1bc88b1 tracing/bpf: Add might_fault check to syscall probes
cdb537ac4179 tracing/perf: Add might_fault check to syscall probes
a3204c740a59 tracing/ftrace: Add might_fault check to syscall probes
a363d27cdbc2 tracing: Allow system call tracepoints to handle page faults   <---- This is where bisection points as first offending commit.
4aadde89d81f tracing/bpf: disable preemption in syscall probe
65e7462a16ce tracing/perf: disable preemption in syscall probe
13d750c2c03e tracing/ftrace: disable preemption in syscall probe
0e6caab8db8b tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


