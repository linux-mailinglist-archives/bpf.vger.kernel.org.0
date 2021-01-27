Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F0306486
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhA0T5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhA0T5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 14:57:06 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BDC06174A;
        Wed, 27 Jan 2021 11:56:26 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p185so3192730ybg.8;
        Wed, 27 Jan 2021 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BooiqxTZuM/IYjiINr8Zvl7W3ffi+Fqg2tyhmJddqFg=;
        b=jpJWuU4Wb1hADFJrfPgo8CtphuXV8iU3iEe1AS++5bhtkZpEZMn4VjQpxBCSU5v+TT
         qRkCd+Bv+u5Fe2INoif0QUrLY6RD8szYqhJOtPO82BXOvl53yS1f3n5xNu58j5koNLR3
         JduxU5IdcTDOt8vyFuNXlVVFxFOypaem5YxLgSog+CYH54mUhEovkm9pkOXDEhIZqbbS
         tGYzu1XgnWmp9RBhE9MxFbg0HhpvWr8Kz92+nEL33X1/TupAyu64YXu2YJEco5rrdWKu
         ea31HBisbXHi4GT7MaCfrRE69xVlBSi2pRB6lR6HD2of1gz3IRVCABgogS09rPTJ7muy
         g0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BooiqxTZuM/IYjiINr8Zvl7W3ffi+Fqg2tyhmJddqFg=;
        b=nncdY9ETeDDJvR7sUVyN/O/M85x/bTvnQiOjhm/9y5yW3fr5TZD/p0Du9fE5gv340M
         dRqHk7j79eiZkjZATd6JXoxN00dj2WCbICgTkLDYh256+vUwNynF0H82THzJcfJjwwxa
         EC3Cbxoh56B1NzBJhOwi9MGcgoDzNAb7f9Y93tObY7Rnrt/NZEVsjHIxQzaduhC1GhIr
         2GXF9/krVsrwg7xg1YU6CRfnNk2je7ZcSzHBhWnXCyVk1n0RpbpwUqxB1HCnpApa664J
         D2xrzbCBwGdLDCJvy6z72kzuwMDEkZAXC7wHrclD+Ygi/CwgLVHK+T78x6Y4GHp1aDXA
         Wk9g==
X-Gm-Message-State: AOAM531PtLYy1YWliCWcLkAt0lYFVZx3ZHkYCgUT48lkVXx78h3q7ERE
        Z+rs0SoqiGwvcVO2yBlT6YLEvQzJRoQHoKMW+NE=
X-Google-Smtp-Source: ABdhPJwTu3FXqKkxbkVNmIoJDiDAsaElVTzsgwVqMTlSNziONTEwv8IGpzNZ4NQvpGb1wHl2LNQZIAjCCxPMGavZEGM=
X-Received: by 2002:a25:9882:: with SMTP id l2mr17815640ybo.425.1611777385518;
 Wed, 27 Jan 2021 11:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
 <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
 <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
 <CAGvU0HkuZ_AW_YTjsdsivWV+wF3kf49ugChzMdRjZnrYzwVB3A@mail.gmail.com> <CAGvU0H=bNJ6QScpsxQWiijCqvqVhBoHctOhN8nZ8vt9CwpA6tQ@mail.gmail.com>
