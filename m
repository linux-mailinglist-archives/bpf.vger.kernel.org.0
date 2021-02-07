Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00131250D
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGPQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 10:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhBGPPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 10:15:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D49C06174A;
        Sun,  7 Feb 2021 07:15:12 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q7so12448300iob.0;
        Sun, 07 Feb 2021 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rhjYjhTCecyJqM3ffrZMkdxhbCsg5neEz+2qVaWuRDk=;
        b=u0Z+zPgQJdVtNNm/xr88DrgxcqhmcLybwumXBtgYakAKBGhN9wwHe1zrBixhjZTs69
         CuXs+FtflNxDkBSpfH+j/xjpFjvSSUYUTg6lFZ9rNKQsIXRa185t8S3iM3aSSWQ/YCD+
         fUEQG+Ra8U/11bOCBZjq8insAET6UQ5qJw9nCNhVK0FiqdM+CLcdlfuA5JOnnsjzIYrW
         ONPCAMMyWS7mmQxBlQHybgXSs2cKfPD1INcVAJ4r1K6iCutgtewK+tZFbAY1evZZG9i3
         M1Z6LdT3cVmWfOVt08GT7NWmuloIyj8Ql6NbpezImoxTjiKfP5LmCWEPSA4+sU5NPtC5
         LNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rhjYjhTCecyJqM3ffrZMkdxhbCsg5neEz+2qVaWuRDk=;
        b=hprIpc/Jurv089wmTlzHvUfsz5gfJ5u/iOvBwPB2JN84DNnJ6jYqmxB2WsU8Qyn5Ow
         lLDi3Lk71/KZVRRgn/TCDm3+pzkuC9V8hPhWea+jbdxe+Wmx8z3qeHdem3DVYuDvt7ZG
         CzGaGwfCtoExYLAnNqJiDv4diT4SUXGvWhbqv7HN6RUcvLVV1eQu5pa46kuYgGdZxHVK
         UuclhFn/XtismctVLkhCtox11K3fEZ3DXvkSDG+A/bzNQE1CwVyYOg7c6TKPvJFx1dps
         doHPd5DY50HIBBSj2iUOC+/NB4uFgkFO10AkMjQxOMn14dRiwk0Su0j2iN2wMExaJNH2
         b2kg==
X-Gm-Message-State: AOAM533lEwgRmLCt4s6gYrHTuyTTgBKjxvh2XeODdMSHDSg5Bep1dbf/
        nZWxTVlfIuAxmxbA8Bc0X6SRj1PdDzsVWTGpS64=
X-Google-Smtp-Source: ABdhPJw0beRkyQbq3OqaZJUG5P5qxept+1JkByu3nJKsI0jL9RdB1hG9YNfoXUrLypmBa7jwgAVqPMk+k/sDDqv231E=
X-Received: by 2002:a02:9308:: with SMTP id d8mr4643209jah.138.1612710911998;
 Sun, 07 Feb 2021 07:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
In-Reply-To: <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 7 Feb 2021 16:15:00 +0100
Message-ID: <CA+icZUUVLveJ6EkWvHFbBVHOhkP2oYveCrcE=CzfJBThCx3B8w@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Mark Wielaard <mark@klomp.org>
Cc:     Yonghong Song <yhs@fb.com>, acme@kernel.org,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, andriin@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 7, 2021 at 3:18 PM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
> > clang with dwarf5 may generate non-regular int base type,
> > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > Such base types are often used to describe
> > how an actual parameter or variable is generated. For example,
> >
> > 0x000015cf:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x00)
> >
> > 0x00010ed9:         DW_TAG_formal_parameter
> >                       DW_AT_location    (DW_OP_lit0,
> >                                          DW_OP_not,
> >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> >                                          DW_OP_stack_value)
> >                       DW_AT_abstract_origin     (0x00013984 "branch")
> >
> > What it does is with a literal "0", did a "not" operation, and the converted to
> > one-bit unsigned int and then 8-bit unsigned int.
>
> Thanks for tracking this down. Do you have any idea why the clang
> compiler emits this? You might be right that it is intended to do what
> you describe it does (but then it would simply encode an unsigned
> constant 1 char in a very inefficient way). But as implemented it
> doesn't seem to make any sense. What would DW_OP_convert of an zero
> sized base type even mean (if it is intended as a 1 bit sized typed,
> then why is there no DW_AT_bit_size)?
>
> So I do think your patch makes sense. clang clearly is emitting
> something bogus. And so some fixup is needed. But maybe we should at
> least give a warning about it, otherwise it might never get fixed.
>
> BTW. If these bogus base types are only emitted as part of a location
> expression and not as part of an actual function or variable type
> description, then why are we even trying to encode it as a BTF type? It
> might be cheaper to just skip/drop it. But maybe the code setup makes
> it hard to know whether or not such a (bogus) type is actually
> referenced from a function or variable description?
>

