Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBF31521A
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBIOyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 09:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhBIOyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 09:54:09 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94957C061786
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 06:53:29 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id t15so5923874ual.6
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HMQPWYwwjDAZ4Q9sEG15K7UScNkaWeZmvBDmiX0/A0=;
        b=G5XIzuMu5s2zv+dvO5il35uU6abmwOqonH4Q41jK0CKmAvRWaWiFxi887AmX/OliCy
         WsIP0q+Qu/2hiXWorFVIJE3+xIR356KkEfrVM06ITSu+a7ib1A16fjpJZU6fOD2CE6wx
         LPb1ir55moGt9ilFew3E3PNuqYrTiHpNc94hfUj15foXEdw8CBiTGKQUL8p29qJ72AEW
         VpRO9End3CWldGzMSJC4XE3F36Q2BIWT8xYny1YN58vndeoByLr4xkfh35wW4IE7K0YR
         T6GdxzpCKHUedk8w+sUrkSQWHrgYk+TXgq0jVOjjZ58/nXXZISeTQa/6GVVipv2YbnS6
         EgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HMQPWYwwjDAZ4Q9sEG15K7UScNkaWeZmvBDmiX0/A0=;
        b=okc0n20JxcfPGl1kt1UpLdY00VYRBfzPrPQtfMqVcYmTgZ2AF/NnTkatSR+4aiJlsj
         BLZfaeK52wnaCCFwKDGsqk/DCDbDWt8lLCAJ5+KnNZ2BP6iCDBFbIaZttfqVX8RSPllY
         zlEWi6uSKWJyMF4ziXxHWLjaENxOBgT46aMEQgjViid9YUBu1eoUM7JyJTIkDt/IYN11
         qtRtqgkRrtDV40dXd0/awEn8Hst5ocY6CsAakvWoxGtO9TKFsDlOIAI3xCHvrrNMP42O
         /2ET28GidwC6I/WivmdumpbYpFCCC/WD8f+X2GECQyNhrkSWntV3g5NzeokgfLkyLTUB
         QTFg==
X-Gm-Message-State: AOAM533TRh48yc+zd4Ek9UhjkbILa9jrhfOEcogDET8X8lPpJYu5emu5
        mkST61eK44i2RdexZPjjt1/s9QsHxsjn9T6svn332g==
X-Google-Smtp-Source: ABdhPJxNZ1uMgFBAeJhnLBalysHOP3YiaEY/c5ckS2xbSaUugn3rqI97mmq0Tkw2H+4gsk+MjNDE47IkIFh0Fo5j5Vg=
X-Received: by 2002:a9f:2985:: with SMTP id s5mr13580700uas.13.1612882408477;
 Tue, 09 Feb 2021 06:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-3-gprocida@google.com> <CAEf4BzZP8hWkBUKi15j3E+D63n9269viQyCagsHpJFm=DOE4Gg@mail.gmail.com>
In-Reply-To: <CAEf4BzZP8hWkBUKi15j3E+D63n9269viQyCagsHpJFm=DOE4Gg@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 14:52:54 +0000
Message-ID: <CAGvU0HnzLxUsQz2v5qikU6Xts2sPTCKMdLOYS1=ksE6+bGUkcw@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
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

On Mon, 8 Feb 2021 at 22:23, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > Many operations in the libelf API return a pointer to a user-provided
> > struct (on success) or NULL (on failure).
> >
> > There are a couple of places in btf_elf__write where both structs and
> > pointers to the same structs are used. Holding on to the pointers
> > raises ownership and lifetime issues unncessarily and the code is
>
> typo: unnecessarily
>

Thanks. Fixed.

> > cleaner with only a single access path for these data.
> >
> > The code now treats the returned pointers as booleans.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
>
> styling nits, but otherwise LGTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  libbtf.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 7bc49ba..ace8896 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -698,8 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
> >
> >  static int btf_elf__write(const char *filename, struct btf *btf)
> >  {
> > -       GElf_Shdr shdr_mem, *shdr;
> > -       GElf_Ehdr ehdr_mem, *ehdr;
> > +       GElf_Ehdr ehdr;
> >         Elf_Data *btf_data = NULL;
> >         Elf_Scn *scn = NULL;
> >         Elf *elf = NULL;
> > @@ -727,13 +726,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >
> >         elf_flagelf(elf, ELF_C_SET, ELF_F_DIRTY);
> >
> > -       ehdr = gelf_getehdr(elf, &ehdr_mem);
> > -       if (ehdr == NULL) {
> > +       if (!gelf_getehdr(elf, &ehdr)) {
> >                 elf_error("elf_getehdr failed");
> >                 goto out;
> >         }
> >
> > -       switch (ehdr_mem.e_ident[EI_DATA]) {
> > +       switch (ehdr.e_ident[EI_DATA]) {
> >         case ELFDATA2LSB:
> >                 btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
> >                 break;
> > @@ -751,10 +749,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >
> >         elf_getshdrstrndx(elf, &strndx);
> >         while ((scn = elf_nextscn(elf, scn)) != NULL) {
> > -               shdr = gelf_getshdr(scn, &shdr_mem);
> > -               if (shdr == NULL)
> > +               GElf_Shdr shdr;
>
> it's a good style to have an empty line between variable declaration
> block and subsequent instructions
>

The variable in this question is effectively initialised by the
statement on the next line, breaking them apart looks odd.
Also, this is not a variable that needs end-of-scope clean-up. Its
position at the top of the scope is coincidental.
Later commits in the series also place declaration and initialisation
as close together as possible.
The only variables I would intentionally place at the top of a given
scope *and* far from their natural points of initialisation are those
corresponding to resources that need to be released at the end of the
scope, with the labelled exit idiom.
I feel this gives a better balance between readability (keeping things
local) and keeping track of resources (memory, fds, other handles) in
a scope.

However, if that's contrary to the house style, it's easy enough to
pull all the declarations out and move them to the top and separate
them; the compiler should be clever enough to share stack slots in any
case.

Let me know.

Regards,
Giuliano.

>
> > +               if (!gelf_getshdr(scn, &shdr))
> >                         continue;
> > -               char *secname = elf_strptr(elf, strndx, shdr->sh_name);
> > +               char *secname = elf_strptr(elf, strndx, shdr.sh_name);
> >                 if (strcmp(secname, ".BTF") == 0) {
> >                         btf_data = elf_getdata(scn, btf_data);
> >                         break;
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
