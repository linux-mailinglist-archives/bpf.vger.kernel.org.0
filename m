Return-Path: <bpf+bounces-60931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3DADEE74
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0563A6A10
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD52EA75D;
	Wed, 18 Jun 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsYn2KSG"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC2295DA6;
	Wed, 18 Jun 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254733; cv=none; b=pzMdOvuVuWehO0lUwCEAYvK1VKYzGXfiUPKnu2jQdpZSwwBpb7C7a+viealpuxlf/A9APTQvYEzwnpsZDSJ8dgd4UhR7q3JGnBPQIN3sNNiPBy6f/RZbzi/HYwJDlSNghe8HMoN4LLNcBliv9P2RUDd6Um5XLQYuTrWUVPBR1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254733; c=relaxed/simple;
	bh=PbtqtR9wSZ7aEx4EBBSExsFB5cqIvCI/kkLHCNFRZeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDnu+8q9+s7LyKqp3of3TJO9GHINRLLN1V1F/qAJBa2uzMOOX+HGG/iVjoU4bl7FRJdtoBKmAliaHOCnSHROoE8GBbSrmdOPBKpbdUE0T0rQxpSPifWfaPkJct9CnZQxM9y4/wyQULO6jphlIrKy+JKkHmNL0rRuCqpMcRsu28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OsYn2KSG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ugwPy802X+iE+6YxHrNntByNdapgPsPvV86x0LfrY4A=; b=OsYn2KSGjD0cGQAf5+sLld2wem
	OfS0mkYTU0yX2iHiL18VDvQV5EEU3cc6xJEoKrLelOeHABcDy8GyG40il30npPnJVB9Wt7b5x5HI6
	ka7bxb66FNBbxGpqUQ6xsXR77TFqFdYgMXAqVbLRGXLLWyZ7htjV7xqU9/be0IVpfM3kckYyGD7Sh
	QvSO/IvVoEk3O4lVzY8DSvT8KN0IekigR1OfZtjldAA6TBdzwreP7m/lf+9iIeaT70fL+wWX9T58G
	idLoCZVpB31uUA0UIZm3nRx4vbcbNPhlQRjM1NWTmUClOnKeSP9RjwRQJtoJ4q22jRpyR2MckNTj/
	S8idV7pw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtCt-000000044Ux-0Y0f;
	Wed, 18 Jun 2025 13:52:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 116A9307FB7; Wed, 18 Jun 2025 15:52:01 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:52:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 02/14] unwind_user: Add frame pointer support
Message-ID: <20250618135201.GM1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.092934995@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.092934995@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:23PM -0400, Steven Rostedt wrote:
>  int unwind_user_next(struct unwind_user_state *state)
>  {
> +	struct unwind_user_frame *frame;
> +	unsigned long cfa = 0, fp, ra = 0;
> +
> +	if (state->done)
> +		return -EINVAL;
> +
> +	if (fp_state(state))
> +		frame = &fp_frame;
> +	else
> +		goto the_end;
> +
> +	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
> +
> +	/* stack going in wrong direction? */
> +	if (cfa <= state->sp)
> +		goto the_end;
> +
> +	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +		goto the_end;
> +
> +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +		goto the_end;
> +
> +	state->ip = ra;
> +	state->sp = cfa;
> +	if (frame->fp_off)
> +		state->fp = fp;
> +
> +	return 0;
> +
> +the_end:
> +	state->done = true;
>  	return -EINVAL;
>  }

I'm thinking 'the_end' might be better named 'done' ?

Also, CFA here is Call-Frame-Address and RA Return-Address ?

