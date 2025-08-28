Return-Path: <bpf+bounces-66906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF1B3ACA2
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85C824E417C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38583288500;
	Thu, 28 Aug 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go7VN8SP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2324166F;
	Thu, 28 Aug 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415875; cv=none; b=dRhmlgmwZ5yHsROhH6kkbSnnor8X1NXYe90ML/R+tzwSaixUF6dZo29a4wEnbcYya0njn9wPPg+lEMwy6C6tX3/hmRKkopFL1S9DHAfGj75deHn1CzvmrHTdlKLEo4yFqfjGcSBHdQtx+OkEbtbGvFnWR1moqdsl48Pxz/EFnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415875; c=relaxed/simple;
	bh=DsWvnwU0agen7P/TzIjwPCjxm648KDDyXYfW50yobXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAlX/vAS/roxFGIsGMx7GjGGKNKhAh26kCrLkN3DsEYE2ByPcqdIARVJ+1i8iWfXeJth4o6s7mZYbQNxcpqClj8dsdtnT24O3CmI9f2aaUcdQf6on/3rEfaMwIZDUCh0hntoz81NOyQYT+Z5PuISfP1M1yecryd6UBo54GM9MMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go7VN8SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A995C4CEEB;
	Thu, 28 Aug 2025 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756415874;
	bh=DsWvnwU0agen7P/TzIjwPCjxm648KDDyXYfW50yobXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=go7VN8SP0EZolIzwXVJtzgtipce2TQyifuynBtMra1UBQxK/rygnw7MXrAMa2xtNu
	 ZUMtUeQvOqz6x9acjyfxMtIWU7Ui/GWKdKNvsY0gPLUgxArVtHAmTwpu8NulRukP/3
	 07UQ8HP0fK5SZWfSZ7wTpkD1rZkSmsXUi3/P4VwZEKQWnu0swLFsWNPDX6DkDG4Qse
	 bKGM2/MJupgpEfGN0m5v2R4fh+IuayqE1V98dkH8S5mCzwS/DmqYV6O6r4cc2qR3DG
	 7vPoMjhzqsiY0wfKGrVcMXvPctGKgFSDfrnLiojQ3xXK19Ow05MTi1IPkAM1J3cHdw
	 4LQopuKGtowtA==
Date: Thu, 28 Aug 2025 17:17:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250828171748.07681a63@batman.local.home>
In-Reply-To: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 14:06:39 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So you can certainly use siphash for hashing, but make sure to not use
> the same secret key that the printing does.

Right, I just meant to use the same algorithm. The key would be different.

> 
> As to the ID to hash, I actually think a 'struct file *' might be the
> best thing to use - that's directly in the vma, no need to follow any
> other pointers for it.

But that's unique per task, right? What I liked about the f_inode
pointer, is that it appears to be shared between tasks.

I only want to add a new hash and print the path for a new file. If
several tasks are using the same file (which they are with the
libraries), then having the hash be the same between tasks would be
more efficient.

-- Steve

