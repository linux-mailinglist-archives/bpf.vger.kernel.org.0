Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915664E464
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLOXAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 18:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLOXAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 18:00:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905CA1BB
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 15:00:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so2206740ejc.2
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtlIsi8wvjVJqnvimpIP01PDWbh+Qn2vtaldjR2Q47E=;
        b=c00cm7lHqrvW5/0QFMkvVaUBPEXTw3NeBFAjiY3ymQ6pccvPwyM7ZcZtO8BjbfE1GT
         EN3tvRyI0Uq+m3Ttc6Ub3Eo4kcvvjQVd6eiFeCZc8qVjD9oT4DVANBgce9K4Jmat3a+2
         m8DLeWsuZpDcCvZxmQsNpqwkQfXfR2b/TL9tFfbDKKAxBkp2M828bAz3rZW7oKkmEIUL
         FHG7AZt5A7SICtzA3q+/pC0v/+wmg0mST1ir3kBZTH7cUrgAZzzn5rulOZ3uTfYawU3Q
         Xhyjn2LRAwV9OA/2sl9ZeJ8sxw7ntieF/rl1DhNd5cmvA3qbw50fWk9yk6R/UnjYXzbT
         ofgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtlIsi8wvjVJqnvimpIP01PDWbh+Qn2vtaldjR2Q47E=;
        b=PuShFKW99BbTWVDZVSuP0uO4KNb2/yK2e9z65jXiG3a+yqE8j5RU4dYd5J3jGDQv3p
         UEaMljAnqFFCZ2GXAeBa06UBNmMyo3nW3Cjzk5jnKg4fPGDWZIHZPg2LzRa9e1zxkWqM
         cyY8r/D4QWA08ijNlkwJCKikt3rM/ZjaCVGomOREsoVLrqgZmYCX1e7Q6mrXiNQ6wjTW
         QWJO1sCZL3TI6K4dXmVjwF141WJoRPAJ5q1WxMRVMNeBxccMebWc+vbVtX1qQkiqIJsj
         zZSvi+D1eiUSpX8iwheZebWk8AJ9Usv9GkQT7ayGvERQWMYU42pDgWdiMcW0lnQAmeZd
         5jzA==
X-Gm-Message-State: ANoB5pkmLW/CJVFEKft0U7EMDBV35+vIHRkN7VRN6Cj9v1Wa5F6wwvFh
        Uba8OOup3byOuxPLQnNUMRE58yrewQeoS8u8CKTo
X-Google-Smtp-Source: AA0mqf6lH7n6djtP6gJMxv0ytcCZaCMNHFW5HIy2ydyyhyoHLepCtlB8fpMFUN082MJJbtefpSkb/Kcb3hfmmuNxt3E=
X-Received: by 2002:a17:906:2604:b0:78a:d0a4:176 with SMTP id
 h4-20020a170906260400b0078ad0a40176mr83289136ejc.720.1671145242194; Thu, 15
 Dec 2022 15:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com> <20221122000011.241697-2-morbo@google.com>
 <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
 <CAGG=3QWGAepDQmSxarrMENOX79srigF48xYOsOjOPO-YuvFr1g@mail.gmail.com>
 <CAEf4Bzb38BXEL_mKuqRdUrvQVTXLH9TmOdwZbrVa_10YmdhoTw@mail.gmail.com>
 <CAGG=3QVC_qOFWRi4sf88Ct3Tz5_N6j_GUwj+Dk11Oi9AJYNm-A@mail.gmail.com>
 <CAEf4BzYs4h0ya7MbQ9P96293XkyW4ab3f+nYeJU6D=LFsrm6-w@mail.gmail.com>
 <CAGG=3QXVC-9tPT1KL0ze+5oWz=hpXsy+w=BJgSjokufmSP4eZQ@mail.gmail.com>
 <CAEf4BzazUVOnPD_wBdhVaLjB5jE5CDd1t1zop6zwA4Lr2qF+rA@mail.gmail.com>
 <CAGG=3QV0rWv22b5vM9Ht8Htf7k5SvppXyDWwX1nkKPFiC4e+bQ@mail.gmail.com> <CAEf4Bzbb3XZ4BUBCvpvZ4a1tac+7gwO0GL8dm_2rKK+OBKCEkA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbb3XZ4BUBCvpvZ4a1tac+7gwO0GL8dm_2rKK+OBKCEkA@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 15 Dec 2022 15:00:25 -0800
