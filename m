Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182832C5F32
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 05:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgK0ETL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 23:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgK0ETK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 23:19:10 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD77C0613D1;
        Thu, 26 Nov 2020 20:19:10 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 2so3365593ybc.12;
        Thu, 26 Nov 2020 20:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1v/7QB/73a02EkYhyrLOExQ1ofz9RfgOD57ZabaMhQ=;
        b=OM3g8Zu6ozAGrxMvuZ8EshBs4jcvo0AICM+sSnw95O2eRlly/a2BLZaq2N76u76ag7
         HGFr3cl5IT+fa+icqR6awt78ASsvniOe8M8XRS6Owguw3ae4dlQCUQEOO0CzNSobXl5V
         6lQG0fLiODPLdJWDSmPCdimpZHsFf9huq1E7AU6yjvqkzqUc5hpsJYVJHpKRAqDcXlhk
         FBoxmFfrpQLFZt+smvrhvpW3DHqQmGtHTkyeKp+xspwfqVbxLfeB7VBMCOHBAfxrc06V
         IArNb27lCbBJxDn17GKhs0tHwNZJVwq+1wlSGVoO6w+ULePR1nYJTg++qO94L4RDfrT2
         pQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1v/7QB/73a02EkYhyrLOExQ1ofz9RfgOD57ZabaMhQ=;
        b=XAEQgEv3Rzab3xabAv/b5HzXCvyHrcqls7K4ocLijOlSp3053KaYgcEHKzKXSJPs6J
         DmLptgJB6x4HcSDs+10zMGcq6zE7mqYlg0q1k3/SyoGlia8jZabhBS0STGDN1PcCsjDb
         zkd0FXYnDDQ3xK8TepUyJFLdpXXPyKYXZyDVRU7TXfQAHSdJWmK1KkBT7+E1z2EonBvz
         CU/CVz4QoZidKnoX8Vn7xlrtMmM4BglLq76kJ7WsSk1X+PuutgWkxUxfB5Mq5IbwoH1z
         2GyJd3kUl+jxWDff9Ut9q9rA944764bjKTlCHYFALCj4/V+F3ivmmTRiwMLv/pIPMi2E
         hodA==
X-Gm-Message-State: AOAM5300c03+GmK+1WqCzm+pEXsWGNQyATdnDf+TFwLTJydGpFlQNUJ1
        atSDjZ2nC5pMuwR8hGesiWfV356zphfSRto4eBg=
X-Google-Smtp-Source: ABdhPJy83oPGuxAf7PejMIFItqX98BZB73FvDOlzLzbK/auGtOzlgBQL0sukogFvran277UFqZ7jHnyWoo5gszWzotY=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr6990578ybe.403.1606450749777;
 Thu, 26 Nov 2020 20:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20201124161919.2152187-1-jolsa@kernel.org> <20201124161919.2152187-3-jolsa@kernel.org>
In-Reply-To: <20201124161919.2152187-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Nov 2020 20:18:58 -0800
Message-ID: <CAEf4BzbbpLkJth5HYh=a6V1+uPAcPpUTsi=JHQrOeHF5f2xALg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Detect kernel module ftrace addresses
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
> Add support to detect kernel module dtrace addresses and use
> it as filter for functions.

typo: dtrace -> ftrace?

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
> config I'm getting slightly bigger number of functions:
>
>   before: 2429, after: 2615
>
> Because of the malfunction DWARF's declaration tag, the
> 'before' functions contain also functions that are not
> part of the module. The 'after' functions contain only
> functions that are traceable and part of xfs.ko.
>
> Despite filtering out some declarations, this change
> also adds static functions, hence the total number
> of functions is bigger.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  dutil.c       | 16 ++++++++++
>  dutil.h       |  2 ++
>  3 files changed, 100 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 467c4657b2c0..e6114c10ad01 100644
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
> @@ -65,11 +66,11 @@ static void delete_functions(void)
>  static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>  {
>         struct elf_function *new;
> +       static GElf_Shdr sh;
> +       static int last_idx;
>
>         if (elf_sym__type(sym) != STT_FUNC)
>                 return 0;
> -       if (!elf_sym__value(sym))
> -               return 0;
>
>         if (functions_cnt == functions_alloc) {
>                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -84,8 +85,17 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>                 functions = new;
>         }
>
> +       if (elf_sym__section(sym) != last_idx) {
> +               int idx = elf_sym__section(sym);

nit: elf_sym__section() called twice, maybe have sec_idx local variable instead?

> +
> +               if (!elf_section_by_idx(btfe->elf, &sh, idx))
> +                       return 0;

isn't this an error and shouldn't return 0?..

> +               last_idx = idx;
> +       }
> +
>         functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
>         functions[functions_cnt].addr = elf_sym__value(sym);
> +       functions[functions_cnt].sh_addr = sh.sh_addr;
>         functions[functions_cnt].generated = false;
>         functions_cnt++;
>         return 0;
> @@ -146,10 +156,60 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
>         return 0;
>  }
>
> +static int
> +get_kmod_addrs(struct btf_elf *btfe, unsigned long **paddrs, unsigned long *pcount)
> +{
> +       unsigned long *addrs, count;
> +       GElf_Shdr shdr_mcount;
> +       Elf_Data *data;
> +       Elf_Scn *sec;
> +
> +       /* get __mcount_loc */
> +       sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
> +                                 "__mcount_loc", NULL);
> +       if (!sec) {
> +               if (btf_elf__verbose) {
> +                       printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
> +                              btfe->filename);
> +               }


nit: unnecessary {} for single-statement if

> +               return 0;
> +       }
> +
> +       data = elf_getdata(sec, NULL);
> +       if (!data) {
> +               fprintf(stderr, "Failed to data for __mcount_loc section.\n");
> +               return -1;
> +       }
> +
> +       addrs = malloc(data->d_size);
> +       if (!addrs) {
> +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> +               return -1;
> +       }
> +
> +       count = data->d_size / sizeof(unsigned long);

not sure this is safe to do, e.g., if we are processing ELF of
different bitness (32 vs 64). Maybev we can get the size of an entry
from sh_entsize?


> +       memcpy(addrs, data->d_buf, data->d_size);
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
>         unsigned long *addrs = NULL, count, i;
>         int functions_valid = 0;
> +       bool kmod = false;
>
>         /*
>          * Check if we are processing vmlinux image and
> @@ -158,6 +218,16 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
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
> @@ -174,9 +244,18 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
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
> +               unsigned long addr = kmod ? func->addr + func->sh_addr : func->addr;
>
>                 /* Make sure function is within ftrace addresses. */
> -               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> +               if (bsearch(&addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
>                         /*
>                          * We iterate over sorted array, so we can easily skip
>                          * not valid item and move following valid field into
> diff --git a/dutil.c b/dutil.c
> index f7b853f0660d..5ebbd2f9c84c 100644
> --- a/dutil.c
> +++ b/dutil.c
> @@ -196,6 +196,22 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>         return sec;
>  }
>
> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)


there is elf_getscn(), which does the same?

> +{
> +       Elf_Scn *sec = NULL;
> +       size_t cnt = 1;
> +
> +       while ((sec = elf_nextscn(elf, sec)) != NULL) {
> +               if (cnt == idx) {
> +                       gelf_getshdr(sec, shp);
> +                       return sec;
> +               }
> +               ++cnt;
> +       }
> +
> +       return NULL;
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
