Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD8530119
	for <lists+bpf@lfdr.de>; Sun, 22 May 2022 07:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiEVFit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 May 2022 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiEVFis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 May 2022 01:38:48 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD83631B;
        Sat, 21 May 2022 22:38:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i5so7950750ilv.0;
        Sat, 21 May 2022 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UqpfJk04j/G5TmmjLU8r49li3eldLMLnOiRVESjdyI8=;
        b=ivRLGjoe7oeWVXb5T7H5TYS5+s/CuBjy2qGzxyg3TyXZsEUPFbJvL/vc35ATasUoBJ
         w72HL9I+hjZmcuZZ1wXPyp8SgJlr40GyoNKGSOpf56lsO7yn7MRMmG/aH4cXQnK57zK5
         Uf8wJ/if2IMsWna6b435xvHBLcRGTY6Y0vQy0tl5gj6hJ3Xj9yrcbb06TJhiUCbrz08s
         UeN/GLQ9+yBIWG+zpZvtIf9MwIAJ4aCk8dB1pGTBQfd6KZHUANRzvy4oW208ckl9ZE6e
         HZf2ID07SMKRpIphsvzOFeyAFmQWeiOGmc5TeWU14Oh5usTsuYBdnaa3PN2U92ExeAd/
         4EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqpfJk04j/G5TmmjLU8r49li3eldLMLnOiRVESjdyI8=;
        b=ZAWJk+0clEw7GWht5hre2SjSEL744vJavCKbrY3s6pbsb7pFnSWJ9SaTaMFh1Qd6zV
         DVer4Ux3LSeU17/YcZW1LeryTM16WFrhSBzIjMK3iHPNxcGgKOowWOcgTbpy8LTyd8oo
         musTcp5+aZJ8kSNi3MYpuzGRE8lSLBqTNImr9lq3+FYm5geqs0gpgjM0zBCfrVfu7Ko6
         ql0VEOPsm1hqDoIGSx6MwmVCqfKx+zM+mJbN6nrZVjD36agrTbHi5MIcRBZOmjvfMFlw
         aBYEf32jZnYoPlC/rgzbz/u0PdFvmEMyCRGBKTwH4wOfcIap7jRNvupTAJKiwg0Su6PY
         bpvA==
X-Gm-Message-State: AOAM530olHwigl/sRGgnpxnpKeovutET546oBlo8YO/HtUDdyDqLkXcN
        e4tVJuBrpHB33RqlJi7qThs=
X-Google-Smtp-Source: ABdhPJwzfydJBjgFeHlR0T+XUVy/nXpQIewgUbh3FoTL0sMB7MFxQA/tguvONEiCkVhgPfy/xD3K2g==
X-Received: by 2002:a92:c262:0:b0:2d1:3722:a3eb with SMTP id h2-20020a92c262000000b002d13722a3ebmr8880184ild.270.1653197926895;
        Sat, 21 May 2022 22:38:46 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id e16-20020a92d750000000b002cde6e352d9sm3031298ilq.35.2022.05.21.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 22:38:46 -0700 (PDT)
Date:   Sun, 22 May 2022 05:38:44 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 2/8] x86/alternative: introduce text_poke_set
Message-ID: <YonMZLyn6YJYnmjp@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220520031548.338934-1-song@kernel.org>
 <20220520031548.338934-3-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031548.338934-3-song@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 08:15:42PM -0700, Song Liu wrote:
> Introduce a memset like API for text_poke. This will be used to fill the
> unused RX memory with illegal instructions.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  arch/x86/include/asm/text-patching.h |  1 +
>  arch/x86/kernel/alternative.c        | 67 +++++++++++++++++++++++-----
>  2 files changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index d20ab0921480..1cc15528ce29 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern void text_poke_sync(void);
>  extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
>  extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
> +extern void *text_poke_set(void *addr, int c, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
>  
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d374cb3cf024..7563b5bc8328 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -994,7 +994,21 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>  __ro_after_init struct mm_struct *poking_mm;
>  __ro_after_init unsigned long poking_addr;
>  
> -static void *__text_poke(void *addr, const void *opcode, size_t len)
> +static void text_poke_memcpy(void *dst, const void *src, size_t len)
> +{
> +	memcpy(dst, src, len);
> +}
> +
> +static void text_poke_memset(void *dst, const void *src, size_t len)
> +{
> +	int c = *(const int *)src;
> +
> +	memset(dst, c, len);
> +}
> +
> +typedef void text_poke_f(void *dst, const void *src, size_t len);
> +
> +static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
>  {
>  	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
>  	struct page *pages[2] = {NULL};
> @@ -1059,7 +1073,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
>  	prev = use_temporary_mm(poking_mm);
>  
>  	kasan_disable_current();
> -	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +	func((u8 *)poking_addr + offset_in_page(addr), src, len);
>  	kasan_enable_current();
>  
>  	/*
> @@ -1087,11 +1101,13 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
>  			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
>  			   PAGE_SHIFT, false);
>  
> -	/*
> -	 * If the text does not match what we just wrote then something is
> -	 * fundamentally screwy; there's nothing we can really do about that.
> -	 */
> -	BUG_ON(memcmp(addr, opcode, len));
> +	if (func == text_poke_memcpy) {
> +		/*
> +		 * If the text does not match what we just wrote then something is
> +		 * fundamentally screwy; there's nothing we can really do about that.
> +		 */
> +		BUG_ON(memcmp(addr, src, len));

Maybe something like this?

	} else if (func == text_poke_memset) {
		WARN_ON or BUG_ON(memchr_inv(addr, *((const int *)src), len));
	}

Thanks,
Hyeonggon

>  
>  	local_irq_restore(flags);
>  	pte_unmap_unlock(ptep, ptl);
> @@ -1118,7 +1134,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  {
>  	lockdep_assert_held(&text_mutex);
>  
> -	return __text_poke(addr, opcode, len);
> +	return __text_poke(text_poke_memcpy, addr, opcode, len);
>  }
>  
>  /**
> @@ -1137,7 +1153,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>   */
>  void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
>  {
> -	return __text_poke(addr, opcode, len);
> +	return __text_poke(text_poke_memcpy, addr, opcode, len);
>  }
>  
>  /**
> @@ -1167,7 +1183,38 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
>  
>  		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
>  
> -		__text_poke((void *)ptr, opcode + patched, s);
> +		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
> +		patched += s;
> +	}
> +	mutex_unlock(&text_mutex);
> +	return addr;
> +}
> +
> +/**
> + * text_poke_set - memset into (an unused part of) RX memory
> + * @addr: address to modify
> + * @c: the byte to fill the area with
> + * @len: length to copy, could be more than 2x PAGE_SIZE
> + *
> + * This is useful to overwrite unused regions of RX memory with illegal
> + * instructions.
> + */
> +void *text_poke_set(void *addr, int c, size_t len)
> +{
> +	unsigned long start = (unsigned long)addr;
> +	size_t patched = 0;
> +
> +	if (WARN_ON_ONCE(core_kernel_text(start)))
> +		return NULL;
> +
> +	mutex_lock(&text_mutex);
> +	while (patched < len) {
> +		unsigned long ptr = start + patched;
> +		size_t s;
> +
> +		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
> +
> +		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
>  		patched += s;
>  	}
>  	mutex_unlock(&text_mutex);
> -- 
> 2.30.2
> 
> 
