Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C839F2F3B1E
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393150AbhALTtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 14:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393160AbhALTtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 14:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610480855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TS7hPVbCDF9VxQYBBhd7spkgecLYeTiCw/jD7UaMlQk=;
        b=h2cMn+azXUsJLZjmZfanjCurw+flqZYaL2od3HEKQGigBXHIkTp7OMSlqyaNp4KpjibIFO
        mLd0OtnO22JCXjNZSKcasddn6v3U/EnR/V9PXgIaiGy/nAkTOBcQd4WHkOqxGeKXG2JpuH
        NUIvNDEN16N+mQOAOFDzwVu9Ef7NmF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-jRxm4bjfPki1XkhP-Kf4cw-1; Tue, 12 Jan 2021 14:47:29 -0500
X-MC-Unique: jRxm4bjfPki1XkhP-Kf4cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497801006C8D;
        Tue, 12 Jan 2021 19:47:28 +0000 (UTC)
Received: from krava (unknown [10.40.194.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0C90101E810;
        Tue, 12 Jan 2021 19:47:25 +0000 (UTC)
Date:   Tue, 12 Jan 2021 20:47:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
Message-ID: <20210112194724.GB1291051@krava>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <CAEf4BzZc0-csgmOP=eAvSP5uVYkKiYROAWtp8hwJcYA1awhVJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZc0-csgmOP=eAvSP5uVYkKiYROAWtp8hwJcYA1awhVJw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 11:20:44AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 12, 2021 at 10:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > When processing kernel image build by clang we can
> > find some functions without the name, which causes
> > pahole to segfault.
> >
> > Adding extra checks to make sure we always have
> > function's name defined before using it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 333973054b61..17f7a14f2ef0 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >
> >         if (elf_sym__type(sym) != STT_FUNC)
> >                 return 0;
> > +       if (!elf_sym__name(sym, btfe->symtab))
> > +               return 0;
> 
> elf_sym__name() is called below again, so might be better to just use
> local variable to store result?

right, will add

> 
> >
> >         if (functions_cnt == functions_alloc) {
> >                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                 if (!has_arg_names(cu, &fn->proto))
> >                         continue;
> >                 if (functions_cnt) {
> > -                       struct elf_function *func;
> > +                       const char *name = function__name(fn, cu);
> > +                       struct elf_function *func = NULL;
> >
> > -                       func = find_function(btfe, function__name(fn, cu));
> > +                       if (name)
> > +                               func = find_function(btfe, name);
> 
> isn't this a more convoluted way of writing:
> 
> name = function__name(fn, cu);
> if (!name)
>     continue;
> 
> func = find_function(btfe, name);
> if (!func || func->generated)
>     continue
> 
> ?

convoluted is my middle name ;-) I'll change it

thanks,
jirka

> 
> >                         if (!func || func->generated)
> >                                 continue;
> >                         func->generated = true;
> > --
> > 2.26.2
> >
> 

