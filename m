Return-Path: <bpf+bounces-67061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F3B3CEAE
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB96178167
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5BD2D8381;
	Sat, 30 Aug 2025 18:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80701E3DF8;
	Sat, 30 Aug 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756578693; cv=none; b=nylP80Ya1NdDnz6poTY6LMwffSL2Y3aYwAVApbgTZIWK9dFUcIN1UyOIhdhdvJdf1lK4UmuH6vkrvixHS1ezkJ0AEtM7XTuWFnN9ETbhG08AROtdlNgeGOnu62SAfSV59zad5LsRZQn7Nxnms3eCPPbCQ9C6rWV2Rj5ujtr/iJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756578693; c=relaxed/simple;
	bh=h9s6lq5iWu0Uxgc5pGQipjyw7vKquKkQMSJ+qcO28b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwM8ijtNLVZna2SvA38VPx6hl65GbRdTfCD7hknSdb6Z/yfhtRjPWioO5bjmZT4RXZcd55n7XYVtKy8qdmQ1Js2xef+30ndc/XGWkCvrBsJlplTjWw3OBqnxRwUv+8asaDS/58VFm33mVZVutlUPOFJl8DekfBPjS/42fBk7pAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DF1DA5792F;
	Sat, 30 Aug 2025 18:31:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 2630A6000C;
	Sat, 30 Aug 2025 18:31:16 +0000 (UTC)
Date: Sat, 30 Aug 2025 14:31:14 -0400
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
Message-ID: <20250830143114.395ed246@batman.local.home>
In-Reply-To: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828171748.07681a63@batman.local.home>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dkx6cr1863tdyr5dwpt5ckwrppidbxnn
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2630A6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WYX6tr/gPCLPBNV9cVUMslGrPAuQfGGI=
X-HE-Tag: 1756578676-55030
X-HE-Meta: U2FsdGVkX19XhVDsGgxPqnETmIKyPhWYVZOiIMrpYo75HbTYXBUckcEq91+PibmjNrdUChgztxVBITq5gIDJiZsVzxyHOW1c7Ao38pMYqbOe1gEd6w1TxA44k5zT/CBlImW+GYdOaF54NiWP8v4wLnyB0hInm1XncgCpNCSC9jiNoZ8bbM4qdbGme1iOEMuAb90vDxpAx/T5BI3RNrBLrcmwqccBSJ4Knm/S7fRoS6PEnrfTj7sZmgLgkT211zZpvd2z8MLvcd2gguBeQsYB3uj38ntcaO+Zkc3+GF35KgBDlBZjQigyb4V7nJF1nXCTz2SS+HUWNLN7JDKMv7MlR/pMB/hSHcX7kq17uiEvTyT4XIw+flvkXltxUreC0sQe

On Fri, 29 Aug 2025 17:45:39 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But what it does *NOT* need is munmap() events.
> 
> What it does *NOT* need is translating each hash value for each entry
> by the kernel, when whoever treads the file can just remember and
> re-create it in user space.

If we are going to rely on mmap, then we might as well get rid of the
vma_lookup() altogether. The mmap event will have the mapping of the
file to the actual virtual address.

If we add a tracepoint at mmap that records the path and the address as
well as the permissions of the mapping, then the tracer could then
trace only those addresses that are executable.

To handle missed events, on start of tracing, trigger the mmap event
for every currently running tasks for their executable sections, and
that will allow the tracer to see where the files are mapped.

After that, the stack traces can go back to just showing the virtual
addresses of the user space stack without doing anything else. Let the
trace map the tasks memory to all the mmaps that happened and translate
it that way.

The downside is that there may be a lot of information to record. But
the tracer could choose which task maps to trace via filters and if it's
tracing all tasks, it just needs to make sure its buffer is big enough.

-- Steve

