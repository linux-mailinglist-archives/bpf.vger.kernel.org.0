Return-Path: <bpf+bounces-41819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444399B785
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 00:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C50281673
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EA14F102;
	Sat, 12 Oct 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNh/IU+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FC13213A;
	Sat, 12 Oct 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773149; cv=none; b=tASAnjPIu/cpJrskQ5hOkY3bMHqaVqVoQBUJwq88gB7cMKNIoKXqFWbP3BvM2c8NPq2qxy+hXZFaQuVU0hS4AAXncnDkTYWoJ5GjtmWheJ3zolC3EdyFs3bVRMsDfWTSXsa1dboaTq7ghDFxFC9QsX1h6C9vxlAdIXg0caNKPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773149; c=relaxed/simple;
	bh=apSETmSgP0hyh84sbZkXkLGAl9I4pwPXGMrb1597kao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHBNDW3HEb7lWUjuCy1iyfcHZZMz8rGuccmfwJXMp8eurEwYTj9CMXMyL+5KHwm5NR+GAyAslbr5hCEXuhyDUYNRDyl8zaFQ71GGJz9WJkIOsSnpcSwoihFRREM0iZRGMLsRv3a7krN26nWeUlibR9k26OfVaLktXFgv34M4Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNh/IU+w; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso26324485e9.0;
        Sat, 12 Oct 2024 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728773146; x=1729377946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrAqah5calgIhNd5J2K0kgxnrRY1RxWPFw2HfKMPoO0=;
        b=aNh/IU+wOQk94hCRPa5Yf+09c4U6hLe7FxtQ+mPXeqAOA3V0GIegYgAKwpCTkBfa0a
         MRba11sEPmnWVMqt+G9RUzd13B8yUFbIo9XPRbrUdt3jEvr0U+w4dBhirVJbx5UyG2Fx
         tcoMgnxMoY/5Z2xlgKG8x0m3HvdB4IGz66xaeMoFjj0eA7nmWIUzCTFnKnZc0pTIDItT
         Li2Z8Y1aUUBCzyGj9sKt0jiXApsWEaFrDke5vgT/0Ko/Or8k9tKBJHOqcxTHa1ZGyrPw
         tCxPQDsIIfmyb+YonXw1QLVMq7ncfluipnXjDlomeQr3GvXvZ7Dg7wPKpaRPMCuPxMwp
         XNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728773146; x=1729377946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrAqah5calgIhNd5J2K0kgxnrRY1RxWPFw2HfKMPoO0=;
        b=OTZRo6paJ1UXUc13k7W4zrs06ynMQDpEcFAlJaLY7qoC8Id7Ul/zNeftQydtF4pYFj
         W0nPE8czF91u1g9mer9vVQuJqP7HYLp7DfF2yRy7NFzw9qEHWTcBfz9JrFswSvx6nW5V
         3/crGSMeMSjsjqs4x2NHwI1ofPQDTi07BpkOlKZ7NPrg9U5pqfyo+z7LuxkMrrj9Fw/x
         G2txT5L6AyvJ5fDm1AaS2d5nDKzQKKv1HjakLK7zRMFij6jU6gUymmFov6M+rmqLC31W
         JewnPNPZZEqOBHWRDfhBqAqTYH3UaY/L7IyXymMcKUoaJPLcXbgYVB+IX7/J388reNfb
         UWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUJJPxyJlNnTRNzIYG8A545vr7Xe9GwrB+Po2VhW90zk1tdv6FB6qIR91zJcFG3PhCGzq0=@vger.kernel.org, AJvYcCWEtRgFDb6T9dTVdiUVuejyGE5egqtT8AQ7C9mq8Ef+B7Bzb3hHQBbA6Rq6wDi48fv6JFD9uRBu7FpQUs/j@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxtJAHrD3K6gPRVSsbOdZk9OKAbgxZTRWIpu1hh12JwvPH0mz
	Y1bz+UzGM05sg2cajkIk7HwbVIWsrh1C5LJwoaObcg2VQ3t5F58ugpZlNRtjr8s3iuHtPcH6Qft
	V9eniCo1fNa8i5FBbv8061pNN/AE=
X-Google-Smtp-Source: AGHT+IGbcU9EC65nnFvAa8jfBrfCQ1EvPVm0o/Tx0/F8uhISXF7+3QUzIEj0yWFxxEvXX3i4aKdgfbllJE1itf00xW0=
X-Received: by 2002:a05:6000:18e:b0:37d:3f81:153f with SMTP id
 ffacd0b85a97d-37d551fc17cmr5735258f8f.17.1728773145741; Sat, 12 Oct 2024
 15:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfs6bwdxkKPWWdNCjFH6H6hs0pFjaic12=HgB4b=Vv-xw@mail.gmail.com>
 <20241011035310.2982017-1-snovitoll@gmail.com>
