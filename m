Return-Path: <bpf+bounces-63488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7BB07FAD
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056F658681E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC042EBDEC;
	Wed, 16 Jul 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmScn7AR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23262EBB95;
	Wed, 16 Jul 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701544; cv=none; b=UzNvqhMmh0CYW0AybRbXRx/Lbej+3HfvUmFtU/2i6Wb07+/bLM79JsBqiejfJ+v9y7hS10IuQplRYf0DOqQPH7F1l3MfG3SbF5UHdPAMlXMPdLnGRDGa3JsZPNGJKjcFa/dsFBgzPFdA2xNBKNjFng9ztBFEqvzC+v9SRI8BzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701544; c=relaxed/simple;
	bh=RcJyvGAOYpJenAb2/Ce7hOXw7Nx71fjCzp0c1g1mHhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C41cqA5Tx3OFy0Ju7A2Ivv5s35LQOuVl0rOmVLkSkhfJEtf3gb/WMK8UBmsu1d8JTFYIUG9FV7gefxCZ+QCQZ/wzQVwfVUCCJjqo25SOKzpjI1ERrSZzMkQFErE4VIosT7R3z+JWB9SDMaa+WOelF/sbJZcE9efTJkkLqs8GsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmScn7AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9EBC4CEE7;
	Wed, 16 Jul 2025 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752701544;
	bh=RcJyvGAOYpJenAb2/Ce7hOXw7Nx71fjCzp0c1g1mHhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmScn7ARSIYqiNmzF+rn6FPk0ApXOqD5XWmA1IyOxXBP9+ppw/H4KAOq6Kjoc+s0+
	 idi8lHv7rzfwBehXnK/a7gCf1qne5NXHKAJwIw+z6Qu10DZWpjd+LznayCsReVUH5Y
	 agIyoR524SbkUq7rG2vNfM4MVkHKag/fpwXse/f4fk0DpleuMJlchesk68RgYMaILa
	 /31s80fEietrfCSKVsz0lhKknnyl8pTxT+de4h9v+yGkRfgRrIDAzqixyTGaK/kwQU
	 4+P2ydTeGaKKQuRtq20vT8anHAPeKyb6gMXGyP5pQKzqF3mlceWZ8YIC8NaZbgH08l
	 EgHmVWSkXQ1iA==
Date: Wed, 16 Jul 2025 14:32:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Steven Rostedt <rostedt@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 06/16] unwind_user: Enable archs that define CFA =
 SP_callsite + offset
Message-ID: <qoiocmdhuuaox5v5ig2ui67qbuxkvzl4z3ft4gdp7p3c4b4zfq@trjthmmculkf>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-7-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710163522.3195293-7-jremus@linux.ibm.com>

On Thu, Jul 10, 2025 at 06:35:12PM +0200, Jens Remus wrote:
> Most architectures define their CFA as the value of the stack pointer
> (SP) at the call site in the previous frame, as suggested by the DWARF
> standard:
> 
>   CFA = <SP at call site>
> 
> Enable unwinding of user space for architectures, such as s390, which
> define their CFA as the value of the SP at the call site in the previous
> frame with an offset:
> 
>   CFA = <SP at call site> + offset

This is a bit confusing, as the comment and code define it as

    SP = CFA + offset

Should the commit log be updated to match that?

> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -8,6 +8,7 @@
>  	.cfa_off	= (s32)sizeof(long) *  2,				\
>  	.ra_off		= (s32)sizeof(long) * -1,				\
>  	.fp_off		= (s32)sizeof(long) * -2,				\
> +	.sp_val_off	= (s32)0,						\

IIUC, this is similar to ra_off and fp_off in that its an offset from
the CFA.  Can we call it "sp_off"?

-- 
Josh

