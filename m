Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE427F551
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgI3Wko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgI3Wko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 18:40:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72654C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:40:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so2212999pgi.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LsxsZrDzkouRJ2pUxeyyFLAZmCu65IyaU6WvZaLdE/U=;
        b=RsmQBKhr4pZRmeGux2XNBLISS7y3MbYKhnML9q9HFynIk3GLZW20hbw6ENV+hC3XbU
         eKRdRkE4PAqXC4ZwcN2gXw3ySAeS7eXEjYsqROW7d6mU0q+VFFw/t1tceXltJEb6hsJa
         MA3FStHAILuzrGBQTeg4kotVht+DbVoeZFH5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LsxsZrDzkouRJ2pUxeyyFLAZmCu65IyaU6WvZaLdE/U=;
        b=aGrZEUh/oCyD0wXmjN5y3dRy5Gjjl8TZNdW498wd6ZkNx/FpKWxAEN4JKuS/FG7Le1
         M90DIT7cDYuN8JzX1v5zb9YMRXj58T1FNSGhSvksO/K3sxozRoraKdYW1SjAN65+ptYX
         bBYlJoe678TkrJKzeLwxyAsAckMnm4NqAPx9wkMS2KXF/VbzDCRgV37zbVLqh7M23Eub
         XKQ6+NoIQnU4uxtorC6DlS7e70m9MT/CMG2kOZnbTou3M5IZgMCGStV8Jh/ke3sYdAqn
         ne5qbJ7nETExbKGl0pTY6dphIfQ/z9o11LkX1k9lXZtSFS53O61rkGbj+ct8UCxPLjl9
         BEOw==
X-Gm-Message-State: AOAM5326cK/FFNd+i/3bujRApP1ldojCyOnwZEDBI7JOcyL9UJQWtkaS
        gORlaQuWz6HlDGds122lF0N/gA==
X-Google-Smtp-Source: ABdhPJxPoJ8vHaET6JZ/zqCUiaiX9D18jy6GhQHyPyWyhHFbKJVnl4O9cxcYbYh0VGISWrRwymAKcQ==
X-Received: by 2002:a17:902:6bc1:b029:d0:cbe1:e73d with SMTP id m1-20020a1709026bc1b02900d0cbe1e73dmr4569073plt.24.1601505643841;
        Wed, 30 Sep 2020 15:40:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d77sm3775731pfd.121.2020.09.30.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:42 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:40:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>, Jann Horn <jannh@google.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
Message-ID: <202009301432.C862BBC4B@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 10:19:13AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> access any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
> 
> Each common BPF instruction are emulated. Any weirdness or loading
> from a syscall argument will cause the emulator to bail.
> 
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
> 
> Emulator structure and comments are from Kees [1] and Jann [2].
> 
> Emulation is done at attach time. If a filter depends on more
> filters, and if the dependee does not guarantee to allow the
> syscall, then we skip the emulation of this syscall.
> 
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
> 
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

See comments on patch 3 for reorganizing this a bit for the next
version.

For the infrastructure patch, I'd like to see much of the cover letter
in the commit log (otherwise those details are harder for people to
find). That will describe the _why_ for preparing this change, etc.

For the emulator patch, I'd like to see the discussion about how the
subset of BFP instructions was selected, what libraries  Jann and I
examined, etc.

(For all of these commit logs, I try to pretend that whoever is reading
it has not followed any lkml thread of discussion, etc.)

> ---
>  arch/Kconfig     |  34 ++++++++++
>  arch/x86/Kconfig |   1 +
>  kernel/seccomp.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 201 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 21a3675a7a3a..ca867b2a5d71 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -471,6 +471,14 @@ config HAVE_ARCH_SECCOMP_FILTER
>  	    results in the system call being skipped immediately.
>  	  - seccomp syscall wired up
>  
> +config HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
> +	bool
> +	help
> +	  An arch should select this symbol if it provides all of these things:
> +	  - all the requirements for HAVE_ARCH_SECCOMP_FILTER
> +	  - SECCOMP_ARCH_DEFAULT
> +	  - SECCOMP_ARCH_DEFAULT_NR
> +