Message-ID: <CAGG=3QVEu+7CXtGx4vO0wp+Z5haFEH52-=gCfNAO9TcMpKsxUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 On Wed, Dec 7, 2022 at 12:33 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 7, 2022 at 12:16 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Tue, Dec 6, 2022 at 2:53 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > adding bpf@vger back
> > >
> > > On Tue, Dec 6, 2022 at 12:15 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Tue, Dec 6, 2022 at 10:38 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 1, 2022 at 12:20 PM Bill Wendling <morbo@google.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 1, 2022 at 11:56 AM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 30, 2022 at 4:21 PM Bill Wendling <morbo@google.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 30, 2022 at 2:59 PM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > LLD generates a zero-length .BTF section (BFD doesn't generate this
> > > > > > > > > > section). It shares the same address as .BTF_ids (or any section below
> > > > > > > > > > it). E.g.:
> > > > > > > > > >
> > > > > > > > > >   [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > > > > > > > > >   [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634
> > > > > > > > > >
> > > > > > > > > > Writing new data to that section doesn't adjust the addresses of
> > > > > > > > > > following sections. As a result, the "-J" flag produces a corrupted
> > > > > > > > > > file, causing further commands to fail.
> > > > > > > > > >
> > > > > > > > > > Instead of trying to adjust everything, just add a new section with the
> > > > > > > > > > .BTF data and adjust the name of the original .BTF section. (We can't
> > > > > > > > > > remove the old .BTF section because it has variables that are referenced
> > > > > > > > > > elsewhere.)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Have you tried llvm-objcopy --update-section instead? Doesn't it work?
> > > > > > > > >
> > > > > > > > I gave it a quick try and it fails for me with this:
> > > > > > > >
> > > > > > > > llvm-objcopy: error: '.tmp_vmlinux.btf': cannot fit data of size
> > > > > > > > 4470718 into section '.BTF' with size 0 that is part of a segment
> > > > > > >
> > > > > > > .BTF shouldn't be allocatable section, when added by pahole. I think
> > > > > > > this is the problem. Can you confirm that that zero-sized .BTF is
> > > > > > > marked as allocated and is put into one of ELF segments? Can we fix
> > > > > > > that instead?
> > > > > > >
> > > > > > I think it does:
> > > > > >
> > > > > > [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > > > > > 00  WA  0   0  1
> > > > > >
> > > > >
> > > > > So this allocatable .BTF section, could it be because of linker script
> > > > > in include/asm-generic/vmlinux.lds.h? Should we add some conditions
> > > > > there to not emit .BTF if __startt_BTF == __stop_BTF (i.e., no BTF
> > > > > data is present) to avoid this issue in the first place?
> > > > >
> > > > It looks like keeping the .BTF section around is intentional:
> > > >
> > > >   commit 65c204398928 ("bpf: Prevent .BTF section elimination")
> > > >
> > > > I assume that patch isn't meant if the section is zero sized...
> > >
> > > yep, we need to keep it only if it's non-empty
> > >
> > > >
> > > > I was able to get a working system with two patches: one to Linux and
> > > > one to pahole. The Linux patch specifies that the .BTF section
> > > > shouldn't be allocatable.
> > >
> > > That's not right, we do want this .BTF section to be allocatable,
> > > kernel expects this content to be accessible at runtime. So Linux-side
> > > change is wrong. Is it possible to add some conditional statement to
> > > linker script to keep .BTF only if .BTF is non-empty?
> > >
> > I thought you said the .BTF section shouldn't be allocatable. Is that
> > only when it's added by pahole? The issue isn't really the section
> > that's added by pahole, but the section as it's generated by LLD.
>
> Yeah, it's confusing. Pahole is not a linker and can't properly embed
> .BTF into a data segment inside ELF. So the only choice is to add it
> as nono-allocatable ELF section.
>
> But .BTF as part of vmlinux image *has* to be loadable, as kernel from
> inside expect to have access to BTF contents. So that's why we use
> linker script to embed .BTF into data segment as allocatable.
>
> Generally, the process is that during vmlinux building we add .BTF
> contents to a temporary vmlinux file using pahole. Then during final
> linking (at the same time as we add kallsyms) we rely on linker to
> make .BTF allocatable and add those __start_BTF/__stop_BTF markers.
>
> Hope that clarifies this a bit.
>
I think I understand now. Thanks! :-)

> >
> > I don't know of a way to add conditional code to a linker script. I
> > suspect we'd need the equivalent of this:
> >
> >   .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {
> >     __start_BTF = .;
> >     KEEP(*(.BTF))
> >     __stop_BTF = .;
> >   }
> >   SIZEOF(.BTF) == 0 && /DISCARD/ { *(.BTF) }   # This doesn't work.
>
> Honestly, no idea, I barely ever used linker scripts. Was hoping
> someone else will be able to figure this out and I won't have to learn
> this :)
>
> >
> > > > The pahole patch uses --update-section if
> > > > the section exists rather than writing out a new ELF file. Thoughts?
> > >
> > > That might be ok, because we already have dependency on llvm-objcopy.
> > > But also it's unnecessary change if the section in not allocated,
> > > right? Or why do we need to switch to llvm-objcopy in this case?
> > >
> > Not using llvm-objcopy was still messing up the ELF file. When you
> > used `readelf -lW .tmp_vmlinux.btf` the "Section to Segment mapping"
> > is trashed.
>
> If .BTF is not allocatable, there is no section to segment mapping, is there?
>
> >
> > I'm a bit worried still that even if we modify the Linux linker
> > scripts to remove a zero-sized .BTF section non-Linux projects using
> > pahole will hit this issue. (Or is Linux meant to be the sole user of
> > pahole?)
>
> That's the single most important case that we care about (note that
> the same thing happens for kernel modules). Nothing prevents others
> from using pahole for similar reasons with their custom apps.
>
> >
> > The purpose of the `-J` option is to add BTF data and the next command
> > in scripts/link-linux.sh extracts that data into its own file. The
> > .tmp_vmlinux.btf that pahole modified is then no longer used. Why not
> > cut out the middleman and have `-J` write the BTF data directly to a
> > file? Does it need to be in a special format?
> >
>
> That's exactly what I'm proposing:
>
> > > > > > > Also, more generally, newer paholes (not that new anymore, it's been a
> > > > > > > supported feature for a while) support emitting BTF as raw binary
> > > > > > > files, instead of embedding them into ELF. I think this is a nicer and
> > > > > > > simpler option and we should switch link-vmlinux.sh to use that
> > > > > > > instead, if pahole is new enough.
>
> We dump .BTF contents as raw bytes. Then embed with objcopy. That's the goal.
>
I knew I had a good idea! :-D

