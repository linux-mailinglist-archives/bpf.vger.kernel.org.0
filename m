Return-Path: <bpf+bounces-41195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EB9942C9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2B1C262A7
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380971E102D;
	Tue,  8 Oct 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSJpxKSy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076501E0E08
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376323; cv=none; b=TN3Ym6f2dq5wmBgGmmW3tOz290ETIpJ354MP5IxJ5ikxNjiz1uExxTn/TWKehPkNQ4VXwC8QbCNog6SOdsuDOpYy4zT4gtySLUimwDN3CqV2BzhXVcGZlrcjS6n0/2nAUg4XFKcnoLttaywrePlNOgOPJOYzK3vmgINX1+cpv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376323; c=relaxed/simple;
	bh=Z75Sn9GTcfm0xV4hLIAiqsia//gfc5SQstwS3gjzZIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfYctbP+xI9v4ZxpFdrOjGcLIu6+xm/U3z2drLS+gncBsCK7jkzCEGRNkx6nni8A9SSKtH8ci7cCVzkkiXo0rVWganXblXBGG6uzNLayiNgOtBm7RCL55my1GPDlR6fmn9sfvApIdewoF4Ke6+DtpPdzkjGt4O7lC7SsbbLtWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSJpxKSy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf40737eso58013691fa.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728376320; x=1728981120; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu+DR2ol7NHxdHwZDLwzTYqI016h/oGfPfj/9x7pI30=;
        b=fSJpxKSy/D5WolJwqduy3V+5rrCpXVUXGB8UX1HsdXKRVflCJMpPemXg61GQVnkFFA
         jAKoRT+NwIt7e6XAY1Qo5T/j6MFQESzv5Yfw/RSVl5Wwf6EUWhfacXE3jMj6ctsGnPcG
         p91nvgc/rPrTI7rmPlgN16yjf8x556rnzecWEJG4hxZYHwI1NrQxh5XJ2MvoMJVjtvJO
         +nfUEwzwNLlj9TIw+Wn2LCLeQG3qy5exh5aYG75S0rmEBDtJvX3iEVGr4HtYovtkc6RO
         pYmIrYxMLGVvrAcWjTCJm2edkFwcolOMhl+SoFcVhlNYcM5YnDs5SIgLwtpa0qzVx+Ky
         +/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376320; x=1728981120;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu+DR2ol7NHxdHwZDLwzTYqI016h/oGfPfj/9x7pI30=;
        b=IN3u5aGL2ogAuH0ehaRDZsQYQ9fHFieScY3DeWHaMN07aMpnoJXyKTn3bsqiWyfu/P
         6nvK/m93VFa5wOLZQ3FVHh+V41VkMCzAC9Mz4Y+Ownh+d02cFVRtixjCPQQPu2xOVtLW
         Ai5xPCk8GPWm16jvwyjAeaodUMqZbUQXPomlHX2kNQGA0POn7DiMsjbGM62tj1z6pTpf
         z5xUKw+p60ZJglGcmponXnHwt/ZVtK6vfp1dPlSznCOlBKXziEHkIZ3ON+h4uX40U0XJ
         YX9drc6GQcSTxh5SURkJJp31DCFwOcwWzvaVIZ+5C7cuk0b1KgBtszKM2L+PxeXM3C32
         uSEA==
X-Forwarded-Encrypted: i=1; AJvYcCXVNp1GFzXOt+o8bAqGcG7DsG0+nIq8Voq3sCtgeC2wkEtrKdmwzfTBiHlPtdoBrXtu60g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6io+dH46rTPZ3Cj4wSNPVxQUJfb+MFXQxNMCSuiOS3IfgKak
	jF/xd5scPaHovGYh4jexZ45WD4UEvq2if5WJtn1/nwLOkqDy4/aE02g0K6Ka0w==
