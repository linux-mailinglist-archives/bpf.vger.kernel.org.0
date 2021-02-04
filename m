Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B530F5EB
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhBDPM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 10:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbhBDPMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 10:12:44 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B2C06178C
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 07:11:41 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id n63so733805vkn.12
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WThyMEnbXwGEqg+xvb/UXgCzsUcKXxh8kviOEY1TJto=;
        b=XJVXiK6gZqATdu6sIUyOyoFoYNwWXK+5nKmbJLH2KGZpxaPfRGP/6ESTTt7JiGN5eU
         UJ1sTNpecJMgAAcLoncQraWw1rq4os/W1EC++xDCIT2CeA8OnnERYCVbsmgXMtZU6QOb
         +CBhUwtdtU/a1tlFBKmbTtUoN5guMHNGmfays/DF2vzaAEZDVHw+8fkScI7N58P4MZ6p
         vyBOxFHoqdRWDf6o2cMjV4vHmf4BmWtuEJC8noNevER8rVZb08DwTcoS3E4Y8r/WuKgR
         KxcgrPnNyHaspHd+PSc5g7tNcCj9oU5S1FmYBvaG+WhMZtDhbj/ifGDNq8ZJUf934zCc
         B3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WThyMEnbXwGEqg+xvb/UXgCzsUcKXxh8kviOEY1TJto=;
        b=ZrNBwvvuj0SVaA9juRrTzZ3/QsxWzL5jIzNOcAL7fQ1jpAoxAHW7pCOMLQAGN+edxw
         vnVJRIcR9J1x0G9JipKNrAmHYvXeVh58LewwP2dqOoB7uzymstZz4nxbzuAWcJxTcfe3
         sYTwhssC2TmfV3IjH+I3ezoiurOVcSy/y4dgHFhzVMIXvPfO8MIWa53G1fQNWqWTDEQo
         tUZim41oSeww9s9BaCJhi2Vvf7caJxN7cPft9CRyP6uUxyceFOAxiRvvO82NPCOQ48ro
         ghyn9pJIDe3CHdo3eSvMbyG42uI6DDTE274UCKJIzoFOvNnEtXBUe8W9cvrm0Wc9miQI
         bUHA==
X-Gm-Message-State: AOAM531W3eSJlhFC6sgXkf78SkHzNCo4rkUEyEo1A4CP10RkfSFOA/a5
        93XIBmWY2X34LFqum9QrmcicpOpQhlTufaaEN4MjIA==
X-Google-Smtp-Source: ABdhPJw9uNQ/RPyGKyCJYOF26CCPbELLQwhASEzilEKyZt5Ecitwdv056nAb0pR6hPy3D5M7luI1qhh5nXvt3KMNOu4=
X-Received: by 2002:a1f:a643:: with SMTP id p64mr5453402vke.15.1612451500384;
 Thu, 04 Feb 2021 07:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-5-gprocida@google.com>
 <CAEf4Bzb6bKVo3NeVUr3Zb9+is0XbeOn+xLXtHv-GA_cWGVZfnA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6bKVo3NeVUr3Zb9+is0XbeOn+xLXtHv-GA_cWGVZfnA@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 4 Feb 2021 15:11:03 +0000
Message-ID: <CAGvU0HmLckYQv43OgvpU1aDkwVTBHc3MV0rZ_jfi4Az_tZXjjA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: Align .BTF section/segment to
 8 bytes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

On Thu, 4 Feb 2021 at 04:10, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > This is to avoid misaligned access to BTF type structs when
> > memory-mapping ELF sections.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 048a873..ae99a93 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -755,7 +755,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >          * This actually happens in practice with vmlinux which has .strtab
> >          * after .shstrtab, resulting in a (small) hole the size of the original
> >          * .shstrtab.
> > +        *
> > +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> > +        * nice if we could fetch this value from somewhere. The BTF
> > +        * specification does not discuss alignment and its trailing string
> > +        * table is not currently padded to any particular alignment.
> >          */
> > +       const size_t btf_alignment = 8;
> >
> >         /*
> >          * First we look if there was already a .BTF section present and
> > @@ -847,8 +853,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >         elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> >
> >         /* Update .BTF section in the SHT */
> > -       size_t new_btf_offset = high_water_mark;
> > -       size_t new_btf_size = raw_btf_size;
> > +       size_t new_btf_offset = roundup(high_water_mark, btf_alignment);
> > +       size_t new_btf_size = roundup(raw_btf_size, btf_alignment);
> >         GElf_Shdr btf_shdr_mem;
> >         GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> >         if (!btf_shdr) {
> > @@ -856,6 +862,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                         __func__, elf_errmsg(elf_errno()));
> >                 goto out;
> >         }
> > +       btf_shdr->sh_addralign = btf_alignment;
>
> if we set just this and let libelf do the layout, would libelf ensure
> 8-byte alignment of .BTF section inside the ELF file?
>

Yes. I'll follow up with a trivial patch that does that.




> >         btf_shdr->sh_entsize = 0;
> >         btf_shdr->sh_flags = SHF_ALLOC;
> >         if (dot_btf_offset)
> > @@ -926,6 +933,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
> >                 pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
> >                 pht[phnum].p_flags = PF_R;
> > +               pht[phnum].p_align = btf_alignment;
> >                 void *phdr = gelf_newphdr(elf, phnum+1);
> >                 if (!phdr) {
> >                         fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
> > --
> > 2.30.0.365.g02bc693789-goog
> >
