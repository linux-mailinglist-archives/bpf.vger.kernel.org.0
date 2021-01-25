Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B863302535
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 14:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbhAYM4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 07:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbhAYMyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 07:54:36 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82410C06174A
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 04:53:54 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id m25so1759401vkk.6
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Axap6NCiq5XBgCk4p9bNwKVuQL6Jpya7zeTo4+Oo+k4=;
        b=Fcm1rglPsZkUHdzqu88sNVHBYxu30GoPy+oeLZBYrmCpPuv9aLNb37rzt+UZuq3nrn
         n5e2JsHvf9P96jFkFLYOXLDTgRyW7Bg4dXbi8JTS/TYE6cU/uYDxPFaVmGwr5OkukXRF
         Qs7EjJ40qsS2Hoeq5YX6v8SyYy2jlaEWGzzXZ7ocsmeN2XvWde8Zi/iAMr1IcMf4Qro1
         VuW+SiEEjn6bL7kJ18fJj4tw3n89e3NuUIqVOKOeVoNeaqS5EPWG+yUNIVsKHVYDBSEs
         +n6kN23Aav0yKx+R0TSD8eu2iWNqAnfzAKvUWr/bJS5nDP4wUz4+d0AHtMaPjfUDUyGU
         F9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Axap6NCiq5XBgCk4p9bNwKVuQL6Jpya7zeTo4+Oo+k4=;
        b=mIEuZVxWOVmvg5VT37B1J4HNI08f9pcSBE50XsKESzAdyBittWDaeeTrHe0+yrtQWb
         RPjvvH7oevvPfl8x3SDYqsexrparmOVMj1Vo79iUvL12lXgQvGi2oKE7MeUcPgyLbs7Q
         Vk6/am5mD69ZUptGHk26R0GYfx1xj4TPnFK+a85vElTunVOcyr8W+eDin05rwBMi0KOM
         FbewFLGh6vQrtG2eh6eo+5Izaf3wptmJbJ4EZ4GZ8cOHJztLJKWtgWGEfyumn64bGFxY
         b374JqV6C8cTPlz/O9zbtiYWV7r9xL62Y1P/YNrx7guyRT2Wi6mSIZJQiEC4Qih3dQMo
         w/Xw==
X-Gm-Message-State: AOAM5309OauSNY7ov8grIMlEqt5wXSMr4oAAkhgtdtVGQmITGV1ynJW5
        cifPpprIs9ACVzFSaW4iapg5NYewAPge362TVK/V1A==
X-Google-Smtp-Source: ABdhPJy5U78QxbteNJ+h0p+7a50sUr+JS79ov4wjs5aIS7CxfEgvaTnqeXb3bnoXQSdy7NRjVELUR4Ln6r+NS2TbmqM=
X-Received: by 2002:a1f:a643:: with SMTP id p64mr185980vke.15.1611579233303;
 Mon, 25 Jan 2021 04:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com> <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
In-Reply-To: <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Mon, 25 Jan 2021 12:53:16 +0000
Message-ID: <CAGvU0HmsoTSoPP=uJ679i2xH5k9o3iS=NCUyt2eVC63ShzVctw@mail.gmail.com>
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

I struggled for a day and a bit and have got this (ELF_F_LAYOUT etc.)
working. There are some caveats:

1. Laying out only the new / updated sections can leave gaps.

In practice, for vmlinux, it's a very small hole. To fix this, I'd
need to reposition .strtab as well as .BTF and .shstrtab.

2. vmlinux increases in size as llvm-objcopy was trimming down .strtab.

I know very little about this, but I'd guess that the kernel linker
scripts are leaving strings in .strtab that are not referenced by
.symtab.

I'll send a short series out for review soon.

Giuliano.

>
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
