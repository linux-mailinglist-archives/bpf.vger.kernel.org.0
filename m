Return-Path: <bpf+bounces-67349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F09B42B77
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC85D1B267E7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF002EACF1;
	Wed,  3 Sep 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6n6Sg8z"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F32EA759;
	Wed,  3 Sep 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933283; cv=none; b=mRh7hPwXBx20edaknXMuykZcP7ZCmVHrCd3a0gKPhtverdPNDnqtdXWRTsnovLCnX8TQfQ59Qz9N0SMr0prAhSfqd4NRjGWZS24F1bG9vXOgH480+qax15fbnr6IhpvP1+EqP0PF64no9QDqKLL5zFoOXCdmO/dw+YS8of2/tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933283; c=relaxed/simple;
	bh=XGdtskBGFwtyVmK1+2rQa6K/YB7bXVnyuqJbm3/8uYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F65I5Lf3jmxthyCHbyE+NQ54vDVJOTXwPWOwPpG8pUGtDn6hJ9HXtTss5uJpI3J5iP0lSOYDFSCu3jEzNgx5h8zRugG+fTW2rx9nwRlmHexhxPczPzVgtqXdITXYSsqRwHwb4GTU8aEItgGyIMFQL7nv67+sVtS3kO9ldZv5FcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q6n6Sg8z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XGyZmgjExmsUZagUGeDDTjnxL29Q9nuxRuIDWGJRPo0=; b=q6n6Sg8z2OTXCODlF0HhYQDenI
	/dEkTZtI3M3mHdsd9kmgquVEGU3N6Jl4hcdO4OTyqDfofqLarN7HcUu/bq0v7P4jKSLPXa6TWb8q/
	I08RPLd1qZNH1kgTx85f7a3lwftClNFKxpn1gDpla4g6MhQQfPC7NnAuNTpIufnKeFg/2nRb+N4pg
	MiAFevHM/8Qs90HJlQ4wHj0NYg6CayuWspJnm4hz3bLDobVmvLwMdZaPgHHuPRA/njA0+fE5FFzzH
	hySYJLVn+HBJiEpb6DcdZIfrcTUpsz4usbRg0tYaGj2WjjTpmCwlu/AEbGIjxYlAKp+DyihkznZDN
	9StjEMfA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utubQ-00000007yhf-0fEl;
	Wed, 03 Sep 2025 21:01:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18D9D300220; Wed, 03 Sep 2025 23:01:12 +0200 (CEST)
Date: Wed, 3 Sep 2025 23:01:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLirakTXlr4p2Z7K@krava>

On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:

> > > +SYSCALL_DEFINE0(uprobe)
> > > +{
> > > +       struct pt_regs *regs = task_pt_regs(current);
> > > +       struct uprobe_syscall_args args;
> > > +       unsigned long ip, sp;
> > > +       int err;
> > > +
> > > +       /* Allow execution only from uprobe trampolines. */
> > > +       if (!in_uprobe_trampoline(regs->ip))
> > > +               goto sigill;
> > 
> > Hey Jiri,
> > 
> > So I've been thinking what's the simplest and most reliable way to
> > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > whether we should attach at nop5 vs nop1), and clearly that would be
> > to try to call uprobe() syscall not from trampoline, and expect some
> > error code.
> > 
> > How bad would it be to change this part to return some unique-enough
> > error code (-ENXIO, -EDOM, whatever).
> > 
> > Is there any reason not to do this? Security-wise it will be just fine, right?
> 
> good question.. maybe :) the sys_uprobe sigill error path followed the
> uprobe logic when things go bad, seem like good idea to be strict
> 
> I understand it'd make the detection code simpler, but it could just
> just fork and check for sigill, right?

Can't you simply uprobe your own nop5 and read back the text to see what
it turns into?

