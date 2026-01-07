Return-Path: <bpf+bounces-78128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3413CFEDD4
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B459317EE27
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D3361DD4;
	Wed,  7 Jan 2026 16:03:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71A34D4D8;
	Wed,  7 Jan 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801822; cv=none; b=gFhe0rCLRZM8r6LmyBTQTRQe5gQz4XMQJT/zh/ZIs3nGTINYqTPClOV1U5nCT18UhIBJqJq/WiIR4pgabvhDIqLLR20rwHTzSx6TtGqdmlOF68vbBWA4EfRr4j7pG9aFXCBJ40qQcdqIGismbP8GDLNFTaS1fS3D2DcL0HTzljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801822; c=relaxed/simple;
	bh=0/LOXatsbH7F3/lbi5zwi6kK9oqM1E1EsqV+tVAbn7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTURO8I4e3HRxlC6bv6sWlm3Ij/IVmdPVadUCAy39CTMnQVXZpSH/IiIhLfgRIZHS79IX/52H/h4VkDSP1fKr2Af9Zk/9wjwUuw+O6he3USVFLLOQP9XAOU8vlVbZipSx+lyKRYzsKSQpgHoZD+5s7iht/U7CKHGweD8Op7a4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id BDE121A5130;
	Wed,  7 Jan 2026 16:03:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id E70AC20023;
	Wed,  7 Jan 2026 16:03:25 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:03:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will@kernel.org>,
 Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260107110352.3fd7ddda@gandalf.local.home>
In-Reply-To: <20260107093256.54616-1-jolsa@kernel.org>
References: <20260107093256.54616-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E70AC20023
X-Stat-Signature: 13qo46g6zpia7f3nofbp81nnodino9w7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1957k6O/UsmSN3vUac32Bo7sXZIZwwkaaU=
X-HE-Tag: 1767801805-671253
X-HE-Meta: U2FsdGVkX18RsKY0dngVyvOKbOnb578X+xSZkEOG7hLLVWfcT997CreYeXdTXjiUBbrnEpEplun5zUoX/yIde/2G7I0khiiwc2+9R3i83hE5x9MaXQsj752xyWlfb1torPzACnrRGbNQRBs76gmyhpH81bHqH6l5Ph89iZObGEZbEZGFPfhDP4wmX4UEQOSAmpy+EanvESqs05MZHmkt+EhdhXlEt4bxk4hAlAIcQw42HV/JXn0BV2+43E+XurhE5vtIgIOTTqPOPf6C1dvfnCE7BZArazcQzYY63MXPU9eCBeI0YhZEhYxCQn/Q3+/MgFzPmaLc5W8Wh67jl6agKZJpPxz16ltc

On Wed,  7 Jan 2026 10:32:55 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1621c84f44b3..177c7bbf3b84 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  

See my reply in the other email thread:

  https://lore.kernel.org/all/20260107105316.2b70a308@gandalf.local.home/

-- Steve


> +/*
> + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> + * @fregs: The ftrace_regs to update from @regs
> + * @regs: The partial regs from ftrace_partial_regs() that was updated
> + *
> + * Some architectures have the partial regs living in the ftrace_regs
> + * structure, whereas other architectures need to make a different copy
> + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> + * if the code using @regs updates a field (like the instruction pointer or
> + * stack pointer) it may need to propagate that change to the original @fregs
> + * it retrieved the partial @regs from. Use this function to guarantee that
> + * update happens.
> + */
> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> +
> +	if (afregs->pc != regs->pc) {
> +		afregs->pc = regs->pc;
> +		afregs->regs[0] = regs->regs[0];
> +	}
> +}

