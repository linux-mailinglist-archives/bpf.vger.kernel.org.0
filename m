Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5A2C5F23
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 05:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgK0EFX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 23:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbgK0EFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 23:05:23 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF29C0613D1;
        Thu, 26 Nov 2020 20:05:22 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id k65so3366124ybk.5;
        Thu, 26 Nov 2020 20:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk88nMCwtV2wKVRfqKB4l2mUalEozUtlPPFEGyZhWJ8=;
        b=hWfCEjlQOI5GEvk/BvDBJjvfo1pGG1Pm/+0L/vHHUhy/rsVNF1AvPaTvxBLmt+UN8c
         /ZHrl7MIzG1YJRi5UTVorBmKC+MruA/K4EyTM9DSCWLVWt/1FxyUSKTFbDHCC25VVvVK
         nYw8yPR5LsRa6sdLdDKSrf7MKD/LrNeU5d5kSEN/fK0y2ghzfa7mBJHwUh0BKjvFk265
         Q6Ev++M4pPVAAsosoY6z/ES8FpWePXOcrk2IzEikORiMEb15+g26mgGOxHCF/UTPiH81
         F0GCXnjVeUvRJnHwOjQjovk7MCbH0So1iIk8QYR5ufn1nvgsBUWmnNO5JYVCehYG8IpV
         GTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk88nMCwtV2wKVRfqKB4l2mUalEozUtlPPFEGyZhWJ8=;
        b=gq6zEey0LPzPlPhkfjwB3ej0vNUa9xDm6H2zHm+M6oRa191WBpxbSeXccFFb3ik5u5
         iXrDdZkN/ruxnO99jPROh5VpiCTKcq1doDQ+xLVGft6OZB6x/n6hWHGmIyQwnYL//Vpd
         7FBPYwxxmtPaI0vtrPCv3NY3rk51VkFtIKz/BHA66lETIdFZfPqUqFZs1PfA+p6308fs
         hNkJRZIO9QxXJ+vTAG8djnafAr3OSMqfgAhKaocmw6uQpjIsCoCiN66hr9LzTe/4N5BC
         bgt5nc883690yr2CcxEoMkexVyOmgNtQr9wFE4DoF3ctvzvX3CsjkZkLHEfmnO16sVAz
         JhEg==
X-Gm-Message-State: AOAM533ACCwoWVJldGUQ013F3bF344Fqm17xXe+Tbs2xMQrXQH6xN9Mv
        sGrTvwKg1aCI+XrOLQoWwk3u8t+GUhCeVsQ3sMQ=
X-Google-Smtp-Source: ABdhPJxBFKrbuYhxkwpJkVZkXrjZyfi6IJkwzfb0pdI+VGOqinblW/vWEUkRU4HWHjHacL0GwQ8ZshVl91qgFviYuLA=
X-Received: by 2002:a25:7717:: with SMTP id s23mr9371626ybc.459.1606449922061;
 Thu, 26 Nov 2020 20:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20201124161919.2152187-1-jolsa@kernel.org> <20201124161919.2152187-2-jolsa@kernel.org>
In-Reply-To: <20201124161919.2152187-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Nov 2020 20:05:11 -0800
Message-ID: <CAEf4BzbjTYevuOU7L0LoT0wL2Jb4fnb5LRXEwo_V52npGgvd8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] btf_encoder: Factor filter_functions function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 8:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Reorder the filter_functions function so we can add
> processing of kernel modules in following patch.
>
> There's no functional change intended.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 57 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c40f059580da..467c4657b2c0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -101,14 +101,17 @@ static int addrs_cmp(const void *_a, const void *_b)
>         return *a < *b ? -1 : 1;
>  }
>
> -static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> +static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
> +                            unsigned long **paddrs, unsigned long *pcount)
>  {
> -       unsigned long *addrs, count, offset, i;
> -       int functions_valid = 0;
> +       unsigned long *addrs, count, offset;
>         Elf_Data *data;
>         GElf_Shdr shdr;
>         Elf_Scn *sec;
>
> +       if (!fl->mcount_start || !fl->mcount_stop)
> +               return 0;
> +

probably better to explicitly assign paddrs and pcount to NULL and 0 here

>         /*
>          * Find mcount addressed marked by __start_mcount_loc
>          * and __stop_mcount_loc symbols and load them into
> @@ -138,7 +141,32 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>         }
>
>         memcpy(addrs, data->d_buf + offset, count * sizeof(addrs[0]));
> +       *paddrs = addrs;
> +       *pcount = count;
> +       return 0;
> +}
> +
> +static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> +{
> +       unsigned long *addrs = NULL, count, i;
> +       int functions_valid = 0;
> +
> +       /*
> +        * Check if we are processing vmlinux image and
> +        * get mcount data if it's detected.
> +        */
> +       if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
> +               return -1;
> +
> +       if (!addrs) {
> +               if (btf_elf__verbose)
> +                       printf("ftrace symbols not detected, falling back to DWARF data\n");
> +               delete_functions();
> +               return 0;
> +       }
> +
>         qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
> +       qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
>
>         /*
>          * Let's got through all collected functions and filter
> @@ -162,6 +190,9 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>
>         functions_cnt = functions_valid;
>         free(addrs);
> +
> +       if (btf_elf__verbose)
> +               printf("Found %d functions!\n", functions_cnt);
>         return 0;
>  }
>
> @@ -470,11 +501,6 @@ static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl)
>                 fl->mcount_stop = sym->st_value;
>  }
>
> -static int has_all_symbols(struct funcs_layout *fl)
> -{
> -       return fl->mcount_start && fl->mcount_stop;
> -}
> -
>  static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>  {
>         struct funcs_layout fl = { };
> @@ -501,18 +527,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>                         printf("Found %d per-CPU variables!\n", percpu_var_cnt);
>         }
>
> -       if (functions_cnt && has_all_symbols(&fl)) {
> -               qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> -               if (filter_functions(btfe, &fl)) {
> -                       fprintf(stderr, "Failed to filter dwarf functions\n");
> -                       return -1;
> -               }
> -               if (btf_elf__verbose)
> -                       printf("Found %d functions!\n", functions_cnt);
> -       } else {
> -               if (btf_elf__verbose)
> -                       printf("ftrace symbols not detected, falling back to DWARF data\n");
> -               delete_functions();
> +       if (functions_cnt && setup_functions(btfe, &fl)) {
> +               fprintf(stderr, "Failed to filter dwarf functions\n");

DWARF

> +               return -1;
>         }
>
>         return 0;
> --
> 2.26.2
>
