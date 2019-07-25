Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7750742FC
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 03:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbfGYBtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 21:49:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43512 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbfGYBtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 21:49:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so21847376pfg.10
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 18:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jiFDcwQiGaN6vJB6KlbsTelIXNEPU4EhhSM8eaDwe28=;
        b=NEk+K/M4XoXRNkaimXAp55fFnW3FG5JYc3y4ElmVcnygNevbCkm7g12T2gZIawjH2m
         ervX0znf3v+LokRvX8HvRYRZl/+E9WIpAoEOw7CYj2MriWSfdJygVGODxCuUvmiXdEXX
         RxDDWIzRbhS1RMdFp9h7dgJ5HPvZOYNZiOC0FrRLge9QjYDB9mZb32tTG9bnJ4J1Cwlf
         9zFbjngKQdACK2PH8tc2nnDIp0V5gB6EXixQ18pjnff+elGrh5duFnjWXbo2SlVAz9e/
         jSE3gdzud8A+T/nJBAC8R4eyxE9JDvqa7P4h1FWmp3l493GQEiQ/xOG7MRT1m9wLsv3d
         Rb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jiFDcwQiGaN6vJB6KlbsTelIXNEPU4EhhSM8eaDwe28=;
        b=l5cR4VuaUOkfxIwYZy8JSCq5tOZ8UOTFJsp2Y8iGCdtemXiz69vc4zTO4lveDAcla9
         3ljIMRmj2PqgWB5CYnvswutyXNRmFQtmKvxo61xHfBNVEc4QaFXp0yr2wNg13WBK3SVv
         RNXTjvcr630zvqOZCV8AZZEW/7DeXx9NkDK/fFqc2AUFNzmltl29PlyXl9kC0POkUvDk
         DJz9YaN63/b2HTpU0ookMdOkdfF0NKCjb9xCokQzST7BHCwb+BYzYXyw7dDHn4MNtVgz
         j2u5nHVI2MOR3inO9+3CDbos7ftjtRa5wELCV33CbQtquzwfP+z8yqEfJaImKq9f8te5
         kYoQ==
X-Gm-Message-State: APjAAAUekT5di83rbCVk4z3a3AkYXm3UP75ke4vy+xigCUdSEbB+Adzl
        iLUU6oC7gluvl/LJ/fZJ7M1Z2w==
X-Google-Smtp-Source: APXvYqw8jGLemfwZZMgQ9iTqUNH6yOhQwK3TZ3iENKJ2ax2lB0hZ9iGxiJLocXHtOSry7RDr1MmsXw==
X-Received: by 2002:a65:5144:: with SMTP id g4mr31637451pgq.202.1564019344033;
        Wed, 24 Jul 2019 18:49:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([240e:e0:f090:3aa1:9c84:f7b8:9214:6096])
        by smtp.gmail.com with ESMTPSA id e124sm75939006pfh.181.2019.07.24.18.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 18:49:03 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:48:32 +0800
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
Subject: Re: [PATCH 2/2] arm: Add support for function error injection
Message-ID: <20190725014416.GC6764@leoy-ThinkPad-X240s>
References: <20190716111301.1855-1-leo.yan@linaro.org>
 <20190716111301.1855-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716111301.1855-3-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Russell,

On Tue, Jul 16, 2019 at 07:13:01PM +0800, Leo Yan wrote:
> This patch implement regs_set_return_value() and
> override_function_with_return() to support function error injection
> for arm.
> 
> In the exception flow, we can update pt_regs::ARM_pc with
> pt_regs::ARM_lr so that can override the probed function return.

Gentle ping.

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm/Kconfig                       |  1 +
>  arch/arm/include/asm/error-injection.h | 13 +++++++++++++
>  arch/arm/include/asm/ptrace.h          |  5 +++++
>  arch/arm/lib/Makefile                  |  2 ++
>  arch/arm/lib/error-inject.c            | 19 +++++++++++++++++++
>  5 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/include/asm/error-injection.h
>  create mode 100644 arch/arm/lib/error-inject.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8869742a85df..f7932a5e29ea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -74,6 +74,7 @@ config ARM
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> +	select HAVE_FUNCTION_ERROR_INJECTION if !THUMB2_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/arm/include/asm/error-injection.h b/arch/arm/include/asm/error-injection.h
> new file mode 100644
> index 000000000000..da057e8ed224
> --- /dev/null
> +++ b/arch/arm/include/asm/error-injection.h
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
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index 91d6b7856be4..3b41f37b361a 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -89,6 +89,11 @@ static inline long regs_return_value(struct pt_regs *regs)
>  	return regs->ARM_r0;
>  }
>  
> +static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> +{
> +	regs->ARM_r0 = rc;
> +}
> +
>  #define instruction_pointer(regs)	(regs)->ARM_pc
>  
>  #ifdef CONFIG_THUMB2_KERNEL
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 0bff0176db2c..d3d7430ecd76 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -43,3 +43,5 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>  endif
> +
> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> diff --git a/arch/arm/lib/error-inject.c b/arch/arm/lib/error-inject.c
> new file mode 100644
> index 000000000000..96319d017114
> --- /dev/null
> +++ b/arch/arm/lib/error-inject.c
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
> +	 * 'regs->ARM_lr' contains the the link register for the probed
> +	 * function and assign it to 'regs->ARM_pc', so when kprobe returns
> +	 * back from exception it will override the end of probed function
> +	 * and drirectly return to the predefined function's caller.
> +	 */
> +	regs->ARM_pc = regs->ARM_lr;
> +}
> +NOKPROBE_SYMBOL(override_function_with_return);
> -- 
> 2.17.1
> 
