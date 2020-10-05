Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313C282F17
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJEDsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Oct 2020 23:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJEDsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Oct 2020 23:48:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056EC0613CE;
        Sun,  4 Oct 2020 20:48:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z5so6554509ilq.5;
        Sun, 04 Oct 2020 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dBhgz32sZMbx5kb9JCuOzPqh+A3JaVp4ByVa9zVTLVE=;
        b=aDUyffpkhi+f6OMwsWXBa+8miiLp17CTkihEpZxCX6ES5oriL4vATRtorKlEFv/F8L
         4oCeHpl6gE7sNUNLBjJG4ZV7+6hjWxWqfIfkHqmGhtr6e8y6Mk2S09DuKz+00PPNbQ86
         rHh3e1A9EsDYD585CqdU+/mQjw42/nYjNBvMf5igpW7p+kzQFEz+VAhMUmKt+jpCauTk
         +TwT66QfhlMl3S9F/mwGJmnXmuGfvf2lJa9uATVulPONeOmUglqX/syy6mEdngLnmGyd
         UMHxO8eaNXW5LLSkvOZ2Q1pqcJTuQ2Cq1A5Sss/ZztvSZxdp5+8nypxz70Z3I7CUoGAw
         v7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dBhgz32sZMbx5kb9JCuOzPqh+A3JaVp4ByVa9zVTLVE=;
        b=KQZOdOsXJ56bttDjiQuK60HRK1Y6C1mqzfxsId37CliT9zGKzkMPODP2vZ8NIpz8qg
         1E71qogt/4rlJOISHxR7X9CR7lbFrcchXoppQ7wTg7VL7FF9TQNaGN8APVYqpbhwdO+b
         dOtEi7jZUeOxhMrrr+ika75veRl1zPn6WnGWXTS/Tl2zQLyDtBS42TYS737f3IKzxooL
         LSz4CJdii/qt5W1Bae12yaHXjnCxyd41cvDDqE2kjB4JD6WGMNHMjbqabefHuq1esDu8
         Dpv7ZYQQWRJMw4Ae/dp2N5OunIqWNx79jCDoK3M86V//cLX3GR5Mfr9m26wpu85iHek3
         IfEw==
X-Gm-Message-State: AOAM532jTCuqezHUHFg/2BarJMJFnE2xeLdHB9qBa3BybXQVKD5N3XXl
        +OaBt8AiSORTS4iTkLG6hFJk8M97zpNtIkUuyJU=
X-Google-Smtp-Source: ABdhPJxB1Cy3OzJH699TGu4tVstMbpXMq5mOwJ5CiXtqXwRfalD0JAYcckBiuLUj6J7Fr0EidDJEYEx+3t4Dv2mygNw=
X-Received: by 2002:a92:cb8c:: with SMTP id z12mr9209889ilo.123.1601869721004;
 Sun, 04 Oct 2020 20:48:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Sun, 4 Oct 2020 20:48:32 -0700
Message-ID: <CAPGftE8-TxfyLKuLDowKKhOo5XtfD1YVO4Gv2+k1HqbL074G=A@mail.gmail.com>
Subject: Re: [PATCH dwarves 00/11] Switch BTF loading and encoding to libbpf APIs
To:     andriin@fb.com
Cc:     bpf@vger.kernel.org, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 29, 2020 at 09:27:31PM -0700, Andrii Nakryiko wrote:
> This patch set switches pahole to use libbpf-provided BTF loading and enc=
oding
> APIs. This reduces pahole's own BTF encoding code, speeds up the process,
> reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole fi=
nally
> gets support to generating BTF for cross-compiled ELF binaries with diffe=
rent
> endianness (patch #11).
>
Hello Andrii,

After a small hiccup (see below) I managed to build a modified 'pahole' and=
 test
cross-compiling from x86_64 to mips 64/32-bit and big/little-endian
targets. Using
"bpftool btf dump file /sys/kernel/btf/vmlinux format c" succeeded on
all targets,
whereas prior to your changes running on big-endian targets would
raise an error.
(Note that the 'bpftool' used a 'libbpf' without any of your changes.)

Thanks so much for tackling these BTF endianness problems; it's been a grea=
t
help for working with embedded systems.

> Additionally, patch #6 fixes previously missed problem with invalid array
> index type generation.
>
> Patches #7-10 are speeding up DWARF-to-BTF convertion/dedup pretty
> significantly, saving overall about 9 seconds out of current 27 or so.
>
> Patch #8 revamps how per-CPU BTF variables are emitted, eliminating repea=
ted
> and expensive looping over ELF symbols table.
>
> Patch #10 admittedly has some hacky parts to satisfy CTF use case, but it=
s
> speed ups are greatest. So I'll understand if it gets dropped, but it wou=
ld be
> a pity.
>
Possibly a case of operator error, but I had to skip this patch to
cleanly build 'pahole',
and didn't have much chance to look into the compile error:

  [  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
  In file included from /home/kodidev/pahole/strings.h:9,
                   from /usr/include/string.h:432,
                   from /home/kodidev/pahole/lib/bpf/src/libbpf_common.h:12=
,
                   from /home/kodidev/pahole/lib/bpf/src/libbpf.h:20,
                   from /home/kodidev/pahole/lib/bpf/src/ringbuf.c:20:
  /home/kodidev/pahole/lib/bpf/src/btf.h:33:11: error: expected =E2=80=98;=
=E2=80=99
before =E2=80=98void=E2=80=99
    33 | LIBBPF_API void btf__free(struct btf *btf);
        |           ^~~~~
        |           ;

Kind regards,
Tony

> More details could be found in respective patches.
>
> Andrii Nakryiko (11):
>   libbpf: update to latest libbpf version
>   btf_encoder: detect BTF encoding errors and exit
>   dwarves: expose and maintain active debug info loader operations
>   btf_loader: use libbpf to load BTF
>   btf_encoder: use libbpf APIs to encode BTF type info
>   btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
>   btf_encoder: discard CUs after BTF encoding
>   btf_encoder: revamp how per-CPU variables are encoded
>   dwarf_loader: increase the size of lookup hash map
>   strings: use BTF's string APIs for strings management
>   btf_encoder: support cross-compiled ELF binaries with different
>     endianness
>
