Return-Path: <bpf+bounces-55814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54186A86D70
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826F68C7364
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEF1EB18E;
	Sat, 12 Apr 2025 14:09:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404551E835C;
	Sat, 12 Apr 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744466982; cv=none; b=Q8wEWu/IeBI9jVk0Esu8FevWVMA9LCJ9yZTK/qELy8SLIQdy4u+KWMTAD3XxaacyWdwuAz0RTYc3ZitwuNmOUQZS8fOw/Y8GModEBJfYBZqzV+ZnaBkJ2zT+vAu7g+bZzuaksJXmkrcIPUTaiWPXvGQjrMaQnB5VkK797+cm5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744466982; c=relaxed/simple;
	bh=NyZojqflLZMNhiUpw6gwmCmF7Bw03UAtvFJZ75ZPK78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptbOqjorYhdFc1i6iLwL4YN5KoWtOcPnT4O4Btcw0sPhmLoJKcLq9dGEG+GcgwWuxamBCXBF2TIMU8D4bg0c0/0HIaBy8Ogb97so4oLCg+CzqjH0MEn2NWMv9tT+q+1bnYYnHPlGEXCUrGHSWMWMvfHHw/WT5XZxn02P0S0U3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F1EC4CEEB;
	Sat, 12 Apr 2025 14:09:40 +0000 (UTC)
Date: Sat, 12 Apr 2025 10:09:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf] ftrace: fix incorrect hash size in
 register_ftrace_direct()
Message-ID: <20250412100939.7f8dbbb7@batman.local.home>
In-Reply-To: <20250412133348.92718-1-dongml2@chinatelecom.cn>
References: <20250412133348.92718-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 21:33:48 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> The max ftrace hash bits is made fls(32) in register_ftrace_direct(),
> which seems illogical, and it seems to be a spelling mistake.
> 
> Just fix it.
> 
> (Do I misunderstand something?)

I think the logic is incorrect and this patch doesn't fix it.

> 
> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1a48aedb5255..7697605a41e6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5914,7 +5914,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	/* Make a copy hash to place the new and the old entries in */
>  	size = hash->count + direct_functions->count;
> -	if (size > 32)
> +	if (size < 32)
>  		size = 32;
>  	new_hash = alloc_ftrace_hash(fls(size));
>  	if (!new_hash)

The above probably should be:

	size = hash->count + direct_functions->count
	size = fls(size);
	if (size > FTRACE_HASH_MAX_BITS)
                size = FTRACE_HASH_MAX_BITS;
	new_hash = alloc_ftrace_hash(size);

-- Steve



