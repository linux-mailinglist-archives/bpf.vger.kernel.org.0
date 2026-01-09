Return-Path: <bpf+bounces-78328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E5D0A804
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E543A3034374
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340BD33B962;
	Fri,  9 Jan 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1FWGrPc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2D20459A;
	Fri,  9 Jan 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966449; cv=none; b=ZOo3qUMFM6u+5JfjVXsVZ6dCuD9EjzLcb63DikZ1fQhYoEiCAOaZalpgoz+YtSVYBVDvZXy9Zp065dwG4NNXgzOJqN59zJD5RwnyGbeYVXGhxZPIJ3f3P+/dtGpKXzDkTaFMUJYfsKR7qSjYzN+OjaM4Ef2n5Xj6BOWnQjw/1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966449; c=relaxed/simple;
	bh=cEF2HlQxucHUoV1e6UadmpWp+jSEoVJADc0Y46qZqbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+jw+7EVxjY99Mgn4ueQ4swdznzN5JJNtie0I+s0SwnBiJkCyPkFcDVkwuc1qyxfkp4A64HE/tR83D0iAcVwgENZ3oSODnsvZ3hPadQJ8bZvFVAOzEY8GZXoJPNvwx3noQBWiULz7UUE9tK7BHr5s+hycK0A8Do5ww7qLnGkDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1FWGrPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A3C19422;
	Fri,  9 Jan 2026 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767966449;
	bh=cEF2HlQxucHUoV1e6UadmpWp+jSEoVJADc0Y46qZqbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1FWGrPcQeROcGwnj7vSyZsZ1zoSFgaD4Ln4/ur1+e7jz2eTTP6zYm4hc6t69Rtx4
	 ZMmzuPPYsHpinghqDInHPL7rn5HeCDufgC5QuhRtbfMLhWFLcCU60gr6oeygzkIrDL
	 3jFoHuAyXCVfTLXcowVvzN7EuhmBtm8euqQh7RyfCox9zqcC/B5cvi9niLHeasjEIb
	 QD6oexPs+n4lFjegd2rI/pWCvTT1Tedm5O83ZKR50AEKyofkAbTp3btKM6ZjDQrz9Q
	 k7/CFJCmNVlIFPAnncs0QS5avgRg0WcLROqnnMZwJBKdvA8WGI9ZJFpKbjdQ9nuecr
	 R94qzMn7rVI1g==
Date: Fri, 9 Jan 2026 13:47:23 +0000
From: Will Deacon <will@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aWEG685zlaV0o7M7@willie-the-truck>
References: <20260109093454.389295-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109093454.389295-1-jolsa@kernel.org>

On Fri, Jan 09, 2026 at 10:34:53AM +0100, Jiri Olsa wrote:
> Mahe reported issue with bpf_override_return helper not working when
> executed from kprobe.multi bpf program on arm.
> 
> The problem is that on arm we use alternate storage for pt_regs object
> that is passed to bpf_prog_run and if any register is changed (which
> is the case of bpf_override_return) it's not propagated back to actual
> pt_regs object.
> 
> Fixing this by introducing and calling ftrace_partial_regs_update function
> to propagate the values of changed registers (ip and stack).
> 
> Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
> - moved ftrace_partial_regs_update to generic code [Will]
> 
>  include/linux/ftrace_regs.h | 25 +++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c    |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> index 15627ceea9bc..f9a7c009cdae 100644
> --- a/include/linux/ftrace_regs.h
> +++ b/include/linux/ftrace_regs.h
> @@ -33,6 +33,31 @@ struct ftrace_regs;
>  #define ftrace_regs_get_frame_pointer(fregs) \
>  	frame_pointer(&arch_ftrace_regs(fregs)->regs)
>  
> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) { }
> +
> +#else
> +
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
> +	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> +	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
> +}

I think the AI thingy is right about dropping the const qualifier here
but overall I prefer this to the previous revisions. Thanks for sticking
with it!

Acked-by: Will Deacon <will@kernel.org>

Will

