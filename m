Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C503ACCFD
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhFRODX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFRODW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 10:03:22 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93ACC061574;
        Fri, 18 Jun 2021 07:01:11 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 68so4982934vsu.6;
        Fri, 18 Jun 2021 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cvh75hY019BX7uc+RL+q/CXawViVX/LTbPoN9FGziiU=;
        b=TPLqjgPX8zTppClsQrKq5bIUE8xSKDkvXMOs4lwm9LIrccUkW9YUHsAJI+/8S7cayg
         849czcxIu9SS+BMEkaB/5jJ0clO5nhJFv6P9UZE9MaPZfVxZiykTwQV2MvDJct/3YyT6
         8vTbeml8S7jW8wrSFTUZO2ucTROh3al+/z5UejSXeAh//gSBu0fLEaQs92kWYlHAjKJW
         yFmKKjq3XNDaMe4NXMTbsSuwHcek9JX3JsBd+wxdiOO6ywk0SeZxo19dmQj7RTpk7Kb9
         gbAVEEXW5YsqX70dHMO8NXz0+jIATjGUSi2gdQ185aeH5Hg+bCKItFmh6w7juqTFqHUt
         V1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cvh75hY019BX7uc+RL+q/CXawViVX/LTbPoN9FGziiU=;
        b=bI9UYDdH/qxaQDgA54zIX6nFjNWemlJm9K9x9DEFkO9Krnx+6wcJg6N9x/+5n25nV0
         qUxk6zKeCG/eu0mN/JB2JwbkznKEvLG63CPU66/MfnHISE1guc5A6/n35T7gB2D0caq+
         fg1JMFbn2/cqfZ5x85CBgG2YWcLvMGFVJJKT9HdE2BBcVpPDqt/jg5Pi6rqTUaaED3sl
         f2GgAseZihO9cLWDHYTJ+t17o4ktnfmC2/3OOtWePFvCzq7vukEszyBUADYi+fMkEHaD
         Jchap/hAOXIsHRZ0jtLopmgK9uMtCQvDNtK3Y8NLfxK6wjInZj5ZC48PAqgsUUSav4Vd
         E6rA==
X-Gm-Message-State: AOAM533DOxakoh3emaogeGkwDmwmY8YTCffUJhueNVaFFEMxGCNcgXcY
        4XhETZoXKVaO171BYsgyeyu66gfJkNNQ2wm+iPY=
X-Google-Smtp-Source: ABdhPJyP/wfyi3OjQdOB27bjaAtzuwv0aKxCsuMKO/D6Ptea0UfTWxI2NV18ffpeB7Q/ieRYFZOch8zdVZCVOESNBVE=
X-Received: by 2002:a05:6102:358b:: with SMTP id h11mr7143898vsu.6.1624024871034;
 Fri, 18 Jun 2021 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182023.8137-1-grantseltzer@gmail.com> <20210617182023.8137-2-grantseltzer@gmail.com>
 <CAEf4Bzar3CVJCkKHo5RKcCXLAwEVW5y_JUTo7_cVuBOwjRaiJg@mail.gmail.com>
In-Reply-To: <CAEf4Bzar3CVJCkKHo5RKcCXLAwEVW5y_JUTo7_cVuBOwjRaiJg@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 18 Jun 2021 10:00:59 -0400
Message-ID: <CAO658oXL0++2gHc=E0i5YinHkmRJgFzq05+DxRkRrJ3ku1Ufow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] Add documentation for libbpf including
 API autogen
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 4:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 17, 2021 at 11:20 AM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > This adds rst files containing documentation for libbpf. This includes
> > the addition of libbpf_api.rst which pulls comment documentation from
> > header files in libbpf under tools/lib/bpf/. The comment docs would be
> > of the standard kernel doc format.
> >
> > Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> > ---
> >  Documentation/bpf/index.rst                   | 13 +++++++
> >  Documentation/bpf/libbpf.rst                  | 14 +++++++
> >  Documentation/bpf/libbpf_api.rst              | 27 ++++++++++++++
> >  Documentation/bpf/libbpf_build.rst            | 37 +++++++++++++++++++
>
> Didn't we agree to have docs under Documentation/bpf/libbpf? That
> should make it clear that each is libbpf-specific and probably would
> make copying/syncing easier. Plus it will be a libbpf sub-section in
> the docs, no?

Ah sure, that works.

>
> >  .../bpf/libbpf_naming_convention.rst          | 32 +++++++---------
> >  5 files changed, 104 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/bpf/libbpf.rst
> >  create mode 100644 Documentation/bpf/libbpf_api.rst
> >  create mode 100644 Documentation/bpf/libbpf_build.rst
> >  rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf_naming_convention.rst (89%)
> >
> > diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> > index a702f67dd..44f646735 100644
> > --- a/Documentation/bpf/index.rst
> > +++ b/Documentation/bpf/index.rst
> > @@ -12,6 +12,19 @@ BPF instruction-set.
> >  The Cilium project also maintains a `BPF and XDP Reference Guide`_
> >  that goes into great technical depth about the BPF Architecture.
> >
> > +libbpf
> > +======
> > +
> > +Libbpf is a userspace library for loading and interacting with bpf programs.
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   libbpf
> > +   libbpf_api
> > +   libbpf_build
> > +   libbpf_naming_convention
> > +
> >  BPF Type Format (BTF)
> >  =====================
> >
> > diff --git a/Documentation/bpf/libbpf.rst b/Documentation/bpf/libbpf.rst
> > new file mode 100644
> > index 000000000..2e62cadee
> > --- /dev/null
> > +++ b/Documentation/bpf/libbpf.rst
> > @@ -0,0 +1,14 @@
> > +.. SPDX-License-Identifier: GPL-2.0
>
> Should we use dual-license LGPL-2.1 OR BSD-2-Clause like the rest of libbpf?
>
> > +
> > +libbpf
> > +======
> > +
> > +This is documentation for libbpf, a userspace library for loading and
> > +interacting with bpf programs.
> > +
>
> [...]
>
> > +    $ cd src
> > +    $ PKG_CONFIG_PATH=/build/root/lib64/pkgconfig DESTDIR=/build/root make
> > \ No newline at end of file
> > diff --git a/tools/lib/bpf/README.rst b/Documentation/bpf/libbpf_naming_convention.rst
> > similarity index 89%
> > rename from tools/lib/bpf/README.rst
> > rename to Documentation/bpf/libbpf_naming_convention.rst
> > index 8928f7787..b6dc5c592 100644
> > --- a/tools/lib/bpf/README.rst
> > +++ b/Documentation/bpf/libbpf_naming_convention.rst
> > @@ -1,7 +1,7 @@
> > -.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +.. SPDX-License-Identifier: GPL-2.0
>
> I don't think we can just easily re-license without asking original
> contributor. But see above, I think we should stick to the
> dual-license to stay consistent with libbpf sources?

This change was not at all intentional. I'll change it back to the
dual license.
>
>
> [...]
