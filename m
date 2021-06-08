Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166539EB0A
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHA5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 20:57:18 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:43622 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHA5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Jun 2021 20:57:15 -0400
Received: by mail-yb1-f178.google.com with SMTP id b9so27668385ybg.10;
        Mon, 07 Jun 2021 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W4OU7fkNvdED8OXslYthRL/JhGAkngLOR0j2mHX/3kk=;
        b=S7CXXx/LLcTxNEpcKTkhcd6MejOiR3xjY0Jp4El64TSNFULwdomm/HWBhiY2v7PXqv
         qCW69Er54ytyzWx0YeTJfM2mJ5OOF+nrW8qwX4oOb89wg5CvwDmEyDtjKfs9mV9yP5Iu
         reEE01EzAfsHUrQKevYF6+l77I+yQoDY/s3DJ7EQjUpPx6/8Uh+B7y7arUBCR/JNarDD
         y4ubqdOH1VVqiCwiF5P3TIPdivVLIuA3b4nDBlu+tsqOF7L0Rk8YL/+MarCVHbxb5QQU
         OX2gyX/Wh9NUAGDnEPailnKbfi4tgCRy+ToNQQfv2wId+VVkY8aK53NKSutEPwFahYbQ
         Nqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W4OU7fkNvdED8OXslYthRL/JhGAkngLOR0j2mHX/3kk=;
        b=pJYdPJst58L3xbnA+hgLPveHoev+ft72MEsTu9G3twWmOPDmyES+/hxo9QmFoYlxg0
         00DjyvYQ/n9Nl/1XSp+0vN5tK4jWgM9cpQtsI+/tVZPs2TmsSJFOiveoYCPPAjKlUj7+
         wyr6uSS7JI04JHNdkftVPNrVz4anQ0sV3lTk3XzlwcKwY3NmL7eSqg9+7P2X0jU1PKc9
         7nGNgvkYilEklk4loTpkyoyHHPEO/Fh4a3Q9/4eL7WzI5Eq5m3Y1h1XBAF49y0k/ot5v
         sJ3V67srSh/DoLxXILKVeQVb5mEFGJrrs8d9wGjN3mrdIdVQzmtSu7qMTMgXOfY9Z2Az
         D4Mg==
X-Gm-Message-State: AOAM531FdYimJ7eT9H/t4xYrOEyPWACROCWGAkYONrwGvIhp0lyqL00I
        G/neM0poYpfHY6SsdDE4DJ6XiiaXiCpsBiGS35FJeUQhwB8=
X-Google-Smtp-Source: ABdhPJzpCY0638r+BXtHRjaCR4d42F3tMT9njFqytL/a99JnCHy4C25kbjZH93ZW2TtF+LMJviaPnICLDfq20rWR9mM=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr26076428ybg.459.1623113650011;
 Mon, 07 Jun 2021 17:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com> <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org> <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org> <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org>
