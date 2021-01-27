Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1BD305F28
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbhA0PKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 10:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343701AbhA0PKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 10:10:01 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1263EC061573
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 07:09:17 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id b78so552520vke.12
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VWuvj3onwL5E8A+RzsQ7+jyLFxjrQdIWwV4dMSub7rw=;
        b=wP+y1wLcmwDJf2N6jKTc4y9duxd/vKitk09bwCH7uybKVpXiyRZJ4KF3U74FTjtVj6
         0AIVqnbxEcG6k76u5VhLHsbFqXJi5dIxK2bL+aKmi/F1G7ZWxgODl4y+J8wfM0vFe2jX
         P7fKB4EvxnzcPTiAXcB0qpmI01TZ0uyQ4fQY3ZxeH3rOKd0+YPnvC7f/e3QEBwbhGsEC
         71gTVQQDGcUtn4ZBFCYULLKMhzyd7nh1Foa/sEBccMmHu1Wrj5YOy87UEdqTaraYz02L
         RR0Ox+Cs0rlrwPZ3Euz6HPn3U8Y12OFIHkYGtNSaVDI/wnhAh3YYdReKmEjOnyW2+nkn
         5B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VWuvj3onwL5E8A+RzsQ7+jyLFxjrQdIWwV4dMSub7rw=;
        b=iw88o84dMtArThrpyvA1tydTWC7qXBlMDvgfbCzV58oMP4nsFcdL5K/UGUSrGU4+Tq
         KzB1hHHYVjFlLwC0ihW71jQMYVU5MkcR0QadDUxmj51oEEFiFsogwBJdvi9SvTozF9TW
         K4S4cwthh5aVJ1fcQpT5eM5rI/7iVZNLlko8tsZUmC5GzHHzy7tQHaAT+tHnTktwjn3Q
         A5+v6itu7zPPyShOzTd7Mds+atv6hbM8yL2wIFdj1+D8PXjuRUk7NsnWPI2yXPitEnFl
         8tfO1STzc2xuAVGqVSc/L9RSDAjAnYNuYAas/z1O2bWt8d39d3dpRme/k8gq1Bdpp51E
         1jXg==
X-Gm-Message-State: AOAM530p3lvsnlzkGedu7OhFB1NMBcp+XLUDWxIyURXLBCo6Th3OLbMt
        naIFTo94wSH6S2YBPrNKAN04h4MMmANHPH48k3DoDw==
X-Google-Smtp-Source: ABdhPJwWcey/Da92zydDzbiiuQDWwjS9fB/PdUrYSOldcCYGnJjFzLzmH5xbljlMckIrQz+FEYIFfeiI51E8cwGxdOE=
X-Received: by 2002:ac5:cf1e:: with SMTP id y30mr3375321vke.18.1611760155757;
 Wed, 27 Jan 2021 07:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com> <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
In-Reply-To: <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Wed, 27 Jan 2021 15:08:38 +0000
Message-ID: <CAGvU0HkuZ_AW_YTjsdsivWV+wF3kf49ugChzMdRjZnrYzwVB3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii.

On Thu, 21 Jan 2021 at 20:08, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Jan 21, 2021 at 3:07 AM Giuliano Procida <gprocida@google.com> wr=
ote:
> >
> > Hi.
> >
> > On Thu, 21 Jan 2021 at 07:16, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> >>
> >> On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.com>=
 wrote:
> >> >
> >> > This is to avoid misaligned access when memory-mapping ELF sections.
> >> >
> >> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> >> > ---
> >> >  libbtf.c | 8 ++++++++
> >> >  1 file changed, 8 insertions(+)
> >> >
> >> > diff --git a/libbtf.c b/libbtf.c
> >> > index 7552d8e..2f12d53 100644
> >> > --- a/libbtf.c
> >> > +++ b/libbtf.c
> >> > @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename,=
 struct btf *btf)
