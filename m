Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145A139F732
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhFHNBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 09:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhFHNBo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 09:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A2416128A;
        Tue,  8 Jun 2021 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623157191;
        bh=uf6bK3lw2lq5/9u/WvjNBRZXY/2vJoIfinsV5m8I4PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgvpZePi4uhdUfm/sq0rTSKN2wfN8yyhPCUa5j0RitBTwzMJ8cVggfv4Tcp5UyDP0
         Zjs5Z3pxlql+obkGRZWRWCNCoCGv12WqzGhN5NawYkTr9B+L1qoyGlFl/ms2eiYT07
         NSfXko4gJj9jFMRNGAXQpwD+evKpwb1sug7aVBY4FeOi7wTlDGJ/ogFoFdbCnO28S4
         NYBPxSbzd+z5Vmto3fQk+BMsC5fuhsZFPl0qhkrRCHoVjmbuiiGj/s1FIPHSX9gd7k
         P9jqqpCWu0L3cOsh2r9PFWqSOSuGPIbuRPD6rxCq18ZPBeXtfnaVTtLwWSaIsZIWD8
         zHwzyVOVKTR8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F32040B1A; Tue,  8 Jun 2021 09:59:48 -0300 (-03)
Date:   Tue, 8 Jun 2021 09:59:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
Message-ID: <YL9pxDFIYQEUODM5@kernel.org>
References: <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org>
 <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org>
 <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> On Mon, Jun 7, 2021 at 6:20 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Fri, Jun 04, 2021 at 07:55:17PM -0700, Andrii Nakryiko escreveu:
