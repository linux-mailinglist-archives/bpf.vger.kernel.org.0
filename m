Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECA277C4E
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgIXXZv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 19:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 19:25:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8662C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:25:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so809847pgl.10
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7PL1EBxY4NfiWcb/UHJLL71TMtiqKp5+973YnXyw05Y=;
        b=JeYYRWWCf1XLt5Alef5VQ3jetZmSt6IZjjhlaVs8VAV4y+kqwU5cIsRjnhy9qfrwQg
         JZtw7qLg2JprkJ83T3aRf6DXmzC7jAdbmW1nrcYlAcJDbYFxsxlZLc+nsOJP1dy1yPNY
         3SEg5+RFf5BHPvAxUnExj4HochqHAiCwdQjVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7PL1EBxY4NfiWcb/UHJLL71TMtiqKp5+973YnXyw05Y=;
        b=gIfCRbCBEIbVG3zcwmZrVyIaKrTSYNS7hVkJ0KzLyn72vjZpha+62nSuMA9HoGb6Q8
         dUcL3B0rGfSaP0zt4ejCRWcvHf5CileoAjrslbC463ELlkoH4ZVMyK0WULssfk+Pjqwo
         w2wcu2HI9cqdMBeMBZrE70q1eXYj1wQP0As36h72CHr71AV+3sS6T9KfYVGcFlszKUid
         GeaCBlh43KZle29AAbVJNCtq5NEVwVVxNwmiRpsej6jqiI/dfd7RIbsP9rhO6LvKFULk
         ROXzo7qyIwkh6ARvtxxryerQQ+EL8hSjJw/JqL4kmQswVrYIogYTboYZjYBpnR7E9IqQ
         XsaQ==
X-Gm-Message-State: AOAM5326wDWQukaH8mCkMI95xL3dRA+TeKsyMBhY0u+9EgWkxefobvaS
        ZXiuC9W+YXWVVh0XNbZ/Fb8Tag==
X-Google-Smtp-Source: ABdhPJyrnrufXiW/2g1hntSBLfLFEleOVfFpdHqa+7mJiippdYi/DHJ1i5w0H5tXKvZQkbtPlqbG9w==
X-Received: by 2002:aa7:8a46:0:b029:142:2501:398a with SMTP id n6-20020aa78a460000b02901422501398amr1361042pfa.79.1600989950119;
        Thu, 24 Sep 2020 16:25:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm521961pfq.102.2020.09.24.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 16:25:48 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:25:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