> >> >                         goto unlink;
> >> >                 }
> >> >
> >> > +               snprintf(cmd, sizeof(cmd), "%s --set-section-alignme=
nt .BTF=3D16 %s",
> >> > +                        llvm_objcopy, filename);
> >>
> >> does it align inside the ELF file to 16 bytes, or does it request the
> >> linker to align it at 16 byte alignment in memory? Given .BTF section
> >> is not loadable, trying to understand the implications.
> >>
> >
> > We have a tool that loads BTF from ELF files. It uses mmap and "parses"=
 the BTF as structs in memory. The ELF file is mapped with page alignment b=
ut the BTF section within it has no alignment at all. Using MSAN (IIRC) we =
get warnings about misaligned accesses. Everything within BTF itself is nat=
urally aligned, so it makes sense to align the section within ELF as well. =
There are probably some architectures where this makes the difference betwe=
en working and SIGBUS.
> >
>
> Right, ok, thanks for explaining!
>
> > I did try to get objcopy to set alignment at the point the section is a=
dded. However, this didn't work.
> >
> >>
> >>
> >> > +               if (system(cmd)) {
> >>
> >> Also curious, if objcopy emits error (saying that
> >> --set-section-alignment argument is not recognized), will that error
> >> be shown in stdout? or system() consumes it without redirecting it to
> >> stdout?
> >>
> >
> > I believe it goes to stderr. I would need to check. system() will not c=
onsume this. I'm not keen to write stderr (or stdout) post-processing code =
in plain C.
> >
>
> You can use popen() to capture/hide output, this is a better
> alternative to system() in this case. We don't want "expected
> warnings" in kernel build process.
>
> >>
> >> > +                       /* non-fatal, this is a nice-to-have and it'=
s only supported from LLVM 10 */
> >> > +                       fprintf(stderr, "%s: warning: failed to alig=
n .BTF section in '%s': %d!\n",
> >> > +                               __func__, filename, errno);
> >>
> >> Probably better to emit this warning only in verbose mode, otherwise
> >> lots of people will start complaining that they get some new warnings
> >> from pahole.
> >>
> >
> > It may be better to just use POSIX and ELF APIs directly instead of obj=
copy. This way the section can be added with the right alignment directly. =
pahole is already linked against libelf and if we could get rid of the exte=
rnal dependency on objcopy it would be a win in more than one way.
>
> This would be great, yes. At some point I remember giving it a try,
> but for some reason I couldn't make libelf flush data and update
> section headers properly. Maybe you'll have better luck. Though I
> think I was trying to mark section loadable, and eventually I probably
> managed to do that, but still abandoned it (it's not enough to mark
> section loadable, you have to assign it to ELF segment as well, which
> libelf doesn't allow to do and you need linker support). Anyways, give
> it a try, it should work.
>

I found 341dfcf8d78eaa3a2dc96dea06f0392eb2978364 ("btf: expose BTF
info through sysfs") and I now see what you mean.

Alignment of .BTF as produced by the linker script is currently not
down to pahole at all. The kernel link script has to add .BTF in a
rather roundabout way because it needs to be added as a loadable
segment and pahole only adds it as a plain section.

pahole's does this using llvm-objcopy (which I spotted has some
side-effects on our AOSP vmlinux). On vanilla kernels, while
llvm-objcopy doesn't rewrite (or at least, resize) .strtab, it does
renumber sections so that the offset order is monotonic.

We're working with .BTF in userspace and haven't needed .BTF as a
segment. If I managed to get pahole to make .BTF a loadable segment as
well, then the linker scripts could be simplified. I'll see if I can
do this part as well.

Regards,
Giuliano.

> >
> >>
> >>
> >> > +               }
> >> > +
> >> >                 err =3D 0;
> >> >         unlink:
> >> >                 unlink(tmp_fn);
> >> > --
> >> > 2.30.0.284.gd98b1dd5eaa7-goog
> >> >
> >
> >
> > I'll see if I can spend a little time on this idea instead.
> >
> > Regards,
> > Giuliano.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
