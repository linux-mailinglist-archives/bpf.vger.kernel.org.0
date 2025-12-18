Return-Path: <bpf+bounces-76951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0FCC9F26
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 403CD302AFB9
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95F242D67;
	Thu, 18 Dec 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1DPZ0hm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00943A1E87;
	Thu, 18 Dec 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766020037; cv=none; b=bs58y3/vBxD0ZU9Ec0sRgXDYHg58pFrSoVSuHTGne7iW+5WufXLygzZbppslzFegzS0mEiHtPVZG0zlDRoCm02SnWpCjzT95pckm+s8Yr0lQlkp/TrANqX90Ve6MMdrtYUZleWkrb9+hs7diftCY6l7dFm+CLtOYMEZ/iLOMm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766020037; c=relaxed/simple;
	bh=CWH28cOxPZAZWrWcY/NKpJgCf7WSDCA3ZIr66yGr2UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDwZijbrY+5Epiw6cEnpohWRABpnGcPzyegdVT5E9WL/XtVOoKhA7E5In/v8vAdVm0NPim/q7fMutSJroX1cZRf7Z6KW21JT2e14Dqpl4noMI5zRkU8lEHPCYemxWVA8MrvJBOgnzYaDossnE3zXkV8vsA3gJxsl9PExSr53HDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1DPZ0hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C31C4CEF5;
	Thu, 18 Dec 2025 01:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766020037;
	bh=CWH28cOxPZAZWrWcY/NKpJgCf7WSDCA3ZIr66yGr2UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1DPZ0hmLO6jFAREjtVWQteO0CmpRtbzEDH+BXoZ34nSIC2fE4WentvnDRK/ikQ1z
	 xeClGXoi3Xyf2z+I6IvOwzr7PPbTQRaOVY3dKcVbSBZLFh/owd9efx45KXA9WbZx0e
	 E3pa2UodwPc+3OrfQQEiCkT2aVMIO+PQOQzRHHmb0sH3Fc0LJoqjkhBiiUKylbTj79
	 jFYpqrBLPGNhRcWYHRXwfAKhzBa19RXdkSx2fCjiegf89SjNA7Xz/4ave1+P1cEtQK
	 9gl24R+7GIZeXCOTl2CZ01ppi09iLoKRGVDd6VOZQT5ApdRFZMIO17CsCqbwRUs28X
	 D+w+/WNq4y8QA==
Date: Wed, 17 Dec 2025 20:07:12 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 3/9] ftrace: Export some of hash related
 functions
Message-ID: <20251217200712.606a9a7a@robin>
In-Reply-To: <20251215211402.353056-4-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-4-jolsa@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 22:13:56 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> index 505b7d3f5641..c0a72fcae1f6 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -82,6 +82,7 @@ static inline void early_trace_init(void) { }
>  
>  struct module;
>  struct ftrace_hash;
> +struct ftrace_func_entry;
>  
>  #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
>  	defined(CONFIG_DYNAMIC_FTRACE)
> @@ -405,6 +406,14 @@ enum ftrace_ops_cmd {
>  typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +
> +#define FTRACE_HASH_DEFAULT_BITS 10
> +
> +struct ftrace_hash *alloc_ftrace_hash(int size_bits);
> +void free_ftrace_hash(struct ftrace_hash *hash);
> +struct ftrace_func_entry *add_hash_entry_direct(struct ftrace_hash *hash,

As this is no longer static and is exported to other users within the
kernel, it should be renamed to: add_ftrace_hash_entry_direct()
to keep the namespace unique.

-- Steve

> +						unsigned long ip, unsigned long direct);
> +
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {
>  	struct ftrace_hash __rcu	*notrace_hash;

