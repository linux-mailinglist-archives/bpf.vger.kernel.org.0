Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88C13A49F3
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFKULf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 16:11:35 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:41785 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFKULe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 16:11:34 -0400
Received: by mail-yb1-f182.google.com with SMTP id q21so5947913ybg.8;
        Fri, 11 Jun 2021 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G/KK1UkJoUDfQz9VUZNipcPN0tXnhdyhUBVyjUBjLDE=;
        b=jyf/fach7pCHoFlg55mWK1l94NOFYGXJNA3pcfBBHw7MjiWiGEqnYVYZiqgddvzxUn
         xj5u6W1Zhuc2H3cZfFFyUEdrGygz1rku/HzOv8G8MezSuWrKA9aY0nQiFmqGe6o8xzog
         p6frvitZeYGLHgP4up8xDELDxZ9odbu5LsRLOmPPsW3kuyu1HU4FE4O0mj4oUZ/DTtHn
         LFr2YQ9+74GYMy7CEidpQMHV9YK/+rXmZ4qAQ5YAByZRgcFDFmTawqkBjieoBORzt/eB
         GaAKzi/eGO90puOzo2on2ajw7X7U+33xTLBnDoU7mYmCIeoUtbyisPyHo1WCtrKMb5AR
         xoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G/KK1UkJoUDfQz9VUZNipcPN0tXnhdyhUBVyjUBjLDE=;
        b=NxkDROXrEB8B4kbKXoiaGKFWWCKbL8e7E6yV3BC/hGG/M5NROkl/Y70R8SKWSIiacR
         H2xEZy/19sdk4CwitAZ5cMma6cuYhza8+kc+g9eHbYtEeD/OviElVmVAt2H1GFjTFLLe
         DfK0Eu/RMgQ0Oc5drLxbA2WIi4qfTRfE8dgjghPis1mgOwGnXOQgXH9nD/uWDZL/E6iW
         pjV4AR/RuWHE9LAbKCkbcbrHiYBxhpkWNq1GBHKUnKbBODKEr11wezYARiI5xy/qCL2h
         dtZeZL0cgDBPaaAG0LLjjB1N/Ge9Dc/NeDZ3fvTd+g+Ezeq9VdGPWagyNpBnHTblTZME
         Ctjg==
X-Gm-Message-State: AOAM530Nj+4qq1pAXQC4pz0uijWcZXssA50lIM25h8nyuyb8sYet9RVM
        3jFBl6rWnw/wisA873v9X6eaGa0AxCHXRPDkktc=
X-Google-Smtp-Source: ABdhPJzCmnyiT9W+7Y1XLIqL6aviwLODbIKZ4H7nNrod5w/gbtIBkkSmAjwNF2MzfrMWIg5GHDcjYJHDS7m0DgG1yr8=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr8135994ybg.459.1623442104718;
 Fri, 11 Jun 2021 13:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org> <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
 <YMPA1T0Cuo7xw/Sp@kernel.org>
In-Reply-To: <YMPA1T0Cuo7xw/Sp@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 13:08:13 -0700
Message-ID: <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 1:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Jun 11, 2021 at 12:34:13PM -0700, Andrii Nakryiko escreveu:
> > On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra escreve=
u:
> > > > CMakeLists.txt does not allow creation of static library and link a=
pplications
> > > > accordingly.
> > > >
> > > > Creation of SHARED and STATIC should be allowed using -DBUILD_SHARE=
D_LIBS
> > > > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets =
it to ON.
> > > >
> > > > Ex:
> > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> > >
> > > Had to do some fixups due to a previous patch touching CMakeLists.txt=
,
> > > please check below.
> > >
> > > I tested it and added some performance notes.
> >
> > Hey Arnaldo, Deepak,
> >
> > I think this commit actually breaks libbpf's CI (see [0]) and my local
> > setup as well (see output below). It seems like now we are using
> > system-wide libbpf headers, while still building local libbpf sources.
> > This is pretty bad because system-wide headers might be too old or
> > just missing.
>
> I can't check this right now, but isn't this related to this one
> instead?

