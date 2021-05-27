Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638AC393744
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhE0UnJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbhE0UnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 16:43:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79905C061574;
        Thu, 27 May 2021 13:41:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z38so2519738ybh.5;
        Thu, 27 May 2021 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkEtI6YOTA2WONcr1yd7qWLnvbieG6wKJihibGed1L0=;
        b=Q+T45K99SioxovAruV5kTFQKM4hgG3/cUY9XMy9hhfq2r+IMaC9C9u/KDZvMoqewrE
         DOOwdSJVLItVmNczJ5u0WYBhIyPeulfySF1Ty+K+QAzbtVVB+LH5mvRsjuSCe7xjXVeD
         bzquGr/ht7pbOnKr7gyzhebPosPWYSUJsIwe57naupg8BIchiNQ+iQb4AyTTW2lIcXNy
         XKKYQqMCdN7WSUeSWypDM14hbTfPdaL59yNkT398kjTgsl8DHPYIslcR0kMCpEyDtZuH
         kW087hANGqmdy1ZsACbWrWlPGfA7g2yGpcXz7QClS+hzXHPhjEeR8tRJBt6DqK1DjdQA
         9lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkEtI6YOTA2WONcr1yd7qWLnvbieG6wKJihibGed1L0=;
        b=iAGmu5WSwqxRvy6fzbkzpstFF2vBwvpfGTWzGVoknRVXJhS3pkkF49XA5C0BRqXhmD
         JEJPC5g/eVZsU/JYhxHVwIxu2rr37usFw0mGyddPRW4EW/tusHCqOggFMw6h2bsTLmeh
         Bq5r5LqV4q7WB0YKq9BFLekKtrQhiZc593/BVtzG3LR3iXFimJ6ufjtcZXfsC+mR/Byf
         r2M6jRO0iMMHVtWfpmm9c+z2HP4MdjRn5DQahWZATJLqr7OUwShI16AZlO2q6qnf2owA
         C8l4lj35oclz868xhT7tUOW8MzsFQmlqgEjQu3D+8OoFK5sWk9z0mGwPscBWer5kzrn2
         Zsbg==
X-Gm-Message-State: AOAM532NwkOlf83ey5BnXg8SokdKEneHWWqTL7tE4LUE/HnF0cbY2EqD
        kB3xR8OMV3b1+AgKw3FEBRBBdzKCf8KqZ3FndMCeGKbeJY8=
X-Google-Smtp-Source: ABdhPJzY4NmTn+00ot/krOIV9qieX5mbliWUUm7Y9mMtyeKUenL5cxayspybgPnGn2YN1CVbB8iYmUsPsOgv1BWL5pA=
X-Received: by 2002:a5b:286:: with SMTP id x6mr7992123ybl.347.1622148084588;
 Thu, 27 May 2021 13:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
In-Reply-To: <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 13:41:13 -0700
Message-ID: <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
Subject: Re: [RFT] Testing 1.22
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
>
>
>
> On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Thu, May 27, 2021 at 12:06 PM Arnaldo <arnaldo.melo@gmail.com>
> >wrote:
> >>
> >>
> >>
> >> On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko
> ><andrii.nakryiko@gmail.com> wrote:
> >> >On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
> >> ><acme@kernel.org> wrote:
> >> >>
> >> >> Hi guys,
> >> >>
> >> >>         Its important to have 1.22 out of the door ASAP, so please
> >> >clone
> >> >> what is in tmp.master and report your results.
> >> >>
> >> >
> >> >Hey Arnaldo,
> >> >
> >> >If we are going to make pahole 1.22 a new mandatory minimal version
> >of
> >> >pahole, I think we should take a little bit of time and fix another
> >> >problematic issue and clean up Kbuild significantly.
> >> >
> >> >We discussed this before, it would be great to have an ability to
> >dump
> >> >generated BTF into a separate file instead of modifying vmlinux
> >image
> >> >in place. I'd say let's try to push for [0] to land as a temporary
> >> >work around to buy us a bit of time to implement this feature. Then,
> >> >when pahole 1.22 is released and packaged into major distros, we can
> >> >follow up in kernel with Kbuild clean ups and making pahole 1.22
> >> >mandatory.
> >> >
> >> >What do you think? If anyone agrees, please consider chiming in on
> >the
> >> >above thread ([0]).
> >>
> >> There's multiple fixes that affects lots of stakeholders, so I'm more
> >inclined to release 1.22 sooner rather than later.
> >>
> >> If anyone has cycles right now to work on that detached BTF feature,
> >releasing 1.23 as soon as that feature is complete and tested shouldn't
> >be a problem.
> >>
> >> Then 1.23 the mandatory minimal version.
> >>
> >> Wdyt?
> >
> >If we make 1.22 mandatory there will be no good reason to make 1.23
> >mandatory again. So I will have absolutely no inclination to work on
> >this, for example. So we are just wasting a chance to clean up the
> >Kbuild story w.r.t. pahole. And we are talking about just a few days
> >at most, while we do have a reasonable work around on the kernel side.
>
> So there were patches for stop using objcopy, which we thought could uncover some can of worms, were there patches for the detached BTF  file?

No, there weren't, if I remember correctly. What's the concern,
though? That detached BTF file isn't even an ELF, so it's
btf__get_raw_data() and write it to the file. Done.

>
> - Arnaldo
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
