Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87CC2F6A04
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbhANSx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhANSx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:53:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A9C0613C1
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:53:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h10so3888097pfo.9
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etEJQyE4wI0xqWJz8agLY3zHi4W3c5fEnAfHXnXZRx4=;
        b=PkfoBY28Z0KZd+sJWOsFzHre7U+J5Q9Ahv42tts9JioNQsOe3PcXmNv+9C2ByJiSVS
         22nAALAvEsCbETcdwhMQ3PVxhWR7R6/uD09fr/xz9+q5TdQfuDnUfpubORpm9VpkijpV
         gUVNVOxe1lb2kq8KQxokHVknP/g+oFDtdH4r3+LSJuxXybZBATZMh2NBmnQ22fcbzBKf
         YtwBSRAo3ULo2U8g1prwHLkaWKkW8qIs8IZGBxTOHA1hJwyCDzz8A/pztfAsRJXhBOsp
         QKaehCoC4s+sFVSyQhGcui5QhqVAtnQ8DdCQlxWAEKAo/1D3j/cbEeL/pSNlZLT3rBPQ
         IfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etEJQyE4wI0xqWJz8agLY3zHi4W3c5fEnAfHXnXZRx4=;
        b=ZKi5nGKZQ78LAXagNPqCjhXVQ6AgKI5ou0rAmjC8GwCkHN4xLND4u0N+q5gcfZQq75
         CF7qtMafOEKsT/vJzTcII2dHGMAiS5WlqzS8q5AXRGu0hAxtyWouKIEVJd4DieaiJDJY
         oafElVKFYRf4l+gw3aD6OmWZRGBZ6St+eQQdoFHCfI32fW7teILDiENoveq3KCDv5poY
         UhpoHrTQpaF8UPjigSkApWIfQII2jedKvA/HKKf/L/6yDcrRVxnhJZvXUx/IkHa0mGka
         GcdP6WvN52ST06172Mm2w8IM0tsBdaCQALcOWDIiBcaCEdHZ7K7Izya0TVVF5BvBqbMD
         sDtg==
X-Gm-Message-State: AOAM531CCeGx7vsyPCl7fwYtFJaXRSpTaQgUPqjjL8WW02vtj9uHTjf8
        y6A46tqschU719w3mJeDHMR1ULDPpINzL75P3tCxwg==
X-Google-Smtp-Source: ABdhPJw38RHREm7Yzl2+YeiPnoudzHETWhrvYLvHmrWnfe86WnAr71gkSEfCUUdTGK65f4KE1GJr4g9I5gXheZcJEQw=
X-Received: by 2002:a62:7c4a:0:b029:19d:b7bc:2c51 with SMTP id
 x71-20020a627c4a0000b029019db7bc2c51mr8801353pfc.30.1610650397614; Thu, 14
 Jan 2021 10:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com> <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
In-Reply-To: <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 10:53:06 -0800
Message-ID: <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 10:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
> >> CONFIG_DEBUG_INFO_BTF=y:
> >>
> >> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
> >> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!

I can confirm that I see a stream of these warnings when building with
this patch series applied, and those two configs enabled.

rebuilding with `make ... V=1`, it looks like the call to:

+ pahole -J .tmp_vmlinux.btf

is triggering these.

Shall I send a v4 that adds a Kconfig dependency on !DEBUG_INFO_BTF?
Does pahole have a bug tracker?

> >>
> >> In /usr/include/dwarf.h I found:
> >>
> >> 498:    DW_OP_lit24 = 0x48,                /* Literal 24.  *
> >
> >
> > There are multiple dwarf objects with the value 0x48, depending on which section of the dwarf.h file you search:
> >
> > DW_TAG_call_site = 0x48
> > DW_AT_static_link = 0x48
> > DW_OP_lit24 = 0x48.
> >
> > In this case, since the error message was about a DW_TAG, it would be complaining about DW_TAG_call_site, which is new to DWARF v5.
> >
> Example for "DW_TAG_INVALID (0x48)" from my build-log:
>
> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x1f671e7> not handled!
>
> $ llvm-dwarfdump-11 --debug-info=0x1f671e7 vmlinux
> vmlinux:        file format elf64-x86-64
>
> .debug_info contents:
>
> 0x01f671e7: DW_TAG_call_site
>              DW_AT_call_return_pc      (0xffffffff811b16f2)
>              DW_AT_call_origin (0x01f67f1d)
>
> Looking for "DW_AT_call_origin (0x01f67f1d)":
>
> $ llvm-dwarfdump-11 --debug-info=0x01f67f1d vmlinux
> vmlinux:        file format elf64-x86-64
>
> .debug_info contents:
>
> 0x01f67f1d: DW_TAG_subprogram
>              DW_AT_external    (true)
>              DW_AT_declaration (true)
>              DW_AT_linkage_name        ("fput")
>              DW_AT_name        ("fput")
>              DW_AT_decl_file
> ("/home/dileks/src/linux-kernel/git/./include/linux/file.h")
>              DW_AT_decl_line   (16)
>              DW_AT_decl_column (0x0d)

That's a neat trick (using --debug-info=offset to print one element
from the stream).
-- 
Thanks,
~Nick Desaulniers