In-Reply-To: <CAGvU0H=bNJ6QScpsxQWiijCqvqVhBoHctOhN8nZ8vt9CwpA6tQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 11:56:14 -0800
Message-ID: <CAEf4BzZRPz9A3knMe7_n9enDpK-FFEOjRRCydxQiuhKWxi-X3Q@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 10:07 AM Giuliano Procida <gprocida@google.com> wro=
te:
>
> Hi.
>
> On Wed, 27 Jan 2021 at 15:08, Giuliano Procida <gprocida@google.com> wrot=
e:
> >
> > Hi Andrii.
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
> > >
> >
> > I found 341dfcf8d78eaa3a2dc96dea06f0392eb2978364 ("btf: expose BTF
> > info through sysfs") and I now see what you mean.
> >
> > Alignment of .BTF as produced by the linker script is currently not
> > down to pahole at all. The kernel link script has to add .BTF in a
> > rather roundabout way because it needs to be added as a loadable
> > segment and pahole only adds it as a plain section.
> >
> > pahole's does this using llvm-objcopy (which I spotted has some
> > side-effects on our AOSP vmlinux). On vanilla kernels, while
> > llvm-objcopy doesn't rewrite (or at least, resize) .strtab, it does
> > renumber sections so that the offset order is monotonic.
> >
> > We're working with .BTF in userspace and haven't needed .BTF as a
> > segment. If I managed to get pahole to make .BTF a loadable segment as
> > well, then the linker scripts could be simplified. I'll see if I can
> > do this part as well.
>
> OK...
>
> $ readelf -lW /tmp/vmlinux
>
> Elf file type is EXEC (Executable file)
> Entry point 0x1000000
> There are 5 program headers, starting at offset 64
>
> Program Headers:
>   Type           Offset   VirtAddr           PhysAddr
> FileSiz  MemSiz   Flg Align
>   LOAD           0x200000 0xffffffff81000000 0x0000000001000000
> 0x167be37 0x167be37 R E 0x200000
>   LOAD           0x1a00000 0xffffffff82800000 0x0000000002800000
> 0x5a6000 0x5a6000 RW  0x200000
>   LOAD           0x2000000 0x0000000000000000 0x0000000002da6000
> 0x02a258 0x02a258 RW  0x200000
>   LOAD           0x21d1000 0xffffffff82dd1000 0x0000000002dd1000
> 0x104000 0x25b000 RWE 0x200000
>   NOTE           0x152ac30 0xffffffff8232ac30 0x000000000232ac30
> 0x00003c 0x00003c     0x4
>
>  Section to Segment mapping:
>   Segment Sections...
>    00     .text .rodata .pci_fixup .tracedata __ksymtab __ksymtab_gpl
> __ksymtab_strings __param __modver __ex_table .notes .BTF
>    01     .data __bug_table .orc_unwind_ip .orc_unwind .orc_lookup .vvar
>    02     .data..percpu
>    03     .init.text .altinstr_aux .init.data .x86_cpu_dev.init
> .altinstructions .altinstr_replacement .iommu_table .apicdrivers
> .exit.text .smp_locks .data_nosave .bss .brk
>    04     .notes
>
> This is the end result. The sausage factory (gen_btf / vmlinux_link -
> which I've now read through) actually does:
>
> * link a temporary vmlinux
> * run pahole -J on this
> * dump out the .BTF as a raw file (anything clever pahole does with
> ELF is thrown away here)
> * create an ELF file with arch and format to match vmlinux, containing
> a single .BTF section
> * link this ELF file with the other bits of the kernel.
>
> As a DWARF to BTF converter, pahole's role is clear. At this point I'd
> like to separate what's useful for the kernel and what's useful in
> terms of generally packaging up .BTF as a kind of debug information
> for general use.
>
> Packaging up BTF as an ELF section or linking this into the kernel is
> a lot of work to do properly in pahole and duplicates the role of the
> linker. If I continue, I'll probably end up creating a disjoint R
> segment just for .BTF and I don't know if that's OK. I'm not sure how
> much more work is needed to get to the point where all the various
> objcopy/objdump can be eliminated or whether this is a worthwhile
> goal. Another way of getting rid of the objcopy/objdump dependencies
> for the kernel would be to just emit an ELF file containing the .BTF
> section only and let the linker do its thing.
>
> For non-kernel use, I'm not sure of the implications of letting libelf
> reorder all the sections, or if we'd ever want the .BTF to be in a
> loadable segment. If anything, I'd advocate for having pahole just
> generate raw BTF output. However, I know there's a big convenience
> factor in having debug (type) info packaged into the ELF.

At this point I don't think pahole can mark .BTF as loadable, at best
it should be an opt-in. Order of .BTF section relative to others
shouldn't matter, though. I, honestly, lost track of what's the latest
status of your work, but if it's dangerous to do with libelf, I'd use
llvm-objcopy, but would do better detection of
--set-section-alignment.

>
> So I'm not sure if it's worth pursuing the line of work beyond
> eliminating pahole's dependency on llvm-objcopy. In terms of my
> follow-up series, this might mean dropping 3/4 (as preserving existing
> ELF layout in the temporary vmlinux isn't needed) but keeping 4/4 (as
> it's useful to us, even if it's currently useless for the kernel).

Right, I'm not aware of any other use case beyond vmlinux and kernel
modules where BTF has to be in a loadable section.

>
> If we cannot get libelf to make the right kind of sausage, then I
> agree that vmlinux .BTF alignment should probably follow your earlier
> suggestion of `. =3D ALIGN(8)` in vmlinux.lds.h.

this can be done independent of all the other decisions, IMO

>
> And we haven't even got to discussing modules and merging .BTF info. :-)

that shouldn't matter at all, in the end it's a single .BTF blob that
needs to be put into ELF

>
> Regards,
> Giuliano.
>
>
> > Regards,
> > Giuliano.
> >
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
