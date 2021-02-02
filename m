Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F9F30BC70
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBBK4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 05:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBBK4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 05:56:01 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4FAC061573
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 02:55:21 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id g13so6963967uaw.5
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2KcHewdO5OWdri1u0nj0dmMm94dkytL7v5kHywy6GM=;
        b=HdNk6ieCmG3cO1gUZZoUb89+U/a2vaB5zFr5uYXmkArQwGcGBD2/6dMsKXQZ33nR5m
         jiPu12XcbGQz7/+H/32v6JIJEGOvQNKsXAcSvj4woCbciTEZU0aHVdYUozLSIpzgBItd
         CyXzVl8FIInt88jLHaCFfUz2bhNV6sKAjBHFDYWl9CAdXe3lD5EfHDXm7P5IMbYY5LuS
         qxZ4uN2yk67DdZsF8YnzYbjUgrJjpyLRuJt2qYW+MYfog6HbeqhLIH2cq9GW9atBheac
         cRgQStgdmV0neEfbQhGBgT937ytWLL0yU1pKR2/6xFKulSlG1ouR9NRJaFqwPB3aH3JC
         lyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2KcHewdO5OWdri1u0nj0dmMm94dkytL7v5kHywy6GM=;
        b=OenLtBSiNGnFQO6rHECy4upKh708o3tpYp4NGlMpKeUnlRTYX39vs8zvX/bh3EIfFG
         4WsJjUm7VVoj3mXRH0mZrFCFiKXc8P7VrKeIPVx4Dd2zH/E9Eu2Gc6YCnkNFmvxTPzOO
         uc0ABLh4Srbgy6veqACw+X2sBWKKvHHDl8/fw21CK1bkFyvq2I5iwwS5SKCg7nCO0cY9
         +pzZmYORZ3QxhBYSiUGbTcCDVFHkxyJkXFXtsFFRYzeHwiD4oZ7pDD7vwUvMJmdf42MU
         3EuiuqfadC44+7YlVO6e/JOuPSHyc2z8maBw+MDn32ubWmIvUcL7YtIoV4EwHo7UUk7a
         uVTA==
X-Gm-Message-State: AOAM533VtartU6vrbIFRGnpHaUHUYPV8Fb1t5pWex9/EqEKd292LLHOi
        qzuJQmJLq4Xek9vqm5lZNGAmyqd4ZKGuK2CjSmVv+A==
X-Google-Smtp-Source: ABdhPJzIQLKbz2ruSkS7bpqdFRvpVqpaXUDzMwuBVABT2JQ7OtOfSEZnJEeBr1fw9SCccCx8Q9VjtazbkuyGPdP764g=
X-Received: by 2002:ab0:7193:: with SMTP id l19mr11527394uao.84.1612263320452;
 Tue, 02 Feb 2021 02:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-4-gprocida@google.com>
In-Reply-To: <20210201172530.1141087-4-gprocida@google.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 2 Feb 2021 10:54:43 +0000
Message-ID: <CAGvU0HnVVJYPXV65aG_iM7n5_SKp_CQ6OKwTG=YhXsYMRkQAYQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 3/4] btf_encoder: Add .BTF as a loadable segment
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two issues here.

On Mon, 1 Feb 2021 at 17:26, Giuliano Procida <gprocida@google.com> wrote:
>
> In addition to adding .BTF to the Section Header Table, we also need
> to add it to the Program Header Table and rewrite the PHT's
> description of itself.
>
> The segment as loadbale, at address 0 and read-only.
>

Typos.

> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/libbtf.c b/libbtf.c
> index 6e06a58..048a873 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         int fd, err = -1;
>         size_t strndx;
>         void *str_table = NULL;
> +       GElf_Phdr *pht = NULL;
>
>         fd = open(filename, O_RDWR);
>         if (fd < 0) {
> @@ -900,6 +901,47 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 goto out;
>         }
>
> +       size_t phnum = 0;
> +       if (!elf_getphdrnum(elf, &phnum)) {
> +               pht = malloc((phnum + 1) * sizeof(GElf_Phdr));

Adding a segment unconditionally is incorrect.
It should behave differently if .BTF already has its own segment or is
part of an existing segment containing other sections.
The ELF surgery needed in the general case may be considerable.

> +               if (!pht) {
> +                       fprintf(stderr, "%s: malloc (PHT) failed\n", __func__);
> +                       goto out;
> +               }
> +               for (size_t ix = 0; ix < phnum; ++ix) {
> +                       if (!gelf_getphdr(elf, ix, &pht[ix])) {
> +                               fprintf(stderr,
> +                                       "%s: gelf_getphdr(%zu) failed: %s\n",
> +                                       __func__, ix, elf_errmsg(elf_errno()));
> +                               goto out;
> +                       }
> +                       if (pht[ix].p_type == PT_PHDR) {
> +                               size_t fsize = gelf_fsize(elf, ELF_T_PHDR,
> +                                                         phnum+1, EV_CURRENT);
> +                               pht[ix].p_memsz = pht[ix].p_filesz = fsize;
> +                       }
> +               }
> +               pht[phnum].p_type = PT_LOAD;
> +               pht[phnum].p_offset = btf_shdr->sh_offset;
> +               pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
> +               pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
> +               pht[phnum].p_flags = PF_R;
> +               void *phdr = gelf_newphdr(elf, phnum+1);
> +               if (!phdr) {
> +                       fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
> +                               __func__, elf_errmsg(elf_errno()));
> +                       goto out;
> +               }
> +               for (size_t ix = 0; ix < phnum+1; ++ix) {
> +                       if (!gelf_update_phdr(elf, ix, &pht[ix])) {
> +                               fprintf(stderr,
> +                                       "%s: gelf_update_phdr(%zu) failed: %s\n",
> +                                       __func__, ix, elf_errmsg(elf_errno()));
> +                               goto out;
> +                       }
> +               }
> +       }
> +
>         if (elf_update(elf, ELF_C_WRITE) < 0) {
>                 fprintf(stderr, "%s: elf_update (write) failed: %s\n",
>                         __func__, elf_errmsg(elf_errno()));
> @@ -908,6 +950,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         err = 0;
>
>  out:
> +       if (pht)
> +               free(pht);
>         if (str_table)
>                 free(str_table);
>         if (fd != -1)
> --
> 2.30.0.365.g02bc693789-goog
>
