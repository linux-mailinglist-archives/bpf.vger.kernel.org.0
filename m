Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DC2C6AC3
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgK0Rkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731882AbgK0Rkt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 12:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606498847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KMM3cbq6jyIBPTwItif0SInDuNROtFrwRJTOllhSLHY=;
        b=V5JZPxEdt1dISUwljIIvDkQn0RfthLvrnQXQFxoV+hskEPKZHR+9u04RCUWuMDr6zd12yD
        t3Uy5inrCQyLmBKtBZ4ZADXlm1glWZBkoOflxUhW38MkuH5mwUnUB/uS0UsYWgAgjQnTDm
        sq7a545V+6mH3dJD2S36DebLR6ATwpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-sihSX_ocOpSeX09cjrnMSw-1; Fri, 27 Nov 2020 12:40:41 -0500
X-MC-Unique: sihSX_ocOpSeX09cjrnMSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51A6C1842145;
        Fri, 27 Nov 2020 17:40:40 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 633629CA0;
        Fri, 27 Nov 2020 17:40:38 +0000 (UTC)
Date:   Fri, 27 Nov 2020 18:40:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Detect kernel module ftrace addresses
Message-ID: <20201127174037.GB2767982@krava>
References: <20201124161919.2152187-1-jolsa@kernel.org>
 <20201124161919.2152187-3-jolsa@kernel.org>
 <CAEf4BzbbpLkJth5HYh=a6V1+uPAcPpUTsi=JHQrOeHF5f2xALg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbbpLkJth5HYh=a6V1+uPAcPpUTsi=JHQrOeHF5f2xALg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 08:18:58PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 24, 2020 at 8:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add support to detect kernel module dtrace addresses and use
> > it as filter for functions.
> 
> typo: dtrace -> ftrace?

heh, honest typo I swear ;-)

SNIP

> >
> >         if (functions_cnt == functions_alloc) {
> >                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> > @@ -84,8 +85,17 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >                 functions = new;
> >         }
> >
> > +       if (elf_sym__section(sym) != last_idx) {
> > +               int idx = elf_sym__section(sym);
> 
> nit: elf_sym__section() called twice, maybe have sec_idx local variable instead?

ugh, right, will fix

> 
> > +
> > +               if (!elf_section_by_idx(btfe->elf, &sh, idx))
> > +                       return 0;
> 
> isn't this an error and shouldn't return 0?..

I'm skiping functions without section, I did not want to fail
all this because of some misplaced symbol

mabe we could warn, but still go on..

> 
> > +               last_idx = idx;
> > +       }
> > +
> >         functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> >         functions[functions_cnt].addr = elf_sym__value(sym);
> > +       functions[functions_cnt].sh_addr = sh.sh_addr;
> >         functions[functions_cnt].generated = false;
> >         functions_cnt++;
> >         return 0;
> > @@ -146,10 +156,60 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
> >         return 0;
> >  }
> >
> > +static int
> > +get_kmod_addrs(struct btf_elf *btfe, unsigned long **paddrs, unsigned long *pcount)
> > +{
> > +       unsigned long *addrs, count;
> > +       GElf_Shdr shdr_mcount;
> > +       Elf_Data *data;
> > +       Elf_Scn *sec;
> > +
> > +       /* get __mcount_loc */
> > +       sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
> > +                                 "__mcount_loc", NULL);
> > +       if (!sec) {
> > +               if (btf_elf__verbose) {
> > +                       printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
> > +                              btfe->filename);
> > +               }
> 
> 
> nit: unnecessary {} for single-statement if

ah ok, I put it because kernel guys scream with multiline
conditions without {}

> 
> > +               return 0;
> > +       }
> > +
> > +       data = elf_getdata(sec, NULL);
> > +       if (!data) {
> > +               fprintf(stderr, "Failed to data for __mcount_loc section.\n");
> > +               return -1;
> > +       }
> > +
> > +       addrs = malloc(data->d_size);
> > +       if (!addrs) {
> > +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> > +               return -1;
> > +       }
> > +
> > +       count = data->d_size / sizeof(unsigned long);
> 
> not sure this is safe to do, e.g., if we are processing ELF of
> different bitness (32 vs 64). Maybev we can get the size of an entry
> from sh_entsize?

it's not filled in, zero in my build

we could get bitness from elf header and use that in here
and also for vmlinux where it's hardcoded as well

SNIP

> > @@ -174,9 +244,18 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> >          */
> >         for (i = 0; i < functions_cnt; i++) {
> >                 struct elf_function *func = &functions[i];
> > +               /*
> > +                * For vmlinux image both addrs[x] and functions[x]::addr
> > +                * values are final address and are comparable.
> > +                *
> > +                * For kernel module addrs[x] is final address, but
> > +                * functions[x]::addr is relative address within section
> > +                * and needs to be relocated by adding sh_addr.
> > +                */
> > +               unsigned long addr = kmod ? func->addr + func->sh_addr : func->addr;
> >
> >                 /* Make sure function is within ftrace addresses. */
> > -               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> > +               if (bsearch(&addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> >                         /*
> >                          * We iterate over sorted array, so we can easily skip
> >                          * not valid item and move following valid field into
> > diff --git a/dutil.c b/dutil.c
> > index f7b853f0660d..5ebbd2f9c84c 100644
> > --- a/dutil.c
> > +++ b/dutil.c
> > @@ -196,6 +196,22 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
> >         return sec;
> >  }
> >
> > +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
> 
> 
> there is elf_getscn(), which does the same?

great, did not see it

thanks,
jirka

