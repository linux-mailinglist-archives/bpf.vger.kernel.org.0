Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487BB307739
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhA1Ngr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 08:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhA1Ngp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 08:36:45 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5635C061574
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 05:36:04 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m25so1327564vkk.6
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP5AX6eRuH8975QLRszVCUh5ptrVOePIFc8DADAlkB8=;
        b=LYRMHghzoSOxp58mGJyIY1ue4hpWokKmchL8eJYX6S4Yn4yMU0dKgESvkWh6csB7kE
         /SphyjEzTfDjBhmWE782sRJHp8+uyQ4Jv5FuqlaKaw0nQu1vvtr4gulH1FSLgIiZQvG1
         DP5G1KezT/aWAHReCBtHxVOIxhf5rXFhWTmOxyVSyyOWzh2QmudlaLenON9XvNgI+DBd
         aiadumbc2Yh68f+i5L4tVBkxoLF+Iy7p64yZsQYT5TCXeWrkiYNKcce1c1GawNHAdk2y
         zMkC10lDsruaceuw6dK1Wbz8WIF1TWdKd0r4VgSlpYB5HMw0GKxZGRUoC28uvTM4lk+m
         DKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP5AX6eRuH8975QLRszVCUh5ptrVOePIFc8DADAlkB8=;
        b=LH5naxekcVDWyiFARK01R7OBQNnk3S8ypYWSYOuF3pHkfu1RaV7AiYMRuD7HAewbYL
         Dtllw9iwS3euUjiw4DR0U9y80zcWnCLSuqMJ7XQ5nMwv2T0vlqUvrtnpH4+EZSg5ZBTh
         ZX/9ULX+u52uL6ny7Ep+xpAWSxOd4QOaN1DlR+m3a4Et/+OlND5P7SOYQRdTkR/2mOjT
         7wi4SxzSzEMVAcy96QsEn6/98tqLew+7SKeLq+MjTeD9eVdZPcj6LbyI66Ghe2IOAI6K
         Ea3029Z+339J3R4QFtVAOyvLo+JKmFXuThbWYptJnlueknCyGFdBUEF7w02dzWG26auf
         GL7w==
X-Gm-Message-State: AOAM533SakryjabykPZlMhjJIYWnurJvNLRxf9aziqNEqJqQ660Sr5B3
        iCToWTWDwUX92vCWfinFqjiwZeKHqNvYtKCc9Uoy5A==
X-Google-Smtp-Source: ABdhPJzrJl0lv8AQQsCgky1R7C8AuHbMCMlbmTrOsZfyGFP5d11u7TR6HgbgipPzX5FObDNGpSamVvy1XWVjyacKT7E=
X-Received: by 2002:ac5:cf1e:: with SMTP id y30mr6423523vke.18.1611840963767;
 Thu, 28 Jan 2021 05:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com> <20210125130625.2030186-3-gprocida@google.com>
 <20210127232320.GA295637@krava>
In-Reply-To: <20210127232320.GA295637@krava>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 28 Jan 2021 13:35:27 +0000
Message-ID: <CAGvU0Hn9CMXmYdm65KUeCUHXw6iHe5QRwKN39trNou3OXD_CZA@mail.gmail.com>
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

On Wed, 27 Jan 2021 at 23:23, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 25, 2021 at 01:06:23PM +0000, Giuliano Procida wrote:
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
> > In this initial version layout is left completely up to libelf which
> > may be OK for non-loadable object files, but is probably no good for
> > things like vmlinux where all the offsets may change. This is
> > addressed in a follow-up commit.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 145 ++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 100 insertions(+), 45 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 9f76283..fb8e043 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >       uint32_t raw_btf_size;
> >       int fd, err = -1;
> >       size_t strndx;
> > +     void *str_table = NULL;
> >
> >       fd = open(filename, O_RDWR);
> >       if (fd < 0) {
> > @@ -741,74 +742,128 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >       }
> >
> >       /*
> > -      * First we look if there was already a .BTF section to overwrite.
> > +      * First we check if there is already a .BTF section present.
> >        */
> > -
> >       elf_getshdrstrndx(elf, &strndx);
> > +     Elf_Scn *btf_scn = 0;
>
> NULL
>
>
> SNIP
>
> > -             const char *llvm_objcopy;
> > -             char tmp_fn[PATH_MAX];
> > -             char cmd[PATH_MAX * 2];
> > -
> > -             llvm_objcopy = getenv("LLVM_OBJCOPY");
> > -             if (!llvm_objcopy)
> > -                     llvm_objcopy = "llvm-objcopy";
> > -
> > -             /* Use objcopy to add a .BTF section */
> > -             snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > -             close(fd);
> > -             fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > -             if (fd == -1) {
> > -                     fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > -                             tmp_fn);
> > +             /* Add ".BTF" to the section name string table */
> > +             Elf_Data *str_data = elf_getdata(str_scn, NULL);
> > +             if (!str_data) {
> > +                     fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
> > +                             __func__, elf_errmsg(elf_errno()));
> >                       goto out;
> >               }
> > -
> > -             if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > -                     fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > -                             __func__, raw_btf_size, tmp_fn, errno);
> > -                     goto unlink;
> > +             dot_btf_offset = str_data->d_size;
> > +             size_t new_str_size = dot_btf_offset + 5;
> > +             str_table = malloc(new_str_size);
> > +             if (!str_table) {
> > +                     fprintf(stderr, "%s: malloc(%zu) failed: %s\n", __func__,
> > +                             new_str_size, elf_errmsg(elf_errno()));
> > +                     goto out;
> >               }
> > +             memcpy(str_table, str_data->d_buf, dot_btf_offset);
> > +             memcpy(str_table + dot_btf_offset, ".BTF", 5);
>
> hum, I wonder this will always copy the final zero byte

