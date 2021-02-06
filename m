Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716BA311C64
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBFJdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 04:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBFJc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 04:32:57 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67087C06174A;
        Sat,  6 Feb 2021 01:32:17 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n201so9766379iod.12;
        Sat, 06 Feb 2021 01:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=t1aIgtgK95AwkThnUG/6uLsZUsZLXxfzFLDu2/cfzsA=;
        b=TmQJuLLCs/lt72kTuob+P161bPVDejrqIigyLN247VK+vXmQ3FHdk1CKDkUzPv/BOT
         qzVaI19MDQARrSZ0lrsQywaevJm8Wr3zSaElLafkliKJTlp70vruk9NJrRaeBChsEtsh
         KHsEbRtviSmzWD8y2i5uZwxQK9bGRqOxB3nUaYzC5l5FYaCC6Dl1RGt1AununbB3TGZQ
         QMy01a/Q/+neWi1WKhqVLRquYeY2PlyJIP+NHc/OgGxNiRjKnnpJWEdvO6ypYG8ubvQ3
         NzbqUR7ohS4UhtYvc13oiqO/EMOd4auXN6+tAzCKCIyqCIf4oznD6+yvu8HtvLxZLUts
         U2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=t1aIgtgK95AwkThnUG/6uLsZUsZLXxfzFLDu2/cfzsA=;
        b=V6fdk28QCHrSQ04pFRAxE3+lRzJupRPoiWbVvjsuJPssJ8s8VrK9eoFozV43YyQ/m7
         zmGjVgTlfHppGcfaJUf4c5OWqKp5BH4S3aqXFdJliofMZqvp6pV1HuMI8FYZ9DWZzYXL
         PkREty8aUjK/VKz4rmZKnHS1ExZ4xMObsh+EI3ITCNhZC2Sj8HLKTbZHkTSTxmGvEP+A
         xerWf6jWTjJUMxVtcs3WpuW62bYVg8y7u3+PxaF9KX/CP6psQCpojBKNl+6/odmepLTQ
         OwF2ihpJPfiqVX2wG2WBTi29Iqo3d0b7GrDv5vxQbsbCb36SkPMMLRMN7cv1+Am2kjeF
         Uu2Q==
X-Gm-Message-State: AOAM533g6GMzxJGMJzinALHO1WAiZkp1Fj2ToDMcUvwLES3OTRY4Cx/y
        7FGS79EB+aB4BSFUkP6aiSq2+VioDbEQKQccQuY=
X-Google-Smtp-Source: ABdhPJzwkSXkwVbIyseuhT/YlXHFTfZHpXboLaiQEkYaedS045DmMPXhVDNuVCQTW94I7Fo5NJES78GjDQSME2LIpSs=
X-Received: by 2002:a6b:e006:: with SMTP id z6mr7917260iog.110.1612603936613;
 Sat, 06 Feb 2021 01:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com> <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com> <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com> <CA+icZUVwM9VY5huMpbMtGL-rs16JYvBM2MDiebx6taptH3m-Jg@mail.gmail.com>