Heh, I beat you by 5 minutes ;)

>
> commit ae2581647e84948810ba209f3891359dd4540110 (quaco/master, quaco/HEAD=
, acme/tmp.master)
> Author: Luca Boccassi <bluca@debian.org>
> Date:   Mon Jan 4 22:16:22 2021 +0000
>
>     libbpf: Allow to use packaged version
>
>     Add a new CMake option, LIBBPF_EMBEDDED, to switch between the embedd=
ed
>     version and the system version (searched via pkg-config) of libbpf. S=
et
>     the embedded version as the default.
>
>  -------
>
> I can't look at this right now, will try probably tomorrow.
>
> Andrii, I would love to be able to stage this somewhere, like I did with
> tmp.master, so that it could go thru your CI before I moved to master,
> is that possible?

Yes, absolutely, we can pick whatever branch and use that to checkout
and build pahole. It would be great, though, if you can keep an eye on
kernel CI and/or libbpf CI breakages when you are pushing new changes
to pahole. That would save everyone time and will shorten the downtime
for our CIs.

Here are the links where all the builds can be seen in real-time:

  - kernel CI: https://travis-ci.com/github/kernel-patches/bpf/pull_request=
s
  - libbpf CI: https://travis-ci.com/github/libbpf/libbpf


Let me know which branch we should hard-code for staging.

>
> - Arnaldo
>
> > Is it possible to make sure that we always use local libbpf headers
> > when building pahole with libbpf built from sources (the default case,
> > right?). It's also important to use UAPI headers distributed with
> > libbpf when building libbpf itself, I don't know if that's what is
> > done right now or not.
> >
> > Note how libbpf CI case shows that system-wide bpf/btf.h is not
> > available at all because we don't have system-wide libbpf installed.
> > In my local case, you can see that my system-wide header is outdated
> > and doesn't have BTF_LITTLE_ENDIAN/BTF_BIG_ENDIAN constants defined in
> > libbpf.h.
> >
> > BTW, I tried -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF options and they
> > didn't help. Maybe I'm doing something wrong.
> >
> >   [0] https://travis-ci.com/github/kernel-patches/bpf/builds/228673352
> >
> >
> > $ make -j60
> > -- Setting BUILD_SHARED_LIBS =3D ON
> > -- Checking availability of DWARF and ELF development libraries
> > -- Checking availability of DWARF and ELF development libraries - done
> > -- Configuring done
> > -- Generating done
> > -- Build files have been written to: /home/andriin/local/pahole/build
> >
> > ....
> >
> > /home/andriin/local/pahole/btf_encoder.c:900:28: error:
> > =E2=80=98BTF_LITTLE_ENDIAN=E2=80=99 undeclared (first use in this funct=
ion)
> >    btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
> >                             ^
> > /home/andriin/local/pahole/btf_encoder.c:900:28: note: each undeclared
> > identifier is reported only once for each function it appears in
> > /home/andriin/local/pahole/btf_encoder.c:903:28: error:
> > =E2=80=98BTF_BIG_ENDIAN=E2=80=99 undeclared (first use in this function=
)
> >    btf__set_endianness(btf, BTF_BIG_ENDIAN);
> >                             ^
> > ...
> >
> >
> > >
> > > Thanks!
> > >
> > > - Arnaldo
> > >
> > > commit aa2027708659f172780f85698f14303c7de6a1d2
> > > Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> > > Date:   Tue Jun 8 00:50:13 2021 +0530
> > >
> > >     CMakeLists.txt: Enable SHARED and STATIC lib creation
> > >
> > >     CMakeLists.txt does not allow creation of static library and link=
 applications
> > >     accordingly.
> > >
> > >     Creation of SHARED and STATIC should be allowed using -DBUILD_SHA=
RED_LIBS
> > >     If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt set=
s it to ON.
> > >
> > >     Ex:
> > >
> > >       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > >       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> > >
> >
> > [...]
>
> --
>
> - Arnaldo
