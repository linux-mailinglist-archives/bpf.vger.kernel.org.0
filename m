Return-Path: <bpf+bounces-67014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC669B3C162
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DCC1897557
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E433A031;
	Fri, 29 Aug 2025 16:57:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589A3081BE;
	Fri, 29 Aug 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486664; cv=none; b=peXNPblJorjAUBfLtFVo+xUrCFUwRZ6t9eSgW+cr+9KsE/efo3UPAKipnJBVFeHEFhDgyGkJX/aD1A6YOp3pyPH+H0UOZmSJ3cJxHg76UFwMWS2UgWdb1tE4h3CI3pQK/C+LjM8yKVEfWj3J5fya3x353mh+GzpT1dC2LvcxA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486664; c=relaxed/simple;
	bh=B31eEimj8OTYKu7/EvM1IRu8gUQcEs3P1Hpgf4B8wMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PldBEs6IzYMeJhQK/07vVRoTQE++FnfyzrD4DduH+RGwGZsOq+av3bj8Ip3/SdR2sqXuk7c16JvQ4NCkleb5IskLLGlizDwIBkeBFuHSFP6nbmYuYxJSe7E2s1Pxixf/TMahv0Z6Eq5dAbwxMdKSBVQju/34P+sVO30hH21KBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id CBF1DBB93A;
	Fri, 29 Aug 2025 16:57:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 984956000F;
	Fri, 29 Aug 2025 16:57:33 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:57:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250829125756.2be2a3c3@gandalf.local.home>
In-Reply-To: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
	<20250829123321.63c9f525@gandalf.local.home>
	<CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 18jykodge4m1t8y9iu4ci1anjgx8bi38
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 984956000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1801hL3r63Hi0MBtC7pDdEvK0YgZ9zEiac=
X-HE-Tag: 1756486653-638081
X-HE-Meta: U2FsdGVkX1/sCw8yIWzmnLshxirkyw2IcJV/SeAn8Hga1OXlAU7UEAxvJMnS2DybjyIECYf9cIpKtlQ3hcI9F7+f6ZcoqCukuPup6DhaHzQzd0Z7hImnUfk//XjJHxwPqSsmDiEEo/tKK3eP5g3Fbp1ijDC1hdlnCUfGYtCsrwGV3KLb2WJ7TwwFiUTq0ZpOAGgci+0vkE8Eh12cSxnr6QyO6jpK60Wz4OH1rtPyrU/rWns0xQrsPAJDk5daN0T1j+BRD7jPa0DS8y23njgh3a1EUbTeuebNqQbCtkrrvYfHnKp80NCKOLxMCI7CcyIrYB315qsvBm3ehrMVN25RDcJmQm2GpWKASfKTIGiVjRLAnn6G1SYq9boBtT1nwwikNEfZ5fX9t0x3pRFAef+ssIR0hVeLCK2bQxfeLdVL0Nv6c5OM6IKxOLEQRZ2qVXRG

On Fri, 29 Aug 2025 09:42:03 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 09:33, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I just realized that I'm using the rhashtable as an "does this hash exist".  
> 
> The question is still *why*?

The reason is to keep from triggering the event that records the pathname
for every look up.

> 
> SO JUST USE THE NUMBERS, for chissake! Don't make them mean anything.
> Don't try to think they mean something.
> 
> The *reason* I htink hashing 'struct file *' is better than the
> alternative is exactly that it *cannot* mean anything. It will get
> re-used quite actively, even when nobody actually changes any of the
> files. So you are forced to deal with this correctly, even though you
> seem to be fighting dealing with it correctly tooth and nail.
> 
> And at no point have you explained why you can't just treat it as
> meaningless numbers. The patch that started this all did exactly that.
> It just used the *wrong* numbers, and I pointed out why they were
> wrong, and why you shouldn't use those numbers.

I agree. The hash I showed last time was just using the pointers. The hash
itself is meaningless and is useless by itself. The only thing the hash is
doing is to be an identifier in the stack trace so that the path name and
buildid don't need to be generated and saved every time.

In my other email, I'm thinking of using the pid / vma->vm_start as a key
to know if the pathname needs to be printed again or not. Although, perhaps
if a task does a dlopen(), load some text and execute it, then a dlclose()
and another dlopen() and loads text, that this could break the assumption
that the vm_start is unique per file.

Just to clarify, the goal of this exercise is to avoid the work of creating
and generating the pathnames and buildids for every lookup / stacktrace.

Now maybe hashing the pathname isn't as expensive as I think it may be. And
just doing that could be "good enough".


-- Steve


