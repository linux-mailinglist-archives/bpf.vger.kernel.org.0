Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E958311BA2
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 06:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBFFpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 00:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBFFpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 00:45:44 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C3C061756;
        Fri,  5 Feb 2021 21:45:03 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n14so9522031iog.3;
        Fri, 05 Feb 2021 21:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mgvcpTTcW8PBaaNw1Tjnl6h6thHbP/Gn/IDAfwrlkkU=;
        b=VldFKiEEu7U+UcM3QrdBSXAMdJfqI0kFAtUSK+dx84EZiUlu6y3daYvmGeR5D+Abao
         ilMejG3CCT5PJ7Vsa4L+hPzVX1VDC4aFgBpyj63yadjUNaWPCZHKIvvC34c4gKSPUuV8
         j8fFkJ/k/Z9PFSLQBvn3t4vTOqtolKbqjBznoPlcMbGkxj6lD7NQqwVPcWn6CjpyEPxq
         VLWCGmJISQJhRl8pHHqTkBL7hAbdT+uQODHd4kyDRbn17Et0HBO9TDg4eCxX7CCbR6HV
         Zptqpm/bLcDdTO1+3KOWYuSCc/G9GNyZJCQzUVe94wxhWX2rKUe04DrsC14PlSbYWZR4
         uRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mgvcpTTcW8PBaaNw1Tjnl6h6thHbP/Gn/IDAfwrlkkU=;
        b=PRctIJc+s1eE4KtGUf0BpB/IZZ0Mhtvk6CJ1byf26vxlr0tGqmLKEcjyGnXGAyWHJV
         bB9lmh0r+MCfE00gBp2GAxcXcA4Iq21pQIM7f7o6ATZZSFKHts1VSBWVcPV3PQBMGgew
         /hD9TvbAbNYEU55Vj5uenEO4RmEfazs3KOy2PHJR+RoGDpTLyY2scp9tkfjuUUcjUT89
         JzSLywhJWrN1d1mWJFqMASgkK7ceQrLRR43KupQFG9wbfXnTrTMkSVCQa041/Ja1L7Sr
         d6ZvSb09QJI1ZqnTtVcmNrF80cmLWUFy9sMUzrirJuKrWp1T7mvLRD31CEy1QTO1ccqj
         h8DQ==
X-Gm-Message-State: AOAM533+zWAFxGgZNd/CeU7VI76UZ286q7PkMCHOGmyu0EVZDaBJWwAu
        WFgKZcaABgwFr9jkEPMh/NBQaxGjJVijFzZ/U4U=
X-Google-Smtp-Source: ABdhPJxa40h6vLZElnkuF5kQU3sHGXGNj8iskk8P0AaI34eleLj1HXcTceml9ECM8EDerRsCo/qtbiDA3924Yu33hTo=
X-Received: by 2002:a05:6638:251:: with SMTP id w17mr8218734jaq.138.1612590302568;
 Fri, 05 Feb 2021 21:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com> <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com> <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
