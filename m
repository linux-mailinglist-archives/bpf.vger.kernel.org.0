Return-Path: <bpf+bounces-34306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69792C5F4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572F21F22A86
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790D18563D;
	Tue,  9 Jul 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1ATtM6L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13313AD07;
	Tue,  9 Jul 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563053; cv=none; b=OFF69JUbeGG3j61xftv6UF1BJ/nK1NzUyIWvbSBaCZpCj/WnZ0Os2VsiPgWumGSw2hui1W//dNRnc5ngDtOwUHCN70lp89fz5U9O/rO5GPswsNyHGON7DvoXFiOBDzLePKUScNbELzTrAhRK2g2lhqJFhwTi7M0c1NvmDkcRX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563053; c=relaxed/simple;
	bh=YOn34ybC7wOhO270i+Jc4r/nQBeK0KcsYGPPaopRL0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fpNeoAjcVTVZkHG8O9LTXUVvFtVMjbnL1clu6NRtUM0j48CAJaDdehONbjxA6uIf3nw9cfJH1kHYjqJgVNhcYHPCIK/Ig4OvWGcaltf+tgKLt3iJ2Kpc6d0sUPoRS9iumz+bNu8JElWIMd9FGZwgIgXN8UFdNKjAI1Ic9KYdRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1ATtM6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA8DC3277B;
	Tue,  9 Jul 2024 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720563052;
	bh=YOn34ybC7wOhO270i+Jc4r/nQBeK0KcsYGPPaopRL0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m1ATtM6LVMUMkJIN9fMpo7FHR3XYlUtPS3n/RJIKXkc4EHqCXEWf3691l2/C2CkeB
	 XIHt95c8FkaUBNILnjM4AHx8viw5TTEPWOySiaSRnv9TXwfKAb0GjY31Rj2tmM94yp
	 RYdGxhhYyc84LzQ5cKbFU53Kk+e15VB4sGn7U5XPvoMC+pSVFEdM0OIXQdBOah23s9
	 1T8VzMNGWN/wnxgAqWvNCRWOe1hDALShDJnwktvneGKQZ5gMeFN4jJz7tvXwnTp0Uv
	 vpb468nd3p3ZjIg/Lsfel6uxpNghvkF34gYoPkHwQyZ8HXQucnBvBogrTrMcsrs6HK
	 4xoymVDn8fYfA==
Date: Wed, 10 Jul 2024 07:10:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, clm@meta.com, paulmck@kernel.org, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240710071046.e032ee74903065bddba9a814@kernel.org>
In-Reply-To: <20240709101634.GJ27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
	<20240709075651.122204f1358f9f78d1e64b62@kernel.org>
	<CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
	<20240709090304.GG27299@noisy.programming.kicks-ass.net>
	<Zo0KX1P8L3Yt4Z8j@krava>
	<20240709101634.GJ27299@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 12:16:34 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jul 09, 2024 at 12:01:03PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 09, 2024 at 11:03:04AM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> > > 
> > > > Ramping this up to 16 threads shows that mmap_rwsem is getting more
> > > > costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> > > > CPU. Is this expected? (I'm not familiar with the implementation
> > > > details)
> > > 
> > > SRCU getting more expensive is a bit unexpected, it's just a per-cpu
> > > inc/dec and a full barrier.
> > > 
> > > > P.S. Would you be able to rebase your patches on top of latest
> > > > probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> > > > uretprobe benchmarks are quite unrepresentative because of that.
> > > 
> > > What branch is that? kernel/events/ stuff usually goes through tip, no?
> > 
> > it went through the trace tree:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes/for-next
> > 
> > and it's in linux-next/master already
> 
> FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
> what gives?

This is managing *probes and related dynamic trace-events. Those has been
moved from tip. Could you also add linux-trace-kernel@vger ML to CC?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

