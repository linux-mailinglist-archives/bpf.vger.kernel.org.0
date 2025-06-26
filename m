Return-Path: <bpf+bounces-61655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35803AE985F
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798085A6C03
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF48292B2D;
	Thu, 26 Jun 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jECo95zw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B41A254E;
	Thu, 26 Jun 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926791; cv=none; b=uTLHb9pwxZSmnkz6cNHbz5N3p1KF7IKJD1EZ9sxVG4Cvz1n1Z9jjlBvzw4uWRrmSh3I7aKGtxQ2TE+L9tQ4jEKDmk+oqxIBcfmqAvMAzowap0bAgrPfwuw343dI9XcHe/7kF5q0+3kZSFor3h52sClWDEWlcJyuiHmqjEPR0PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926791; c=relaxed/simple;
	bh=4aGL9WPbA5W/z9AUctL3gQOUzTjLraWh2A6DZhAKLpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCtNXPI0a93Dlx5u3JF/wnrc9o5rVyfrs2PBymC/GzRE0oa4GGsQj5XZdLEYVBnVFWgp+LP7cUzyaD9euU3g7AuUQHyfLJo8daooHAIUM8w1RoeGZV1vwcfgYPvRO/bO8DDEzIE1kZBsRBdnviUDQDbdPzYt+e8EU2P+SmNPJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jECo95zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6815CC4CEEB;
	Thu, 26 Jun 2025 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926790;
	bh=4aGL9WPbA5W/z9AUctL3gQOUzTjLraWh2A6DZhAKLpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jECo95zwkP7nfTECBN7B2V5BpdXc+1D8COVANmKLxmlsPGy/9o5e4NM+ronkZFHfo
	 iQHLAcf+UHHZBtWzshpBu4oeaB5/9cdLgnVzvjJVxBygiJTIebUWayIzuU/g67Bk6P
	 obytzePRDTbIdIU2QkrZHpUwINwYLp1NMBX7JA/4jgavdLsTMTNZzxk0EvgbJa5TQY
	 MEWAzzFy5pEIAmWOJ5M55+JMipsLrWqrW5JntYec105IgrV0NbJQXaRkG4ZMspUBZ9
	 ihIFOytSfL2DJvUmTrfCvp+susThpPIuFHneI7ytGzIY74NO+an3E0HX3N4OUnrj2h
	 woRS7KwwTYl3g==
Date: Thu, 26 Jun 2025 10:33:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 14/14] unwind_user/x86: Enable compat mode frame
 pointer unwinding on x86
Message-ID: <aF0FwYq1ECJV5Fdi@gmail.com>
References: <20250625225600.555017347@goodmis.org>
 <20250625225717.187191105@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625225717.187191105@goodmis.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
> new file mode 100644
> index 000000000000..d7074dc5f0ce
> --- /dev/null
> +++ b/arch/x86/include/asm/unwind_user_types.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UNWIND_USER_TYPES_H
> +#define _ASM_UNWIND_USER_TYPES_H

This is not the standard x86 header guard pattern ...

> +
> +#ifdef CONFIG_IA32_EMULATION
> +
> +struct arch_unwind_user_state {
> +	unsigned long ss_base;
> +	unsigned long cs_base;
> +};
> +#define arch_unwind_user_state arch_unwind_user_state

Ran out of newlines? ;-)

> +/*
> + * If an architecture needs to initialize the state for a specific
> + * reason, for example, it may need to do something different
> + * in compat mode, it can define arch_unwind_user_init to a
> + * function that will perform this initialization.

Please use 'func()' when referring to functions in comments.

> +/*
> + * If an architecture requires some more updates to the state between
> + * stack frames, it can define arch_unwind_user_next to a function
> + * that will update the state between reading stack frames during
> + * the user space stack walk.

Ditto.

Thanks,

	Ingo

