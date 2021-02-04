Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DF30FB83
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhBDSbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbhBDSam (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 13:30:42 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DEC061788
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 10:29:51 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id e10so907610vkm.2
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrbb+FhQsOP06mKN+FTW39dmrGDoQl/JosYGMhqlToI=;
        b=Md4d4Ut3RDC/jj65grwMZ/RNflMHO8gKbSyW4kUM/AkseBuBbEzk1TEQ+l6FbmaqEk
         s1A7TSl3bEP7q62bVGsA0R3p/nbwotZqeDkDGzkZCmeJ/MEYfvE6ZZK9CX/jOopHN9je
         UoVeDF4GdzpPaKtK1X7ou9r5K8C1R625CGahJ0uOKZnL8hFSes6W++G0jsbszdi/ki1C
         TrWGxZgscSkIr+d/Rc93MdBjLVGtdN5IIDNDNZ5B/U28U53bH9HvTfD2QJ6gAmFyUR+B
         SfDxOBgdDTWysadMczJ1i7U5QaCEVrRNWKbPEwpEV6P8hSEnlsWSYd9dSDtBugF2f6uX
         qxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrbb+FhQsOP06mKN+FTW39dmrGDoQl/JosYGMhqlToI=;
        b=Af5Xm4ES6Anmge+l1tiOkX0ZFep4dIqWBDh0uRpN5JF7la6GM5j9u7NjHAGcZaQpkE
         t+N+x3RWcDPCs7ywc7Bs0+2leziB9ZG+Agoqvv8EeA6Vv0A9VsqGRVsl8QLqptln/iIL
         9+8diHrdKY8izbBrLy7LkqPFEcSzpoLCDWDEgo/IIWBFpRRqCAnvX2DzNeZzdg6Sr+GE
         D5KJWoN/n5a1wlA7mWsqw9t7oLGAgKsZPMPHEk3UaBvheN3b/BSoB4K74nfCftZ3RFxF
         X6jefkcGl55ynG9EuCz4+01lGSOaNSre+oCEKr7ORDUPG74dgDJnHuVQ4V8u0y9niGWr
         HIUQ==
X-Gm-Message-State: AOAM5332phELGawElk291yTbgbC1TA4q6w853bvC0noNa/+sBHz3Ys0D
        TgTRenFMj3k3/GQcKB5W9zz35JWmJUjlT4MbayFCBA==
X-Google-Smtp-Source: ABdhPJwwEwvNC3zQT61ZEauXppJ4DNsiU2g8v5m4grt7ICMaeSDSm/qt9y3Za0rtfLI7Yvlh6yON0sD5rU2yemeiB30=
X-Received: by 2002:ac5:cf1e:: with SMTP id y30mr490215vke.18.1612463389942;
 Thu, 04 Feb 2021 10:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-2-gprocida@google.com>
 <CAEf4BzYxfO72ozDtjjXynewfQv_ZLvVEFWrEHwro7J1uwMy-Kw@mail.gmail.com>
In-Reply-To: <CAEf4BzYxfO72ozDtjjXynewfQv_ZLvVEFWrEHwro7J1uwMy-Kw@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 4 Feb 2021 18:29:13 +0000
Message-ID: <CAGvU0HmL28uARL2NSUGuau=qohamqtCRmPCBOQ9XhoQLOAfwXw@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 1/4] btf_encoder: Add .BTF section using libelf
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

On Thu, 4 Feb 2021 at 04:10, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>

I've addressed all the comments below, except for flag control over
whether .BTF is loadable, in pending commits.
I've also moved the simple alignment change to earlier in the series.
I'll review any other comments and see if I can work out what's wrong
with the segment creation code or if it's worth preserving. I think
it's likely that anything involving segments won't survive.

Thanks for reviewing!

