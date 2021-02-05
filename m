Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EC311167
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhBESAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 13:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhBER4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 12:56:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBAFC061756;
        Fri,  5 Feb 2021 11:38:15 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id o7so2355074ils.2;
        Fri, 05 Feb 2021 11:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mwLxkFVe03MmkYCBahpI6SDm01fTcoo2tni0W+8JeQM=;
        b=H0iLDSiQ8Iwg935LoplXA3JbMGkpM7Bklp5o2oHgXxTIMnvSg4fBSEtd0kEZNEsNVC
         0zKkH/m4lXBAVubqaQce0i/K6nDjcOt7MNZHC6ZzjMiZSeKe3Y7RnMnKnyuuO7xF9vn3
         QsXOALugo1iicDU0ZqzEMIaA4Oqz/nUBxSJ3JrJtcXKDXxsS87eD/5MnOVT+g4zCXCiu
         +pCH7yVdWFFj3dMEVJ+PserRZv3MU7aLrpRG+TVO2WeqsK3M1nXicWcR4+Z/zhOL1+Nz
         m7p2LHnsWA1JD8wlyCddFfAgsmwUIGYxql9KWnghHb1p787TY1S3ptg45pKCfIV0qMZa
         m+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mwLxkFVe03MmkYCBahpI6SDm01fTcoo2tni0W+8JeQM=;
        b=cDOlYLF2LHROQieUzb6ZP3tyzcH9uVvwVT9XrpIPdI6C3E024kd9e/nkF/Mc6fXW7c
         mAJP9MIL5+53TdJK2GxPjoSVtjckbSWVYXOHwR1O75ezZgHDWh+FGA/nDReAD3JG0qNO
         9ogMUvnRaXbSuBzXz4W0tfWUrS7sz4kkPK+8Vlbr1vJEhWQ4wkiozcO0zhi8JGUIRfqS
         FGde2IHdAHELLqMOgpHY2T55EfgMgzugUXV4t9BAU+cGq15JJH4cgcW3Oo9KbVAwtqk4
         asdrYltSLo8JzPOO2q+DUxQ8jTqBpMDqSplj6SOF1S5j9UafbtTrpAep/JxqyoE5Ji6h
         7MtQ==
X-Gm-Message-State: AOAM533oy8o4VgvOE0YmjnS7U9Pl8BwBfPUlAwWzXIpJ0pcUN94rBdeS
        3GWU+ipTVmshfDlh3sjtoqLaDqh5ihgMAaXz8ws=
X-Google-Smtp-Source: ABdhPJw57shqvvmx+O7lrnu6U36RfiPujtlnSJdMtudr7FP3riZyQecDvbV53UaagO+sOq0er0baxkNymqLSrNi2WK0=
X-Received: by 2002:a92:58ce:: with SMTP id z75mr5430151ilf.209.1612553895279;
 Fri, 05 Feb 2021 11:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <CA+icZUWESAQxWb6fvhOY0CxngLY3z4kOiZS2vPtSD5tDaSve-g@mail.gmail.com>
 <CA+icZUVGXxEGy7KYqHvw-iSb1HqDNzjXwAn=VEJaAbTjLCKDFQ@mail.gmail.com> <CAFP8O3KA6uR5Q29UGXqxahHmfn6V6GSeKzCsBiD3838WEAGO3Q@mail.gmail.com>
