Return-Path: <bpf+bounces-77675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5733CEECD8
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32C3300F30D
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945E22D7B1;
	Fri,  2 Jan 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/vDziwn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8B22688C;
	Fri,  2 Jan 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365552; cv=none; b=Jb9X93Lj+uOQqcNTSRhvUyQVu/YEP+x3QuA9CENL6dGcmCuoMvoMY5T97297f9fEjRkS55RkaR0aco6W6Lspl5kAeKteZ7BZjc5LjhBOGB/0Am8RkUk1rayksSRfQOkh8vm55jCWIhX+PFp/Ycf+yI4zFSaEH3SSRwOIcxOLnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365552; c=relaxed/simple;
	bh=JQQ5LuFQIAK/IiQNjSgP3KNOzDhsqMGgsVNg6dB+StI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyxBFlUC36EjlafHDerZi0dopEcVQimKfoQa40Yz2AECf+B8MrS7gJgHRFuRJqwSd+byYxS8LLCvd18I6xZzm21b44th2wPCNh0IRaTWaWscqPoitFIalTEwbxZbUDKqt9Zd9Nj7BKrvbnCpyNptu0ww3yrsGGt8RPDl4AbQkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/vDziwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0BAC116B1;
	Fri,  2 Jan 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767365552;
	bh=JQQ5LuFQIAK/IiQNjSgP3KNOzDhsqMGgsVNg6dB+StI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/vDziwnCwq1mltUECV7jiwGIjish4gYTwEefWcXF66tMsA+/3UW4qvnybkYaHTn4
	 EafDa92jcR6Yv1QDuywTsuuNfxdh4BffmTsun4ORuSyLUei3h3lcWX1fV/llAHpnMp
	 pQPzEqJTTLMW4WrXXyHbohmeyTOxaRk0x0jnb7d843oNA1+pvsNglqzU6r2ir73KCc
	 7UA6OwtAlmxeqeTIjiqQhDJKUi9zvYM8H2MUAofDVvHXAjBguDSRc/XtuAqd9Oq9oT
	 F+gsKUS66rDiU34l3iHRSwf8JRiYxsBPII2Jkw/yn+6aalLlvtI7nDPb2yfst/yRNR
	 FwSGKYRmj32bw==
Date: Fri, 2 Jan 2026 14:52:25 +0000
From: Will Deacon <will@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aVfbqYsWdGXu4lh8@willie-the-truck>
References: <20251105125924.365205-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105125924.365205-1-jolsa@kernel.org>

On Wed, Nov 05, 2025 at 01:59:23PM +0100, Jiri Olsa wrote:
> hi,
> Mahe reported issue with bpf_override_return helper not working
> when executed from kprobe.multi bpf program on arm.
> 
> The problem seems to be that on arm we use alternate storage for
> pt_regs object that is passed to bpf_prog_run and if any register
> is changed (which is the case of bpf_override_return) it's not
> propagated back to actual pt_regs object.
> 
> The change below seems to fix the issue, but I have no idea if
> that's proper fix for arm, thoughts?
> 
> I'm attaching selftest to actually test bpf_override_return helper
> functionality, because currently we only test that we are able to
> attach a program with it, but not the override itself.
> 
> thanks,
> jirka
> 
> 
> ---
>  arch/arm64/include/asm/ftrace.h | 11 +++++++++++
>  include/linux/ftrace.h          |  3 +++
>  kernel/trace/bpf_trace.c        |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ba7cf7fec5e9..ad6cf587885c 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> +
> +	if (afregs->pc != regs->pc) {
> +		afregs->pc = regs->pc;
> +		afregs->regs[0] = regs->regs[0];
> +	}
> +}

This looks a bit grotty to me and presumably other architectures would
need similar treatement. Wouldn't it be cleaner to reuse the existing
API instead? For example, by calling ftrace_regs_set_instruction_pointer()
and ftrace_regs_set_return_value() to update the relevant registers from
the core code?

Will

