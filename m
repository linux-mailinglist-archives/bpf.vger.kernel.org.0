Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DE277C6D
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIXXqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 19:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIXXqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 19:46:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F47C0613D3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:46:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn7so742510pjb.5
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ENj7PY9iJR1aaISufa4dEvKLBt90CYksr2n88AjVwM=;
        b=nZU0Gox+BoWWtqzE5vCBMv3HolbRvoED55Q9kq1zlE9AgPIMSWyOPXXyjplO8BeIlL
         ZSXjTV7lL/CyldFXjcec/BmUnEUL00XZD2TAYIeVMcTdf2RbZxfhaLyoCVgJwmqEbEjS
         VTcmrBIBnJ6elvXh1lBKjh9rUMcDeUSbulZts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ENj7PY9iJR1aaISufa4dEvKLBt90CYksr2n88AjVwM=;
        b=DO0jmI43FQKO4yZoOTM8V6sVfk3IAT4qXlyqqrRRzhE1KiYKe0+MyqwUFaO/a33HcV
         BRxzpNA4RRf+9vLxAQPQNBOP9XD37pCxwR3RTSGozBJVApKErhhnRdTwh0ZcmzZEi62Q
         Z4saYtYpUv2PXFsBbV9RoCjMnb1gOGBJmB9BNF4papKF3sSe0T+nzdrqD33V5hb4kikk
         qElbdzwyNogje1FX93wpNa5k6yJh+K+kSCLNnKQ/PgfXZDcecSwkvBMUnzCNTTsuEscn
         xjIVR7NJ3VVFARRXT8IX0OMMqZVxAcRCxqVzyr4BKnUgz7wffaXEGtTwEiK2iikmyIu5
         5tbw==
X-Gm-Message-State: AOAM533iEMeHpdmOjXyhJqwFqZI4O9kI9F3rLVEWSghA7PXKQj1tkYFP
        kcZqtUuAn5u505uNQFBbGgAQVw==
X-Google-Smtp-Source: ABdhPJxec1KyHWgGfvd89Lelsy+1DeBi80BXPrruoAVIIOR9PLwUTmv1+bZnwlF0lZrfREhV1FhV8g==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr78123pjb.200.1600991168576;
        Thu, 24 Sep 2020 16:46:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f28sm525791pfq.191.2020.09.24.16.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 16:46:07 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:46:06 -0700
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
Subject: Re: [PATCH v2 seccomp 4/6] seccomp/cache: Lookup syscall allowlist
 for fast path
Message-ID: <202009241640.7E3C54CF@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <64052a5b81d5dacd63efb577c1d99e6f98e69702.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64052a5b81d5dacd63efb577c1d99e6f98e69702.1600951211.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 07:44:19AM -0500, YiFei Zhu wrote:
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
> ---
>  kernel/seccomp.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 20d33378a092..ac0266b6d18a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -167,6 +167,12 @@ static inline void seccomp_cache_inherit(struct seccomp_filter *sfilter,
>  					 const struct seccomp_filter *prev)
>  {
>  }
> +
> +static inline bool seccomp_cache_check(const struct seccomp_filter *sfilter,
> +				       const struct seccomp_data *sd)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
>  
>  /**
> @@ -321,6 +327,34 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * seccomp_cache_check - lookup seccomp cache
> + * @sfilter: The seccomp filter
> + * @sd: The seccomp data to lookup the cache with
> + *
> + * Returns true if the seccomp_data is cached and allowed.
> + */
> +static bool seccomp_cache_check(const struct seccomp_filter *sfilter,
> +				const struct seccomp_data *sd)
> +{
> +	int syscall_nr = sd->nr;
> +	int arch;
> +
> +	if (unlikely(syscall_nr < 0 || syscall_nr >= NR_syscalls))
> +		return false;

This protects us from x32 (i.e. syscall_nr will have 0x40000000 bit
set), but given the effort needed to support compat, I think supporting
x32 isn't much more. (Though again, I note that NR_syscalls differs in
size, so this test needs to be per-arch and obviously after
arch-discovery.)

That said, if it really does turn out that x32 is literally the only
architecture doing these shenanigans (and I suspect not, given the MIPS
case), okay, fine, I'll give in. :) You and Jann both seem to think this
isn't worth it.

> +
> +	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
> +		if (likely(syscall_arches[arch] == sd->arch))

I think this linear search for the matching arch can be made O(1) (this
is what I was trying to do in v1: we can map all possible combos to a
distinct bitmap, so there is just math and lookup rather than a linear
compare search. In the one-arch case, it can also be easily collapsed
into a no-op (though my v1 didn't do this correctly).

> +			return test_bit(syscall_nr,
> +					sfilter->cache.syscall_ok[arch]);
> +	}
> +
> +	WARN_ON_ONCE(true);
> +	return false;
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
> +
>  /**
>   * seccomp_run_filters - evaluates all seccomp filters against @sd
>   * @sd: optional seccomp data to be passed to filters
> @@ -343,6 +377,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
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

-- 
Kees Cook
