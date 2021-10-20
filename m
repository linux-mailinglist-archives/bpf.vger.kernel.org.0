Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF53435587
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJTVvr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTVvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382AAC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:49:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d125so26490192iof.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tylk8tUmUJnElPrslojZ0e+cU+uTCFyZHlXCDChVYpM=;
        b=VTrEo03PIDtWi3QB/bmWNdIvhmxTEbajVqPOPSNHtOvV1d3mLnR+iBtczF4g5i957w
         S4QkqOhFJ9BN6tPcldYwWT6nQ/wtBttfnO4E7s6c+En68uaS1zmzn/wgwaufp3TQZnP1
         N07e+nDNzWdA40gYxJBjWDO5O2Ns3TL2esF4hnxcZrrp2J5Qq8Hhc+/iMm3GsHH4tJqx
         mIDjFNnQYgDXkfgb0mgrCv39d0PgwyNFBTpepBs1bzyzs6FTS2UNMLfNSIkO3JuwWXQG
         3+gL7SYWawec2eQFfkUUzEY0R2D3NQ16rLxXjbIEX4A8nrjBOYA3Bs7ANuYykfsuOY/c
         4jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tylk8tUmUJnElPrslojZ0e+cU+uTCFyZHlXCDChVYpM=;
        b=4g29gklI7CkXEPottQMhS74cEccWzdIn+nLSdiLbAkNpj3ktlpe+xaQbkXguHoq4GK
         Y7b94X+/O3xnR0rhYKHjjTyd4Ul7FtfiOMpD19frCwIu/b5lYsKQGV9MUpq4C+8rb4SH
         swNhxChkoNt31LjezPSj+x6WkgdpcN2h9P2LHvX234yQBhMEd8GpoeSnX966LmaTpgj+
         q9FxAK1Op+dFaH9bSooRhjIURMl8ahvUlr69Olk6JzVV8bOqm4D8NKeCnbbdgvgL1R0+
         rIAXvApNE9VWTxVMSdpmzMoHZfXfcZVuA7y+f5xwqdPrOQwPWkRHmru7OTG7v5KlHbhv
         vsCA==
X-Gm-Message-State: AOAM531Q9DPoJ39E6ytEGsaf3wWJ+Na8B4MUA/Tmd6oWP1ZE5Y93sQm8
        e+/blHg3Zj54xX0wSjhS1wMC5jIxJDJt8wnslZJCQg==
X-Google-Smtp-Source: ABdhPJykiDhO3eOHiSYPgpgGGbYix5dwnXqoijLEOvjlqndH5s+50doaD3IpQPfi763HWJlOZV+yx6PRHtLA1epblYw=
X-Received: by 2002:a05:6638:293:: with SMTP id c19mr1236363jaq.21.1634766571415;
 Wed, 20 Oct 2021 14:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212049.1010192-1-irogers@google.com> <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
 <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com> <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
In-Reply-To: <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Oct 2021 14:49:17 -0700
Message-ID: <CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 2:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 20, 2021 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 2:12 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> > > > the code requiring it conditionally compiled in.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  btf_encoder.c | 7 +++++++
> > > >  lib/bpf       | 2 +-
> > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > index c341f95..400d64b 100644
> > > > --- a/btf_encoder.c
> > > > +++ b/btf_encoder.c
> > > > @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> > > >         [BTF_KIND_VAR]          = "VAR",
> > > >         [BTF_KIND_DATASEC]      = "DATASEC",
> > > >         [BTF_KIND_FLOAT]        = "FLOAT",
> > > > +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
> > > >         [BTF_KIND_TAG]          = "TAG",
> > > > +#endif
> > > >  };
> > > >
> > > >  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> > > > @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
> > > >  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
> > > >                                     int component_idx)
> > > >  {
> > > > +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
> > >
> > > How will this work when libbpf is loaded dynamically? I believe pahole
> > > has this mode as well.
> >
> > Well it won't have a compilation error because BTF_KIND_TAG isn't
>
> Great, you traded compile-time error for runtime linking error, I hope
> that trade off makes sense to Arnaldo.
>
> > undefined :-) Tbh, I'm not sure but it seems that you'd be limited to
> > features in the version of libbpf you compiled against.
>
> I've been consistently advocating for statically linking against
> libbpf exactly to control what APIs and features are supported. But
> people stubbornly want dynamic linking. I hope added complexity and
> feature detection makes sense in practice for pahole.
>
> >
> > > Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
> > > LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
> > > guessing the version
> >
> > This was moved to a header file in:
> > https://lore.kernel.org/bpf/CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com/T/
> >
> > But that header doesn't appear any more:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf
> >
> > Is that a bug?
>
> You should be checking here:
>
> https://github.com/libbpf/libbpf/blob/master/src/libbpf_version.h

We don't currently mirror this or bpf-next, but presumably the
released version of libbpf is that in the Linus' tree [1]? There are
some things like traceevent that are planned for removal. It seems
like a bug that these trees are missing libbpf_version.h.

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf
> >
> > Thanks,
> > Ian
> >
> > > >         struct btf *btf = encoder->btf;
> > > >         const struct btf_type *t;
> > > >         int32_t id;
> > > > @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
> > > >         }
> > > >
> > > >         return id;
> > > > +#else
> > > > +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> > > > +        return -ENOTSUP;
> > > > +#endif
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/lib/bpf b/lib/bpf
> > > > index 980777c..986962f 160000
> > > > --- a/lib/bpf
> > > > +++ b/lib/bpf
> > > > @@ -1 +1 @@
> > > > -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> > > > +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> > > > --
> > > > 2.33.0.1079.g6e70778dc9-goog
> > > >