In-Reply-To: <YL4dGFsfb0ZzgxlR@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Jun 2021 17:53:59 -0700
Message-ID: <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 7, 2021 at 6:20 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Fri, Jun 04, 2021 at 07:55:17PM -0700, Andrii Nakryiko escreveu:
> > On Thu, Jun 3, 2021 at 7:57 AM Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
> > > Em Sat, May 29, 2021 at 05:40:17PM -0700, Andrii Nakryiko escreveu:
>
> > > > At some point it probably would make sense to formalize
> > > > "btf_encoder" as a struct with its own state instead of passing in
> > > > multiple variables. It would probably also
>
> > > Take a look at the tmp.master branch at:
>
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3Dtmp.m=
aster
>
> > Oh wow, that's a lot of commits! :) Great that you decided to do this
> > refactoring, thanks!
>
> > > that btf_elf class isn't used anymore by btf_loader, that uses only
> > > libbpf's APIs, and now we have a btf_encoder class with all the globa=
ls,
> > > etc, more baby steps are needed to finally ditch btf_elf altogether a=
nd
> > > move on to the parallelization.
>
> > So do you plan to try to parallelize as a next step? I'm pretty
>
> So, I haven't looked at details but what I thought would be interesting
> to investigate is to see if we can piggyback DWARF generation with BTF
> one, i.e. when we generate a .o file with -g we encode the DWARF info,
> so, right after this, we could call pahole as-is and encode BTF, then,
> when vmlinux is linked, we would do the dedup.
>
> I.e. when generating ../build/v5.13.0-rc4+/kernel/fork.o, that comes
> with:
>
> =E2=AC=A2[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fo=
rk.o | grep debug
>   [78] .debug_info       PROGBITS        0000000000000000 00daec 032968 0=
0      0   0  1
>   [79] .rela.debug_info  RELA            0000000000000000 040458 053b68 1=
8   I 95  78  8
>   [80] .debug_abbrev     PROGBITS        0000000000000000 093fc0 0012e9 0=
0      0   0  1
>   [81] .debug_loclists   PROGBITS        0000000000000000 0952a9 00aa43 0=
0      0   0  1
>   [82] .rela.debug_loclists RELA         0000000000000000 09fcf0 009d98 1=
8   I 95  81  8
>   [83] .debug_aranges    PROGBITS        0000000000000000 0a9a88 000080 0=
0      0   0  1
>   [84] .rela.debug_aranges RELA          0000000000000000 0a9b08 0000a8 1=
8   I 95  83  8
>   [85] .debug_rnglists   PROGBITS        0000000000000000 0a9bb0 001509 0=
0      0   0  1
>   [86] .rela.debug_rnglists RELA         0000000000000000 0ab0c0 001bc0 1=
8   I 95  85  8
>   [87] .debug_line       PROGBITS        0000000000000000 0acc80 0086b7 0=
0      0   0  1
>   [88] .rela.debug_line  RELA            0000000000000000 0b5338 002550 1=
8   I 95  87  8
>   [89] .debug_str        PROGBITS        0000000000000000 0b7888 0177ad 0=
1  MS  0   0  1
>   [90] .debug_line_str   PROGBITS        0000000000000000 0cf035 001308 0=
1  MS  0   0  1
>   [93] .debug_frame      PROGBITS        0000000000000000 0d0370 000e38 0=
0      0   0  8
>   [94] .rela.debug_frame RELA            0000000000000000 0d11a8 000e70 1=
8   I 95  93  8
> =E2=AC=A2[acme@toolbox perf]$
>
> We would do:
>
> =E2=AC=A2[acme@toolbox perf]$ pahole -J ../build/v5.13.0-rc4+/kernel/fork=
.o
> =E2=AC=A2[acme@toolbox perf]$
>
> Which would get us to have:
>
> =E2=AC=A2[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fo=
rk.o | grep BTF
>   [103] .BTF              PROGBITS        0000000000000000 0db658 030550 =
00      0   0  1
> =E2=AC=A2[acme@toolbox perf]
>
> =E2=AC=A2[acme@toolbox perf]$ pahole -F btf -C hlist_node ../build/v5.13.=
0-rc4+/kernel/fork.o
> struct hlist_node {
>         struct hlist_node *        next;                 /*     0     8 *=
/
>         struct hlist_node * *      pprev;                /*     8     8 *=
/
>
>         /* size: 16, cachelines: 1, members: 2 */
>         /* last cacheline: 16 bytes */
> };
> =E2=AC=A2[acme@toolbox perf]$
>
> So, a 'pahole --dedup_btf vmlinux' would just go on looking at:
>
> =E2=AC=A2[acme@toolbox perf]$ readelf -wi ../build/v5.13.0-rc4+/vmlinux |=
 grep -A10 DW_TAG_compile_unit | grep -w DW_AT_name | grep fork
>     <f220eb>   DW_AT_name        : (indirect line string, offset: 0x62e7)=
: /var/home/acme/git/linux/kernel/fork.c
>
> To go there and go on extracting those ELF sections to combine and
> dedup.
>
> This combine thing could be done even by the linker, I think, when all
> the DWARF data in the .o file are combined into vmlinux, we could do it
> for the .BTF sections as well, that way would be even more elegant, I
> think. Then, the combined vmlinux .BTF section would be read and fed in
> one go to libbtf's dedup arg.
>
> This way the encoding of BTF would be as paralellized as the kernel build
> process, following the same logic (-j NR_PROCESSORS).
>
> wdyt?

I think it's very fragile and it will be easy to get
broken/invalid/incomplete BTF. Yonghong already brought up the case
for static variables. There might be some other issues that exist
today, or we might run into when we further extend BTF. Like some
custom linker script that will do something to vmlinux.o that we won't
know about.

And also this will be purely vmlinux-specific approach relying on
extra and custom Kbuild integration.

While if you parallelize DWARF loading and BTF generation, that will
be more reliably correct (modulo any bugs of course) and will work for
any DWARF-to-BTF cases that might come up in the future.

So I wouldn't even bother with individual .o's, tbh.

>
> If this isn't the case, we can process vmlinux as is today and go on
> creating N threads and feeding each with a DW_TAG_compile_unit
> "container", i.e. each thread would consume all the tags below each
> DW_TAG_compile_unit and produce a foo.BTF file that in the end would be
> combined and deduped by libbpf.
>
> Doing it as my first sketch above would take advantage of locality of
> reference, i.e. the DWARF data would be freshly produced and in the
> cache hierarchy when we first encode BTF, later, when doing the
> combine+dedup we wouldn't be touching the more voluminous DWARF data.

Yep, that's what I'd do.

>
> - Arnaldo
>
> > confident about BTF encoding part: dump each CU into its own BTF, use
> > btf__add_type() to merge multiple BTFs together. Just need to re-map
> > IDs (libbpf internally has API to visit each field that contains
> > type_id, it's well-defined enough to expose that as a public API, if
> > necessary). Then final btf_dedup().
>
> > But the DWARF loading and parsing part is almost a black box to me, so
> > I'm not sure how much work it would involve.
>
> > > I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
> > > very piecemeal as I'm doing will help bisecting any subtle bug this m=
ay
> > > introduce.
>
> > > > allow to parallelize BTF generation, where each CU would proceed in
> > > > parallel generating local BTF, and then the final pass would merge =
and
> > > > dedup BTFs. Currently reading and processing DWARF is the slowest p=
art
> > > > of the DWARF-to-BTF conversion, parallelization and maybe some othe=
r
> > > > optimization seems like the only way to speed the process up.
>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > > Thanks!
