Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2531593E
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhBIWRZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 17:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233907AbhBIWJ3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 17:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0hty/1N2nNDoySj6uUiH4vrUX6CERHagjY1LtXvMBs=;
        b=DA+sOhqajn3c6sWM8ZEvdS+2i99NFm1wMJ9RiBiyC9zGIPsN6g+azHJF5hY9z9QEiQ3ZMW
        PLtoplrEZ97a3uWeAl+LzJ4C6bWafJia5xABqdogWBe1TJWJIq6JUWknC1O2vRI3qDWTiU
        Yo8VqCRZa1DcltJ0ijAk4CfC/Bw0dSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-CEflJrryPAu39YK5HzIMng-1; Tue, 09 Feb 2021 16:55:12 -0500
X-MC-Unique: CEflJrryPAu39YK5HzIMng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC3E818A08C3;
        Tue,  9 Feb 2021 21:55:09 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id A6C44100164C;
        Tue,  9 Feb 2021 21:55:06 +0000 (UTC)
Date:   Tue, 9 Feb 2021 22:55:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: FAILED unresolved symbol vfs_truncate on arm64 with LLVM
Message-ID: <YCMEucGZVPPQuxWw@krava>
References: <20210209034416.GA1669105@ubuntu-m3-large-x86>
 <CAEf4BzYnT-eoKRL9_Pu_DEuqXVa+edN5F-s+k2RxBSzcsSTJ1g@mail.gmail.com>
 <20210209052311.GA125918@ubuntu-m3-large-x86>
 <CAEf4BzZV0-zx6YKUUKmecs=icnQNXJjTokdkSAoexm36za+wdA@mail.gmail.com>
 <CAEf4BzYvri7wzRnGH_qQbavXOx5TfBA0qx4nYVnn=YNGv+vNVw@mail.gmail.com>
 <CAEf4Bzax90hn_5axpnCpW+E6gVc1mtUgCXWqmxV0tJ4Ud7bsaA@mail.gmail.com>
 <20210209074904.GA286822@ubuntu-m3-large-x86>
 <YCKB1TF5wz93EIBK@krava>
 <YCKlrLkTQXc4Cyx7@krava>
 <CAEf4BzaL=qsSyDc8OxeN4pr7+Lvv+de4f+hM5a56LY8EABAk3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaL=qsSyDc8OxeN4pr7+Lvv+de4f+hM5a56LY8EABAk3w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 09, 2021 at 12:59:51PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 9, 2021 at 7:09 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Feb 09, 2021 at 01:36:41PM +0100, Jiri Olsa wrote:
