Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256BF6D72A7
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 05:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjDEDIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 23:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjDEDIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 23:08:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F72D6D
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 20:08:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2797734pjc.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680664111; x=1683256111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kik4jgteyA4BneMJl6LIoIyjDPfKXmglUA1TVnaHtc=;
        b=GBIWCc54m6PT+S9mTLxEhqjP5Wv4+7i1tb4gto61+P8koFzIRDiKIbdmo04Yh3OetC
         2Q0NlrJCnoiUu89mGMdCo7Yxj2V19zslzBt/BorOvjIr8SZKLr1O5i1tLYXKsSLJinon
         /6ZKH7/agWuyB9gJzvS20Y/UVpW4Y2RdnjFHWmux1IhXb7JiVTs4CZ9FsZUhqHemxBT1
         5MwLRG2bLAsHI2lWGKXzWSpMkMztR5QWvL8qi/ApW2osAHuj3ozgTUo73zY1yHRAepqs
         yEf2IVD8bxHC4gbF32UTCQrJ6tBdnpJ5Ka5krkoa4OSFibIY+MLVM1/GU9TugclD0spC
         3f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680664111; x=1683256111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kik4jgteyA4BneMJl6LIoIyjDPfKXmglUA1TVnaHtc=;
        b=3VdfTufKLJ5NERWBfmlly3pnwtYRCZtYImC3Sf5nIru7LVRzCsWJeoUGLtPbky6Fse
         Wk7IGKKI/OX3z4s6JzG0Syn8YUtur03RcgL7SnW9Teq8P5GFCUCQuTkahX/RLSbPWenS
         jEk2JUO1ZhpOL3GPKK+1R0p7GasFeiHlslE3LTH5wuhKNjDNxVWxxZ7QE5V0KAnMw+uU
         dzoowaqXoqBZ7klvAdnRUYYGPSwnejIMz2aLK7wJaO9W1XuAn1uyst3idFylydMDXJnC
         zc3U8XZbHnXYQJmgWApRWspVZlmjsxghP7Xn3at5xf785aB3Z4q41Xel19o4Z2i2z4Xh
         MUcA==
X-Gm-Message-State: AAQBX9dyTGaJmNsasMLsicGIRzF6UMEIL24tOwkArv6M9BQhKOPVjp2x
        mk49cfYJnqX4tM8g+K60EC0=
X-Google-Smtp-Source: AKy350ZbwU0j81b4JQQNPKsPCijX4HChuwOMemw3ZGxwKI2lzy7RmDBiLqx11h3l5NdZcoJwIC7zHw==
X-Received: by 2002:a17:902:e5c7:b0:19e:29bd:8411 with SMTP id u7-20020a170902e5c700b0019e29bd8411mr5595181plf.30.1680664111482;
        Tue, 04 Apr 2023 20:08:31 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001a1add0d616sm9098337plb.161.2023.04.04.20.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 20:08:30 -0700 (PDT)
Date:   Tue, 4 Apr 2023 20:08:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf@vger.kernel.org, x86@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, peterz@infradead.org,
        keescook@chromium.org, tglx@linutronix.de, hsinweih@uci.edu,
        rostedt@goodmis.org, vegard.nossum@oracle.com,
        gregkh@linuxfoundation.org, alan.maguire@oracle.com,
        dylany@meta.com, riel@surriel.com, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RESUBMIT bpf-next 2/2] perf: Fix arch_perf_out_copy_user().
Message-ID: <20230405030827.pcbekhecrx7jqyvc@macbook-pro-6.dhcp.thefacebook.com>
References: <20230329193931.320642-1-dev@der-flo.net>
 <20230329193931.320642-3-dev@der-flo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329193931.320642-3-dev@der-flo.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 09:39:33PM +0200, Florian Lehner wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> There are several issues with arch_perf_out_copy_user().
