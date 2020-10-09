Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7560A289C0D
	for <lists+bpf@lfdr.de>; Sat, 10 Oct 2020 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJIXOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 19:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgJIXOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 19:14:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F41C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 16:14:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so5200996plo.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8tMNPlt+WgOGWxVqUdEpRLjgaATmbfqGWdnlUKGm2w=;
        b=iKYPQpxjWQDkWz+DPQGsFwsINVhn1zUNJnEVfUJUHTj6OrT2UeyVf1jFWu2VGG0Sd/
         Q6eQgdzwWjj1nWOw0JUlCIXxYd/FtVriQRsOUwCsaFdBcNkPKi+2pbMPFtUj75Sr/tRe
         8j88AH6f6bdBDPc15Bfpy6/ADirbyIrXuuiWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8tMNPlt+WgOGWxVqUdEpRLjgaATmbfqGWdnlUKGm2w=;
        b=brPpDuMj+u0U7lNNzWGY1nsBbYeAB7Z0cTMWQRex6GCTn3oxIEbjgT7oPL8t0GSpuZ
         qbgjn1aQKHps+YgL1fwj0cNqYWxrx5Lh+OLvldtbysVYQwnP7vNsccFo4FiaCQDu+Tat
         AuIUCRPfMTPHJnpDujyajShTSqJQthZG8R5LL48mMqFwkO/EJQeaJDUP8N1T6BzQdB5x
         iYBRTsRSTsM8ucWJaswuEG0WQ4ZdwKmqTYfzNGowchk2aqzKdLP7C5tTiqJvoykIikD1
         7Sy5bqCeS4PzmBAOsZ8XxqaRo78oK5vNFnwQoMUYVHqTqAhCpfT8lygiw+N2nuTouLh9
         CTMQ==
X-Gm-Message-State: AOAM5307Cj5wOgzDqtJgiKYsQdUxr764SkVRYiFaafojj3iAegqVVCZx
        lGjge2VAaU/TsE9ytbqPPVo57Q==
X-Google-Smtp-Source: ABdhPJwNBafddDMTu9v6aB/SdriCWv98crtqxIV19v6tjDbA0QjDMDvn6HIEfpx597XYVrlGXc/Prw==
X-Received: by 2002:a17:902:8bc4:b029:d2:8cec:1fae with SMTP id r4-20020a1709028bc4b02900d28cec1faemr14566468plo.23.1602285290468;
        Fri, 09 Oct 2020 16:14:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm12323939pgh.65.2020.10.09.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 16:14:49 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:14:48 -0700
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
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202010091613.B671C86@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 09, 2020 at 12:14:33PM -0500, YiFei Zhu wrote:
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
> This file is guarded by CONFIG_SECCOMP_CACHE_DEBUG with a default
> of N because I think certain users of seccomp might not want the
> application to know which syscalls are definitely usable. For
> the same reason, it is also guarded by CAP_SYS_ADMIN.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/Kconfig                   | 24 ++++++++++++++
>  arch/x86/Kconfig               |  1 +
>  arch/x86/include/asm/seccomp.h |  3 ++
>  fs/proc/base.c                 |  6 ++++
>  include/linux/seccomp.h        |  5 +++
>  kernel/seccomp.c               | 59 ++++++++++++++++++++++++++++++++++
>  6 files changed, 98 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 21a3675a7a3a..85239a974f04 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -471,6 +471,15 @@ config HAVE_ARCH_SECCOMP_FILTER
>  	    results in the system call being skipped immediately.
>  	  - seccomp syscall wired up
>  
> +config HAVE_ARCH_SECCOMP_CACHE
> +	bool
> +	help
> +	  An arch should select this symbol if it provides all of these things:
> +	  - all the requirements for HAVE_ARCH_SECCOMP_FILTER
> +	  - SECCOMP_ARCH_NATIVE
> +	  - SECCOMP_ARCH_NATIVE_NR
> +	  - SECCOMP_ARCH_NATIVE_NAME
> +
> [...]
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1ab22869a765..1a807f89ac77 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -150,6 +150,7 @@ config X86
>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SECCOMP_CACHE
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_TRACEHOOK

HAVE_ARCH_SECCOMP_CACHE isn't used any more. I think this was left over
from before.

-- 
Kees Cook
