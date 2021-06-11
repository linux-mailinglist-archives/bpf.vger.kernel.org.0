Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3053A4B58
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFKXpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKXpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:45:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AEC061574;
        Fri, 11 Jun 2021 16:43:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b9so6576356ybg.10;
        Fri, 11 Jun 2021 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O+dPIZ5eSZUH96tussFb/uHl8kglwUBZzNTUK6MWugo=;
        b=AVb57aVeu9NxW3NpbGIS383+kSbaUnTzkxdUEfKO+LnfSzoUx7o3c1dVCiWeEQCDmg
         8CuagTNroU5atPN/vL9kZLes7FuxrOdCaOZt2XOC8MDitQz4zZGqeiktIKGEhQfZRsAs
         XDREnwIR9gW71+c11nsFlyWSlbTsy20CViJFB1rFvlIy50gRjsZSomlq511G9Oq9fUQq
         4g5vvus46ABNCFiEScgLtSO3vHnpX7FpllT35E7ra/YXeu+tXsRyCm4d4jE2nxDD2iKY
         ykAO5JYWH1iV8ZXcp8kF3C5KcNlrB+Ew1Y+e9JbjBVGPxapPVgM6LbtuKDoPJUvKjq6N
         pYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+dPIZ5eSZUH96tussFb/uHl8kglwUBZzNTUK6MWugo=;
        b=tgpXGlnESYb/Jr3i0ndUT1oYJm+eNzSSLcpO/heEEJQHS5JbgCSP9SbOPJ0Wfuwouh
         HMPY9DG9enYq2N6YJM5rakxVH0pYtcumnTqoXif8fnBkvpfjkT/L6FHOxLBJg+vJCBYc
         C1NhVBJqRQnrfSQquWqA/vlz9jBTYRgwvfVsJRYcTXcz4aikQe2nxTKrKJXLco1npmGp
         3WEQOFfZFBpwB4m3yFJMdp8YFTdUsEVmToqddRgM68SwJke9c2frN0y9V0tr0AUywruD
         +kKA33JTjeEmSbk3EIFhMFu7IoqUrxWHIEwSWLGcw8RdVV2VyUySD+YvajlzyHaAwrWf
         rcBg==
X-Gm-Message-State: AOAM532YNooB4k17ifbA0MYq3vSB32ryqKQtHDWtX73mCn1yhJ4iRjh/
        vNO5EitIX2jWtAfbQLxOITxPnKkYEX916nMAg9A=
X-Google-Smtp-Source: ABdhPJyWAorMOG+qc+mBsqk6dE3US8fbvb+1EevjHrkGuXFKVl2IgxPO1Axen9GCbN57d142WXJUvWctRq+p6VEP+eM=
X-Received: by 2002:a25:7246:: with SMTP id n67mr9440628ybc.510.1623455011980;
 Fri, 11 Jun 2021 16:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org> <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
 <YMPA1T0Cuo7xw/Sp@kernel.org> <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
 <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
 <49ebd74aac20b3896996c3b1fdcc14e35c7a05ec.camel@debian.org>
 <8471df5c1e5aa52bedb032b2fcb3b6ce7722de6b.camel@debian.org>
 <YMPpfzNCSE8DxvOA@codewreck.org> <4ec3aa68d7f608dd6f389e3ef192b5f86c71e93b.camel@debian.org>