In-Reply-To: <CAFP8O3KA6uR5Q29UGXqxahHmfn6V6GSeKzCsBiD3838WEAGO3Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 20:38:04 +0100
Message-ID: <CA+icZUVBHJ2eTxtt_3uCd=b4_i7WgJm5p2KpPvo=3AMd606w2g@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 8:30 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google=
.com> wrote:
>
> On Fri, Feb 5, 2021 at 11:21 AM Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> >
> > On Fri, Feb 5, 2021 at 8:15 PM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> > >
> > > On Fri, Feb 5, 2021 at 8:10 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2/5/21 11:06 AM, Sedat Dilek wrote:
> > > > > On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
> > > > >>
> > > > >> On Fri, Feb 5, 2021 at 6:48 PM Sedat Dilek <sedat.dilek@gmail.co=
m> wrote:
> > > > >>>
> > > > >>> On Fri, Feb 5, 2021 at 4:28 PM Arnaldo Carvalho de Melo
> > > > >>> <arnaldo.melo@gmail.com> wrote:
> > > > >>>>
> > > > >>>> Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu=
:
> > > > >>>>> On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail=
.com> wrote:
> > > > >>>>>>
> > > > >>>>>> On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmai=
l.com> wrote:
> > > > >>>>>>>
> > > > >>>>>>> Hi,
> > > > >>>>>>>
> > > > >>>>>>> when building with pahole v1.20 and binutils v2.35.2 plus C=
lang
> > > > >>>>>>> v12.0.0-rc1 and DWARF-v5 I see:
> > > > >>>>>>> ...
> > > > >>>>>>> + info BTF .btf.vmlinux.bin.o
> > > > >>>>>>> + [  !=3D silent_ ]
> > > > >>>>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > > > >>>>>>>   BTF     .btf.vmlinux.bin.o
> > > > >>>>>>> + LLVM_OBJCOPY=3D/opt/binutils/bin/objcopy /opt/pahole/bin/=
pahole -J
> > > > >>>>>>> .tmp_vmlinux.btf
> > > > >>>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > > > >>>>>>> Encountered error while encoding BTF.
> > > > >>>>>>
> > > > >>>>>> Grepping the pahole sources:
> > > > >>>>>>
> > > > >>>>>> $ git grep DW_ATE
> > > > >>>>>> dwarf_loader.c:         bt->is_bool =3D encoding =3D=3D DW_A=
TE_boolean;
> > > > >>>>>> dwarf_loader.c:         bt->is_signed =3D encoding =3D=3D DW=
_ATE_signed;
> > > > >>>>>>
> > > > >>>>>> Missing DW_ATE_unsigned encoding?
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> Checked the LLVM sources:
> > > > >>>>>
> > > > >>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =3D
> > > > >>>>> llvm::dwarf::DW_ATE_unsigned_char;
> > > > >>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =3D llvm::dwar=
f::DW_ATE_unsigned;
> > > > >>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =3D
> > > > >>>>> llvm::dwarf::DW_ATE_unsigned_fixed;
> > > > >>>>> clang/lib/CodeGen/CGDebugInfo.cpp:
> > > > >>>>>    ? llvm::dwarf::DW_ATE_unsigned
> > > > >>>>> ...
> > > > >>>>> lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT=
_encoding
> > > > >>>>>   (DW_ATE_unsigned)
> > > > >>>>>
> > > > >>>>> So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.
> > > > >>>>
> > > > >>>> Thanks for the research, probably your conclusion is correct, =
can you go
> > > > >>>> the next step and add that part and check if the end result is=
 the
