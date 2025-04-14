Return-Path: <bpf+bounces-55841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC78A87867
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579723AEED7
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1B1C3C14;
	Mon, 14 Apr 2025 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSc2D+fO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A971B425C;
	Mon, 14 Apr 2025 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614331; cv=none; b=nenLjBpsYgi1D9blYCZ/YAQCpPvYuKI7MbJXjYHp1+mo5RlrBLgmZrLRx6yoddMLjit94vCNIhszYnP9z5ngQ0tAj8iGsNxwoL5gNAdEHwVmXi2MQ6aG6YDkEx/UOJuICy6+SNSDsLEkdnJW6LZze82eFuMKSG83VlHm8Y14ABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614331; c=relaxed/simple;
	bh=FMQI8FgGKRqjDb9goFSkLMlrY0FglRHVdCSHbAxc/Dw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k3hx4ZHvq9unFlxkyd9VR0UEyWadJYfCVSoN6kld19uWdDWEZks2VUr9D/LteLmRmEe2bV4IWNKjFz3SCDPNB5FOHosblUbLUnD9pxncPOHtq5XAQKSuT5XBKbGOip2hyew1+LBPW+PyMub6QQZyfccT6SIfJSP5JSWsei8+T68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSc2D+fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D266EC4CEEA;
	Mon, 14 Apr 2025 07:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744614331;
	bh=FMQI8FgGKRqjDb9goFSkLMlrY0FglRHVdCSHbAxc/Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSc2D+fOxrizzyCyyccJPDnbs3OYHOVDw21EoG/MWLlRVsC6NPn6Jm0NSrvlxLEDk
	 zT9G4D1v6AQAcA8hV1k4ZPHlzbCQOX98SZuRJsYnkvnzhXRtautfPPoasbaTlw+uCn
	 zmpguAnO0gCdTCu/mnsyBL0j96yMkJDir4TpMj0JDUBZKdcwwSdpLv8pE9qrnbvbY2
	 uAaCtJ/JKvyaasfyhbqJZDoUFVdD3g9fuXZLCqdfMJ+994cZLJJxxR77U5GRLb4cv6
	 xbXT7jV8hvz5v4FwwZCnK995Dtrc2EhkNkLafK1L4A3BhJRgiOhsDaAuVz2S1Z7msO
	 6s+HIm8qauCEw==
Date: Mon, 14 Apr 2025 16:05:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v2] ftrace: fix incorrect hash size in
 register_ftrace_direct()
Message-Id: <20250414160528.3fd76062ad194bdffff515b5@kernel.org>
In-Reply-To: <20250413014444.36724-1-dongml2@chinatelecom.cn>
References: <20250413014444.36724-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Apr 2025 09:44:44 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> The maximum of the ftrace hash bits is made fls(32) in
> register_ftrace_direct(), which seems illogical. So, we fix it by making
> the max hash bits FTRACE_HASH_MAX_BITS instead.
> 

Loogs good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - thanks for Steven's advice, we fix the problem by making the max hash
>   bits FTRACE_HASH_MAX_BITS instead.
> ---
>  kernel/trace/ftrace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1a48aedb5255..d153ad13e0e0 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5914,9 +5914,10 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	/* Make a copy hash to place the new and the old entries in */
>  	size = hash->count + direct_functions->count;
> -	if (size > 32)
> -		size = 32;
> -	new_hash = alloc_ftrace_hash(fls(size));
> +	size = fls(size);
> +	if (size > FTRACE_HASH_MAX_BITS)
> +		size = FTRACE_HASH_MAX_BITS;
> +	new_hash = alloc_ftrace_hash(size);
>  	if (!new_hash)
>  		goto out_unlock;
>  
> -- 
> 2.39.5
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

