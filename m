Return-Path: <bpf+bounces-64095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5048B0E402
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891321895F8B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009C283FDE;
	Tue, 22 Jul 2025 19:18:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30DA17C224;
	Tue, 22 Jul 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211896; cv=none; b=r2nGx8lhAThD5UcxjJ1LsYvQzDyrOzU6fX5qJAm2mqArhd2kkjcKHQv7ApYzxo03BZ8LJPaAOZENoMWcK2ikcfTLjQ4NaYJLKRQ0Im2VKrU363grVI+iFBoEuvcyrYfYtIVGZ4knBV8w39NuqMzMKNUNYrnKgTI9g1NcjFCRL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211896; c=relaxed/simple;
	bh=9R6Ax9GxruuQjRfCABR/xn3kzf0bjrP5zgk181FzYXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7AU/77YFkt+xfej9w4gU8weTHNY1fug4jQB4/gdoNxRjhPhTgTu/a0h5JseUQRuMMnEaDklSOjnqhFIQkofhgubDFVmyYeEfAvy4A1mLQfszrExvEVNsFOs1j/7rvuiTLmXJojhaUJykSjlIGgLscbOO4Xx2IgvKbPmj66oztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D46E2804FF;
	Tue, 22 Jul 2025 19:18:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id D1A2A60011;
	Tue, 22 Jul 2025 19:18:00 +0000 (UTC)
Date: Tue, 22 Jul 2025 15:17:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Beau Belgrave <beaub@linux.microsoft.com>, Jens
 Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-ID: <20250722151759.616bd551@batman.local.home>
In-Reply-To: <87jz40hx5c.fsf@gnu.org>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
	<20250721145343.5d9b0f80@gandalf.local.home>
	<e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
	<20250721171559.53ea892f@gandalf.local.home>
	<1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
	<20250722122538.6ce25ca2@batman.local.home>
	<87jz40hx5c.fsf@gnu.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D1A2A60011
X-Stat-Signature: ybsyzp1dr8cb6ziks7idajrbc9gw9gzx
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1979V1hD2x9nTSMk+tj+8Oc7hlb+oyCHjQ=
X-HE-Tag: 1753211880-344321
X-HE-Meta: U2FsdGVkX1+dUvzKuwYx+6/w3W9bHUQsFKKf9bOQxhmxbU3BIJvAmm9SMNfnMGL2ZS/extKenm9CxsxeotXsVGrgn75e0b7YdYcKTzmNexkzqSV68BuTWmh/TnDzTQrTtD+/G0MX1Klou5nM1AFtEU28hf8mpdSc/3BVTOpImg9R7hWmtU7ZcTilXzPXmFqhhBFTE1s1jmq/3cENJMpUO0S/PjSy1jtoECRx4eZoC0zzGBR+Pp/P9spUMgEit9DpEXOp1s+Bt2JifOwQ6qabmnBLNg9okGNBOvw6xZwfhTxUpPNINOdUKFgln4Guzzism+iUPq+re/fpE+Kp804AmibZrq0O/YJM

On Tue, 22 Jul 2025 20:56:47 +0200
"Jose E. Marchesi" <jemarch@gnu.org> wrote:

> I think glibc could "register" loaded SFrame data by just pointing the
> kernel to the VM address where it got loaded, "you got some SFrame
> there".  Starting from that address it is then possible to find the
> referred code locations just by applying the offsets, without needing
> any additional information nor ELF foobar...
> 
> Or thats how I understand it.  Indu will undoubtly correct me if I am
> wrong 8-)

Maybe I'm wrong, but if you know where the text is loaded (the final
location it is in memory), it is possible to figure out the relocations
in the sframe section.

> 
> > In the future, if we wants to compress the sframe section, it will not
> > even be a loadable ELF section. But the system call can tell the
> > kernel: "there's a sframe compressed section at this offset/size in
> > this file" for this text address range and then the kernel will do the
> > rest.  
> 
> I think supporting compressed SFrame will probably require to do some
> sort of relocation of the offsets in the uncompressed data, depending on
> where the uncompressed data will get eventually loaded.

Assuming that all the text is at a given offset, would that be enough
to fill in the blanks?

As the text would have already been linked into memory before the
system call is made. If this is not the case, then we definitely need
the linker to load the sframe into memory before it does the system
call, and just give the kernel that address.

-- Steve

