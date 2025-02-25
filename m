Return-Path: <bpf+bounces-52555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A2A449BA
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0540868124
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702ED19EEBF;
	Tue, 25 Feb 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkkGLWS7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F219D88F;
	Tue, 25 Feb 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506452; cv=none; b=EiZM7lrjnZA4Tb74SgwrCoX5F/u8Y7l1vaztMTNRhQfGK6gd1E+SSJyIxaP9J4mEswFYPxQ1yCdeuBLA2ztMhceEqVatm8u6BIlr53aAOz97PEnzioPszv0KtpD285YRjgMOfiDLGqOBEvgbSYVNMih55oG9M+9WYepsM9zajQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506452; c=relaxed/simple;
	bh=HlX8DGTi9nlLo2x1LU/ru3/CQMoDi9iaqMlhlLom/Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlOICuQaK27WPwRYTyrMDasTZ21EjHn65MUJc3HlrJhM/f+Mz3AzMZDJ/1Q5ZjFpXRLrr3xAe3llXuGpMTWCOCTzkdCO1tGt4n+75J3S5CqpxCeWMUewGEgzUaXRRpeB3i6K7hDDJDWqtgIJZbSGn2xpD7dhZ5eqtWoYxnStI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkkGLWS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C29C4CEDD;
	Tue, 25 Feb 2025 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506451;
	bh=HlX8DGTi9nlLo2x1LU/ru3/CQMoDi9iaqMlhlLom/Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkkGLWS7I4U/Tu8ufmRHEFa5dZlmB0zA/1VzZkqyK4uMLmiWLepcNXTZ07W9vTqC8
	 QYyzE5opMVpatD+MjawiqGwK45AUlHwbAYPe3I9esEw2mloPUPZRYUJXDIAdk7JkE4
	 Ydy1yYUFFBIFuSTms75YI4yz3Ynbbb+PsYLBQQ0zj0bCQAGYo+3g5JOu8bBlL+QPnv
	 z8p65oX7D4E7apD1UlPlvA2xTZDRiNNwfq+t8wsEjn/vM562WhJMoh1NmXe8LULRM3
	 m579cJNTcOzgbsn4pHlWcZxDffmvFC0DZPpfV+oJNobbBLz+hNO4OGooZLBEISCQ/T
	 jFuCpsbg589Aw==
Date: Tue, 25 Feb 2025 11:00:44 -0700
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
Message-ID: <20250225180044.GA3655100@ax162>
References: <20250219151815.734900568@goodmis.org>
 <20250219151904.476350486@goodmis.org>
 <20250225025631.GA271248@ax162>
 <20250224222833.0a9f2f4c@batman.local.home>
 <20250225104726.5e4eed32@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225104726.5e4eed32@gandalf.local.home>

On Tue, Feb 25, 2025 at 10:47:26AM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 22:28:33 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Thanks, I'm about to go to bed soon and I'll take a look more into it tomorrow.
> 
> Can you try this patch (it has the clang fix too).

Yup, that appears to fix all my issues with my initial tests.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 27c8def2139d..bec7b5dbdb3b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7004,7 +7004,6 @@ static int ftrace_process_locs(struct module *mod,
>  	unsigned long count;
>  	unsigned long *p;
>  	unsigned long addr;
> -	unsigned long kaslr;
>  	unsigned long flags = 0; /* Shut up gcc */
>  	unsigned long pages;
>  	int ret = -ENOMEM;
> @@ -7056,25 +7055,37 @@ static int ftrace_process_locs(struct module *mod,
>  		ftrace_pages->next = start_pg;
>  	}
>  
> -	/* For zeroed locations that were shifted for core kernel */
> -	kaslr = !mod ? kaslr_offset() : 0;
> -
>  	p = start;
>  	pg = start_pg;
>  	while (p < end) {
>  		unsigned long end_offset;
> -		addr = ftrace_call_adjust(*p++);
> +
> +		addr = *p++;
> +
>  		/*
>  		 * Some architecture linkers will pad between
>  		 * the different mcount_loc sections of different
>  		 * object files to satisfy alignments.
>  		 * Skip any NULL pointers.
>  		 */
> -		if (!addr || addr == kaslr) {
> +		if (!addr) {
> +			skipped++;
> +			continue;
> +		}
> +
> +		/*
> +		 * If this is core kernel, make sure the address is in core
> +		 * or inittext, as weak functions get zeroed and KASLR can
> +		 * move them to something other than zero. It just will not
> +		 * move it to an area where kernel text is.
> +		 */
> +		if (!mod && !(is_kernel_text(addr) || is_kernel_inittext(addr))) {
>  			skipped++;
>  			continue;
>  		}
>  
> +		addr = ftrace_call_adjust(addr);
> +
>  		end_offset = (pg->index+1) * sizeof(pg->records[0]);
>  		if (end_offset > PAGE_SIZE << pg->order) {
>  			/* We should have allocated enough */
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 23c7e0e6c024..7b4b3714b1af 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -611,13 +611,16 @@ static int add_field(uint64_t addr, uint64_t size)
>  	return 0;
>  }
>  
> +/* Used for when mcount/fentry is before the function entry */
> +static int before_func;
> +
>  /* Only return match if the address lies inside the function size */
>  static int cmp_func_addr(const void *K, const void *A)
>  {
>  	uint64_t key = *(const uint64_t *)K;
>  	const struct func_info *a = A;
>  
> -	if (key < a->addr)
> +	if (key + before_func < a->addr)
>  		return -1;
>  	return key >= a->addr + a->size;
>  }
> @@ -827,9 +830,14 @@ static void *sort_mcount_loc(void *arg)
>  		pthread_exit(m_err);
>  	}
>  
> -	if (sort_reloc)
> +	if (sort_reloc) {
>  		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
> -	else
> +		/* gcc may use relocs to save the addresses, but clang does not. */
> +		if (!count) {
> +			count = fill_addrs(vals, size, start_loc);
> +			sort_reloc = 0;
> +		}
> +	} else
>  		count = fill_addrs(vals, size, start_loc);
>  
>  	if (count < 0) {
> @@ -1248,6 +1256,8 @@ static int do_file(char const *const fname, void *addr)
>  #ifdef MCOUNT_SORT_ENABLED
>  		sort_reloc = true;
>  		rela_type = 0x403;
> +		/* arm64 uses patchable function entry placing before function */
> +		before_func = 8;
>  #endif
>  		/* fallthrough */
>  	case EM_386:

