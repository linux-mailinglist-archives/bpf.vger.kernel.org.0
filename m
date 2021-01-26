Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20946303541
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbhAZFiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbhAZBuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 20:50:07 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA46C0617A9;
        Mon, 25 Jan 2021 16:28:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id b11so15100099ybj.9;
        Mon, 25 Jan 2021 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ND23aPy8zpGQ99qhXMXe1prkSdeC2noDocOwnTidYzU=;
        b=o/ythDK4DuFyaDDje0Lhh+YPdmJYIXXRWa5vD2ise5bX45vQV1ffUkh1Dq4GNneWaf
         OHiZ0HkGKP44jRoATWP6ESdo4h/ZEMOgAmhkdkWobnaeTRzI634BgqzmMY0cUJnO+SFy
         o24lD7VeuH6y5tmMJ+jq6KBuu9FMTUa24GvmyOXjAlaZQNR3j3suJPPZJ+0qjPIPxp+3
         Tjj4CG9Ij7/4uyyibZJT72tnuyRmbnovesKNmWaMwC1pviqo3BEGkbP7vcLkas12M3N/
         nML/Bzde8WNGe9vfke3wetnRI5rkY7DsC4/VgKsGyhUzlFFNWSMO36G92bbUW3z35A5N
         w1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ND23aPy8zpGQ99qhXMXe1prkSdeC2noDocOwnTidYzU=;
        b=FGg41glkCFSahlMTVmYnUkfGemj1p5gocNh8dapc2XFD7dxfjbJkrnvZxAuGhJeUg6
         QNiVZwPQ9ehPXYwKMoPfwSAtxlHIoMA11IrYQqz/N1eaONGEtvxWjaBKAeP/86ZbOKb4
         yJEN0/KaVXg9bxn71UCwgVFvbMb46LIxaTKpp+Q0etwCr+sjjTV112dQiYBJ2CQdAjVq
         ZnNZ+Bvo/6QL4+SHTLxue/GSXc1TV7gzhCfSaSU6w/tCWXVlkbOmOS8fm9Cg2wwP+txC
         Ho8VRlLTepbmtJwysv1p9nEBGONiVNfK+mJ9k2CmGyr03zbGOeuTmP6JqwwXlmBFoish
         G0ZA==
X-Gm-Message-State: AOAM533xm62zXkqVF8MR+uhjT6Xg7dKMTUyJ3PyJKipiaZ/B8SX+ZW92
        uCf7+G6698DyHGXhdBijJeDbLpkSgeDwBgYhLRA=
X-Google-Smtp-Source: ABdhPJxBC7znTdaYeDTd9iTlVEm0Wia5u7iSqG3qiL+UZjWU+vb7pIlvv9dGxFiGKCaH6oBZm9+67ffCkukK1b3/U7w=
X-Received: by 2002:a25:548:: with SMTP id 69mr4443197ybf.510.1611620904937;
 Mon, 25 Jan 2021 16:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
 <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com> <CAGvU0HmsoTSoPP=uJ679i2xH5k9o3iS=NCUyt2eVC63ShzVctw@mail.gmail.com>
In-Reply-To: <CAGvU0HmsoTSoPP=uJ679i2xH5k9o3iS=NCUyt2eVC63ShzVctw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Jan 2021 16:28:14 -0800
Message-ID: <CAEf4BzZPSEsKn6DiFwffTW81iFPVO329RAnA+bm0NPPiBqnqag@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
To:     Giuliano Procida <gprocida@google.com>
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

On Mon, Jan 25, 2021 at 4:53 AM Giuliano Procida <gprocida@google.com> wrot=
e:
>
> Hi.
>
> On Thu, 21 Jan 2021 at 20:08, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Thu, Jan 21, 2021 at 3:07 AM Giuliano Procida <gprocida@google.com> =
wrote:
> > >
> > > Hi.
> > >
> > > On Thu, 21 Jan 2021 at 07:16, Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
> > >>
> > >> On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.co=
m> wrote:
> > >> >
> > >> > This is to avoid misaligned access when memory-mapping ELF section=
s.
> > >> >
> > >> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > >> > ---
> > >> >  libbtf.c | 8 ++++++++
> > >> >  1 file changed, 8 insertions(+)
> > >> >
> > >> > diff --git a/libbtf.c b/libbtf.c
> > >> > index 7552d8e..2f12d53 100644
> > >> > --- a/libbtf.c
> > >> > +++ b/libbtf.c
> > >> > @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filenam=
e, struct btf *btf)
> > >> >                         goto unlink;
> > >> >                 }
> > >> >
> > >> > +               snprintf(cmd, sizeof(cmd), "%s --set-section-align=
ment .BTF=3D16 %s",
> > >> > +                        llvm_objcopy, filename);
> > >>
> > >> does it align inside the ELF file to 16 bytes, or does it request th=
e
> > >> linker to align it at 16 byte alignment in memory? Given .BTF sectio=
n
> > >> is not loadable, trying to understand the implications.
> > >>
> > >
> > > We have a tool that loads BTF from ELF files. It uses mmap and "parse=
s" the BTF as structs in memory. The ELF file is mapped with page alignment=
 but the BTF section within it has no alignment at all. Using MSAN (IIRC) w=
