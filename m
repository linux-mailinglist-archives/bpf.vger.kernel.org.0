Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123F22CE29C
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLCXYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 18:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgLCXYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 18:24:49 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B4C061A4F;
        Thu,  3 Dec 2020 15:24:08 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id x2so3642973ybt.11;
        Thu, 03 Dec 2020 15:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsBmZpIENTuWuswaSqsFmapwFs22ICBjpmXhSZZV/oI=;
        b=oYpehUDNNeADoUFzhTyWtIYkRlopbOnSyirM9b7R007ovo/B165Un8kOovcagOpXTA
         x/KE/a/euaFA1sz5UMBF6xVMP9N6Zs+E6BDKIOiKOlS1EZPvI3hnJj185TmBBWKpWCpi
         0uQyw1C7Zvd+Rv0aMUH+O4mWHoO6EsN/v7Vgr/Ceteae3UGgXlYw8mHB/lGzDaM29fuJ
         FEqX7QJBf0hf/Coyepg4Q4zjAKXwppKhD6I1DSnaISX8r25pjach6Tb3aqhJ+w2/3wSD
         iT6d2aQJPWUuYXxRXl9LhUVy94ulPwy/wddZd3r53SqNCjnIosV2ihtwgzJYnHmWORS8
         L/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsBmZpIENTuWuswaSqsFmapwFs22ICBjpmXhSZZV/oI=;
        b=dW4JQqJNAQA28Gk3Anqm/slhek7M+xZB2mYjJ7dEnZuhG/TUyxhfsP8SSm/OkLKI6u
         dOdM+fT2oJB7x/mLWE+h+mqYFW0YVfViuyVex4hoPAP1mf2MHRunFVkS+TIr+QCPIQ1R
         gT0KqhjM1Kboy0osF16gUgM24DbTELTmPFJ02NtvVEODozn6zAYaDcsJVljFWLbGpZWO
         HkA4BnsnIIw6H6uY5QTXuIPtEDH6UlVP2rJXRTpS+3rtYzmOn7x9nSnbV+FSsg7dDkSE
         gP1ztoRl/PIhQGuNspCdEc3mfutoKCv+6jVCQIBtvQNYHN7CoBNVHzyV6xzafXynFSaY
         BWCw==
X-Gm-Message-State: AOAM5324/Kub91QTjeKrZgBsvh5JAcYy1FULhuPe4bRFU1s57qhIb9ry
        gwnB460dvV+1q3+3N9ctfWNljoQ+tjUc2TyocM8=
X-Google-Smtp-Source: ABdhPJyET1dFhQ8FIGV7UEquSDeMgRszl8kDh4ryJ0NuVDpQB3tXw8/gD1NTDBl3bSbpzDFkzWlUkGuZvJgh+mV0r0k=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr2083256ybe.403.1607037848089;
 Thu, 03 Dec 2020 15:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20201203220625.3704363-1-jolsa@kernel.org> <20201203220625.3704363-4-jolsa@kernel.org>
In-Reply-To: <20201203220625.3704363-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 15:23:57 -0800
Message-ID: <CAEf4BzYGPxxwaiUnNf4auq=gXzTkBuc=Sz3EJtnbDgaC-BEQ0A@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Detect kernel module ftrace addresses
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

On Thu, Dec 3, 2020 at 2:08 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add support to detect kernel module ftrace addresses and use
> it as filter for detected functions.
>
> For kernel modules the ftrace addresses are stored in __mcount_loc
> section. Adding the code that detects this section and reads
> its data into array, which is then processed as filter by
> current code.
>
> There's one tricky point with kernel modules wrt Elf object,
> which we get from dwfl_module_getelf function. This function
> performs all possible relocations, including __mcount_loc
> section.
>
> So addrs array contains relocated values, which we need take
> into account when we compare them to functions values which
> are relative to their sections.
>
> With this change for example for xfs.ko module in my kernel
> config, I'm getting slightly bigger number of functions:
>
>   before: 2373, after: 2601
>
> The ftrace's available_filter_functions still shows 2701, but
> it includes functions like:
>
>   suffix_kstrtoint.constprop.0
>   xchk_btree_check_minrecs.isra.0
>   xfs_ascii_ci_compname.part.0
>
> which are not part of dwarf data, the rest matches BTF functions.
>
> Because of the malfunction DWARF's declaration tag, the 'before'
> functions contain also functions that are not part of the module.
> The 'after' functions contain only functions that are traceable
> and part of xfs.ko.
>
> Despite filtering out some declarations, this change also adds
> static functions, hence the total number of functions is bigger.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

I've tested locally on bpf_testmod that I'm adding to selftests in
[0]. All worked well. I changed the test function from global to
non-inlined static, and BTF had it. And the tests passed. So LGTM.

Tested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>

  [0] https://patchwork.kernel.org/user/todo/netdevbpf/?series=395715&delegate=121173&state=*

