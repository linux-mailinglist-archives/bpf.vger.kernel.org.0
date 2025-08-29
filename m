Return-Path: <bpf+bounces-66996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B0B3C0A8
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B5D1774DB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9C326D6E;
	Fri, 29 Aug 2025 16:27:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2907326D44;
	Fri, 29 Aug 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484844; cv=none; b=Y4g9qG4YGzQEwvr6RxvhdTR8Viov8QanMeKnafCV/yhKbkILJud5ZCoqcN1NaEe1Tl7y3pFtidGOldL+nKDQC5oX9uX47nsVDLvvtuoLx2cIi/zCM5CP3Vu+b0x0uIJ/b1kiIw6jgnTcxKIpo4J6W8SQOUR4GJTp42+IqmXjoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484844; c=relaxed/simple;
	bh=hXHSsZAB6Q/oFdRH23+ll2sKA2yCwCgHtspp14zdNIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fcm0xL3belpS5rJAL+7XTzP/uqjOzOalmZRlgmt3iojAvAdgL4nTfgKR8UsfwlqydngTXk42b/BaNikVB0qiKyGbtM6ICNowXp/Zf1I9m5Z/UkZRIS+RIOTZohZpnwXYRa9PjZKZYsRvG5JNMTR22PnuVWVXiMEi1+uEBFymseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7AFD7340E37;
	Fri, 29 Aug 2025 16:27:18 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  x86@kernel.org,  Masami Hiramatsu <mhiramat@kernel.org>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Arnaldo
 Carvalho de Melo <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Andrii Nakryiko
 <andrii@kernel.org>,  Indu Bhagat <indu.bhagat@oracle.com>,  "Jose E.
 Marchesi" <jemarch@gnu.org>,  Beau Belgrave <beaub@linux.microsoft.com>,
  Jens Remus <jremus@linux.ibm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Florian Weimer <fweimer@redhat.com>,  Kees
 Cook <kees@kernel.org>,  Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
In-Reply-To: <F8A0C174-F51B-40A4-8DC5-C75B8706BE74@gmail.com>
Organization: Gentoo
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
	<20250828165139.15a74511@batman.local.home>
	<F8A0C174-F51B-40A4-8DC5-C75B8706BE74@gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Fri, 29 Aug 2025 17:27:15 +0100
Message-ID: <87349adrfg.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> On August 28, 2025 5:51:39 PM GMT-03:00, Steven Rostedt <rostedt@kernel.org> wrote:
>>On Thu, 28 Aug 2025 17:27:37 -0300
>>Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>>
>>> >I would love to have a hash to use. The next patch does the mapping
>>> >of the inode numbers to their path name. It can  
>>> 
>>> The path name is a nice to have detail, but a content based hash is
>>> what we want, no?
>>> 
>>> Tracing/profiling has to be about contents of files later used for
>>> analysis, and filenames provide no guarantee about that.
>>
>>I could add the build id to the inode_cache as well (which I'll rename
>>to file_cache).
>>
>>Thus, the user stack trace will just have the offset and a hash value
>>that will be match the output of the file_cache event which will have
>>the path name and a build id (if one exists).
>>
>>Would that work?
>
> Probably.
>
> This "if it is available" question is valid, but since 2016 it's is more of a "did developers disabled it explicitly?"
>
> If my "googling" isn't wrong, GNU LD defaults to generating a build ID in ELF images since 2011 and clang's companion since 2016.

GNU ld doesn't ever default to generating build IDs, and I don't *think*
LLVM does either (either in Clang, or LLD).

GCC, on the other hand, has a configure arg to control this, but it's
default-off. Clang generally prefers to have defaults like this done via
user/sysadmin specified configuration files rather than adding
build-time configure flags.

Now, is it a reasonable ask to say "we require build IDs for this
feature"? Yeah, it probably is, but it's not default-on right now, and
indeed we in Gentoo aren't using them yet (but I'm working on enabling
them).

>
> So making it even more available than what the BPF guys did long ago
> and perf piggybacked on at some point, by having it cached, on
> request?, in some 20 bytes alignment hole in task_struct that would be
> only used when profiling/tracing may be amenable.

thanks,
sam

