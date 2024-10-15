Return-Path: <bpf+bounces-42009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F999E4F9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90E2284820
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69711D5AA7;
	Tue, 15 Oct 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3VvS4Uf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B5140E50;
	Tue, 15 Oct 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990286; cv=none; b=Trx428itbKpG4lboFaI6HfPMGV8sgrgv4m35lYD00rHw+tHXNV8ObB2Fdiwv7l9WYcNC15ziq2ns2/eKEchcBSA2cMViIe75l++vp3WntgvlMRKHcFS7RxDOtisfB0tBLYnCXIApPbIpAQkGF8dJs2rcJm6QW6pMmTIkzFph2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990286; c=relaxed/simple;
	bh=EHs9TNHyAZCmkepfPPiXFBa/6zhy+DQq43xy9DSyA7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc0+V7yO525XpiYkfC8d0GoVLs683o6uRRVbuJ95xqkfWsTBP7UR7u8C1Rt6uObyi5vEqxKAer7mhkbRV3p77DGJu97ovmeYjFnRqVAKBb6QEdHhQWUyPDdZxTY6Rb2l0BpysFgWTTozw7w59tqp8ls6aCDiV65ITANIPeRkUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3VvS4Uf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so11414821fa.3;
        Tue, 15 Oct 2024 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990282; x=1729595082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWOPVDT6rjztxkkkBYeqnJi9hJ5pL7jdILVFzXtkOpE=;
        b=j3VvS4UfAeqcadZZlBRa3gykwMT0vHUwV+ZGw4ihI8mMXLA32IrX0q52G56H0iH1ec
         tZyD5AMiOt7bVPUfg66tcDQhdcspfVgtshtjgEJBXYBJQWxaxdks5fv9t8WqoPpW+nFQ
         d/uQr6vTq8LOBt9V48oSwbuvMcgJcd15vqtEByebqFY47lNvP5zkxHRPOXGWBh7+Yukh
         oT3VBdvpmrMs1YNaIQIK1XzxCruhaYrlOEBwmVhb/DtGD8jFsc2qBBn8k9uB6ndvReQV
         mpPeEdU2vz9Fz5zhw/+D5dwM+Ez9AViC9FR6KK4yNpcxFD2xhuHS+LlXjihDEvE0rLEm
         n4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990282; x=1729595082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWOPVDT6rjztxkkkBYeqnJi9hJ5pL7jdILVFzXtkOpE=;
        b=VXnOw4sgZlwGsgnlFRw+PX8aKYMQytgYhFWFEskW9dI8OSH/PsJE/CUyUgdPv7vIMv
         XHNkkFEKLgOBScvBhBR0xnDvn22MwD7qnFdqLqyBjR0fiQZbTjiax9v5gVC6lsZUhy50
         Ckg225S4Z+AQV5yKq6N55VyimVKeTyoisYYWsG8B7czc4wIKUbeHtNto5vXonwcVCDCC
         6VNKAElP2bstavs0/2aiO2c2f/rVZl3AZXf5G4HyZPTBOkI6qIxRt/wRZu1XOGslSV0K
         gmhYPYn0ndtN7F6j1+A4X2kJv/UXO6ROSiFZM0W8JT2O5YwruIuMS+ekYX0VOux5NpFL
         jkDA==
X-Forwarded-Encrypted: i=1; AJvYcCUI8SSqoc+13ylPGY23G2jg2krHjUJ+1bwBd4AajYntdhjEriEyoUKCJobO4QnT0lcKC1dW0Wo9k0iGmNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESg1BSTV0iVORQKYfTT3QeY++EtVBuUnhrINLlQ84cQckM5Lt
	Et7sC9MkBYpuY7hroFV9HEECP1HkbyW411ivO6JUJanujt4rCLhMMv+MEfIiDgwUin91kSBUzO2
	VklfLlt3sQINkwU+XtjWNifB/o68=
X-Google-Smtp-Source: AGHT+IHECShA4tATBXPqyYtooksdYzBqgSf3Db+mvaXbo971SiRyVKAus92Oc8d2TyY05X7ncNh4AVpr2Hikniy6Nxs=
X-Received: by 2002:a05:651c:220e:b0:2fb:51f3:9212 with SMTP id
 38308e7fff4ca-2fb51f39559mr31642441fa.6.1728990282008; Tue, 15 Oct 2024
 04:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfs6bwdxkKPWWdNCjFH6H6hs0pFjaic12=HgB4b=Vv-xw@mail.gmail.com>
 <20241011035310.2982017-1-snovitoll@gmail.com> <CA+fCnZfznvJ-zaJg+Oeddt7OOPhnvkJ4z4N35rq5KXx2N=HBFw@mail.gmail.com>
