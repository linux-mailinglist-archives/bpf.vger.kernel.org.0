Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFC435539
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhJTVZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTVZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 17:25:25 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B77C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:23:11 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s3so23722309ild.0
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TDC4x3/7XL0ZvZG6kWFOBV8Qo5kFtOCk5tOpRbqnhk=;
        b=mzDwje90VYbNiITgj3fjZdBNduLU15yu69zqD7v3D4JnfAVNGJYhWQJN+r2SyHMvIa
         OsOVrvxHMDr3IwWAOo0NrkIA/85rwGvdnaw6zKHZOCEe6DACJelXxaHSc9dIqn2tyhJZ
         82a3HWRJyL6MbAq7Vt23V/cnkZy5zm9Q13cpSTnYQ/HphmG0yskXbXvDXkVQe9lLy62l
         FIsOssJKiv2yKVGUw5vWUqhcCi1Dvjl8Xr4Rw3GW7ZLtrRjLpBZXYOK1mqCOXjfFkq0P
         5n3sKkVvpa4wsEK3Uq7ZFDpEaty+465LvTcplV2hht++6ChjeBhg+WgC7olABzLFlZY0
         WghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TDC4x3/7XL0ZvZG6kWFOBV8Qo5kFtOCk5tOpRbqnhk=;
        b=BJUYbKVAdg2aU59UF+iKd+mSHP55vsCp/pdfFIe6fdjzYxXh7oC+6YOk5yrniTJZh0
         0rLAQ40liINUNVdmr6sQb3G1esRKZFzMX6gnAapmsTRfHh3YXBSkKSW3WB12lSehSZNf
         CnwnlowVvRA6PTbyaZEvfMxZ9MkyoJ/fvMkCzv3QqtBcMhHIGqTka8IDzCY8xOsX59bk
         FCPWMIbFrMyHIf75zeVQI5jPqA3WD12BnrNbinaz6h8QBxmmcyxJz6LmXuFyQize5zFJ
         SfvHywAqwnTPW2HUvOFzYj9ybGRJKwkP1l0teG5MX4JCxpWkQk314JBGIofh1vx+KyvJ
         mFrg==
X-Gm-Message-State: AOAM5322eW/Gs9+NAlfEKnnyKKjUU73y4SMEoVWnp9Gh8jaUcomNQFDz
        Ak0YidpfkWag2sIiRcUCtwnAHQxcVYgwVotJHcNkww==
X-Google-Smtp-Source: ABdhPJy/FvOZEOCIWm/s+rKEGnlIr9U46Xt+VG9stPEYHeyy3c0wXomamMbJ5YiEFEIMkKO3sjrohE4H+WnPIUue4Dw=
X-Received: by 2002:a05:6e02:1708:: with SMTP id u8mr979145ill.2.1634764988399;
 Wed, 20 Oct 2021 14:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212049.1010192-1-irogers@google.com> <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
In-Reply-To: <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Oct 2021 14:22:55 -0700
Message-ID: <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com>
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

On Wed, Oct 20, 2021 at 2:12 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> >
> > BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> > the code requiring it conditionally compiled in.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  btf_encoder.c | 7 +++++++
> >  lib/bpf       | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index c341f95..400d64b 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >         [BTF_KIND_VAR]          = "VAR",
> >         [BTF_KIND_DATASEC]      = "DATASEC",
> >         [BTF_KIND_FLOAT]        = "FLOAT",
> > +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
> >         [BTF_KIND_TAG]          = "TAG",
> > +#endif
> >  };
> >
> >  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> > @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
> >  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
> >                                     int component_idx)
> >  {
> > +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
>
> How will this work when libbpf is loaded dynamically? I believe pahole
> has this mode as well.

Well it won't have a compilation error because BTF_KIND_TAG isn't
undefined :-) Tbh, I'm not sure but it seems that you'd be limited to
features in the version of libbpf you compiled against.

> Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
> LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
> guessing the version

This was moved to a header file in:
https://lore.kernel.org/bpf/CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com/T/

But that header doesn't appear any more:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf

Is that a bug?

Thanks,
Ian

> >         struct btf *btf = encoder->btf;
> >         const struct btf_type *t;
> >         int32_t id;
> > @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
> >         }
> >
> >         return id;
> > +#else
> > +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> > +        return -ENOTSUP;
> > +#endif
> >  }
> >
> >  /*
> > diff --git a/lib/bpf b/lib/bpf
> > index 980777c..986962f 160000
> > --- a/lib/bpf
> > +++ b/lib/bpf
> > @@ -1 +1 @@
> > -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> > +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
