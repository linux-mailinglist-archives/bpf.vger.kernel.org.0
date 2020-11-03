Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51A2A4F74
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCS4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCS4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 13:56:10 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09AC0613D1;
        Tue,  3 Nov 2020 10:56:10 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id c18so2919438ybj.10;
        Tue, 03 Nov 2020 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJY7WGKB7t34pOHGgzWmhtYgvBjvp3KhjCHKCPGb0xA=;
        b=pKNrNsIgQLNwjPkOfhHctTdoROV6VPQSQKuKUqDdMYCyVeiVSS8fNvpD5r1lQSPze/
         JUA5WKYZbpO23qTIafJ7y/Rra12H5/JcwFQhPpk0uyJ10D+fcmMGJKXmhA/VLXiyVI0M
         wcNQtCry21Xek4wPWuY98WsFOGYglFAb7gMoewNbuzfOownQyZPDpujLCeFTdctoz9ZQ
         5B2fyySp27l6fsAmhE5+wyJ0jadBFEMZzXqK3soJFPtIy5lfF/47PuW0TlrOVbuFe+Xb
         ps43HJnb2j88P6fgDCU6F2vElH90iwg6MxAKd1qZltCEdJTdTNtjgkmUZZspRwkKwl+b
         AXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJY7WGKB7t34pOHGgzWmhtYgvBjvp3KhjCHKCPGb0xA=;
        b=SFf0GOD4nywANZfyuGGcgO6l0jsD2tllbxwJtuPjPOGYmMPYzV8LFXbkjseUtD293b
         9NFQvP4d52Mc0LHOTavgiZT75SCa6Mpt4/xFgtJF0heKlSvPYAvHJzCh2K9xv2knArYK
         hbLMIzDm6VvjG4epvNgD7yKm7s5XFGjI0IcU5K9dWaStJJo1h8FOynAnKeGOpE1cdq6Z
         PMedMgPgxhXE3a82eRKON74FuWSd6+HruV4IRrRSiYHc4TkMXtygI84lOm6NvkdkGCsq
         qFSKRThsh0ycKp/01RrAOnZF+cTps0CQjLQSDHpYLXWAjjrPSbcImqZUWw6UqqqksU17
         fMHw==
X-Gm-Message-State: AOAM530flElSYPV/Qwn4Ot19tGSVoUJyng2khM9NHhGhw6/ffB4y0+Cy
        Fak0I8yc8vI5lcltmBWZEb3YSpDdJ8PtYbBqLJg=
X-Google-Smtp-Source: ABdhPJxEQHFV82ObgeYiQ+S1ZtWJyM3hHPFGHeXNGtKBavynYcsIeWzJYfiLoCjFoqYT06Wi6CnCWO/1qMq8P5R/jcI=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr31109160ybe.403.1604429769824;
 Tue, 03 Nov 2020 10:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20201031223131.3398153-1-jolsa@kernel.org> <20201031223131.3398153-3-jolsa@kernel.org>
In-Reply-To: <20201031223131.3398153-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Nov 2020 10:55:58 -0800
Message-ID: <CAEf4BzYeaiQJ+-NCtCK4wB-2ia3U40RtTWez6c7osCuzpy11Zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 31, 2020 at 3:32 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to generate just single BTF instance for the
> function, while DWARF data contains multiple instances
> of DW_TAG_subprogram tag.
>
> Unfortunately we can no longer rely on DW_AT_declaration
> tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
>
> Instead we apply following checks:
>   - argument names are defined for the function
>   - there's symbol and address defined for the function
>   - function is generated only once
>
> Also because we want to follow kernel's ftrace traceable
> functions, this patchset is adding extra check that the
> function is one of the ftrace's functions.
>
> All ftrace functions addresses are stored in vmlinux
> binary within symbols:
>   __start_mcount_loc
>   __stop_mcount_loc
>
> During object preparation code we read those addresses,
> sort them and use them as filter for all detected dwarf
> functions.
>
> We also filter out functions within .init section, ftrace
> is doing that in runtime.
>
> I can still see several differences to ftrace functions in
> /sys/kernel/debug/tracing/available_filter_functions file:
>
>   - available_filter_functions includes modules (7086 functions)
>   - available_filter_functions includes functions like:
>       __acpi_match_device.part.0.constprop.0
>       acpi_ns_check_sorted_list.constprop.0
>       acpi_os_unmap_generic_address.part.0
>       acpiphp_check_bridge.part.0
>
>     which are not part of dwarf data (1164 functions)
>   - BTF includes multiple functions like:
>       __clk_register_clkdev
>       clk_register_clkdev
>
>     which share same code so they appear just as single function
>     in available_filter_functions, but dwarf keeps track of both
>     of them (16 functions)
>
> With this change I'm getting 38334 BTF functions, which
> when added above functions to consideration gives same
> amount of functions in available_filter_functions.
>
> The patch still keeps the original function filter condition
> (that uses current fn->declaration check) in case the object
> does not contain *_mcount_loc symbol -> object is not vmlinux.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 220 insertions(+), 2 deletions(-)

