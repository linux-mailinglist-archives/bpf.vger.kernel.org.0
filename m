Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8C39CA7D
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhFESXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Jun 2021 14:23:37 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:46977 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFESXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Jun 2021 14:23:37 -0400
Received: by mail-ua1-f46.google.com with SMTP id p1so7161729uam.13;
        Sat, 05 Jun 2021 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzZZh4edDOB7247AHfLiMcDvyzZxdoaMtET9kddA+Fs=;
        b=h06dzvUxtdNq5eESxWGBS+9Bvnft/dV0vkVd1OxxrJZ3ogzuJxNAA/qT9enUDN1XBU
         m0Ya0wmSSlCiYWFTTWftNZ//68MzN4a67aody+0bu/UgNlWRfF69VOHzjiSzRiUhqlAK
         6cNm0CC4IY5lN5q2Y6sgGroR0MzTzB0Sxh1LhtvwZ16POZ8YStq6tL71dJYC/wBtB0zn
         PmhsdmZuPZD4EXcTLK19DPUIoLZbE9Fvn1IrPHRysRd1hg8dSSRaJFL9m3EJGzA0UsJ1
         K2SbyBc7PKZRSIaev1Qjj8U/MnmBUWWqxLfkQk3Ny0acYnOYA5ODELV6R7x3XD2sx2NA
         2Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzZZh4edDOB7247AHfLiMcDvyzZxdoaMtET9kddA+Fs=;
        b=MSh61iaHxf/u1iEZ6NWbWwIZfc+WvvHCif4U9dqLOy6/5HkZbm0FVknVhdOtPpB0mZ
         YBeGNeLBFWZ1SnMiFuT12wZHeFW76Ox8Nvwmbod+XVXORcy9natLzZHnv7Sm9PuFNSdJ
         T25TGIja3ioxESonvRBYPa4OReIc+SCY75Z51rOlUrXqORaAdCpdDnV52j+s1gFQ4c66
         PISy4Knoeo3Pw9R6lJWxopQcTX9k8/TTOyuU3tqp1j++TaD55Ctxq2Rmv1zdksjZ4OtJ
         QHAPxXCAcGO+LGdLMXqBZGnMUxMbcWU52i6MGyy7UgyJT6NXC5R1Jlw5ZzW4hGFtVLzj
         OiVQ==
X-Gm-Message-State: AOAM530RLSv+kFL6i7OFs/6BSknS3nY53eLv7w5Fdag9yY7TvplrWm7d
        oJ8W0K6KOwnx/39pBjW7EdwKOTbhFV1avWAwr5I7eG3rljDdZZxF
X-Google-Smtp-Source: ABdhPJwRAw21aJTuE62LM5U/Q7saDl0iOYDg/iRJZEKr3OAv7O00x2VsE8S9T023e4ZreD1ScR84eJNExPNynzIB+3I=
X-Received: by 2002:a1f:a08e:: with SMTP id j136mr5457410vke.25.1622917234023;
 Sat, 05 Jun 2021 11:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210531195553.168298-1-grantseltzer@gmail.com>
 <20210531195553.168298-2-grantseltzer@gmail.com> <CAEf4BzaKBHy16R4WQEgi0Cyy_6a3EVtBBo=0yRm7K4nF2X53qQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaKBHy16R4WQEgi0Cyy_6a3EVtBBo=0yRm7K4nF2X53qQ@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Sat, 5 Jun 2021 14:20:23 -0400
