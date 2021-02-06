Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04208311A3E
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 04:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBFDhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 22:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhBFDfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:37 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDECC06174A;
        Fri,  5 Feb 2021 19:34:56 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n2so9308101iom.7;
        Fri, 05 Feb 2021 19:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=sx+cmLwR+MiZoGwD22OjNTjFyoCsqtP98Gt/hEHeCy0=;
        b=lJ2DMN/Hyb1Q7p6UDt56PLldvTrV95J+C7/GFpa0x0qWOBx9ghU+fv0CIvCboFv7nR
         HhLGrVZXaQ8Z0DBP0dbI6UO+CLrFDBn/GhO9Uqdn4QnVa5jOmmkl60SQquSFpJSbRKuV
         m7qAqcbs9ibz40ExCPW8iZumWloAjFlE96R1Y78xkB2sXf7C7unD/BGVuwQ5zAf/3lF3
         ChSWhs5jdADWBu9art5+LUG+j44wUka/nYVNFuJKn7mUB16SZheQbnc1sWXr4NItkEKz
         HbJYJ599hDigR8jFGKNad77uWnzWYnO8UYrGN6Ow70/2LhrKz1WnoaiB75r5mmxFtyr0
         kN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=sx+cmLwR+MiZoGwD22OjNTjFyoCsqtP98Gt/hEHeCy0=;
        b=AsBVbF72yXgRp2XAWgbnomkPBkiOglsSnL3Hm/2jQGFK7GE1W6950IxJrDxjzdWzn8
         uy9nBfwQ7A3WaaGOcQGjWko40p+V5tNvPnSAhq0kRYC4BDPkKhFcqzMuONmDW2Yy8cxn
         HmqQw4DgI55pI91NKB6aG1f/a22hGnHrmnvNsQwaXyWkU+r7HUL82KsHGQyEbueYTFi9
         vSrQUdBNxBuFp2KFtTK3Uj8biSQB7p75oqAzFY6uvH3M5YobjESU/CFXRp4rs28KuL0c
         Mpyks6ZLs/O/S4FIPdOogKX7ot3jkUXpH3xJfiyjbpar4lVmUfq/tYmWJqzbRIpk70Tu
         Gb1g==
X-Gm-Message-State: AOAM531GlHzPAXVcQM3TZpjX+b9Na3PghusV8KeIG2jymfF8jljhcF9q
        Kc20NcGgQJL3eGwGJY58JhWwiqlNGbMVeDnMdZY=
X-Google-Smtp-Source: ABdhPJx9edJx2FuQUFt7ePFg+XPE5cLldPxN+L7oLmeMbR2nTP66VN6fYfBkRdkYhkzF5AlrsK3tz1hVph48grqwd/Y=
X-Received: by 2002:a02:74a:: with SMTP id f71mr7894312jaf.30.1612582495700;
 Fri, 05 Feb 2021 19:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com> <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
In-Reply-To: <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 04:34:43 +0100
Message-ID: <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 10:54 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/5/21 12:31 PM, Sedat Dilek wrote:
> > On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> >>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> >>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> >>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> >>>>> know what BTF_INT_UNSIGNED is?
> >>>
> >>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> >>>> ignore this for now until kernel infrastructure is ready.
> >>>
> >>> Yeah, I thought about doing that.
> >>>
> >>>> Not sure whether this information will be useful or not
> >>>> for BTF. This needs to be discussed separately.
> >>>
> >>> Maybe search for the rationale for its introduction in DWARF.
> >>
> >> In LLVM, we have:
> >>     uint8_t BTFEncoding;
> >>     switch (Encoding) {
> >>     case dwarf::DW_ATE_boolean:
> >>       BTFEncoding = BTF::INT_BOOL;
> >>       break;
> >>     case dwarf::DW_ATE_signed:
> >>     case dwarf::DW_ATE_signed_char:
> >>       BTFEncoding = BTF::INT_SIGNED;
> >>       break;
> >>     case dwarf::DW_ATE_unsigned:
> >>     case dwarf::DW_ATE_unsigned_char:
> >>       BTFEncoding = 0;
> >>       break;
> >>
> >> I think DW_ATE_unsigned can be ignored in pahole since
> >> the default encoding = 0. A simple comment is enough.
> >>
> >
> > Yonghong Son, do you have a patch/diff for me?
>
> Looking at error message from log:
>
>   LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> .tmp_vmlinux.btf
> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.
>
> Not exactly what is the root cause. Maybe bt->bit_size is not
> encoded correctly. Could you put vmlinux (in the above it is
> .tmp_vmlinux.btf) somewhere, I or somebody else can investigate
> and provide a proper fix.
>

[ TO: Masahiro ]

Thanks for taking care Yonghong - hope this is your first name, if not
I am sorry.
In case of mixing my first and last name you will make me female -
Dilek is a Turkish female first name :-).
So, in some cultures you need to be careful.

Anyway... back to business and facts.

Out of frustration I killed my last build via `make distclean`.
The whole day I tested diverse combination of GCC-10 and LLVM-12
together with BTF Kconfigs, selfmade pahole, etc.

I will do ne run with some little changes:

#1: Pass LLVM_IAS=1 to make (means use Clang's Integrated ASsembler -
as per Nick this leads to the same error - should be unrelated)
#2: I did: DEBUG_INFO_COMPRESSED y -> n

#2 I did in case you need vmlinux and I have to upload - I will
compress the resulting vmlinux with ZSTD.
You need vmlinux or .tmp_vmlinux.btf file?
Nick was not allowed from his company to download from a Dropbox link.
So, as an alternative I can offer GoogleDrive...
...or bomb into your INBOX :-).

Now, why I CCed Masahiro:

In case of ERRORs when running `scripts/link-vmlinux.sh` above files
will be removed.

Last, I found a hack to bypass this - means to keep these files (I
need to check old emails).

Masahiro, you see a possibility to have a way to keep these files in
case of ERRORs without doing hackery?

From a previous post in this thread:

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

^^^ Look here.

Thanks.

Regards,
- Sedat -