[...]

> +static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> +{
> +       if (elf_sym__type(sym) != STT_FUNC)
> +               return 0;
> +       if (!elf_sym__value(sym))
> +               return 0;
> +
> +       if (functions_cnt == functions_alloc) {
> +               functions_alloc = max(1000, functions_alloc * 3 / 2);
> +               functions = realloc(functions, functions_alloc * sizeof(*functions));
> +               if (!functions)
> +                       return -1;

memory leak right here. You need to use a temporary variable and check
if for NULL, before overwriting functions.

> +       }
> +
> +       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +       functions[functions_cnt].addr = elf_sym__value(sym);
> +       functions[functions_cnt].generated = false;
> +       functions[functions_cnt].valid = false;
> +       functions_cnt++;
> +       return 0;
> +}
> +
> +static int addrs_cmp(const void *_a, const void *_b)
> +{
> +       const unsigned long *a = _a;
> +       const unsigned long *b = _b;
> +
> +       return *a - *b;

this is cute, but is it always correct? instead of thinking how this
works with overflows, maybe let's keep it simple with

if (*a == *b)
  return 0;
return *a < *b ? -1 : 1;

?

> +}
> +
> +static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
> +{
> +       bool init_filter = ms->init_begin && ms->init_end;
> +       unsigned long *addrs, count, offset, i;
> +       Elf_Data *data;
> +       GElf_Shdr shdr;
> +       Elf_Scn *sec;
> +
> +       /*
> +        * Find mcount addressed marked by __start_mcount_loc
> +        * and __stop_mcount_loc symbols and load them into
> +        * sorted array.
> +        */
> +       sec = elf_getscn(btfe->elf, ms->start_section);
> +       if (!sec || !gelf_getshdr(sec, &shdr)) {
> +               fprintf(stderr, "Failed to get section(%lu) header.\n",
> +                       ms->start_section);
> +               return -1;
> +       }
> +
> +       offset = ms->start - shdr.sh_addr;
> +       count  = (ms->stop - ms->start) / 8;
> +
> +       data = elf_getdata(sec, 0);
> +       if (!data) {
> +               fprintf(stderr, "Failed to section(%lu) data.\n",

typo: failed to get?

> +                       ms->start_section);
> +               return -1;
> +       }
> +
> +       addrs = malloc(count * sizeof(addrs[0]));
> +       if (!addrs) {
> +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> +               return -1;
> +       }
> +

[...]

>
> +#define SET_SYMBOL(__sym, __var)                                               \
> +       if (!ms->__var && !strcmp(__sym, elf_sym__name(sym, btfe->symtab)))     \
> +               ms->__var = sym->st_value;                                      \
> +
> +static void collect_mcount_symbol(GElf_Sym *sym, struct mcount_symbols *ms)
> +{
> +       if (!ms->start &&
> +           !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
> +               ms->start = sym->st_value;
> +               ms->start_section = sym->st_shndx;
> +       }
> +       SET_SYMBOL("__stop_mcount_loc", stop)
> +       SET_SYMBOL("__init_begin", init_begin)
> +       SET_SYMBOL("__init_end", init_end)

please don't use macro here, it doesn't save much code but complicates
reading it quite significantly

> +}
> +
> +#undef SET_SYMBOL
> +
>  static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>  {
> +       struct mcount_symbols ms = { };
>         uint32_t core_id;
>         GElf_Sym sym;
>
> @@ -320,6 +485,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>         elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
>                 if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
>                         return -1;
> +               if (collect_function(btfe, &sym))
> +                       return -1;
> +               collect_mcount_symbol(&sym, &ms);
>         }
>
>         if (collect_percpu_vars) {
> @@ -329,9 +497,34 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>                 if (btf_elf__verbose)
>                         printf("Found %d per-CPU variables!\n", percpu_var_cnt);
>         }
> +
> +       if (functions_cnt) {
> +               qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> +               if (ms.start && ms.stop &&
> +                   filter_functions(btfe, &ms)) {

nit: single line should fit well, no?

> +                       fprintf(stderr, "Failed to filter dwarf functions\n");
> +                       return -1;
> +               }
> +               if (btf_elf__verbose)
> +                       printf("Found %d functions!\n", functions_valid);
> +       }
> +
>         return 0;
>  }
>

[...]