Message-ID: <202009241601.FFC0CF68@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <c14518ba563d4c6bb75b9fac63b69cd4c82f9dcc.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14518ba563d4c6bb75b9fac63b69cd4c82f9dcc.1600951211.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 07:44:18AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> access any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
> 
> Each common BPF instruction (stolen from Kees's list [1]) are
> emulated. Any weirdness or loading from a syscall argument will
> cause the emulator to bail.
> 
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
> 
> Filter dependency is resolved at attach time. If a filter depends
> on more filters, then we perform an and on its bitmask against its
> dependee; if the dependee does not guarantee to allow the syscall,
> then the depender is also marked not to guarantee to allow the
> syscall.
> 
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> 
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/Kconfig     |  25 ++++++
>  kernel/seccomp.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 218 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6dfc5673215d..8cc3dc87f253 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -489,6 +489,31 @@ config SECCOMP_FILTER
>  
>  	  See Documentation/userspace-api/seccomp_filter.rst for details.
>  
> +choice
> +	prompt "Seccomp filter cache"
> +	default SECCOMP_CACHE_NONE
> +	depends on SECCOMP_FILTER
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
> +	depends on !HAVE_SPARSE_SYSCALL_NR
> +	help
> +	  For each syscall number, if the seccomp filter has a fixed
> +	  result, store that result in a bitmap to speed up system calls.
> +
> +endchoice

I'm not interested in seccomp having a config option for this. It should
entire exist or not, and that depends on the per-architecture support.
You mentioned in another thread that you wanted it to let people play
with this support in some way. Can you elaborate on this? My perspective
is that of distro and vendor kernels: there is _one_ config and end
users can't really do anything about it without rolling their own
kernels.

> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * struct seccomp_cache_filter_data - container for cache's per-filter data
> + *
> + * @syscall_ok: A bitmap for each architecture number, where each bit
> + *		represents whether the filter will always allow the syscall.
> + */
> +struct seccomp_cache_filter_data {
> +	DECLARE_BITMAP(syscall_ok[ARRAY_SIZE(syscall_arches)], NR_syscalls);
> +};

So, as Jann pointed out, using NR_syscalls only accidentally works --
they're actually different sizes and there isn't strictly any reason to
expect one to be smaller than another. So, we need to either choose the
max() in asm/linux/seccomp.h or be more efficient with space usage and
use explicitly named bitmaps (how my v1 does things).

> +
> +#define SECCOMP_EMU_MAX_PENDING_STATES 64

This isn't used in this patch; likely leftover/in need of moving?

> +#else
> +struct seccomp_cache_filter_data { };
> +
> +static inline int seccomp_cache_prepare(struct seccomp_filter *sfilter)
> +{
> +	return 0;
> +}
> +
> +static inline void seccomp_cache_inherit(struct seccomp_filter *sfilter,
> +					 const struct seccomp_filter *prev)
> +{
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * struct seccomp_filter - container for seccomp BPF programs
>   *
> @@ -185,6 +211,7 @@ struct seccomp_filter {
>  	struct notification *notif;
>  	struct mutex notify_lock;
>  	wait_queue_head_t wqh;
> +	struct seccomp_cache_filter_data cache;

I moved this up in the structure to see if I could benefit from cache
line sharing. In either case, we must verify (with "pahole") that we do
not induce massive padding in the struct.

But yes, attaching this to the filter is the right way to go.

>  };
>  
>  /* Limit any path through the tree to 256KB worth of instructions. */
> @@ -530,6 +557,139 @@ static inline void seccomp_sync_threads(unsigned long flags)
>  	}
>  }
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * struct seccomp_emu_env - container for seccomp emulator environment
> + *
> + * @filter: The cBPF filter instructions.
> + * @nr: The syscall number we are emulating.
> + * @arch: The architecture number we are emulating.
> + * @syscall_ok: Emulation result, whether it is okay for seccomp to cache the
> + *		syscall.
> + */
> +struct seccomp_emu_env {
> +	struct sock_filter *filter;
> +	int arch;
> +	int nr;
> +	bool syscall_ok;

nit: "ok" is too vague. We mean either "constant action" or "allow" (or
"filter" in the negative case).

> +};
> +
> +/**
> + * struct seccomp_emu_state - container for seccomp emulator state
> + *
> + * @next: The next pending state. This structure is a linked list.
> + * @pc: The current program counter.
> + * @areg: the value of that A register.
> + */
> +struct seccomp_emu_state {
> +	struct seccomp_emu_state *next;
> +	int pc;
> +	u32 areg;
> +};

Why is this split out? (i.e. why is it not just a self-contained loop
the way Jann wrote it?)

> +
> +/**
> + * seccomp_emu_step - step one instruction in the emulator
> + * @env: The emulator environment
> + * @state: The emulator state
> + *
> + * Returns 1 to halt emulation, 0 to continue, or -errno if error occurred.

I appreciate the -errno intent, but it actually risks making these
changes break existing userspace filters: if something is unhandled in
the emulator in a way we don't find during design and testing, the
filter load will actually _fail_ instead of just falling back to "run
filter". Failures should be reported (WARN_ON_ONCE()), but my v1
intentionally lets this continue.

> + */
> +static int seccomp_emu_step(struct seccomp_emu_env *env,
> +			    struct seccomp_emu_state *state)
> +{
> +	struct sock_filter *ftest = &env->filter[state->pc++];
> +	u16 code = ftest->code;
> +	u32 k = ftest->k;
> +	bool compare;
> +
> +	switch (code) {
> +	case BPF_LD | BPF_W | BPF_ABS:
> +		if (k == offsetof(struct seccomp_data, nr))
> +			state->areg = env->nr;
> +		else if (k == offsetof(struct seccomp_data, arch))
> +			state->areg = env->arch;
> +		else
> +			return 1;
> +
> +		return 0;
> +	case BPF_JMP | BPF_JA:
> +		state->pc += k;
> +		return 0;
> +	case BPF_JMP | BPF_JEQ | BPF_K:
> +	case BPF_JMP | BPF_JGE | BPF_K:
> +	case BPF_JMP | BPF_JGT | BPF_K:
> +	case BPF_JMP | BPF_JSET | BPF_K:
> +		switch (BPF_OP(code)) {
> +		case BPF_JEQ:
> +			compare = state->areg == k;
> +			break;
> +		case BPF_JGT:
> +			compare = state->areg > k;
> +			break;
> +		case BPF_JGE:
> +			compare = state->areg >= k;
> +			break;
> +		case BPF_JSET:
> +			compare = state->areg & k;
> +			break;
> +		default:
> +			WARN_ON(true);
> +			return -EINVAL;
> +		}
> +
> +		state->pc += compare ? ftest->jt : ftest->jf;
> +		return 0;
> +	case BPF_ALU | BPF_AND | BPF_K:
> +		state->areg &= k;
> +		return 0;
> +	case BPF_RET | BPF_K:
> +		env->syscall_ok = k == SECCOMP_RET_ALLOW;
> +		return 1;
> +	default:
> +		return 1;
> +	}
> +}

