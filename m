Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292F435875
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUB5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJUB5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 21:57:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BEEC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:55:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t127so22326970ybf.13
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Raao5mFGmYqcZ0AlCjy1zm3a4Xcr7+U7s99Zig3pIfM=;
        b=behglBHr0o36ZOQmNSqGvbgoElHJe7s2bxwYxoSU3hQDZNaSTECBCITfLEhilGKeOk
         3pr1PVglwcdw1RwbLnKBwhotOoXdfrzLdT2nkaY7BslMS06B1A5lcHvfNscoBrhLfVdS
         d6CnvCWNYSxTrydqy/ivCw0xf28HEV1Yy9Uzn1KqZkyw6SSRBUOaCrzsPEeUIEIZNJFn
         s+WASZyEYOipOcpkPru4Bimnlc7PhCnk01X7GBG74R77ZmRlDWV8iRrOC8GlcPvmCSmE
         DVcqwmZ5dEoHRaGE0cuLuTd9IJQvRkf7wV3245UuyHDR/UR2wsq8xZgIZqKghztskEEq
         9pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Raao5mFGmYqcZ0AlCjy1zm3a4Xcr7+U7s99Zig3pIfM=;
        b=Vu8dqePytInWjT4FxPurTCn78SKzLeI6bwyzt2AgKWF//cjWdE7i7E8/5Nm1ouZBa9
         Tqsg7OWCE1nr9ULE3GGGJEONlCoTy9PKSDrFpUS97pxVjCufug7IYvhgexdxtg4N0llL
         uagKSq00Evohafhho7lS0741gRHsF/AG9G0nShDy9pjBZN+gg503CL5zJJ+ItLEF5tBZ
         p5XA7fBH8bZZnZr+8YT828R69Mlx8WaG2vJYgKzrsP9UsT/DemcKcprBQb6cPaDppdkc
         y87ygXItGPCjFqVcBmMpHf95EVHiud2h5mlwAcbUlQDB/hxrWToeuCaUR62ZXorRKskx
         CI7g==
X-Gm-Message-State: AOAM530VnSqQXI5IyXfq+me98nbTPByRUIpaLNxCyjvNiwGHKC3TOltL
        b93NmamOx2FY83gfav52kZVMP0iQeiaJuXIwikw=
X-Google-Smtp-Source: ABdhPJyUkipMsb0BKpnCgcUTTdmmsjLofRGWj73JlugzxHA4NZ/EspOwgLQlVv6GDzrTft81eGUWXnWoxzUjYVtWHKA=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr3046973ybk.2.1634781323486;
 Wed, 20 Oct 2021 18:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212049.1010192-1-irogers@google.com> <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
 <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com>
 <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
 <CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com>
 <CAEf4BzaNwEkGJ9OFEPe7nH2G2yP3tzqRjXV8zLHhqk-76xK1QA@mail.gmail.com> <CAP-5=fVCJ+RCj9WBr6BGhweC6_F0tMpdUky=ZS-_FLKmF6+neg@mail.gmail.com>
In-Reply-To: <CAP-5=fVCJ+RCj9WBr6BGhweC6_F0tMpdUky=ZS-_FLKmF6+neg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 18:55:12 -0700
Message-ID: <CAEf4BzbuYZ6dayHoRKQ1w3PuNKnG0N=AO=a=NO0vEvKN0WY1tQ@mail.gmail.com>
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

