Return-Path: <bpf+bounces-69030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39240B8BB1F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42B17A7C5E
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7D1DED63;
	Sat, 20 Sep 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohY8jiEk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773391531C8;
	Sat, 20 Sep 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328278; cv=none; b=fnAbg+6vDiriByaUtFxMIav0qJgLcFw8BEG8RnRMjmNsi8AwFdq8BF9g3sOffOw0v/6WGm7X+vWC4rFR1SShJz+tl7GqvvTbk1FXxS4WARfRAgmKbnXr5kmnZftTvORhFFke+TcInyowVLy4xzyZu5MMcRnn+ewiD97W2COEHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328278; c=relaxed/simple;
	bh=fUw84tVM4i1ZERTTuH1ul7cyXtQ5Hh5nFu/eE5XWjFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIOPR0kILjBkZrxYJMTRvZwZxGJkl1GZUCFlgQmLTkIaMK1J+LkTzUw44qOBmfqdYlhNodPubgrp4+aCD7juPvYnHbYSkU3UYR86+u72xtH7aonzDHG81uU2ekOdof4gvI5FpJAPFGfSbLNLnOmUwT+91zJ7E7KEiDfW3JngyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohY8jiEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B73C4CEF0;
	Sat, 20 Sep 2025 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758328278;
	bh=fUw84tVM4i1ZERTTuH1ul7cyXtQ5Hh5nFu/eE5XWjFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohY8jiEkbSerfUbZ79tr5XVVsrQxi88iOiqvfQG+iARi761s0qb/++uEB3AL+utou
	 cY4j1ONAQ8OuT4Snjcgw0J2UYvucz9RocBcrhbpUle8hldhbSarVDo3MzUYBmmWcvV
	 z23QlbpfYHo10KFWXFs907bfma3m3e9aMB4Xsr6iqoMiNi0SdhH0zvE1vg6pbdgWQr
	 bTBegq5wMdmbB96WalBCHHH96dRefuLNnjcbuAC3Yn3ATkJ248WtmC0acqs9bDAcdE
	 KBAWC2A793xzqBxp5kiueCAUW0MXmKUUTTmuH9cKw1eUjhDYmgv/9x3C62isA1bkzP
	 kvzSEug4J/Hbg==
Date: Fri, 19 Sep 2025 17:31:15 -0700
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
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v16 09/10] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <cic4dekp3h5fduzsar5lydynzambabar26zjzogdbn26dxiabh@g2eaji3bqlct>
References: <20250729182304.965835871@kernel.org>
 <20250729182406.331548065@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729182406.331548065@kernel.org>

On Tue, Jul 29, 2025 at 02:23:13PM -0400, Steven Rostedt wrote:
> @@ -230,6 +232,14 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
>  		return -EINVAL;
>  
> +	/* Do not allow cancelled works to request again */
> +	bit = READ_ONCE(work->bit);
> +	if (WARN_ON_ONCE(bit < 0))
> +		return -EINVAL;

The local 'bit' variable is unsigned long, so this will never be < 0.

Should be "bit == -1"?

-- 
Josh