In-Reply-To: <CA+fCnZfznvJ-zaJg+Oeddt7OOPhnvkJ4z4N35rq5KXx2N=HBFw@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 15 Oct 2024 16:05:37 +0500
Message-ID: <CACzwLxiAnGZaDMnKYU3+NKwuHVmk70OYTsBz=SZEYCV8zSn5GQ@mail.gmail.com>
Subject: Re: [PATCH v6] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: akpm@linux-foundation.org
Cc: bpf@vger.kernel.org, Andrey Konovalov <andreyknvl@gmail.com>, dvyukov@google.com, 
	elver@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:45=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Fri, Oct 11, 2024 at 5:52=E2=80=AFAM Sabyrzhan Tasbolatov
> <snovitoll@gmail.com> wrote:
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
>
> For future reference: please write commit messages in a way that is
> readable standalone. I.e. without obscured references to the
> discussions or problems in the previous versions of the patch. It's
> fine to give such references in itself, but you need to give enough
> context in the commit message to make it understandable without
> looking up those discussions.
>
> > copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> > CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> > kunit test currently fails. Need more clarification on it.
> >
> > Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1=
X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> > Reviewed-by: Marco Elver <elver@google.com>
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
> > v4:
> > - replaced Suggested-by with Reviewed-by
> > v5:
> > - addressed Andrey's comment on deleting CONFIG_KASAN_HW_TAGS check in
> >   mm/kasan/kasan_test_c.c
> > - added explanatory comment in kasan_test_c.c
> > - added Suggested-by: Marco Elver back per Andrew's comment.
> > v6:
> > - deleted checks KASAN_TAG_MIN, KASAN_TAG_KERNEL per Andrey's comment.
> > - added empty line before kfree.
> > ---
> >  mm/kasan/kasan_test_c.c | 34 ++++++++++++++++++++++++++++++++++
> >  mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
> >  mm/maccess.c            | 10 ++++++++--
> >  3 files changed, 59 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index a181e4780d9d..716f2cac9708 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -1954,6 +1954,39 @@ static void rust_uaf(struct kunit *test)
> >         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
> >  }
> >
> > +static void copy_to_kernel_nofault_oob(struct kunit *test)
> > +{
> > +       char *ptr;
> > +       char buf[128];
> > +       size_t size =3D sizeof(buf);
> > +
> > +       /* This test currently fails with the HW_TAGS mode.
> > +        * The reason is unknown and needs to be investigated. */
> > +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> > +
> > +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +       OPTIMIZER_HIDE_VAR(ptr);
> > +
> > +       /*
> > +       * We test copy_to_kernel_nofault() to detect corrupted memory t=
hat is
> > +       * being written into the kernel. In contrast, copy_from_kernel_=
nofault()
> > +       * is primarily used in kernel helper functions where the source=
 address
> > +       * might be random or uninitialized. Applying KASAN instrumentat=
ion to
> > +       * copy_from_kernel_nofault() could lead to false positives.
> > +       * By focusing KASAN checks only on copy_to_kernel_nofault(),
> > +       * we ensure that only valid memory is written to the kernel,
> > +       * minimizing the risk of kernel corruption while avoiding
> > +       * false positives in the reverse case.
> > +       */
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(&buf[0], ptr, size));
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(ptr, &buf[0], size));
> > +
> > +       kfree(ptr);
> > +}
> > +
> >  static struct kunit_case kasan_kunit_test_cases[] =3D {
> >         KUNIT_CASE(kmalloc_oob_right),
> >         KUNIT_CASE(kmalloc_oob_left),
> > @@ -2027,6 +2060,7 @@ static struct kunit_case kasan_kunit_test_cases[]=
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
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> For KASAN parts.

Andrew,

Please let me know if the last v6 is ready for -mm tree.

Previous version was removed here:
https://lore.kernel.org/mm-commits/20241010214955.DBEB7C4CEC5@smtp.kernel.o=
rg/

Hopefully, they won't conflict in mm/kasan/kasan_test_c.c per another patch=
:
https://lore.kernel.org/linux-mm/20241014025701.3096253-3-snovitoll@gmail.c=
om/

Thanks

>
> Thank you!

