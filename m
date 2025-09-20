Return-Path: <bpf+bounces-69081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC853B8BCA5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F242CB66124
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5A1E9B1C;
	Sat, 20 Sep 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS6eI/FI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025E286A9;
	Sat, 20 Sep 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330033; cv=none; b=gw4gw4SzuxJE/jBjXEWFpxKJF3LoE5mztAVs9KadBPtrFJndQmvgckNZD8SQZtvOT0JQoRtzD85omtAVGio6jjx05JhXnTXOlhBjpz0m3BxhemWdsvAjb4OZDOXScjiyf/ghQE8h90RP7U23118m6OuX3mQ6luSJrtpO9YLyaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330033; c=relaxed/simple;
	bh=152V8ABtwHHLogh3lVMMKtEoSOaUdwb1Bwq6vDnjQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPbhUw5nwAhfEYY5GqQ2Qi/qCvLJ2pjebhR7GfvQvRnbAv4j4LSvyu2dS/crZBg4JRbJ5GUg1zfe7/TxegUDfm2uV/2iN0SeS5H3mI//LrZCwcXZe5paG007onGzh5nx/ihEnJVxYlpYeIwepPs35dOWEiEd3Z/DgD0Qdmhwa6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS6eI/FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D15EC4CEF0;
	Sat, 20 Sep 2025 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330033;
	bh=152V8ABtwHHLogh3lVMMKtEoSOaUdwb1Bwq6vDnjQJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lS6eI/FIk2sbh3fa9diFQxOFDsvm9zjkX1rboM2k4iklkn8jqM1ufFoTpfMwb/UMu
	 As+5nT/P03SrogGhQzn2lvIzK5vIaHQFohCwvSOvZ7gQ9s4gN/LhDirii8ObOvs4Wi
	 YikGN7E0LpoUJNJejAOl3+9fXwgL8fl9mb78atRsgx5e1/ia1BjrGJWb16KyGa/PC6
	 OALgNH2lF6Pl8yVgBb5fEapjBeJiFFphhvDPmBUJnZIOBw7VME/D4/mADaXq5if58j
	 dFux0TbdzjMcXFzKoB7vqlIDun6otOl5a6egA6L47tAdzQp4MH7OKaxJXeNuTO7m4C
	 cO7FeEtwP1g0Q==
Date: Fri, 19 Sep 2025 18:00:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v16 06/10] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <vxdnyz3e6c5whsd4let47ms75a7kcjykzud6x7d6pwkfd4yd2z@odddgxwsst4d>
References: <20250729182304.965835871@kernel.org>
 <20250729182405.822789300@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729182405.822789300@kernel.org>

On Tue, Jul 29, 2025 at 02:23:10PM -0400, Steven Rostedt wrote:
> @@ -212,32 +225,59 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  
>  	*cookie = get_cookie(info);
>  
> -	/* callback already pending? */
> -	pending = READ_ONCE(info->pending);
> -	if (pending)
> -		return 1;
> +	old = READ_ONCE(info->unwind_mask);
>  
> -	/* Claim the work unless an NMI just now swooped in to do so. */
> -	if (!try_cmpxchg(&info->pending, &pending, 1))
> +	/* Is this already queued or executed */
> +	if (old & bit)
>  		return 1;
>  
> +	/*
> +	 * This work's bit hasn't been set yet. Now set it with the PENDING
> +	 * bit and fetch the current value of unwind_mask. If ether the
> +	 * work's bit or PENDING was already set, then this is already queued
> +	 * to have a callback.
> +	 */
> +	bits = UNWIND_PENDING | bit;
> +	old = atomic_long_fetch_or(bits, (atomic_long_t *)&info->unwind_mask);
> +	if (old & bits) {
> +		/*
> +		 * If the work's bit was set, whatever set it had better
> +		 * have also set pending and queued a callback.
> +		 */
> +		WARN_ON_ONCE(!(old & UNWIND_PENDING));
> +		return old & bit;

Per the function comment, the function returns 0, 1, or negative.  So
this should be 

		return !!(old & bit)

right?

-- 
Josh

