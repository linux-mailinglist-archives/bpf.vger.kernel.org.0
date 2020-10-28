Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4229D472
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgJ1VwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728281AbgJ1VwL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LozTGWjHxSdQ35uV/IvBWdUB+pje99WiRl59ynoTvg=;
        b=MzK06hw1DE3CjUDu9YQEJ8pqY+4qFaoWtEzeg9BIeyHlqu+dwMhU3zlynXAsefjaTLScSb
        6+S9Qpol0+RxBKPbrJ9YcbnweEOhiwBpiSuvlIiJk3HD/KnQ3yXna2bEy7tq4LI7uu5bE2
        vaal7qD9ogYHnhTzcpyzmuYzpU7Znxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-N5zYHUK1MmuHPRUbIdx7MA-1; Wed, 28 Oct 2020 11:50:57 -0400
X-MC-Unique: N5zYHUK1MmuHPRUbIdx7MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A411891E89;
        Wed, 28 Oct 2020 15:50:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B94E6266E;
        Wed, 28 Oct 2020 15:50:50 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:50:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 2/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201028155049.GP2900849@krava>
References: <20201026223617.2868431-1-jolsa@kernel.org>
 <20201026223617.2868431-3-jolsa@kernel.org>
 <CAEf4BzZZ6abHMB4Y2wHF+0vGVqJ_UtMnjDfSscVXbHUZcfEGtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZZ6abHMB4Y2wHF+0vGVqJ_UtMnjDfSscVXbHUZcfEGtg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 04:20:10PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We need to generate just single BTF instance for the
> > function, while DWARF data contains multiple instances
> > of DW_TAG_subprogram tag.
> >
> > Unfortunately we can no longer rely on DW_AT_declaration
> > tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> >
> > Instead we apply following checks:
> >   - argument names are defined for the function
> >   - there's symbol and address defined for the function
> >   - function is generated only once
> >
> > They might be slightly superfluous together, but it's
> > better to be ready for another DWARF mishap.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  elf_symtab.h  |   8 ++++
> >  2 files changed, 109 insertions(+), 1 deletion(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2dd26c904039..99b9abe36993 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -26,6 +26,62 @@
> >   */
> >  #define KSYM_NAME_LEN 128
> >
> > +struct elf_function {
> > +       const char *name;
> > +       bool generated;
> > +};
> > +
> > +static struct elf_function *functions;
> > +static int functions_alloc;
> > +static int functions_cnt;
> > +
> > +static int functions_cmp(const void *_a, const void *_b)
> > +{
> > +       const struct elf_function *a = _a;
> > +       const struct elf_function *b = _b;
> > +
> > +       return strcmp(a->name, b->name);
> > +}
> > +
> > +static void delete_functions(void)
> > +{
> > +       free(functions);
> > +       functions_alloc = functions_cnt = 0;
> > +}
> > +
> > +static int config_function(struct btf_elf *btfe, GElf_Sym *sym)
> > +{
> > +       if (!elf_sym__is_function(sym))
> > +               return 0;
> > +       if (!elf_sym__value(sym))
> > +               return 0;
> > +
> > +       if (functions_cnt == functions_alloc) {
> > +               functions_alloc += 5000;
> 
> maybe just do a conventional exponential size increase? Not
> necessarily * 2, could be (* 3 / 2) or (* 4 / 3), libbpf uses such
> approach.

ok, will change

> 
> > +               functions = realloc(functions, functions_alloc * sizeof(*functions));
> > +               if (!functions)
> > +                       return -1;
> > +       }
> > +
> > +       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> > +       functions_cnt++;
> > +       return 0;
> > +}
> > +
> 
> [...]
> 
> > diff --git a/elf_symtab.h b/elf_symtab.h
> > index 359add69c8ab..094ec4683d01 100644
> > --- a/elf_symtab.h
> > +++ b/elf_symtab.h
> > @@ -63,6 +63,14 @@ static inline uint64_t elf_sym__value(const GElf_Sym *sym)
> >         return sym->st_value;
> >  }
> >
> > +static inline int elf_sym__is_function(const GElf_Sym *sym)
> > +{
> > +       return (elf_sym__type(sym) == STT_FUNC ||
> > +               elf_sym__type(sym) == STT_GNU_IFUNC) &&
> 
> Why do we need to collect STT_GNU_IFUNC? That is some PLT special
> magic, does the kernel use that? Even if it does, are we even able to
> attach to that? Could that remove some of the assembly functions?

I missed that when I copied that function from perf ;-) I'll check

jirka

> 
> > +               sym->st_name != 0 &&
> > +               sym->st_shndx != SHN_UNDEF;
> > +}
> > +
> >  static inline bool elf_sym__is_local_function(const GElf_Sym *sym)
> >  {
> >         return elf_sym__type(sym) == STT_FUNC &&
> > --
> > 2.26.2
> >
> 

