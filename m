Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A611627F440
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 23:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgI3Vct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3Vcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 17:32:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D1C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:32:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so2005617pgd.4
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o420e7m3IZbrqieFDO0g3Vbb/K2chBl3Ks/YWgHiNOw=;
        b=KJ+eWGv91AIz2+/v9kMs/VQl1R9zZsmavTp7VpHUz2rt2f9L/NffkF/5WluUYnzSnj
         7sPW5vVGvMSfLA4aeQXS+W7lcReo95gKT2p3BfmU2AREeaIfQcUFRa04KlDcPT0npPYL
         2ykxJdLnXqzphZIpU6TUFo3ijdAv7ruc4KXsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o420e7m3IZbrqieFDO0g3Vbb/K2chBl3Ks/YWgHiNOw=;
        b=oZ4IS4ThMIA9TADzojjuOKyKZKw5JBDequn/CUnjGNgCz4rmA0fr1AVz0EcQQso5ke
         9u49rFmbQMEk03of8WrgZ4B99JtNtIkjzne09OkIq/YpQB9myTzj6Ie9SdL8omIz+IHi
         kdYIpImGNA4eRkB8G3ApSZVg8QlgQ0+dAJTu9fTygRA4fL7BHsuwlBPeisyR7U41XSKt
         wYCXoWA+Y1fCHRi/CA5nHwceYOaFjowvhyUc3b6zzlKlxD0oMFMymkD474HbNj0YEs+g
         U9Dfl9l1ro4wYeJ/EE3JsXqQme7F3u1EONCqn9jC96XxukYpK5SX0BLUESP/h9aOoj44
         DyXQ==
X-Gm-Message-State: AOAM5303SsXToOpRMd59MwMysY2UHPmvopXVNGgBOuN9TsqmuW+l5a+i
        k+xTkNBiu6fH6zCPSB+z91EcQA==
X-Google-Smtp-Source: ABdhPJxFywfjRUgJLANfHOyPeH+0Smh8BUvdparFVzlNNYHCvLQNaP+SUaw0rvKQOr1CntN7Htfrkg==
X-Received: by 2002:a63:703:: with SMTP id 3mr3557549pgh.159.1601501568307;
        Wed, 30 Sep 2020 14:32:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17sm3658037pff.6.2020.09.30.14.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:32:47 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:32:46 -0700
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
Subject: Re: [PATCH v3 seccomp 3/5] seccomp/cache: Lookup syscall allowlist
 for fast path
Message-ID: <202009301422.D9F6E6A@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <83c72471f9f79fa982508bd4db472686a67b8320.1601478774.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c72471f9f79fa982508bd4db472686a67b8320.1601478774.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 10:19:14AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> The fast (common) path for seccomp should be that the filter permits
> the syscall to pass through, and failing seccomp is expected to be
> an exceptional case; it is not expected for userspace to call a
> denylisted syscall over and over.
> 
> This first finds the current allow bitmask by iterating through
> syscall_arches[] array and comparing it to the one in struct
> seccomp_data; this loop is expected to be unrolled. It then
> does a test_bit against the bitmask. If the bit is set, then
> there is no need to run the full filter; it returns
> SECCOMP_RET_ALLOW immediately.
> 
> Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

I'd like the content/ordering of this and the emulator patch to be reorganized a bit.
I'd like to see the infrastructure of the cache added first (along with
the "always allow" test logic in this patch), with the emulator missing:
i.e. the patch is a logical no-op: no behavior changes because nothing
ever changes the cache bits, but all the operational logic, structure
changes, etc, is in place. Then the next patch would be replacing the
no-op with the emulator.

> ---
>  kernel/seccomp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f09c9e74ae05..bed3b2a7f6c8 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -172,6 +172,12 @@ struct seccomp_cache_filter_data { };
>  static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
>  {
>  }
> +
> +static inline bool seccomp_cache_check(const struct seccomp_filter *sfilter,

bikeshedding: "cache check" doesn't tell me anything about what it's
actually checking for. How about calling this seccomp_is_constant_allow() or
something that reflects both the "bool" return ("is") and what that bool
means ("should always be allowed").

> +				       const struct seccomp_data *sd)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
>  
>  /**
> @@ -331,6 +337,49 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +static bool seccomp_cache_check_bitmap(const void *bitmap, size_t bitmap_size,

Please also mark as "inline".

> +				       int syscall_nr)
> +{
> +	if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))
> +		return false;
> +	syscall_nr = array_index_nospec(syscall_nr, bitmap_size);
> +
> +	return test_bit(syscall_nr, bitmap);
> +}
> +
> +/**
> + * seccomp_cache_check - lookup seccomp cache
> + * @sfilter: The seccomp filter
> + * @sd: The seccomp data to lookup the cache with
> + *
> + * Returns true if the seccomp_data is cached and allowed.
> + */
> +static bool seccomp_cache_check(const struct seccomp_filter *sfilter,

inline too.

> +				const struct seccomp_data *sd)
> +{
> +	int syscall_nr = sd->nr;
> +	const struct seccomp_cache_filter_data *cache = &sfilter->cache;
> +
> +#ifdef SECCOMP_ARCH_DEFAULT
> +	if (likely(sd->arch == SECCOMP_ARCH_DEFAULT))
> +		return seccomp_cache_check_bitmap(cache->syscall_allow_default,
> +						  SECCOMP_ARCH_DEFAULT_NR,
> +						  syscall_nr);
> +#endif /* SECCOMP_ARCH_DEFAULT */
> +
> +#ifdef SECCOMP_ARCH_COMPAT
> +	if (likely(sd->arch == SECCOMP_ARCH_COMPAT))
> +		return seccomp_cache_check_bitmap(cache->syscall_allow_compat,
> +						  SECCOMP_ARCH_COMPAT_NR,
> +						  syscall_nr);
> +#endif /* SECCOMP_ARCH_COMPAT */
> +
> +	WARN_ON_ONCE(true);
> +	return false;
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * seccomp_run_filters - evaluates all seccomp filters against @sd
>   * @sd: optional seccomp data to be passed to filters
> @@ -353,6 +402,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>  	if (WARN_ON(f == NULL))
>  		return SECCOMP_RET_KILL_PROCESS;
>  
> +	if (seccomp_cache_check(f, sd))
> +		return SECCOMP_RET_ALLOW;
> +
>  	/*
>  	 * All filters in the list are evaluated and the lowest BPF return
>  	 * value always takes priority (ignoring the DATA).
> -- 
> 2.28.0
> 

Otherwise, yup, looks good.

-- 
Kees Cook
