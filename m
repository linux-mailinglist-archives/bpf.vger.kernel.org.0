Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A383110C1
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhBER1Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 12:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhBERZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 12:25:07 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16865C06174A;
        Fri,  5 Feb 2021 11:06:50 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d6so6792330ilo.6;
        Fri, 05 Feb 2021 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=W04rzmoh0dDqBnrpFVEMr7Q8MspUnqt0UMEBpX0pL3s=;
        b=QZ7dB2jQA03FLGbAScMI70F9+TzH+vZxpRzFvlMBsSA5fp1nmyXKvY95K3H3haGz7C
         NlHAX084Euv5353n5YwR7YCM/HTNSwDCZQ5ZK8gcaUph8w/3YQcasmG5ONQUMvik4PI+
         0KRfiCvvXQgANS2Duq+Sn/Gmz2F5gjkcNUh0gfCAWtqREORoMHKYv7ERhzcJubKvqI5+
         L+i2/tDHSZQ+0ivlKSEQA8kEJ1/PksrUJ3Uz3xXZDtx4lHu2RaqSc8JsMu4Kb7ejJ2p/
         86ml2PhZImG/KiMV/C07a8pAjI3KRatERigub+jLAkvW0O+wg5a1fcyTy1UUkcgaGnmZ
         JiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=W04rzmoh0dDqBnrpFVEMr7Q8MspUnqt0UMEBpX0pL3s=;
        b=pvVrLbF00WIrrCwiPI7dsrklV+aTTLYiVHhdWWpHwYbgF7tOUPB00kMCH8HcsK9iME
         TPPXxluXcCQXsI/WoJ4MRfaFL/egJqllWsZUSPH01CkzStvGEP0c9Xh3DLW41/+sfRwU
         nGhJpChzXD1/SbK4EwHy1bVkg0NriM8f3IKYrFWBttURLcAGEVDz6Kx5F1TuoQZj5v9n
         C8jmN28feuO6yEA+xri+0DV3oALqm0GT59zSkwrYemeP8R8MyKAKdQpCpnSZXaRG+hMH
         bHUNjnA1aLv1UVfeo8+3PJGJICFQ9HMtOBsz4dVoEK9POQMQCQF+x74AoQ9Y+IrkNyBd
         pP7g==
X-Gm-Message-State: AOAM531w1vLrziZLue92VZgDoqieEgTJEAFCXUn91taCAb/EZP5SytDq
        +fhuszAiuq3bfUITBcf5kabP18w/8yLTeRKwtKPRyhvbRm0p1A==
X-Google-Smtp-Source: ABdhPJxeQ9p93d1K3KvC1JLYt3TYDuGlosypb9DuGnyrIHGc9AxB+5h8uPx1qyoqI+a/1GyydRRP5uQQKAQFie5yMY4=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr5097185ilq.112.1612552009533;
 Fri, 05 Feb 2021 11:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
