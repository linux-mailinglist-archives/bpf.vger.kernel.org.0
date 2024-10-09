Return-Path: <bpf+bounces-41486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3299764E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 22:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2700A1F2378B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA21E22FE;
	Wed,  9 Oct 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUd7/p1e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174101E22E0;
	Wed,  9 Oct 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505140; cv=none; b=p0fzMBvuwrt+3br6MxEDRJuEcXzKdc3evS7mhOcHLNmH7buMXsaK0PA3lv6xtznoUe8pIZ+WTTSv3M5ACUhcosy2I0RzU5FJeFgEXEGcOr9vq5Pp2E3trLawW1E1wd9mqSIRttIWQqyNTrL4Mn0Fv6HiTR8JThplqEMYkSDr9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505140; c=relaxed/simple;
	bh=j54F2spr8DH4zZv+7maiA7eCGvCBWLOUclrK4vGLGHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0dp3fr5YDutp5GbMgDfSF7b5DRUK44lIsqrxGbPNlKCButKi/DypAMMVjOGfH2J4rC0lpymAsDBSZVnzUFKrB+FL0gtiRpNcCMIwT2hb5ZiIduxoHuTFAguXkzJueRbQTT7bnGu9bB+kMhAzHyqgJon9SN3mdQjTUdyQdQlXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUd7/p1e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311420b63fso1107985e9.2;
        Wed, 09 Oct 2024 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728505137; x=1729109937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c35+JpWEpsPpCJZNGS7NrTRM+BKUrPMr11LkkZQ0go=;
        b=LUd7/p1epRN/Z+S5lP9R0eAMVfYaOugXWXVRTqWK+wA7EPhthz89L6fopVe435kuRP
         J9xRzPI8zIt4gN58vZbWol+GO5+E33cmrUXS8VDo5Ugtvn4XLxPX/3zsn2TDKMGr5y+b
         X8EEVU5J3zxI6JiICR2ly1+wsVV/vVD7egWfmR29JULibULQVhcpw7Pa1Hw4R6+ZnRx/
         BfvA18myFWF9xthN38w6BzqIPGOOe7G2yIo+SA1B3Q4YtM9rKtlxZBYDOnUKkC1VfRek
         quXMghQxWbB/OCvBCzxSFp6IQyZNKeVunAV6y8QazC+TQDpxWukRtnTqGK2Boi4RLUZV
         sZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505137; x=1729109937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c35+JpWEpsPpCJZNGS7NrTRM+BKUrPMr11LkkZQ0go=;
        b=UD+QELQXUh+sNUibWHEwExx/SKs6bP4lryewbJaOzxGlwciR7ISSRi/FDEANhcTjvF
         8KyeQixG8LWkIQPCI+vq5SajcUtDRnX9Lmn/1mEwNCHZfmTA+663LNMnHnqm0abPw3T1
         XNYo/n6DlBmyYm2Rh0FvAfDbqcrxwC1qJX05wWLmZv48HBYkSH2ytSSJ4/cD5h86bZL0
         IGjq1kkYKFY/Hws+J9g99i1J4tvh9f0RhrSzSc3G8Z/i+gHsqdZhqbOxhb8mxp/nXmai
         g4NxpeZUaVI+rjLS7EmQAtjPHLtPFVi2jigb6jUpNx1gWCmYBDofq4JK+6p3y7yPrkMg
         iNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXI3u2Yiym6Ld2pcTXXBfuzqjZwA0Fc03ecGgjkIR9et/Qqj5rFKUzP7tL1lulEL291Kw=@vger.kernel.org, AJvYcCXyPO1ls8NObk3uunzwYXeawVQKwbVXMLlBa1ij9nlJjuTcMvoRmpJuS09Yx3R0e57OeULS4K8U+mSmlxqm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk76zv0kZFBR/Zlf0EQzM8oJKJOvIn5TdF/NDdGfT2/5O228Le
	Eee4/wktcgQ+noFUZ25seEF5PhwDpkYuzra+PuSlXMfVd4r7ZOoDxDp/TITFWFXkEz9H/Gv5xwC
	0Q6P1cThtyk8g/rQCNaSnhVtahPEKleqt
X-Google-Smtp-Source: AGHT+IEQx0AGyWtXNRqY8P/dVmpR3p8HBSZumK19Zat2IZqc0Ucy0FVIpxOiDWV8yz0RdA+qpWPoNIIl9Gw1vdotbQk=
X-Received: by 2002:adf:dd8d:0:b0:37d:31a7:2814 with SMTP id
 ffacd0b85a97d-37d3aa579famr2243483f8f.29.1728505137061; Wed, 09 Oct 2024
 13:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
 <20241008192910.2823726-1-snovitoll@gmail.com>
In-Reply-To: <20241008192910.2823726-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 9 Oct 2024 22:18:46 +0200
Message-ID: <CA+fCnZeMRZZe4A0QW4SSnEgXFEnb287PgHd5hVq8AA4itBFxEQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: elver@google.com, akpm@linux-foundation.org, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:28=E2=80=AFPM Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
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
>
> Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7=
qeeeAp_6yKjwKo8iw@mail.gmail.com/
> Reviewed-by: Marco Elver <elver@google.com>
> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D61123a5daeb9f7454599
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

(Back from travels, looking at the patches again.)

> ---
> v2:
> - squashed previous submitted in -mm tree 2 patches based on Linus tree
> v3:
> - moved checks to *_nofault_loop macros per Marco's comments
> - edited the commit message
> v4:
> - replaced Suggested-By with Reviewed-By: Marco Elver
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
> +       size_t size =3D sizeof(buf);
> +
> +       /* Not detecting fails currently with HW_TAGS */

Let's reword this to:

This test currently fails with the HW_TAGS mode. The reason is unknown
and needs to be investigated.

> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> +
> +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> +               /* Check that the returned pointer is tagged. */
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN=
);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KER=
NEL);
> +       }

Let's drop the checks above: if pointers returned by kmalloc are not
tagged, the checks below (and many other tests) will fail.

> +

Please add a comment here explaining why we only check
copy_to_kernel_nofault and not copy_from_kernel_nofault (is this
because we cannot add KASAN instrumentation to
copy_from_kernel_nofault?).

> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));
> +       kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2027,6 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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

