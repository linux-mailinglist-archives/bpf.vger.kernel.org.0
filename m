Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1C2AF95E
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgKKT7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 14:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgKKT7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:32 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBAC0613D1;
        Wed, 11 Nov 2020 11:59:32 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 2so3009663ybc.12;
        Wed, 11 Nov 2020 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQKkHAjupPVZGMChRJmohP/fqlb046EEhM5NCQW/MPg=;
        b=MNhvzW8Y16ZZHuxekdBlMw5nEwQTnCsw/q8H5ZHRnNnPerqXk+pdRD55Xl5LbXM0ai
         3RvTdNqRnxS651vWGRW41KAQjIhJvOGB9ZPMSPJSIzDghQ14BSN79L+BCp1dTs8OfZa0
         +9tJOWD5hWAezuh97E4qb/NDlw0wshYCjHQNaV/UJOJN6T/EwfmsHQNq+oPRMEME+tPQ
         ul8Eu/6OyUMkQawcKJ9gEWzuP4k9mhXF+Fb+xLS6geavjiBhJibASG+FG7trISx/8N9J
         RJ//1Fz7pfxitMxTaFeMWHL4osmbw26QzxPrt4qIIUg2Z4NOb+LTmHfrugrCcKZZDfyM
         qdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQKkHAjupPVZGMChRJmohP/fqlb046EEhM5NCQW/MPg=;
        b=NnOeGVyxQse6Od8PmAiaP63DL5Jr20VVe6IWraciqh7XKZkuMrv8So7FpBqcYdPZzk
         IyE1n7ZtEend0qlQi1mRi/bNOKLo1rRYRpZEJBokINQFu+fY0QbfHZgW4aLchP9FTSXi
         ZLPcpjsXXCEU5MS6dJ2Y7ECBSCcj8/O/jY0VWDfsdJUANL/c/tGfdWEs5cNqp50l01/T
         9O2ZRpkIj3xBcuEz5tHQixd1zUNURHJ0iv8WCXdOTM6FP9+O80XqLSJTi9+9iGQeE+gy
         5AmoR6zsMZrhi5pTKX7O/m3have17ondP/9P+TCUv3IzTnOKXr/U51lmp5BarcQRb8RE
         BQ9g==
X-Gm-Message-State: AOAM530fzwzQ69CfciEuUefZjvH9DrYR2p7IGmUoPAq0lgRk+luyKukx
        ZG74QxTYCv75ZqDWxNPFPhHaBOkzdatxdCKRjTw=
X-Google-Smtp-Source: ABdhPJw5y0Zw+rz2gG45cKAq+iV0izE3tM3rRnUsxEvvzaVCIUniUbT1nsB/wePx9RJRHqG1SE7yvumi7y2S6QhTKrg=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr23777442ybd.27.1605124771148;
 Wed, 11 Nov 2020 11:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20201106222512.52454-1-jolsa@kernel.org> <20201106222512.52454-4-jolsa@kernel.org>
In-Reply-To: <20201106222512.52454-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 11:59:20 -0800
Message-ID: <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 6, 2020 at 2:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> is doing that in runtime. At the same time we keep functions
> from .init.bpf.preserve_type, because they are needed in BTF.
>
> I can still see several differences to ftrace functions in
> /sys/kernel/debug/tracing/available_filter_functions file:
>
>   - available_filter_functions includes modules
>   - available_filter_functions includes functions like:
>       __acpi_match_device.part.0.constprop.0
>       acpi_ns_check_sorted_list.constprop.0
>       acpi_os_unmap_generic_address.part.0
>       acpiphp_check_bridge.part.0
>
>     which are not part of dwarf data
>   - BTF includes multiple functions like:
>       __clk_register_clkdev
>       clk_register_clkdev
>
>     which share same code so they appear just as single function
>     in available_filter_functions, but dwarf keeps track of both
>     of them
>
>   - BTF includes iterator functions, which do not make it to
>     available_filter_functions
>
> With this change I'm getting 38384 BTF functions, which
> when added above functions to consideration gives same
> amount of functions in available_filter_functions.
>
> The patch still keeps the original function filter condition
> (that uses current fn->declaration check) in case the object
> does not contain *_mcount_loc symbol -> object is not vmlinux.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Jiri,

