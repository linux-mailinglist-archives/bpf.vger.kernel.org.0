Return-Path: <bpf+bounces-72151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE2C07D4A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 21:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95494189EB99
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E5348460;
	Fri, 24 Oct 2025 19:00:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA21DF99C;
	Fri, 24 Oct 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332453; cv=none; b=YGvlLmBQtrMDZvnwSO4rHp68V/p1COhJp2rrPXLfYVuMgLI5QU+F5UZc/qe90mO76iOpW+IfCTweXBUotRgstWPnRah588u+4W0H7VcTXtiCT7bLpUBLzfD1uMtCQdejiIyS80KZPWIP5WL5TrTXePpX1N6o+6P9fsCx001Yg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332453; c=relaxed/simple;
	bh=diM7Qgw1ej98nx/rDfikI9dHJMDBcaE3lkFoDDXW2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guiC1qj7o07N5FvpaXfct3zVIQA+LF9uas5jDpLxBTO7SSEufXnzbEgJvWWuFCOHJreNvnImn5P7fnNvYLY8v8YybCaVoNEa7fSSLtnXn4Hthe5F6hhACmVr6VtUHSh+0kOU3fuM8Ty/jBjpZH+5I/45WAXxl3/IYXQcXO2MYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E5BCBBE7B8;
	Fri, 24 Oct 2025 19:00:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id B3CC720027;
	Fri, 24 Oct 2025 19:00:16 +0000 (UTC)
Date: Fri, 24 Oct 2025 15:00:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 linux-mm@kvack.org, Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v11 08/15] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20251024150045.5fdbfb6a@gandalf.local.home>
In-Reply-To: <6b5c0c64-c4da-416d-a103-8d6ec2f06a9b@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
	<20251022144326.4082059-9-jremus@linux.ibm.com>
	<20251024134415.GD3245006@noisy.programming.kicks-ass.net>
	<6b5c0c64-c4da-416d-a103-8d6ec2f06a9b@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: meot9n4skde9zpjhbqgjtfhxopiebfpq
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B3CC720027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19iy0relq0hsycahgoTlXBcrmF8ZC/GxZs=
X-HE-Tag: 1761332416-792391
X-HE-Meta: U2FsdGVkX18ubh822JQukhagA4rmyZ/kfFZ5e9GBo5bHGmEcFo3R5wrw+1cNrkalDAZsGy1EymjeMHOvmc+qfcEJjivdvmslflP/cCPZQm6vsoqHmDNgexfeEZWDP3fXLN/3PWR7NOuwSKK9Dgp69k8l/ZOb651Lci4jwPdj/HqW0nSyCxXm45JJSvokANbRiozVvP6p37v+DWjDJYxDZh9Vsk2YPQV1DGwEadcGYfQqRu7D+3A+8InWOYOqM3h+/JyWlkB4A4hRNJfCKGE4D6FHEGWpSqrdzugRjEFxubyS8zE0ycnMrulBlS+Z11oaDq2dZpehUVm8XCFSDafwZRLq3La1yEcZ4SWdRJvmXpCTybXp00PcB8acZ6q4VqPJcltalzuk0eKEIgDzyXQ9b77CWyR88irNcuRIF7Ky2OQ=

On Fri, 24 Oct 2025 16:29:07 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> @Steven: Any idea why you added pt_regs?  Your v9 even had this other
> instance of unused pt_regs:
> 
> +static struct unwind_user_frame *get_fp_frame(struct pt_regs *regs)
> +{
> +	return &fp_frame;
> +}

According to the history:

  https://lore.kernel.org/linux-trace-kernel/20250717012848.927473176@kernel.org/

Which has:

  Changes since v8: https://lore.kernel.org/linux-trace-kernel/20250708021115.894007410@kernel.org/

  - Rebased on the changes by Mathieu in the kernel/unwind/user.c file
    https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/

It looks like it came in from Mathieu's updates, which was trying to deal
with compat. But then after noticing that compat wasn't working on my tests
boxes, I removed it. The removal failed to notice that regs is now unused.

-- Steve

