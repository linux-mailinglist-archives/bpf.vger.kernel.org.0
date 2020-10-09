Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39491289C2D
	for <lists+bpf@lfdr.de>; Sat, 10 Oct 2020 01:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgJIXS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJIXSL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 19:18:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE094C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 16:18:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q123so8127077pfb.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D744gDcHOWXajYrsEOce8eCK8+o4p+P+OG7A3xbJaOo=;
        b=Lr1dfoHemJlX/RIX2hvL2D/L44xa5PQeU7QnVLpPhzAzEOQAlmblx8B40RmQGL/07E
         VCSHsxo6VPYFWmSWRAxyjPtDbXNEFu1QxWriaykwo9hkwNCSPWr3lehsNnYMCBvsFPcq
         5ZaxgqdbhnQ+j6kvffD/AwvtU0IQXPPK+WzIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D744gDcHOWXajYrsEOce8eCK8+o4p+P+OG7A3xbJaOo=;
        b=XbTOdR5T0EGdQI723GDBeOtEUvUue0/zrIvHNYsLQxwTunESO64RDRvUlHnEwFMm5y
         mAR8o110djyb3D0k9vB+i7XRSuWpR/vU3+NRV+Ft+8+/j2WJ//PO5N3l8T2mKJO3UYwB
         23GJeYdTksTX7JQr942rxWEgzOjssI9Md++0NQF41S19M6JDvgtyqETSiZ4v99MXvGCD
         5fCjWXbq/1FNugNQ+Bak+7vU2sqAGOu89hmjsWf/3j/iZf2MJyB54tuJv4pzEbGdcNIz
         ZVRa6++C39+B/p7DfC0ZllZRtCJID4TRRsUX7c6dBMORYozUdUUxbV/pUL9iYsXx+nFg
         pYWg==
X-Gm-Message-State: AOAM533NX25fJGvFO6sC9nuBO1FNVLLcw75AkJVtJXT36YjenXFLxZ7m
        PPf8WgamDquczT5voWsEeswGDZVIJ4jjgg==
X-Google-Smtp-Source: ABdhPJx8ui/HzkhIAhu2rRwKn7Y9jfi9DolNG8cFk6RzmyJOjHiY9uQq6NzZY+18AB3NyWZTy5R5OQ==
X-Received: by 2002:a17:90a:3fcb:: with SMTP id u11mr6950918pjm.128.1602285490320;
        Fri, 09 Oct 2020 16:18:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm11555731pgt.24.2020.10.09.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 16:18:09 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:18:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
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
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 1/5] seccomp/cache: Lookup syscall allowlist
 bitmap for fast path
