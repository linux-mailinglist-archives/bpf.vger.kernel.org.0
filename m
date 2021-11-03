Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC3444641
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 17:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhKCQvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKCQvh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 12:51:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF585C061714
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 09:49:00 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o12so7949689ybk.1
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziawTi6pwHFo+bD7e1IO0+/fzQGHU+JVQocz/ODYzFQ=;
        b=p5KCV7L4Cp895DimoZoJGgcOxpTUritAMoZPQ0FfYEqP1z7L3QwyDBLvojs7XN7Pto
         aANfmKIZ7COPtbjFyCQ8OR8ygE50k4vrVuZadINfwawlgtgJ4baNmySVkjhuKq1mAkwj
         nDPTufK+XnsrGd4o95lZn8I3SDfxLoLyllYIfvJYZhfwkSFe7f+dv+vtk4Hx4MvY9fBx
         8FE5GCRMOsvqOmeh/RxtQiLe1iAzq3lJRiD9RlkogQgXAbVoXOKjwTP8LXxqYwqccIaK
         Ioeys2bkkS50RlZgupP9fr47bh8b/eRuzlLL72Rz3EbNMim8ZhlT9D/eUD1F2sNK+7bO
         jL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziawTi6pwHFo+bD7e1IO0+/fzQGHU+JVQocz/ODYzFQ=;
        b=T3anmocI7j28/nqJLQkYEhk1YSmGhvU4tPCddy6q85PsgUEq9au7fhe7ukzr/6pTas
         JGhIX1UsmnbjsjqcRczTq2D5BivlWx0DJsPWhFdeFqm18agleWM1fZaxZQXNFP7uaspI
         uXtIZE9evnvOvYOfu19KigY7qz6xfnI8XTOySH8QqcCrlS5G6tdxQNsi2P5+rFqU9Alo
         i3vNiCVP3m+7kb8pjlH+ohwXYocXzUeHf9ZTykciVevxA32sKPDskNUim86R0fLpTNlv
         hlWLgssPv2vcw5S8YSfOIlAmNI92FsArtOCpavojBlCaX8aj/ms2+Flcu044HqzAuoHc
         tFXA==
X-Gm-Message-State: AOAM532I5gzUn1OZvfgqAJZGwDzlPF8zD6+6nySsfQLh1MHGePB25kAI
        g103L97lFh3YUaJzmT8qylfD3q+XQbfNuQLnC4v0hcgr
X-Google-Smtp-Source: ABdhPJxTLgZRGY7npR0XLtqWLv8gFCpEDmmdsQ25+zAkMP2ddmBVMHnoeMLdWbDOhNCwpyhO6rxNVXqhrNE15v2lGNc=
X-Received: by 2002:a25:d010:: with SMTP id h16mr40619947ybg.225.1635958139949;
 Wed, 03 Nov 2021 09:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211103001003.398812-1-andrii@kernel.org> <20211103001003.398812-3-andrii@kernel.org>
 <21677f40-5415-e932-46ef-4e31cf6dd0f2@fb.com> <CAEf4BzaPE8QKRfeHPmPtJjQQ1Fv1AzSVUb-s+0+8Z4GMpDa2SQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaPE8QKRfeHPmPtJjQQ1Fv1AzSVUb-s+0+8Z4GMpDa2SQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Nov 2021 09:48:49 -0700
Message-ID: <CAEf4BzZn-hY1JnRGjWZutyrfWU83eT1KCkfkbViFrEPKFQdTtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: improve sanity checking during BTF
 fix up
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 3, 2021 at 9:36 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 2, 2021 at 11:06 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> > > If BTF is corrupted DATASEC's variable type ID might be incorrect.
> > > Prevent this easy to detect situation with extra NULL check.
> > > Reported by oss-fuzz project.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Ack with a nit below.
> > Acked-by: Yonghong Song <yhs@fb.com>
> >
> > > ---
> > >   tools/lib/bpf/libbpf.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 71f5a009010a..4537ce6d54ce 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -2754,7 +2754,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
> > >               t_var = btf__type_by_id(btf, vsi->type);
> > >               var = btf_var(t_var);
> >
> > Can we move the above 'var = ...' assignment after below if statement?
>
> it's safe as is because btf_var() is equivalent to pointer casting. I
> considered doing a check before btf_var() cast, but that would require
> a separate if and pr_debug statements which felt like an overkill.

Oh, never mind, we don't validate var itself, so no need for extra if.
I'll post a v2 with this change.

>
> >
> > >
> > > -             if (!btf_is_var(t_var)) {
> > > +             if (!t_var || !btf_is_var(t_var)) {
> > >                       pr_debug("Non-VAR type seen in section %s\n", name);
> > >                       return -EINVAL;
> > >               }
> > >
