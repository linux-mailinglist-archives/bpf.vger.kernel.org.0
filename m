Return-Path: <bpf+bounces-67055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC5B3C717
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18156207D4F
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DE2236FA;
	Sat, 30 Aug 2025 01:25:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AF3C33;
	Sat, 30 Aug 2025 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517152; cv=none; b=tdApICa6c21c8X1hqbEJ7z8pr+U04k0MeGS73I1nlxn5XMAXbXXSvJI4x4tanuywSIe085yeby3ntxmhs67awc8MsKX8SsftCAYSKhc0Qj5ZsWcu07bexZn/O5vfg3VHpBGECQazzflOHnjdp1s7axfqYAKHHogs/4nR/qIRlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517152; c=relaxed/simple;
	bh=aQfMa7G8xSMpwFrU9h8/JS2wva8i/q2sArpym3zZluI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7VeXe9GCsNsBO6er9ttEc6UkradYJ+wD5/PPci51htgOimF73XGwchvJeInII0rdeHaaWp/BKDGQSlpj9kOGdhDIinPEVFA4zeO5j0dWGFKBjRfCBYHTRdRev1X/QkY5l4cXEtDTM5oLJwuqxQIEcPRsJBmBRbw9vqqBhykfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 172A613ACBE;
	Sat, 30 Aug 2025 01:25:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E042F2000E;
	Sat, 30 Aug 2025 01:25:41 +0000 (UTC)
Date: Fri, 29 Aug 2025 21:26:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250829212605.445e1479@gandalf.local.home>
In-Reply-To: <20250829212023.4ab9506f@gandalf.local.home>
References: <20250828180300.591225320@kernel.org>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<20250829121900.0e79673c@gandalf.local.home>
	<CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
	<20250829124922.6826cfe6@gandalf.local.home>
	<CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
	<6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
	<CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
	<20250829141142.3ffc8111@gandalf.local.home>
	<CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
	<20250829171855.64f2cbfc@gandalf.local.home>
	<CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
	<20250829190935.7e014820@gandalf.local.home>
	<CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
	<20250829212023.4ab9506f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E042F2000E
X-Stat-Signature: p96rn3iquaawkxjothy37xu4s1xjpczj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+MiEqrAYBwDRHk7XtPOHKUXUWRtT2lBTA=
X-HE-Tag: 1756517141-622699
X-HE-Meta: U2FsdGVkX18XdQHVzdi5IJHrLJr+zTe1edsim9VGa7GrXpnPXGndCYwFdLFmXWnDDCkMD6Hu+g2C6VTyhqEJPVL66Oxj08WcZVP/wngTqUz66NLXCZuJ/AxtejyOt3HUXYr2WQeUh23p6pynBSTDsOOkxVGlKSCEBGj/PbddJvtn3zmUeMJ9SrkgUQqlvl++6DLMpVDNAQzS0ywOqeFFYw4mN1/DIs/AfKuDBKFi0DVJMPhmuyfmky3qUzUUBoyX8KvbzBBF2r8NU2sBSun7P2re1IbqDUFcTJrgZzbzSOlzzG9PQUcDrzoePRWAWpSsw+ZJEeBLK11Q6p6MkWHmVgoZq3RqNx2GlLupjuTdPICSB2iu/x6d8W8fhryIqMmx

On Fri, 29 Aug 2025 21:20:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I'm done arguing. You're not listening, so I'll just let you know that  
> 
> I am listening. I'm just not understanding you.

BTW, I'm not arguing with you. I'm really trying hard to figure out what it
is that you want me to do. I'm looking for that "don't use dentry outside
of VFS" moment.

I get we have in the call stack the offsets of the file and a magical hash
value that represents that vma.

What I don't get is what is user space suppose to match that magical hash
value to?

Do you want me to trace all mmaps and trigger an event for them that show
the hash value and the path names?

If that's the case, what do I do about the major use case of tracing an
application after it has mapped all it's memory to files?

What about wasted ring buffer space for recording every mmap when the
majority of them will not be used. It could risk dropping events of the
mmaps we care about.

Again, I'm not arguing with you. I'm trying to figure out what you are
suggesting.

-- Steve

