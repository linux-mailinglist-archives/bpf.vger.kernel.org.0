Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0D2DA516
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 01:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgLOAvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 19:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgLOAvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 19:51:22 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DCDC061793
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 16:50:42 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so25249724ejb.1
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCqc3+z65fYEZgAOquQ1zB3ZS3hxPLmVKO6YFQJziRA=;
        b=DA2T+eONjHW/3pSzFTMk0TWeZ7O7V5AhUut8GnbN8fRUD2HTMCuYyjILFThzq8iQ76
         HJRVz/DpVR+FHIyvNyihkuQFa006sjFXnkaEnoImAI+8vpRb3Y3bhVENNL2a3ETU2EK/
         M2fNSniV6hXgeQJeWWXItAtk96+3zXiUyKu7iKHC8ZZkbXU/uhuVTfZxbOWAE0eqZbSR
         qVJWldWGEDkJK/OhMt11mi/VoAt3rOEQfSQdQXs3aUakeA0JtLA6xnwNPLu3Of6+PpPJ
         HoZk97CuvraI+OJ36af0dPg7OqKPvDRp6vNcQu6QNN68G2ExyOfWZCf165gJfdYwJN/n
         VZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCqc3+z65fYEZgAOquQ1zB3ZS3hxPLmVKO6YFQJziRA=;
        b=s49OKR3oFKOYuFjoIRXQUksCD6MIE0TLjGcIUZ+QrluML+89+6NAsVxdLloQhzAR6N
         E4zN0BXV4EFBY1nYbIxia7r3YmG1JmRjDb3PaFQo3hf6kZXojoUJ1PncBIEcT/4wHZZv
         uAZdUd9+USoBDE2PdRU46OetPFZn7WPryjxLYNpF5QoaVlxNGe4ikuD3mNR8TSYzn2ki
         Kly4cCypVBCk+8kR+xLsR4qBjpOnGDKKqXAYxUuA5pcMdXXJ2JD+TxE1TR8KK8d3nhqX
         PZRJ0d7dhFxucC3qyOgYDZ1EZZXoHgPQr0G5ze+T1YtF3EnyhbSQwZTrK/WuBjMor7ID
         YPIQ==
X-Gm-Message-State: AOAM530iGizAuZ7rTp2vVgdXGdO0qASwbhhxCPEs7E7VSf4uC0SyfFik
        eEGXPPtEG3HkDOS+6MelRgtFYz2Y32Oe6GmIcsrzEQ==
X-Google-Smtp-Source: ABdhPJwuCbO9nERiglLYs2Pnc4Pn8Veq9VYIyEn5Ur9mTdswzjImapyV85sCGBC7mmAMhnaE7u9BL00S8Djg4XqUXkM=
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr24588986ejx.113.1607993440727;
 Mon, 14 Dec 2020 16:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20201211041139.589692-1-andrii@kernel.org> <20201211041139.589692-3-andrii@kernel.org>
In-Reply-To: <20201211041139.589692-3-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 14 Dec 2020 16:50:29 -0800
Message-ID: <CA+khW7h2HpmruTCGXTbm59=oRB4qe9uqzH3RbFQkO3coSH0DjQ@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] btf_encoder: fix skipping per-CPU variables
 at offset 0
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii, sorry for the late reply. This change looks good. It makes
much more sense than before.

Thanks,
Hao

On Thu, Dec 10, 2020 at 8:11 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Adjust pahole logic of skipping any per-CPU symbol with offset 0, which is
> especially bad for kernel modules, because it most certainly skips the very
> first per-CPU variable.
>
> Instead, do collect per-CPU ELF symbol with 0 offset, but do extra check for
> non-kernel module case by verifying that ELF symbol name and DWARF variable
> name match. Due to the bug of DWARF name of variable sometimes being NULL,
> this is necessarily too pessimistic check (e.g., on my vmlinux image,
> fixed_percpu_data variable is still not emitted due to missing DWARF variable
> name), it allows to emit data for all module per-CPU variables.
>
> Fixes: f3d9054ba8ff ("btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  btf_encoder.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index a7d484765ce2..1d7817078f89 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -412,21 +412,6 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
>                 return 0;
>
>         addr = elf_sym__value(sym);
> -       /*
> -        * Store only those symbols that have allocated space in the percpu section.
> -        * This excludes the following three types of symbols:
> -        *
> -        *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -        *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -        *  3. __exitcall(fn), functions which are labeled as exit calls.
> -        *
> -        * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> -        * also not included, which currently includes:
> -        *
> -        *  1. fixed_percpu_data
> -        */
> -       if (!addr)
> -               return 0;
>
>         size = elf_sym__size(sym);
>         if (!size)
> @@ -652,7 +637,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>
>         cu__for_each_variable(cu, core_id, pos) {
>                 uint32_t size, type, linkage;
> -               const char *name;
> +               const char *name, *dwarf_name;
>                 uint64_t addr;
>                 int id;
>
> @@ -680,6 +665,29 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 if (!percpu_var_exists(addr, &size, &name))
>                         continue; /* not a per-CPU variable */
>
> +               /* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
> +                * have addr == 0, which is the same as, say, valid
> +                * fixed_percpu_data per-CPU variable. To distinguish between
> +                * them, additionally compare DWARF and ELF symbol names. If
> +                * DWARF doesn't provide proper name, pessimistically assume
> +                * bad variable.
> +                *
> +                * Examples of such special variables are:
> +                *
> +                *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> +                *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> +                *  3. __exitcall(fn), functions which are labeled as exit calls.
> +                *
> +                *  This is relevant only for vmlinux image, as for kernel
> +                *  modules per-CPU data section has non-zero offset so all
> +                *  per-CPU symbols have non-zero values.
> +                */
> +               if (var->ip.addr == 0) {
> +                       dwarf_name = variable__name(var, cu);
> +                       if (!dwarf_name || strcmp(dwarf_name, name))
> +                               continue;
> +               }
> +
>                 if (var->spec)
>                         var = var->spec;
>
> --
> 2.24.1
>
