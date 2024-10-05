Return-Path: <bpf+bounces-41048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9872991620
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2391C21890
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B2149013;
	Sat,  5 Oct 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXvc339g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000A13A250
	for <bpf@vger.kernel.org>; Sat,  5 Oct 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124645; cv=none; b=QMScM9dFfbfDowtdP9EEnkY1Hw9dWDvIsFYKQqSfBBathE8GD/vNXOjuPalj40HZdQzsgB0ag5l58O45D746wv/5w4WipUZpW/9IpSHLSZTkMgWPQkVdeNtbbRWen4EbFmm1vRzfh7JWcsFJQtiKAj0D4xTUFwAlSn7ezdasWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124645; c=relaxed/simple;
	bh=xXuYtNAETQ1g5JcjlzOE5MFvfpkQQOj1E6OhX/1lXZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aihfDydCE0Ivyx230KHFDyksI0/qCoKJVYFaKot5G1enmfDBnQsBt/9B6Qi/ktujCRcM93HTyvlHqDvPmzBQHLXD6eUZolCiV6C1OB+aiMuhSUL3QTNQoFjxrksYvOF8cTSCG3ETzfwAS7zyml2DiZX6uKL7SOriZCraSrfdNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXvc339g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so2241834a91.2
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2024 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728124643; x=1728729443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4ms11ZQkraDYH9Xo26ocEAmXpjpDosjseyHDy0gtFw=;
        b=wXvc339gD3yax5pXG8Oz24licvzXm3QJyLsxLFvtE69FsgpBYStAz8o5EyW+ba4BGy
         jM2oRVmPEuLFhMbW3XXTehTomowxtqcT1gCUYM/AcR9aK3b5pBaKYXHQ6marbSpmgKXw
         USdT5DpumO+RhRHEoA/jqrd8JnlBOdZJIIUSAMmDSGTudeypSm+FovDJ0BnDUn0AQGvW
         ZepE6tHXni+tzjMDFRlnsjHsVbVZqCPK/X6pBB/xuXpHRPFA5GhhDhSsjKNMdTjhuYJK
         WZaiWgr9ATN5aPUjum9LwPbOrLXaLtJ9TibwsuWbEM7P8ox28c8IvwUrcIZjXaOt4MKa
         Ngmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728124643; x=1728729443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4ms11ZQkraDYH9Xo26ocEAmXpjpDosjseyHDy0gtFw=;
        b=NW6U4fmfFu+X7Ei3G9N+Gor/x4k+7Fjh6PE57VhuilknACyyieltP0/PYPUBk0hpyX
         uNREfRpGpJuhWWLKWzSt37eNFMucIrmX0Je/yNnAWclu7DIQB9nV2yHfm6J20kCzNamq
         Hf2BZARpOQKjkzI9RbyjSA1MS61AH4Ljd5kjFP6B+/oTh50RY6u46LlHsV6vU5f2P05O
         JMJct0D207kgIucqCrkxn13CK2g3+lZW0521nBYMl57k9ZanueX7E23K/qKti7n3fbzV
         E7Z5mYob/OnGdTtJEq5ijTh9Q39gYUN6PQ6n+DwPKTexU8oU4z5ZDbXcdkfkeOI/459f
         PpAw==
X-Forwarded-Encrypted: i=1; AJvYcCWqlEzysIl7twodbAbz/1CuBxlXZs9FrBPQf59nV2K+mFLDOvIqG4bfSv4fjevqBctdzR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6bm0joM1US3nr9y1QQ0DMiRrPXYiG+NOtb5PsPfioiQI7+/L
	+hT+Nw730jucAnD4Suec+JXv9MbZ1sfyRYmg93Msdp7/itjNjptm05vAeABGFDAXWmGYEV4DJeN
	LmY3Bg8QzAqnx5OTpwWeDRxsN0G/4CXvX8WKT
X-Google-Smtp-Source: AGHT+IFpelqnAaOBUIxS1I4oQr1q2aEbZ56jlxqBJluUueazlQUie6wZxLwd0KZecIyBO72JszXXXVvhtpu6+8xR5xo=
X-Received: by 2002:a17:90b:494:b0:2c9:b72:7a1f with SMTP id
 98e67ed59e1d1-2e1e632369fmr7417174a91.28.1728124642435; Sat, 05 Oct 2024
 03:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005092316.2471810-1-snovitoll@gmail.com>
