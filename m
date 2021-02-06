Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CC1311C2A
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 09:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBFIc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFIc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 03:32:58 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E4C061756;
        Sat,  6 Feb 2021 00:32:18 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q7so9782474iob.0;
        Sat, 06 Feb 2021 00:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8jZ/SgN+hKQexkXrpdxS/cjJFDMUx4y5qzsPaB3r9UM=;
        b=awgbKCs8hGG/j8aWm9+PSGJW/gpQwDoxFN8d5jEVurL3h2EXoPF3n1IWRVcOJM9eWo
         /CRReYw66XW0WjAPFA2yRsw9hB5XBYyf3S1uFnu+9c1R9YlKcW+Ug6Iaj2A+xnX5Bf6M
         X3CJoGVsTotfssaZVzPdzA3VG4DmHiVwwTUYPJgcgl715ktNtZQI0XYqn6ifhSzf3oyY
         AjG5lrEZk6mBEUCwoxolK8KM88IRGhuvLtyN8AdR+gfiIZgoUwmtytvVj1xOCVJZk5BP
         G6oL9QNNSrQkOhdowIklRBK1K5vR/K/ftk7O/bVpu677wQLMSHURn73gpgoqmVMcUQwd
         O1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8jZ/SgN+hKQexkXrpdxS/cjJFDMUx4y5qzsPaB3r9UM=;
        b=Tlc3NzdOXiAWzS70UZ5URN/81tPTiSngWEJL5/vfECyIFcsTV5+bbK7tBs29c4ZK+q
         LK/xjtO6f7j8k/IObgwzZ+irITgWTFl6/V+uR0qcSZDCQhzgcWZ912k/KncOXKF7kH/I
         8qjy8vVZx/K8jvdxDitCkWD8FbEak7KqwcdVRn1pRMD8Zj1MEhc7XQNtefPV98ptrjjA
         cyJtzNQzpdPqlgsNNXhmZDWZR5Sf/tXBQUlc3HoGDiND+quIbdr6oC3R6FsuLyrHtplY
         I+vM4Fwzp2+OHYpHKsKemrwcvD4kDWBOpIR8KFx811JRkdz/YO83KobYH4W1iDZg4+kW
         h2Mw==
X-Gm-Message-State: AOAM5327cZnn6v19uED1BY3w5gejM1bS6AbA1IL/RR6ciU0vLaiZGw8/
        IfL+uk1v3JJQnpPVyy9bpwAnuDfWamjuDRG/LuRn2vVQmQbkOk3X
