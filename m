Return-Path: <bpf+bounces-72099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F175C068F7
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABCF3B022A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73331D75F;
	Fri, 24 Oct 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KHRd6md2"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAD2F83D2;
	Fri, 24 Oct 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313478; cv=none; b=QFf0Vnef0mF4iBSNaJJix+QMmWbY26wt2e0UZeh5eESRzJUCmPkDF/JuQnSUowtHwYZ4FsHSVX8lb0xjLW6DPpPX33No+1Kgk/9bQHCS360ossr+/KKzpVe9kBObi/ETHC/qRk9gAmy3hJ1wmBVCVIzRkk87p+Gm9PAUjZpIaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313478; c=relaxed/simple;
	bh=F/p6ZO4UJcB+L6rsMxVdDJvv5GUBx34XWCIi8m4T6H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZoLKIjfnBO5kwEpnjmzCqvR3GpLPsHXC2wgRwIKYwf1twIzFjRM+9pLT2qKBm9+zsc+81CMj454RpZ4CVzhZVnow8m06l2XxnsR9ZDmthCzdP9tilZOIiTbIs4zXb1L9LhauI3UWUHZLlwjUWQbY/BrMg7s7WpS6/xA70nRoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KHRd6md2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ffcj2jilQV0mH7721aCemvuNywIj+ADnf9rulKDQShk=; b=KHRd6md2YVWeoXFeMmOWjQOBva
	hh98PWr8MR1nG8zt+X/s6pNq8xiLExucjDp3JcN4aiatOzqJUNgvQ/KXmFQ7o8aCO6EU/gzmFHN4J
	Be0zoP4ogk+i21sdK+niWsL0z7p50enlf4qEG8yQCXJHbDN6kAk7dVQfgziqyu7kPRpTlSqQt9E9Q
	wGRNbOnpdhRIV1kmPH+hE+l9at4KY/wj1129/zMzH6nu0h3oFQ4glOQsKZgjAfDc4E3WoD9po659j
	UNyIyGukE3AA/jCEbu384/JafPxkcxYI90Efy8nuNuLJoyK5IFbaVDRSf0vI4xv8IYuGNSSqNPKgb
	J0+2JBww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCI5W-00000001uJu-3O11;
	Fri, 24 Oct 2025 13:44:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A030300323; Fri, 24 Oct 2025 15:44:15 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:44:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	Steven Rostedt <rostedt@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v11 08/15] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20251024134415.GD3245006@noisy.programming.kicks-ass.net>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
 <20251022144326.4082059-9-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022144326.4082059-9-jremus@linux.ibm.com>

On Wed, Oct 22, 2025 at 04:43:19PM +0200, Jens Remus wrote:

> @@ -26,12 +27,10 @@ get_user_word(unsigned long *word, unsigned long base, int off, unsigned int ws)
>  	return get_user(*word, addr);
>  }
>  
> -static int unwind_user_next_fp(struct unwind_user_state *state)
> +static int unwind_user_next_common(struct unwind_user_state *state,
> +				   const struct unwind_user_frame *frame,
> +				   struct pt_regs *regs)
>  {

What is pt_regs for? AFAICT it isn't actually used in any of the
following patches.

> -	const struct unwind_user_frame fp_frame = {
> -		ARCH_INIT_USER_FP_FRAME(state->ws)
> -	};
> -	const struct unwind_user_frame *frame = &fp_frame;
>  	unsigned long cfa, fp, ra;
>  
>  	if (frame->use_fp) {
> @@ -67,6 +66,26 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
>  	return 0;
>  }
>  
> +static int unwind_user_next_sframe(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame _frame, *frame;
> +
> +	/* sframe expects the frame to be local storage */
> +	frame = &_frame;
> +	if (sframe_find(state->ip, frame))
> +		return -ENOENT;
> +	return unwind_user_next_common(state, frame, task_pt_regs(current));
> +}

Would it not be simpler to write:

static int unwind_user_next_sframe(struct unwind_user_state *state)
{
	struct unwind_user_frame frame;

	/* sframe expects the frame to be local storage */
	if (sframe_find(state->ip, &frame))
		return -ENOENT;
	return unwind_user_next_common(state, &frame, task_pt_regs(current));
}

hmm?

> +static int unwind_user_next_fp(struct unwind_user_state *state)
> +{
> +	const struct unwind_user_frame fp_frame = {
> +		ARCH_INIT_USER_FP_FRAME(state->ws)
> +	};
> +
> +	return unwind_user_next_common(state, &fp_frame, task_pt_regs(current));
> +}
> +
>  static int unwind_user_next(struct unwind_user_state *state)
>  {
>  	unsigned long iter_mask = state->available_types;
> @@ -80,6 +99,16 @@ static int unwind_user_next(struct unwind_user_state *state)
>  
>  		state->current_type = type;
>  		switch (type) {
> +		case UNWIND_USER_TYPE_SFRAME:
> +			switch (unwind_user_next_sframe(state)) {
> +			case 0:
> +				return 0;
> +			case -ENOENT:
> +				continue;	/* Try next method. */
> +			default:
> +				state->done = true;
> +			}
> +			break;

Should it remove SFRAME from state->available_types at this point?