This patch breaks the bpf tree pretty badly right now by generating
bad BTF for (at least some) FUNCs. Please investigate ASAP. And please
also make sure that you run test_progs for the kernel with BTF
generated by pahole.

bpf-next is not broken only because pahole falls back to old logic if
it doesn't find __init_bpf_preserve_type_begin and
__init_bpf_preserve_type_end symbols.

>  btf_encoder.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1866bb16a8ba..9b93e9963727 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -26,6 +26,179 @@
>   */
>  #define KSYM_NAME_LEN 128
>
> +struct funcs_layout {
> +       unsigned long mcount_start;
> +       unsigned long mcount_stop;
> +       unsigned long init_begin;
> +       unsigned long init_end;
> +       unsigned long init_bpf_begin;
> +       unsigned long init_bpf_end;
> +       unsigned long mcount_sec_idx;
> +};
> +
> +struct elf_function {
> +       const char      *name;
> +       unsigned long    addr;
> +       bool             generated;
> +};
> +
> +static struct elf_function *functions;
> +static int functions_alloc;
> +static int functions_cnt;
> +
> +static int functions_cmp(const void *_a, const void *_b)
> +{
> +       const struct elf_function *a = _a;
> +       const struct elf_function *b = _b;
> +
> +       return strcmp(a->name, b->name);
> +}
> +
> +static void delete_functions(void)
> +{
> +       free(functions);
> +       functions_alloc = functions_cnt = 0;
> +       functions = NULL;
> +}
> +
> +#ifndef max
> +#define max(x, y) ((x) < (y) ? (y) : (x))
> +#endif
> +
> +static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> +{
> +       struct elf_function *new;
> +
> +       if (elf_sym__type(sym) != STT_FUNC)
> +               return 0;
> +       if (!elf_sym__value(sym))
> +               return 0;
> +
> +       if (functions_cnt == functions_alloc) {
> +               functions_alloc = max(1000, functions_alloc * 3 / 2);
> +               new = realloc(functions, functions_alloc * sizeof(*functions));
> +               if (!new) {
> +                       /*
> +                        * The cleanup - delete_functions is called
> +                        * in cu__encode_btf error path.
> +                        */
> +                       return -1;
> +               }
> +               functions = new;
> +       }
> +
> +       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +       functions[functions_cnt].addr = elf_sym__value(sym);
> +       functions[functions_cnt].generated = false;
> +       functions_cnt++;
> +       return 0;
> +}
> +
> +static int addrs_cmp(const void *_a, const void *_b)
> +{
> +       const unsigned long *a = _a;
> +       const unsigned long *b = _b;
> +
> +       if (*a == *b)
> +               return 0;
> +       return *a < *b ? -1 : 1;
> +}
> +
> +static bool is_init(struct funcs_layout *fl, unsigned long addr)
> +{
> +       return addr >= fl->init_begin && addr < fl->init_end;
> +}
> +
> +static bool is_bpf_init(struct funcs_layout *fl, unsigned long addr)
> +{
> +       return addr >= fl->init_bpf_begin && addr < fl->init_bpf_end;
> +}
> +
> +static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> +{
> +       unsigned long *addrs, count, offset, i;
> +       int functions_valid = 0;
> +       Elf_Data *data;
> +       GElf_Shdr shdr;
> +       Elf_Scn *sec;
> +
> +       /*
> +        * Find mcount addressed marked by __start_mcount_loc
> +        * and __stop_mcount_loc symbols and load them into
> +        * sorted array.
> +        */
> +       sec = elf_getscn(btfe->elf, fl->mcount_sec_idx);
> +       if (!sec || !gelf_getshdr(sec, &shdr)) {
> +               fprintf(stderr, "Failed to get section(%lu) header.\n",
> +                       fl->mcount_sec_idx);
> +               return -1;
> +       }
> +
> +       offset = fl->mcount_start - shdr.sh_addr;
> +       count  = (fl->mcount_stop - fl->mcount_start) / 8;
> +
> +       data = elf_getdata(sec, 0);
> +       if (!data) {
> +               fprintf(stderr, "Failed to get section(%lu) data.\n",
> +                       fl->mcount_sec_idx);
> +               return -1;
> +       }
> +
> +       addrs = malloc(count * sizeof(addrs[0]));
> +       if (!addrs) {
> +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> +               return -1;
> +       }
> +
> +       memcpy(addrs, data->d_buf + offset, count * sizeof(addrs[0]));
> +       qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
> +
> +       /*
> +        * Let's got through all collected functions and filter
> +        * out those that are not in ftrace and init code.
> +        */
> +       for (i = 0; i < functions_cnt; i++) {
> +               struct elf_function *func = &functions[i];
> +
> +               /*
> +                * Do not enable .init section functions,
> +                * but keep .init.bpf.preserve_type functions.
> +                */
> +               if (is_init(fl, func->addr) && !is_bpf_init(fl, func->addr))
> +                       continue;
> +
> +               /* Make sure function is within ftrace addresses. */
> +               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> +                       /*
> +                        * We iterate over sorted array, so we can easily skip
> +                        * not valid item and move following valid field into
> +                        * its place, and still keep the 'new' array sorted.
> +                        */
> +                       if (i != functions_valid)
> +                               functions[functions_valid] = functions[i];
> +                       functions_valid++;
> +               }
> +       }
> +
> +       functions_cnt = functions_valid;
> +       free(addrs);
> +       return 0;
> +}
> +
> +static bool should_generate_function(const struct btf_elf *btfe, const char *name)
> +{
> +       struct elf_function *p;
> +       struct elf_function key = { .name = name };
> +
> +       p = bsearch(&key, functions, functions_cnt,
> +                   sizeof(functions[0]), functions_cmp);
> +       if (!p || p->generated)
> +               return false;
> +
> +       p->generated = true;
> +       return true;
> +}
> +
>  static bool btf_name_char_ok(char c, bool first)
>  {
>         if (c == '_' || c == '.')
> @@ -207,6 +380,7 @@ int btf_encoder__encode()
>                 btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
>
>         err = btf_elf__encode(btfe, 0);
> +       delete_functions();
>         btf_elf__delete(btfe);
>         btfe = NULL;
>
> @@ -308,8 +482,45 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
>         return 0;
>  }
>
> +static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl)
> +{
> +       if (!fl->mcount_start &&
> +           !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
> +               fl->mcount_start = sym->st_value;
> +               fl->mcount_sec_idx = sym->st_shndx;
> +       }
> +
> +       if (!fl->mcount_stop &&
> +           !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
> +               fl->mcount_stop = sym->st_value;
> +
> +       if (!fl->init_begin &&
> +           !strcmp("__init_begin", elf_sym__name(sym, btfe->symtab)))
> +               fl->init_begin = sym->st_value;
> +
> +       if (!fl->init_end &&
> +           !strcmp("__init_end", elf_sym__name(sym, btfe->symtab)))
> +               fl->init_end = sym->st_value;
> +
> +       if (!fl->init_bpf_begin &&
> +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> +               fl->init_bpf_begin = sym->st_value;
> +
> +       if (!fl->init_bpf_end &&
> +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> +               fl->init_bpf_end = sym->st_value;
> +}
> +
> +static int has_all_symbols(struct funcs_layout *fl)
> +{
> +       return fl->mcount_start && fl->mcount_stop &&
> +              fl->init_begin && fl->init_end &&
> +              fl->init_bpf_begin && fl->init_bpf_end;

See below for what seems to be the root cause for the immediate problem.

But me, Alexei and Daniel had a discussion offline, and we concluded
that this special bpf_preserve_init section is probably not the right
approach overall. We should roll back the bpf patch and instead adjust
pahole's approach. I think we should just drop the __init check and
include all the __init functions into BTF. There could be cases where
we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
security cases), so having BTFs for those FUNCs are necessary as well.
Ftrace currently disallows that, but it's only because no user-space
application has a way to attach probes early enough. This might change
in the future, so there is no need to invent special mechanisms now
for bpf_iter function preservation. Let's just include all __init
functions in BTF. Can you please do that change and check how much
more functions we get in BTF? Thanks!

> +}
> +
>  static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>  {
> +       struct funcs_layout fl = { };
>         uint32_t core_id;
>         GElf_Sym sym;
>
> @@ -320,6 +531,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>         elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
>                 if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
>                         return -1;
> +               if (collect_function(btfe, &sym))
> +                       return -1;
> +               collect_symbol(&sym, &fl);
>         }
>
>         if (collect_percpu_vars) {
> @@ -329,9 +543,37 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>                 if (btf_elf__verbose)
>                         printf("Found %d per-CPU variables!\n", percpu_var_cnt);
>         }
> +
> +       if (functions_cnt && has_all_symbols(&fl)) {
> +               qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> +               if (filter_functions(btfe, &fl)) {
> +                       fprintf(stderr, "Failed to filter dwarf functions\n");
> +                       return -1;
> +               }
> +               if (btf_elf__verbose)
> +                       printf("Found %d functions!\n", functions_cnt);
> +       } else {
> +               if (btf_elf__verbose)
> +                       printf("vmlinux not detected, falling back to dwarf data\n");
> +               delete_functions();
> +       }
> +
>         return 0;
>  }
>
> +static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> +{
> +       struct parameter *param;
> +       const char *name;
> +
> +       ftype__for_each_parameter(ftype, param) {
> +               name = dwarves__active_loader->strings__ptr(cu, param->name);
> +               if (name == NULL)
> +                       return false;
> +       }
> +       return true;
> +}
> +

I suspect (but haven't verified) that the problem is in this function.
If it happens that DWARF for a function has no arguments, then we'll
conclude it has all arg names. Don't know what's the best solution
here, but please double-check this.

Specifically, two selftests are failing now. One of them:

libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
arg#0 type is not a struct
Unrecognized arg#0 type PTR
; int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
0: (79) r6 = *(u64 *)(r1 +0)
func 'security_inode_getattr' doesn't have 1-th argument
invalid bpf_context access off=0 size=8
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
libbpf: -- END LOG --
libbpf: failed to load program 'prog_stat'
libbpf: failed to load object 'test_d_path'
libbpf: failed to load BPF skeleton 'test_d_path': -4007
test_d_path:FAIL:setup d_path skeleton failed
#27 d_path:FAIL

This is because in generated BTF security_inode_getattr has a
prototype void security_inode_getattr(void); And once we emit this
prototype, due to logic in should_generate_function() we won't attempt
to do it again, even for the prototype with the right arguments.


>  int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                    bool skip_encoding_vars)
>  {
> @@ -357,7 +599,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 if (!btfe)
>                         return -1;
>
> -               if (collect_symbols(btfe, !skip_encoding_vars))
> +               err = collect_symbols(btfe, !skip_encoding_vars);
> +               if (err)
>                         goto out;
>
>                 has_index_type = false;
> @@ -407,8 +650,28 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 int btf_fnproto_id, btf_fn_id;
>                 const char *name;
>
> -               if (fn->declaration || !fn->external)
> -                       continue;
> +               /*
> +                * The functions_cnt != 0 means we parsed all necessary
> +                * kernel symbols and we are using ftrace location filter
> +                * for functions. If it's not available keep the current
> +                * dwarf declaration check.
> +                */
> +               if (functions_cnt) {
> +                       /*
> +                        * We check following conditions:
> +                        *   - argument names are defined
> +                        *   - there's symbol and address defined for the function
> +                        *   - function address belongs to ftrace locations
> +                        *   - function is generated only once
> +                        */
> +                       if (!has_arg_names(cu, &fn->proto))
> +                               continue;
> +                       if (!should_generate_function(btfe, function__name(fn, cu)))
> +                               continue;
> +               } else {
> +                       if (fn->declaration || !fn->external)
> +                               continue;
> +               }
>
>                 btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
>                 name = dwarves__active_loader->strings__ptr(cu, fn->name);
> @@ -492,6 +755,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>
>  out:
>         if (err) {
> +               delete_functions();
>                 btf_elf__delete(btfe);
>                 btfe = NULL;
>         }
> --
> 2.26.2
>