X-Google-Smtp-Source: ABdhPJxiJPGHzIddWBjHhXwlEnZDx9AdnlFOw9kn4/UwHkVyPXpy02KSmdRvPOmyTDfla4ubSwdrdCGGERz3k6s7IbA=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr7451113iog.57.1612600337723;
 Sat, 06 Feb 2021 00:32:17 -0800 (PST)
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
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com> <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
In-Reply-To: <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 09:32:06 +0100
Message-ID: <CA+icZUVwM9VY5huMpbMtGL-rs16JYvBM2MDiebx6taptH3m-Jg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:27 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/5/21 10:52 PM, Sedat Dilek wrote:
> > On Sat, Feb 6, 2021 at 7:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> On Sat, Feb 6, 2021 at 6:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>
> >>> On Sat, Feb 6, 2021 at 6:44 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>
> >>>> On Sat, Feb 6, 2021 at 4:34 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>>
> >>>>> On Fri, Feb 5, 2021 at 10:54 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2/5/21 12:31 PM, Sedat Dilek wrote:
> >>>>>>> On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> >>>>>>>>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> >>>>>>>>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> >>>>>>>>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>>>>>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> >>>>>>>>>>> know what BTF_INT_UNSIGNED is?
> >>>>>>>>>
> >>>>>>>>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> >>>>>>>>>> ignore this for now until kernel infrastructure is ready.
> >>>>>>>>>
> >>>>>>>>> Yeah, I thought about doing that.
> >>>>>>>>>
> >>>>>>>>>> Not sure whether this information will be useful or not
> >>>>>>>>>> for BTF. This needs to be discussed separately.
> >>>>>>>>>
> >>>>>>>>> Maybe search for the rationale for its introduction in DWARF.
> >>>>>>>>
> >>>>>>>> In LLVM, we have:
> >>>>>>>>      uint8_t BTFEncoding;
> >>>>>>>>      switch (Encoding) {
> >>>>>>>>      case dwarf::DW_ATE_boolean:
> >>>>>>>>        BTFEncoding = BTF::INT_BOOL;
> >>>>>>>>        break;
> >>>>>>>>      case dwarf::DW_ATE_signed:
> >>>>>>>>      case dwarf::DW_ATE_signed_char:
> >>>>>>>>        BTFEncoding = BTF::INT_SIGNED;
> >>>>>>>>        break;
> >>>>>>>>      case dwarf::DW_ATE_unsigned:
> >>>>>>>>      case dwarf::DW_ATE_unsigned_char:
> >>>>>>>>        BTFEncoding = 0;
> >>>>>>>>        break;
> >>>>>>>>
> >>>>>>>> I think DW_ATE_unsigned can be ignored in pahole since
> >>>>>>>> the default encoding = 0. A simple comment is enough.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Yonghong Son, do you have a patch/diff for me?
> >>>>>>
> >>>>>> Looking at error message from log:
> >>>>>>
> >>>>>>    LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> >>>>>> .tmp_vmlinux.btf
> >>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> >>>>>> Encountered error while encoding BTF.
> >>>>>>
> >>>>>> Not exactly what is the root cause. Maybe bt->bit_size is not
> >>>>>> encoded correctly. Could you put vmlinux (in the above it is
> >>>>>> .tmp_vmlinux.btf) somewhere, I or somebody else can investigate
> >>>>>> and provide a proper fix.
> >>>>>>
> >>>>>
> >>>>> [ TO: Masahiro ]
> >>>>>
> >>>>> Thanks for taking care Yonghong - hope this is your first name, if not
> >>>>> I am sorry.
> >>>>> In case of mixing my first and last name you will make me female -
> >>>>> Dilek is a Turkish female first name :-).
> >>>>> So, in some cultures you need to be careful.
> >>>>>
> >>>>> Anyway... back to business and facts.
> >>>>>
> >>>>> Out of frustration I killed my last build via `make distclean`.
> >>>>> The whole day I tested diverse combination of GCC-10 and LLVM-12
> >>>>> together with BTF Kconfigs, selfmade pahole, etc.
> >>>>>
> >>>>> I will do ne run with some little changes:
> >>>>>
> >>>>> #1: Pass LLVM_IAS=1 to make (means use Clang's Integrated ASsembler -
> >>>>> as per Nick this leads to the same error - should be unrelated)
> >>>>> #2: I did: DEBUG_INFO_COMPRESSED y -> n
> >>>>>
> >>>>> #2 I did in case you need vmlinux and I have to upload - I will
> >>>>> compress the resulting vmlinux with ZSTD.
> >>>>> You need vmlinux or .tmp_vmlinux.btf file?
> >>>>> Nick was not allowed from his company to download from a Dropbox link.
> >>>>> So, as an alternative I can offer GoogleDrive...
> >>>>> ...or bomb into your INBOX :-).
> >>>>>
> >>>>> Now, why I CCed Masahiro:
> >>>>>
> >>>>> In case of ERRORs when running `scripts/link-vmlinux.sh` above files
> >>>>> will be removed.
> >>>>>
> >>>>> Last, I found a hack to bypass this - means to keep these files (I
> >>>>> need to check old emails).
> >>>>>
> >>>>> Masahiro, you see a possibility to have a way to keep these files in
> >>>>> case of ERRORs without doing hackery?
> >>>>>
> >>>>>  From a previous post in this thread:
> >>>>>
> >>>>> + info BTF .btf.vmlinux.bin.o
> >>>>> + [  != silent_ ]
> >>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> >>>>>   BTF     .btf.vmlinux.bin.o
> >>>>> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
> >>>>> [2] INT long unsigned int Error emitting BTF type
> >>>>> Encountered error while encoding BTF.
> >>>>> + llvm-objcopy --only-section=.BTF --set-section-flags
> >>>>> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> >>>>> ...
> >>>>> + info BTFIDS vmlinux
> >>>>> + [  != silent_ ]
> >>>>> + printf   %-7s %s\n BTFIDS vmlinux
> >>>>>   BTFIDS  vmlinux
> >>>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> >>>>> FAILED: load BTF from vmlinux: Invalid argument
> >>>>> + on_exit
> >>>>> + [ 255 -ne 0 ]
> >>>>> + cleanup
> >>>>> + rm -f .btf.vmlinux.bin.o
> >>>>> + rm -f .tmp_System.map
> >>>>> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
> >>>>> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
> >>>>> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
> >>>>> 2.o
> >>>>> + rm -f System.map
> >>>>> + rm -f vmlinux
> >>>>> + rm -f vmlinux.o
> >>>>> make[3]: *** [Makefile:1166: vmlinux] Error 255
> >>>>>
> >>>>> ^^^ Look here.
> >>>>>
> >>>>
> >>>> With this diff:
> >>>>
> >>>> $ git diff scripts/link-vmlinux.sh
> >>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> >>>> index eef40fa9485d..40f1b6aae553 100755
> >>>> --- a/scripts/link-vmlinux.sh
> >>>> +++ b/scripts/link-vmlinux.sh
> >>>> @@ -330,7 +330,7 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> >>>> # fill in BTF IDs
> >>>> if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
> >>>>         info BTFIDS vmlinux
> >>>> -       ${RESOLVE_BTFIDS} vmlinux
> >>>> +       ##${RESOLVE_BTFIDS} vmlinux
> >>>> fi
> >>>>
> >>>> if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> >>>>
> >>>> This files are kept - not removed:
> >>>>
> >>>> $ LC_ALL=C ll .*btf* vmlinux vmlinux.o
> >>>> -rwxr-xr-x 1 dileks dileks  31M Feb  6 06:37 .btf.vmlinux.bin.o
> >>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 .tmp_vmlinux.btf
> >>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 vmlinux
> >>>> -rw-r--r-- 1 dileks dileks 344M Feb  6 06:37 vmlinux.o
> >>>>
> >>>> Pleas let me know where to upload - Dropbox or GoogleDrive or
> >>>> elsewhere and give me a link.
> >>>>
> >>>
> >>>
> >>> WOW, ZSTD is great :-).
> >>>
> >>> $ zstd -19 -T0 -v vmlinux
> >>> *** zstd command line interface 64-bits v1.4.8, by Yann Collet ***
> >>> Note: 2 physical core(s) detected
> >>> vmlinux              : 22.71%   (364466016 => 82784801 bytes, vmlinux.zst)
> >>>
> >>> $ du -m vmlinux*
> >>> 348     vmlinux
> >>> 79      vmlinux.zst
> >>>
> >>
> >> Dropbox link:
> >> https://www.dropbox.com/sh/kvyh8ps7na0r1h5/AABfyNfDZ2bESse_bo4h05fFa?dl=0
> >>
> >> I hope this is public available.
> >>
> >
> > Inspecting vmlinux with llvm-dwarf:
> >
> > $ /opt/llvm-toolchain/bin/llvm-dwarfdump vmlinux | grep DW_AT_name |
> > grep DW_ATE_ | sort | uniq
> >                 DW_AT_name      ("DW_ATE_signed_1")
> >                 DW_AT_name      ("DW_ATE_signed_16")
> >                 DW_AT_name      ("DW_ATE_signed_32")
> >                 DW_AT_name      ("DW_ATE_signed_64")
> >                 DW_AT_name      ("DW_ATE_signed_8")
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_name      ("DW_ATE_unsigned_128")
> >                 DW_AT_name      ("DW_ATE_unsigned_16")
> >                 DW_AT_name      ("DW_ATE_unsigned_24")
> >                 DW_AT_name      ("DW_ATE_unsigned_32")
> >                 DW_AT_name      ("DW_ATE_unsigned_40")
> >                 DW_AT_name      ("DW_ATE_unsigned_64")
> >                 DW_AT_name      ("DW_ATE_unsigned_8")
> >
> > - Sedat -
>
> Thanks for the above dropbot link, I am able to reproduce the issue.
>
> I tried to use latest llvm + Nick's patch + latest pahole + dwarf5
> config option to compile kernel with LLVM=1 LLVM_IAS=1, somehow
> I did not hit the issue. It complained like
>
>    MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(.text+0x6ce73): Section mismatch in
> reference from the function __nodes
> _weight() to the variable .init.data:numa_nodes_parsed
> The function __nodes_weight() references
> the variable __initdata numa_nodes_parsed.
> This is often because __nodes_weight lacks a __initdata
> annotation or the annotation of numa_nodes_parsed is wrong.
>
> but otherwise compilation is fine.
>
> With the above vmlinux, the issue appears to be handling
> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
>
> The following patch should fix the issue:
>
> -bash-4.4$ git diff
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
>
> index b73d786..0341b5e 100644
>
> --- a/dwarf_loader.c
>
> +++ b/dwarf_loader.c
>
> @@ -467,8 +467,16 @@ static struct base_type *base_type__new(Dwarf_Die
> *die, struct cu *cu)
>
>
>          if (bt != NULL) {
>
>                  tag__init(&bt->tag, cu, die);
>
> -               bt->name = strings__add(strings, attr_string(die,
> DW_AT_name));
> -               bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8;
>
> +               const char *name = attr_string(die, DW_AT_name);
>
> +               bt->name = strings__add(strings, name);
>
> +               /* DW_ATE_unsigned_1 has DW_AT_byte_size == 0.
>
> +                * specially process it.
>
> +                */
>
> +               if (strcmp(name, "DW_ATE_unsigned_1") == 0)
>
> +                       bt->bit_size = 1;
>
> +               else
>
> +                       bt->bit_size = attr_numeric(die,
> DW_AT_byte_size) * 8;
> +
>
>                  uint64_t encoding = attr_numeric(die, DW_AT_encoding);
>                  bt->is_bool = encoding == DW_ATE_boolean;
>                  bt->is_signed = encoding == DW_ATE_signed;
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..b5aa077 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -367,13 +367,32 @@ static void btf_log_func_param(const struct
> btf_elf *btfe,
>          }
>   }
>
> +/* btf requires power-of-2 bytes, yet dwarf may have something like
> + * DW_ATE_unsigned_24 which encodes as 24 bits (3 bytes).
> + */
> +static int bits_to_int_bytes(uint16_t bit_size)
> +{
> +       if (bit_size <= 8)
> +               return 1;
> +       if (bit_size <= 16)
> +               return 2;
> +       if (bit_size <= 32)
> +               return 4;
> +       if (bit_size <= 64)
>
> +               return 8;
>
> +       if (bit_size <= 128)
> +               return 16;
> +       /* BTF supports upto 16byte int (__int128). */
> +       return -1;
> +}
> +
>   int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct
> base_type *bt,
>                                 const char *name)
>   {
>          struct btf *btf = btfe->btf;
>          const struct btf_type *t;
>          uint8_t encoding = 0;
> -       int32_t id;
> +       int32_t id, nbytes;
>
>          if (bt->is_signed) {
>                  encoding = BTF_INT_SIGNED;
> @@ -384,7 +403,13 @@ int32_t btf_elf__add_base_type(struct btf_elf
> *btfe, const struct base_type *b
> t,
>                  return -1;
>          }
> -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size),
> encoding);
> +       nbytes = bits_to_int_bytes(bt->bit_size);
> +       if (nbytes < 0) {
> +               fprintf(stderr, "not supported bit_size %hu\n",
> bt->bit_size);
> +               return -1;
> +       }
> +
> +       id = btf__add_int(btf, name, nbytes, encoding);
>          if (id < 0) {
>                  btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error
> emitting BTF type");
>          } else {
> -bash-4.4$
>
> Please help do a test. I can submit a formal patch tomorrow.

Thanks for the patch.

Can you attach the diff as Gmail has totally truncated/malformed it?

For the Linux breakage - you will need some additional Clang specific patches.
Is this Linux 5.11-rcX?
The "Blocking bugs" are listed in the first post of "Linux 5.11 release cycle".
Hope this helps.

This is cool co-working :-).

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1228
