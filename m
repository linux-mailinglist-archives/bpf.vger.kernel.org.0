Return-Path: <bpf+bounces-74110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D7C49BA3
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 00:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8ECE1889F9D
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837A2FF652;
	Mon, 10 Nov 2025 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJB3kG+Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DC2F745E;
	Mon, 10 Nov 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816839; cv=none; b=b16YgMo2YvzBvhzmK9oh4fztAcLXJTYIPUs0mcWei/PIqS107ugAmlbwDehwRU3HRB42lkFY5wZuIIHO2mwMORXooufdRQIyLwDYXyzBwaeUWwK5DsjYGtQMcjLLQUz678j53LorOpTxetqnz/SBS9EWUlaQfkmQ2460rWtMAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816839; c=relaxed/simple;
	bh=FIeaS0AVxWNe9gMVVor1LhTI7CIaaVmn2VWhVMDjN9E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ra1h2UlArmpUbbZBAJx3VsUisUb97poZzW9grIofmetEbiSlkZBsNNZ4PMQ1hhGIIWwaHGMFAXqVJl5gm19IZ11h9H5VD+VHKtawr3T78LE0w411DLA0izfGUqYTzFSn/NG0jV8WGl4trwG98rP0A2mbCQPq56wYDx7Kx9nwJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJB3kG+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B6FC4CEF5;
	Mon, 10 Nov 2025 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762816839;
	bh=FIeaS0AVxWNe9gMVVor1LhTI7CIaaVmn2VWhVMDjN9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TJB3kG+Zfq5iwiqyKCdKsPXVEpen8pNtMx1TpJNY677D/p9HXUqytmIoyfw2aYscH
	 K7YQWtOu9yqE6d2z7J7fd3Lyc5Wp7ucnDxmythM4AIUL6PGmGBABqOuHs/Ve6dHW0n
	 Wnz9DbUyuCIvYmReUCRRPMeZDJpjBJEP/YNT2eWmDh/ot9g7k9DMCqLBeZemTr7ko0
	 tRUVyGM5kcqa5gbhUlB8eBgJUYoPehwelf3je6qEOH4UZk8vSccsotb+dQsz5xzEkM
	 jkEW3aJs8GNV7Td09B8ZlyqZFxz1g9e6u0gnkSlK1ethw+Zn4oLWqKrp7xSGlC5bOl
	 nwqN27UzeABLQ==
Date: Tue, 11 Nov 2025 08:20:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid redundant initialization in
 register_ftrace_direct
Message-Id: <20251111082033.32f65dec4f8d3ddc417b2b0b@kernel.org>
In-Reply-To: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
References: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 20:18:08 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
> which can make it initialized by ftrace_ops_init() even if it is already
> initialized. It seems that there is no big deal here, but let's still fix
> it.
> 
> Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..efb5ce32298f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	new_hash = NULL;
>  
>  	ops->func = call_direct_funcs;
> -	ops->flags = MULTI_FLAGS;
> +	ops->flags |= MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
>  	ops->direct_call = addr;
>  
> -- 
> 2.51.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

