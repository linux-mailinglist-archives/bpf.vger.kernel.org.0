Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A835F4352B2
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTSey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTSey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:34:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B505C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:32:39 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b9so2263967ybc.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i4y6UyDLDUiSaX1ey5DBe2SVakCZgM42B6OBIqtHH0=;
        b=ldAht1IA/DnDLII3Vwy1N8/rtivKHBciTZAsRCXmkKIAMkXMFYEbuRUKwcLns1HqL2
         TThBIanLaD1eaP6UkuKneDhveE0WPGJvUE0OHdx/y9FZBXrw05Mhz/W/3xvlcFDMMKnb
         T9859mPbzLavGVTJPPy8GTv2/evADfgEH4+f2LnuVvXT6ctf8s1s6n1IoDD5PtQ0KxBU
         QN+A8O8Znt6/S5PxAcwGAqDnUtKyrvYtb4T/NeCAAQcdr7uORhcnF85JNEbGuV0gIaUV
         FjHSP1HBKDuENYSmRPD+WTKe7R2LCUTQreZwn4kUspkjcvDjpRsiGqSREtwXpq2poDzF
         jeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i4y6UyDLDUiSaX1ey5DBe2SVakCZgM42B6OBIqtHH0=;
        b=i6zSFQuZnCGSZwfHSm7+appojB/ClDzx1X/M0UNegRXCO8po1oEkVpbmSmaEpAx997
         fJ2ztjr+33yoTsIFb0a9d87+vSIZz2xSs8nLvOwUabQomaAvumfPGemW4/vg062SKC/c
         pifOBqLV872XvNHoePdYhgPqdYyGrxVt2UnR4QZhDcv+UmcOuP/BwCaIYv8d0sMq7sne
         v0QWed0DzCVLNFSg/p3fMx6a0+IMhcx5j6yHIUPtdyEqgxPSqaf3LCh/7wgX0FMpPbZt
         HXT6ou0tToabTbKVxz+zmM2pLuVz4HBVF1jUTu5j49Mgx0NBAh4kly0Ddk/Mc492XuHl
         yqEw==
X-Gm-Message-State: AOAM533nX1sUx8YvnbVL35Npy5QKZhTHqNy8Jej2r6n+HPJ9uAfEmPOu
        R7M6WlY02h4FOHwGbtDp/QSTSMMzFxh2q1QXOVKLCYXeiMU=
X-Google-Smtp-Source: ABdhPJy1oYJzM9DUwvKrtAzAFhWNbCbY/SrQEhCEkLjgDOWthKTNrxxr0wyo3UUnWjGvt8vT9sLIlQRhmrx29ekuaWc=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr717816ybf.455.1634754758479;
 Wed, 20 Oct 2021 11:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211012023218.399568-1-iii@linux.ibm.com> <20211012023218.399568-2-iii@linux.ibm.com>
 <CAEf4BzY=npfWOSgPPEKZ9g44a5XQ_606agX840dLLCqJiDC++g@mail.gmail.com> <fd749b049550e179d0d0b789d08a102655b1a68e.camel@linux.ibm.com>
In-Reply-To: <fd749b049550e179d0d0b789d08a102655b1a68e.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 11:32:27 -0700
Message-ID: <CAEf4BzZq9kfQ_effdQMcfFJDcui_14QPTs7e_i42txiZMzHvUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Use cpu_number only on arches
 that have it
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 4:03 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2021-10-12 at 05:56 +0200, Andrii Nakryiko wrote:
> > On Tue, Oct 12, 2021 at 4:51 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > cpu_number exists only on Intel and aarch64, so skip the test
> > > involing
> > > it on other arches. An alternative would be to replace it with an
> > > exported non-ifdefed primitive-typed percpu variable from the
> > > common
> > > code, but there appears to be none.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > > b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > > index 87f9df653e4e..12f457b6786d 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > > @@ -778,8 +778,10 @@ static void test_btf_dump_struct_data(struct
> > > btf *btf, struct btf_dump *d,
> > >  static void test_btf_dump_var_data(struct btf *btf, struct
> > > btf_dump *d,
> > >                                    char *str)
> > >  {
> > > +#if defined(__i386__) || defined(__x86_64__) ||
> > > defined(__aarch64__)
> > >         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int,
> > > BTF_F_COMPACT,
> > >                           "int cpu_number = (int)100", 100);
> > > +#endif
> >
> > We are in the talks about supporting cross-compilation of selftests,
> > and this will be just another breakage that we'll have to undo.
>
> Why would this break? Cross-compilation should define these macros
> based on target, not build system.

Ok, then it should be good.

>
> > Can we find some other variable that will be available on all
> > architectures? Maybe "runqueues"?
>
> Wouldn't runqueues be pointless? We already have cpu_profile_flip. I
> thought the idea here was to have something marked with
> EXPORT_PER_CPU_SYMBOL.

No idea what the idea was, tbh.

>
> > >         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_profile_flip",
> > > int, BTF_F_COMPACT,
> > >                           "static int cpu_profile_flip = (int)2",
> > > 2);
> > >  }
> > > --
> > > 2.31.1
>