In-Reply-To: <20241005092316.2471810-1-snovitoll@gmail.com>
From: Marco Elver <elver@google.com>
Date: Sat, 5 Oct 2024 12:36:44 +0200
Message-ID: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
Subject: Re: [PATCH] mm, kmsan: instrument copy_from_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, akpm@linux-foundation.org, vincenzo.frascino@arm.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 11:22, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
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
>
> Added KMSAN and modified KASAN kunit tests and tested on x86_64.
>
> This is the part of PATCH series attempting to properly address bugzilla
> issue.
>
> Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> Suggested-by: Marco Elver <elver@google.com>
> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

I'm getting confused which parts are already picked up by Andrew into
-mm, and which aren't.

To clarify we have:
 1. https://lore.kernel.org/mm-commits/20240927171751.D1BD9C4CEC4@smtp.kernel.org/
 2. https://lore.kernel.org/mm-commits/20240930162435.9B6CBC4CED0@smtp.kernel.org/

And this is the 3rd patch, which applies on top of the other 2.

If my understanding is correct, rather than just adding fix on top of
fix, in the interest of having one clean patch which can also be
backported more easily, would it make sense to drop the first 2
patches from -mm, and you send out one clean patch series?

Thanks,
-- Marco

> ---
>  mm/kasan/kasan_test_c.c |  8 ++------
>  mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
>  mm/maccess.c            |  5 +++--
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 0a226ab032d..5cff90f831d 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,7 +1954,7 @@ static void rust_uaf(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
>  }
>
> -static void copy_from_to_kernel_nofault_oob(struct kunit *test)
> +static void copy_to_kernel_nofault_oob(struct kunit *test)
>  {
>         char *ptr;
>         char buf[128];
> @@ -1973,10 +1973,6 @@ static void copy_from_to_kernel_nofault_oob(struct kunit *test)
>                 KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               copy_from_kernel_nofault(&buf[0], ptr, size));
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               copy_from_kernel_nofault(ptr, &buf[0], size));
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 copy_to_kernel_nofault(&buf[0], ptr, size));
>         KUNIT_EXPECT_KASAN_FAIL(test,
> @@ -2057,7 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(match_all_not_assigned),
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
> -       KUNIT_CASE(copy_from_to_kernel_nofault_oob),
> +       KUNIT_CASE(copy_to_kernel_nofault_oob),
>         KUNIT_CASE(rust_uaf),
>         {}
>  };
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 13236d579eb..9733a22c46c 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -640,6 +640,22 @@ static void test_unpoison_memory(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +static void test_copy_from_kernel_nofault(struct kunit *test)
> +{
> +       long ret;
> +       char buf[4], src[4];
> +       size_t size = sizeof(buf);
> +
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "copy_from_kernel_nofault");
> +       kunit_info(
> +               test,
> +               "testing copy_from_kernel_nofault with uninitialized memory\n");
> +
> +       ret = copy_from_kernel_nofault((char *)&buf[0], (char *)&src[0], size);
> +       USE(ret);
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> +}
> +
>  static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_uninit_kmalloc),
>         KUNIT_CASE(test_init_kmalloc),
> @@ -664,6 +680,7 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_long_origin_chain),
>         KUNIT_CASE(test_stackdepot_roundtrip),
>         KUNIT_CASE(test_unpoison_memory),
> +       KUNIT_CASE(test_copy_from_kernel_nofault),
>         {},
>  };
>
> diff --git a/mm/maccess.c b/mm/maccess.c
> index f752f0c0fa3..a91a39a56cf 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -31,8 +31,9 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>         if (!copy_from_kernel_nofault_allowed(src, size))
>                 return -ERANGE;
>
> +       /* Make sure uninitialized kernel memory isn't copied. */
> +       kmsan_check_memory(src, size);
>         pagefault_disable();
> -       instrument_read(src, size);
>         if (!(align & 7))
>                 copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
>         if (!(align & 3))
> @@ -63,8 +64,8 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>                 align = (unsigned long)dst | (unsigned long)src;
>
> -       pagefault_disable();
>         instrument_write(dst, size);
> +       pagefault_disable();
>         if (!(align & 7))
>                 copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
>         if (!(align & 3))
> --
> 2.34.1
>

