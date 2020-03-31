Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCA199F6C
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCaTuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 15:50:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41435 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCaTuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 15:50:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id q188so24438594qke.8
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5+qKLQ1f4NqUqvhqrfke6cOCk10NSdeFo7t2OCsew8=;
        b=CMfKSpfoJV/1XPTFCLmfA6IVfkYQO8d03ChIgA6G5K9uJ+Dt3sOIpoIqUlgv24jKYI
         dVs1Rea5ot/663JHeeGdiAJgIieYtep+k0d56O36iC5BOZ0gw2ls9THUtf0jc72nxMus
         mRxyXXTPK905JkamOGghpPhn3gNSNHvi1KAtWZgckgKWRt40U0/xSxnPZ3PtEaD0Jd6f
         VwMTkv+gis5tw5wWBE6aZlVsvqRpGPzk2QXMyTkkBgVrN9vjHu7zbS/zODZI7gJBdy2g
         Dtxh7RyABKfNMFA0HbbSWR68XR8OXpc6MU0OkqZ2K/cXh0CtZfCtUKvbAqd9mRbnsgYY
         aq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5+qKLQ1f4NqUqvhqrfke6cOCk10NSdeFo7t2OCsew8=;
        b=shzFiwucvwVKKkbsjpur7T3LtUfqHyS3+m9IMuD9asQMpYw6TDBz/SpBNaCwptqGvx
         l5Q7WGsxgH7DZuZIfWaEKye/lIs6cR5VvDoOBPt0yVQU+omwB4lsyMJFE1+xRmwjhogn
         pnWm0U646mLQesk/AEPLb0yU+g3ePRb6Bw8uLMFSmVs+MHGtFJ1/dZs7PGwaQbhjEslb
         itOzFdWhMpdXsG1X463CWzPBv3vACHm1iGvKR56ESjWrypx0XlNWtQ8+ljUXwRlQkHyz
         ZeLz/1Ga/PbsetKwSccZnspljzlJDWH5AbLwP0h2LSv1TwS5wEnPWqPVKr637LM83ap/
         rPLA==
X-Gm-Message-State: ANhLgQ2VIWDVQbHbGvMwqql+/lLGLNlPXNiGUYP0/hYrwUuOJwQkqnuz
        RdaLzAOA5rzPovlYknVMJHXSnbxSIxvJsdsZUqA=
X-Google-Smtp-Source: ADFU+vsNIICmh4UU/HbDsexWPCQXWoxpUmRkqKNeRLTkqhCMElndmAYdLEyHsPlFNZnb+FTSqvH7XgLIP5OruxPWt8I=
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr6969392qka.449.1585684218869;
 Tue, 31 Mar 2020 12:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook> <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
 <202003311110.2B08091E@keescook>
In-Reply-To: <202003311110.2B08091E@keescook>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Mar 2020 12:50:07 -0700
Message-ID: <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 11:12 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Mar 31, 2020 at 12:41:04AM +0200, Daniel Borkmann wrote:
> > On 3/30/20 7:20 PM, Kees Cook wrote:
> > > On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
> > > > On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> > > > > >
> > > > > > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > > > > > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
> > > > >
> > > > > Is it a theoretical stmt or you have data?
> > > > > I think it's the other way around.
> > > > > gcc-plugin breaks dwarf and breaks btf.
> > > > > But I only looked at gcc patches without applying them.
> > > >
> > > > Ah, interesting - I haven't actually tested it, I just assumed
> > > > (perhaps incorrectly) that the GCC plugin would deal with DWARF info
> > > > properly.
> > >
> > > Yeah, GCC appears to create DWARF before the plugin does the
> > > randomization[1], so it's not an exposure, but yes, struct randomization
> > > is pretty completely incompatible with a bunch of things in the kernel
> > > (by design). I'm happy to add negative "depends" in the Kconfig if it
> > > helps clarify anything.
> >
> > Is this expected to get fixed at some point wrt DWARF? Perhaps would make
>
> No, gcc closed the issue as "won't fix".
>
> > sense then to add a negative "depends" for both DWARF and BTF if the option
> > GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.
>
> I hadn't just to keep wider randconfig build test coverage. That said, I
> could make it be: depends COMPILE_TEST || !DWARF ...
>
> I can certainly do that.

I've asked Slava in [0] to disable all three known configs that break
DWARF and subsequently BTF, I hope it's ok to just do it in one patch.
Currently all these appear to result in invalid BTF due to various
DWARF modifications:

  - DEBUG_INFO_REDUCED (see [1])
  - DEBUG_INFO_SPLIT (see [0]
  - GCC_PLUGIN_RANDSTRUCT (this discussion).

  [0] https://lore.kernel.org/bpf/CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com/
  [1] https://lore.kernel.org/bpf/CAEf4BzZri8KpwLcoPgjiVx_=QmJ2W9UzBkDqSO2rUWMzWogkKg@mail.gmail.com/


>
> -Kees
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052
>
> --
> Kees Cook