There's no need for this config and the per-arch Kconfig clutter:
SECCOMP_ARCH_NATIVE will be a sufficient gate.

>  config SECCOMP
>  	prompt "Enable seccomp to safely execute untrusted bytecode"
>  	def_bool y
> @@ -498,6 +506,32 @@ config SECCOMP_FILTER
>  
>  	  See Documentation/userspace-api/seccomp_filter.rst for details.
>  
> +choice
> +	prompt "Seccomp filter cache"
> +	default SECCOMP_CACHE_NONE
> +	depends on SECCOMP_FILTER
> +	depends on HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
> +	help
> +	  Seccomp filters can potentially incur large overhead for each
> +	  system call. This can alleviate some of the overhead.
> +
> +	  If in doubt, select 'syscall numbers only'.
> +
> +config SECCOMP_CACHE_NONE
> +	bool "None"
> +	help
> +	  No caching is done. Seccomp filters will be called each time
> +	  a system call occurs in a seccomp-guarded task.
> +
> +config SECCOMP_CACHE_NR_ONLY
> +	bool "Syscall number only"
> +	depends on HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
> +	help
> +	  For each syscall number, if the seccomp filter has a fixed
> +	  result, store that result in a bitmap to speed up system calls.
> +
> +endchoice

I don't want this config: there is only 1 caching mechanism happening
in this series and I do not want to have it buildable as "off": it
should be available for all supported architectures. When further caching
methods happen, the config can be introduced then (though I'll likely
argue it should then be a boot param to allow distro kernels to make it
selectable).

> +
>  config HAVE_ARCH_STACKLEAK
>  	bool
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1ab22869a765..ff5289228ea5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -150,6 +150,7 @@ config X86
>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ae6b40cc39f4..f09c9e74ae05 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,6 +143,37 @@ struct notification {
>  	struct list_head notifications;
>  };
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * struct seccomp_cache_filter_data - container for cache's per-filter data

naming nits: "data" doesn't tell me anything. "seccomp_action_cache"
might be better. Or since it's an internal struct, maybe just
"action_cache". And let's not use the word "container" for the kerndoc. ;)
How about "per-filter cache of seccomp actions per arch/syscall pair"

> + *
> + * Tis struct is ordered to minimize padding holes.

typo: This

> + *
> + * @syscall_allow_default: A bitmap where each bit represents whether the
> + *			   filter willalways allow the syscall, for the

typo: missing space

> + *			   default architecture.

default -> native

