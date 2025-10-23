Return-Path: <bpf+bounces-71930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB11C01C02
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB236506276
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E8B32B994;
	Thu, 23 Oct 2025 14:23:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33830E0FC;
	Thu, 23 Oct 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229412; cv=none; b=ReL1aUbEW8QewtPpvJRB7DWHRHiju23FjTf1FTig37rgxS59/xprThVPMkYt+s8K+Ve21TMS3w0ZavPKeSt3mQ0vdIwoPocRffhYBjZ+m1+Vg/L6rRyeJ+sxWUIkx5An7IXspOQb8tV4wyUl3K9RgPvAeWLlqkSCyWGqqj4mQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229412; c=relaxed/simple;
	bh=9XPfcex3hX8Yq51hvEdZq8mkmLnOVqxEUgFWlRSCmx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2aiZpRjGk+Wfl8WvJUHh6X80JZZqLuWpdI6Wt7/NCS4pYtIjAux6NwZ/rtTDeVsBGyn8fm6+lMEbqnGmHoevxytdF852bJgU0AG6gkNNLSG6VBIG/XBT/8w5FWRnmqlq6IdQJqjx4pbCFBti6Ryt+pRYv051Rwce5+alAr9Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B8138129BC6;
	Thu, 23 Oct 2025 14:23:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5E7336000B;
	Thu, 23 Oct 2025 14:23:06 +0000 (UTC)
Date: Thu, 23 Oct 2025 10:23:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fangrui Song <maskray@sourceware.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 linux-mm@kvack.org, Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook
 <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>, Sam James
 <sam@gentoo.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v11 00/15] unwind_deferred: Implement sframe handling
Message-ID: <20251023102332.7b7f1241@gandalf.local.home>
In-Reply-To: <mzqhpduikzpeczmmxh5uyfzjpvdeae3ityqyp2rno4myujzb6y@ey346eksvoyf>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
	<mzqhpduikzpeczmmxh5uyfzjpvdeae3ityqyp2rno4myujzb6y@ey346eksvoyf>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5E7336000B
X-Stat-Signature: ywywgk4jin8a8ru9j8rnqecapusdnye7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/B9JQTNbR4QP1SUw0zmZnqU0dFZXkG9bs=
X-HE-Tag: 1761229386-657495
X-HE-Meta: U2FsdGVkX18AsgT3wUjnPBgCWRK1PjrNucH0m2er7H8Y7F02PT+qJ2ECLo7Ib0sBuZv2V/AmogulDS/KBAtvdQqooEV2x+ikzFX8qozMGkU5h5Gbl6z6BdLKTPXIEyrlcddrSO0JS/kivrcu3ukW3wJCaBEJM4Eo7yrui2JrnbZKctgvKboz+o96sHa1VryuzA5CUCC/TZnERfu3DVdozVgG05orV2OIYN67RfaDv8zGwXhTK7WLAc3E9+eN30bv/znwWjVdTYHX6md1vdHUhP/iIRhBaotU4mG1COOyBpbdua7yyMUz0Qc0ArxE4BKxPX4foEDDQHm/Mng95sJXPt6Z4Tqf/bJDVTm4YcVvPsJ2Xb3G36C9IxxdWR9N5lOkbC398iuadGedSQUziFjuEasHxohtdqk6Rd7+m49RUfHPGb10X4nAqG4b9GaSpwiC7KBsfXAHBWyaQHTGd9xMIw==

On Thu, 23 Oct 2025 01:09:02 -0700
Fangrui Song <maskray@sourceware.org> wrote:

> Please consider dropping the statement, "soon will also be supported by LLVM."
> Speaking as LLVM's MC, lld/ELF, and binary utilities maintainer, I have
> significant concerns about the v2 format, specifically its apparent
> disregard for standard ELF and linker conventions
> (https://maskray.me/blog/2025-09-28-remarks-on-sframe#linking-and-execution-views)

Please note, v2 can be dropped entirely. There's no plans to have the Linux
kernel ship with v2. The patches for v2 for the Linux kernel are for
testing purposes only (which was what help find the issues with v2).

The plan is to have v3 be the first versions supported by an official
release of the Linux kernel with the assumptions that changes after v3 will
be minimal.

The reason there was such a big difference between v2 and v3 is because v2
was the first version to have a consumer try to use it in a more production
like environment. This found several corner cases that needed to be
addressed, and that the current layout of v2 was not acceptable.

No linker needs to support v2 as there will be no consumers of it.

-- Steve

