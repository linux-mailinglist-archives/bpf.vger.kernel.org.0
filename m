Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6190427F598
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbgI3W7l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 18:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgI3W7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 18:59:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F14C0613D0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:59:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so733898pjb.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mA4RbbGe3ZFZ8RcnTkMkNKoVYtjAYSExGb4WNfYO9TM=;
        b=RvEzwWeJN2a6gRlpZth2o25ndD+auCau4MS6DEJl7FxRP73WxgWlIWhGFYT4nMj4ax
         rwqmJHWUhezeYTftYK3nZPt4GWWUr4r0+VwQ5Mo0/P62KBQLjDwPqasCuvps4S30EzsK
         sQi5G0JVL9ITJDfSI/8aqYEeY5u3nyKSGfggs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mA4RbbGe3ZFZ8RcnTkMkNKoVYtjAYSExGb4WNfYO9TM=;
        b=uL22f3yfv5QMwDls+AA+PfnBhOhXbnGG4J+unnd8OHJoiWZzwJfDhZRHV4Cy/xUC0/
         kA4gyvtuwjvxW60p5Hn4exQQZles9QHrUpxVfZ94drZGFneOoVsGsbDjuyc3wzkfYwgI
         FEUpt4PBOV8FxqkqM7uGFQ4JB78h2Ok3MeVeXrWgQXoSzE2AL3/NF+abLgEsupORHLBU
         9rn0H8pNTJQ7cO0HY2rZx7EIKW7xc6y1fkDUFigRaWo+UbfWyng15jiLOuQsMsl6a6dx
         4ixYJiCDZ2UZQBryxn8hBgRTpNSh3aL/c005XL7+LRgX6+r/ZXqmC7hVqTBF+pBY1KLP
         SShg==
X-Gm-Message-State: AOAM530r5WVjDF9qHetTDBWzBJ6rGT4HDBtYzPIGUcU7sCR2AHLcXvBr
        c4O5Q+GuXOGceQPS/4/m/ko1wg==
X-Google-Smtp-Source: ABdhPJz64CmLzcbic8Oz26Aoz/WnP6GPlfiVb7QsHaknqk8NVQHnMJKg1SPPBWVyqQNBYFHVFM/jpw==
X-Received: by 2002:a17:90b:1083:: with SMTP id gj3mr4559450pjb.126.1601506780048;
        Wed, 30 Sep 2020 15:59:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm3775348pfb.198.2020.09.30.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:59:38 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:59:37 -0700
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
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202009301554.590642EBE@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 10:19:16AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> Currently the kernel does not provide an infrastructure to translate
> architecture numbers to a human-readable name. Translating syscall
> numbers to syscall names is possible through FTRACE_SYSCALL
> infrastructure but it does not provide support for compat syscalls.
> 
> This will create a file for each PID as /proc/pid/seccomp_cache.
> The file will be empty when no seccomp filters are loaded, or be
> in the format of:
> <arch name> <decimal syscall number> <ALLOW | FILTER>
> where ALLOW means the cache is guaranteed to allow the syscall,
> and filter means the cache will pass the syscall to the BPF filter.
> 
> For the docker default profile on x86_64 it looks like:
> x86_64 0 ALLOW
> x86_64 1 ALLOW
> x86_64 2 ALLOW
> x86_64 3 ALLOW
> [...]
> x86_64 132 ALLOW
> x86_64 133 ALLOW
> x86_64 134 FILTER
> x86_64 135 FILTER
> x86_64 136 FILTER
> x86_64 137 ALLOW
> x86_64 138 ALLOW
> x86_64 139 FILTER
> x86_64 140 ALLOW
> x86_64 141 ALLOW
> [...]
> 
> This file is guarded by CONFIG_DEBUG_SECCOMP_CACHE with a default
> of N because I think certain users of seccomp might not want the
> application to know which syscalls are definitely usable. For
> the same reason, it is also guarded by CAP_SYS_ADMIN.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/Kconfig                   | 15 +++++++++++
>  arch/x86/include/asm/seccomp.h |  3 +++
>  fs/proc/base.c                 |  3 +++
>  include/linux/seccomp.h        |  5 ++++
>  kernel/seccomp.c               | 46 ++++++++++++++++++++++++++++++++++
>  5 files changed, 72 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ca867b2a5d71..b840cadcc882 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -478,6 +478,7 @@ config HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
>  	  - all the requirements for HAVE_ARCH_SECCOMP_FILTER
>  	  - SECCOMP_ARCH_DEFAULT
>  	  - SECCOMP_ARCH_DEFAULT_NR
> +	  - SECCOMP_ARCH_DEFAULT_NAME
>  
>  config SECCOMP
>  	prompt "Enable seccomp to safely execute untrusted bytecode"
> @@ -532,6 +533,20 @@ config SECCOMP_CACHE_NR_ONLY
>  
>  endchoice
>  
> +config DEBUG_SECCOMP_CACHE

naming nit: I prefer where what how order, so SECCOMP_CACHE_DEBUG.

> +	bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
> +	depends on SECCOMP_CACHE_NR_ONLY
> +	depends on PROC_FS
> +	help
> +	  This is enables /proc/pid/seccomp_cache interface to monitor
> +	  seccomp cache data. The file format is subject to change. Reading
> +	  the file requires CAP_SYS_ADMIN.
> +
> +	  This option is for debugging only. Enabling present the risk that
> +	  an adversary may be able to infer the seccomp filter logic.
> +
> +	  If unsure, say N.
> +
>  config HAVE_ARCH_STACKLEAK
>  	bool
>  	help
> diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> index 7b3a58271656..33ccc074be7a 100644
> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -19,13 +19,16 @@
>  #ifdef CONFIG_X86_64
>  # define SECCOMP_ARCH_DEFAULT			AUDIT_ARCH_X86_64
>  # define SECCOMP_ARCH_DEFAULT_NR		NR_syscalls
> +# define SECCOMP_ARCH_DEFAULT_NAME		"x86_64"
>  # ifdef CONFIG_COMPAT
>  #  define SECCOMP_ARCH_COMPAT			AUDIT_ARCH_I386
>  #  define SECCOMP_ARCH_COMPAT_NR		IA32_NR_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME		"x86_32"

I think this should be "ia32"? Is there a good definitive guide on this
naming convention?

-- 
Kees Cook