I tried emitting the BTF data with the --btf_encode_detached flag.
However, it's emitted as a binary file, which the linker isn't able to
handle. We could process it afterwards with "objcopy", but I'm not
sure how to grab the correct output BFD name. So something like this:

$ objcopy --input-target=binary --output-target=???
.btf.vmlinux.bin.o.raw .btf.vmlinux.bin.o

What should I put in place of "???"? I can't seem to find a tool that
will give me a BFD name so that I could use the same type as the
".tmp_vmlinux.btf.o" file.

-bw

> > -bw
> >
> > > >
> > > > Linux patch:
> > > >
> > > > diff --git a/include/asm-generic/vmlinux.lds.h
> > > > b/include/asm-generic/vmlinux.lds.h
> > > > index 3dc5824141cd..5bea090b736e 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -680,7 +680,7 @@
> > > >   */
> > > >  #ifdef CONFIG_DEBUG_INFO_BTF
> > > >  #define BTF                                                            \
> > > > -       .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                           \
> > > > +       .BTF (INFO) : AT(ADDR(.BTF) - LOAD_OFFSET) {                    \
> > > >                 __start_BTF = .;                                        \
> > > >                 KEEP(*(.BTF))                                           \
> > > >                 __stop_BTF = .;                                         \
> > > >
> > > > pahole patch:
> > > >
>
> [...]
>
> > > >
> > > >
> > > > > > Fangrui mentioned something similar to this in a previous message:
> > > > > >
> > > > > >   https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/T/#u
> > > > > >
> > > > > > > Also, more generally, newer paholes (not that new anymore, it's been a
> > > > > > > supported feature for a while) support emitting BTF as raw binary
> > > > > > > files, instead of embedding them into ELF. I think this is a nicer and
> > > > > > > simpler option and we should switch link-vmlinux.sh to use that
> > > > > > > instead, if pahole is new enough.
> > > > > > >
> > > > > > > Hopefully eventually we can get rid of all the old pahole version
> > > > > > > cruft, but for now it's inevitable to support both modes, of course.
> > > > > > >
> > > > > >
> > > > > > Ah technical debt! :-)
> > > > >
> > > > > Yep, it would be good to get contributions to address it ;) It's
> > > > > better than hacks with renaming of sections, *wink wink* :)
> > > > >
> > > > ;-)
> > > >
> > > > -bw
> > > >
> > > > > >
> > > > > > -bw
> > > > > >
> > > > > > > > btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux.btf': 2!
> > > > > > > > Failed to encode BTF
> > > > > > > >
> > > > > > > > -bw
> > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
> > > > > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > > > > Cc: Fangrui Song <maskray@google.com>
> > > > > > > > > > Cc: dwarves@vger.kernel.org
> > > > > > > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > > > > > > > ---
> > > > > > > > > >  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
> > > > > > > > > >  1 file changed, 54 insertions(+), 34 deletions(-)
> > > > > > > > > >
>
> [...]
