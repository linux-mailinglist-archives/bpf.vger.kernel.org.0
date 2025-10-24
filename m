Return-Path: <bpf+bounces-72116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B639C06E27
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F01C012C4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AE2580E4;
	Fri, 24 Oct 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzOfcxMC"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29D322551;
	Fri, 24 Oct 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318712; cv=none; b=Ki6ci6yiP0j9DzWSNlSSXA74LAf7hfRv1qdw5q3AD1f3K7An4FfxqCaM9iepJYcehSWIHZlvYuOfvPsNED0dqUPP4jsAcx0s/bmuy3R0pAPMzttmF5ggY3jLyxAb10zGsgXSyFfueIE49G3gg9uL2bUdV7USf/HR33ZkFBk0UIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318712; c=relaxed/simple;
	bh=BuhRwQqOn185L9Koztwo8r5hvZsRb998u1ud/oZS1oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgEJZ1x/uZbEMLAO0M4pBqa2fNKe9ivwVfB5ic4c33a8HhOn8VH6aYi6S32Rb9iIwdZ7iwNoNefRZpTyZnXKi0cgwtVzwKZ/lXqO2sj5FPP18ANKBaA9QkN1BWPaAVquWunKGnLSdLR5wcrSPU7+XwMmQdI/8wvw0c4iBWWv4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzOfcxMC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CxG4CHyBweo14i/zFzydr1W9oDxtD1iA/8RO4G7wS9w=; b=RzOfcxMCFeRC5nVW1X9wbSqUYv
	Js8bryWUMXJT+NS+1Ur3Q+b19Cg/4X8cUVYBRU1l9S6qs7Bkcm62sg5zulM2eSx/HKyPhI6u7iFN4
	F1vLB5FW4//QMYMWOmE7Ytx4pV8pO8yKtr14WKbVsMC+WqP2QPBf+9MRXlXHbu2j6Dh/hFPp2msFr
	OCQAm0lnZ3oxx7P/mtCDyPCyENuTkAn3/hPM74OE5eWOIuDrUWAe2mL4ZWs05Av1KOpxwnt8q5thn
	5mYtFGGlOo8NPA+7rxcSDqm4LsCZAK0XGChHNCVDkOhcTRi4kyGgMehyqxOA3+0y3nzc9k9ejoSIF
	sqeKyKjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCJS9-00000003YjT-23c5;
	Fri, 24 Oct 2025 15:11:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4BB43300323; Fri, 24 Oct 2025 17:11:42 +0200 (CEST)
Date: Fri, 24 Oct 2025 17:11:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024151142.GF3245006@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
 <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
 <acacc4b6-9f4a-48f0-9660-035f0ed4b0fd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acacc4b6-9f4a-48f0-9660-035f0ed4b0fd@linux.ibm.com>

On Fri, Oct 24, 2025 at 05:09:02PM +0200, Jens Remus wrote:
> Hello Peter,
> 
> very nice!
> 
> On 10/24/2025 4:51 PM, Peter Zijlstra wrote:
> 
> > Subject: unwind_user/x86: Teach FP unwind about start of function
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri Oct 24 12:31:10 CEST 2025
> > 
> > When userspace is interrupted at the start of a function, before we
> > get a chance to complete the frame, unwind will miss one caller.
> > 
> > X86 has a uprobe specific fixup for this, add bits to the generic
> > unwinder to support this.
> > 
> > Suggested-by: Jens Remus <jremus@linux.ibm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> > +++ b/kernel/unwind/user.c
> 
> > +static int unwind_user_next_fp(struct unwind_user_state *state)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +
> > +	const struct unwind_user_frame fp_frame = {
> > +		ARCH_INIT_USER_FP_FRAME(state->ws)
> > +	};
> > +	const struct unwind_user_frame fp_entry_frame = {
> > +		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
> > +	};
> > +
> > +	if (state->topmost && unwind_user_at_function_start(regs))
> > +		return unwind_user_next_common(state, &fp_entry_frame);
> 
> IIUC this will cause kernel/unwind/user.c to fail compile on
> architectures that will support HAVE_UNWIND_USER_SFRAME but not
> HAVE_UNWIND_USER_FP (such as s390), and thus do not need to implement
> unwind_user_at_function_start().
> 
> Either s390 would need to supply a dummy unwind_user_at_function_start()
> or the unwind user sframe series needs to address this and supply
> a dummy one if FP is not enabled, so that the code compiles with only
> SFRAME enabled.
> 
> What do you think?

I'll make it conditional on HAVE_UNWIND_USER_FP -- but tomorrow or so.

