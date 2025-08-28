Return-Path: <bpf+bounces-66880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA58B3AB3E
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE7A00950
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4F27CCE0;
	Thu, 28 Aug 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxy53NT/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D845215198;
	Thu, 28 Aug 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411483; cv=none; b=UCOC8LpHCKCoGqJYnkXrmS/Soz924gBiMXTexqEsbwbpJV/qCixY+MAn9plTzvudy4nAzkPzz0NsksF6YTsvhGHONzSM3jgz6crZS11NqilHyBSWKcj+CuO1JH0QcWsjmtiYnVbhmuwqsU6AvtZuC92wSKeXm5Ul1i2SaywQoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411483; c=relaxed/simple;
	bh=5afeh85lUxhx753E2Mx3hibqZTVDszFxzOqclgIIGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8gQsfJmfaU90jneO4zh/9QQPJlrVjNyzuPex8/GP5ils53lb/QaUc3lBILjgKz8I4igPkx1YfuMHWyferwqWzcjyVg3DlcNXwWW2YFydbdpPOc7JbdVYgjcQVTxNioYin3UgLDwJGlrpgjs4opOvoW8KTLps5PwX7VFb3ar8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxy53NT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A77DC4CEEB;
	Thu, 28 Aug 2025 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756411482;
	bh=5afeh85lUxhx753E2Mx3hibqZTVDszFxzOqclgIIGzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxy53NT/IVD6ltXeYTGqywzDRNqnYFvb13cgIk0R73sIPkn7+xpWs0eAq3/Qt7oOS
	 kJslIH9Nm/73Am42W2t54YWoyFf4RiAHfGV6r8vHG+4uq2ddygkJslWdqDkXqVHlK7
	 605Hk9vt2uE+mUnlHQHEFW+Dbqncp9hDFlo7ryIChuoF28aKMKdInH6Z9ESeRFMmeR
	 buzV1L8XlJc38AxskvoWMpQVxQqni+nu80Ukfx34dX8jjGBR1R5BNqld6wIzymrX43
	 w/FS7XggjoQBTC+ZPQeZQglPQKSMNKQd+LOhpBkmuTn5qNniZP4xhFWT67HcknNRPM
	 WCqViIg9s7Dnw==
Date: Thu, 28 Aug 2025 17:04:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <aLC2Vs06UifGU2HZ@x1>
References: <20250828180300.591225320@kernel.org>
 <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
 <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>

On Thu, Aug 28, 2025 at 12:18:39PM -0700, Linus Torvalds wrote:
> On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> > >Give the damn thing an actual filename or something *useful*, not a
> > >number that user space can't even necessarily match up to anything.

> > A build ID?
 
> I think that's a better thing than the disgusting inode number, yes.

> That said, I think they are problematic too, in that I don't think
> they are universally available, so if you want to trace some
> executable without build ids - and there are good reasons to do that -
> you might hate being limited that way.

Right, but these days gdb (and other traditional tools) supports it and
downloads it (perf should do it with a one-time sticky question too,
does it already in some cases, unconditionally, that should be fixed as
well), most distros have it:

⬢ [acme@toolbx perf-tools-next]$ file /bin/bash
/bin/bash: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=707a1c670cd72f8e55ffedfbe94ea98901b7ce3a, for GNU/Linux 3.2.0, stripped
⬢ [acme@toolbx perf-tools-next]$

We have debuginfod-servers that brings ELF images with debug keyed by
that build id and finally build-ids come together with pathnames, so if
one is null, fallback to the other.

Default in fedora:

⬢ [acme@toolbx perf-tools-next]$ echo $DEBUGINFOD_
$DEBUGINFOD_IMA_CERT_PATH  $DEBUGINFOD_URLS           
⬢ [acme@toolbx perf-tools-next]$ echo $DEBUGINFOD_
$DEBUGINFOD_IMA_CERT_PATH  $DEBUGINFOD_URLS           
⬢ [acme@toolbx perf-tools-next]$ echo $DEBUGINFOD_IMA_CERT_PATH 
/etc/keys/ima:
⬢ [acme@toolbx perf-tools-next]$ echo $DEBUGINFOD_URLS 
https://debuginfod.fedoraproject.org/
⬢ [acme@toolbx perf-tools-next]$

I wasn't aware of that IMA stuff.

So even without the mandate and with sometimes not being able to get
that build-id, most of the time they are there and deterministically
allows tooling to fetch it in most cases, I guess that is as far as we
can pragmatically get.

- Arnaldo
 
> So I think you'd be much better off with just actual pathnames.
> 
> Are there no trace events for "mmap this path"? Create a good u64 hash
> from the contents of a 'struct path' (which is just two pointers: the
> dentry and the mnt) when mmap'ing the file, and then you can just
> associate the stack trace entry with that hash.
> 
> That should be simple and straightforward, and hashing two pointers
> should be simple and straightforward.
> 
> And then matching that hash against the mmap event where the actual
> path was saved off gives you an actual *pathname*. Which is *so* much
> better than those horrific inode numbers.
> 
> And yes, yes, obviously filenames can go away and aren't some kind of
> long-term stable thing. But inode numbers can be re-used too, so
> that's no different.
> 
> With the "create a hash of 'struct path' contents" you basically have
> an ID that can be associated with whatever the file name was at the
> time it was mmap'ed into the thing you are tracing, which is I think
> what you really want anyway.
> 
> Now, what would be even simpler is to not create a hash at all, but
> simply just create the whole pathname when the stack trace entry is
> created. But it would probably waste too much space, since you'd
> probably want to have at least 32 bytes (as opposed to just 64 bits)
> for a (truncated) pathname.
> 
> And it would be more expensive than just hashing the dentry/mnt
> pointers, although '%pD' isn't actually *that* expensive. But probably
> expensive enough to not really be acceptable. I'm just throwing it out
> as a stupid idea that at least generates much more usable output than
> the inode numbers do.
> 
>           Linus

