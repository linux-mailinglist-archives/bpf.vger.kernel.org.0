Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D03297935
	for <lists+bpf@lfdr.de>; Sat, 24 Oct 2020 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbgJWWCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbgJWWCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 18:02:43 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27682C0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 15:02:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c129so2406328yba.8
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhodysNWfesoEr27BBcoydZSeeh81d51gQbDjShlE0Y=;
        b=B3FFPsQmHwww8kArC/biZ2cRWpshxrdIabVzztw3HZ7z90jaqfqzzONDqd28YxeLmQ
         T7dIDFju2PJJdAi3LN74iW3kt8cL2DJjLgdy1r8npvVBgC263kD/Ahz+TAJFUkzSPQV8
         TEc5VPJkVbJBHqEvgWzu8eEOVOn5VDKoks4I3qr6YllnqXegaAhBktEFt9WP7Tl/on1V
         En2tjWZ8rJJ7oX5VDqpEcfoIhlpgwYTs9zl2lEMbiGGmw7Ct9WyOBU6T5EA8i3eQ+xQJ
         rzvNEUTL1DQSClHuEpsEBHbasoxXetKLlGphgLEj5MBijuJaWWrPR1s7D3akVuzoxB6u
         M1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhodysNWfesoEr27BBcoydZSeeh81d51gQbDjShlE0Y=;
        b=A4i3z3qox/UlGntFzOAkDe5R8vXPa92AJOLDQVc2xArqF870KrejxA8D+/jhqoJniu
         hzLgjrHOzQhX4qr4lra8Hz/13D5PUosKGJryHsSyUFc7yhz7L9lKYb6yWo2PNJ2+GrgC
         8TAVt8YF37A/PuErOJrlqURNXxnBmfyHycwsEOjmeN2Gas3Iuejfc4vJxSiT5O3JhRNw
         KgwqEuHIXVBXzy4JRTzQYQq/8jYrb8bC777Oqm4u5MkWvEhZ1na+phfx4y9rQEDSxN71
         K0WxbwI813h7tg3PzInuADzgch/8zF0ooyYf/CYEOryxKwazvANBy54ACH2Pr3J2A0h0
         Mdnw==
X-Gm-Message-State: AOAM530wG9dmWd/7ye9BqiTX/a1MWDHFXG8xFRZu3eowVhQAGKTc0NJJ
        9UyEABP5Zv1SImrpH0i1ym9nNA2D9+thwFmW1hVGu2LmwNc=
X-Google-Smtp-Source: ABdhPJysUPz2QX/c3pLGyVoZBf4MSkWkzpbibOIoXMqdJ+tJCMjpRYzthQQC3ol1h5yvsOp90DR0yMBhlhXYhII53UM=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr6428082ybf.425.1603490562280;
 Fri, 23 Oct 2020 15:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200915121743.GA2199675@krava> <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava> <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava> <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
 <20201023201702.GA2495983@krava> <CAEf4BzZzMNfBBPGeXazk0Qh8pbXMPip-i3iaSt6QqXE-tttT=A@mail.gmail.com>
 <20201023204539.GB2495983@krava>
In-Reply-To: <20201023204539.GB2495983@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Oct 2020 15:02:31 -0700
Message-ID: <CAEf4BzZKKLecyK3L+b6zqBvA4W3x3YbZ7y=8-kXwY+XoUvwgcg@mail.gmail.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 1:45 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 23, 2020 at 01:32:44PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > right, we can generate them in bpftrace, but it's a shame
> > >
> > >
> > > >
> > > > But otherwise, I don't really have a good feeling what's the perfect
> > > > solution here...
> > >
> > > I tried the check of dwarf record against function symbols
> > > with adresses mentioned earlier (attached)
> > >
> > > getting more functions of course ;-)
> > >
> > > $ bpftool btf dump file ./vmlinux | grep 'FUNC '  | wc -l
> > > 46606
> > >
> > > compared to 22869 on the same .config with working gcc
> > > and current pahole
> >
> > Just curious, what's the change in BTF size due to this?
>
> current: 3342279
> new:     4361045
>
> so about 1MB

ok, not too bad for almost 24k functions and bringing fentry/fexit on
par with kprobe/kretprobe in terms of what to attach to

>
> >
> > >
> > > and resolve_btfids is happy, because there are no duplications
> > >
> > > jirka
> > >
> > >
> > > ---
> >
> > [...]
> >
> > >  static int btf_var_secinfo_cmp(const void *a, const void *b)
> > >  {
> > >         const struct btf_var_secinfo *av = a;
> > > @@ -72,6 +157,7 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
> > >         if (!btfe)
> > >                 return NULL;
> > >
> > > +       btfe->symbols = RB_ROOT;
> >
> > Can you please check what we do for per-cpu variables with ELF
> > symbols? Perhaps we can unify approaches. I'd also favor using a sort
> > + bsearch approach instead of rb_tree, given we don't really need to
> > dynamically add/delete elements, it's a one-time operation to iterate
> > and initialize everything. Also binary search of linear arrays would
> > be more memory-efficient and cache-efficient, most probably.
>
> ok, will check
>

thanks!

> jirka
>
> >
> > >         btfe->in_fd = -1;
> > >         btfe->filename = strdup(filename);
> > >         if (btfe->filename == NULL)
> > > @@ -177,6 +263,7 @@ void btf_elf__delete(struct btf_elf *btfe)
> > >                         elf_end(btfe->elf);
> > >         }
> > >
> > > +       btfe__delete_symbols(btfe);
> > >         elf_symtab__delete(btfe->symtab);
> > >         __gobuffer__delete(&btfe->percpu_secinfo);
> > >         btf__free(btfe->btf);
> >
> > [...]
> >
>
