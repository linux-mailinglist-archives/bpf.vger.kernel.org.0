Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96263115D5
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBEWnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhBENmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 08:42:14 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C373C0617AA
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 05:41:32 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id i12so3580831vsq.6
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTSkz3lDpV/ec5h11x6M2gXWYeaUMZyhEL4qU1jWZsQ=;
        b=Ulxx4QsFtp2Nh0vYk+veivQmzFo7UlpHDqKsEllK9gr/fuKe5tPKGWwLce1YkiAdbC
         fhReIkFVMobeyWN6q75J3wHboLYXy8xMMvAaM9UqRL4d8m/MktMJKKixcaBDw8mKRoZ7
         +qcovyskD8x+McfBfRTPlt8i2dNpxzXZEpEtfrkWhhxtWfVcLE34xOEwEqUE9SWRtXeC
         4kIJbjrV4lIAJ0oVljlxkraF+tbNDPFFaRXbTpGFDqdZHHMYOV3WbKOkAz1hE5O7/uHA
         G47Gqga1q9jfWLoKE952ptm/qibiIXxHqhPikxSfhODsDGP1wqYgqVfuhInjep6hHLdO
         iS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTSkz3lDpV/ec5h11x6M2gXWYeaUMZyhEL4qU1jWZsQ=;
        b=ezBZ6hRBIdnRLt3PnxlIT5+fv/9QgnN1gmDeLiT98tTA7Xo3IMlZ902YMEQiqEYwKR
         FpgbnWaGVH6I1p2D1FgNi/YrrYmP5Vrmgy614ec0reEhgAi/oao/FWmtjdycyvwIruYQ
         wwtQpCyOnM/89wKoOFAB7DoAPlE7icsU4L5IiSA130Un9wBJ9MH4sviWcxtwsqrZKIw4
         ayQWX0cH03q9c3w/R+7Rve6rB3U/8nQjccDMqiPOobx32kgdLL7V5lx1wpmZjg48LHYE
         r+N1bD9xhRCf7i6KayNAhPuHlMNP00CsQWK4s+lstYomv2w30PI8Du+O9jdexOvKAnF8
         TaSQ==
X-Gm-Message-State: AOAM5337yLtKihRs/yvFkVsBXb4HNWh2i2xfJD2Kz6XRV+nXGmDikT1+
        CXcWlFlKPSMqrc6uSFe6S9l4w6KB8+ZAGaFwXeXUxA==
X-Google-Smtp-Source: ABdhPJwovzciMQTsQ5shYwY3ynjubMuzzjFimZQ0NBuT6h+UdXCE99gfjyEkFGbMf6RVc/aVkss8YPu5sI34+QMh8kE=
X-Received: by 2002:a67:87c2:: with SMTP id j185mr3073834vsd.25.1612532491023;
 Fri, 05 Feb 2021 05:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com> <20210125130625.2030186-3-gprocida@google.com>
 <20210127232320.GA295637@krava> <CAGvU0Hn9CMXmYdm65KUeCUHXw6iHe5QRwKN39trNou3OXD_CZA@mail.gmail.com>
In-Reply-To: <CAGvU0Hn9CMXmYdm65KUeCUHXw6iHe5QRwKN39trNou3OXD_CZA@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Fri, 5 Feb 2021 13:40:54 +0000
Message-ID: <CAGvU0H=yCyp=XJAH639Ae+sGwG1OTXA0y0J=tPB9-qkQ5gM-1w@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/4] btf_encoder: Add .BTF section using libelf
To:     Jiri Olsa <jolsa@redhat.com>
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