It should, as strlen(".BTF") == 4.

> > +             str_data->d_buf = str_table;
> > +             str_data->d_size = new_str_size;
> > +             elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +             /* Create a new section */
> > +             btf_scn = elf_newscn(elf);
> > +             if (!btf_scn) {
> > +                     fprintf(stderr, "%s: elf_newscn failed: %s\n",
> > +                     __func__, elf_errmsg(elf_errno()));
> > +                     goto out;
> > +             }
> > +             btf_data = elf_newdata(btf_scn);
> > +             if (!btf_data) {
> > +                     fprintf(stderr, "%s: elf_newdata failed: %s\n",
> > +                     __func__, elf_errmsg(elf_errno()));
> > +                     goto out;
> > +             }
> > +     }
> >
> > -             snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> > -                      llvm_objcopy, tmp_fn, filename);
> > -             if (system(cmd)) {
> > -                     fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > -                             __func__, filename, errno);
> > -                     goto unlink;
> > +     /* (Re)populate the BTF section data */
> > +     raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > +     btf_data->d_buf = (void *)raw_btf_data;
>
> doesn't this potentially leak btf_data->d_buf?

I believe libelf owns the original btf_data->d_buf and it could even
just be a pointer into mmaped memory,  but I will check.

> > +     btf_data->d_size = raw_btf_size;
> > +     btf_data->d_type = ELF_T_BYTE;
> > +     btf_data->d_version = EV_CURRENT;
> > +     elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +     /* Update .BTF section in the SHT */
> > +     GElf_Shdr btf_shdr_mem;
> > +     GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> > +     if (!btf_shdr) {
> > +             fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
> > +                     __func__, elf_errmsg(elf_errno()));
> > +             goto out;
> > +     }
> > +     btf_shdr->sh_entsize = 0;
> > +     btf_shdr->sh_flags = 0;
> > +     if (dot_btf_offset)
> > +             btf_shdr->sh_name = dot_btf_offset;
> > +     btf_shdr->sh_type = SHT_PROGBITS;
> > +     if (!gelf_update_shdr(btf_scn, btf_shdr)) {
> > +             fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
> > +                     __func__, elf_errmsg(elf_errno()));
> > +             goto out;
> > +     }
> > +
> > +     if (elf_update(elf, ELF_C_NULL) < 0) {
> > +             fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
> > +                     __func__, elf_errmsg(elf_errno()));
> > +             goto out;
> > +     }
> > +
> > +     size_t phnum = 0;
> > +     if (!elf_getphdrnum(elf, &phnum)) {
> > +             for (size_t ix = 0; ix < phnum; ++ix) {
> > +                     GElf_Phdr phdr;
> > +                     GElf_Phdr *elf_phdr = gelf_getphdr(elf, ix, &phdr);
> > +                     size_t filesz = gelf_fsize(elf, ELF_T_PHDR, 1, EV_CURRENT);
> > +                     fprintf(stderr, "type: %d %d\n", elf_phdr->p_type, PT_PHDR);
> > +                     fprintf(stderr, "offset: %lu %lu\n", elf_phdr->p_offset, ehdr->e_phoff);
> > +                     fprintf(stderr, "filesize: %lu %lu\n", elf_phdr->p_filesz, filesz);
>
> looks like s forgotten debug or you're missing
> btf_elf__verbose check for fprintf calls above

Oops, forgotten debug.

>
> jirka
>

Thanks,
Giuliano.