> + * @syscall_allow_compat: A bitmap where each bit represents whether the
> + *		          filter will always allow the syscall, for the
> + *			  compat architecture.
> + */
> +struct seccomp_cache_filter_data {
> +#ifdef SECCOMP_ARCH_DEFAULT
> +	DECLARE_BITMAP(syscall_allow_default, SECCOMP_ARCH_DEFAULT_NR);

naming nit: "syscall" is redundant here, IMO. "allow_native" should be
fine.

> +#endif
> +#ifdef SECCOMP_ARCH_COMPAT
> +	DECLARE_BITMAP(syscall_allow_compat, SECCOMP_ARCH_COMPAT_NR);
> +#endif
> +};
> +
> +#define SECCOMP_EMU_MAX_PENDING_STATES 64
> +#else
> +struct seccomp_cache_filter_data { };
> +
> +static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
> +{
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * struct seccomp_filter - container for seccomp BPF programs
>   *
> @@ -159,6 +190,7 @@ struct notification {
>   *	   this filter after reaching 0. The @users count is always smaller
>   *	   or equal to @refs. Hence, reaching 0 for @users does not mean
>   *	   the filter can be freed.
> + * @cache: container for cache-related data.

more descriptive: "cache of arch/syscall mappings to actions"

>   * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
>   * @prev: points to a previously installed, or inherited, filter
>   * @prog: the BPF program to evaluate
> @@ -180,6 +212,7 @@ struct seccomp_filter {
>  	refcount_t refs;
>  	refcount_t users;
>  	bool log;
> +	struct seccomp_cache_filter_data cache;
>  	struct seccomp_filter *prev;
>  	struct bpf_prog *prog;
>  	struct notification *notif;
> @@ -544,7 +577,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>  {
>  	struct seccomp_filter *sfilter;
>  	int ret;
> -	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
> +	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
> +			       IS_ENABLED(CONFIG_SECCOMP_CACHE_NR_ONLY);
>  
>  	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
>  		return ERR_PTR(-EINVAL);
> @@ -610,6 +644,136 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>  	return filter;
>  }
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * seccomp_emu_is_const_allow - check if filter is constant allow with given data
> + * @fprog: The BPF programs
> + * @sd: The seccomp data to check against, only syscall number are arch
> + *      number are considered constant.
> + */
> +static bool seccomp_emu_is_const_allow(struct sock_fprog_kern *fprog,
> +				       struct seccomp_data *sd)

naming: I would drop "emu" from here. The caller doesn't care how it is
determined. ;)

> +{
> +	unsigned int insns;
> +	unsigned int reg_value = 0;
> +	unsigned int pc;
> +	bool op_res;
> +
> +	if (WARN_ON_ONCE(!fprog))
> +		return false;
> +
> +	insns = bpf_classic_proglen(fprog);
> +	for (pc = 0; pc < insns; pc++) {
> +		struct sock_filter *insn = &fprog->filter[pc];
> +		u16 code = insn->code;
> +		u32 k = insn->k;
> +
> +		switch (code) {
> +		case BPF_LD | BPF_W | BPF_ABS:
> +			switch (k) {
> +			case offsetof(struct seccomp_data, nr):
> +				reg_value = sd->nr;
> +				break;
> +			case offsetof(struct seccomp_data, arch):
> +				reg_value = sd->arch;
> +				break;
> +			default:
> +				/* can't optimize (non-constant value load) */
> +				return false;
> +			}
> +			break;
> +		case BPF_RET | BPF_K:
> +			/* reached return with constant values only, check allow */
> +			return k == SECCOMP_RET_ALLOW;
> +		case BPF_JMP | BPF_JA:
> +			pc += insn->k;
> +			break;
> +		case BPF_JMP | BPF_JEQ | BPF_K:
> +		case BPF_JMP | BPF_JGE | BPF_K:
> +		case BPF_JMP | BPF_JGT | BPF_K:
> +		case BPF_JMP | BPF_JSET | BPF_K:
> +			switch (BPF_OP(code)) {
> +			case BPF_JEQ:
> +				op_res = reg_value == k;
> +				break;
> +			case BPF_JGE:
> +				op_res = reg_value >= k;
> +				break;
> +			case BPF_JGT:
> +				op_res = reg_value > k;
> +				break;
> +			case BPF_JSET:
> +				op_res = !!(reg_value & k);
> +				break;
> +			default:
> +				/* can't optimize (unknown jump) */
> +				return false;
> +			}
> +
> +			pc += op_res ? insn->jt : insn->jf;
> +			break;
> +		case BPF_ALU | BPF_AND | BPF_K:
> +			reg_value &= k;
> +			break;
> +		default:
> +			/* can't optimize (unknown insn) */
> +			return false;
> +		}
> +	}
> +
> +	/* ran off the end of the filter?! */
> +	WARN_ON(1);
> +	return false;
> +}

For the emulator patch, you'll want to include these tags in the commit
log:

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>

> +
> +static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
> +					 void *bitmap, const void *bitmap_prev,
> +					 size_t bitmap_size, int arch)
> +{
> +	struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
> +	struct seccomp_data sd;
> +	int nr;
> +
> +	for (nr = 0; nr < bitmap_size; nr++) {
> +		if (bitmap_prev && !test_bit(nr, bitmap_prev))
> +			continue;
> +
> +		sd.nr = nr;
> +		sd.arch = arch;
> +
> +		if (seccomp_emu_is_const_allow(fprog, &sd))
> +			set_bit(nr, bitmap);

The guiding principle with seccomp's designs is to always make things
_more_ restrictive, never less. While we can never escape the
consequences of having seccomp_is_const_allow() report the wrong
answer, we can at least follow the basic principles, hopefully
minimizing the impact.

When the bitmap starts with "always allowed" and we only flip it towards
"run full filters", we're only ever making things more restrictive. If
we instead go from "run full filters" towards "always allowed", we run
the risk of making things less restrictive. For example: a process that
maliciously adds a filter that the emulator mistakenly evaluates to
"always allow" doesn't suddenly cause all the prior filters to stop running.
(i.e. this isolates the flaw outcome, and doesn't depend on the early
"do not emulate if we already know we have to run filters" case before
the emulation call: there is no code path that allows the cache to
weaken: it can only maintain it being wrong).

Without any seccomp filter installed, all syscalls are "always allowed"
(from the perspective of the seccomp boundary), so the default of the
cache needs to be "always allowed".


	if (bitmap_prev) {
		/* The new filter must be as restrictive as the last. */
		bitmap_copy(bitmap, bitmap_prev, bitmap_size);
	} else {
		/* Before any filters, all syscalls are always allowed. */
		bitmap_fill(bitmap, bitmap_size);
	}

	for (nr = 0; nr < bitmap_size; nr++) {
		/* No bitmap change: not a cacheable action. */
		if (!test_bit(nr, bitmap_prev) ||
			continue;

		/* No bitmap change: continue to always allow. */
		if (seccomp_is_const_allow(fprog, &sd))
			continue;

		/* Not a cacheable action: always run filters. */
		clear_bit(nr, bitmap);

> +	}
> +}
> +
> +/**
> + * seccomp_cache_prepare - emulate the filter to find cachable syscalls
> + * @sfilter: The seccomp filter
> + *
> + * Returns 0 if successful or -errno if error occurred.
> + */
> +static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
> +{
> +	struct seccomp_cache_filter_data *cache = &sfilter->cache;
> +	const struct seccomp_cache_filter_data *cache_prev =
> +		sfilter->prev ? &sfilter->prev->cache : NULL;
> +
> +#ifdef SECCOMP_ARCH_DEFAULT
> +	seccomp_cache_prepare_bitmap(sfilter, cache->syscall_allow_default,
> +				     cache_prev ? cache_prev->syscall_allow_default : NULL,
> +				     SECCOMP_ARCH_DEFAULT_NR,
> +				     SECCOMP_ARCH_DEFAULT);
> +#endif /* SECCOMP_ARCH_DEFAULT */
> +
> +#ifdef SECCOMP_ARCH_COMPAT
> +	seccomp_cache_prepare_bitmap(sfilter, cache->syscall_allow_compat,
> +				     cache_prev ? cache_prev->syscall_allow_compat : NULL,
> +				     SECCOMP_ARCH_COMPAT_NR,
> +				     SECCOMP_ARCH_COMPAT);
> +#endif /* SECCOMP_ARCH_COMPAT */
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * seccomp_attach_filter: validate and attach filter
>   * @flags:  flags to change filter behavior
> @@ -659,6 +823,7 @@ static long seccomp_attach_filter(unsigned int flags,
>  	 * task reference.
>  	 */
>  	filter->prev = current->seccomp.filter;
> +	seccomp_cache_prepare(filter);
>  	current->seccomp.filter = filter;

Jann, do we need a WRITE_ONCE() or something when writing
current->seccomp.filter here? I think the rmb() in __seccomp_filter() will
cover the cache bitmap writes having finished before the filter pointer
is followed in the TSYNC case.

>  	atomic_inc(&current->seccomp.filter_count);
>  
> -- 
> 2.28.0
> 

Otherwise, yes, I'm looking forward to having this for everyone to use!
:)

-- 
Kees Cook