On Thu, 28 Jan 2021 at 13:35, Giuliano Procida <gprocida@google.com> wrote:
>
> Hi.
>
> On Wed, 27 Jan 2021 at 23:23, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Jan 25, 2021 at 01:06:23PM +0000, Giuliano Procida wrote:
> > > pahole -J uses libelf directly when updating a .BTF section. However,
> > > it uses llvm-objcopy to add .BTF sections. This commit switches to
> > > using libelf for both cases.
> > >
> > > This eliminates pahole's dependency on llvm-objcopy. One unfortunate
> > > side-effect is that vmlinux actually increases in size. It seems that
> > > llvm-objcopy modifies the .strtab section, discarding many strings. I
> > > speculate that is it discarding strings not referenced from .symtab
> > > and updating the references therein.
> > >
> > > In this initial version layout is left completely up to libelf which
> > > may be OK for non-loadable object files, but is probably no good for
> > > things like vmlinux where all the offsets may change. This is
> > > addressed in a follow-up commit.
> > >
> > > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > ---
> > >  libbtf.c | 145 ++++++++++++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 100 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/libbtf.c b/libbtf.c
> > > index 9f76283..fb8e043 100644
> > > --- a/libbtf.c
> > > +++ b/libbtf.c
> > > @@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> > >       uint32_t raw_btf_size;
> > >       int fd, err = -1;
> > >       size_t strndx;
> > > +     void *str_table = NULL;
> > >
> > >       fd = open(filename, O_RDWR);
> > >       if (fd < 0) {
> > > @@ -741,74 +742,128 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> > >       }
> > >
> > >       /*
> > > -      * First we look if there was already a .BTF section to overwrite.
> > > +      * First we check if there is already a .BTF section present.
> > >        */
> > > -
> > >       elf_getshdrstrndx(elf, &strndx);
> > > +     Elf_Scn *btf_scn = 0;
> >
> > NULL
> >
> >
> > SNIP
> >
> > > -             const char *llvm_objcopy;
> > > -             char tmp_fn[PATH_MAX];
> > > -             char cmd[PATH_MAX * 2];
> > > -
> > > -             llvm_objcopy = getenv("LLVM_OBJCOPY");
> > > -             if (!llvm_objcopy)
> > > -                     llvm_objcopy = "llvm-objcopy";
> > > -
> > > -             /* Use objcopy to add a .BTF section */
> > > -             snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > > -             close(fd);
> > > -             fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > > -             if (fd == -1) {
> > > -                     fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > > -                             tmp_fn);
> > > +             /* Add ".BTF" to the section name string table */
> > > +             Elf_Data *str_data = elf_getdata(str_scn, NULL);
> > > +             if (!str_data) {
> > > +                     fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
> > > +                             __func__, elf_errmsg(elf_errno()));
> > >                       goto out;
> > >               }
> > > -
> > > -             if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > > -                     fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > > -                             __func__, raw_btf_size, tmp_fn, errno);
> > > -                     goto unlink;
> > > +             dot_btf_offset = str_data->d_size;
> > > +             size_t new_str_size = dot_btf_offset + 5;
> > > +             str_table = malloc(new_str_size);
> > > +             if (!str_table) {
> > > +                     fprintf(stderr, "%s: malloc(%zu) failed: %s\n", __func__,
> > > +                             new_str_size, elf_errmsg(elf_errno()));
> > > +                     goto out;
> > >               }
> > > +             memcpy(str_table, str_data->d_buf, dot_btf_offset);
> > > +             memcpy(str_table + dot_btf_offset, ".BTF", 5);
> >
> > hum, I wonder this will always copy the final zero byte
>
> It should, as strlen(".BTF") == 4.
>
> > > +             str_data->d_buf = str_table;
> > > +             str_data->d_size = new_str_size;
> > > +             elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
> > > +
> > > +             /* Create a new section */
> > > +             btf_scn = elf_newscn(elf);
> > > +             if (!btf_scn) {
> > > +                     fprintf(stderr, "%s: elf_newscn failed: %s\n",
> > > +                     __func__, elf_errmsg(elf_errno()));
> > > +                     goto out;
> > > +             }
> > > +             btf_data = elf_newdata(btf_scn);
> > > +             if (!btf_data) {
> > > +                     fprintf(stderr, "%s: elf_newdata failed: %s\n",
> > > +                     __func__, elf_errmsg(elf_errno()));
> > > +                     goto out;
> > > +             }
> > > +     }
> > >
> > > -             snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> > > -                      llvm_objcopy, tmp_fn, filename);
> > > -             if (system(cmd)) {
> > > -                     fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > > -                             __func__, filename, errno);
> > > -                     goto unlink;
> > > +     /* (Re)populate the BTF section data */
> > > +     raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > > +     btf_data->d_buf = (void *)raw_btf_data;
> >
> > doesn't this potentially leak btf_data->d_buf?
>
> I believe libelf owns the original btf_data->d_buf and it could even
> just be a pointer into mmaped memory,  but I will check.
>

FTR, that pointer *is* owned by libelf. If I free it, I get a
double-free warning later on.

> > > +     btf_data->d_size = raw_btf_size;
> > > +     btf_data->d_type = ELF_T_BYTE;
> > > +     btf_data->d_version = EV_CURRENT;
> > > +     elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > > +
> > > +     /* Update .BTF section in the SHT */
> > > +     GElf_Shdr btf_shdr_mem;
> > > +     GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> > > +     if (!btf_shdr) {
> > > +             fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
> > > +                     __func__, elf_errmsg(elf_errno()));
> > > +             goto out;
> > > +     }
> > > +     btf_shdr->sh_entsize = 0;
> > > +     btf_shdr->sh_flags = 0;
> > > +     if (dot_btf_offset)
> > > +             btf_shdr->sh_name = dot_btf_offset;
> > > +     btf_shdr->sh_type = SHT_PROGBITS;
> > > +     if (!gelf_update_shdr(btf_scn, btf_shdr)) {
> > > +             fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
> > > +                     __func__, elf_errmsg(elf_errno()));
> > > +             goto out;
> > > +     }
> > > +
> > > +     if (elf_update(elf, ELF_C_NULL) < 0) {
> > > +             fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
> > > +                     __func__, elf_errmsg(elf_errno()));
> > > +             goto out;
> > > +     }
> > > +
> > > +     size_t phnum = 0;
> > > +     if (!elf_getphdrnum(elf, &phnum)) {
> > > +             for (size_t ix = 0; ix < phnum; ++ix) {
> > > +                     GElf_Phdr phdr;
> > > +                     GElf_Phdr *elf_phdr = gelf_getphdr(elf, ix, &phdr);
> > > +                     size_t filesz = gelf_fsize(elf, ELF_T_PHDR, 1, EV_CURRENT);
> > > +                     fprintf(stderr, "type: %d %d\n", elf_phdr->p_type, PT_PHDR);
> > > +                     fprintf(stderr, "offset: %lu %lu\n", elf_phdr->p_offset, ehdr->e_phoff);
> > > +                     fprintf(stderr, "filesize: %lu %lu\n", elf_phdr->p_filesz, filesz);
> >
> > looks like s forgotten debug or you're missing
> > btf_elf__verbose check for fprintf calls above
>
> Oops, forgotten debug.
>
> >
> > jirka
> >
>
> Thanks,
> Giuliano.
