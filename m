Return-Path: <bpf+bounces-56536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0208A99828
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B33F1B850E8
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF628E61A;
	Wed, 23 Apr 2025 18:51:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B827FD7D;
	Wed, 23 Apr 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434278; cv=none; b=MvyvhllmJFwqmfXZGJeVduPrJJKXZOXdI/B4XG3EbSMP4mpvngN+MeTR0A7jlS2OjwqEISzgtcD6PcMBnkjGpBo8uOQJ0bpwy58IkLgRfgwwvt+LPDBFmhwo3yFrppMpZSZbfjL9+TSZE4RI1I1mgR5QR5lDoQzAeYDCuZMpHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434278; c=relaxed/simple;
	bh=B3l3DrVwceHsmAJLpOH9gKyLG+5YvzEjnbWCz/zqbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWWOmYCnoL0cc8hu5Dz8fPPiccnTukLTMKwrJwctNYcXH+yX3EGp+fVoX0OTInOSAocx2uFF3bXdI/qJJCgdMOF7PXnazRwBOwRrfD7MAyStQVhkZz4YTB3HdQVWUxLiDBtiTnW4oJqv/Yfozi4pFSo4QLKw0W8qy8UeoSWERz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6FEC4CEE2;
	Wed, 23 Apr 2025 18:51:15 +0000 (UTC)
Date: Wed, 23 Apr 2025 14:53:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>,
 Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250423145308.5f808ada@gandalf.local.home>
In-Reply-To: <CAEf4BzZfoCV=irWiy1MCY0fkhsJWxq8UGTYCW9Y3pQQP35eBLQ@mail.gmail.com>
References: <20250418110104.12af6883@gandalf.local.home>
	<CAEf4BzZfoCV=irWiy1MCY0fkhsJWxq8UGTYCW9Y3pQQP35eBLQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 11:21:25 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> The part about accessing only from code within the kernel isn't true.
> Can we please drop that? BPF program can be attached to these bare
> tracepoints just fine without tracefs (so-called BPF raw tracepoint
> program types).

Is it possible to see a list of these tracepoints from user space? If not,
then it's only available via the kernel. Sure BPF and even trace probes can
attach to them. Just like attaching to functions. The point is, they are
not exposed directly to user space. User space only knows about it if the
user has access to the kernel.

Unless BPF does expose what's avaliable, does it?

> 
> But I don't have an objection to the change itself, given all of them
> currently do have _tp suffix except a few that we have in BPF
> selftests's module, just as Jiri mentioned.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks,

-- Steve