As said this is with LLVM/Clang v12.0.0-rc1 and `make LLVM=1
LLVM_IAS=1` means use all LLVM tools (do not use GNU/binutils like
GNU/ld BFD) and Clang's Integrated ASsembler (means do not use GNU
AS).

When doing an indexed search for "DW_ATE_unsigned"...

...this points to changes recently done in places like
llvm/lib/CodeGen/AsmPrinter/.

I see 16 changes there touching DWARF-x area since llvmorg-12.0.0-rc1 release:

$ git log --oneline llvmorg-12.0.0-rc1.. llvm/lib/CodeGen/AsmPrinter/
e44a10094283 .gcc_except_table: Set SHF_LINK_ORDER if binutils>=2.36,
and drop unneeded unique ID for -fno-unique-section-names
853a2649160c [AsmPrinter] __patchable_function_entries: Set
SHF_LINK_ORDER for binutils 2.36 and above
e3c0b0fe0958 [WebAssembly] locals can now be indirect in DWARF
34f3249abdff [DebugInfo] Fix error from D95893, where I accidentally
used an unsigned int in a loop and it wraps around.
a740af4de970 [CodeView][DebugInfo] Update the code for removing
template arguments from the display name of a codeview function id.
56fa34ae3570 DebugInfo: Temporarily work around -gsplit-dwarf + LTO
.debug_gnu_pubnames regression after D94976
8998f5843503 Re-land D94976 after revert in e29552c5aff6
d32deaab4d53 Revert "[DWARF] Location-less inlined variables should
not have DW_TAG_variable"
ddc2f1e3fb4f [DWARF] Location-less inlined variables should not have
DW_TAG_variable
511c9a76fb98 [AsmPrinter] Use ListSeparator (NFC)
85b7b5625a00 Fix memory leak in 4318028cd2d7633a0cdeb0b5d4d2ed81fab87864
4318028cd2d7 DebugInfo: Add a DWARF FORM extension for addrx+offset
references to reduce relocations
e29552c5aff6 Revert "[DWARF] Create subprogram's DIE in DISubprogram's unit"
dd7297e1bffe DebugInfo: Fix bug in addr+offset exprloc to use DWARFv5
addrx op instead of DWARFv4 GNU extension
7e6c87ee0454 DebugInfo: Deduplicate addresses in debug_addr
ef0dcb506300 [DWARF] Create subprogram's DIE in DISubprogram's unit

What I try to say is with LLVM-13 (git) this might look different?

Here, I have a LLVM-12 ThinLTO+PGO optimized toolchain which saves 1/3
of Linux-kernel build-time.
So, I do not want to switch to Debian's or packages from <apt.llvm.org>.
These binaries take much much longer and I do not know if I get some
new issues with Linux v5.11-rc6+.

Again, I am not a LLVM toolchain expert.
Best is to ask on llvm-dev mailing-list?

Thanks.

- Sedat -



[1] https://github.com/llvm/llvm-project/search?o=desc&q=DW_ATE_unsigned&s=indexed
