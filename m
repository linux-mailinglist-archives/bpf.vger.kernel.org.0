Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F038D306302
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 19:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhA0SHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhA0SHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 13:07:46 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76257C06174A
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 10:07:06 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id v19so1604376vsf.9
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqU3SVTs41QnYhQTyLtFIkjNA6jv04Ow5LwKWbmjGo8=;
        b=vKf76odHTiOEKU/8lplOvjX662IVxUA3wySTZy3rlQ5KYKq1JY4On4hzgXbaVzesT5
         sZFr3hWupgS/AjDwguWZMP/2TUDTI15+oI/dDzPCNoUuzr89fhDkMRDwWdBSHSzZ5gYh
         c0P5LZwIsTltqz2rjMJrHF6hXwnlQYlynxsfrcmKbn10r1l77Q5bncLY2NW50idHaX6g
         J4XzNGwQFgTLNome7XbA6tN/b3wilXeWtBxFtAyMx77BwxR2WDHEHtk3KrYpFmueWDyW
         p4fvA29RxJDDWwOe5dgnRwmXThv7OMdeEDeH6Lz+/T2JQgqcxzwOoK5S65JEIW0btf64
         1cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqU3SVTs41QnYhQTyLtFIkjNA6jv04Ow5LwKWbmjGo8=;
        b=hX7Vx6FMwTP1EE7JXUU8uv2VCY+SGufjRpyrdCt6YfYy6WRFId3ZJVuYTT+Yna6QoA
         g2xMtxRYoKL+9Bn+sPLPrKX9Felwi8B1QkNZNsx6JvsusTBY5PgkVOxi8jMrubCBRYMK
         FuRFmEIcEXZ26xd0rWhaFkxiW7Cg2Y8Z4rt2jwYkWw6v368alsqVbvHa+AErR8/UBE3/
         3enZmDEDEZcMDizSgxpMeE7TS3/0fj5+huioqJELzs/oPpFH8+WSHrtHdLSDLtXV7tl/
         68P/V8jwcoGmhI/1M/pHV5W6IN7tEW3lW072xtSx/Vo7NQeLvLH5p0KnO2WQgQ1tScbx
         sKuA==
X-Gm-Message-State: AOAM531t59r9zs/eeP7kPOfL/vdKdzLnGAM7qUInMXfRjlunzq9SUbZX
        /wy9JNPNT0WzTZqgwPjoEwEbFCi9NNW/f9tpReleLA==
X-Google-Smtp-Source: ABdhPJwmvsn0S2UFVMjn+TFeFUpGYa7RzoBuiddcX57u7gOkYqkyjQ6kgfITMxtMQwt8SPWk+6YeR+mTQmw4U3vB0fs=
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr9469792vsc.4.1611770825269;
 Wed, 27 Jan 2021 10:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
 <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com> <CAGvU0HkuZ_AW_YTjsdsivWV+wF3kf49ugChzMdRjZnrYzwVB3A@mail.gmail.com>
In-Reply-To: <CAGvU0HkuZ_AW_YTjsdsivWV+wF3kf49ugChzMdRjZnrYzwVB3A@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Wed, 27 Jan 2021 18:06:27 +0000
Message-ID: <CAGvU0H=bNJ6QScpsxQWiijCqvqVhBoHctOhN8nZ8vt9CwpA6tQ@mail.gmail.com>
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

On Wed, 27 Jan 2021 at 15:08, Giuliano Procida <gprocida@google.com> wrote:
>
> Hi Andrii.
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
> >
>
> I found 341dfcf8d78eaa3a2dc96dea06f0392eb2978364 ("btf: expose BTF
> info through sysfs") and I now see what you mean.
>
> Alignment of .BTF as produced by the linker script is currently not
> down to pahole at all. The kernel link script has to add .BTF in a
> rather roundabout way because it needs to be added as a loadable
> segment and pahole only adds it as a plain section.
>
> pahole's does this using llvm-objcopy (which I spotted has some
> side-effects on our AOSP vmlinux). On vanilla kernels, while
> llvm-objcopy doesn't rewrite (or at least, resize) .strtab, it does
> renumber sections so that the offset order is monotonic.
>
> We're working with .BTF in userspace and haven't needed .BTF as a
> segment. If I managed to get pahole to make .BTF a loadable segment as
> well, then the linker scripts could be simplified. I'll see if I can
> do this part as well.