> > > On Tue, Feb 09, 2021 at 12:49:04AM -0700, Nathan Chancellor wrote:
> > > > On Mon, Feb 08, 2021 at 10:56:36PM -0800, Andrii Nakryiko wrote:
> > > > > On Mon, Feb 8, 2021 at 10:13 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 8, 2021 at 10:09 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 8, 2021 at 9:23 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 08, 2021 at 08:45:43PM -0800, Andrii Nakryiko wrote:
> > > > > > > > > On Mon, Feb 8, 2021 at 7:44 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi all,
> > > > > > > > > >
> > > > > > > > > > Recently, an issue with CONFIG_DEBUG_INFO_BTF was reported for arm64:
> > > > > > > > > > https://groups.google.com/g/clang-built-linux/c/de_mNh23FOc/m/E7cu5BwbBAAJ
> > > > > > > > > >
> > > > > > > > > > $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
> > > > > > > > > >                       LLVM=1 O=build/aarch64 defconfig
> > > > > > > > > >
> > > > > > > > > > $ scripts/config \
> > > > > > > > > >     --file build/aarch64/.config \
> > > > > > > > > >     -e BPF_SYSCALL \
> > > > > > > > > >     -e DEBUG_INFO_BTF \
> > > > > > > > > >     -e FTRACE \
> > > > > > > > > >     -e FUNCTION_TRACER
> > > > > > > > > >
> > > > > > > > > > $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
> > > > > > > > > >                       LLVM=1 O=build/aarch64 olddefconfig all
> > > > > > > > > > ...
> > > > > > > > > > FAILED unresolved symbol vfs_truncate
> > > > > > > > > > ...
> > > > > > > > > >
> > > > > > > > > > My bisect landed on commit 6e22ab9da793 ("bpf: Add d_path helper")
> > > > > > > > > > although that seems obvious given that is what introduced
> > > > > > > > > > BTF_ID(func, vfs_truncate).
> > > > > > > > > >
> > > > > > > > > > I am using the latest pahole v1.20 and LLVM is at
> > > > > > > > > > https://github.com/llvm/llvm-project/commit/14da287e18846ea86e45b421dc47f78ecc5aa7cb
> > > > > > > > > > although I can reproduce back to LLVM 10.0.1, which is the earliest
> > > > > > > > > > version that the kernel supports. I am very unfamiliar with BPF so I
> > > > > > > > > > have no idea what is going wrong here. Is this a known issue?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I'll skip the reproduction games this time and will just request the
> > > > > > > > > vmlinux image. Please upload somewhere so that we can look at DWARF
> > > > > > > > > and see what's going on. Thanks.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Sure thing, let me know if this works. I uploaded in two places to make
> > > > > > > > it easier to grab:
> > > > > > > >
> > > > > > > > zstd compressed:
> > > > > > > > https://github.com/nathanchance/bug-files/blob/3b2873751e29311e084ae2c71604a1963f5e1a48/btf-aarch64/vmlinux.zst
> > > > > > > >
> > > > > > >
> > > > > > > Thanks. I clearly see at least one instance of seemingly well-formed
> > > > > > > vfs_truncate DWARF declaration. Also there is a proper ELF symbol for
> > > > > > > it. Which means it should have been generated in BTF, but it doesn't
> > > > > > > appear to be, so it does seem like a pahole bug. I (or someone else
> > > > > > > before me) will continue tomorrow.
> > > > > > >
> > > > > > > $ llvm-dwarfdump vmlinux
> > > > > > > ...
> > > > > > >
> > > > > > > 0x00052e6f:   DW_TAG_subprogram
> > > > > > >                 DW_AT_name      ("vfs_truncate")
> > > > > > >                 DW_AT_decl_file
> > > > > > > ("/home/nathan/cbl/src/linux/include/linux/fs.h")
> > > > > > >                 DW_AT_decl_line (2520)
> > > > > > >                 DW_AT_prototyped        (true)
> > > > > > >                 DW_AT_type      (0x000452cb "long int")
> > > > > > >                 DW_AT_declaration       (true)
> > > > > > >                 DW_AT_external  (true)
> > > > > > >
> > > > > > > 0x00052e7b:     DW_TAG_formal_parameter
> > > > > > >                   DW_AT_type    (0x00045fc6 "const path*")
> > > > > > >
> > > > > > > 0x00052e80:     DW_TAG_formal_parameter
> > > > > > >                   DW_AT_type    (0x00045213 "long long int")
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > >
> > > > > > ... and here's the *only* other one (not marked as declaration, but I
> > > > > > thought we already handle that, Jiri?):
> > > > > >
> > > > > > 0x01d0da35:   DW_TAG_subprogram
> > > > > >                 DW_AT_low_pc    (0xffff80001031f430)
> > > > > >                 DW_AT_high_pc   (0xffff80001031f598)
> > > > > >                 DW_AT_frame_base        (DW_OP_reg29)
> > > > > >                 DW_AT_GNU_all_call_sites        (true)
> > > > > >                 DW_AT_name      ("vfs_truncate")
> > > > > >                 DW_AT_decl_file ("/home/nathan/cbl/src/linux/fs/open.c")
> > > > > >                 DW_AT_decl_line (69)
> > > > > >                 DW_AT_prototyped        (true)
> > > > > >                 DW_AT_type      (0x01cfdfe4 "long int")
> > > > > >                 DW_AT_external  (true)
> > > > > >
> > > > >
> > > > > Ok, the problem appears to be not in DWARF, but in mcount_loc data.
> > > > > vfs_truncate's address is not recorded as ftrace-attachable, and thus
> > > > > pahole ignores it. I don't know why this happens and it's quite
> > > > > strange, given vfs_truncate is just a normal global function.
> > >
> > > right, I can't see it in mcount adresses.. but it begins with instructions
> > > that appears to be nops, which would suggest it's traceable
> > >
> > >       ffff80001031f430 <vfs_truncate>:
> > >       ffff80001031f430: 5f 24 03 d5   hint    #34
> > >       ffff80001031f434: 1f 20 03 d5   nop
> > >       ffff80001031f438: 1f 20 03 d5   nop
> > >       ffff80001031f43c: 3f 23 03 d5   hint    #25
> > >
> > > > >
> > > > > I'd like to understand this issue before we try to fix it, but there
> > > > > is at least one improvement we can make: pahole should check ftrace
> > > > > addresses only for static functions, not the global ones (global ones
> > > > > should be always attachable, unless they are special, e.g., notrace
> > > > > and stuff). We can easily check that by looking at the corresponding
> > > > > symbol. But I'd like to verify that vfs_truncate is ftrace-attachable
> >
> > I'm still trying to build the kernel.. however ;-)
> >
> > patch below adds the ftrace check only for static functions
> > and lets the externa go through.. but as you said, in this
> > case we'll need to figure out the 'notrace' and other checks
> > ftrace is doing
> >
> > jirka
> >
> >
> > ---
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index b124ec20a689..4d147406cfa5 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -734,7 +734,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                         continue;
> >                 if (!has_arg_names(cu, &fn->proto))
> >                         continue;
> > -               if (functions_cnt) {
> > +               if (!fn->external && functions_cnt) {
> 
> I wouldn't trust DWARF, honestly. Wouldn't checking GLOBAL vs LOCAL
> FUNC ELF symbol be more reliable?

that'd mean extra bsearch on each processed function,
on the ther hand, we'are already slow ;-) I'll check
how big the slowdown would be

jirka

