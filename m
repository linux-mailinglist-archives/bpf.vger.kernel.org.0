Return-Path: <bpf+bounces-26330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33F89E5BD
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA801F228EF
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A88158D6F;
	Tue,  9 Apr 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK419PTP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF771433A6;
	Tue,  9 Apr 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702985; cv=none; b=CXBFIx3cfyyonCvoQZMRTnPnpbzbEDs+3hMOSUKDKQBGe/YoutqRTD2+AfybcF7LXQ277ohu4hxRLs4y4lxRqtgh9s9fnMJclfnDRMcy1FKsQWdTqWXNZf5uaYc5Hd+dE12Dfjl+dH1CuS/vaPEiTiRqjyGJoWkBaROvT6249kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702985; c=relaxed/simple;
	bh=NnRXDhS5EvKEH7DqITyT3f5FZAqsFmG8sTlfOWAZ5y4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tAOV6UY9TGrZHtA5zDIOg63t7hdowtS5LQ+45xD5EOBL5n4Ml9Tfldlj5514cr/dwyfSfmqUbMaXtXGGNgXxKsJfLXlYZAi6S8+Z3FBnnyj97FzO7B7DUTYGHgygC1SgUY0SRAp97rqv0N5WJfLlsMDGJsm6i7NOPYt0Pr6XGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK419PTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BA2C433C7;
	Tue,  9 Apr 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712702985;
	bh=NnRXDhS5EvKEH7DqITyT3f5FZAqsFmG8sTlfOWAZ5y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JK419PTPLD8zXblqm8PKDxIyXQO62zUNZ35D3I3K1EYGrmo3wm/zV6jMO4TO0Zbqg
	 zkK1vU4f7pN0U5v5aLN3W0xv8tzWRaFrt9r57F3Ix6KxDLSdqVg74laMNmulKGSXtg
	 Vk7kasFiVFhkImsDTSvDcMbWru+dfFOl0+GhbergELqVYE4S55OlRyf3rEGyplxwUn
	 EvZ1UdehIq4FrpZT/NGFT758FeXT/n86Ujb7BCA7qG4E1J+4Y1JohwdVujCzYALD66
	 e8m8hI0oAzqZ9gzoZCUqzvUCWJk8Q8pvm9P/qTljFj8zOYRIjSAl/3I/sGRkQgFVll
	 TP6yLLM/KqrAA==
Date: Wed, 10 Apr 2024 07:49:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>
Subject: Re: [PATCH v3 1/2] ftrace: make extra rcu_is_watching() validation
 check optional
Message-Id: <20240410074941.7182e5b8ce2113227709c7fc@kernel.org>
In-Reply-To: <20240403220328.455786-1-andrii@kernel.org>
References: <20240403220328.455786-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 15:03:27 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
> control whether ftrace low-level code performs additional
> rcu_is_watching()-based validation logic in an attempt to catch noinstr
> violations.
> 
> This check is expected to never be true and is mostly useful for
> low-level validation of ftrace subsystem invariants. For most users it
> should probably be kept disabled to eliminate unnecessary runtime
> overhead.
> 
> This improves BPF multi-kretprobe (relying on ftrace and rethook
> infrastructure) runtime throughput by 2%, according to BPF benchmarks ([0]).
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/
> 

This looks good to me :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/trace_recursion.h |  2 +-
>  kernel/trace/Kconfig            | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index d48cd92d2364..24ea8ac049b4 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
>  # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
>  #endif
>  
> -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
>  # define trace_warn_on_no_rcu(ip)					\
>  	({								\
>  		bool __ret = !rcu_is_watching();			\
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..7aebd1b8f93e 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
>  	  This file can be reset, but the limit can not change in
>  	  size at runtime.
>  
> +config FTRACE_VALIDATE_RCU_IS_WATCHING
> +	bool "Validate RCU is on during ftrace execution"
> +	depends on FUNCTION_TRACER
> +	depends on ARCH_WANTS_NO_INSTR
> +	help
> +	  All callbacks that attach to the function tracing have some sort of
> +	  protection against recursion. This option is only to verify that
> +	  ftrace (and other users of ftrace_test_recursion_trylock()) are not
> +	  called outside of RCU, as if they are, it can cause a race. But it
> +	  also has a noticeable overhead when enabled.
> +
> +	  If unsure, say N
> +
>  config RING_BUFFER_RECORD_RECURSION
>  	bool "Record functions that recurse in the ring buffer"
>  	depends on FTRACE_RECORD_RECURSION
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