OK...

$ readelf -lW /tmp/vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x1000000
There are 5 program headers, starting at offset 64

Program Headers:
  Type           Offset   VirtAddr           PhysAddr
FileSiz  MemSiz   Flg Align
  LOAD           0x200000 0xffffffff81000000 0x0000000001000000
0x167be37 0x167be37 R E 0x200000
  LOAD           0x1a00000 0xffffffff82800000 0x0000000002800000
0x5a6000 0x5a6000 RW  0x200000
  LOAD           0x2000000 0x0000000000000000 0x0000000002da6000
0x02a258 0x02a258 RW  0x200000
  LOAD           0x21d1000 0xffffffff82dd1000 0x0000000002dd1000
0x104000 0x25b000 RWE 0x200000
  NOTE           0x152ac30 0xffffffff8232ac30 0x000000000232ac30
0x00003c 0x00003c     0x4

 Section to Segment mapping:
  Segment Sections...
   00     .text .rodata .pci_fixup .tracedata __ksymtab __ksymtab_gpl
__ksymtab_strings __param __modver __ex_table .notes .BTF
   01     .data __bug_table .orc_unwind_ip .orc_unwind .orc_lookup .vvar
   02     .data..percpu
   03     .init.text .altinstr_aux .init.data .x86_cpu_dev.init
.altinstructions .altinstr_replacement .iommu_table .apicdrivers
.exit.text .smp_locks .data_nosave .bss .brk
   04     .notes

This is the end result. The sausage factory (gen_btf / vmlinux_link -
which I've now read through) actually does:

* link a temporary vmlinux
* run pahole -J on this
* dump out the .BTF as a raw file (anything clever pahole does with
ELF is thrown away here)
* create an ELF file with arch and format to match vmlinux, containing
a single .BTF section
* link this ELF file with the other bits of the kernel.

As a DWARF to BTF converter, pahole's role is clear. At this point I'd
like to separate what's useful for the kernel and what's useful in
terms of generally packaging up .BTF as a kind of debug information
for general use.

Packaging up BTF as an ELF section or linking this into the kernel is
a lot of work to do properly in pahole and duplicates the role of the
linker. If I continue, I'll probably end up creating a disjoint R
segment just for .BTF and I don't know if that's OK. I'm not sure how
much more work is needed to get to the point where all the various
objcopy/objdump can be eliminated or whether this is a worthwhile
goal. Another way of getting rid of the objcopy/objdump dependencies
for the kernel would be to just emit an ELF file containing the .BTF
section only and let the linker do its thing.

For non-kernel use, I'm not sure of the implications of letting libelf
reorder all the sections, or if we'd ever want the .BTF to be in a
loadable segment. If anything, I'd advocate for having pahole just
generate raw BTF output. However, I know there's a big convenience
factor in having debug (type) info packaged into the ELF.

So I'm not sure if it's worth pursuing the line of work beyond
eliminating pahole's dependency on llvm-objcopy. In terms of my
follow-up series, this might mean dropping 3/4 (as preserving existing
ELF layout in the temporary vmlinux isn't needed) but keeping 4/4 (as
it's useful to us, even if it's currently useless for the kernel).

If we cannot get libelf to make the right kind of sausage, then I
agree that vmlinux .BTF alignment should probably follow your earlier
suggestion of `. =3D ALIGN(8)` in vmlinux.lds.h.

And we haven't even got to discussing modules and merging .BTF info. :-)

Regards,
Giuliano.


> Regards,
> Giuliano.
>
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