Message-ID: <CAO658oVB-2LDUsbbe0Y2E5hMP5tRb16GmJhBWjuvJ4gice6mEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] Add documentation for libbpf including API autogen
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 2, 2021 at 4:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 31, 2021 at 12:56 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > This adds rst files containing documentation for libbpf. This includes
> > the addition of libbpf_api.rst which pulls comment documentation from
> > header files in libbpf under tools/lib/bpf/. The comment docs would be
> > of the standard kernel doc format.
> >
> > Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> > ---
>
> Looks good, thanks! See few comments below. Let's figure out what to
> do with libbpf docs versioning and land it through bpf-next tree.
>
> >  Documentation/bpf/index.rst                   |  13 ++
> >  Documentation/bpf/libbpf.rst                  |  14 ++
> >  Documentation/bpf/libbpf_api.rst              |  18 ++
> >  Documentation/bpf/libbpf_build.rst            |  37 ++++
> >  .../bpf/libbpf_naming_convention.rst          | 170 ++++++++++++++++++
> >  5 files changed, 252 insertions(+)
> >  create mode 100644 Documentation/bpf/libbpf.rst
> >  create mode 100644 Documentation/bpf/libbpf_api.rst
> >  create mode 100644 Documentation/bpf/libbpf_build.rst
> >  create mode 100644 Documentation/bpf/libbpf_naming_convention.rst
> >
>
> [...]
>
> > +API
> > +===
> > +
> > +This documentation is autogenerated from header files in libbpf, tools/lib/bpf
> > +
> > +.. kernel-doc:: tools/lib/bpf/libbpf.h
> > +   :internal:
> > +
> > +.. kernel-doc:: tools/lib/bpf/bpf.h
> > +   :internal:
> > +
> > +.. kernel-doc:: tools/lib/bpf/btf.h
> > +   :internal:
> > +
> > +.. kernel-doc:: tools/lib/bpf/xsk.h
> > +   :internal:
>
> Libbpf API has a BPF side as well (bpf_helpers.h which pulls in
> auto-generated bpf_helper_defs.h with all BPF helper definitions,
> bpf_tracing.h, bpf_core_read.h, bpf_endian.h), we should probably
> expose them as well?
>
> > diff --git a/Documentation/bpf/libbpf_build.rst b/Documentation/bpf/libbpf_build.rst
> > new file mode 100644
> > index 000000000..b8240eaaa
> > --- /dev/null
> > +++ b/Documentation/bpf/libbpf_build.rst
> > @@ -0,0 +1,37 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Building libbpf
> > +===============
> > +
> > +libelf is an internal dependency of libbpf and thus it is required to link
>
> zlib is another dependency, can you please mention it as well?
>
> > +against and must be installed on the system for applications to work.
> > +pkg-config is used by default to find libelf, and the program called
> > +can be overridden with PKG_CONFIG.
> > +
>
> [...]
>
> > +API naming convention
> > +=====================
> > +
> > +libbpf API provides access to a few logically separated groups of
> > +functions and types. Every group has its own naming convention
> > +described here. It's recommended to follow these conventions whenever a
> > +new function or type is added to keep libbpf API clean and consistent.
> > +
> > +All types and functions provided by libbpf API should have one of the
> > +following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``,
> > +``perf_buffer_``.
>
> ring_buffer_ and btf_dump_ are two others that we use. But I don't
> know how important it is to have an exhaustive list here.
>
> > +
> > +System call wrappers
> > +--------------------
> > +
> > +System call wrappers are simple wrappers for commands supported by
> > +sys_bpf system call. These wrappers should go to ``bpf.h`` header file
> > +and map one-on-one to corresponding commands.
>
> typo: one-to-one?
>
> > +
> > +For example ``bpf_map_lookup_elem`` wraps ``BPF_MAP_LOOKUP_ELEM``
> > +command of sys_bpf, ``bpf_prog_attach`` wraps ``BPF_PROG_ATTACH``, etc.
> > +
> > +Objects
> > +-------
> > +
> > +Another class of types and functions provided by libbpf API is "objects"
> > +and functions to work with them. Objects are high-level abstractions
> > +such as BPF program or BPF map. They're represented by corresponding
> > +structures such as ``struct bpf_object``, ``struct bpf_program``,
> > +``struct bpf_map``, etc.
> > +
> > +Structures are forward declared and access to their fields should be
> > +provided via corresponding getters and setters rather than directly.
> > +
> > +These objects are associated with corresponding parts of ELF object that
> > +contains compiled BPF programs.
> > +
> > +For example ``struct bpf_object`` represents ELF object itself created
> > +from an ELF file or from a buffer, ``struct bpf_program`` represents a
> > +program in ELF object and ``struct bpf_map`` is a map.
> > +
> > +Functions that work with an object have names built from object name,
> > +double underscore and part that describes function purpose.
> > +
> > +For example ``bpf_object__open`` consists of the name of corresponding
> > +object, ``bpf_object``, double underscore and ``open`` that defines the
> > +purpose of the function to open ELF file and create ``bpf_object`` from
> > +it.
> > +
> > +Another example: ``bpf_program__load`` is named for corresponding
> > +object, ``bpf_program``, that is separated from other part of the name
> > +by double underscore.
>
> let's drop this example, bpf_program__load is a bad example and is
> going to be deprecated.  We can use btf__parse() as an example here.
>
> > +
> > +All objects and corresponding functions other than BTF related should go
> > +to ``libbpf.h``. BTF types and functions should go to ``btf.h``.
> > +
> > +Auxiliary functions
> > +-------------------
> > +
> > +Auxiliary functions and types that don't fit well in any of categories
> > +described above should have ``libbpf_`` prefix, e.g.
> > +``libbpf_get_error`` or ``libbpf_prog_type_by_name``.
> > +
> > +AF_XDP functions
> > +-------------------
> > +
> > +AF_XDP functions should have an ``xsk_`` prefix, e.g.
> > +``xsk_umem__get_data`` or ``xsk_umem__create``. The interface consists
> > +of both low-level ring access functions and high-level configuration
> > +functions. These can be mixed and matched. Note that these functions
> > +are not reentrant for performance reasons.
> > +
> > +Please take a look at Documentation/networking/af_xdp.rst in the Linux
> > +kernel source tree on how to use XDP sockets and for some common
> > +mistakes in case you do not get any traffic up to user space.
>
> I'd probably drop this section, given we move xsk.{c,h} into libxdp.
>
> > +
> > +ABI
> > +==========
> > +
> > +libbpf can be both linked statically or used as DSO. To avoid possible
> > +conflicts with other libraries an application is linked with, all
> > +non-static libbpf symbols should have one of the prefixes mentioned in
> > +API documentation above. See API naming convention to choose the right
> > +name for a new symbol.
> > +
>
> [...]

Thanks for the feedback on this, I've fixed them on a local copy and
will incorporate them into my final patch/PR depending on what we go
with. See my most recent response on '[PATCH bpf-next 0/3]
Autogenerating API documentation'
