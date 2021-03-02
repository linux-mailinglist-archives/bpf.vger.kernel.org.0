Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C463132A465
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578070AbhCBKfY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381336AbhCBFVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 00:21:03 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41DC061793
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 21:08:57 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p186so19463676ybg.2
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 21:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiqa2uk1rCVC87NmlpDfcyohmBIepsgQBQTP19VRNuE=;
        b=mA2UuqyBPww7uEpqmeeoZ1akFVWxdfAWlSTgo7pnwSIyZzpLM7HhD45HH+7UhiuJcM
         QSpTyU5zZAgB+uio69SLiT1kk4HUtpn6Ce4hNwmSbl9QP2AhKc+pOVTT0gaZwGWd4Gr/
         dCqWRFB6te/xQJB4/aXl6OWTofDEfDpi0hHsaed/U+NDkjhUjSFUWey9U2fVkAWSy8iE
         DEv8HkD/+ZOLD50qjd6Bf2NagARfccGy8iQfJvDv4RCMVaHpRUjK92wLuqbSoQEbWa5x
         pWtymXpDnrA47QqWPJtvv3oUx55RQV3x5uO+OpKorihS0bSfJ1e7rkGz7uHtahJHNyIn
         0Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiqa2uk1rCVC87NmlpDfcyohmBIepsgQBQTP19VRNuE=;
        b=UXOpXDQ/TFjMqq+/N749s3zLK7h1khN4cYiLZz+vdvh/5cvQ4O4Jyg1H28znyJZXfM
         CFoFp4hb3+wAdyolo0dsd3pbNuwQQHF2CTi5OzwmAdqByeC2LgufVs/ZiBCCkl7y8nZ8
         wXNxSvmdskJvnWXLfXQy3HcyJ9NFCC+S1X4Z4AyKIUdA2mOD9793l53cVTUzEHxjnweC
         Tjn4MZ5y5phlzV+c56qExSrdDxp16Q2E4gLVoAt1XRFo8AuoZpU+hTjmGUZ0sHH/hQ+K
         DxmntUmxPt9AYrzGNBV4MsZWWNuG8SCBjmShoRnHyHhMbf+Cmos49ct6Z7YxIIRryLpz
         gyVw==
X-Gm-Message-State: AOAM532SrGbVlOrXBYkghf/MTHh6Doo5OFVirV/firgJ40kicEyrm4Dh
        vKyJERPOs010Hnk3CQhQ5nj/xHt53YWeBYyuRWzpdg4cR6M=
X-Google-Smtp-Source: ABdhPJyuejvvH4huvo1vqdiLRsb3w1Jxn3IhJ8W5N0Pss1HRXuxD6Ha+J3MhH/Cav4sECBRuYElevwYg0KaD//CIVbY=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr28399746ybf.260.1614661736454;
 Mon, 01 Mar 2021 21:08:56 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
 <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com> <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
 <3a6d2ee3-4ce0-0f8b-2ab4-dad77e6da42e@fb.com> <ffbd1904-ac22-7922-201d-a971c685d761@fb.com>
In-Reply-To: <ffbd1904-ac22-7922-201d-a971c685d761@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Mar 2021 21:08:45 -0800
Message-ID: <CAEf4BzZ2LXc=5zT45VKgwbvc6VQ0XUU+J7_hKmqPaURKtYeJBQ@mail.gmail.com>
Subject: Re: Enum relocations against zero values
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 1, 2021 at 8:19 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/26/21 7:31 PM, Yonghong Song wrote:
> >
> >
> > On 2/26/21 12:43 PM, Andrii Nakryiko wrote:
> >> On Fri, Feb 26, 2021 at 10:08 AM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/26/21 9:47 AM, Lorenz Bauer wrote:
> >>>> Hi Andrii and Yonghong,
> >>>>
> >>>> I'm playing around with enum CO-RE relocations, and hit the
> >>>> following snag:
> >>>>
> >>>>       enum e { TWO };
> >>>>       bpf_core_enum_value_exists(enum e, TWO);
> >>>>
> >>>> Compiling this with clang-12
> >>>> (12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
> >>>> me the following:
> >>>>
> >>>> internal/btf/testdata/relocs.c:66:2: error:
> >>>> __builtin_preserve_enum_value argument 1 invalid
> >>>>           enum_value_exists(enum e, TWO);
> >>>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>> internal/btf/testdata/relocs.c:53:8: note: expanded from macro
> >>>> 'enum_value_exists'
> >>>>                   if (!bpf_core_enum_value_exists(t, v)) { \
> >>>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>> internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
> >>>> macro 'bpf_core_enum_value_exists'
> >>>>           __builtin_preserve_enum_value(*(typeof(enum_type)
> >>>> *)enum_value, BPF_ENUMVAL_EXISTS)
> >>>>
> >>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>
> >>> Andrii can comment on MACRO failures.
> >>
> >> Yeah, I ran into this a long time ago as well...
> >>
> >> I don't actually know why this doesn't work for zeroes. I've tried to
> >> write that macro in a bit different way, but Clang rejects it:
> >>
> >> __builtin_preserve_enum_value(({typeof(enum_type) ___xxx =
> >> (enum_value); *(typeof(enum_type)*)&___xxx;}), BPF_ENUMVAL_EXISTS)
> >>
> >> And something as straightforward as
> >>
> >> __builtin_preserve_enum_value((typeof(enum_type))(enum_value),
> >> BPF_ENUMVAL_EXISTS)
> >>
> >> doesn't work as well.
> >>
> >> Yonghong, any idea how to write such a macro to work in all cases? Or
> >> why those alternatives don't work? I only get " error:
> >> __builtin_preserve_enum_value argument 1 invalid" with no more
> >> details, so hard to do anything about this.
> >
> > This is a clang BPF bug. In certain number classification system,
> > clang considers 0 as NULL and non-0 as INTEGER. I only checked
> > INTEGER and hence only non-0 works. All my tests has non-zero
> > enum values :-(
> >
> > Will fix the issue soon. Thanks for reporting!
>
> Just pushed the fix (https://reviews.llvm.org/D97659) to llvm trunk
> this morning. Also filed a request
> (https://bugs.llvm.org/show_bug.cgi?id=49391) to backport the fix to
> 12.0.1 release.
> it is too late to be included in 12.0.0 release.
> Thanks!
>

Thanks, Yonghong!

> >
> >>
> >>
> >>>
> >>>>
> >>>> Changing the definition of the enum to
> >>>>
> >>>>       enum e { TWO = 1 }
> >>>>
> >>>> compiles successfully. I get the same result for any enum value that
> >>>> is zero. Is this expected?
> >>>
> >>> IIRC, libbpf will try to do relocation against vmlinux BTF.
> >>> So here, "enum e" probably does not exist in vmlinux BTF, so
> >>> the builtin will return 0. You can try some enum type
> >>> existing in vmlinux BTF to see what happens.
> >>>
> >>>>
> >>>> Best
> >>>> Lorenz
> >>>>