This version appears to have removed all the comments; I liked Jann's
comments and I had rearranged things a bit to make it more readable
(IMO) for people that do not immediate understand BPF. :)

> +
> +/**
> + * seccomp_cache_prepare - emulate the filter to find cachable syscalls
> + * @sfilter: The seccomp filter
> + *
> + * Returns 0 if successful or -errno if error occurred.
> + */
> +int seccomp_cache_prepare(struct seccomp_filter *sfilter)
> +{
> +	struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
> +	struct sock_filter *filter = fprog->filter;
> +	int arch, nr, res = 0;
> +
> +	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
> +		for (nr = 0; nr < NR_syscalls; nr++) {
> +			struct seccomp_emu_env env = {0};
> +			struct seccomp_emu_state state = {0};
> +
> +			env.filter = filter;
> +			env.arch = syscall_arches[arch];
> +			env.nr = nr;
> +
> +			while (true) {
> +				res = seccomp_emu_step(&env, &state);
> +				if (res)
> +					break;
> +			}
> +
> +			if (res < 0)
> +				goto out;
> +
> +			if (env.syscall_ok)
> +				set_bit(nr, sfilter->cache.syscall_ok[arch]);

I don't really like the complexity here, passing around syscall_ok, etc.
I feel like seccomp_emu_step() should be self-contained to say "allow or
filter" directly.

I also prefer an inversion to the logic: if we start bitmaps as "default
allow", we only ever increase the filtering cases: we can never
accidentally ADD an allow to the bitmap. (This was an intentional design
in the RFC and v1 to do as much as possible to fail safe.)

> +		}
> +	}
> +
> +out:
> +	return res;
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * seccomp_prepare_filter: Prepares a seccomp filter for use.
>   * @fprog: BPF program to install
> @@ -540,7 +700,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>  {
>  	struct seccomp_filter *sfilter;
>  	int ret;
> -	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
> +	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
> +			       IS_ENABLED(CONFIG_SECCOMP_CACHE_NR_ONLY);
>  
>  	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
>  		return ERR_PTR(-EINVAL);
> @@ -571,6 +732,13 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>  		return ERR_PTR(ret);
>  	}
>  
> +	ret = seccomp_cache_prepare(sfilter);
> +	if (ret < 0) {
> +		bpf_prog_destroy(sfilter->prog);
> +		kfree(sfilter);
> +		return ERR_PTR(ret);
> +	}

Why do the prepare here instead of during attach? (And note that it
should not be written to fail.)

> +
>  	refcount_set(&sfilter->refs, 1);
>  	refcount_set(&sfilter->users, 1);
>  	init_waitqueue_head(&sfilter->wqh);
> @@ -606,6 +774,29 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>  	return filter;
>  }
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * seccomp_cache_inherit - mask accept bitmap against previous filter
> + * @sfilter: The seccomp filter
> + * @sfilter: The previous seccomp filter
> + */
> +static void seccomp_cache_inherit(struct seccomp_filter *sfilter,
> +				  const struct seccomp_filter *prev)
> +{
> +	int arch;
> +
> +	if (!prev)
> +		return;
> +
> +	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
> +		bitmap_and(sfilter->cache.syscall_ok[arch],
> +			   sfilter->cache.syscall_ok[arch],
> +			   prev->cache.syscall_ok[arch],
> +			   NR_syscalls);
> +	}

And, as per being as defensive as I can imagine, this should be a
one-way mask: we can only remove bits from syscall_ok, never add them.
sfilter must be constructed so that it can only ever have fewer or the
same bits set as prev.

> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * seccomp_attach_filter: validate and attach filter
>   * @flags:  flags to change filter behavior
> @@ -655,6 +846,7 @@ static long seccomp_attach_filter(unsigned int flags,
>  	 * task reference.
>  	 */
>  	filter->prev = current->seccomp.filter;
> +	seccomp_cache_inherit(filter, filter->prev);

In the RFC I did this inherit earlier (in the emulation stage) to
benefit from the RET_KILL results, but that's not very useful any more.
However, I think it's still code-locality better to keep the bit
manipulation logic as close together as possible for readability.

>  	current->seccomp.filter = filter;
>  	atomic_inc(&current->seccomp.filter_count);
>  
> -- 
> 2.28.0
> 

-- 
Kees Cook