On Wed, Oct 20, 2021 at 4:46 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 3:30 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 2:49 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 2:27 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 20, 2021 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Wed, Oct 20, 2021 at 2:12 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> > > > > > >
> > > > > > > BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> > > > > > > the code requiring it conditionally compiled in.
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > ---
> > > > > > >  btf_encoder.c | 7 +++++++
> > > > > > >  lib/bpf       | 2 +-
> > > > > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > > > index c341f95..400d64b 100644
> > > > > > > --- a/btf_encoder.c
> > > > > > > +++ b/btf_encoder.c
> > > > > > > @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> > > > > > >         [BTF_KIND_VAR]          = "VAR",
> > > > > > >         [BTF_KIND_DATASEC]      = "DATASEC",
> > > > > > >         [BTF_KIND_FLOAT]        = "FLOAT",
> > > > > > > +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
> > > > > > >         [BTF_KIND_TAG]          = "TAG",
> > > > > > > +#endif
> > > > > > >  };
> > > > > > >
> > > > > > >  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> > > > > > > @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
> > > > > > >  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
> > > > > > >                                     int component_idx)
> > > > > > >  {
> > > > > > > +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
> > > > > >
> > > > > > How will this work when libbpf is loaded dynamically? I believe pahole
> > > > > > has this mode as well.
> > > > >
> > > > > Well it won't have a compilation error because BTF_KIND_TAG isn't
> > > >
> > > > Great, you traded compile-time error for runtime linking error, I hope
> > > > that trade off makes sense to Arnaldo.
> > > >
> > > > > undefined :-) Tbh, I'm not sure but it seems that you'd be limited to
> > > > > features in the version of libbpf you compiled against.
> > > >
> > > > I've been consistently advocating for statically linking against
> > > > libbpf exactly to control what APIs and features are supported. But
> > > > people stubbornly want dynamic linking. I hope added complexity and
> > > > feature detection makes sense in practice for pahole.
> > > >
> > > > >
> > > > > > Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
> > > > > > LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
> > > > > > guessing the version
> > > > >
> > > > > This was moved to a header file in:
> > > > > https://lore.kernel.org/bpf/CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com/T/
> > > > >
> > > > > But that header doesn't appear any more:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf
> > > > >
> > > > > Is that a bug?
> > > >
> > > > You should be checking here:
> > > >
> > > > https://github.com/libbpf/libbpf/blob/master/src/libbpf_version.h
> > >
> > > We don't currently mirror this or bpf-next, but presumably the
> >
> > Sorry, who's "we" and what's the use case we are talking about here?
> > pahole itself is using libbpf from Github mirror and that's what all
> > distros either are already doing or strongly encouraged to start
> > doing.
>
> I work for Google. When I spoke with Arnaldo it seemed uncommon that a
> distro would be tracking bpf-next. There's a policy of a single
> library version within Google and a different version for pahole has
> some issues for us.

I'm not following. Distros don't track bpf-next for libbpf. They track
https://github.com/libbpf/libbpf as an official libbpf repo. Not sure
what you mean by "different version for pahole"? Use pahole version
that statically links against its own (submodule) libbpf.

>
> > > released version of libbpf is that in the Linus' tree [1]? There are
> > > some things like traceevent that are planned for removal. It seems
> > > like a bug that these trees are missing libbpf_version.h.
> >
> > I misremembered versions, LIBBPF_MAJOR_VERSION/LIBBPF_MINOR_VERSION
> > are available starting from v0.6 (unreleased yet), not v0.5. It's a
> > pretty recent change, so might have not made it to the tip tree. But
> > Github repo does have it, it's synced from bpf-next directly.
>
> Ok, do you suggest something like:
>
> #if defined(LIBBPF_MAJOR_VERSION)
> #if LIBBPF_MAJOR_VERSION > 5
> ..
> #endif
> #endif
>
> rather than #ifdef BTF_KIND_TAG ? I couldn't see similar examples to
> cargo cult from, so there's a likelihood that this could become a
> pattern others copy.

That's more reliable than checking BTF_KIND_TAG for sure. BTF_KIND_TAG
comes from kernel UAPI headers, it doesn't directly correlate with
libbpf version, unless you make sure that you only use UAPI headers
that libbpf uses for its own build.

But then, if you use pahole in the mode that dynamically links against
libbpf, then this whole LIBBPF_MAJOR_VERSION business is bogus,
because it only checks what version of libbpf pahole was compiled
against, not which libbpf version will it dynamically link against.


Regardless, it's probably a good idea to add libbpf version APIs that
could be queried at runtime, e.g., int libbpf_major_version(), int
libbpf_minor_version(), etc. That would be usable even with shared
library.

>
> Thanks,
> Ian
>
> > >
> > > Thanks,
> > > Ian
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > >         struct btf *btf = encoder->btf;
> > > > > > >         const struct btf_type *t;
> > > > > > >         int32_t id;
> > > > > > > @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
> > > > > > >         }
> > > > > > >
> > > > > > >         return id;
> > > > > > > +#else
> > > > > > > +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> > > > > > > +        return -ENOTSUP;
> > > > > > > +#endif
> > > > > > >  }
> > > > > > >
> > > > > > >  /*
> > > > > > > diff --git a/lib/bpf b/lib/bpf
> > > > > > > index 980777c..986962f 160000
> > > > > > > --- a/lib/bpf
> > > > > > > +++ b/lib/bpf
> > > > > > > @@ -1 +1 @@
> > > > > > > -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> > > > > > > +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> > > > > > > --
> > > > > > > 2.33.0.1079.g6e70778dc9-goog
> > > > > > >
