Return-Path: <bpf+bounces-41294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF69957BE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E291C219BA
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C795213EE2;
	Tue,  8 Oct 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULv8+xCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66286770E2;
	Tue,  8 Oct 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416323; cv=none; b=ZhPmuWP3xUmqp5c0mWgmvswNmzS1ZtGLtHzKF/QcxZ96jPAY5i2vrfTibBV/lDFT0tYV3vx/aJq4dQfe1DApC9udqnnzlKuoMe4jHt4ZPDhFsLnQtQIe0Q/A1nh7g1fUr1vvQjCnjtyjHjWO0BE1UuVvScamBXNCLlbVbL/v5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416323; c=relaxed/simple;
	bh=Ik3RXqF0OckT22GAlkxDsmLwmlw/W4GHtmz72BVjk7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJh3gJxLr0O6Rdg49UN8WlletAWCrjv2FuesA24luc0EHhZXZrgTEvix/CdEm91y7MAkRubmWXSxIGU5Ew6zITBIBLozUcGNGD32fUIMUayIv8Igsm+6uJ/HVwG4koRk6JbMnayXfqVAxlyQrq3zlHdRQladXFD9ioFmdLv4qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULv8+xCa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so296666a12.0;
        Tue, 08 Oct 2024 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416317; x=1729021117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU/Z0kwK+eaj75ISibAXbIBx/QyJ6gNEXpgdp3T0PQM=;
        b=ULv8+xCayDP9c7vsfD7DyI7qdC2H3eTi0lDmwcBaYaII40RYFsdVAg10FI9JIKt26a
         M01iK9717X+kPGZtgAapT1GmU0m8cU5kTpShptsKZYjfM926SdS3hbgS0FnPvyjDpppo
         qsHwCmVaV9tTKzaJmgDYV8FPhKXbVYiTgSjYvTeYztSeulolBAkTiFJWi3UNKoZAOyEP
         F5v2JlRqF5wBJKLBgMdl87Tr137RnPzbWTOvuJM8/zpXnZmQ+huvpGyJGZaFhCHm+eFC
         ysXdjSDN+M+dWfhlk78lqy03z6j3y9v8M+vLOvyxxL7tc5Ugr1Z+VG4mf6ZEz4yDvpOt
         8fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416317; x=1729021117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU/Z0kwK+eaj75ISibAXbIBx/QyJ6gNEXpgdp3T0PQM=;
        b=J5vJNuq3s1o+qdzVR67COlWCnvseEXT1tgDTLVBk6Lhz3Pnp/AxFXma9dhl3/x2XsX
         J64X8XG8WbbjMC5ckQCcFeA6wlzec71fW87BSb+WvLK8QlUf5DhJuQTjaaB1wPgYufjW
         C4fppj/GIqFjwmOvzZOvtlMW4JwB66cj5wrDksbGVmXGMhsIsExS2flWddkoo8xj89oe
         0QNCLbNY7jYY/FXcGk5E7e7hf8inxFjULmVqvdt9jRfB1g3zq/h1npuTQOcGr+pBMb80
         E3GFpg8YD6Mq4k1iRo2SQbOVKe0zJ6i5BapyGVqVX2Ww45nU+BjpszaPiZ9DSyrXOPEb
         yMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9ggdnaRvYrJzfgsCxDT+aj6UG3WiVe0qqwSghF263/cPefpUMO/ZpLcNuNwEQyexNqg=@vger.kernel.org, AJvYcCWtofW3hv90w/48pcTdTszIfa1lDEWtbmGQfapNkE1wCpfxx8BwCkoM7kwm86IyY2kc+97jKgEhSEl0L6wa@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBPI2LYHu6ikbES5h1qySJ+lYThlemG4LSDxG5X2d5+JWigHo
	dyMeN/ljjhmjIsx1A2TbK/u4XsfhbW3SG0uEG68i3+cC0WUlgRvFwtMwLpbhrpQRKDIo3J9GYR6
	beGDb83dOW8zTAucv60JJNsDu8DQ=
X-Google-Smtp-Source: AGHT+IFVcrrrfNVBSDdyr6cJG45dXwexTXGVHMegMHCll8wICMefrggSUiyolMkyX9cvTbn4Sc3M1qUqNQxKNoUWZCY=
X-Received: by 2002:a05:6402:1f4b:b0:5c9:11d9:f9b2 with SMTP id
 4fb4d7f45d1cf-5c911d9ff57mr2878883a12.9.1728416316561; Tue, 08 Oct 2024
 12:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
 <20241008101526.2591147-1-snovitoll@gmail.com> <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
