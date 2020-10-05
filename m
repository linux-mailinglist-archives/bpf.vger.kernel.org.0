Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A566283FA9
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgJETaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgJETaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 15:30:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171CC0613CE;
        Mon,  5 Oct 2020 12:30:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so13387868qkj.7;
        Mon, 05 Oct 2020 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1HvuvtCCGAXqlhpHOStSdHbpePokIXHzcLpf4xpR16M=;
        b=TrWdaS4byFM2CaP0h4Dhn6p2kqeoCtE5XdXx3T4oMIXHnMSIiG1URpy5zyf/0HCN7p
         QJR04pHSaaPdVkRyqtBPKjjBSGO612f2qXGFic+9/C741WklhCVoefpej3cXvzTDrFGu
         S04JrTcvi/mjO3emtx1W0fvFqbKWlPu4Xxczk92cC4j0I4ZlpMOP5kA3KgrR9HDH6ODJ
         17u4dlAEq6KeUS2Np554yJVebQnLWLw2CFkbRT3B8v8gd9jhuWHKGBieN5FLy+AfX4N3
         b5JquRw4K7VZ/Lx9GsxaBhd/oO2KhnDh9dTYSTnmzc99uG/nTnWNFMhlWd3x+H8+dLQY
         O1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1HvuvtCCGAXqlhpHOStSdHbpePokIXHzcLpf4xpR16M=;
        b=esgpazSMpvB04KxMJrYwnXwLI0ayKcHQaWnUdAuyGm0WiYI4xaGgo/OC6uNM/W30H6
         jqgGN47ea+SgxtVNRivFz+lAaMsIttiT11r6913v7I6cKvg2dRUNQMC1GM6UG9PEKTvF
         Gf33uyrwziqJwFMriJR6yr6X0B3fyHQNgOSPqWotY4I1RpwYTn1YWKCjoXiJsTpcRq0S
         a27tb1HPA8ePd/SCinPyAf7/8YSRbHrKVNNhZrugbPalDacIQhx0ES90yGfjmIqOMcpd
         VCWuK2ewJI1lK96xsWhTxFefdLEtOUZKOL/7Vr6LsV/XHHBmZobezPMkISyLHLcCxISy
         TkAw==
X-Gm-Message-State: AOAM531Xxmg1NaWQNYaX46Sceta0H58tBCOogPh0vN4R1xmtwwGiBwSG
        WveMTDef2wsj74nqo5ql3U3ZlJdjlbVdoENFkSc=
X-Google-Smtp-Source: ABdhPJyEYJAROiALR1H9EhjqbxlBG1v87QUyQrvkbJBrdvZi7nLNMuNktrKfhntBENyN2q13+I0NxLXv5ZlHGCu3dRA=
X-Received: by 2002:a25:2f43:: with SMTP id v64mr2059348ybv.27.1601926219578;
 Mon, 05 Oct 2020 12:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8-TxfyLKuLDowKKhOo5XtfD1YVO4Gv2+k1HqbL074G=A@mail.gmail.com>
In-Reply-To: <CAPGftE8-TxfyLKuLDowKKhOo5XtfD1YVO4Gv2+k1HqbL074G=A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 5 Oct 2020 12:30:08 -0700
Message-ID: <CAEf4BzZ6VZR_3pGKqh0UXmJyS05_7LdUeoH39y+Xwc5T6F0=+A@mail.gmail.com>
Subject: Re: [PATCH dwarves 00/11] Switch BTF loading and encoding to libbpf APIs
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 4, 2020 at 8:48 PM Tony Ambardar <tony.ambardar@gmail.com> wrot=
e:
>
> On Tue, Sep 29, 2020 at 09:27:31PM -0700, Andrii Nakryiko wrote:
> > This patch set switches pahole to use libbpf-provided BTF loading and e=
ncoding
> > APIs. This reduces pahole's own BTF encoding code, speeds up the proces=
s,
> > reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole =
finally
> > gets support to generating BTF for cross-compiled ELF binaries with dif=
ferent
> > endianness (patch #11).
> >
> Hello Andrii,
>
> After a small hiccup (see below) I managed to build a modified 'pahole' a=
nd test
> cross-compiling from x86_64 to mips 64/32-bit and big/little-endian
> targets. Using
> "bpftool btf dump file /sys/kernel/btf/vmlinux format c" succeeded on
> all targets,
> whereas prior to your changes running on big-endian targets would
> raise an error.
> (Note that the 'bpftool' used a 'libbpf' without any of your changes.)
>
> Thanks so much for tackling these BTF endianness problems; it's been a gr=
eat
> help for working with embedded systems.
>

Awesome, thanks for confirming! With this and libbpf patches to do
integer/pointer load/store auto-resizing, 32-bit arches should be in a
better shape w.r.t. BPF usage.

> > Additionally, patch #6 fixes previously missed problem with invalid arr=
ay
> > index type generation.
> >
> > Patches #7-10 are speeding up DWARF-to-BTF convertion/dedup pretty
> > significantly, saving overall about 9 seconds out of current 27 or so.
> >
> > Patch #8 revamps how per-CPU BTF variables are emitted, eliminating rep=
eated
> > and expensive looping over ELF symbols table.
> >
> > Patch #10 admittedly has some hacky parts to satisfy CTF use case, but =
its
> > speed ups are greatest. So I'll understand if it gets dropped, but it w=
ould be
> > a pity.
> >
> Possibly a case of operator error, but I had to skip this patch to
> cleanly build 'pahole',
> and didn't have much chance to look into the compile error:
>
>   [  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
>   In file included from /home/kodidev/pahole/strings.h:9,
>                    from /usr/include/string.h:432,

There seems to be some issue with including pahole's strings.h header
from /usr/include/string.h, which doesn't seem right, but I can't
really repro this locally. I wonder if Arnaldo will see this in his
setup as well. This might be your local setup problem.

>                    from /home/kodidev/pahole/lib/bpf/src/libbpf_common.h:=
12,
>                    from /home/kodidev/pahole/lib/bpf/src/libbpf.h:20,
>                    from /home/kodidev/pahole/lib/bpf/src/ringbuf.c:20:
>   /home/kodidev/pahole/lib/bpf/src/btf.h:33:11: error: expected =E2=80=98=
;=E2=80=99
> before =E2=80=98void=E2=80=99
>     33 | LIBBPF_API void btf__free(struct btf *btf);
>         |           ^~~~~
>         |           ;
>
> Kind regards,
> Tony
>
> > More details could be found in respective patches.
> >
> > Andrii Nakryiko (11):
> >   libbpf: update to latest libbpf version
> >   btf_encoder: detect BTF encoding errors and exit
> >   dwarves: expose and maintain active debug info loader operations
> >   btf_loader: use libbpf to load BTF
> >   btf_encoder: use libbpf APIs to encode BTF type info
> >   btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
> >   btf_encoder: discard CUs after BTF encoding
> >   btf_encoder: revamp how per-CPU variables are encoded
> >   dwarf_loader: increase the size of lookup hash map
> >   strings: use BTF's string APIs for strings management
> >   btf_encoder: support cross-compiled ELF binaries with different
> >     endianness
> >
