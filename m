Return-Path: <bpf+bounces-43271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D099B2401
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6823F282037
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 05:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC318B470;
	Mon, 28 Oct 2024 05:06:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74D4685;
	Mon, 28 Oct 2024 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092014; cv=none; b=iS23tVC57FRkAVDQjL00mCL/SzelKKaLl7Z2OsPBPBUfRszAZ4Vn3qoyAHbG8/QLprj6lqd7fLz82ZAa73EwBDJJZYJ3QZKEQzwb9wSmft4+q50gzCKqn+1Ao/wll6DGnNlSSJtl/bOpykU798mKawBvYRQJ685XWTo8r3Y9Mww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092014; c=relaxed/simple;
	bh=prY2IVSkiqU1T7tj9uznRv0r6Xzl/QHeNDgh6J5hwlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APzCUmQWMfJkHUNzAc1xEWv9WFFpEf9bSGIAgNOfCRPzyAkPGox0i+ThkJneoZuTEJ3Fgk9uYvfXj/QTVTvhMZI2RvHxW/KNScys4nOJRafa/zH57TD0AZ7x82uqvRSLwIVXhkwdF7ASZTYV0F0JAoiCYcQrD+6xsPuIx3anaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4F2C4CEC3;
	Mon, 28 Oct 2024 05:06:50 +0000 (UTC)
Date: Mon, 28 Oct 2024 01:06:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
Message-ID: <20241028010647.38f4847f@rorschach.local.home>
In-Reply-To: <933ab148-2a28-4912-9bca-150a0643eecd@efficios.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
	<20241026154629.593041-2-mathieu.desnoyers@efficios.com>
	<20241026200840.17171eb2@rorschach.local.home>
	<933ab148-2a28-4912-9bca-150a0643eecd@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 08:30:54 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > I wonder if we should call it "sleepable" instead? For this patch set
> > do we really care if it's a system call or not? It's really if the
> > tracepoint is sleepable or not that's the issue. System calls are just
> > one user of it, there may be more in the future, and the changes to BPF
> > will still be needed.  
> 
> Remember that syscall tracepoint probes are allowed to handle page
> faults, but should not generally block, otherwise it would postpone the
> grace periods of all RCU tasks trace users.
> 
> So naming this "sleepable" would be misleading, because probes are
> not allowed general blocking, just to handle page faults.

I'm fine with "faultable" too.

> 
> If we look at the history of this tracepoint feature, we went with
> the following naming over the various versions of the patch series:
> 
> 1) Sleepable tracepoints: until we understood that we just want to
>     allow page fault, not general sleeping, so we needed to change
>     the name,
> 
> 2) Faultable tracepoints: until Linus requested that we aim for
>     something that is specific to system calls, rather than a generic
>     thing.
> 
>     https://lore.kernel.org/lkml/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/

Reading that thread again, I believe that Linus was talking more about
all the infrastructure going around to make a special "faultable"
tracepoint (I could be wrong, and Linus may correct me here). When in
fact, the only user is system calls. But from the BPF POV, it doesn't
care if it's a system call, it cares that it is faultable, and the
check should be on that. Having BPF check if it's a system call is
requiring that BPF knows the implementation details of system call
tracepoints. But if it knows it is faultable, then it needs to do
something special.

> 
> 3) Syscall tracepoints: This is what we currently have.
> 
> > Other than that, I think this could work.  
> 
> Calling this field "sleepable" would be misleading. Calling it "faultable"
> would be a better fit, but based on Linus' request, I'm tempted to stick
> with "syscall" for now.
> 
> Your concern is to name this in a way that is general and future-proof.
> Linus' point was to make it syscall-specific rather than general. My
> position is that we should wait until we face other use-cases (if we
> even do) before consider changing the naming from "syscall" to something
> more generic.

Yes, but that was for the infrastructure itself. It really doesnt' make
sense that BPF needs to know which type of tracepoint can fault. That's
telling BPF, you need to know the implementation of this type of
tracepoint.

-- Steve


