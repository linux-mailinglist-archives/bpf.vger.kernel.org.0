Return-Path: <bpf+bounces-40948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2509906DD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DEE1F216CC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6B21BAF2;
	Fri,  4 Oct 2024 14:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE9219480;
	Fri,  4 Oct 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053479; cv=none; b=nvO5zQooxBu/w1ORrxQKcZYSoK9aTxy271q6Y9j8mg5EKi4hK2Ge4iqrrHeTzdAVwmEf3QwcnVdF+AW5bJwKOI61u78LOoYIaElP6o1v257DmWKUtEAk8ZsBbNnDJQcI1B6fr8HeDjxyPvC7VNzQgC5u8FvSL9+jMacrRkuc5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053479; c=relaxed/simple;
	bh=r/co0L0B4wgl0JjCCmR6K1PuFgXUGYn8T4273gDb+pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyE/2zzeJd9boG2Z5thLa/Vpk0Y5MmJPgi/z/6x0WkrE40BHIVxyo+ymZkvWwfoMaBpeUr3bMQ6BLVWS1g77xMzkHJX3C6OJ5xw5lCJUDs4nKuSNfhd1LHA4gJGYNAT3qZWQJ+ZRADCvF1AO5vks3JXYlNEcYv84oN9GUjiojN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31484C4CEC6;
	Fri,  4 Oct 2024 14:51:16 +0000 (UTC)
Date: Fri, 4 Oct 2024 10:52:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
Message-ID: <20241004105211.13ea45da@gandalf.local.home>
In-Reply-To: <e547819a-7993-4c80-b358-6719ca420cf8@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
	<20241003182304.2b04b74a@gandalf.local.home>
	<6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
	<20241003210403.71d4aa67@gandalf.local.home>
	<90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
	<20241004092619.0be53f90@gandalf.local.home>
	<e547819a-7993-4c80-b358-6719ca420cf8@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 10:19:36 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The eBPF people want to leverage this. When I last discussed this with
> eBPF maintainers, they were open to adapt eBPF after this infrastructure
> series is merged. Based on this eBPF attempt from 2022:
> 
> https://lore.kernel.org/lkml/c323bce9-a04e-b1c3-580a-783fde259d60@fb.com/

Sorry, I wasn't part of that discussion.

> 
> The sframe code is just getting in shape (2024), but is far from being ready.
> 
> Everyone appears to be waiting for this infrastructure work to go in
> before they can build on top. Once this infrastructure is available,
> multiple groups can start working on introducing use of this into their
> own code in parallel.
> 
> Four years into this effort, and this is the first time we're told we need
> to adapt in-tree tracers to handle the page faults before this can go in.
> 
> Could you please stop moving the goal posts ?

I don't think I'm moving the goal posts. I was mentioning to show an
in-tree user. If BPF wants this, I'm all for it. The only thing I saw was a
generalization in the cover letter about perf, bpf and ftrace using
faultible tracepoints. I just wanted to see a path for that happening.

-- Steve

