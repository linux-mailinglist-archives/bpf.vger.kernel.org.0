Return-Path: <bpf+bounces-31150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF038D7626
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922EB282825
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64441C6D;
	Sun,  2 Jun 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeZtNGj8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AD40861;
	Sun,  2 Jun 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717337997; cv=none; b=BDvyWzcFf8b/ut+Iyr5rGpK/Zys2kaXXROlEA/cYdgOGmneE0uT5btdr3tzXyBLOvBVpFyrLJ3lf3U0QqIzjz4hoD9llFCQZJET5sKchhmE72JQ5INnuQnLaNM2hL1kFZHksfdy3fu0QeIGd4B5bwOPfpjl/8dEMRBMH/QsgVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717337997; c=relaxed/simple;
	bh=SeH9oWFSVri/bYiL+0r6iXfVRwtJYCiDV4spRm85XH0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ET6Vk4icDIFvzFbwrITYHn8LupPoojii9wUvVBekNUcM1dFNt9BP/e4Jo972cqikMJXJxzFQ09oYw6cZCZUmmu20Os0C1KbdODvckAvxAjaY0+dzyUnPocWh/ZHNfWz1qt9vQ+6uNWLBRPoVxxZtebyJIVr0CD20G0av8j7InjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeZtNGj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE04C2BBFC;
	Sun,  2 Jun 2024 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717337996;
	bh=SeH9oWFSVri/bYiL+0r6iXfVRwtJYCiDV4spRm85XH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aeZtNGj80P6dBrMVhzxBiC8mLZ9bYoUrqmjdD1dEvU+6K0j5kGcQ3+RwXldhxqspA
	 x+cNLqDPTlDhsmZ/k06h+3sQeO9EMu2CpvFATRODDEt7O0Cpwf/7sSAOzeGLePKgw0
	 uFfoLJ2++QZQUHQIPo88cMO/TxUy4IEphA6QNOzR6QJd2uVfjbV+3cA4WPU8c5BJlh
	 c7u9OznZuzTZtyEIRsBExkYRo45mdJnj9zH61RljTC6obWI55KX5iXtvw90b3q3pFf
	 PkarPFFsgewNvIHhvk0+MX/EAIhp9CPaLsEoyZXtftQv83jaCBu0ThMALHgJHXtEYS
	 xOey6ph3aoZKw==
Date: Sun, 2 Jun 2024 23:19:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S
 Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] error-injection: support static keys around
 injectable functions
Message-Id: <20240602231950.cbb7bc65fce96934fb10dc06@kernel.org>
In-Reply-To: <20240531-fault-injection-statickeys-v1-2-a513fd0a9614@suse.cz>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
	<20240531-fault-injection-statickeys-v1-2-a513fd0a9614@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 11:33:33 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> Error injectable functions cannot be inlined and since some are called
> from hot paths, this incurrs overhead even if no error injection is
> enabled for them.
> 
> To remove this overhead when disabled, allow the callsites of error
> injectable functions to put the calls behind a static key, which the
> framework can control when error injection is enabled or disabled for
> the function.
> 
> Introduce a new ALLOW_ERROR_INJECTION_KEY() macro that adds a parameter
> with the static key's address, and store it in struct
> error_injection_entry. This new field has caused a mismatch when
> populating the injection list from the _error_injection_whitelist
> section with the current STRUCT_ALIGN(), so change the alignment to 8.
> 
> During the population, copy the key's address also to struct ei_entry,
> and make it possible to retrieve it along with the error type by
> get_injectable_error_type().
> 
> Finally, make the processing of writes to the debugfs inject file enable
> the static key when the function is added to the injection list, and
> disable when removed.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/asm-generic/error-injection.h | 13 ++++++++++++-
>  include/asm-generic/vmlinux.lds.h     |  2 +-
>  include/linux/error-injection.h       |  9 ++++++---
>  kernel/fail_function.c                | 22 +++++++++++++++++++---
>  lib/error-inject.c                    |  6 +++++-
>  5 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index b05253f68eaa..eed2731f3820 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -12,6 +12,7 @@ enum {
>  
>  struct error_injection_entry {
>  	unsigned long	addr;
> +	unsigned long	static_key_addr;
>  	int		etype;
>  };
>  
> @@ -25,16 +26,26 @@ struct pt_regs;
>   * 'Error Injectable Functions' section.
>   */
>  #define ALLOW_ERROR_INJECTION(fname, _etype)				\
> -static struct error_injection_entry __used				\
> +static struct error_injection_entry __used __aligned(8)			\
>  	__section("_error_injection_whitelist")				\
>  	_eil_addr_##fname = {						\
>  		.addr = (unsigned long)fname,				\
>  		.etype = EI_ETYPE_##_etype,				\
>  	}
>  
> +#define ALLOW_ERROR_INJECTION_KEY(fname, _etype, key)			\
> +static struct error_injection_entry __used __aligned(8)			\
> +	__section("_error_injection_whitelist")				\
> +	_eil_addr_##fname = {						\
> +		.addr = (unsigned long)fname,				\
> +		.static_key_addr = (unsigned long)key,			\
> +		.etype = EI_ETYPE_##_etype,				\
> +	}
> +
>  void override_function_with_return(struct pt_regs *regs);
>  #else
>  #define ALLOW_ERROR_INJECTION(fname, _etype)
> +#define ALLOW_ERROR_INJECTION_KEY(fname, _etype, key)
>  
>  static inline void override_function_with_return(struct pt_regs *regs) { }
>  #endif
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5703526d6ebf..1b15a0af2a00 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -248,7 +248,7 @@
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  #define ERROR_INJECT_WHITELIST()			\
> -	STRUCT_ALIGN();					\
> +	. = ALIGN(8);					\
>  	BOUNDED_SECTION(_error_injection_whitelist)
>  #else
>  #define ERROR_INJECT_WHITELIST()
> diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
> index 20e738f4eae8..bec81b57a9d5 100644
> --- a/include/linux/error-injection.h
> +++ b/include/linux/error-injection.h
> @@ -6,10 +6,12 @@
>  #include <linux/errno.h>
>  #include <asm-generic/error-injection.h>
>  
> +struct static_key;
> +
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  
> -extern bool within_error_injection_list(unsigned long addr);
> -extern int get_injectable_error_type(unsigned long addr);
> +bool within_error_injection_list(unsigned long addr);
> +int get_injectable_error_type(unsigned long addr, struct static_key **key_addr);

This seems like an add-hoc change. Since this is called in a cold path
(only used when adding new function), can you add new 
`struct static_key *get_injection_key(unsigned long addr)`
to find the static_key from the address?

Other part looks good to me.

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