In-Reply-To: <CA+icZUVwM9VY5huMpbMtGL-rs16JYvBM2MDiebx6taptH3m-Jg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 10:32:04 +0100
Message-ID: <CA+icZUU=qnLmZWsjeU2G=R0sTkx9+6qtG6Cni1xit=-p_vG_Pw@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000ce59ca05baa79c87"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000ce59ca05baa79c87
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 6, 2021 at 9:32 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Feb 6, 2021 at 9:27 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 2/5/21 10:52 PM, Sedat Dilek wrote:
> > > On Sat, Feb 6, 2021 at 7:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>
> > >> On Sat, Feb 6, 2021 at 6:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>
> > >>> On Sat, Feb 6, 2021 at 6:44 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>>
> > >>>> On Sat, Feb 6, 2021 at 4:34 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>>>
> > >>>>> On Fri, Feb 5, 2021 at 10:54 PM Yonghong Song <yhs@fb.com> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On 2/5/21 12:31 PM, Sedat Dilek wrote:
> > >>>>>>> On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> > >>>>>>>>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> > >>>>>>>>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> > >>>>>>>>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>>>>>>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> > >>>>>>>>>>> know what BTF_INT_UNSIGNED is?
> > >>>>>>>>>
> > >>>>>>>>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> > >>>>>>>>>> ignore this for now until kernel infrastructure is ready.
> > >>>>>>>>>
> > >>>>>>>>> Yeah, I thought about doing that.
> > >>>>>>>>>
> > >>>>>>>>>> Not sure whether this information will be useful or not
> > >>>>>>>>>> for BTF. This needs to be discussed separately.
> > >>>>>>>>>
> > >>>>>>>>> Maybe search for the rationale for its introduction in DWARF.
> > >>>>>>>>
> > >>>>>>>> In LLVM, we have:
> > >>>>>>>>      uint8_t BTFEncoding;
> > >>>>>>>>      switch (Encoding) {
> > >>>>>>>>      case dwarf::DW_ATE_boolean:
> > >>>>>>>>        BTFEncoding = BTF::INT_BOOL;
> > >>>>>>>>        break;
> > >>>>>>>>      case dwarf::DW_ATE_signed:
> > >>>>>>>>      case dwarf::DW_ATE_signed_char:
> > >>>>>>>>        BTFEncoding = BTF::INT_SIGNED;
> > >>>>>>>>        break;
> > >>>>>>>>      case dwarf::DW_ATE_unsigned:
> > >>>>>>>>      case dwarf::DW_ATE_unsigned_char:
> > >>>>>>>>        BTFEncoding = 0;
> > >>>>>>>>        break;
> > >>>>>>>>
> > >>>>>>>> I think DW_ATE_unsigned can be ignored in pahole since
> > >>>>>>>> the default encoding = 0. A simple comment is enough.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> Yonghong Son, do you have a patch/diff for me?
> > >>>>>>
> > >>>>>> Looking at error message from log:
> > >>>>>>
> > >>>>>>    LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > >>>>>> .tmp_vmlinux.btf
> > >>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > >>>>>> Encountered error while encoding BTF.
> > >>>>>>
> > >>>>>> Not exactly what is the root cause. Maybe bt->bit_size is not
> > >>>>>> encoded correctly. Could you put vmlinux (in the above it is
> > >>>>>> .tmp_vmlinux.btf) somewhere, I or somebody else can investigate
> > >>>>>> and provide a proper fix.
> > >>>>>>
> > >>>>>
> > >>>>> [ TO: Masahiro ]
> > >>>>>
> > >>>>> Thanks for taking care Yonghong - hope this is your first name, if not
> > >>>>> I am sorry.
> > >>>>> In case of mixing my first and last name you will make me female -
> > >>>>> Dilek is a Turkish female first name :-).
> > >>>>> So, in some cultures you need to be careful.
> > >>>>>
> > >>>>> Anyway... back to business and facts.
> > >>>>>
> > >>>>> Out of frustration I killed my last build via `make distclean`.
> > >>>>> The whole day I tested diverse combination of GCC-10 and LLVM-12
> > >>>>> together with BTF Kconfigs, selfmade pahole, etc.
> > >>>>>
> > >>>>> I will do ne run with some little changes:
> > >>>>>
> > >>>>> #1: Pass LLVM_IAS=1 to make (means use Clang's Integrated ASsembler -
> > >>>>> as per Nick this leads to the same error - should be unrelated)
> > >>>>> #2: I did: DEBUG_INFO_COMPRESSED y -> n
> > >>>>>
> > >>>>> #2 I did in case you need vmlinux and I have to upload - I will
> > >>>>> compress the resulting vmlinux with ZSTD.
> > >>>>> You need vmlinux or .tmp_vmlinux.btf file?
> > >>>>> Nick was not allowed from his company to download from a Dropbox link.
> > >>>>> So, as an alternative I can offer GoogleDrive...
> > >>>>> ...or bomb into your INBOX :-).
> > >>>>>
> > >>>>> Now, why I CCed Masahiro:
> > >>>>>
> > >>>>> In case of ERRORs when running `scripts/link-vmlinux.sh` above files
> > >>>>> will be removed.
> > >>>>>
> > >>>>> Last, I found a hack to bypass this - means to keep these files (I
> > >>>>> need to check old emails).
> > >>>>>
> > >>>>> Masahiro, you see a possibility to have a way to keep these files in
> > >>>>> case of ERRORs without doing hackery?
> > >>>>>
> > >>>>>  From a previous post in this thread:
> > >>>>>
> > >>>>> + info BTF .btf.vmlinux.bin.o
> > >>>>> + [  != silent_ ]
> > >>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > >>>>>   BTF     .btf.vmlinux.bin.o
> > >>>>> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
> > >>>>> [2] INT long unsigned int Error emitting BTF type
> > >>>>> Encountered error while encoding BTF.
> > >>>>> + llvm-objcopy --only-section=.BTF --set-section-flags
> > >>>>> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> > >>>>> ...
> > >>>>> + info BTFIDS vmlinux
> > >>>>> + [  != silent_ ]
> > >>>>> + printf   %-7s %s\n BTFIDS vmlinux
> > >>>>>   BTFIDS  vmlinux
> > >>>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > >>>>> FAILED: load BTF from vmlinux: Invalid argument
> > >>>>> + on_exit
> > >>>>> + [ 255 -ne 0 ]
> > >>>>> + cleanup
> > >>>>> + rm -f .btf.vmlinux.bin.o
> > >>>>> + rm -f .tmp_System.map
> > >>>>> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
> > >>>>> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
> > >>>>> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
> > >>>>> 2.o
> > >>>>> + rm -f System.map
> > >>>>> + rm -f vmlinux
> > >>>>> + rm -f vmlinux.o
> > >>>>> make[3]: *** [Makefile:1166: vmlinux] Error 255
> > >>>>>
> > >>>>> ^^^ Look here.
> > >>>>>
> > >>>>
> > >>>> With this diff:
> > >>>>
> > >>>> $ git diff scripts/link-vmlinux.sh
> > >>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > >>>> index eef40fa9485d..40f1b6aae553 100755
> > >>>> --- a/scripts/link-vmlinux.sh
> > >>>> +++ b/scripts/link-vmlinux.sh
> > >>>> @@ -330,7 +330,7 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> > >>>> # fill in BTF IDs
> > >>>> if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
> > >>>>         info BTFIDS vmlinux
> > >>>> -       ${RESOLVE_BTFIDS} vmlinux
> > >>>> +       ##${RESOLVE_BTFIDS} vmlinux
> > >>>> fi
> > >>>>
> > >>>> if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> > >>>>
> > >>>> This files are kept - not removed:
> > >>>>
> > >>>> $ LC_ALL=C ll .*btf* vmlinux vmlinux.o
> > >>>> -rwxr-xr-x 1 dileks dileks  31M Feb  6 06:37 .btf.vmlinux.bin.o
> > >>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 .tmp_vmlinux.btf
> > >>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 vmlinux
> > >>>> -rw-r--r-- 1 dileks dileks 344M Feb  6 06:37 vmlinux.o
> > >>>>
> > >>>> Pleas let me know where to upload - Dropbox or GoogleDrive or
> > >>>> elsewhere and give me a link.
> > >>>>
> > >>>
> > >>>
> > >>> WOW, ZSTD is great :-).
> > >>>
> > >>> $ zstd -19 -T0 -v vmlinux
> > >>> *** zstd command line interface 64-bits v1.4.8, by Yann Collet ***
> > >>> Note: 2 physical core(s) detected
> > >>> vmlinux              : 22.71%   (364466016 => 82784801 bytes, vmlinux.zst)
> > >>>
> > >>> $ du -m vmlinux*
> > >>> 348     vmlinux
> > >>> 79      vmlinux.zst
> > >>>
> > >>
> > >> Dropbox link:
> > >> https://www.dropbox.com/sh/kvyh8ps7na0r1h5/AABfyNfDZ2bESse_bo4h05fFa?dl=0
> > >>
> > >> I hope this is public available.
> > >>
> > >
> > > Inspecting vmlinux with llvm-dwarf:
> > >
> > > $ /opt/llvm-toolchain/bin/llvm-dwarfdump vmlinux | grep DW_AT_name |
> > > grep DW_ATE_ | sort | uniq
> > >                 DW_AT_name      ("DW_ATE_signed_1")
> > >                 DW_AT_name      ("DW_ATE_signed_16")
> > >                 DW_AT_name      ("DW_ATE_signed_32")
> > >                 DW_AT_name      ("DW_ATE_signed_64")
> > >                 DW_AT_name      ("DW_ATE_signed_8")
> > >                 DW_AT_name      ("DW_ATE_unsigned_1")
> > >                 DW_AT_name      ("DW_ATE_unsigned_128")
> > >                 DW_AT_name      ("DW_ATE_unsigned_16")
> > >                 DW_AT_name      ("DW_ATE_unsigned_24")
> > >                 DW_AT_name      ("DW_ATE_unsigned_32")
> > >                 DW_AT_name      ("DW_ATE_unsigned_40")
> > >                 DW_AT_name      ("DW_ATE_unsigned_64")
> > >                 DW_AT_name      ("DW_ATE_unsigned_8")
> > >
> > > - Sedat -
> >
> > Thanks for the above dropbot link, I am able to reproduce the issue.
> >
> > I tried to use latest llvm + Nick's patch + latest pahole + dwarf5
> > config option to compile kernel with LLVM=1 LLVM_IAS=1, somehow
> > I did not hit the issue. It complained like
> >
> >    MODPOST vmlinux.symvers
> > WARNING: modpost: vmlinux.o(.text+0x6ce73): Section mismatch in
> > reference from the function __nodes
> > _weight() to the variable .init.data:numa_nodes_parsed
> > The function __nodes_weight() references
> > the variable __initdata numa_nodes_parsed.
> > This is often because __nodes_weight lacks a __initdata
> > annotation or the annotation of numa_nodes_parsed is wrong.
> >
> > but otherwise compilation is fine.
> >
> > With the above vmlinux, the issue appears to be handling
> > DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
> >
> > The following patch should fix the issue:
> >
> > -bash-4.4$ git diff
> >
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> >
> > index b73d786..0341b5e 100644
> >
> > --- a/dwarf_loader.c
> >
> > +++ b/dwarf_loader.c
> >
> > @@ -467,8 +467,16 @@ static struct base_type *base_type__new(Dwarf_Die
> > *die, struct cu *cu)
> >
> >
> >          if (bt != NULL) {
> >
> >                  tag__init(&bt->tag, cu, die);
> >
> > -               bt->name = strings__add(strings, attr_string(die,
> > DW_AT_name));
> > -               bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8;
> >
> > +               const char *name = attr_string(die, DW_AT_name);
> >
> > +               bt->name = strings__add(strings, name);
> >
> > +               /* DW_ATE_unsigned_1 has DW_AT_byte_size == 0.
> >
> > +                * specially process it.
> >
> > +                */
> >
> > +               if (strcmp(name, "DW_ATE_unsigned_1") == 0)
> >
> > +                       bt->bit_size = 1;
> >
> > +               else
> >
> > +                       bt->bit_size = attr_numeric(die,
> > DW_AT_byte_size) * 8;
> > +
> >
> >                  uint64_t encoding = attr_numeric(die, DW_AT_encoding);
> >                  bt->is_bool = encoding == DW_ATE_boolean;
> >                  bt->is_signed = encoding == DW_ATE_signed;
> > diff --git a/libbtf.c b/libbtf.c
> > index 9f76283..b5aa077 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -367,13 +367,32 @@ static void btf_log_func_param(const struct
> > btf_elf *btfe,
> >          }
> >   }
> >
> > +/* btf requires power-of-2 bytes, yet dwarf may have something like
> > + * DW_ATE_unsigned_24 which encodes as 24 bits (3 bytes).
> > + */
> > +static int bits_to_int_bytes(uint16_t bit_size)
> > +{
> > +       if (bit_size <= 8)
> > +               return 1;
> > +       if (bit_size <= 16)
> > +               return 2;
> > +       if (bit_size <= 32)
> > +               return 4;
> > +       if (bit_size <= 64)
> >
> > +               return 8;
> >
> > +       if (bit_size <= 128)
> > +               return 16;
> > +       /* BTF supports upto 16byte int (__int128). */
> > +       return -1;
> > +}
> > +
> >   int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct
> > base_type *bt,
> >                                 const char *name)
> >   {
> >          struct btf *btf = btfe->btf;
> >          const struct btf_type *t;
> >          uint8_t encoding = 0;
> > -       int32_t id;
> > +       int32_t id, nbytes;
> >
> >          if (bt->is_signed) {
> >                  encoding = BTF_INT_SIGNED;
> > @@ -384,7 +403,13 @@ int32_t btf_elf__add_base_type(struct btf_elf
> > *btfe, const struct base_type *b
> > t,
> >                  return -1;
> >          }
> > -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size),
> > encoding);
> > +       nbytes = bits_to_int_bytes(bt->bit_size);
> > +       if (nbytes < 0) {
> > +               fprintf(stderr, "not supported bit_size %hu\n",
> > bt->bit_size);
> > +               return -1;
> > +       }
> > +
> > +       id = btf__add_int(btf, name, nbytes, encoding);
> >          if (id < 0) {
> >                  btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error
> > emitting BTF type");
> >          } else {
> > -bash-4.4$
> >
> > Please help do a test. I can submit a formal patch tomorrow.
>
> Thanks for the patch.
>
> Can you attach the diff as Gmail has totally truncated/malformed it?
>
> For the Linux breakage - you will need some additional Clang specific patches.
> Is this Linux 5.11-rcX?
> The "Blocking bugs" are listed in the first post of "Linux 5.11 release cycle".
> Hope this helps.
>
> This is cool co-working :-).
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/1228

