Return-Path: <bpf+bounces-71697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F5BFB0E4
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E151218C3A78
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B21311C2A;
	Wed, 22 Oct 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvo5GFQz"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6430F7FA;
	Wed, 22 Oct 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123918; cv=none; b=Z5a5QRKwdE/ztkoeUs4KAaeeLZmLSRTiG2OGE5QiLvisIlo22Gh16mIrhxRSBDPAcDdIyb7AcDMF79y4AgND6mQSHmz2BXtSU0iusbaBldPRQhk7lJI9+NCXZnBxkEGtKCq7wSZtHBb+LO0sFtTnaP4eOCZnRP6jpu9wceX27wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123918; c=relaxed/simple;
	bh=DHXfpS9aswzlJwBEoWw7X4Zv+9/3m5MUqiLosCFMR7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djA9HzkJKi+b8er8jyBDCZ/PEi3xHpdtwIQJ9YJVzCf2eItjZLUo94QquEoFmj1Q7uoS+obzMyVOy4BrTyMjO452L4qn30IXX2rz367I5Mt1nCStKC8VksHxPs9rvvMA+9p4pArDYcE3u/mwSS7qjJpF9cv5RhpU9gNtA4cH1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mvo5GFQz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pd
	nI4MEp0UYVRPKbdbYIQkMJ3KrGkN06ieOL071k4ws=; b=mvo5GFQzB3IifmVuMA
	93hBsSIR9IskT1fLvOB9pZcna4DKjScg7c155RqOepGXR7ki4EMFpc7JlB6gkTVU
	3vAOTgG77SWE+7aYOY7ZvfIo0X9ESayPAspHzKVb08bq+uzK0y3oYMVBmz9baY98
	PeTkaqfnWl5aeD9TI7n/xHgB8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHFx8dnvhonGH4Bw--.20175S2;
	Wed, 22 Oct 2025 17:04:30 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: rostedt@goodmis.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	jpoimboe@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	olsajiri@gmail.com,
	peterz@infradead.org,
	x86@kernel.org,
	yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Date: Wed, 22 Oct 2025 17:04:29 +0800
Message-Id: <20251022090429.136755-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015121138.4190d046@gandalf.local.home>
References: <20251015121138.4190d046@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHFx8dnvhonGH4Bw--.20175S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry5CF1kXw43AF1Duw1rWFg_yoW8ZFy5pr
	W8tFyYkr4kZFn2vr42vw48Kr1SyrWfCrW5GrWkArWrCwsIq343AryayFyjgFW0yryrWa4j
	vF4YvrZ0kwn8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRe6w_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRjueGj4lf3kzwAAsQ

On Wed, 15 Oct 2025 12:11:38 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Hmm, we do have a way to retrieve the actual return caller from a location
> > > for return_to_handler:
> > > 
> > >   See kernel/trace/fgraph.c: ftrace_graph_get_ret_stack()
> > > 
> > > Hmm, I think the x86 ORC unwinder needs to use this.  
> > 
> > I'm confused, is that not what ftrace_graph_ret_addr() already does?

> Ah yeah, that does it too. I just searched for the first function that did
> the look up ;-)

> Now I guess the question is, why is this not working?


I've also encountered this issue recently. It only outputs the stack trace of return_to_handler, for example:

# bpftrace -e 'kretprobe:vfs_rea* {@[kstack]=count()}'
Attaching 1 probe...
^C

@[
    ksys_read+192
    get_perf_callchain+211
    bpf_get_stackid+101
    cleanup_module+303100
    kprobe_multi_link_prog_run+175
    fprobe_return+265
    __ftrace_return_to_handler.isra.0+433
    return_to_handler+30
]: 1

The return stack trace when directly executing samples/fprobe/fprobe_example.c is similar:
[ 71.892353] return_to_handler: kernel_thread+0x71/0xa0
[ 71.892356] sample_exit_handler: Return from <kernel_clone+0x4/0x470> ip = 0x000000000e0e2004 to rip = 0x00000000127e6d58 (kernel_thread+0x71/0xa0)
[ 71.892361] __ftrace_return_to_handler.isra.0+0x1b1/0x280
[ 71.892363] return_to_handler+0x1e/0x50

No cases were found where the ret of the ftrace_graph_ret_addr function is equal to return_handler.

Additionally, I noticed that when the x86 architecture executes perf_callchain_kernel, perf_hw_regs(regs) is false,
and it calls unwind_start(&state, current, NULL, (void *)regs->sp);
which then proceeds to __unwind_start where the check task == current is performed.
However, the ARM architecture executes kunwind_init_from_regs(&state, regs);
instead of taking the second branch with the task == current check.

I hope these phenomena can help you analyze the cause of this issue.
Thanks.


