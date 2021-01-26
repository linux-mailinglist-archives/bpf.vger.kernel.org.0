Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC723303C01
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405415AbhAZLrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405459AbhAZLoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 06:44:20 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE3C06174A
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 03:43:40 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id g5so5489051uak.10
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 03:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nmuOYHgkcffU1TmUUYyVFeq0dnR8xy//yZ8kcpFOSWw=;
        b=FXMEHez1nuU2WKkghPz5KxQKB3Mswraev40GRScQp+6g/tV58X1mkC0/ZSH/NPF63N
         6vhOEeSzqvqRd0Uc0m70lmUZ7+bycQV/QLdRXi4X+OVLkZd0gDaLj85GV2OyMwdpaYGw
         dOmRjJJvyuHE4oqfTTEbSlentdPnuOY7kAoOl9Y0qZGN1kG1HwYqB/V8q2V2hQVmfcbw
         yJ7YJoa/NHd2iGJNS7fhb/98kjz9TvJjYCLZS2UesERk2fNt+V0HnQVTOmpctM5+Vnqy
         xcZugMFVRa7qvCuDdsyef7DzSjiHftxWbfXC5ClfUum1hs2Y1FTNxoHo7nXLvI0CIxW4
         Xnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nmuOYHgkcffU1TmUUYyVFeq0dnR8xy//yZ8kcpFOSWw=;
        b=PeX8sYIaGzTSm5MFbfKE0gXQzi7d5uSrNz9jKrxrQq7b7QW326dePpuv6BV7+v0vG4
         T3TqZ1LES2xy2tzJsW9Rw1053tSDFafjJ2KdGGUSSsEyVZtMCKPDUt8rg3vxZUMk/9L8
         oevUaD81HRSx4PrwXb9gMwXy3MDxUzVsZgd5xDEOzu95BT+TruVpBZX2waj2YOZO8YJz
         zZjUznOsfYwh2hvFOwfwflOEq3B9+UKVX9WDclFfwDY6UXnlao1We/VgLFimtuiAMvxw
         Vm41gSZzJrM3ILrqHd4hxJqwg4acnzu55dJaLUC5rJe5tJHG+v5ln/gt0nFTm3GNXEB2
         Jv2A==
X-Gm-Message-State: AOAM533TeqotLP+doL5PLHDPTh6N/r1YFq2xNBK0nKwgWE17VMaZCAHC
        V15GjIhV2H+BRogSp2kTQ6HC2TP7Ne6BSS0XsolfIg==
X-Google-Smtp-Source: ABdhPJyNyFrPXz4k1TP7jc4XeGEanv0CXlPo6zOFZgnnnUE+23GpI18VEeBXV3WJQiXd0pGeNj5oKCBoIbiUeVutw94=
X-Received: by 2002:ab0:2549:: with SMTP id l9mr3602089uan.5.1611661419204;
 Tue, 26 Jan 2021 03:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
 <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
 <CAGvU0HmsoTSoPP=uJ679i2xH5k9o3iS=NCUyt2eVC63ShzVctw@mail.gmail.com> <CAEf4BzZPSEsKn6DiFwffTW81iFPVO329RAnA+bm0NPPiBqnqag@mail.gmail.com>
In-Reply-To: <CAEf4BzZPSEsKn6DiFwffTW81iFPVO329RAnA+bm0NPPiBqnqag@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 26 Jan 2021 11:43:01 +0000
Message-ID: <CAGvU0H=++8jWJQKg-BJoi1qxCJe=bzJqsYhRLwpwH51dXLO=Jw@mail.gmail.com>
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

Hi.

On Tue, 26 Jan 2021 at 00:28, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Mon, Jan 25, 2021 at 4:53 AM Giuliano Procida <gprocida@google.com> wr=
ote:
> >
> > Hi.
> >
> > On Thu, 21 Jan 2021 at 20:08, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 3:07 AM Giuliano Procida <gprocida@google.com=
> wrote:
> > > >
> > > > Hi.
> > > >
> > > > On Thu, 21 Jan 2021 at 07:16, Andrii Nakryiko <andrii.nakryiko@gmai=
l.com> wrote:
> > > >>
> > > >> On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.=
com> wrote:
> > > >> >
> > > >> > This is to avoid misaligned access when memory-mapping ELF secti=
ons.
> > > >> >
> > > >> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > >> > ---
> > > >> >  libbtf.c | 8 ++++++++
> > > >> >  1 file changed, 8 insertions(+)
> > > >> >
> > > >> > diff --git a/libbtf.c b/libbtf.c
> > > >> > index 7552d8e..2f12d53 100644
> > > >> > --- a/libbtf.c
> > > >> > +++ b/libbtf.c
> > > >> > @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filen=
ame, struct btf *btf)
> > > >> >                         goto unlink;
> > > >> >                 }
> > > >> >
> > > >> > +               snprintf(cmd, sizeof(cmd), "%s --set-section-ali=
gnment .BTF=3D16 %s",
> > > >> > +                        llvm_objcopy, filename);
> > > >>
> > > >> does it align inside the ELF file to 16 bytes, or does it request =
the
> > > >> linker to align it at 16 byte alignment in memory? Given .BTF sect=
ion
> > > >> is not loadable, trying to understand the implications.
> > > >>
> > > >
> > > > We have a tool that loads BTF from ELF files. It uses mmap and "par=
ses" the BTF as structs in memory. The ELF file is mapped with page alignme=
nt but the BTF section within it has no alignment at all. Using MSAN (IIRC)=
 we get warnings about misaligned accesses. Everything within BTF itself is=
 naturally aligned, so it makes sense to align the section within ELF as we=