>  btf_encoder.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  dutil.c       |  10 +++++
>  dutil.h       |   2 +
>  3 files changed, 109 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 398be0fbf7c7..570fce46b6d9 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -36,6 +36,7 @@ struct funcs_layout {
>  struct elf_function {
>         const char      *name;
>         unsigned long    addr;
> +       unsigned long    sh_addr;
>         bool             generated;
>  };
>
> @@ -65,11 +66,12 @@ static void delete_functions(void)
>  static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>  {
>         struct elf_function *new;
> +       static GElf_Shdr sh;
> +       static int last_idx;
> +       int idx;
>
>         if (elf_sym__type(sym) != STT_FUNC)
>                 return 0;
> -       if (!elf_sym__value(sym))
> -               return 0;
>
>         if (functions_cnt == functions_alloc) {
>                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -84,8 +86,17 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>                 functions = new;
>         }
>
> +       idx = elf_sym__section(sym);
> +
> +       if (idx != last_idx) {
> +               if (!elf_section_by_idx(btfe->elf, &sh, idx))
> +                       return 0;
> +               last_idx = idx;
> +       }
> +
>         functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
>         functions[functions_cnt].addr = elf_sym__value(sym);
> +       functions[functions_cnt].sh_addr = sh.sh_addr;
>         functions[functions_cnt].generated = false;
>         functions_cnt++;
>         return 0;
> @@ -160,10 +171,74 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
>         return 0;
>  }
>
> +static int
> +get_kmod_addrs(struct btf_elf *btfe, __u64 **paddrs, __u64 *pcount)
> +{
> +       __u64 *addrs, count;
> +       unsigned int addr_size, i;
> +       GElf_Shdr shdr_mcount;
> +       Elf_Data *data;
> +       Elf_Scn *sec;
> +
> +       /* Initialize for the sake of all error paths below. */
> +       *paddrs = NULL;
> +       *pcount = 0;
> +
> +       /* get __mcount_loc */
> +       sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
> +                                 "__mcount_loc", NULL);
> +       if (!sec) {
> +               if (btf_elf__verbose) {
> +                       printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
> +                              btfe->filename);
> +               }
> +               return 0;
> +       }
> +
> +       data = elf_getdata(sec, NULL);
> +       if (!data) {
> +               fprintf(stderr, "Failed to data for __mcount_loc section.\n");
> +               return -1;
> +       }
> +
> +       /* Get address size from processed file's ELF class. */
> +       addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
> +
> +       count = data->d_size / addr_size;
> +
> +       addrs = malloc(count * sizeof(addrs[0]));
> +       if (!addrs) {
> +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> +               return -1;
> +       }
> +
> +       if (addr_size == sizeof(__u64)) {
> +               memcpy(addrs, data->d_buf, count * addr_size);
> +       } else {
> +               for (i = 0; i < count; i++)
> +                       addrs[i] = (__u64) *((__u32 *) (data->d_buf + i * addr_size));
> +       }
> +
> +       /*
> +        * We get Elf object from dwfl_module_getelf function,
> +        * which performs all possible relocations, including
> +        * __mcount_loc section.
> +        *
> +        * So addrs array now contains relocated values, which
> +        * we need take into account when we compare them to
> +        * functions values, see comment in setup_functions
> +        * function.
> +        */
> +       *paddrs = addrs;
> +       *pcount = count;
> +       return 0;
> +}
> +
>  static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>  {
>         __u64 *addrs, count, i;
>         int functions_valid = 0;
> +       bool kmod = false;
>
>         /*
>          * Check if we are processing vmlinux image and
> @@ -172,6 +247,16 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>         if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
>                 return -1;
>
> +       /*
> +        * Check if we are processing kernel module and
> +        * get mcount data if it's detected.
> +        */
> +       if (!addrs) {
> +               if (get_kmod_addrs(btfe, &addrs, &count))
> +                       return -1;
> +               kmod = true;
> +       }
> +
>         if (!addrs) {
>                 if (btf_elf__verbose)
>                         printf("ftrace symbols not detected, falling back to DWARF data\n");
> @@ -188,9 +273,18 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>          */
>         for (i = 0; i < functions_cnt; i++) {
>                 struct elf_function *func = &functions[i];
> +               /*
> +                * For vmlinux image both addrs[x] and functions[x]::addr
> +                * values are final address and are comparable.
> +                *
> +                * For kernel module addrs[x] is final address, but
> +                * functions[x]::addr is relative address within section
> +                * and needs to be relocated by adding sh_addr.
> +                */
> +               __u64 addr = kmod ? func->addr + func->sh_addr : func->addr;
>
>                 /* Make sure function is within ftrace addresses. */
> -               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> +               if (bsearch(&addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
>                         /*
>                          * We iterate over sorted array, so we can easily skip
>                          * not valid item and move following valid field into
> diff --git a/dutil.c b/dutil.c
> index f7b853f0660d..7b667647420f 100644
> --- a/dutil.c
> +++ b/dutil.c
> @@ -196,6 +196,16 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>         return sec;
>  }
>
> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
> +{
> +       Elf_Scn *sec;
> +
> +       sec = elf_getscn(elf, idx);
> +       if (sec)
> +               gelf_getshdr(sec, shp);
> +       return sec;
> +}
> +
>  char *strlwr(char *s)
>  {
>         int len = strlen(s), i;
> diff --git a/dutil.h b/dutil.h
> index 676770d5d5c9..0838dff2d679 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -324,6 +324,8 @@ void *zalloc(const size_t size);
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>                              GElf_Shdr *shp, const char *name, size_t *index);
>
> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
> +
>  #ifndef SHT_GNU_ATTRIBUTES
>  /* Just a way to check if we're using an old elfutils version */
>  static inline int elf_getshdrstrndx(Elf *elf, size_t *dst)
> --
> 2.26.2
>