> On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > pahole -J uses libelf directly when updating a .BTF section. However,
> > it uses llvm-objcopy to add .BTF sections. This commit switches to
> > using libelf for both cases.
> >
> > This eliminates pahole's dependency on llvm-objcopy. One unfortunate
> > side-effect is that vmlinux actually increases in size. It seems that
> > llvm-objcopy modifies the .strtab section, discarding many strings. I
> > speculate that is it discarding strings not referenced from .symtab
> > and updating the references therein.
> >
> > In this initial version layout is left completely up to libelf and
> > indeed offsets of existing sections are likely to change.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 134 ++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 88 insertions(+), 46 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 81b1b36..5b91d3a 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -698,6 +698,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >         uint32_t raw_btf_size;
> >         int fd, err = -1;
> >         size_t strndx;
> > +       void *str_table = NULL;
> >
> >         fd = open(filename, O_RDWR);
> >         if (fd < 0) {
> > @@ -740,74 +741,115 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >         }
> >
> >         /*
> > -        * First we look if there was already a .BTF section to overwrite.
> > +        * First we check if there is already a .BTF section present.
> >          */
> > -
> >         elf_getshdrstrndx(elf, &strndx);
> > +       Elf_Scn *btf_scn = 0;
>
> NULL, not 0
>
> >         while ((scn = elf_nextscn(elf, scn)) != NULL) {
> >                 shdr = gelf_getshdr(scn, &shdr_mem);
> >                 if (shdr == NULL)
> >                         continue;
> >                 char *secname = elf_strptr(elf, strndx, shdr->sh_name);
> >                 if (strcmp(secname, ".BTF") == 0) {
> > -                       btf_data = elf_getdata(scn, btf_data);
> > +                       btf_scn = scn;
> >                         break;
> >                 }
> >         }
> >
> > -       raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > -
> > -       if (btf_data) {
> > -               /* Exisiting .BTF section found */
> > -               btf_data->d_buf = (void *)raw_btf_data;
> > -               btf_data->d_size = raw_btf_size;
> > -               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > +       Elf_Scn *str_scn = elf_getscn(elf, strndx);
> > +       if (!str_scn) {
> > +               fprintf(stderr, "%s: elf_getscn(strndx) failed\n", __func__);
>
> no elf_errmsg(elf_errno()) here? BTW, this form is very common (and a
> bit verbose), so how about having a local macro that would make this
> shorter, e.g.:
>
> elf_error("elf_getscn(strndx) failed"); ?
>
> > +               goto out;
> > +       }
> >
> > -               if (elf_update(elf, ELF_C_NULL) >= 0 &&
> > -                   elf_update(elf, ELF_C_WRITE) >= 0)
> > -                       err = 0;
> > -               else
> > -                       fprintf(stderr, "%s: elf_update failed: %s.\n",
> > -                               __func__, elf_errmsg(elf_errno()));
> > +       size_t dot_btf_offset = 0;
> > +       if (btf_scn) {
> > +               /* Existing .BTF section found */
> > +               btf_data = elf_getdata(btf_scn, NULL);
> > +               if (!btf_data) {
> > +                       fprintf(stderr, "%s: elf_getdata failed: %s\n", __func__,
> > +                               elf_errmsg(elf_errno()));
> > +                       goto out;
> > +               }
> >         } else {
> > -               const char *llvm_objcopy;
> > -               char tmp_fn[PATH_MAX];
> > -               char cmd[PATH_MAX * 2];
> > -
> > -               llvm_objcopy = getenv("LLVM_OBJCOPY");
> > -               if (!llvm_objcopy)
> > -                       llvm_objcopy = "llvm-objcopy";
> > -
> > -               /* Use objcopy to add a .BTF section */
> > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > -               close(fd);
> > -               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > -               if (fd == -1) {
> > -                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > -                               tmp_fn);
> > +               /* Add ".BTF" to the section name string table */
> > +               Elf_Data *str_data = elf_getdata(str_scn, NULL);
> > +               if (!str_data) {
> > +                       fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
> > +                               __func__, elf_errmsg(elf_errno()));
> >                         goto out;
> >                 }
> > -
> > -               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > -                       fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > -                               __func__, raw_btf_size, tmp_fn, errno);
> > -                       goto unlink;
> > +               dot_btf_offset = str_data->d_size;
> > +               size_t new_str_size = dot_btf_offset + 5;
>
> 5 is a bit magical, maybe use sizeof(".BTF") or a dedicated constant?
>
> > +               str_table = malloc(new_str_size);
> > +               if (!str_table) {
> > +                       fprintf(stderr, "%s: malloc (strtab) failed\n", __func__);
> > +                       goto out;
> >                 }
> > -
> > -               snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> > -                        llvm_objcopy, tmp_fn, filename);
> > -               if (system(cmd)) {
> > -                       fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > -                               __func__, filename, errno);
> > -                       goto unlink;
> > +               memcpy(str_table, str_data->d_buf, dot_btf_offset);
> > +               memcpy(str_table + dot_btf_offset, ".BTF", 5);
>
> same about magical 5
>
> > +               str_data->d_buf = str_table;
> > +               str_data->d_size = new_str_size;
> > +               elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +               /* Create a new section */
> > +               btf_scn = elf_newscn(elf);
> > +               if (!btf_scn) {
> > +                       fprintf(stderr, "%s: elf_newscn failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +                       goto out;
> > +               }
> > +               btf_data = elf_newdata(btf_scn);
> > +               if (!btf_data) {
> > +                       fprintf(stderr, "%s: elf_newdata failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +                       goto out;
> >                 }
> > +       }
> >
> > -               err = 0;
> > -       unlink:
> > -               unlink(tmp_fn);
> > +       /* (Re)populate the BTF section data */
> > +       raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > +       btf_data->d_buf = (void *)raw_btf_data;
> > +       btf_data->d_size = raw_btf_size;
> > +       btf_data->d_type = ELF_T_BYTE;
> > +       btf_data->d_version = EV_CURRENT;
> > +       elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +       /* Update .BTF section in the SHT */
> > +       GElf_Shdr btf_shdr_mem;
> > +       GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> > +       if (!btf_shdr) {
>
>
> btf_shdr just points to btf_shdr_mem, no? This duplication is not
> pretty, why not:
>
> GElf_Shdr btf_shdr;
> if (!gelf_getshdr(btf_scn, &btf_shdr_mem)) { ... }
>
> And then use btf_shdr. everywhere below
>
> > +               fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +               goto out;
> > +       }
> > +       btf_shdr->sh_entsize = 0;
> > +       btf_shdr->sh_flags = SHF_ALLOC;
>
> this is wrong, making .BTF allocatable should be an opt-in, not all
> applications need to have a loadable .BTF section. Plus this patch
> doesn't really make it loadable, so SHF_ALLOC should be updated in the
> later patch. And I don't think we'll use that for vmlinux BTF or
> kernel module BTFs either, because there is still going to be linker
> script involved.
>
>
> > +       if (dot_btf_offset)
> > +               btf_shdr->sh_name = dot_btf_offset;
> > +       btf_shdr->sh_type = SHT_PROGBITS;
> > +       if (!gelf_update_shdr(btf_scn, btf_shdr)) {
> > +               fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +               goto out;
> > +       }
> > +
> > +       if (elf_update(elf, ELF_C_NULL) < 0) {
> > +               fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +               goto out;
> > +       }
> > +
> > +       if (elf_update(elf, ELF_C_WRITE) < 0) {
> > +               fprintf(stderr, "%s: elf_update (write) failed: %s\n",
> > +                       __func__, elf_errmsg(elf_errno()));
> > +               goto out;
> >         }
> > +       err = 0;
> >
> >  out:
> > +       if (str_table)
> > +               free(str_table);
> >         if (fd != -1)
> >                 close(fd);
> >         if (elf)
> > --
> > 2.30.0.365.g02bc693789-goog
> >