ll. There are probably some architectures where this makes the difference b=
etween working and SIGBUS.
> > > >
> > >
> > > Right, ok, thanks for explaining!
> > >
> > > > I did try to get objcopy to set alignment at the point the section =
is added. However, this didn't work.
> > > >
> > > >>
> > > >>
> > > >> > +               if (system(cmd)) {
> > > >>
> > > >> Also curious, if objcopy emits error (saying that
> > > >> --set-section-alignment argument is not recognized), will that err=
or
> > > >> be shown in stdout? or system() consumes it without redirecting it=
 to
> > > >> stdout?
> > > >>
> > > >
> > > > I believe it goes to stderr. I would need to check. system() will n=
ot consume this. I'm not keen to write stderr (or stdout) post-processing c=
ode in plain C.
> > > >
> > >
> > > You can use popen() to capture/hide output, this is a better
> > > alternative to system() in this case. We don't want "expected
> > > warnings" in kernel build process.
> > >
> > > >>
> > > >> > +                       /* non-fatal, this is a nice-to-have and=
 it's only supported from LLVM 10 */
> > > >> > +                       fprintf(stderr, "%s: warning: failed to =
align .BTF section in '%s': %d!\n",
> > > >> > +                               __func__, filename, errno);
> > > >>
> > > >> Probably better to emit this warning only in verbose mode, otherwi=
se
> > > >> lots of people will start complaining that they get some new warni=
ngs
> > > >> from pahole.
> > > >>
> > > >
> > > > It may be better to just use POSIX and ELF APIs directly instead of=
 objcopy. This way the section can be added with the right alignment direct=
ly. pahole is already linked against libelf and if we could get rid of the =
external dependency on objcopy it would be a win in more than one way.
> > >
> > > This would be great, yes. At some point I remember giving it a try,
> > > but for some reason I couldn't make libelf flush data and update
> > > section headers properly. Maybe you'll have better luck. Though I
> > > think I was trying to mark section loadable, and eventually I probabl=
y
> > > managed to do that, but still abandoned it (it's not enough to mark
> > > section loadable, you have to assign it to ELF segment as well, which
> > > libelf doesn't allow to do and you need linker support). Anyways, giv=
e
> > > it a try, it should work.
> >
> > I struggled for a day and a bit and have got this (ELF_F_LAYOUT etc.)
> > working. There are some caveats:
> >
> > 1. Laying out only the new / updated sections can leave gaps.
> >
> > In practice, for vmlinux, it's a very small hole. To fix this, I'd
> > need to reposition .strtab as well as .BTF and .shstrtab.
> >
> > 2. vmlinux increases in size as llvm-objcopy was trimming down .strtab.
> >
> > I know very little about this, but I'd guess that the kernel linker
> > scripts are leaving strings in .strtab that are not referenced by
> > .symtab.
> >
> > I'll send a short series out for review soon.
>
> 1. Hm.. I realized I don't get why you need 16-byte alignment. Can you
> comment on why 8 doesn't work?
>

Sorry, 16 was a number that was guaranteed to work. However, after
looking in more detail, 8 seems fine too.

> 2. If you care about vmlinux BTF only, I think an easier way to ensure
> proper alignment is to adjust include/asm-generic/vmlinux.lds.h and
> add `. =3D ALIGN(8);` before .BTF (see how we ensure 4-byte alignment
> for .BTF_ids)
>

Firstly, while we do care mostly about vmlinux, we also care about
modules and even potentially plain userspace .o and .so files. In
terms of testing and development, working with simple objects is
simpler and faster.

Does the above mean vmlinux will always contain an empty .BTF, ready
to be populated?

If not, we and others may add .BTF with pahole -J and that's the code
I've been working on.

> If you have code ready to get rid of llvm-objcopy requirement for
> pahole, please still post, but we'll need to test it very thoroughly
> to ensure there are no regressions before landing in pahole.

It's stuck in a vger/kernel.org queue somewhere.

The updated vmlinux my code generates is I believe much closer to the
original vmlinux than what the existing code produces using
llvm-objcopy. But that's not necessarily a good thing.

Regards.

>
> >
> > Giuliano.
> >
> > >
> > > >
> > > >>
> > > >>
> > > >> > +               }
> > > >> > +
> > > >> >                 err =3D 0;
> > > >> >         unlink:
> > > >> >                 unlink(tmp_fn);
> > > >> > --
> > > >> > 2.30.0.284.gd98b1dd5eaa7-goog
> > > >> >
> > > >
> > > >
> > > > I'll see if I can spend a little time on this idea instead.
> > > >
> > > > Regards,
> > > > Giuliano.
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-team+unsubscribe@android.com.
> > >
