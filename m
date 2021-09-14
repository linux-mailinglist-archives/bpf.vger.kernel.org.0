Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE640BA71
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhINVkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhINVkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:40:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68BC061574;
        Tue, 14 Sep 2021 14:38:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r4so1211473ybp.4;
        Tue, 14 Sep 2021 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z3lBJBQ/Bym47HMSsBvnUhCPMDKAk/Fy6PETEvHswtY=;
        b=U7AjMScwlGaDda8rOD3Ew1z/BLQP9jGIALjueaI4LnUyGmZmesnVY7T6RsCOKO+h1Y
         Os3xWmWSLiF+Se8ZlFUSCu9t8wN8SgRact8yqkMcYsYIDdUUtulXca5kC5HsY9VYEE1W
         kfHQfuK55NhQ5Kn7jxJswTa8erc+J9sYzr57tQLUInuE66BRjjQnoTcg0RLMp2W2Qu0L
         jFRueHtBPhB5RwnweTPTFHM6xobHC3GdWTAUEbPpIOQh0zuQWaAFbqcaddaKKhGWJtDg
         9jxqhC+DkB/2Tr9y8fBmqQINmkwPzPU0u8YaMg4oHcP7EnzOhVeAzV0w7Lt4QfgNvPmY
         6MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z3lBJBQ/Bym47HMSsBvnUhCPMDKAk/Fy6PETEvHswtY=;
        b=2Vn6TuleelAP4ThPJB1GUmJ8Upb+5TlnvWOyAntlTsMEAt1gtS3fWW4sLpAVihHW1i
         hBl0lnP+yJn3d5hCkZYNyO2C4QBYmLNxqH2w8k8Et6qbRlL9eDPrH9l+HPkz8lGp/eu8
         RKF4b1Xxz2Wv5yGhFjARB9b59F2bRuElQ5nplD/s3lkbzq4o6Ldm1dwIoLCqX4461eFh
         Ng1j3e9c5sBoKXN1vbciL8uat5bZF53V8aBzzdfrkTDWpyQxBgFF0wUEU8zGMoGX4QCG
         0VtaL2us5f9SuUXuLt4pFxvubY+rbd2egRcxh+3WhUWYgnzGyLuPRZFpT/71ZT7cdImP
         vFNw==
X-Gm-Message-State: AOAM532xwkroJWjLWNS6DMxvrPbp0UKHydyby2jLgTXKIx+1fjqwPBRh
        FxQ2YVMQoxo4uAkfFc9bMBZjXen/Wcgc3TjkU/s=
X-Google-Smtp-Source: ABdhPJwZP+i+J9MDvy08tXxR3yDToL69p2/DLL43tHRaYgiftJ/mrbifatbneOiA1S9SUUUaMnIFXs2GByvWsFpwFc8=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr1610635ybt.433.1631655521470;
 Tue, 14 Sep 2021 14:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210914170004.4185659-1-andrii@kernel.org> <YUDoNX0eUndsPCu+@krava>
 <CAEf4BzbU8Ok-7Fsp1uGZ4F6b5GPb58fk1YKgnGwx9+sUBq71tA@mail.gmail.com> <YUDxqnJhjnpdl6vv@kernel.org>
In-Reply-To: <YUDxqnJhjnpdl6vv@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 14:38:30 -0700
Message-ID: <CAEf4BzYzCQ4yuNKi3OCNqTXGXJQXt1XXNuhCT5oVF=khx85bXQ@mail.gmail.com>
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using libbpf's btf__get_from_id()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 12:02 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 14, 2021 at 11:28:28AM -0700, Andrii Nakryiko escreveu:
> > On Tue, Sep 14, 2021 at 11:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
> > > > Perf code re-implements libbpf's btf__load_from_kernel_by_id() API =
as
> > > > a weak function, presumably to dynamically link against old version=
 of
> > > > libbpf shared library. Unfortunately this causes compilation warnin=
g
> > > > when perf is compiled against libbpf v0.6+.
> > > >
> > > > For now, just ignore deprecation warning, but there might be a bett=
er
> > > > solution, depending on perf's needs.
> > >
> > > HI,
> > > the problem we tried to solve is when perf is using symbols
> > > which are not yet available in released libbpf.. but it all
> > > linkes in default perf build because it's linked statically
> > > libbpf.a in the tree
> > >
> >
> > If you are always statically linking libbpf into perf, there is no
> > need to implement this __weak shim. Libbpf is never going to deprecate
> > an API if a new/replacement API hasn't been at least in a previous
> > released version. So in this case btf__load_from_kernel_by_id() was
> > added in libbpf 0.5, and btf__get_from_id() was marked deprecated in
> > libbpf 0.6 (not yet released, of course). So with that, do you still
> > think we need this __weak re-implementation?
> >
> > I was wondering if this was done to make latest perf code compile
> > against some old libbpf source code or dynamically linked against old
> > libbpf. But if that's not the case, the fix should be a removal of
> > __weak btf__load_from_kernel_by_id().
>
> It was made to build against the libbpf that comes with fedora 34, the
> distro I'm using, which is:
>
> =E2=AC=A2[acme@toolbox perf]$ sudo dnf install libbpf-devel
> Package libbpf-devel-2:0.4.0-1.fc34.x86_64 is already installed.
> Dependencies resolved.
> Nothing to do.
> Complete!
> =E2=AC=A2[acme@toolbox perf]$ cat /etc/redhat-release
> Fedora release 34 (Thirty Four)
>
> And we have 'make -C tools/perf build-test' that has one entry to build
> with LIBBPF_EXTERNAL=3D1, i.e. using whatever libbpf-devel package is
> installed in the distro, in addtion to statically linking with the
> libbpf in the kernel sources.
>
> That is done because several distros are linking perf with the libbpf
> they ship.
>
> When I merged the latest upstream this test failed, and I realized that
> some files in tools/perf/ had changed to make use of a new function and
> that was the reason for the build test failure.
>
> So I tried to provide a transition help for these cases, initially as a
> feature test that would look if that new function was available and if
> not, provide the fallback, but then ended up following Jiri's suggestion
> for a __weak function, as that involved less coding.
>

Ok, that's cool, then my "fix" should be fine for now. Can you please
land it in perf/core to unblock Stephen's (cc'ed) build failure when
merging perf and bpf-next trees?

Also it's good to keep in mind that libbpf is now providing
LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macro, so when
statically linking you should be able to use that to detect libbpf
version. For shared library cases we should probably also add runtime
APIs (e.g., int libbpf_major_version(void), int
libbpf_minor_version(void), const char *libbpf_version(void)) so that
you can do more detection based on libbpf version at runtime. Let me
know if it's something that would be helpful.

> - Arnaldo
>
> > > so now we have weak function with that warning disabled locally,
> > > which I guess could work?  also for future cases like that
> > >
> > > jirka
> > >
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf-event.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-even=
t.c
> > > > index 683f6d63560e..1a7112a87736 100644
> > > > --- a/tools/perf/util/bpf-event.c
> > > > +++ b/tools/perf/util/bpf-event.c
> > > > @@ -24,7 +24,10 @@
> > > >  struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > >  {
> > > >         struct btf *btf;
> > > > +#pragma GCC diagnostic push
> > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > >         int err =3D btf__get_from_id(id, &btf);
> > > > +#pragma GCC diagnostic pop
> > > >
> > > >         return err ? ERR_PTR(err) : btf;
> > > >  }
> > > > --
> > > > 2.30.2
> > > >
> > >
>
> --
>
> - Arnaldo
