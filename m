Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C13A49A8
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhFKT5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKT5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 15:57:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF55C061574;
        Fri, 11 Jun 2021 12:54:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m9so5925266ybo.5;
        Fri, 11 Jun 2021 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4mieS3qwDtPPtNIN3tHLvCuP5BevzszpYB1km2xCkM=;
        b=LHkjqRLFDM7283XCgt6IqAjxPrcsnFZi5fO18RcSuNZMBUIIti43r5hcHitRhJoefq
         PoPk9lC7YomFTrAuQfdQ89RgOL4kcG7hbPP45e8cfRdb1y8BxyuLUmoGP7BHHHlc9/F0
         7Jcj/7Bryrc2okASWmPcfmkI5avRnmoDoezsF2WyEf6iYOmV5FOW+4M3wBU7ZuC113Qs
         rRfMVQuJZYxKbkoawIqHt4FMT/3TxGxGrqSxeNTsRw60v2uRsfjYf6TUxX3UHSRI9atI
         okIcGGze+fjV/6XWLllFWjvF7cPbNrO7kBKYTjMN/Y3V9NBqi9hW0WNVi8GAVoZxy69u
         xl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4mieS3qwDtPPtNIN3tHLvCuP5BevzszpYB1km2xCkM=;
        b=aywl/2GTgV5xNhxBY4Y1PAaH5bwkQh2EVBnqSXzU1T8+w1C5hyyQlF7z9jIO+FPtro
         rZ4q/ydcqBa6txzn3DMI1oZs4miWIL3CUgs5hTm2ypB/UwRWLpKc9usaeVrp69Aa2K6s
         72xnFuQJGEYozt+jM+gagXtZfCGLBRsW8LxM5Qwh/yrhr5qIR+ifLYlXkEGmBmy9sKDB
         truxTpuvxxLeQJSl/gqtyht2cnO9NOg7jDGocsTEBGc12OhzkvdIiNZY5Pr+H7VlwKdl
         6m2KrBa0JjX34v5Y1PAtYHYP9pdDoO5bK5rlkviczoPizWNKRfNpXcgKW+Wn/or8AZfc
         wQlg==
X-Gm-Message-State: AOAM533XexT3+HRXdGBPyEtWUeHscXnnrgaSBTyDb+E7B5BciWdYtH/2
        jZl0vBHUWQZd7ffAij0SsQWrfbPK85dzm7VAbCw=
X-Google-Smtp-Source: ABdhPJxQcFSYzG1H7WTEzjS7a5bGB6oAM4rMC8LxcG9H5ltSHXW674SArmvfym8BttA+dpdh1/MsFOkVGCL5fi9kP1w=
X-Received: by 2002:a25:1455:: with SMTP id 82mr8229088ybu.403.1623441293700;
 Fri, 11 Jun 2021 12:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org> <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 12:54:42 -0700
Message-ID: <CAEf4BzaFt4n3cuwSLVycuBGrpJAphu3WhAwKjNR2krs39KJuoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luca Boccassi <bluca@debian.org>
Cc:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 12:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra escreveu:
> > > CMakeLists.txt does not allow creation of static library and link app=
lications
> > > accordingly.
> > >
> > > Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_=
LIBS
> > > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it=
 to ON.
> > >
> > > Ex:
> > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> >
> > Had to do some fixups due to a previous patch touching CMakeLists.txt,
> > please check below.
> >
> > I tested it and added some performance notes.
>
> Hey Arnaldo, Deepak,

Should have added Luca as well, it might be his patch (ae2581647e84
("libbpf: Allow to use packaged version")) that might have introduced
this breakage in the first place.

>
> I think this commit actually breaks libbpf's CI (see [0]) and my local
> setup as well (see output below). It seems like now we are using
> system-wide libbpf headers, while still building local libbpf sources.
> This is pretty bad because system-wide headers might be too old or
> just missing.
>
> Is it possible to make sure that we always use local libbpf headers
> when building pahole with libbpf built from sources (the default case,
> right?). It's also important to use UAPI headers distributed with
> libbpf when building libbpf itself, I don't know if that's what is
> done right now or not.
>
> Note how libbpf CI case shows that system-wide bpf/btf.h is not
> available at all because we don't have system-wide libbpf installed.
> In my local case, you can see that my system-wide header is outdated
> and doesn't have BTF_LITTLE_ENDIAN/BTF_BIG_ENDIAN constants defined in
> libbpf.h.
>
> BTW, I tried -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF options and they
> didn't help. Maybe I'm doing something wrong.
>
>   [0] https://travis-ci.com/github/kernel-patches/bpf/builds/228673352
>
>
> $ make -j60
> -- Setting BUILD_SHARED_LIBS =3D ON
> -- Checking availability of DWARF and ELF development libraries
> -- Checking availability of DWARF and ELF development libraries - done
> -- Configuring done
> -- Generating done
> -- Build files have been written to: /home/andriin/local/pahole/build
>
> ....
>
> /home/andriin/local/pahole/btf_encoder.c:900:28: error:
> =E2=80=98BTF_LITTLE_ENDIAN=E2=80=99 undeclared (first use in this functio=
n)
>    btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
>                             ^
> /home/andriin/local/pahole/btf_encoder.c:900:28: note: each undeclared
> identifier is reported only once for each function it appears in
> /home/andriin/local/pahole/btf_encoder.c:903:28: error:
> =E2=80=98BTF_BIG_ENDIAN=E2=80=99 undeclared (first use in this function)
>    btf__set_endianness(btf, BTF_BIG_ENDIAN);
>                             ^
> ...
>
>
> >
> > Thanks!
> >
> > - Arnaldo
> >
> > commit aa2027708659f172780f85698f14303c7de6a1d2
> > Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> > Date:   Tue Jun 8 00:50:13 2021 +0530
> >
> >     CMakeLists.txt: Enable SHARED and STATIC lib creation
> >
> >     CMakeLists.txt does not allow creation of static library and link a=
pplications
> >     accordingly.
> >
> >     Creation of SHARED and STATIC should be allowed using -DBUILD_SHARE=
D_LIBS
> >     If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets =
it to ON.
> >
> >     Ex:
> >
> >       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> >       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
> >
>
> [...]