In-Reply-To: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 9 Oct 2024 00:39:24 +0500
Message-ID: <CACzwLxhkooTNjijL71AVKm85XChycy1b-Ew11nMbBQWMxNebfw@mail.gmail.com>
Subject: Re: [PATCH v3] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Marco Elver <elver@google.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:36=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Tue, 8 Oct 2024 at 12:14, Sabyrzhan Tasbolatov <snovitoll@gmail.com> w=
rote:
> >
> > Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kern=
el
> > memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> > the memory corruption.
> >
> > syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> > KASAN report via kasan_check_range() which is not the expected behaviou=
r
> > as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> >
> > Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> > copy_from_kernel_nofault() with KMSAN detection of copying uninitilaize=
d
> > kernel memory. In copy_to_kernel_nofault() we can retain
> > instrument_write() explicitly for the memory corruption instrumentation=
.
> >
> > copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> > CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> > kunit test currently fails. Need more clarification on it
> > - currently, disabled in kunit test.
>
> I assume you retested. Did you also test the bpf_probe_read_kernel()
> false positive no longer appears?
I've tested on:
- x86_64 with KMSAN
- x86_64 with KASAN
- arm64 with HW_TAGS -- still failing
- arm64 with SW_TAGS
Please see the testing result in the following link:
https://gist.github.com/novitoll/e2ccb2162340f7f8a63b63ee3e0f9994

I've also tested bpf_probe_read_kernel() in x86_64 KMSAN build,
it does trigger KMSAN, though I don't see explicitly copy_from_kernel*
in stack frame. AFAIU, it's checked prior to it in text_poke_copy().

Attached the PoC in the comment of the link above:

