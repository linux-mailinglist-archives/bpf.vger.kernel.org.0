Return-Path: <bpf+bounces-52402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52DA42AB1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806E517608C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54383264FA6;
	Mon, 24 Feb 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qelw19KD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3122641D8;
	Mon, 24 Feb 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420492; cv=none; b=JbglQWOQEMnUSxa2TweNaaGY/tzNAeLjUKCgb0fjE0aIuAoGtQvhaD+uDu5fC9+qmWnvTw9JBmC7GfxKMer+SuL5xzV9lJbbMiql59gKGehTTt3fis9/Q+H93ZIPKgyzGMPgI1wsEuMsjm1UL3doL+0wlG4/NvidmH1drR0RXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420492; c=relaxed/simple;
	bh=OAGKsUmy5EtMSVfMc9WTBde8Uxv0P28mK2h80COKX7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYuG6iuLw5OagsKp+F1lrB6u+NHE4yUw/pYWbKKXTLDHFe6QEJ0F/8Whx5D0jWO8i2+nLsyxpzoEoBjFGSOSJ+cuhq0Q9Ax/ZYvVKXHkkfXLH17mavvgjlsPnJ3NS6gK87Mh1ZiieI2F4y2PIwryaBgHxlN/YekJ5YBy0apRPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qelw19KD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68671C4CED6;
	Mon, 24 Feb 2025 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740420492;
	bh=OAGKsUmy5EtMSVfMc9WTBde8Uxv0P28mK2h80COKX7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qelw19KDNu3QrsBuONGuAhKFvM8rTeBIVxDIr1U788i1+zWZCnhxgLph12LRkIbXr
	 3+uXYdtoIHMNlQD+kSDJO9bwuz8oQmuaY7lgUqp81HJ2/QomcbuHb7/8KFjHe4z8PI
	 AAFcpOyN0Xi30jU2JDvk/sciKh8+U60Yzsg4Ym/+czneNs3tp1qj+K9p9bfrdi0S/x
	 1/OBrHyUC+vonPIlWNYbJiQhhPDZP9iySdKmMxeg4GmFfOAC+Pgzr6jqpUUrqsjw0K
	 Sa3Qdwe3Mg42KjWZRNx2YPyMK8V/J71bprho2oxqyCGekYgEVUwyMzhYJeUrDKQT+C
	 BkeKqEgaS7XGg==
Date: Mon, 24 Feb 2025 10:08:05 -0800
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [for-next][PATCH 4/6] scripts/sorttable: Zero out weak functions
 in mcount_loc table
Message-ID: <20250224180805.GA1536711@ax162>
References: <20250219151815.734900568@goodmis.org>
 <20250219151904.476350486@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219151904.476350486@goodmis.org>

Hi Steve,

On Wed, Feb 19, 2025 at 10:18:19AM -0500, Steven Rostedt wrote:
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 728ecda6e8d4..e3f89924f603 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7004,6 +7004,7 @@ static int ftrace_process_locs(struct module *mod,
>  	unsigned long count;
>  	unsigned long *p;
>  	unsigned long addr;
> +	unsigned long kaslr;
>  	unsigned long flags = 0; /* Shut up gcc */
>  	int ret = -ENOMEM;
>  
> @@ -7052,6 +7053,9 @@ static int ftrace_process_locs(struct module *mod,
>  		ftrace_pages->next = start_pg;
>  	}
>  
> +	/* For zeroed locations that were shifted for core kernel */
> +	kaslr = !mod ? kaslr_offset() : 0;
> +
>  	p = start;
>  	pg = start_pg;
>  	while (p < end) {
> @@ -7063,7 +7067,7 @@ static int ftrace_process_locs(struct module *mod,
>  		 * object files to satisfy alignments.
>  		 * Skip any NULL pointers.
>  		 */
> -		if (!addr) {
> +		if (!addr || addr == kaslr) {
>  			skipped++;
>  			continue;
>  		}

Our CI and KernelCI reports that this change as commit ef378c3b8233
("scripts/sorttable: Zero out weak functions in mcount_loc table") in
next-20250224 breaks when an architecture does not have kaslr_offset()
defined:

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/trace/ftrace.o
  kernel/trace/ftrace.c: In function 'ftrace_process_locs':
  kernel/trace/ftrace.c:7074:24: error: implicit declaration of function 'kaslr_offset' [-Wimplicit-function-declaration]
   7074 |         kaslr = !mod ? kaslr_offset() : 0;
        |                        ^~~~~~~~~~~~

https://lore.kernel.org/CACo-S-0GeJjWWcrGvos_Avg2FwGU2tj2QZpgoHOvPT+YbyknSg@mail.gmail.com/

Cheers,
Nathan