Message-ID: <202010091614.8BB0EB64@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <896cd9de97318d20c25edb1297db8c65e1cfdf84.1602263422.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <896cd9de97318d20c25edb1297db8c65e1cfdf84.1602263422.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 09, 2020 at 12:14:29PM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> The overhead of running Seccomp filters has been part of some past
> discussions [1][2][3]. Oftentimes, the filters have a large number
> of instructions that check syscall numbers one by one and jump based
> on that. Some users chain BPF filters which further enlarge the
> overhead. A recent work [6] comprehensively measures the Seccomp
> overhead and shows that the overhead is non-negligible and has a
> non-trivial impact on application performance.
> 
> We observed some common filters, such as docker's [4] or
> systemd's [5], will make most decisions based only on the syscall
> numbers, and as past discussions considered, a bitmap where each bit
> represents a syscall makes most sense for these filters.
> 
> The fast (common) path for seccomp should be that the filter permits
> the syscall to pass through, and failing seccomp is expected to be
> an exceptional case; it is not expected for userspace to call a
> denylisted syscall over and over.
> 
> When it can be concluded that an allow must occur for the given
> architecture and syscall pair (this determination is introduced in
> the next commit), seccomp will immediately allow the syscall,
> bypassing further BPF execution.
> 
> Each architecture number has its own bitmap. The architecture
> number in seccomp_data is checked against the defined architecture
> number constant before proceeding to test the bit against the
> bitmap with the syscall number as the index of the bit in the
> bitmap, and if the bit is set, seccomp returns allow. The bitmaps
> are all clear in this patch and will be initialized in the next
> commit.
> 
> [1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
> [2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
> [3] https://github.com/seccomp/libseccomp/issues/116
> [4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
> [5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
> [6] Draco: Architectural and Operating System Support for System Call Security
>     https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020
> 
> Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  kernel/seccomp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ae6b40cc39f4..73f6b6e9a3b0 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,6 +143,34 @@ struct notification {
>  	struct list_head notifications;
>  };
>  
> +#ifdef SECCOMP_ARCH_NATIVE
> +/**
> + * struct action_cache - per-filter cache of seccomp actions per
> + * arch/syscall pair
> + *
> + * @allow_native: A bitmap where each bit represents whether the
> + *		  filter will always allow the syscall, for the
> + *		  native architecture.
> + * @allow_compat: A bitmap where each bit represents whether the
> + *		  filter will always allow the syscall, for the
> + *		  compat architecture.
> + */
> +struct action_cache {
> +	DECLARE_BITMAP(allow_native, SECCOMP_ARCH_NATIVE_NR);
> +#ifdef SECCOMP_ARCH_COMPAT
> +	DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
> +#endif
> +};
> +#else
> +struct action_cache { };
> +
> +static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilter,
> +					     const struct seccomp_data *sd)
> +{
> +	return false;
> +}
> +#endif /* SECCOMP_ARCH_NATIVE */
> +
>  /**
>   * struct seccomp_filter - container for seccomp BPF programs
>   *
> @@ -298,6 +326,47 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  	return 0;
>  }
>  
> +#ifdef SECCOMP_ARCH_NATIVE
> +static inline bool seccomp_cache_check_allow_bitmap(const void *bitmap,
> +						    size_t bitmap_size,
> +						    int syscall_nr)
> +{
> +	if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))
> +		return false;
> +	syscall_nr = array_index_nospec(syscall_nr, bitmap_size);
> +
> +	return test_bit(syscall_nr, bitmap);
> +}
> +
> +/**
> + * seccomp_cache_check_allow - lookup seccomp cache
> + * @sfilter: The seccomp filter
> + * @sd: The seccomp data to lookup the cache with
> + *
> + * Returns true if the seccomp_data is cached and allowed.
> + */
> +static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilter,
> +					     const struct seccomp_data *sd)
> +{
> +	int syscall_nr = sd->nr;
> +	const struct action_cache *cache = &sfilter->cache;
> +
> +	if (likely(sd->arch == SECCOMP_ARCH_NATIVE))
> +		return seccomp_cache_check_allow_bitmap(cache->allow_native,
> +							SECCOMP_ARCH_NATIVE_NR,
> +							syscall_nr);
> +#ifdef SECCOMP_ARCH_COMPAT
> +	if (likely(sd->arch == SECCOMP_ARCH_COMPAT))
> +		return seccomp_cache_check_allow_bitmap(cache->allow_compat,
> +							SECCOMP_ARCH_COMPAT_NR,
> +							syscall_nr);
> +#endif /* SECCOMP_ARCH_COMPAT */
> +
> +	WARN_ON_ONCE(true);
> +	return false;
> +}
> +#endif /* SECCOMP_ARCH_NATIVE */

An small optimization for the non-compat case might be to do this to
avoid the sd->arch test (which should have no way to ever change in such
builds):

static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilter,
                                             const struct seccomp_data *sd)
{
        const struct action_cache *cache = &sfilter->cache;

#ifndef SECCOMP_ARCH_COMPAT
        /* A native-only architecture doesn't need to check sd->arch. */
        return seccomp_cache_check_allow_bitmap(cache->allow_native,
                                                SECCOMP_ARCH_NATIVE_NR,
                                                sd->nr);
#else /* SECCOMP_ARCH_COMPAT */
        if (likely(sd->arch == SECCOMP_ARCH_NATIVE))
                return seccomp_cache_check_allow_bitmap(cache->allow_native,
                                                        SECCOMP_ARCH_NATIVE_NR,
                                                        sd->nr);
        if (likely(sd->arch == SECCOMP_ARCH_COMPAT))
                return seccomp_cache_check_allow_bitmap(cache->allow_compat,
                                                        SECCOMP_ARCH_COMPAT_NR,
                                                        sd->nr);
#endif

        WARN_ON_ONCE(true);
        return false;
}

> +
>  /**
>   * seccomp_run_filters - evaluates all seccomp filters against @sd
>   * @sd: optional seccomp data to be passed to filters
> @@ -320,6 +389,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>  	if (WARN_ON(f == NULL))
>  		return SECCOMP_RET_KILL_PROCESS;
>  
> +	if (seccomp_cache_check_allow(f, sd))
> +		return SECCOMP_RET_ALLOW;
> +
>  	/*
>  	 * All filters in the list are evaluated and the lowest BPF return
>  	 * value always takes priority (ignoring the DATA).
> -- 
> 2.28.0
> 

This is all looking good; thank you! I'm doing some test builds/runs
now. :)

-- 
Kees Cook
