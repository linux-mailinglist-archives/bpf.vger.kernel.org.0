Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D209F435542
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTVaE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 17:30:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F72C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:27:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g6so17787820ybb.3
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trJ5qupIUuTA08iG4ykhqnQTpYLgxUEzEcK4z9AeclQ=;
        b=jlyY2QRXKH6ywnnO9s/7pYCrquvkqv4MC6AqloQY5UU1WsMAhC9g9fFCOvM8yFes91
         nOWXvPJJ/LPNrtgAk0cXiEOXuM8hRdANWWCxDPjxOq25FV/0I/V55JOohShJDOJqIzpU
         TgmEtkjVfu2FUXAGx5XihzCOmw2DLCstH+Pdr2TuiQQQt41z3CrGJ+IRS6f/LKFxLdKh
         YGw/rp6oQbGXHgPup2SzfVeQJ39hti830kg0BqcXi+bh4g3jtFkxwAXo+pPIyWGlIUrb
         PJVr1d4+XM3tVdoxEOo/N0fhfpWhNypsGVUgD/VSjiY9SaFVvcknw7KLlcsp2YJy+p28
         5m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trJ5qupIUuTA08iG4ykhqnQTpYLgxUEzEcK4z9AeclQ=;
        b=pqQvo2Q6vuEIZ/QfDc2WHGIcuMwmoacMu/Q9Xbfk+SwSnGIPATuVuDJdOA9mrEA+ab
         5HKJUXOiT0ccyLELwYVW/Ohg4ELv4gGE267lnwTWiFf/cYy5zGkuJp8RrD9fe+hES6kL
         JUG3JiKwAwazt7rUt6E3dD19Jvs7ls3fovZmv+p3Tc/nHONke7RSkEL+5kUC5lrIJZt1
         Uwkto7iTEcpjFG+OnZDkajriJEgy68Gggn9DDRhxh6eSB07ow+wraM+Gng+3q0uroApQ
         ANEdZKI7gKGOv7yXlozsCa387vZ7i/2t0H3pf6Gcg29ZDSoYFh4TlroPxFS7Zq8hhgG0
         7tQA==
X-Gm-Message-State: AOAM531pN1AnIPsszrClb5j8vJcMpDLqxUJl2DxfQn7tIvElTt3oPmMu
        +60878OM9ak6Yje9EPNrih8isukNHrjOHREfKcw=
X-Google-Smtp-Source: ABdhPJxyfeDGW2plHn84lIlXkUrxfVuEFg8ss4PlNtf6JH2PtBZwAa7hwaKbGN3vYVL9A9SiMhkMXvdbEB4CllmvKKM=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr1484197ybj.433.1634765268300;
 Wed, 20 Oct 2021 14:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212049.1010192-1-irogers@google.com> <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
 <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com>
In-Reply-To: <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 14:27:37 -0700
Message-ID: <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
To:     Ian Rogers <irogers@google.com>
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

On Wed, Oct 20, 2021 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 2:12 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> > > the code requiring it conditionally compiled in.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  btf_encoder.c | 7 +++++++
> > >  lib/bpf       | 2 +-
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index c341f95..400d64b 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> > >         [BTF_KIND_VAR]          = "VAR",
> > >         [BTF_KIND_DATASEC]      = "DATASEC",
> > >         [BTF_KIND_FLOAT]        = "FLOAT",
> > > +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
> > >         [BTF_KIND_TAG]          = "TAG",
> > > +#endif
> > >  };
> > >
> > >  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> > > @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
> > >  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
> > >                                     int component_idx)
> > >  {
> > > +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
> >
> > How will this work when libbpf is loaded dynamically? I believe pahole
> > has this mode as well.
>
> Well it won't have a compilation error because BTF_KIND_TAG isn't

Great, you traded compile-time error for runtime linking error, I hope
that trade off makes sense to Arnaldo.

> undefined :-) Tbh, I'm not sure but it seems that you'd be limited to
> features in the version of libbpf you compiled against.

I've been consistently advocating for statically linking against
libbpf exactly to control what APIs and features are supported. But
people stubbornly want dynamic linking. I hope added complexity and
feature detection makes sense in practice for pahole.

>
> > Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
> > LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
> > guessing the version
>
> This was moved to a header file in:
> https://lore.kernel.org/bpf/CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com/T/
>
> But that header doesn't appear any more:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf
>
> Is that a bug?

You should be checking here:

https://github.com/libbpf/libbpf/blob/master/src/libbpf_version.h

>
> Thanks,
> Ian
>
> > >         struct btf *btf = encoder->btf;
> > >         const struct btf_type *t;
> > >         int32_t id;
> > > @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
> > >         }
> > >
> > >         return id;
> > > +#else
> > > +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> > > +        return -ENOTSUP;
> > > +#endif
> > >  }
> > >
> > >  /*
> > > diff --git a/lib/bpf b/lib/bpf
> > > index 980777c..986962f 160000
> > > --- a/lib/bpf
> > > +++ b/lib/bpf
> > > @@ -1 +1 @@
> > > -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> > > +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