> On x86 it's the same as copy_from_user_nmi() and all is good,
> but on other archs:
> 
> - __access_ok() is missing.
> Only on m68k, s390, parisc, sparc64 archs this function returns 'true'.
> Other archs must call it before user memory access.
> - nmi_uaccess_okay() is missing.
> - __copy_from_user_inatomic() issues under CONFIG_HARDENED_USERCOPY.
> 
> The latter two issues existed in copy_from_user_nofault() as well and
> were fixed in the previous patch.
> 
> This patch copies comments from copy_from_user_nmi() into mm/maccess.c
> and splits copy_from_user_nofault() into copy_from_user_nmi()
> that returns number of not copied bytes and copy_from_user_nofault()
> that returns -EFAULT or zero.
> With that copy_from_user_nmi() becomes generic and is used
> by perf on all architectures.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/x86/include/asm/perf_event.h |  2 --
>  arch/x86/lib/Makefile             |  2 +-
>  arch/x86/lib/usercopy.c           | 55 -------------------------------
>  kernel/events/internal.h          | 16 +--------
>  mm/maccess.c                      | 48 ++++++++++++++++++++++-----
>  mm/usercopy.c                     |  2 +-
>  6 files changed, 42 insertions(+), 83 deletions(-)
>  delete mode 100644 arch/x86/lib/usercopy.c
> 
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8fc15ed5e60b..b1e27ca28563 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -598,6 +598,4 @@ static __always_inline void perf_lopwr_cb(bool lopwr_in)
>   static inline void amd_pmu_disable_virt(void) { }
>  #endif
>  
> -#define arch_perf_out_copy_user copy_from_user_nmi
> -
>  #endif /* _ASM_X86_PERF_EVENT_H */
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 4f1a40a86534..e85937696afd 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -42,7 +42,7 @@ clean-files := inat-tables.c
>  obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
>  
>  lib-y := delay.o misc.o cmdline.o cpu.o
> -lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
> +lib-y += usercopy_$(BITS).o getuser.o putuser.o
>  lib-y += memcpy_$(BITS).o
>  lib-y += pc-conf-reg.o
>  lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
> diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
> deleted file mode 100644
> index 24b48af27417..000000000000
> --- a/arch/x86/lib/usercopy.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/*
> - * User address space access functions.
> - *
> - *  For licencing details see kernel-base/COPYING
> - */
> -
> -#include <linux/uaccess.h>
> -#include <linux/export.h>
> -#include <linux/instrumented.h>
> -
> -#include <asm/tlbflush.h>
> -
> -/**
> - * copy_from_user_nmi - NMI safe copy from user
> - * @to:		Pointer to the destination buffer
> - * @from:	Pointer to a user space address of the current task
> - * @n:		Number of bytes to copy
> - *
> - * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
> - *
> - * Contrary to other copy_from_user() variants this function can be called
> - * from NMI context. Despite the name it is not restricted to be called
> - * from NMI context. It is safe to be called from any other context as
> - * well. It disables pagefaults across the copy which means a fault will
> - * abort the copy.
> - *
> - * For NMI context invocations this relies on the nested NMI work to allow
> - * atomic faults from the NMI path; the nested NMI paths are careful to
> - * preserve CR2.
> - */
> -unsigned long
> -copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
> -{
> -	unsigned long ret;
> -
> -	if (!__access_ok(from, n))
> -		return n;
> -
> -	if (!nmi_uaccess_okay())
> -		return n;
> -
> -	/*
> -	 * Even though this function is typically called from NMI/IRQ context
> -	 * disable pagefaults so that its behaviour is consistent even when
> -	 * called from other contexts.
> -	 */
> -	pagefault_disable();
> -	instrument_copy_from_user_before(to, from, n);
> -	ret = raw_copy_from_user(to, from, n);
> -	instrument_copy_from_user_after(to, from, n, ret);
> -	pagefault_enable();
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(copy_from_user_nmi);
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 5150d5f84c03..62fe2089a1f9 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -190,21 +190,7 @@ memcpy_skip(void *dst, const void *src, unsigned long n)
>  
>  DEFINE_OUTPUT_COPY(__output_skip, memcpy_skip)
>  
> -#ifndef arch_perf_out_copy_user
> -#define arch_perf_out_copy_user arch_perf_out_copy_user
> -
> -static inline unsigned long
> -arch_perf_out_copy_user(void *dst, const void *src, unsigned long n)
> -{
> -	unsigned long ret;
> -
> -	pagefault_disable();
> -	ret = __copy_from_user_inatomic(dst, src, n);
> -	pagefault_enable();
> -
> -	return ret;
> -}
> -#endif
> +#define arch_perf_out_copy_user copy_from_user_nmi
>  
>  DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
>  
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 6ee9b337c501..aa7520bb64bf 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -103,17 +103,27 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>  }
>  
>  /**
> - * copy_from_user_nofault(): safely attempt to read from a user-space location
> - * @dst: pointer to the buffer that shall take the data
> - * @src: address to read from. This must be a user address.
> - * @size: size of the data chunk
> + * copy_from_user_nmi - NMI safe copy from user
> + * @dst:	Pointer to the destination buffer
> + * @src:	Pointer to a user space address of the current task
> + * @size:	Number of bytes to copy
>   *
> - * Safely read from user address @src to the buffer at @dst. If a kernel fault
> - * happens, handle that and return -EFAULT.
> + * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
> + *
> + * Contrary to other copy_from_user() variants this function can be called
> + * from NMI context. Despite the name it is not restricted to be called
> + * from NMI context. It is safe to be called from any other context as
> + * well. It disables pagefaults across the copy which means a fault will
> + * abort the copy.
> + *
> + * For NMI context invocations this relies on the nested NMI work to allow
> + * atomic faults from the NMI path; the nested NMI paths are careful to
> + * preserve CR2 on X86 architecture.
>   */
> -long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
> +unsigned long
> +copy_from_user_nmi(void *dst, const void __user *src, unsigned long size)
>  {
> -	long ret = -EFAULT;
> +	unsigned long ret = size;
>  
>  	if (!__access_ok(src, size))
>  		return ret;
> @@ -121,13 +131,33 @@ long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
>  	if (!nmi_uaccess_okay())
>  		return ret;
>  
> +	/*
> +	 * Even though this function is typically called from NMI/IRQ context
> +	 * disable pagefaults so that its behaviour is consistent even when
> +	 * called from other contexts.
> +	 */
>  	pagefault_disable();
>  	instrument_copy_from_user_before(dst, src, size);
>  	ret = raw_copy_from_user(dst, src, size);
>  	instrument_copy_from_user_after(dst, src, size, ret);
>  	pagefault_enable();
>  
> -	if (ret)
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_from_user_nmi);
> +
> +/**
> + * copy_from_user_nofault(): safely attempt to read from a user-space location
> + * @dst: pointer to the buffer that shall take the data
> + * @src: address to read from. This must be a user address.
> + * @size: size of the data chunk
> + *
> + * Safely read from user address @src to the buffer at @dst. If a kernel fault
> + * happens, handle that and return -EFAULT.
> + */
> +long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
> +{
> +	if (copy_from_user_nmi(dst, src, size))
>  		return -EFAULT;
>  	return 0;
>  }
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 4c3164beacec..83c164aba6e0 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -173,7 +173,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  		return;
>  	}
>  
> -	if (is_vmalloc_addr(ptr)) {
> +	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {

Florian,

thank you for taking over the patches.
This bit isn't right though.
This hunk needs to be in patch 1.
Then instead of open coding __copy_from_user_inatomic without check_object_size()
it would be fine to only add __access_ok and nmi_uaccess_okay()
to copy_from_user_nofault() and keep __copy_from_user_inatomic().
The patch 2 can still remove copy_from_user_nmi() (adjusting return value, of course),
since check_heap_object() will no longer dead lock due to !pagefault_disabled()
in the patch 1.
Does this make sense?
