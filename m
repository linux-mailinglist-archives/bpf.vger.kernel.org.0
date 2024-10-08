Return-Path: <bpf+bounces-41250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553F4994754
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39D31F23AE4
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813A1DED69;
	Tue,  8 Oct 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzL9ZZ4X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7B1D432D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387364; cv=none; b=CIBxZoMAfhRgAwPVxtpwhh1NbeMq0fFYJrQ7LzOKpEQ2qutqvnKV18GV44kbBO3owW1mUDYiG2Gt3D+gEwWDuY/RF8OdKwtQeZMTAoWdNq0mvcInRA5YTy9X+uxQjjF1z6ZO0wMFf6orBRGe6tsVrBX4Cs8+9XWTPFowfotQFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387364; c=relaxed/simple;
	bh=tHFU/gwRkf0aidZZCKieHpOpBAoouiQWmHaCzMBpxuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkeJY9/aWCK7gRNfQ95ycXecXhy2ZYkY3wOn41byjCWi4QmdespJMVCVNop5KU5wQ2uAhgu3hBKvoyM0zyf8mM12xc8ptWx5QSI6aAe5DONN7UIoXb8Blp/mhnngxpzzYnpEUrhGCT9mDNNcS2T7HHrTFFq5MVXewKt7FeIUBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzL9ZZ4X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bcae5e482so48011045ad.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728387362; x=1728992162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALIusGAUH/4/gvGvjWJecPeh4PIpgeoXr9PxFWIdEcw=;
        b=mzL9ZZ4Xwgxw43LTldV46RLlhetw7R87vx7uGO1Wdj1DJT0BAalLZ6+BbZSwnH/hR2
         vJABztnA3IedyPMwFt7Fasuzwc8tlbc0HxUyy/e0Gda7p0QD+RH34PvRMJiolIMJgWDP
         ZaxO0juP55/TN2cHrly/jWXNlpkGy+QPP1Oy1/YqGOpw6idkAcpd27k/CNR6Wemaqm6a
         nMHNW0sA2IuyYN1+ieEzwnV8gdanNL8nL27+HizsduufnyoZdDrolWJWEluMfUoGicY+
         a+hiT+cakw9G/sk6vGC6HYYTuMVmSGse2mimlhFOblsuzKnxBY7vxrHAiZddTXMwkAAS
         dYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387362; x=1728992162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALIusGAUH/4/gvGvjWJecPeh4PIpgeoXr9PxFWIdEcw=;
        b=wgEcaBfR42x8qpGSCX0EUMwIQ+tKm2XKYuEF7GLpVigqH+ilxDRlLBdEWZ1h5qtndX
         LKXR8QHLrPXXC80u/Yf/XumElOHose2rsVusnLKMXtbTR9l7tTmJAZauPdBDVRwH/UAb
         ap8Feipg8EQmjO5zrOhxLa0dToB8A3fxtLkMu+TYEKWi39qR26Elf6Dq8N7WOi/eNOCL
         TIkMv/SnuRGE49oTQPxX9xh3Z76hiYhbmDPeRZSSEumX4O4eEC8sIvzV4vPNRYT0FXUd
         XxGrZ0n1KH5dJBdRNB6OP8Yq0O7yrgz43X3bMnaGEPoZUzaHEHZDMfqUjB5Fg8HGkWNV
         8ycA==
X-Forwarded-Encrypted: i=1; AJvYcCUj1ii+Y1y1mNladVBrhYyCzXIEt4JRtTAiJgKyNGs/LvYiamkfMa7psCOLhPfXGSWk4wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWh1mr9UB5Wf5XOZattLycMjV4B9/0D0WEiJv6rcckO3Rb1T0y
	d4Hk5aGu3mrf7rMaLMwd/WW9LYeueTL5OQJPjU40kqYRKHMIt0keVbBXUgjW5BGAOqTX2u8csXF
	vY/kI3czd3XrGboP38U049DaYfHPbnYf+iBE8
X-Google-Smtp-Source: AGHT+IGUCuCcx5Oq/sXgMeQZzWnV/tGknipDCQlPgw8tYwUKUn2ZopWd01vBpejmDEYjMN4BboM7KCNc5K5vujleOvM=
X-Received: by 2002:a17:90a:bc92:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e1e63bf552mr17536878a91.38.1728387361594; Tue, 08 Oct 2024
 04:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
 <20241008101526.2591147-1-snovitoll@gmail.com>
In-Reply-To: <20241008101526.2591147-1-snovitoll@gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 8 Oct 2024 13:35:22 +0200
Message-ID: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
Subject: Re: [PATCH v3] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 12:14, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
>
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
> instrument_write() explicitly for the memory corruption instrumentation.
>
> copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> kunit test currently fails. Need more clarification on it
> - currently, disabled in kunit test.

I assume you retested. Did you also test the bpf_probe_read_kernel()
false positive no longer appears?

> Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> Suggested-by: Marco Elver <elver@google.com>

This looks more reasonable:

Reviewed-by: Marco Elver <elver@google.com>

This looks like the most conservative thing to do for now.

> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> v2:
> - squashed previous submitted in -mm tree 2 patches based on Linus tree
> v3:
> - moved checks to *_nofault_loop macros per Marco's comments
> - edited the commit message
> ---
>  mm/kasan/kasan_test_c.c | 27 +++++++++++++++++++++++++++
>  mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
>  mm/maccess.c            | 10 ++++++++--
>  3 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..5cff90f831db 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,6 +1954,32 @@ static void rust_uaf(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
>  }
>
> +static void copy_to_kernel_nofault_oob(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[128];
> +       size_t size = sizeof(buf);
> +
> +       /* Not detecting fails currently with HW_TAGS */
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> +
> +       ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> +               /* Check that the returned pointer is tagged. */
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +       }
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));
> +       kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2027,6 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(match_all_not_assigned),
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
> +       KUNIT_CASE(copy_to_kernel_nofault_oob),
>         KUNIT_CASE(rust_uaf),
>         {}
>  };
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 13236d579eba..9733a22c46c1 100644
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
> index 518a25667323..3ca55ec63a6a 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
>         return true;
>  }
>
> +/*
> + * The below only uses kmsan_check_memory() to ensure uninitialized kernel
> + * memory isn't leaked.
> + */
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
>         while (len >= sizeof(type)) {                                   \
> -               __get_kernel_nofault(dst, src, type, err_label);                \
> +               __get_kernel_nofault(dst, src, type, err_label);        \
> +               kmsan_check_memory(src, sizeof(type));                  \
>                 dst += sizeof(type);                                    \
>                 src += sizeof(type);                                    \
>                 len -= sizeof(type);                                    \
> @@ -49,7 +54,8 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)    \
>         while (len >= sizeof(type)) {                                   \
> -               __put_kernel_nofault(dst, src, type, err_label);                \
> +               __put_kernel_nofault(dst, src, type, err_label);        \
> +               instrument_write(dst, sizeof(type));                    \
>                 dst += sizeof(type);                                    \
>                 src += sizeof(type);                                    \
>                 len -= sizeof(type);                                    \
> --
> 2.34.1
>

