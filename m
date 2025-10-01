Return-Path: <bpf+bounces-70173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D66BB20EF
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C07AC80F
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BA29BDA5;
	Wed,  1 Oct 2025 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ8nQTZI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD4221739;
	Wed,  1 Oct 2025 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360852; cv=none; b=jXWKPlgC3yhUW7lcNfjZByZjsuYeLzZ46L5UCGhDhuU8kdTthpzzxUha52I9c+/oAxeT5LcEJAhxepnJSthPIztP3U2d8NM2Ifx1D4UUO8U8j1J+AoZZvXt3r4zPuYSRdbWteA9yxzxVEUSk0XEngUC0t1ORLY3m/DFbSI8H3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360852; c=relaxed/simple;
	bh=BZOP4eup77yJhBeTriLocwoqSrC/fZy9yvr//D8xsck=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DQKBzXRjFfEP0HI4cxLuYPCGF4KqnMqDMrBnhKgLI06susX1AKD67nUr46/jVUtHB1Jtjnq5bvHEriAFGOQH2OyuJPVOTYhERp4v3LAlpHjQ1ar2kTUZuYmlE3s31nZfmuBfAgV2LGdzFcIegqT/WyrsLGRZBOk/MNUWGiADMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ8nQTZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8459FC4CEF1;
	Wed,  1 Oct 2025 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759360852;
	bh=BZOP4eup77yJhBeTriLocwoqSrC/fZy9yvr//D8xsck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQ8nQTZIhoO/h/qUDHztFjSbakWvucDpYxvOLb8ejkXl2bK6tIfE7rjKp2357Cex7
	 um3S7q6/KxNJs8uyiYz94wiR7W6nF4oLH5Mo+zKWkmkCNxpG9+chrRDXDROK67C/Pz
	 GndF7xSc2o544DkTESEoe6/ux1oi+pqoVslD3mKGz6PKDkhNrTn9WBVtn0gg+XXC2S
	 2Y+puvLzveByMJSt4rfXH/dk0kejknfckB3MXhIXVx/m7vRIzQVNwMyjoS9F2Qmnuh
	 /lWmmCC8lSGpUYuHHDysJikJP03QxN/nvEwXnslVFo1261zCWHOkAWFV6r1tz43eIW
	 guZmicPVabyZQ==
Date: Thu, 2 Oct 2025 08:20:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, David Laight
 <David.Laight@ACULAB.COM>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, Ingo Molnar <mingo@kernel.org>, Jann Horn
 <jannh@google.com>, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers
 execution
Message-Id: <20251002082045.f9059a70eebea517e7cb67b8@kernel.org>
In-Reply-To: <20251001132449.178759-1-jolsa@kernel.org>
References: <20251001132449.178759-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 15:24:49 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> It's less confusing to optimize uprobe right after handlers execution
> and before we do the check for changed ip register to avoid situations
> where changed ip register would skip uprobe optimization.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thanks,

> ---
>  kernel/events/uprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 5dcf927310fd..c14ec27b976d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
>  
>  	handler_chain(uprobe, regs);
>  
> +	/* Try to optimize after first hit. */
> +	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>  	/*
>  	 * If user decided to take execution elsewhere, it makes little sense
>  	 * to execute the original instruction, so let's skip it.
> @@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
>  	if (instruction_pointer(regs) != bp_vaddr)
>  		goto out;
>  
> -	/* Try to optimize after first hit. */
> -	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> -
>  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>  		goto out;
>  
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

