Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310E529CD65
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgJ1BiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:18 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34109 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832995AbgJ0XUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 19:20:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id o70so2707628ybc.1;
        Tue, 27 Oct 2020 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4SAdGOpiLm65FSUnkwtEuHmAnkcY3IBxAs940sqDlE=;
        b=lFVR0zjuXI9GV+bp8fGB78GnizBP5jkr7yutKHwB3Qv+iZ1m2MbGxOdXcJDwUlTXvo
         J4mTkrze2vYUnC1/8LJ3OZnTXqUd4d3Rg6l4/2b637/nj2CPik2uyGJOF6AVPJx9lDlQ
         vicqgHdPH+EdhvuKsIMntGcZFEc56BB7Q2tM82d6dd6YxRqJF6COWFGqK5D3DkNxMDoJ
         I/hzd/EWCfUPbYYrGgl7q2zQ92KrwU9iTebr3S+MjbRuAwgZNnzhdTN8aRJnFWCRa5j8
         Q08HHOL3I1Bzh9z+q+MRgVeH9ispR9vvY+UgZcgLdNnejPKwPe284IxwDdzEaX15m+a5
         pPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4SAdGOpiLm65FSUnkwtEuHmAnkcY3IBxAs940sqDlE=;
        b=kqHbpsLX1ZrHcnYk0EnQRsdAMRXnKPOKwXvuW75X1NFHWLyaPoCJXHEdTcBRaZSRiw
         ql7nGcgdHFtV3JaXrG0EBmDpvLV6PFlsv1+VvL8DfYlOhxxvD9BywIhfD0kvvvvMlR6K
         /Oj2Xao9RofzVb6EMTgPDImwR7gSAlkBaGwQikcksjb8bl4+6nTbiDiih1Vw5eBtGmMk
         ftAM7rLqXPVjorA/f0l1U7E5RSZ12eZv/tQZXS6urAho3cD3NSM/ubQPPscjWWDh3G2e
         UUMDPK6PdSKHa/oCZQB6VIK9wAgc4aHlJhKK+M9e3AYQH099r2qm1KUk27NKlwy7zGqH
         Xp8w==
X-Gm-Message-State: AOAM530dc77X6k6l9gbUmqC367IMM5b77Hr7Dhe10iVzVHYvzF+iLPIe
        2qajMtuA6D8rtlihzlhTuhCgykCW1sQVv27LBZs=
X-Google-Smtp-Source: ABdhPJwfmhODCMSJtXjcs0e2v8f3Q4//GuPxCZ1DI8ofGUMdVAGVRqQii4RT+0Y4tkztjSbwUuPacmN1+AnZeira8NM=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr6546039ybf.425.1603840821264;
 Tue, 27 Oct 2020 16:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201026223617.2868431-1-jolsa@kernel.org> <20201026223617.2868431-3-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Oct 2020 16:20:10 -0700
Message-ID: <CAEf4BzZZ6abHMB4Y2wHF+0vGVqJ_UtMnjDfSscVXbHUZcfEGtg@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf_encoder: Change functions check due to broken dwarf
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

On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> They might be slightly superfluous together, but it's
> better to be ready for another DWARF mishap.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  elf_symtab.h  |   8 ++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2dd26c904039..99b9abe36993 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -26,6 +26,62 @@
>   */
>  #define KSYM_NAME_LEN 128
>
> +struct elf_function {
> +       const char *name;
> +       bool generated;
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
> +}
> +
> +static int config_function(struct btf_elf *btfe, GElf_Sym *sym)
> +{
> +       if (!elf_sym__is_function(sym))
> +               return 0;
> +       if (!elf_sym__value(sym))
> +               return 0;
> +
> +       if (functions_cnt == functions_alloc) {
> +               functions_alloc += 5000;

maybe just do a conventional exponential size increase? Not
necessarily * 2, could be (* 3 / 2) or (* 4 / 3), libbpf uses such
approach.

> +               functions = realloc(functions, functions_alloc * sizeof(*functions));
> +               if (!functions)
> +                       return -1;
> +       }
> +
> +       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +       functions_cnt++;
> +       return 0;
> +}
> +

[...]

> diff --git a/elf_symtab.h b/elf_symtab.h
> index 359add69c8ab..094ec4683d01 100644
> --- a/elf_symtab.h
> +++ b/elf_symtab.h
> @@ -63,6 +63,14 @@ static inline uint64_t elf_sym__value(const GElf_Sym *sym)
>         return sym->st_value;
>  }
>
> +static inline int elf_sym__is_function(const GElf_Sym *sym)
> +{
> +       return (elf_sym__type(sym) == STT_FUNC ||
> +               elf_sym__type(sym) == STT_GNU_IFUNC) &&

Why do we need to collect STT_GNU_IFUNC? That is some PLT special
magic, does the kernel use that? Even if it does, are we even able to
attach to that? Could that remove some of the assembly functions?

> +               sym->st_name != 0 &&
> +               sym->st_shndx != SHN_UNDEF;
> +}
> +
>  static inline bool elf_sym__is_local_function(const GElf_Sym *sym)
>  {
>         return elf_sym__type(sym) == STT_FUNC &&
> --
> 2.26.2
>