e get warnings about misaligned accesses. Everything within BTF itself is n=
aturally aligned, so it makes sense to align the section within ELF as well=
. There are probably some architectures where this makes the difference bet=
ween working and SIGBUS.
> > >
> >
> > Right, ok, thanks for explaining!
> >
> > > I did try to get objcopy to set alignment at the point the section is=
 added. However, this didn't work.
> > >
> > >>
> > >>
> > >> > +               if (system(cmd)) {
> > >>
> > >> Also curious, if objcopy emits error (saying that
> > >> --set-section-alignment argument is not recognized), will that error
> > >> be shown in stdout? or system() consumes it without redirecting it t=
o
> > >> stdout?
> > >>
> > >
> > > I believe it goes to stderr. I would need to check. system() will not=
 consume this. I'm not keen to write stderr (or stdout) post-processing cod=
e in plain C.
> > >
> >
> > You can use popen() to capture/hide output, this is a better
> > alternative to system() in this case. We don't want "expected
> > warnings" in kernel build process.
> >
> > >>
> > >> > +                       /* non-fatal, this is a nice-to-have and i=
t's only supported from LLVM 10 */
> > >> > +                       fprintf(stderr, "%s: warning: failed to al=
ign .BTF section in '%s': %d!\n",
> > >> > +                               __func__, filename, errno);
> > >>
> > >> Probably better to emit this warning only in verbose mode, otherwise
> > >> lots of people will start complaining that they get some new warning=
s
> > >> from pahole.
> > >>
> > >
> > > It may be better to just use POSIX and ELF APIs directly instead of o=
bjcopy. This way the section can be added with the right alignment directly=
. pahole is already linked against libelf and if we could get rid of the ex=
ternal dependency on objcopy it would be a win in more than one way.
> >
> > This would be great, yes. At some point I remember giving it a try,
> > but for some reason I couldn't make libelf flush data and update
> > section headers properly. Maybe you'll have better luck. Though I
> > think I was trying to mark section loadable, and eventually I probably
> > managed to do that, but still abandoned it (it's not enough to mark
> > section loadable, you have to assign it to ELF segment as well, which
> > libelf doesn't allow to do and you need linker support). Anyways, give
> > it a try, it should work.
>
> I struggled for a day and a bit and have got this (ELF_F_LAYOUT etc.)
> working. There are some caveats:
>
> 1. Laying out only the new / updated sections can leave gaps.
>
> In practice, for vmlinux, it's a very small hole. To fix this, I'd
> need to reposition .strtab as well as .BTF and .shstrtab.
>
> 2. vmlinux increases in size as llvm-objcopy was trimming down .strtab.
>
> I know very little about this, but I'd guess that the kernel linker
> scripts are leaving strings in .strtab that are not referenced by
> .symtab.
>
> I'll send a short series out for review soon.

1. Hm.. I realized I don't get why you need 16-byte alignment. Can you
comment on why 8 doesn't work?

2. If you care about vmlinux BTF only, I think an easier way to ensure
proper alignment is to adjust include/asm-generic/vmlinux.lds.h and
add `. =3D ALIGN(8);` before .BTF (see how we ensure 4-byte alignment
for .BTF_ids)

If you have code ready to get rid of llvm-objcopy requirement for
pahole, please still post, but we'll need to test it very thoroughly
to ensure there are no regressions before landing in pahole.

>
> Giuliano.
>
> >
> > >
> > >>
> > >>
> > >> > +               }
> > >> > +
> > >> >                 err =3D 0;
> > >> >         unlink:
> > >> >                 unlink(tmp_fn);
> > >> > --
> > >> > 2.30.0.284.gd98b1dd5eaa7-goog
> > >> >
> > >
> > >
> > > I'll see if I can spend a little time on this idea instead.
> > >
> > > Regards,
> > > Giuliano.
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
