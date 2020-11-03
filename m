Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477E02A4CE3
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 18:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgKCRbQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 12:31:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgKCRbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 12:31:16 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC4A206F8;
        Tue,  3 Nov 2020 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604424675;
        bh=Cm7DrskVIJo9VAZXNPzkz2ZwnUWmZg1K4hX2//kXFrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQFIIgPg+5cxYX4tgBw4pPDSY6ffArj36qiob0biWmYw5F344Luz9bdTZcXEp1KEn
         uXQw7xcCILNmbN0m/0MYux18hIdpHN5r2LeJ6+cOn5H3U6qsRwph4KdK4q2NW+RGN3
         MqMhSJLDQBnpzFECGFSQ8ywX3xF/J2F4x49b6T7g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E67E40452; Tue,  3 Nov 2020 14:31:12 -0300 (-03)
Date:   Tue, 3 Nov 2020 14:31:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/2] btf_encoder: Move find_all_percpu_vars in generic
 collect_symbols
Message-ID: <20201103173112.GI151027@kernel.org>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-2-jolsa@kernel.org>
 <CA+khW7hRm4xwKKDjdoJkaQADfjANCzy9hpp-xL_T-Two3oNAfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7hRm4xwKKDjdoJkaQADfjANCzy9hpp-xL_T-Two3oNAfA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 02, 2020 at 10:29:22AM -0800, Hao Luo escreveu:
> This looks good to me. Thanks, Jiri.
> 
> Acked-by: Hao Luo <haoluo@google.com>

Thanks, applied, will wait for a v2 for the other.
 
> On Sat, Oct 31, 2020 at 3:31 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Moving find_all_percpu_vars under generic collect_symbols
> > function that walks over symbols and calls collect_percpu_var.
> >
> > We will add another collect function that needs to go through
> > all the symbols, so it's better we go through them just once.
> >
> > There's no functional change intended.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 124 +++++++++++++++++++++++++++-----------------------
> >  1 file changed, 67 insertions(+), 57 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 4c92908beab2..1866bb16a8ba 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -250,75 +250,85 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
> >         return true;
> >  }
> >
> > -static int find_all_percpu_vars(struct btf_elf *btfe)
> > +static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
> >  {
> > -       uint32_t core_id;
> > -       GElf_Sym sym;
> > +       const char *sym_name;
> > +       uint64_t addr;
> > +       uint32_t size;
> >
> > -       /* cache variables' addresses, preparing for searching in symtab. */
> > -       percpu_var_cnt = 0;
> > +       /* compare a symbol's shndx to determine if it's a percpu variable */
> > +       if (elf_sym__section(sym) != btfe->percpu_shndx)
> > +               return 0;
> > +       if (elf_sym__type(sym) != STT_OBJECT)
> > +               return 0;
> >
> > -       /* search within symtab for percpu variables */
> > -       elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> > -               const char *sym_name;
> > -               uint64_t addr;
> > -               uint32_t size;
> > +       addr = elf_sym__value(sym);
> > +       /*
> > +        * Store only those symbols that have allocated space in the percpu section.
> > +        * This excludes the following three types of symbols:
> > +        *
> > +        *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> > +        *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> > +        *  3. __exitcall(fn), functions which are labeled as exit calls.
> > +        *
> > +        * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> > +        * also not included, which currently includes:
> > +        *
> > +        *  1. fixed_percpu_data
> > +        */
> > +       if (!addr)
> > +               return 0;
> >
> > -               /* compare a symbol's shndx to determine if it's a percpu variable */
> > -               if (elf_sym__section(&sym) != btfe->percpu_shndx)
> > -                       continue;
> > -               if (elf_sym__type(&sym) != STT_OBJECT)
> > -                       continue;
> > +       size = elf_sym__size(sym);
> > +       if (!size)
> > +               return 0; /* ignore zero-sized symbols */
> >
> > -               addr = elf_sym__value(&sym);
> > -               /*
> > -                * Store only those symbols that have allocated space in the percpu section.
> > -                * This excludes the following three types of symbols:
> > -                *
> > -                *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> > -                *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> > -                *  3. __exitcall(fn), functions which are labeled as exit calls.
> > -                *
> > -                * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> > -                * also not included, which currently includes:
> > -                *
> > -                *  1. fixed_percpu_data
> > -                */
> > -               if (!addr)
> > -                       continue;
> > +       sym_name = elf_sym__name(sym, btfe->symtab);
> > +       if (!btf_name_valid(sym_name)) {
> > +               dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> > +                                   sym_name, btf_elf__verbose, btf_elf__force);
> > +               if (btf_elf__force)
> > +                       return 0;
> > +               return -1;
> > +       }
> >
> > -               size = elf_sym__size(&sym);
> > -               if (!size)
> > -                       continue; /* ignore zero-sized symbols */
> > +       if (btf_elf__verbose)
> > +               printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> >
> > -               sym_name = elf_sym__name(&sym, btfe->symtab);
> > -               if (!btf_name_valid(sym_name)) {
> > -                       dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> > -                                           sym_name, btf_elf__verbose, btf_elf__force);
> > -                       if (btf_elf__force)
> > -                               continue;
> > -                       return -1;
> > -               }
> > +       if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
> > +               fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> > +                       MAX_PERCPU_VAR_CNT);
> > +               return -1;
> > +       }
> > +       percpu_vars[percpu_var_cnt].addr = addr;
> > +       percpu_vars[percpu_var_cnt].sz = size;
> > +       percpu_vars[percpu_var_cnt].name = sym_name;
> > +       percpu_var_cnt++;
> >
> > -               if (btf_elf__verbose)
> > -                       printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> > +       return 0;
> > +}
> > +
> > +static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
> > +{
> > +       uint32_t core_id;
> > +       GElf_Sym sym;
> >
> > -               if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
> > -                       fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> > -                               MAX_PERCPU_VAR_CNT);
> > +       /* cache variables' addresses, preparing for searching in symtab. */
> > +       percpu_var_cnt = 0;
> > +
> > +       /* search within symtab for percpu variables */
> > +       elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> > +               if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
> >                         return -1;
> > -               }
> > -               percpu_vars[percpu_var_cnt].addr = addr;
> > -               percpu_vars[percpu_var_cnt].sz = size;
> > -               percpu_vars[percpu_var_cnt].name = sym_name;
> > -               percpu_var_cnt++;
> >         }
> >
> > -       if (percpu_var_cnt)
> > -               qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
> > +       if (collect_percpu_vars) {
> > +               if (percpu_var_cnt)
> > +                       qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
> >
> > -       if (btf_elf__verbose)
> > -               printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> > +               if (btf_elf__verbose)
> > +                       printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> > +       }
> >         return 0;
> >  }
> >
> > @@ -347,7 +357,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                 if (!btfe)
> >                         return -1;
> >
> > -               if (!skip_encoding_vars && find_all_percpu_vars(btfe))
> > +               if (collect_symbols(btfe, !skip_encoding_vars))
> >                         goto out;
> >
> >                 has_index_type = false;
> > --
> > 2.26.2
> >

-- 

- Arnaldo