> > > > >>>> expected one?
> > > > >>>>
> > > > >>>
> > > > >>> Still building...
> > > > >>>
> > > > >>> Can you give me a hand on what has to be changed in dwarves/pah=
ole?
> > > > >>>
> > > > >>> I guess switching from ld.bfd to ld.lld will show the same ERRO=
R.
> > > > >>>
> > > > >>
> > > > >> This builds successfully - untested:
> > > > >>
> > > > >> $ git diff
> > > > >> diff --git a/btf_loader.c b/btf_loader.c
> > > > >> index ec286f413f36..a39edd3362db 100644
> > > > >> --- a/btf_loader.c
> > > > >> +++ b/btf_loader.c
> > > > >> @@ -107,6 +107,7 @@ static struct base_type *base_type__new(stri=
ngs_t
> > > > >> name, uint32_t attrs,
> > > > >>                 bt->bit_size =3D size;
> > > > >>                 bt->is_signed =3D attrs & BTF_INT_SIGNED;
> > > > >>                 bt->is_bool =3D attrs & BTF_INT_BOOL;
> > > > >> +               bt->is_unsigned =3D attrs & BTF_INT_UNSIGNED;
> > > > >>                 bt->name_has_encoding =3D false;
> > > > >>                 bt->float_type =3D float_type;
> > > > >>         }
> > > > >> diff --git a/ctf.h b/ctf.h
> > > > >> index 25b79892bde3..9e47c3c74677 100644
> > > > >> --- a/ctf.h
> > > > >> +++ b/ctf.h
> > > > >> @@ -100,6 +100,7 @@ struct ctf_full_type {
> > > > >> #define CTF_TYPE_INT_CHAR      0x2
> > > > >> #define CTF_TYPE_INT_BOOL      0x4
> > > > >> #define CTF_TYPE_INT_VARARGS   0x8
> > > > >> +#define CTF_TYPE_INT_UNSIGNED  0x16
> > > > >>
> > > > >> #define CTF_TYPE_FP_ATTRS(VAL)         ((VAL) >> 24)
> > > > >> #define CTF_TYPE_FP_OFFSET(VAL)                (((VAL) >> 16) & =
0xff)
> > > > >> diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > >> index b73d7867e1e6..79d40f183c24 100644
> > > > >> --- a/dwarf_loader.c
> > > > >> +++ b/dwarf_loader.c
> > > > >> @@ -473,6 +473,7 @@ static struct base_type *base_type__new(Dwar=
f_Die
> > > > >> *die, struct cu *cu)
> > > > >>                 bt->is_bool =3D encoding =3D=3D DW_ATE_boolean;
> > > > >>                 bt->is_signed =3D encoding =3D=3D DW_ATE_signed;
> > > > >>                 bt->is_varargs =3D false;
> > > > >> +               bt->is_unsigned =3D encoding =3D=3D DW_ATE_unsig=
ned;
> > > > >>                 bt->name_has_encoding =3D true;
> > > > >>         }
> > > > >>
> > > > >> diff --git a/dwarves.h b/dwarves.h
> > > > >> index 98caf1abc54d..edf32d2e6f80 100644
> > > > >> --- a/dwarves.h
> > > > >> +++ b/dwarves.h
> > > > >> @@ -1261,6 +1261,7 @@ struct base_type {
> > > > >>         uint8_t         is_signed:1;
> > > > >>         uint8_t         is_bool:1;
> > > > >>         uint8_t         is_varargs:1;
> > > > >> +       uint8_t         is_unsigned:1;
> > > > >>         uint8_t         float_type:4;
> > > > >> };
> > > > >>
> > > > >> diff --git a/lib/bpf b/lib/bpf
> > > > >> --- a/lib/bpf
> > > > >> +++ b/lib/bpf
> > > > >> @@ -1 +1 @@
> > > > >> -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
> > > > >> +Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396-dirt=
y
> > > > >> diff --git a/libbtf.c b/libbtf.c
> > > > >> index 9f7628304495..a0661a7bbed9 100644
> > > > >> --- a/libbtf.c
> > > > >> +++ b/libbtf.c
> > > > >> @@ -247,6 +247,8 @@ static const char *
> > > > >> btf_elf__int_encoding_str(uint8_t encoding)
> > > > >>                 return "CHAR";
> > > > >>         else if (encoding =3D=3D BTF_INT_BOOL)
> > > > >>                 return "BOOL";
> > > > >> +       else if (encoding =3D=3D BTF_INT_UNSIGNED)
> > > > >> +               return "UNSIGNED";
> > > > >>         else
> > > > >>                 return "UNKN";
> > > > >> }
> > > > >> @@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_el=
f
> > > > >> *btfe, const struct base_type *bt,
> > > > >>                 encoding =3D BTF_INT_SIGNED;
> > > > >>         } else if (bt->is_bool) {
> > > > >>                 encoding =3D BTF_INT_BOOL;
> > > > >> +       } else if (bt->is_unsigned) {
> > > > >> +               encoding =3D BTF_INT_UNSIGNED;
> > > > >>         } else if (bt->float_type) {
> > > > >>                 fprintf(stderr, "float_type is not supported\n")=
;
> > > > >>                 return -1;
> > > > >>
> > > > >> Additionally - I cannot see it with `git diff`:
> > > > >>
> > > > >> [ lib/bpf/include/uapi/linux/btf.h ]
> > > > >>
> > > > >> /* Attributes stored in the BTF_INT_ENCODING */
> > > > >> #define BTF_INT_SIGNED (1 << 0)
> > > > >> #define BTF_INT_CHAR (1 << 1)
> > > > >> #define BTF_INT_BOOL (1 << 2)
> > > > >> #define BTF_INT_UNSIGNED (1 << 3)
> > > > >>
> > > > >> Comments?
> > > > >>
> > > > >
> > > > > Hmmm...
> > > > >
> > > > > + info BTF .btf.vmlinux.bin.o
> > > > > + [  !=3D silent_ ]
> > > > > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > > > >   BTF     .btf.vmlinux.bin.o
> > > > > + LLVM_OBJCOPY=3Dllvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmli=
nux.btf
> > > > > [2] INT long unsigned int Error emitting BTF type
> > > > > Encountered error while encoding BTF.
> > > > > + llvm-objcopy --only-section=3D.BTF --set-section-flags
> > > > > .BTF=3Dalloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.b=
in.o
> > > > > ...
> > > > > + info BTFIDS vmlinux
> > > > > + [  !=3D silent_ ]
> > > > > + printf   %-7s %s\n BTFIDS vmlinux
> > > > >   BTFIDS  vmlinux
> > > > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > FAILED: load BTF from vmlinux: Invalid argument
> > > > > + on_exit
> > > > > + [ 255 -ne 0 ]
> > > > > + cleanup
> > > > > + rm -f .btf.vmlinux.bin.o
> > > > > + rm -f .tmp_System.map
> > > > > + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
> > > > > .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
> > > > > .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kall=
syms
> > > > > 2.o
> > > > > + rm -f System.map
> > > > > + rm -f vmlinux
> > > > > + rm -f vmlinux.o
> > > > > make[3]: *** [Makefile:1166: vmlinux] Error 255
> > > > >
> > > > > Grepping through linux.git/tools I guess some BTF tools/libs need=
 to
> > > > > know what BTF_INT_UNSIGNED is?
> > > >
> > > > BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> > > > ignore this for now until kernel infrastructure is ready.
> > > > Not sure whether this information will be useful or not
> > > > for BTF. This needs to be discussed separately.
> > > >
> > >
> > > [ CC Fangrui ]
> > >
> > > How can I teach pahole to ignore BTF_INT_UNSIGNED?
> > >
> > > Another tryout might be to use "-fbinutils-version=3D..." which is
> > > available for LLVM-12 according to Fangrui?
> > > Fangrui, which binutils versions can I pass and how?
> > >
> >
> > OK, I checked LLVM-12 sources:
> >
> > clang/docs/ReleaseNotes.rst:101:- New option ``-fbinutils-version=3D``
> > specifies the targeted binutils version.
> > clang/docs/ReleaseNotes.rst:102:  For example,
> > ``-fbinutils-version=3D2.35`` means compatibility with GNU as/ld
> > clang/docs/ReleaseNotes.rst-103-  before 2.35 is not needed: new
> > features can be used and there is no need to
> > clang/docs/ReleaseNotes.rst-104-  work around old GNU as/ld bugs.
> >
> > Can I pass (also patchlevel) like 2.35.2?
> > Here I have Debian's v2.35.1 and a selfmade v2.35.2?
> >
> > - Sedat -
> >
> > - Sedat -
>
> Answering specifically this question:
>
> clang -help displays:
> ...
>   -fbinutils-version=3D<major.minor>
>                           Produced object files can use all ELF
> features supported by this binutils version and newer. If
> -fno-integrated-as is specified, the generated assembly will consider
> GNU as support. 'none' means that all ELF features can be used,
> regardless of binutils support. Defaults to 2.26.
>
> The option was introduced in  https://reviews.llvm.org/D85474
> major.minor.patch is not supported. In reality, very few features are
> gated by this option, currently just SHF_MERGE and a pending
> SHF_LINK_ORDER PGO patch.
> I think we will be conservative. If a 2.37 fix is back ported to
> 2.35.2 and 2.36.1, we will ignore that and will use the feature only
> if -fbinutils-version=3D2.37 or above is specified.
>

Binutils v2.35.2 has DWARF-5 fixes which are not in vanilla v2.36 - I
might be wrong, please correct me.

So what shall I pass now to -fbinutils-version=3D ?

- Sedat -