With the attached diff and new selfmade pahole looks good here.

Passed (see line-numbers):

11090:+ info LD .tmp_vmlinux.btf
11099:+ info BTF .btf.vmlinux.bin.o
11103:+ LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
11121:+ info LD .tmp_vmlinux.kallsyms1
11139:+ info KSYMS .tmp_vmlinux.kallsyms1.S
11145:+ info AS .tmp_vmlinux.kallsyms1.S
11160:+ info LD .tmp_vmlinux.kallsyms2
11178:+ info KSYMS .tmp_vmlinux.kallsyms2.S
11184:+ info AS .tmp_vmlinux.kallsyms2.S
11200:+ info LD vmlinux
11210:+ info BTFIDS vmlinux
11216:+ info SORTTAB vmlinux

Still building linux-kernel...

Will report later if I was able to boot on bare metal.

- Sedat -

--000000000000ce59ca05baa79c87
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="DW_ATE_unsigned_1-pahole_1_20-dileks.diff"
Content-Disposition: attachment; 
	filename="DW_ATE_unsigned_1-pahole_1_20-dileks.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kktio1eq0>
X-Attachment-Id: f_kktio1eq0

ZGlmZiAtLWdpdCBhL2R3YXJmX2xvYWRlci5jIGIvZHdhcmZfbG9hZGVyLmMKaW5kZXggYjczZDc4
NjdlMWU2Li5hYmExNDY3OWEwN2UgMTAwNjQ0Ci0tLSBhL2R3YXJmX2xvYWRlci5jCisrKyBiL2R3
YXJmX2xvYWRlci5jCkBAIC00NjcsOCArNDY3LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgYmFzZV90eXBl
ICpiYXNlX3R5cGVfX25ldyhEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGN1ICpjdSkKIAogCWlmIChi
dCAhPSBOVUxMKSB7CiAJCXRhZ19faW5pdCgmYnQtPnRhZywgY3UsIGRpZSk7Ci0JCWJ0LT5uYW1l
ID0gc3RyaW5nc19fYWRkKHN0cmluZ3MsIGF0dHJfc3RyaW5nKGRpZSwgRFdfQVRfbmFtZSkpOwot
CQlidC0+Yml0X3NpemUgPSBhdHRyX251bWVyaWMoZGllLCBEV19BVF9ieXRlX3NpemUpICogODsK
KwkJY29uc3QgY2hhciAqbmFtZSA9IGF0dHJfc3RyaW5nKGRpZSwgRFdfQVRfbmFtZSk7CisJCWJ0
LT5uYW1lID0gc3RyaW5nc19fYWRkKHN0cmluZ3MsIG5hbWUpOworCQkvKiBEV19BVEVfdW5zaWdu
ZWRfMSBoYXMgRFdfQVRfYnl0ZV9zaXplID09IDAuCisJCSogc3BlY2lhbGx5IHByb2Nlc3MgaXQu
CisJCSovCisJCWlmIChzdHJjbXAobmFtZSwgIkRXX0FURV91bnNpZ25lZF8xIikgPT0gMCkKKwkJ
CWJ0LT5iaXRfc2l6ZSA9IDE7CisJCWVsc2UKKwkJCWJ0LT5iaXRfc2l6ZSA9IGF0dHJfbnVtZXJp
YyhkaWUsIERXX0FUX2J5dGVfc2l6ZSkgKiA4OwogCQl1aW50NjRfdCBlbmNvZGluZyA9IGF0dHJf
bnVtZXJpYyhkaWUsIERXX0FUX2VuY29kaW5nKTsKIAkJYnQtPmlzX2Jvb2wgPSBlbmNvZGluZyA9
PSBEV19BVEVfYm9vbGVhbjsKIAkJYnQtPmlzX3NpZ25lZCA9IGVuY29kaW5nID09IERXX0FURV9z
aWduZWQ7CmRpZmYgLS1naXQgYS9saWJidGYuYyBiL2xpYmJ0Zi5jCmluZGV4IDlmNzYyODMwNDQ5
NS4uNDRkYjI5ZTgzNDMzIDEwMDY0NAotLS0gYS9saWJidGYuYworKysgYi9saWJidGYuYwpAQCAt
MzY3LDEzICszNjcsMzIgQEAgc3RhdGljIHZvaWQgYnRmX2xvZ19mdW5jX3BhcmFtKGNvbnN0IHN0
cnVjdCBidGZfZWxmICpidGZlLAogCX0KIH0KIAorLyogYnRmIHJlcXVpcmVzIHBvd2VyLW9mLTIg
Ynl0ZXMsIHlldCBkd2FyZiBtYXkgaGF2ZSBzb21ldGhpbmcgbGlrZQorICogRFdfQVRFX3Vuc2ln
bmVkXzI0IHdoaWNoIGVuY29kZXMgYXMgMjQgYml0cyAoMyBieXRlcykuCisgKi8KK3N0YXRpYyBp
bnQgYml0c190b19pbnRfYnl0ZXModWludDE2X3QgYml0X3NpemUpCit7CisgICAgICAgaWYgKGJp
dF9zaXplIDw9IDgpCisgICAgICAgICAgICAgICByZXR1cm4gMTsKKyAgICAgICBpZiAoYml0X3Np
emUgPD0gMTYpCisgICAgICAgICAgICAgICByZXR1cm4gMjsKKyAgICAgICBpZiAoYml0X3NpemUg
PD0gMzIpCisgICAgICAgICAgICAgICByZXR1cm4gNDsKKyAgICAgICBpZiAoYml0X3NpemUgPD0g
NjQpCisgICAgICAgICAgICAgICByZXR1cm4gODsKKyAgICAgICBpZiAoYml0X3NpemUgPD0gMTI4
KQorICAgICAgICAgICAgICAgcmV0dXJuIDE2OworICAgICAgIC8qIEJURiBzdXBwb3J0cyB1cHRv
IDE2Ynl0ZSBpbnQgKF9faW50MTI4KS4gKi8KKyAgICAgICByZXR1cm4gLTE7Cit9CisKIGludDMy
X3QgYnRmX2VsZl9fYWRkX2Jhc2VfdHlwZShzdHJ1Y3QgYnRmX2VsZiAqYnRmZSwgY29uc3Qgc3Ry
dWN0IGJhc2VfdHlwZSAqYnQsCiAJCQkgICAgICAgY29uc3QgY2hhciAqbmFtZSkKIHsKIAlzdHJ1
Y3QgYnRmICpidGYgPSBidGZlLT5idGY7CiAJY29uc3Qgc3RydWN0IGJ0Zl90eXBlICp0OwogCXVp
bnQ4X3QgZW5jb2RpbmcgPSAwOwotCWludDMyX3QgaWQ7CisJaW50MzJfdCBpZCwgbmJ5dGVzOwog
CiAJaWYgKGJ0LT5pc19zaWduZWQpIHsKIAkJZW5jb2RpbmcgPSBCVEZfSU5UX1NJR05FRDsKQEAg
LTM4NCw3ICs0MDMsMTMgQEAgaW50MzJfdCBidGZfZWxmX19hZGRfYmFzZV90eXBlKHN0cnVjdCBi
dGZfZWxmICpidGZlLCBjb25zdCBzdHJ1Y3QgYmFzZV90eXBlICpidCwKIAkJcmV0dXJuIC0xOwog
CX0KIAotCWlkID0gYnRmX19hZGRfaW50KGJ0ZiwgbmFtZSwgQklUU19ST1VORFVQX0JZVEVTKGJ0
LT5iaXRfc2l6ZSksIGVuY29kaW5nKTsKKwluYnl0ZXMgPSBiaXRzX3RvX2ludF9ieXRlcyhidC0+
Yml0X3NpemUpOworCWlmIChuYnl0ZXMgPCAwKSB7CisJCWZwcmludGYoc3RkZXJyLCAibm90IHN1
cHBvcnRlZCBiaXRfc2l6ZSAlaHVcbiIsIGJ0LT5iaXRfc2l6ZSk7CisJCXJldHVybiAtMTsKKwl9
CisKKwlpZCA9IGJ0Zl9fYWRkX2ludChidGYsIG5hbWUsIG5ieXRlcywgZW5jb2RpbmcpOwogCWlm
IChpZCA8IDApIHsKIAkJYnRmX2VsZl9fbG9nX2VycihidGZlLCBCVEZfS0lORF9JTlQsIG5hbWUs
IHRydWUsICJFcnJvciBlbWl0dGluZyBCVEYgdHlwZSIpOwogCX0gZWxzZSB7Cg==
--000000000000ce59ca05baa79c87--
