Return-Path: <bpf+bounces-76229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF284CAB662
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 16:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C93530006EE
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845052F5337;
	Sun,  7 Dec 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asmsHUdv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E52D1F64;
	Sun,  7 Dec 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120250; cv=none; b=H6NVLZmoP6P1QGDzHadxJWldE6NPM7R6Q9YLwHwQDDv1FwgqAPEKPM+aboSr8TGRMHsy1HwAxnOthj++jq/RWQSo/s0WQsO9GAmBeS9cjK6hkKg/it2ddq1AG4bIq/KK5vVoKesq+HaTs4zC6vNglv062mCYxXclOoynh6KWVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120250; c=relaxed/simple;
	bh=OzF7hS6TrInXl3mCcNu9qnyxA3CdmEZ4IbhduQGYtII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLFDFnuDIOrB6VO1Ln3u9QdxJtYp9fzN5Ztx/kVLh5hF32u9KmhDeU5kA3JbbL5jGhYo8CR207DV2TGEm9L54VQjOIh8+uaHV9lRWwLeLKLMDg2YfT8TSejVdrIIwEDGdcrzJNfJ2BtAepa+eDjqybfZNbMlCfBhjiBgj15lOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asmsHUdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6551BC4CEFB;
	Sun,  7 Dec 2025 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120249;
	bh=OzF7hS6TrInXl3mCcNu9qnyxA3CdmEZ4IbhduQGYtII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asmsHUdvMM2cCAnZUnx16UexGWR1yWUVU4LB8ks1o0iZFdoifARMV/4pgO5o9Wtcq
	 YhCgZaXlBoafmQ58s//PZX8b5GZ6c0vbP2nOIDqcE9QRFS1yVCUcIqSNDmWsJReD3h
	 jyYI0k9Oviqnwj2ckrtpw9+sQSqFkN9mWtm69jhDfvmuvcbFGcx7Hj1OQHgWiVAPZz
	 4Lw9s4w7Rb1skuJh1fefC7iFDEa3CKHl7FTpTUKwZ+x6niZMDFx6JNB18lpnu30s2H
	 jHW7GHnTniWzg57MsEQav42xNh9RNSleOzw5JP4s2VigfTOZ50AVUbU5EolslYt0lH
	 lon+H+7W3YtyA==
Date: Sun, 7 Dec 2025 07:10:44 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>
Subject: Re: [RFC PATCH v2 14/15] unwind_user/backchain: Introduce back chain
 user space unwinding
Message-ID: <iidpbjmxnjf3zu4fa3atiubgb365yonv4gymaj76l6jvuxy67s@2y5o4txs4vhr>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
 <20251205171446.2814872-15-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205171446.2814872-15-jremus@linux.ibm.com>

On Fri, Dec 05, 2025 at 06:14:45PM +0100, Jens Remus wrote:
> @@ -159,6 +165,10 @@ static int unwind_user_next(struct unwind_user_state *state)
>  			if (!unwind_user_next_fp(state))
>  				return 0;
>  			continue;
> +		case UNWIND_USER_TYPE_BACKCHAIN:
> +			if (!unwind_user_next_backchain(state))
> +				return 0;
> +			continue;		/* Try next method. */
>  		default:
>  			WARN_ONCE(1, "Undefined unwind bit %d", bit);
>  			break;
> @@ -187,6 +197,8 @@ static int unwind_user_start(struct unwind_user_state *state)
>  		state->available_types |= UNWIND_USER_TYPE_SFRAME;
>  	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>  		state->available_types |= UNWIND_USER_TYPE_FP;
> +	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN))
> +		state->available_types |= UNWIND_USER_TYPE_BACKCHAIN;

Any reason not to just use the existing CONFIG_HAVE_UNWIND_USER_FP hook
here rather than create the new BACKCHAIN one?

-- 
Josh

