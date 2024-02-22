Return-Path: <bpf+bounces-22520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4B8602AC
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B41C23CBB
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC00548E6;
	Thu, 22 Feb 2024 19:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E554912;
	Thu, 22 Feb 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630099; cv=none; b=urs+YfaUkWgJRwI8/rVwMl/FsyK9mCs24C7TcT8bywJ7ZtjDhJz/zWvmivkvYcaAPCd8JWVOr1tkp1ehcSwVbk6qVtplCotJlAgx0cjuzQeJ3FTtVWMurGQAds3bmSMW2D4gXh80GVKwuFkGC0c15xQphHxCMPLbLwOCuscJxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630099; c=relaxed/simple;
	bh=9b8XTulk2QF1sfxc4c5foOvPMIs5CgMKk2ts2maQPYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQR1C7UQY1M2lvucGvWJFo+mCqpYHncDCzecNmRFB6Ej5XNCnLMuQsFZa9JrqdfQ6EJOnR+36UXh/Ji+UWG4oGjF0l4ouGKzYXMgKADgTL+cjfSk9T8PhqRSVmZvy3lMF1QY2aKY+iqScvrk/yGUY3fBwR03VHm+MwWrGGKg+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10F9C433F1;
	Thu, 22 Feb 2024 19:28:15 +0000 (UTC)
Date: Thu, 22 Feb 2024 19:28:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64: stacktrace: Implement
 arch_bpf_stack_walk() for the BPF JIT
Message-ID: <ZdegTX9x2ye-7xIt@arm.com>
References: <20240201125225.72796-1-puranjay12@gmail.com>
 <20240201125225.72796-2-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201125225.72796-2-puranjay12@gmail.com>

On Thu, Feb 01, 2024 at 12:52:24PM +0000, Puranjay Mohan wrote:
> This will be used by bpf_throw() to unwind till the program marked as
> exception boundary and run the callback with the stack of the main
> program.
> 
> This is required for supporting BPF exceptions on ARM64.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 7f88028a00c0..66cffc5fc0be 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/efi.h>
>  #include <linux/export.h>
> +#include <linux/filter.h>
>  #include <linux/ftrace.h>
>  #include <linux/kprobes.h>
>  #include <linux/sched.h>
> @@ -266,6 +267,31 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  	kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs);
>  }
>  
> +struct bpf_unwind_consume_entry_data {
> +	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
> +	void *cookie;
> +};
> +
> +static bool
> +arch_bpf_unwind_consume_entry(const struct kunwind_state *state, void *cookie)
> +{
> +	struct bpf_unwind_consume_entry_data *data = cookie;
> +
> +	return data->consume_entry(data->cookie, state->common.pc, 0,
> +				   state->common.fp);
> +}
> +
> +noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void *cookie, u64 ip, u64 sp,
> +								u64 fp), void *cookie)
> +{
> +	struct bpf_unwind_consume_entry_data data = {
> +		.consume_entry = consume_entry,
> +		.cookie = cookie,
> +	};
> +
> +	kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current, NULL);
> +}

Too many "cookies", I found reading this confusing. If you ever respin,
please use some different "cookie" names.

I guess you want this to be merged via the bpf tree?

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

