Return-Path: <bpf+bounces-50697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B2A2B411
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F7D188B015
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58BF1DFE3A;
	Thu,  6 Feb 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT26USX7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A21CEAC8;
	Thu,  6 Feb 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876847; cv=none; b=glAAH5P9gl2AUydA1G+VCGaBYlHc/n3K3lxo9ynUj9qQlNPHuWqzy47U2qL6zcId9FkTzjpVkFvAs1NU5I7rVuoVaWkxsb3tesv/Rk2qakpm8sSWgZg/eumSFHeqqhB8QzJLMLMPxy8DyPoTN1qOv3miZbrH3tSHZrfTUyalJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876847; c=relaxed/simple;
	bh=mfJyXij44o3o0oJrdMgXZbXTD7uDgld9x1fyfk43N1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOMvbqsuZ5X+kUd2rifrzEgwGtk4hYJK1ZlHOEPt71bJS7RjJikx1ir9OOdYhhfC8KuBJm4xRrLa+//1wKZq9aGoJqRXRX8GvRa+CVGDfpAd1b/skTm8j4rcBSVoaWFpWP1ZXBWgU+dVbKqofMAd84/cTFdPLwo2XZWcCl8ANFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT26USX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C924C4CEDD;
	Thu,  6 Feb 2025 21:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738876845;
	bh=mfJyXij44o3o0oJrdMgXZbXTD7uDgld9x1fyfk43N1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT26USX7LJYcjhY05L1NYswCMFEDkGEqK+b7cNTcCq6H6cwFcNw5p/H0ugRdSw0Qz
	 YRn1qHMpGxm3JsiUBM/GlLoeQcuW00LbPkTuS6fEj4Yt8tFiNYw3JqoPBGnKbLMMj0
	 /5ZxXfq7Lc9UEt4V9gEMdng8Z4dsqN7yWZWA0BLULn7EbsCW5PPrf+UsvgWq7t/sJf
	 6osJSoIA26geb+gRut7IWeWDcJdyGQy6eWWGr3lFDPIsyji7XzSvK+eW3eiloAlKLm
	 01vYcvkAqYsjiOk19N5HGuRl1Er7HaiqPbHLk5VNjvOsJCr74nng1McgihLJLSdcaU
	 dQwLJcbm+agGg==
Date: Thu, 6 Feb 2025 13:20:45 -0800
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
Subject: Re: [PATCH v3 1/2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202502061320.07B459A@keescook>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <20250202162921.335813-2-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202162921.335813-2-eyal.birger@gmail.com>

On Sun, Feb 02, 2025 at 08:29:20AM -0800, Eyal Birger wrote:
> When attaching uretprobes to processes running inside docker, the attached
> process is segfaulted when encountering the retprobe.
> 
> The reason is that now that uretprobe is a system call the default seccomp
> filters in docker block it as they only allow a specific set of known
> syscalls. This is true for other userspace applications which use seccomp
> to control their syscall surface.
> 
> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, it is impractical and
> there's very little point in forcing all userspace applications to
> explicitly allow it in order to avoid crashing tracked processes.
> 
> Pass this systemcall through seccomp without depending on configuration.
> 
> Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
> uses the same number as __NR_uretprobe so the syscall isn't forced in the
> compat bitmap.
> 
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> Reported-by: Rafael Buchbinder <rafi@rbk.io>
> Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/20250121182939.33d05470@gandalf.local.home/T/#me2676c378eff2d6a33f3054fed4a5f3afa64e65b
> Link: https://lore.kernel.org/lkml/20250128145806.1849977-1-eyal.birger@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> ---
> v3: no change - deferring 32bit compat handling as there aren't plans to
>     support this syscall in compat mode.
> v2: use action_cache bitmap and mode1 array to check the syscall
> ---
>  kernel/seccomp.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f59381c4a2ff..09b6f8e6db51 100644
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

I minimized the above to:

@@ -749,6 +749,15 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 	if (WARN_ON_ONCE(!fprog))
 		return false;
 
+	/* Our single exception to filtering. */
+#ifdef __NR_uretprobe
+#ifdef SECCOMP_ARCH_COMPAT
+	if (sd->arch == SECCOMP_ARCH_NATIVE)
+#endif
+		if (sd->nr == __NR_uretprobe)
+			return true;
+#endif
+
 	for (pc = 0; pc < fprog->len; pc++) {
 		struct sock_filter *insn = &fprog->filter[pc];
 		u16 code = insn->code;

> @@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
>   */
>  static const int mode1_syscalls[] = {
>  	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
> +#ifdef __NR_uretprobe
> +	__NR_uretprobe,
> +#endif
>  	-1, /* negative terminated */
>  };
>  
> -- 
> 2.43.0
> 

-Kees

-- 
Kees Cook

