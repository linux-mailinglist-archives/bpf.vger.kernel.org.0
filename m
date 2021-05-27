Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E647393618
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhE0TQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhE0TQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 15:16:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA95C061760;
        Thu, 27 May 2021 12:14:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z38so2190989ybh.5;
        Thu, 27 May 2021 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqwtG9DwrNsWzQ+m2JG6f4/HKjZ8kIxl7aJbYVE3wtU=;
        b=X0I/9ngA6iD8aUthP9I342CHyWTol1SfiKA+u2McGF78tEuR+kTgsS3nv5fzcKATxo
         Vm7w5OzJbWxfQuRE4z1OBCl+Mqqc+jRdM8msmrfVznWAZtBY2TjeHByt5ZpowH6NIgAa
         jLUFGnJeF4U4O96n4jlr1F8m0hLenTczLra+b4C3jaQytseaMSOdwyqRS2KleEBYrrNn
         pCWZ0f9EQg04sujNKTfsZ54hLtiHg6yYPeo5v7pryaoSZEeDNTgtdZX4Bp4dY74gHn8M
         ShHzFCaNNytLG6Dw4NEFi0JCDCGINsGz5iHkcvhMXA9zdLU/onPHspXS3+5ubhHA7sWO
         S6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqwtG9DwrNsWzQ+m2JG6f4/HKjZ8kIxl7aJbYVE3wtU=;
        b=VrWL7GTHiN8WwHJq3tgcGhFMPg7pkLCV/0nijcaSKGEtQUHgBDuwbzD/Q2CKE2FW7e
         MF/1sf8/ArGjk+z0KlNZ4upE4eT51REwvWeJmTgOutm8anX9NI7uXof0saAwA3DrqYvU
         tC1pMpG2SYtE+XINWm/mBqXS/81x8Fx6SD0Sx5KYKrGCA9jJLl9eWBqq6+rbDAzshELO
         v/BPFFfOYyJgfycAcenggBGInw6uZiAPyXYxA7hAz0J5cB4JxbzDks5KRWyQR/WtMay/
         v3UsoVXE5/k2O7ip+Z3Hi0ih5MflXEPHtBkvjAdxCSfeRPnHBWpSv9DGjP+l6PbtLi2a
         II0w==
X-Gm-Message-State: AOAM532gf+rCZmE/d4lqtkXrLHFXc+UUxgWwBWkpAVBlSt9XTe+pXx03
        zKvcTMdkioxfHPIn2sRIJlHpDo5jOmTuCgrJh5Y=
X-Google-Smtp-Source: ABdhPJy5CTTcnhXuT9Up53uE/F8URT0PEyTg26tULMj7wfKAbN50peN+KlPWmZ+nPQcr2K4D/vBV2DJGpFcnD46S2to=
X-Received: by 2002:a25:7246:: with SMTP id n67mr7165587ybc.510.1622142868597;
 Thu, 27 May 2021 12:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
In-Reply-To: <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 12:14:17 -0700
Message-ID: <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
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

On Thu, May 27, 2021 at 12:06 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
>
>
>
> On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> Hi guys,
> >>
> >>         Its important to have 1.22 out of the door ASAP, so please
> >clone
> >> what is in tmp.master and report your results.
> >>
> >
> >Hey Arnaldo,
> >
> >If we are going to make pahole 1.22 a new mandatory minimal version of
> >pahole, I think we should take a little bit of time and fix another
> >problematic issue and clean up Kbuild significantly.
> >
> >We discussed this before, it would be great to have an ability to dump
> >generated BTF into a separate file instead of modifying vmlinux image
> >in place. I'd say let's try to push for [0] to land as a temporary
> >work around to buy us a bit of time to implement this feature. Then,
> >when pahole 1.22 is released and packaged into major distros, we can
> >follow up in kernel with Kbuild clean ups and making pahole 1.22
> >mandatory.
> >
> >What do you think? If anyone agrees, please consider chiming in on the
> >above thread ([0]).
>
> There's multiple fixes that affects lots of stakeholders, so I'm more inclined to release 1.22 sooner rather than later.
>
> If anyone has cycles right now to work on that detached BTF feature, releasing 1.23 as soon as that feature is complete and tested shouldn't be a problem.
>
> Then 1.23 the mandatory minimal version.
>
> Wdyt?

If we make 1.22 mandatory there will be no good reason to make 1.23
mandatory again. So I will have absolutely no inclination to work on
this, for example. So we are just wasting a chance to clean up the
Kbuild story w.r.t. pahole. And we are talking about just a few days
at most, while we do have a reasonable work around on the kernel side.

>
> - Arnaldo
>
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