In-Reply-To: <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 06:44:50 +0100
Message-ID: <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>, Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sat, Feb 6, 2021 at 4:34 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 10:54 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 2/5/21 12:31 PM, Sedat Dilek wrote:
> > > On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> > >>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> > >>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> > >>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> > >>>>> know what BTF_INT_UNSIGNED is?
> > >>>
> > >>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> > >>>> ignore this for now until kernel infrastructure is ready.
> > >>>
> > >>> Yeah, I thought about doing that.
> > >>>
> > >>>> Not sure whether this information will be useful or not
> > >>>> for BTF. This needs to be discussed separately.
> > >>>
> > >>> Maybe search for the rationale for its introduction in DWARF.
> > >>
> > >> In LLVM, we have:
> > >>     uint8_t BTFEncoding;
> > >>     switch (Encoding) {
> > >>     case dwarf::DW_ATE_boolean:
> > >>       BTFEncoding = BTF::INT_BOOL;
> > >>       break;
> > >>     case dwarf::DW_ATE_signed:
> > >>     case dwarf::DW_ATE_signed_char:
> > >>       BTFEncoding = BTF::INT_SIGNED;
> > >>       break;
> > >>     case dwarf::DW_ATE_unsigned:
> > >>     case dwarf::DW_ATE_unsigned_char:
> > >>       BTFEncoding = 0;
> > >>       break;
> > >>
> > >> I think DW_ATE_unsigned can be ignored in pahole since
> > >> the default encoding = 0. A simple comment is enough.
> > >>
> > >
> > > Yonghong Son, do you have a patch/diff for me?
> >
> > Looking at error message from log:
> >
> >   LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > .tmp_vmlinux.btf
> > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > Encountered error while encoding BTF.
> >
> > Not exactly what is the root cause. Maybe bt->bit_size is not
> > encoded correctly. Could you put vmlinux (in the above it is
> > .tmp_vmlinux.btf) somewhere, I or somebody else can investigate
> > and provide a proper fix.
> >
>
> [ TO: Masahiro ]
>
> Thanks for taking care Yonghong - hope this is your first name, if not
> I am sorry.
> In case of mixing my first and last name you will make me female -
> Dilek is a Turkish female first name :-).
> So, in some cultures you need to be careful.
>
> Anyway... back to business and facts.
>
> Out of frustration I killed my last build via `make distclean`.
> The whole day I tested diverse combination of GCC-10 and LLVM-12
> together with BTF Kconfigs, selfmade pahole, etc.
>
> I will do ne run with some little changes:
>
> #1: Pass LLVM_IAS=1 to make (means use Clang's Integrated ASsembler -
> as per Nick this leads to the same error - should be unrelated)
> #2: I did: DEBUG_INFO_COMPRESSED y -> n
>
> #2 I did in case you need vmlinux and I have to upload - I will
> compress the resulting vmlinux with ZSTD.
> You need vmlinux or .tmp_vmlinux.btf file?
> Nick was not allowed from his company to download from a Dropbox link.
> So, as an alternative I can offer GoogleDrive...
> ...or bomb into your INBOX :-).
>
> Now, why I CCed Masahiro:
>
> In case of ERRORs when running `scripts/link-vmlinux.sh` above files
> will be removed.
>
> Last, I found a hack to bypass this - means to keep these files (I
> need to check old emails).
>
> Masahiro, you see a possibility to have a way to keep these files in
> case of ERRORs without doing hackery?
>
> From a previous post in this thread:
>
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>  BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
> [2] INT long unsigned int Error emitting BTF type
> Encountered error while encoding BTF.
> + llvm-objcopy --only-section=.BTF --set-section-flags
> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> ...
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>  BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> + on_exit
> + [ 255 -ne 0 ]
> + cleanup
> + rm -f .btf.vmlinux.bin.o
> + rm -f .tmp_System.map
> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
> 2.o
> + rm -f System.map
> + rm -f vmlinux
> + rm -f vmlinux.o
> make[3]: *** [Makefile:1166: vmlinux] Error 255
>
> ^^^ Look here.
>

With this diff:

$ git diff scripts/link-vmlinux.sh
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index eef40fa9485d..40f1b6aae553 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -330,7 +330,7 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
# fill in BTF IDs
if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
       info BTFIDS vmlinux
-       ${RESOLVE_BTFIDS} vmlinux
+       ##${RESOLVE_BTFIDS} vmlinux
fi

if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then

This files are kept - not removed:

$ LC_ALL=C ll .*btf* vmlinux vmlinux.o
-rwxr-xr-x 1 dileks dileks  31M Feb  6 06:37 .btf.vmlinux.bin.o
-rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 .tmp_vmlinux.btf
-rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 vmlinux
-rw-r--r-- 1 dileks dileks 344M Feb  6 06:37 vmlinux.o

Pleas let me know where to upload - Dropbox or GoogleDrive or
elsewhere and give me a link.

Thanks.

- Sedat -
