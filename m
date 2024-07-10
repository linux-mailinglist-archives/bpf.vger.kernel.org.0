Return-Path: <bpf+bounces-34336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6192C7B6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A191F23CE0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E03FE4;
	Wed, 10 Jul 2024 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHn1xkxh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B214A04;
	Wed, 10 Jul 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720572927; cv=none; b=JEDlfqRDwyF9jsWmaN7aDFjNl19vbimATPRI2Tw25mwgOnNFeKYCn5W1iuQq7VHMhETsYhOSgQK8Y04bRZt9O1rXTcF76/dImaUqyyflRfA8prmxJ80uEkX2QOTLfDjATBlXr2Nt5rsC1RxWF5vK96VUUJ8n4jRqrVbWxvSuVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720572927; c=relaxed/simple;
	bh=bitPg8LD4gcptSNxQJP5YQUYZFMEYZzkW1TRSoUqBFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CtdMZsq6qEL04TXdz4Km0SUU/pBXyES1l67a21Ej4Mlqjqek4Mbw21BR1sSBw72N5W0SxPHjhLxG9LR8cLiN355YFIC7jMThvc3fF8AC+hrF9EW2XzQovugEJsbVdtEWTyLnUk4MEkjsnAkU/D/0DySKMNbh6/Z/8p4w0QkLJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHn1xkxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB9C3277B;
	Wed, 10 Jul 2024 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720572926;
	bh=bitPg8LD4gcptSNxQJP5YQUYZFMEYZzkW1TRSoUqBFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHn1xkxhzgNFs/A5esmTp5dqfG4QCJKvPs5hbYcZ6xrWoGosRGawuXCfcH8npeEEU
	 MxZ1ludRolX7Tufd+C2q9DTrC0SPGxpV9Y6WkDuT2OlIwgOhpqUXYoUQ5MTbKKUnTp
	 6UwTPtjMQc8YFQImqSt5GgTWZA7KWjx0CmjUFJvapbYIGapkJtgoPjz79EiguR4Tyn
	 1PMN/i9OUkqT4YIoLrJmmRyqHRv+RqMIMjdGgEMa5n2DR2D55AK5/Vvr3I5mIaKgZK
	 RtOrjmWsUR9aLfzC3pASheaF+hd3OFZcX9fiHcFmVDSwOMvPJuIUj4itutUz4Szqnk
	 Z+xkYOazL0EZA==
Date: Wed, 10 Jul 2024 09:55:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, mingo@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, oleg@redhat.com,
 jolsa@kernel.org, clm@meta.com, paulmck@kernel.org, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240710095520.e6cbfa6efac9bd79f248b111@kernel.org>
In-Reply-To: <20240709090304.GG27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
	<20240709075651.122204f1358f9f78d1e64b62@kernel.org>
	<CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
	<20240709090304.GG27299@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 11:03:04 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> 
> > Ramping this up to 16 threads shows that mmap_rwsem is getting more
> > costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> > CPU. Is this expected? (I'm not familiar with the implementation
> > details)
> 
> SRCU getting more expensive is a bit unexpected, it's just a per-cpu
> inc/dec and a full barrier.
> 
> > P.S. Would you be able to rebase your patches on top of latest
> > probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> > uretprobe benchmarks are quite unrepresentative because of that.
> 
> What branch is that? kernel/events/ stuff usually goes through tip, no?

I'm handling uprobe patches in linux-trace tree, because it's a kind of
probes in the kernel. Actually that is not clarified that the uprobe is
handled by which tree. I had asked to handle kprobes in linux-trace, but
uprobes might not be clear. Is that OK for you to handle uprobes on
linux-trace?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