X-Google-Smtp-Source: AGHT+IHRPjdEucYpIL19B14B0iOgGVC/Si4jbJW6VKT4Gyy1C4mm+LnefOrrfcRw+0WtP/7jvOcAtw==
X-Received: by 2002:a05:6512:104b:b0:536:a5ee:ac01 with SMTP id 2adb3069b0e04-539ab86288amr6724752e87.4.1728376319850;
        Tue, 08 Oct 2024 01:31:59 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c862:2d9d:4fdd:3ea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm118748205e9.44.2024.10.08.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:31:59 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:31:53 +0200
From: Marco Elver <elver@google.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org,
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH v2 1/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
Message-ID: <ZwTt-Sq5bsovQI5X@elver.google.com>
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
 <20241005164813.2475778-1-snovitoll@gmail.com>
 <20241005164813.2475778-2-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005164813.2475778-2-snovitoll@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Sat, Oct 05, 2024 at 09:48PM +0500, Sabyrzhan Tasbolatov wrote:
> Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kernel
> memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> the memory corruption.
> 
> syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> KASAN report via kasan_check_range() which is not the expected behaviour
> as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> 
> Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
> kernel memory. In copy_to_kernel_nofault() we can retain
> instrument_write() for the memory corruption instrumentation but before
> pagefault_disable().

I don't understand why it has to be before the whole copy i.e. before
pagefault_disable()?

I think my suggestion was to only check the memory where no fault
occurred. See below.

> diff --git a/mm/maccess.c b/mm/maccess.c
> index 518a25667323..a91a39a56cfd 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
>  
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
>  	while (len >= sizeof(type)) {					\
> -		__get_kernel_nofault(dst, src, type, err_label);		\
> +		__get_kernel_nofault(dst, src, type, err_label);	\
>  		dst += sizeof(type);					\
>  		src += sizeof(type);					\
>  		len -= sizeof(type);					\
> @@ -31,6 +31,8 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!copy_from_kernel_nofault_allowed(src, size))
>  		return -ERANGE;
>  
> +	/* Make sure uninitialized kernel memory isn't copied. */
> +	kmsan_check_memory(src, size);
>  	pagefault_disable();
>  	if (!(align & 7))
>  		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
> @@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>  
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
>  	while (len >= sizeof(type)) {					\
> -		__put_kernel_nofault(dst, src, type, err_label);		\
> +		__put_kernel_nofault(dst, src, type, err_label);	\
>  		dst += sizeof(type);					\
>  		src += sizeof(type);					\
>  		len -= sizeof(type);					\
> @@ -62,6 +64,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>  		align = (unsigned long)dst | (unsigned long)src;
>  
> +	instrument_write(dst, size);
>  	pagefault_disable();

So this will check the whole range before the access. But if the copy
aborts because of a fault, then we may still end up with false
positives.

Why not something like the below - normally we check the accesses
before, but these are debug kernels anyway, so I see no harm in making
an exception in this case and checking the memory if there was no fault
i.e. it didn't jump to err_label yet. It's also slower because of
repeated calls, but these helpers aren't frequently used.

The alternative is to do the sanitizer check after the entire copy if we
know there was no fault at all. But that may still hide real bugs if
e.g. it starts copying some partial memory and then accesses an
unfaulted page.


diff --git a/mm/maccess.c b/mm/maccess.c
index a91a39a56cfd..3ca55ec63a6a 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 	return true;
 }
 
+/*
+ * The below only uses kmsan_check_memory() to ensure uninitialized kernel
+ * memory isn't leaked.
+ */
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
 		__get_kernel_nofault(dst, src, type, err_label);	\
+		kmsan_check_memory(src, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -31,8 +36,6 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
-	/* Make sure uninitialized kernel memory isn't copied. */
-	kmsan_check_memory(src, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
@@ -52,6 +55,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
 		__put_kernel_nofault(dst, src, type, err_label);	\
+		instrument_write(dst, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -64,7 +68,6 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	instrument_write(dst, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);

