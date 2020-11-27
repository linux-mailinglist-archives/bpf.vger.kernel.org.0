Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09C2C6A8B
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgK0RVa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732142AbgK0RVa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 12:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606497689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20lS4KyFnK6eGEc7ojdATwdNsXMJhTzBernBKmEWuMg=;
        b=bOavMSJ8dps5OexnAxu75edQU9Fnq4w/maMNOCEKBNB0YhhaMVolvApFwJO/d3SgJtrC1o
        kF3Smzk/iPAm7J8owQ/EPB68/oLOhlVbBLpl8K/ArKx/DRKITUwjBhEuE8S9p6NmmEsMbO
        Q84RwH2MHopv0rEj39lgFNplsR/mAwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-X2ka5mkGP4qt9YoyseY1Ng-1; Fri, 27 Nov 2020 12:21:25 -0500
X-MC-Unique: X2ka5mkGP4qt9YoyseY1Ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FD28049C6;
        Fri, 27 Nov 2020 17:21:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C4016085D;
        Fri, 27 Nov 2020 17:21:21 +0000 (UTC)
Date:   Fri, 27 Nov 2020 18:21:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 1/2] btf_encoder: Factor filter_functions function
Message-ID: <20201127172120.GA2767982@krava>
References: <20201124161919.2152187-1-jolsa@kernel.org>
 <20201124161919.2152187-2-jolsa@kernel.org>
 <CAEf4BzbjTYevuOU7L0LoT0wL2Jb4fnb5LRXEwo_V52npGgvd8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbjTYevuOU7L0LoT0wL2Jb4fnb5LRXEwo_V52npGgvd8Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 08:05:11PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 24, 2020 at 8:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Reorder the filter_functions function so we can add
> > processing of kernel modules in following patch.
> >
> > There's no functional change intended.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 57 +++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 37 insertions(+), 20 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index c40f059580da..467c4657b2c0 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -101,14 +101,17 @@ static int addrs_cmp(const void *_a, const void *_b)
> >         return *a < *b ? -1 : 1;
> >  }
> >
> > -static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> > +static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
> > +                            unsigned long **paddrs, unsigned long *pcount)
> >  {
> > -       unsigned long *addrs, count, offset, i;
> > -       int functions_valid = 0;
> > +       unsigned long *addrs, count, offset;
> >         Elf_Data *data;
> >         GElf_Shdr shdr;
> >         Elf_Scn *sec;
> >
> > +       if (!fl->mcount_start || !fl->mcount_stop)
> > +               return 0;
> > +
> 
> probably better to explicitly assign paddrs and pcount to NULL and 0 here

ok

SNIP

> > -       if (functions_cnt && has_all_symbols(&fl)) {
> > -               qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> > -               if (filter_functions(btfe, &fl)) {
> > -                       fprintf(stderr, "Failed to filter dwarf functions\n");
> > -                       return -1;
> > -               }
> > -               if (btf_elf__verbose)
> > -                       printf("Found %d functions!\n", functions_cnt);
> > -       } else {
> > -               if (btf_elf__verbose)
> > -                       printf("ftrace symbols not detected, falling back to DWARF data\n");
> > -               delete_functions();
> > +       if (functions_cnt && setup_functions(btfe, &fl)) {
> > +               fprintf(stderr, "Failed to filter dwarf functions\n");
> 
> DWARF

ook

thanks,
jirka