root@syzkaller:/tmp# uname -a
Linux syzkaller 6.12.0-rc2-g441b500abd70 #10 SMP PREEMPT_DYNAMIC Wed
Oct 9 00:17:59 +05 2024 x86_64 GNU/Linux
root@syzkaller:/tmp# ./exploit
[*] exploit start
[+] program loaded!
[ 139.778255] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ 139.778846] BUG: KMSAN: uninit-value in bcmp+0x155/0x290
[ 139.779311] bcmp+0x155/0x290
[ 139.779591] __text_poke+0xe2d/0x1120
[ 139.779950] text_poke_copy+0x1e7/0x2b0
[ 139.780297] bpf_arch_text_copy+0x41/0xa0
[ 139.780665] bpf_dispatcher_change_prog+0x12dd/0x16b0
[ 139.781324] bpf_prog_test_run_xdp+0xbf0/0x1d20
[ 139.781898] bpf_prog_test_run+0x5d6/0x9a0
[ 139.782372] __sys_bpf+0x758/0xf10
[ 139.782759] __x64_sys_bpf+0xdd/0x130
[ 139.783178] x64_sys_call+0x1a21/0x4e10
[ 139.783610] do_syscall_64+0xcd/0x1b0
[ 139.784039] entry_SYSCALL_64_after_hwframe+0x67/0x6f
[ 139.784597]
[ 139.784779] Uninit was created at:
[ 139.785197] __alloc_pages_noprof+0x717/0xe70
[ 139.785689] alloc_pages_bulk_noprof+0x17e1/0x20e0
[ 139.786223] alloc_pages_bulk_array_mempolicy_noprof+0x49e/0x5b0
[ 139.786873] __vmalloc_node_range_noprof+0xef2/0x24f0
[ 139.787414] execmem_alloc+0x1ec/0x4c0
[ 139.787841] bpf_jit_alloc_exec+0x3e/0x40
[ 139.788299] bpf_dispatcher_change_prog+0x430/0x16b0
[ 139.788837] bpf_prog_test_run_xdp+0xbf0/0x1d20
[ 139.789324] bpf_prog_test_run+0x5d6/0x9a0
[ 139.789774] __sys_bpf+0x758/0xf10
[ 139.790167] __x64_sys_bpf+0xdd/0x130
[ 139.790580] x64_sys_call+0x1a21/0x4e10
[ 139.791007] do_syscall_64+0xcd/0x1b0
[ 139.791423] entry_SYSCALL_64_after_hwframe+0x67/0x6f
>
> > Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1=
X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> > Suggested-by: Marco Elver <elver@google.com>
>
> This looks more reasonable:
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> This looks like the most conservative thing to do for now.
Done.
>
> > Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D61123a5daeb9f7454599
> > Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > v2:
> > - squashed previous submitted in -mm tree 2 patches based on Linus tree
> > v3:
> > - moved checks to *_nofault_loop macros per Marco's comments
> > - edited the commit message
> > ---
> >  mm/kasan/kasan_test_c.c | 27 +++++++++++++++++++++++++++
> >  mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
> >  mm/maccess.c            | 10 ++++++++--
> >  3 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index a181e4780d9d..5cff90f831db 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -1954,6 +1954,32 @@ static void rust_uaf(struct kunit *test)
> >         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
> >  }
> >
> > +static void copy_to_kernel_nofault_oob(struct kunit *test)
> > +{
> > +       char *ptr;
> > +       char buf[128];
> > +       size_t size =3D sizeof(buf);
> > +
> > +       /* Not detecting fails currently with HW_TAGS */
> > +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> > +
> > +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +       OPTIMIZER_HIDE_VAR(ptr);
> > +
> > +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> > +               /* Check that the returned pointer is tagged. */
> > +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_M=
IN);
> > +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_K=
ERNEL);
> > +       }
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(&buf[0], ptr, size));
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(ptr, &buf[0], size));
> > +       kfree(ptr);
> > +}
> > +
> >  static struct kunit_case kasan_kunit_test_cases[] =3D {
> >         KUNIT_CASE(kmalloc_oob_right),
> >         KUNIT_CASE(kmalloc_oob_left),
> > @@ -2027,6 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[]=
 =3D {
> >         KUNIT_CASE(match_all_not_assigned),
> >         KUNIT_CASE(match_all_ptr_tag),
> >         KUNIT_CASE(match_all_mem_tag),
> > +       KUNIT_CASE(copy_to_kernel_nofault_oob),
> >         KUNIT_CASE(rust_uaf),
> >         {}
> >  };
> > diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> > index 13236d579eba..9733a22c46c1 100644
> > --- a/mm/kmsan/kmsan_test.c
> > +++ b/mm/kmsan/kmsan_test.c
> > @@ -640,6 +640,22 @@ static void test_unpoison_memory(struct kunit *tes=
t)
> >         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> >  }
> >
> > +static void test_copy_from_kernel_nofault(struct kunit *test)
> > +{
> > +       long ret;
> > +       char buf[4], src[4];
> > +       size_t size =3D sizeof(buf);
> > +
> > +       EXPECTATION_UNINIT_VALUE_FN(expect, "copy_from_kernel_nofault")=
;
> > +       kunit_info(
> > +               test,
> > +               "testing copy_from_kernel_nofault with uninitialized me=
mory\n");
> > +
> > +       ret =3D copy_from_kernel_nofault((char *)&buf[0], (char *)&src[=
0], size);
> > +       USE(ret);
> > +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> > +}
> > +
> >  static struct kunit_case kmsan_test_cases[] =3D {
> >         KUNIT_CASE(test_uninit_kmalloc),
> >         KUNIT_CASE(test_init_kmalloc),
> > @@ -664,6 +680,7 @@ static struct kunit_case kmsan_test_cases[] =3D {
> >         KUNIT_CASE(test_long_origin_chain),
> >         KUNIT_CASE(test_stackdepot_roundtrip),
> >         KUNIT_CASE(test_unpoison_memory),
> > +       KUNIT_CASE(test_copy_from_kernel_nofault),
> >         {},
> >  };
> >
> > diff --git a/mm/maccess.c b/mm/maccess.c
> > index 518a25667323..3ca55ec63a6a 100644
> > --- a/mm/maccess.c
> > +++ b/mm/maccess.c
> > @@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const v=
oid *unsafe_src,
> >         return true;
> >  }
> >
> > +/*
> > + * The below only uses kmsan_check_memory() to ensure uninitialized ke=
rnel
> > + * memory isn't leaked.
> > + */
> >  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) =
 \
> >         while (len >=3D sizeof(type)) {                                =
   \
> > -               __get_kernel_nofault(dst, src, type, err_label);       =
         \
> > +               __get_kernel_nofault(dst, src, type, err_label);       =
 \
> > +               kmsan_check_memory(src, sizeof(type));                 =
 \
> >                 dst +=3D sizeof(type);                                 =
   \
> >                 src +=3D sizeof(type);                                 =
   \
> >                 len -=3D sizeof(type);                                 =
   \
> > @@ -49,7 +54,8 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
> >
> >  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)   =
 \
> >         while (len >=3D sizeof(type)) {                                =
   \
> > -               __put_kernel_nofault(dst, src, type, err_label);       =
         \
> > +               __put_kernel_nofault(dst, src, type, err_label);       =
 \
> > +               instrument_write(dst, sizeof(type));                   =
 \
> >                 dst +=3D sizeof(type);                                 =
   \
> >                 src +=3D sizeof(type);                                 =
   \
> >                 len -=3D sizeof(type);                                 =
   \
> > --
> > 2.34.1
> >

