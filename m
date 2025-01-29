Return-Path: <bpf+bounces-50014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE4CA2162B
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A9B1888A1B
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B2188735;
	Wed, 29 Jan 2025 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1VDZJY3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451342A92;
	Wed, 29 Jan 2025 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114902; cv=none; b=N2+82jlo9jMhTzxwh7/k+TDaquObqoh8dwXya06VrG1fYo7iMJFuI5IyuCBxt3iXLCB7F4G9Jr4grIef5Hr0clyjdGwX+uPX21j0hPI67WdsmBGV/7Z49YI1drnPPZeFOo2PJZ/dCKQxWfsmzt/o4Y0msw74giyr9+QNhv20IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114902; c=relaxed/simple;
	bh=bGrFUj9+jARzNSZm8ZYw/VH0NfaZgjtLxs5bCA+7fBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw3SabY0aVeIjN0MED2rASUugUj+cvDoOsIy70xyNpSuIC9eSohVmC+ZcCQX6w1xCU1Uk2/l6IG7Oq8E8+/sWjg97izv9Yb1KyeUKS/5g2aYroBRwXnUhPckSx93Q+3QMdmBrSlfQDR5wcUn7aycwKcRC+lIJSJ87SuI/+Hen18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1VDZJY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EF3C4CED3;
	Wed, 29 Jan 2025 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738114901;
	bh=bGrFUj9+jARzNSZm8ZYw/VH0NfaZgjtLxs5bCA+7fBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1VDZJY31zisnT5tXOdJh/SXfRGcB2u22K5FAz6ShmEXOMD4RlBCpNo/1jIr2iB49
	 dvQyMubk+4wwg1t9wtRBCPy76ZUWo0EsdmiElXI5NiGL8lpfewdr0iax3VAS0o/I9q
	 7Az7qPldcF9qBawOw08PkYdbZtaj5TRknj8qSNeq6MZ3XxScw55wblEnCkP3oLrBBB
	 ku873wIOswf5+DCp17YdyG9OCIvmNUskG/SwLBGYQwP+8I88Tyce5Q8JpxxwuJ+3Bt
	 bOxX7WmUy7int8WbsZmc09/93D+/YLl+RV6oL6BlJDIr/GNB/Xo51b3h37sM9ADIMB
	 3zvrfEaoX6m5g==
Date: Tue, 28 Jan 2025 17:41:37 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501281634.7F398CEA87@keescook>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128145806.1849977-1-eyal.birger@gmail.com>

On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
> uses the same number as __NR_uretprobe so the syscall isn't forced in the
> compat bitmap.

So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
uretprobe strictly an x86_64 feature?

> [...]
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 385d48293a5f..23b594a68bc0 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>  
>  #ifdef SECCOMP_ARCH_NATIVE
>  /**
> - * seccomp_is_const_allow - check if filter is constant allow with given data
> + * seccomp_is_filter_const_allow - check if filter is constant allow with given data
>   * @fprog: The BPF programs
>   * @sd: The seccomp data to check against, only syscall number and arch
>   *      number are considered constant.
>   */
> -static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> -				   struct seccomp_data *sd)
> +static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fprog,
> +					  struct seccomp_data *sd)
>  {
>  	unsigned int reg_value = 0;
>  	unsigned int pc;
> @@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
>  	return false;
>  }
>  
> +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> +				   struct seccomp_data *sd)
> +{
> +#ifdef __NR_uretprobe
> +	if (sd->nr == __NR_uretprobe
> +#ifdef SECCOMP_ARCH_COMPAT
> +	    && sd->arch != SECCOMP_ARCH_COMPAT
> +#endif

I don't like this because it's not future-proof enough. __NR_uretprobe
may collide with other syscalls at some point. And if __NR_uretprobe_32
is ever implemented, the seccomp logic will be missing. I think this
will work now and in the future:

#ifdef __NR_uretprobe
# ifdef SECCOMP_ARCH_COMPAT
        if (sd->arch == SECCOMP_ARCH_COMPAT) {
#  ifdef __NR_uretprobe_32
                if (sd->nr == __NR_uretprobe_32)
                        return true;
#  endif
        } else
# endif
        if (sd->nr == __NR_uretprobe)
                return true;
#endif

Instead of doing a function rename dance, I think you can just stick
the above into seccomp_is_const_allow() after the WARN().

Also please add a KUnit tests to cover this in
tools/testing/selftests/seccomp/seccomp_bpf.c
With at least these cases combinations below. Check each of:

	- not using uretprobe passes
	- using uretprobe passes (and validates that uretprobe did work)

in each of the following conditions:

	- default-allow filter
	- default-block filter
	- filter explicitly blocking __NR_uretprobe and nothing else
	- filter explicitly allowing __NR_uretprobe (and only other
	  required syscalls)

Hm, is uretprobe expected to work on mips? Because if so, you'll need to
do something similar to the mode1 checking in the !SECCOMP_ARCH_NATIVE
version of seccomp_cache_check_allow().

(You can see why I really dislike having policy baked into seccomp!)

> +	   )
> +		return true;
> +#endif
> +
> +	return seccomp_is_filter_const_allow(fprog, sd);
> +}
> +
>  static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
>  					 void *bitmap, const void *bitmap_prev,
>  					 size_t bitmap_size, int arch)
> @@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
>   */
>  static const int mode1_syscalls[] = {
>  	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
> +#ifdef __NR_uretprobe
> +	__NR_uretprobe,
> +#endif

It'd be nice to update mode1_syscalls_32 with __NR_uretprobe_32 even
though it doesn't exist. (Is it _never_ planned to be implemented?) But
then, maybe the chances of a compat mode1 seccomp process running under
uretprobe is vanishingly small.

>  	-1, /* negative terminated */
>  };
>  
> -- 
> 2.43.0
> 

-Kees

-- 
Kees Cook

