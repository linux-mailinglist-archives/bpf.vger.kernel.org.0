Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A0742F4
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfGYBmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 21:42:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44275 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388268AbfGYBmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 21:42:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so21814170pfe.11
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQf41Qf2MyEcGAlnCF9Sv7hDI8pxvRaGA0CXobFrUw4=;
        b=iRxxgKeR7cr+V++hP1PTKFiQqoGu3lDyaG67Q0HbnfgYus3nbKzY8UIizGiF8seN/s
         0dTw+JALQRKOo5V/c79A7FAzTuvukc6HS084DxljNZnDNvQYCEQl+ZAM3LLzrmIFHE0Q
         aVcrWaCeV/JSeAvEpzfBdPjfFtVje3wxxiMGaZWBT4tX+ncANg2SCZI06EEVlPQKvF1x
         YJzk590XLIcO2HI+ITddTp0jDw70V4DUthCzlqltJVRifpa1wd7tLS2zBULSKBW/5ex7
         vIC97zr6Lf8YuFtzgj9B79bTm7wpknpPZ0sokurfH/ebOcGmM5a2k/oqIVU41TrU+plQ
         pz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQf41Qf2MyEcGAlnCF9Sv7hDI8pxvRaGA0CXobFrUw4=;
        b=qpsGdR/eBxSk830C9KL6qEYgQUGJj9dkU34bUJJj6D2TAUZfjtxd4EFVn/9AcYi1tn
         W8qNt90kaCchv+5cekcop/36Hce8FpJz5zuWHDVgZ7fvhAYmshkdZTWBvEVh+eSS0d5K
         ZKmXgV39YZ6f1XVVjJSVHzoa8KljtSE3cn6fPfJetr5EhHxZVLbdAiVOKL39quSJ26/C
         TLGlt3B2LTckma1Eep7I1VdEWD48KbG3GRq3p/ZMqzhiY3P70wUSXa0bgTzquoOf87jA
         jibztJdS0jq5mp7BEapIBKE42gbL0hP5lgxuVgvL3JrX27byHgu4Vj9oG0jieuYLtMFw
         Y1CQ==
X-Gm-Message-State: APjAAAUyXBvunNJI2vOAJlkCyL7H9G/thALEs/EMqk1tPl/ls4zE5Iwy
        s6f1bgM0MYAGAtCclmFUZvdgkQ==
X-Google-Smtp-Source: APXvYqz7SxCnEnIwWDcY0tdro2KnRSLcWW6rNVOtl8l+IZj11PjrZsuZgMe9kckvrBuNewHBVXBgnA==
X-Received: by 2002:a63:9318:: with SMTP id b24mr73280689pge.31.1564018933093;
        Wed, 24 Jul 2019 18:42:13 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.232.252.231])
        by smtp.gmail.com with ESMTPSA id o11sm79923453pfh.114.2019.07.24.18.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 18:42:12 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:42:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: Re: [PATCH 1/2] arm64: Add support for function error injection
Message-ID: <20190725014125.GB6764@leoy-ThinkPad-X240s>
References: <20190716111301.1855-1-leo.yan@linaro.org>
 <20190716111301.1855-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716111301.1855-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 16, 2019 at 07:13:00PM +0800, Leo Yan wrote:
> This patch implement regs_set_return_value() and
> override_function_with_return() to support function error injection
> for arm64.
> 
> In the exception flow, arm64's general register x30 contains the value
> for the link register; so we can just update pt_regs::pc with it rather
> than redirecting execution to a dummy function that returns.
> 
> This patch is heavily inspired by the commit 7cd01b08d35f ("powerpc:
> Add support for function error injection").
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Catalin, Will:  Gentle ping ...

> ---
>  arch/arm64/Kconfig                       |  1 +
>  arch/arm64/include/asm/error-injection.h | 13 +++++++++++++
>  arch/arm64/include/asm/ptrace.h          |  5 +++++
>  arch/arm64/lib/Makefile                  |  2 ++
>  arch/arm64/lib/error-inject.c            | 19 +++++++++++++++++++
>  5 files changed, 40 insertions(+)
>  create mode 100644 arch/arm64/include/asm/error-injection.h
>  create mode 100644 arch/arm64/lib/error-inject.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 697ea0510729..a6d9e622977d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -142,6 +142,7 @@ config ARM64
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_TRACER
> +	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> diff --git a/arch/arm64/include/asm/error-injection.h b/arch/arm64/include/asm/error-injection.h
> new file mode 100644
> index 000000000000..da057e8ed224
> --- /dev/null
> +++ b/arch/arm64/include/asm/error-injection.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ASM_ERROR_INJECTION_H_
> +#define __ASM_ERROR_INJECTION_H_
> +
> +#include <linux/compiler.h>
> +#include <linux/linkage.h>
> +#include <asm/ptrace.h>
> +#include <asm-generic/error-injection.h>
> +
> +void override_function_with_return(struct pt_regs *regs);
> +
> +#endif /* __ASM_ERROR_INJECTION_H_ */
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index dad858b6adc6..3aafbbe218a2 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -294,6 +294,11 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->regs[0];
>  }
>  
> +static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> +{
> +	regs->regs[0] = rc;
> +}
> +
>  /**
>   * regs_get_kernel_argument() - get Nth function argument in kernel
>   * @regs:	pt_regs of that context
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 33c2a4abda04..f182ccb0438e 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -33,3 +33,5 @@ UBSAN_SANITIZE_atomic_ll_sc.o	:= n
>  lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
>  
>  obj-$(CONFIG_CRC32) += crc32.o
> +
> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> diff --git a/arch/arm64/lib/error-inject.c b/arch/arm64/lib/error-inject.c
> new file mode 100644
> index 000000000000..35661c2de4b0
> --- /dev/null
> +++ b/arch/arm64/lib/error-inject.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/error-injection.h>
> +#include <linux/kprobes.h>
> +
> +void override_function_with_return(struct pt_regs *regs)
> +{
> +	/*
> +	 * 'regs' represents the state on entry of a predefined function in
> +	 * the kernel/module and which is captured on a kprobe.
> +	 *
> +	 * 'regs->regs[30]' contains the the link register for the probed
> +	 * function and assign it to 'regs->pc', so when kprobe returns
> +	 * back from exception it will override the end of probed function
> +	 * and drirectly return to the predefined function's caller.
> +	 */
> +	regs->pc = regs->regs[30];
> +}
> +NOKPROBE_SYMBOL(override_function_with_return);
> -- 
> 2.17.1
> 