In-Reply-To: <20241011035310.2982017-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 00:45:34 +0200
Message-ID: <CA+fCnZfznvJ-zaJg+Oeddt7OOPhnvkJ4z4N35rq5KXx2N=HBFw@mail.gmail.com>
Subject: Re: [PATCH v6] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, dvyukov@google.com, 
	elver@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 5:52=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
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

For future reference: please write commit messages in a way that is
readable standalone. I.e. without obscured references to the
discussions or problems in the previous versions of the patch. It's
fine to give such references in itself, but you need to give enough
context in the commit message to make it understandable without
looking up those discussions.

> copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> kunit test currently fails. Need more clarification on it.
>
> Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7=
qeeeAp_6yKjwKo8iw@mail.gmail.com/
> Reviewed-by: Marco Elver <elver@google.com>
> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D61123a5daeb9f7454599
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> v2:
> - squashed previous submitted in -mm tree 2 patches based on Linus tree
> v3:
> - moved checks to *_nofault_loop macros per Marco's comments
> - edited the commit message
> v4:
> - replaced Suggested-by with Reviewed-by
> v5:
> - addressed Andrey's comment on deleting CONFIG_KASAN_HW_TAGS check in
>   mm/kasan/kasan_test_c.c
> - added explanatory comment in kasan_test_c.c
> - added Suggested-by: Marco Elver back per Andrew's comment.
> v6:
> - deleted checks KASAN_TAG_MIN, KASAN_TAG_KERNEL per Andrey's comment.
> - added empty line before kfree.
> ---
>  mm/kasan/kasan_test_c.c | 34 ++++++++++++++++++++++++++++++++++
>  mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
>  mm/maccess.c            | 10 ++++++++--
>  3 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..716f2cac9708 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,6 +1954,39 @@ static void rust_uaf(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
>  }
>
> +static void copy_to_kernel_nofault_oob(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[128];
> +       size_t size =3D sizeof(buf);
> +
> +       /* This test currently fails with the HW_TAGS mode.
> +        * The reason is unknown and needs to be investigated. */
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> +
> +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
> +       /*
> +       * We test copy_to_kernel_nofault() to detect corrupted memory tha=
t is
> +       * being written into the kernel. In contrast, copy_from_kernel_no=
fault()
> +       * is primarily used in kernel helper functions where the source a=
ddress
> +       * might be random or uninitialized. Applying KASAN instrumentatio=
n to
> +       * copy_from_kernel_nofault() could lead to false positives.
> +       * By focusing KASAN checks only on copy_to_kernel_nofault(),
> +       * we ensure that only valid memory is written to the kernel,
> +       * minimizing the risk of kernel corruption while avoiding
> +       * false positives in the reverse case.
> +       */
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));
> +
> +       kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2027,6 +2060,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
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
> +       size_t size =3D sizeof(buf);
> +
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "copy_from_kernel_nofault");
> +       kunit_info(
> +               test,
> +               "testing copy_from_kernel_nofault with uninitialized memo=
ry\n");
> +
> +       ret =3D copy_from_kernel_nofault((char *)&buf[0], (char *)&src[0]=
, size);
> +       USE(ret);
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> +}
> +
>  static struct kunit_case kmsan_test_cases[] =3D {
>         KUNIT_CASE(test_uninit_kmalloc),
>         KUNIT_CASE(test_init_kmalloc),
> @@ -664,6 +680,7 @@ static struct kunit_case kmsan_test_cases[] =3D {
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
> @@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const voi=
d *unsafe_src,
>         return true;
>  }
>
> +/*
> + * The below only uses kmsan_check_memory() to ensure uninitialized kern=
el
> + * memory isn't leaked.
> + */
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
>         while (len >=3D sizeof(type)) {                                  =
 \
> -               __get_kernel_nofault(dst, src, type, err_label);         =
       \
> +               __get_kernel_nofault(dst, src, type, err_label);        \
> +               kmsan_check_memory(src, sizeof(type));                  \
>                 dst +=3D sizeof(type);                                   =
 \
>                 src +=3D sizeof(type);                                   =
 \
>                 len -=3D sizeof(type);                                   =
 \
> @@ -49,7 +54,8 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)    \
>         while (len >=3D sizeof(type)) {                                  =
 \
> -               __put_kernel_nofault(dst, src, type, err_label);         =
       \
> +               __put_kernel_nofault(dst, src, type, err_label);        \
> +               instrument_write(dst, sizeof(type));                    \
>                 dst +=3D sizeof(type);                                   =
 \
>                 src +=3D sizeof(type);                                   =
 \
>                 len -=3D sizeof(type);                                   =
 \
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>

For KASAN parts.

Thank you!

