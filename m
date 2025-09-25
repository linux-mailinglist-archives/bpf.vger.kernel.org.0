Return-Path: <bpf+bounces-69658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14164B9D50D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817DB7A1677
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8E2D9EE7;
	Thu, 25 Sep 2025 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpeIJVxS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302FDDC3;
	Thu, 25 Sep 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771216; cv=none; b=qM7pHryZMtxs8/yuNj/vZJM0gX542r92WddAxaYMIk9hh9XVk2FQ9uZ0KEnLw3lSjmK23rcR41YnpTUgAfe0yjicWbRBMy5qKIRmbrHudEbgHqFLtRdzMAeUUJQI8jJ36oEpExWvFBmR3MBgtJvVmkA9abOUgtZlt49zt1pt0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771216; c=relaxed/simple;
	bh=DWfe4aECbsuwyz8AkW6vviHZuLumZTzAPaTzGlzdesg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mHBAPBl6FkhKahKCZ1yrEK51ZExBcOTqFGPJFZ5rJ5YKOzUvmW+LcCezRCrr7vpdW9hOYe/1WbPDT9nG22FrBZ1E2FYxdOEWvJnMes5bRhflltuyv7M07vydzWMU+K93Q2vT1hPpc3V/V6dPEjpUbtoEDUINQTTp7Av4gaMnJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpeIJVxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85439C4CEF0;
	Thu, 25 Sep 2025 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758771215;
	bh=DWfe4aECbsuwyz8AkW6vviHZuLumZTzAPaTzGlzdesg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpeIJVxSOHjl/s2K8uNPyOH91Xr617pjQoR98gz6255BMQrq87DcqAlwrDI5mkwV1
	 OwqJ/CFHdKfkUJ3wYO9bINfdIr0MHVaWR1+OSvggIr/hARfQiX+S4rcsReLDfEbD9q
	 MKd8Xy5VfVA8CRV7N4KRVXVu6H9GssHI4m6v6mwTGO3cu4gsojzr2OSzoEryixJfjb
	 NpZzaAOoJcIWx2/C0lx0Vqir9ub0YHAqj8w46XnMGx+tzuHKGuP6u/RPR5ZsQTvWiO
	 0iaRHn+FkuAm9xJNxWkGXdwOGHb5h0nVLjor90w6cwsPHBpitKqEUbnoClLtbG9qy6
	 Y7pyQyENmtwtg==
Date: Thu, 25 Sep 2025 12:33:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 will@kernel.org, revest@chromium.org, alexei.starovoitov@gmail.com,
 olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix the bug where bpf_get_stackid returns
 -EFAULT on the ARM64
Message-Id: <20250925123331.f4158581bd488ca0ba838d1c@kernel.org>
In-Reply-To: <20250925020822.119302-1-yangfeng59949@163.com>
References: <20250925020822.119302-1-yangfeng59949@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 10:08:22 +0800
Feng Yang <yangfeng59949@163.com> wrote:

> From: Feng Yang <yangfeng@kylinos.cn>
> 
> When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
> that contains the bpf_get_stackid function, the BPF program fails
> to obtain the stack trace and returns -EFAULT.
> 
> This is because ftrace_partial_regs omits the configuration of the pstate register,
> leaving pstate at the default value of 0. When get_perf_callchain executes,
> it uses user_mode(regs) to determine whether it is in kernel mode.
> This leads to a misjudgment that the code is in user mode,
> so perf_callchain_kernel is not executed and the function returns directly.
> As a result, trace->nr becomes 0, and finally -EFAULT is returned.
> 
> Therefore, the assignment of the pstate register is added here.
> 
> Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
> Closes: https://lore.kernel.org/bpf/20250919071902.554223-1-yangfeng59949@163.com/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Thanks for fixing!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This is actually a fix for arm64. So I think it will be
merged via arm64 tree, right?

Thank you,

> ---
>  arch/arm64/include/asm/ftrace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index bfe3ce9df197..ba7cf7fec5e9 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -153,6 +153,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	regs->pc = afregs->pc;
>  	regs->regs[29] = afregs->fp;
>  	regs->regs[30] = afregs->lr;
> +	regs->pstate = PSR_MODE_EL1h;
>  	return regs;
>  }
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