In-Reply-To: <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 20:06:36 +0100
Message-ID: <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 6:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 4:28 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu:
> > > > On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > > > > > v12.0.0-rc1 and DWARF-v5 I see:
> > > > > > ...
> > > > > > + info BTF .btf.vmlinux.bin.o
> > > > > > + [  != silent_ ]
> > > > > > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > > > > >  BTF     .btf.vmlinux.bin.o
> > > > > > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > > > > > .tmp_vmlinux.btf
> > > > > > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > > > > > Encountered error while encoding BTF.
> > > > >
> > > > > Grepping the pahole sources:
> > > > >
> > > > > $ git grep DW_ATE
> > > > > dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
> > > > > dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
> > > > >
> > > > > Missing DW_ATE_unsigned encoding?
> > > > >
> > > >
> > > > Checked the LLVM sources:
> > > >
> > > > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> > > > llvm::dwarf::DW_ATE_unsigned_char;
> > > > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
> > > > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> > > > llvm::dwarf::DW_ATE_unsigned_fixed;
> > > > clang/lib/CodeGen/CGDebugInfo.cpp:
> > > >   ? llvm::dwarf::DW_ATE_unsigned
> > > > ...
> > > > lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
> > > >  (DW_ATE_unsigned)
> > > >
> > > > So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.
> > >
> > > Thanks for the research, probably your conclusion is correct, can you go
> > > the next step and add that part and check if the end result is the
> > > expected one?
> > >
> >
> > Still building...
> >
> > Can you give me a hand on what has to be changed in dwarves/pahole?
> >
> > I guess switching from ld.bfd to ld.lld will show the same ERROR.
> >
>
> This builds successfully - untested:
>
> $ git diff
> diff --git a/btf_loader.c b/btf_loader.c
> index ec286f413f36..a39edd3362db 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -107,6 +107,7 @@ static struct base_type *base_type__new(strings_t
> name, uint32_t attrs,
>                bt->bit_size = size;
>                bt->is_signed = attrs & BTF_INT_SIGNED;
>                bt->is_bool = attrs & BTF_INT_BOOL;
> +               bt->is_unsigned = attrs & BTF_INT_UNSIGNED;
>                bt->name_has_encoding = false;
>                bt->float_type = float_type;
>        }
> diff --git a/ctf.h b/ctf.h
> index 25b79892bde3..9e47c3c74677 100644
> --- a/ctf.h
> +++ b/ctf.h
> @@ -100,6 +100,7 @@ struct ctf_full_type {
> #define CTF_TYPE_INT_CHAR      0x2
> #define CTF_TYPE_INT_BOOL      0x4
> #define CTF_TYPE_INT_VARARGS   0x8
> +#define CTF_TYPE_INT_UNSIGNED  0x16
>
> #define CTF_TYPE_FP_ATTRS(VAL)         ((VAL) >> 24)
> #define CTF_TYPE_FP_OFFSET(VAL)                (((VAL) >> 16) & 0xff)
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b73d7867e1e6..79d40f183c24 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -473,6 +473,7 @@ static struct base_type *base_type__new(Dwarf_Die
> *die, struct cu *cu)
>                bt->is_bool = encoding == DW_ATE_boolean;
>                bt->is_signed = encoding == DW_ATE_signed;
>                bt->is_varargs = false;
> +               bt->is_unsigned = encoding == DW_ATE_unsigned;
>                bt->name_has_encoding = true;
>        }
>
> diff --git a/dwarves.h b/dwarves.h
> index 98caf1abc54d..edf32d2e6f80 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1261,6 +1261,7 @@ struct base_type {
>        uint8_t         is_signed:1;
>        uint8_t         is_bool:1;
>        uint8_t         is_varargs:1;
> +       uint8_t         is_unsigned:1;
>        uint8_t         float_type:4;
> };
>
> diff --git a/lib/bpf b/lib/bpf
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
> +Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396-dirty
> diff --git a/libbtf.c b/libbtf.c
> index 9f7628304495..a0661a7bbed9 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -247,6 +247,8 @@ static const char *
> btf_elf__int_encoding_str(uint8_t encoding)
>                return "CHAR";
>        else if (encoding == BTF_INT_BOOL)
>                return "BOOL";
> +       else if (encoding == BTF_INT_UNSIGNED)
> +               return "UNSIGNED";
>        else
>                return "UNKN";
> }
> @@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_elf
> *btfe, const struct base_type *bt,
>                encoding = BTF_INT_SIGNED;
>        } else if (bt->is_bool) {
>                encoding = BTF_INT_BOOL;
> +       } else if (bt->is_unsigned) {
> +               encoding = BTF_INT_UNSIGNED;
>        } else if (bt->float_type) {
>                fprintf(stderr, "float_type is not supported\n");
>                return -1;
>
> Additionally - I cannot see it with `git diff`:
>
> [ lib/bpf/include/uapi/linux/btf.h ]
>
> /* Attributes stored in the BTF_INT_ENCODING */
> #define BTF_INT_SIGNED (1 << 0)
> #define BTF_INT_CHAR (1 << 1)
> #define BTF_INT_BOOL (1 << 2)
> #define BTF_INT_UNSIGNED (1 << 3)
>
> Comments?
>

Hmmm...

+ info BTF .btf.vmlinux.bin.o
+ [  != silent_ ]
+ printf   %-7s %s\n BTF .btf.vmlinux.bin.o
 BTF     .btf.vmlinux.bin.o
+ LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
[2] INT long unsigned int Error emitting BTF type
Encountered error while encoding BTF.
+ llvm-objcopy --only-section=.BTF --set-section-flags
.BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
...
+ info BTFIDS vmlinux
+ [  != silent_ ]
+ printf   %-7s %s\n BTFIDS vmlinux
 BTFIDS  vmlinux
+ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
FAILED: load BTF from vmlinux: Invalid argument
+ on_exit
+ [ 255 -ne 0 ]
+ cleanup
+ rm -f .btf.vmlinux.bin.o
+ rm -f .tmp_System.map
+ rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
.tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
.tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
2.o
+ rm -f System.map
+ rm -f vmlinux
+ rm -f vmlinux.o
make[3]: *** [Makefile:1166: vmlinux] Error 255

Grepping through linux.git/tools I guess some BTF tools/libs need to
know what BTF_INT_UNSIGNED is?

- Sedat -
