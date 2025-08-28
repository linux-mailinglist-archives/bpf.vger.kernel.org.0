Return-Path: <bpf+bounces-66907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E29B3ACB4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAF5566E91
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B629D29B;
	Thu, 28 Aug 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiF4yDGh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC31A8F84;
	Thu, 28 Aug 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416440; cv=none; b=E1NASVQq6N/vWgXtw+2GERxizc9qwtHEIEOLOsx/8A8167+DUL168wgLfbTUwkToximSj0rv2KZM/MKnHLKFl6V9giYk5wiYwvpI8/VAJvKvmONm2n4DcMiuu0D20vmaxUjz0g3oFyOcV7pvJVspxBvZq6zZQGL1nSDdIeu7wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416440; c=relaxed/simple;
	bh=F9xDHWqkF1GjRihj3dUZnAszqw+My0fBopE3OqZzH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Duh1bZFWHlAc7x0KE2l6Om/PkBi7PRSlRWzHztunGvWOoMon7WUw6Gp/7ZJD1tf6jFkHPcs+jngA77+E4dzffv7HF5ZJyMgD2BhSYS8ZzqsTeQ52tn5882KHYWxLjrlWgGRHRXVKMD832XtJgAS4R3MHuBFomYBmqa4m/ficPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiF4yDGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D2CC4CEEB;
	Thu, 28 Aug 2025 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756416440;
	bh=F9xDHWqkF1GjRihj3dUZnAszqw+My0fBopE3OqZzH+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UiF4yDGhRLT6PMsa8dqe7Ki50MQDjr5ERQN7do3EYNZ/iXznCNMs2GIJkBlUFjwN7
	 0eBQPDI/l3k/JIm/x329kWAd9PoWpgNi+QOTgLiNxv7fG8/8Sv1vzrHlO4F2AjZwlU
	 hP9M14RVymaWeYklvV6oEiLc9eLdrtUFoYmEx8HXTCFUCThG/ZxlsQj5gzmdO30Sjj
	 cTOKbWWrH7C4e3Eh9hcUq8zFpEVk/0i+d3fjRkc7e2H2cGnPdClwWtbaIrcraXu+uT
	 T4wyjpcqm6R0S1/ECvRtvzZqKQYHTuz8ZWo+UEA1Eg12A0+zv9DlwP8/0d+w1/ZjZv
	 KtYeZxUh1EsCQ==
Date: Thu, 28 Aug 2025 17:27:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250828172715.215d18ee@batman.local.home>
In-Reply-To: <F8A0C174-F51B-40A4-8DC5-C75B8706BE74@gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
	<20250828165139.15a74511@batman.local.home>
	<F8A0C174-F51B-40A4-8DC5-C75B8706BE74@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 18:00:22 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> >Thus, the user stack trace will just have the offset and a hash value
> >that will be match the output of the file_cache event which will have
> >the path name and a build id (if one exists).
> >
> >Would that work?  
> 
> Probably.
> 
> This "if it is available" question is valid, but since 2016 it's is
> more of a "did developers disabled it explicitly?"

The "if one exists" comment is that it's not a requirement. If none
exists, it would just add a zero.

> 
> If my "googling" isn't wrong, GNU LD defaults to generating a build
> ID in ELF images since 2011 and clang's companion since 2016.
> 
> So making it even more available than what the BPF guys did long ago
> and perf piggybacked on at some point, by having it cached, on
> request?, in some 20 bytes alignment hole in task_struct that would
> be only used when profiling/tracing may be amenable.

Would perf be interested in this hash file lookup?

I know perf is reliant on user space more than ftrace is, and has a lot
of work happening in user space while getting stack traces. With
ftrace, there's on real user space requirement, thus a lot of the work
needs to be done in the kernel.

If we go with a hash to file, it's somewhat useless by itself without a
way to map the hash to file/buildid.

I originally started making this hash->file a file in tracefs. But then
I needed to figure out how to manage the allocations. Do I add a "size"
for that file and start dropping mappings when it reaches that limit.
Then I may need to add a LRU algorithm to do so. I found simply having
an event that wrote out the mappings was so much easier to implement.

But the file_cache code could be used by perf, where perf does the same
and just monitors the file_cache event. I could make the API more
global than just the kernel/trace directory.

-- Steve