In-Reply-To: <4ec3aa68d7f608dd6f389e3ef192b5f86c71e93b.camel@debian.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 16:43:20 -0700
Message-ID: <CAEf4BzYH9G77gRK18czfQaWkNSUwZReuBKLns3henJpzt9WEzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 4:07 PM Luca Boccassi <bluca@debian.org> wrote:
>
> On Sat, 2021-06-12 at 07:53 +0900, Dominique Martinet wrote:
> > Luca Boccassi wrote on Fri, Jun 11, 2021 at 11:45:25PM +0100:
> > > Actually that was my mistake, used the wrong build tree (sorry,
> > > it's
> > > late!). I can however reproduce the issue in a chroot running the
> > > libbpf CI script. Still looking.
> >
> > with the ci script I get
> >
> > $ /usr/lib64/ccache/cc -DDWARVES_MAJOR_VERSION=3D1 -
> > DDWARVES_MINOR_VERSION=3D21 -D_GNU_SOURCE -Ddwarves_EXPORTS -
> > I/path/to/pahole/build -I/path/to/pahole -
> > I/path/to/pahole/lib/include -I/path/to/pahole/lib/bpf/include/uapi -
> > D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -O2 -g -DNDEBUG -fPIC -MD
> > -MT CMakeFiles/dwarves.dir/btf_encoder.c.o -MF
> > CMakeFiles/dwarves.dir/btf_encoder.c.o.d -o
> > CMakeFiles/dwarves.dir/btf_encoder.c.o -c
> > /path/to/pahole/btf_encoder.c
> > /path/to/pahole/btf_encoder.c: In function =E2=80=98btf_encoder__add_fl=
oat=E2=80=99:
> > /path/to/pahole/btf_encoder.c:224:22: warning: implicit declaration
> > of function =E2=80=98btf__add_float=E2=80=99; did you mean =E2=80=98btf=
__add_var=E2=80=99? [-
> > Wimplicit-function-declaration]
> >   224 |         int32_t id =3D btf__add_float(encoder->btf, name,
> > BITS_ROUNDUP_BYTES(bt->bit_size));
> >       |                      ^~~~~~~~~~~~~~
> >       |                      btf__add_var
> >
> >
> >
> > with btf__add_float defined in .../pahole/lib/bpf/src/btf.h
> > and btf_encoder.c including linux/btf.h
> >
> >
> > changing btf_loader.c to include bpf/btf.h instead fixes the issue
> > for me:
> >
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 75ec674b3b3e..272c73bca7fe 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -20,7 +20,7 @@
> >  #include <string.h>
> >  #include <limits.h>
> >  #include <libgen.h>
> > -#include <linux/btf.h>
> > +#include <bpf/btf.h>
> >  #include <bpf/libbpf.h>
> >  #include <zlib.h>
>
> I've just sent a patch - the issue is that the original commit included
> a symlink lib/include/bpf -> ../bpf/src as suggested by Andrii here:
>
> https://www.spinics.net/lists/dwarves/msg00738.html
>
> git show 82749180b23d3c9c060108bc290ae26507fc324e -- lib/include
>     commit 82749180b23d3c9c060108bc290ae26507fc324e
>     Author: Luca Boccassi <bluca@debian.org>
>     Date:   Mon Jan 4 22:16:22 2021 +0000
>
>         libbpf: allow to use packaged version
>
>         Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
>         embedded version and the system version (searched via pkg-config)
>         of libbpf. Set the embedded version as the default.
>
>         Signed-off-by: Luca Boccassi <bluca@debian.org>
>         Cc: dwarves@vger.kernel.org
>         Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>     diff --git a/lib/include/bpf b/lib/include/bpf
>     new file mode 120000
>     index 0000000..4c41b71
>     --- /dev/null
>     +++ b/lib/include/bpf
>     @@ -0,0 +1 @@
>     +../bpf/src
>     \ No newline at end of file
>
> When the patch was reverted and re-added, the symlink was dropped.
>
> It stayed in my local tree, and I completely missed it - that's why the
> build was working fine for me! D'oh!
> Adding the symlink back fixes the build with the libbpf CI script. I
> would be grateful if folks who are seeing the issue could apply the
> patch (or create the symlink) and confirm whether it fixes the problem
> or not. Thanks!

It does fix it for me locally (apart from another unrelated build
problem), thanks! I can't really test CI beyond what you did, so this
will need to be applied to pahole master for us to know for sure.

>
> --
> Kind regards,
> Luca Boccassi
