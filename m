Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8F52C83C
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 01:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiERX4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiERX4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 19:56:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE658A206F
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 16:56:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f4so4157678iov.2
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTVp0omBsMURoaHte8QkIXwAGpc4ue46lcRcjhB3O+w=;
        b=mgdcBupvj4w4ixBZ7xWci8Ics4l9l2vyBnk0LeoYPOok3t2ePfsB703cqSOiMx2zS0
         lE/2pVeC3JC1djR+Cul3zbvmykzeYkkpoo3B77mMd4sCcLV1n286pphLjipMzmZPPwEo
         jwJp3laRsJ7kO5GWiCchWlt1VSq+8IXiLIEaky7wPZC8QPEr3+pdYUW8ZB99mKmqThWT
         5SWMiZc6QocS1/xAGK3gVR6kiZum62dSxF6GpSUVya/TDKs3kRrpBwfhI0rQ/cwyQzfY
         X00fT2vLo2h+lev2ofxcsQ/X2owBGLErvPmuATrRUiUFahoheP5P0ZyvBjS3HpdkGBXp
         dsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTVp0omBsMURoaHte8QkIXwAGpc4ue46lcRcjhB3O+w=;
        b=TGgV4ZVfde5pkzu+U34CYBQor8YS9kLcsnS9DfARNik2Ecl6ufrdKE3SMRRh3x2Zes
         8+CzKGepVbUaNMqEjHTunbLBkRBV7L1zkOWlEbyMfV3q227YqYKknFgO3R/APFHj1tbN
         o8a2ojWN/ZWPOW9EGUzOoTX26eKX+HqYMC0p9aH7763UrxnwmQ//QZ4iq+tZiK3/sYEY
         XD77fAq/00J1hpJYOlFpuW3SJD6RQOZdlwhmzHgy+ERZ/4d0zKXCvRxjAMlu377M/udg
         vU/QJCm54HS1IRRXpTDpnx1Rpbd5EK9fkfAyrcUScLRTG5Q+C6uFurgY0FUCoPWJwMGG
         sdlw==
X-Gm-Message-State: AOAM5324bD4ALQ95EffqbgGfNMcu+37c4XVNuFRD1h2+rLiGUrpkbzyh
        1sFAJw7jM7gGpBV7+Zvy0bYcl5lJeaYgGqcOmzI=
X-Google-Smtp-Source: ABdhPJxB/bSWYZXNS4h6N+kevhWnjs7tgyGODgMBYVUkK8lZDagLSHdl+btaJmLfRh8TkMFplQ3XkSukPpeakGHnwj0=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr1049993ioo.112.1652918192265; Wed, 18
 May 2022 16:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-5-davemarchevsky@fb.com> <CAEf4BzYj2i4shfAFW4fUKaEDFQvkMtyirVpq8_5AQAX0pW36yQ@mail.gmail.com>
 <20220517011752.or6r4k5qwcc3kgy3@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220517011752.or6r4k5qwcc3kgy3@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 May 2022 16:56:21 -0700
Message-ID: <CAEf4Bza6yPAqE58Xt+_C6XZ2acC-Dfg7dFfU8U6X-4rY01Ji3Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/5] selftests/bpf: Add test for USDT parse
 of xmm reg
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 6:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 16, 2022 at 04:31:55PM -0700, Andrii Nakryiko wrote:
> > On Thu, May 12, 2022 at 12:43 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > Validate that bpf_get_reg_val helper solves the motivating problem of
> > > this patch series: USDT args passed through xmm regs. The userspace
> > > portion of the test forces STAP_PROBE macro to use %xmm0 and %xmm1 regs
> > > to pass a float and an int, which the bpf-side successfully reads using
> > > BPF_USDT.
> > >
> > > In the wild I discovered a sanely-configured USDT in Fedora libpthread
> > > using xmm regs to pass scalar values, likely due to register pressure.
> > > urandom_read_lib_xmm mimics this by using -ffixed-$REG flag to mark
> > > r11-r14 unusable and passing many USDT args.
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile          |  8 ++-
> > >  tools/testing/selftests/bpf/prog_tests/usdt.c |  7 +++
> > >  .../selftests/bpf/progs/test_urandom_usdt.c   | 13 ++++
> > >  tools/testing/selftests/bpf/urandom_read.c    |  3 +
> > >  .../selftests/bpf/urandom_read_lib_xmm.c      | 62 +++++++++++++++++++
> > >  5 files changed, 91 insertions(+), 2 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/urandom_read_lib_xmm.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 6bbc03161544..19246e34dfe1 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -172,10 +172,14 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
> > >         $(call msg,LIB,,$@)
> > >         $(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
> > >
> > > -$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
> > > +$(OUTPUT)/liburandom_read_xmm.so: urandom_read_lib_xmm.c
> > > +       $(call msg,LIB,,$@)
> > > +       $(Q)$(CC) -O0 -ffixed-r11 -ffixed-r12 -ffixed-r13 -ffixed-r14 -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
> >
> > this looks very x86-specific, but we support other architectures as well
> >
> > looking at sdt.h, it seems like STAP_PROBEx() macros support being
> > called from assembly code, I wonder if it would be better to try to
> > figure out how to use it from assembly and use some xmm register
> > directly in inline assembly? I have never done that before, but am
> > hopeful :)
>
> stap_probe in asm won't help cross arch issue.
> It's better to stay with C.
> Maybe some makefile magic can make the above x86 only?
> The test should be skipped on other archs anyway.

It seems easier (or rather cleaner) to maintain arch-specific pieces
within .c file through #if __x86_64__ instead of doing equivalent
changes to Makefile. Suggestion for using assembly was due to needing
to make sure xmmX register is used and desired to avoid maintaining
arch-specific compile-time flags like -ffixed-r11. But truth be told I
have zero idea how STAP_PROBE() use from assembly would look like, so
just a suggestion to consider.
