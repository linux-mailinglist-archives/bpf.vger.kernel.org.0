Return-Path: <bpf+bounces-66881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0EB3AB77
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BA21C86484
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB3285C96;
	Thu, 28 Aug 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiHx2vcg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DB21018A;
	Thu, 28 Aug 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412244; cv=none; b=hEZJIynijtAt06l/5TH/aiOoKLOT6LqRErS2OOsk1z0T9pBJ6gj23lJ49lWCJc64l8aEcL+GtiQe2gQFdGAJ+zcp1OhUWrTWTE+/aS5ySwB+QxykCVH3ytzT/WEuaF3J3vyOnB5i05GNV75SdgN3IWw16rVLxMp2hHjJsFkOyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412244; c=relaxed/simple;
	bh=fK/tnNgDCKG4oKb5DekcqFjcZHYTZn4gd3yjqB++WJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNbmwREDx6eWnGCOJj2xBUYbjeEWM/iX/RYIo4yK1szOa2guBT4P7G06M5ECj+U0nz1vuP4q4HIyBJFS6Ekgbc0RNwXL1Y1zjfWIpW6aFnlW2s7DOZQg4yHv7H0wOjdv9uUxTDq8s3xUJnzMsS6C+73Rs+Pbc7lVYxktCgaRC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiHx2vcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C83C4CEF5;
	Thu, 28 Aug 2025 20:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756412244;
	bh=fK/tnNgDCKG4oKb5DekcqFjcZHYTZn4gd3yjqB++WJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SiHx2vcgsaZ1g0gfAuMHHRVeEtpoPtu+MXZnqO0aMDLMTPEzW1Wcu9nIZoD0B8nS1
	 qJWE/hElqaeHI027M7jx42wbg/W9Bg90fHHH4paMLJp7XdqaSlOwOwF32sRa1DzzDe
	 forOyKKdsrtOOCKrORzfJPrhssfdLh5Cyu3H6LLDzz3p0Gv7qqqP77fK5YWDTfOkjz
	 sCK6tQFynD0S6eKLHVcrcm4z8WJQ5dHlMKzD0uOb2u1bpe28B/fq4j6qtEB3zT+sFo
	 5edL8ZmdZUNlGPgM5ZV/Y9r0cXDDM75zrBV89qyZasEeeDtwmyyVBijwpit0gAhJ2r
	 eoXDqh8wVV8cQ==
Date: Thu, 28 Aug 2025 16:17:18 -0400
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
Message-ID: <20250828161718.77cb6e61@batman.local.home>
In-Reply-To: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 12:18:39 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > >
> > >Give the damn thing an actual filename or something *useful*, not a
> > >number that user space can't even necessarily match up to anything.  
> >
> > A build ID?  
> 
> I think that's a better thing than the disgusting inode number, yes.

I don't care what it is. I picked inode/device just because it was the
only thing I saw available. I'm not sure build ID is appropriate either.

> 
> That said, I think they are problematic too, in that I don't think
> they are universally available, so if you want to trace some
> executable without build ids - and there are good reasons to do that -
> you might hate being limited that way.
> 
> So I think you'd be much better off with just actual pathnames.

As you mentioned below, the reason I avoided path names is that they
take up too much of the ring buffer, and would be duplicated all over
the place. I've run this for a while, and it only picked up a couple of
hundred paths while the trace had several thousand stack traces.

> 
> Are there no trace events for "mmap this path"? Create a good u64 hash
> from the contents of a 'struct path' (which is just two pointers: the
> dentry and the mnt) when mmap'ing the file, and then you can just
> associate the stack trace entry with that hash.

I would love to have a hash to use. The next patch does the mapping of
the inode numbers to their path name. It can easily be switched over to
do the same with a hash number.

> 
> That should be simple and straightforward, and hashing two pointers
> should be simple and straightforward.

Would a hash of these pointers have any collisions? That would be bad.

Hmm, I just tried using the pointer to vma->vm_file->f_inode, and that
gives me a unique number. Then I just need to map that back to the path name:

       trace-cmd-1016    [002] ...1.    34.675646: inode_cache: inode=ffff8881007ed428 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libc.so.6
       trace-cmd-1016    [002] ...1.    34.675893: inode_cache: inode=ffff88811970e648 dev=[254:3] path=/usr/local/lib64/libtracefs.so.1.8.2
       trace-cmd-1016    [002] ...1.    34.675933: inode_cache: inode=ffff88811970b8f8 dev=[254:3] path=/usr/local/lib64/libtraceevent.so.1.8.4
       trace-cmd-1016    [002] ...1.    34.675981: inode_cache: inode=ffff888110b78ba8 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7
            bash-1007    [003] ...1.    34.677316: inode_cache: inode=ffff888103f05d38 dev=[254:3] path=/usr/bin/bash
            bash-1007    [003] ...1.    35.432951: inode_cache: inode=ffff888116be94b8 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libtinfo.so.6.5
            bash-1018    [005] ...1.    36.104543: inode_cache: inode=ffff8881007e9dc8 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
            bash-1018    [005] ...1.    36.110407: inode_cache: inode=ffff888110b78298 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libz.so.1.3.1
            bash-1018    [005] ...1.    36.110536: inode_cache: inode=ffff888103d09dc8 dev=[254:3] path=/usr/local/bin/trace-cmd

I just swapped out the inode with the above (unsigned long)vma->vm_file->f_inode,
and it appears to be unique.

Thus, I could use that as the "hash" value and then the above could be turned into:

       trace-cmd-1016    [002] ...1.    34.675646: inode_cache: hash=ffff8881007ed428 path=/usr/lib/x86_64-linux-gnu/libc.so.6
       trace-cmd-1016    [002] ...1.    34.675893: inode_cache: hash=ffff88811970e648 path=/usr/local/lib64/libtracefs.so.1.8.2
       trace-cmd-1016    [002] ...1.    34.675933: inode_cache: hash=ffff88811970b8f8 path=/usr/local/lib64/libtraceevent.so.1.8.4
       trace-cmd-1016    [002] ...1.    34.675981: inode_cache: hash=ffff888110b78ba8 path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7
            bash-1007    [003] ...1.    34.677316: inode_cache: hash=ffff888103f05d38 path=/usr/bin/bash
            bash-1007    [003] ...1.    35.432951: inode_cache: hash=ffff888116be94b8 path=/usr/lib/x86_64-linux-gnu/libtinfo.so.6.5
            bash-1018    [005] ...1.    36.104543: inode_cache: hash=ffff8881007e9dc8 path=/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
            bash-1018    [005] ...1.    36.110407: inode_cache: hash=ffff888110b78298 path=/usr/lib/x86_64-linux-gnu/libz.so.1.3.1
            bash-1018    [005] ...1.    36.110536: inode_cache: hash=ffff888103d09dc8 path=/usr/local/bin/trace-cmd

This would mean the readers of the userstacktrace_delay need to also
have this event enabled to do the mappings. But that shouldn't be an
issue.

-- Steve


