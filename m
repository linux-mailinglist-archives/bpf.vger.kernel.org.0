Return-Path: <bpf+bounces-63543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41EB082BC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5887B1C2102B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C31C8633;
	Thu, 17 Jul 2025 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvZi6t2s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD0383;
	Thu, 17 Jul 2025 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717966; cv=none; b=RTph/8KIRXdUoVTQj6iToP8YPD7cDo8HBj7cwW+8NhgiWeNIjZOml871hg9ZDcGxMNQuFAK6zLtvCnHxWFU3ZC7KQDt++T60c/tVjyN/7uvHi/iJ3T++d8Oan+k/ppbr3UyDC85Y/42Zj3QQMbJKW4dgdIEhr//+k2TagJwFdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717966; c=relaxed/simple;
	bh=GEUd1AmzQwdYuwp2PPPg8qHYUSWLqdn6zZ9PO8zi+T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSLyOG+/fOtqYGe8SAsFriCTbkaBLE9FP46ZnsFdyHSuFsevsfp2yR/fA/Pokhn2v2tCnLBrH6s4bOPzaxA077feDbkOR8Bs5xecLwxoWwP2RBjdhLZRTjPLeGAPR2Jd08Boi9udrc+I7298+3sSAj+YA1F3xZxo4trPsWRqq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvZi6t2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B24C4CEE7;
	Thu, 17 Jul 2025 02:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752717965;
	bh=GEUd1AmzQwdYuwp2PPPg8qHYUSWLqdn6zZ9PO8zi+T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvZi6t2sJvKlfsUcnWKrsaiMrqkIJ2Sl3kVi0jQ1SFPh4x2OZEwAvJEgKyusSQpKT
	 QQ9oG2xKAnnzmMj7+QXZJ1N9X+R3Q+jAKnGI5GXSLAWgujMrTD+U+MTueNi35HGqoB
	 rE94rEeOcjPe4d2LrRE8i8oAgphJ1t1lprvYUnyO1IQJj2snGLhKImEy/jg8k5xCHo
	 7pgCiIL/nSF8vlxx75fNnDrYs/FzIdTYOCyqQeU/B3kHMB6Hzrb0QtCdvWEF9uywHF
	 5xc+VYapQfEbFZjm6K0XKOz04W7w4T5PRdUzQnv77pYhdOQS5GvMqKykBX00RyalVE
	 hauZfn7lGz6yQ==
Date: Wed, 16 Jul 2025 19:06:02 -0700
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
Subject: Re: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain
 user space unwinding
Message-ID: <a4dd5okskro2h45zmqgg3etj6uwici2hoop2uaf6iqrlaej7yh@xlduwjqke4ec>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-13-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710163522.3195293-13-jremus@linux.ibm.com>

On Thu, Jul 10, 2025 at 06:35:18PM +0200, Jens Remus wrote:
> @@ -66,12 +73,20 @@ static int unwind_user_next(struct unwind_user_state *state)
>  		/* sframe expects the frame to be local storage */
>  		frame = &_frame;
>  		if (sframe_find(state->ip, frame, topmost)) {
> -			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
> -				goto done;
> -			frame = &fp_frame;
> +			if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP)) {
> +				frame = &fp_frame;
> +			} else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN)) {
> +				if (unwind_user_backchain_next(state))
> +					goto done;
> +				goto done_backchain;
> +			}
>  		}
>  	} else if (fp_state(state)) {
>  		frame = &fp_frame;
> +	} else if (backchain_state(state)) {
> +		if (unwind_user_backchain_next(state))
> +			goto done;
> +		goto done_backchain;
>  	} else {
>  		goto done;
>  	}
> @@ -153,6 +168,7 @@ static int unwind_user_next(struct unwind_user_state *state)
>  
>  	arch_unwind_user_next(state);
>  
> +done_backchain:
>  	state->topmost = false;
>  	return 0;

This feels very grafted on, is there not some way to make it more
generic, i.e., to just work with CONFIG_HAVE_UNWIND_USER_FP?

Also, if distros aren't even compiling with -mbackchain, I wonder if we
can just not do this altogether :-)

-- 
Josh