> > > On Thu, Jun 3, 2021 at 7:57 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Em Sat, May 29, 2021 at 05:40:17PM -0700, Andrii Nakryiko escreveu:
> >
> > > > > At some point it probably would make sense to formalize
> > > > > "btf_encoder" as a struct with its own state instead of passing in
> > > > > multiple variables. It would probably also
> >
> > > > Take a look at the tmp.master branch at:
> >
> > > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.master
> >
> > > Oh wow, that's a lot of commits! :) Great that you decided to do this
> > > refactoring, thanks!
> >
> > > > that btf_elf class isn't used anymore by btf_loader, that uses only
> > > > libbpf's APIs, and now we have a btf_encoder class with all the globals,
> > > > etc, more baby steps are needed to finally ditch btf_elf altogether and
> > > > move on to the parallelization.
> >
> > > So do you plan to try to parallelize as a next step? I'm pretty
> >
> > So, I haven't looked at details but what I thought would be interesting
> > to investigate is to see if we can piggyback DWARF generation with BTF
> > one, i.e. when we generate a .o file with -g we encode the DWARF info,
> > so, right after this, we could call pahole as-is and encode BTF, then,
> > when vmlinux is linked, we would do the dedup.
> >
> > I.e. when generating ../build/v5.13.0-rc4+/kernel/fork.o, that comes
> > with:
> >
> > ⬢[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fork.o | grep debug
> >   [78] .debug_info       PROGBITS        0000000000000000 00daec 032968 00      0   0  1
> >   [79] .rela.debug_info  RELA            0000000000000000 040458 053b68 18   I 95  78  8
> >   [80] .debug_abbrev     PROGBITS        0000000000000000 093fc0 0012e9 00      0   0  1
> >   [81] .debug_loclists   PROGBITS        0000000000000000 0952a9 00aa43 00      0   0  1
> >   [82] .rela.debug_loclists RELA         0000000000000000 09fcf0 009d98 18   I 95  81  8
> >   [83] .debug_aranges    PROGBITS        0000000000000000 0a9a88 000080 00      0   0  1
> >   [84] .rela.debug_aranges RELA          0000000000000000 0a9b08 0000a8 18   I 95  83  8
> >   [85] .debug_rnglists   PROGBITS        0000000000000000 0a9bb0 001509 00      0   0  1
> >   [86] .rela.debug_rnglists RELA         0000000000000000 0ab0c0 001bc0 18   I 95  85  8
> >   [87] .debug_line       PROGBITS        0000000000000000 0acc80 0086b7 00      0   0  1
> >   [88] .rela.debug_line  RELA            0000000000000000 0b5338 002550 18   I 95  87  8
> >   [89] .debug_str        PROGBITS        0000000000000000 0b7888 0177ad 01  MS  0   0  1
> >   [90] .debug_line_str   PROGBITS        0000000000000000 0cf035 001308 01  MS  0   0  1
> >   [93] .debug_frame      PROGBITS        0000000000000000 0d0370 000e38 00      0   0  8
> >   [94] .rela.debug_frame RELA            0000000000000000 0d11a8 000e70 18   I 95  93  8
> > ⬢[acme@toolbox perf]$
> >
> > We would do:
> >
> > ⬢[acme@toolbox perf]$ pahole -J ../build/v5.13.0-rc4+/kernel/fork.o
> > ⬢[acme@toolbox perf]$
> >
> > Which would get us to have:
> >
> > ⬢[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fork.o | grep BTF
> >   [103] .BTF              PROGBITS        0000000000000000 0db658 030550 00      0   0  1
> > ⬢[acme@toolbox perf]
> >
> > ⬢[acme@toolbox perf]$ pahole -F btf -C hlist_node ../build/v5.13.0-rc4+/kernel/fork.o
> > struct hlist_node {
> >         struct hlist_node *        next;                 /*     0     8 */
> >         struct hlist_node * *      pprev;                /*     8     8 */
> >
> >         /* size: 16, cachelines: 1, members: 2 */
> >         /* last cacheline: 16 bytes */
> > };
> > ⬢[acme@toolbox perf]$
> >
> > So, a 'pahole --dedup_btf vmlinux' would just go on looking at:
> >
> > ⬢[acme@toolbox perf]$ readelf -wi ../build/v5.13.0-rc4+/vmlinux | grep -A10 DW_TAG_compile_unit | grep -w DW_AT_name | grep fork
> >     <f220eb>   DW_AT_name        : (indirect line string, offset: 0x62e7): /var/home/acme/git/linux/kernel/fork.c
> >
> > To go there and go on extracting those ELF sections to combine and
> > dedup.
> >
> > This combine thing could be done even by the linker, I think, when all
> > the DWARF data in the .o file are combined into vmlinux, we could do it
> > for the .BTF sections as well, that way would be even more elegant, I
> > think. Then, the combined vmlinux .BTF section would be read and fed in
> > one go to libbtf's dedup arg.
> >
> > This way the encoding of BTF would be as paralellized as the kernel build
> > process, following the same logic (-j NR_PROCESSORS).
> >
> > wdyt?
> 
> I think it's very fragile and it will be easy to get
> broken/invalid/incomplete BTF. Yonghong already brought up the case

I thought about that as it would be almost like the compiler generating
BTF, but you are right, the vmlinux prep process is a complex beast and
probably it is best to go with the second approach I outlined and you
agreed to be less fragile, so I'll go with that, thanks for your
comments.

- Arnaldo

> for static variables. There might be some other issues that exist
> today, or we might run into when we further extend BTF. Like some
> custom linker script that will do something to vmlinux.o that we won't
> know about.
> 
> And also this will be purely vmlinux-specific approach relying on
> extra and custom Kbuild integration.
> 
> While if you parallelize DWARF loading and BTF generation, that will
> be more reliably correct (modulo any bugs of course) and will work for
> any DWARF-to-BTF cases that might come up in the future.
> 
> So I wouldn't even bother with individual .o's, tbh.
> 
> >
> > If this isn't the case, we can process vmlinux as is today and go on
> > creating N threads and feeding each with a DW_TAG_compile_unit
> > "container", i.e. each thread would consume all the tags below each
> > DW_TAG_compile_unit and produce a foo.BTF file that in the end would be
> > combined and deduped by libbpf.
> >
> > Doing it as my first sketch above would take advantage of locality of
> > reference, i.e. the DWARF data would be freshly produced and in the
> > cache hierarchy when we first encode BTF, later, when doing the
> > combine+dedup we wouldn't be touching the more voluminous DWARF data.
> 
> Yep, that's what I'd do.
> 
> >
> > - Arnaldo
> >
> > > confident about BTF encoding part: dump each CU into its own BTF, use
> > > btf__add_type() to merge multiple BTFs together. Just need to re-map
> > > IDs (libbpf internally has API to visit each field that contains
> > > type_id, it's well-defined enough to expose that as a public API, if
> > > necessary). Then final btf_dedup().
> >
> > > But the DWARF loading and parsing part is almost a black box to me, so
> > > I'm not sure how much work it would involve.
> >
> > > > I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
> > > > very piecemeal as I'm doing will help bisecting any subtle bug this may
> > > > introduce.
> >
> > > > > allow to parallelize BTF generation, where each CU would proceed in
> > > > > parallel generating local BTF, and then the final pass would merge and
> > > > > dedup BTFs. Currently reading and processing DWARF is the slowest part
> > > > > of the DWARF-to-BTF conversion, parallelization and maybe some other
> > > > > optimization seems like the only way to speed the process up.
> >
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > > Thanks!

-- 

- Arnaldo
