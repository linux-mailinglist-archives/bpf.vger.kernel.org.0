Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8F2FD07C
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbhATMjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 07:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731191AbhATMWK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 07:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611145228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gf6tgpG1D86q7DyOYmdYlfG+qC7YL0qvxxUztYAzDJs=;
        b=e2u6S1nwz/FcJHgfZq9HP4vEoFIiC+3iqDzsaVcE2hQKVo+58SPV8Y+1tWOPzPj3fiAZj8
        lff8B4z48A+3+w33xSlKRcC9MKcRWehbz09Kk0kOQR2VFTg4Vn3s2cYF12q/hRRAG73+7y
        szThEoyr/u5ObSHHPPBtXfnSBNNHg78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-nM4Re3OvMjmSDz1PcyvBrQ-1; Wed, 20 Jan 2021 07:20:24 -0500
X-MC-Unique: nM4Re3OvMjmSDz1PcyvBrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F6421800D41;
        Wed, 20 Jan 2021 12:20:22 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 173761002382;
        Wed, 20 Jan 2021 12:20:11 +0000 (UTC)
Date:   Wed, 20 Jan 2021 13:20:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/3] elf_symtab: Add support for SHN_XINDEX index to
 elf_section_by_name
Message-ID: <20210120122010.GA1760208@krava>
References: <20210119221220.1745061-1-jolsa@kernel.org>
 <20210119221220.1745061-2-jolsa@kernel.org>
 <CAEf4BzYjTu-NbEQcgCXmKormPuQUQip+Qr4Qzr3X3VXPSwreBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYjTu-NbEQcgCXmKormPuQUQip+Qr4Qzr3X3VXPSwreBQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 05:23:00PM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 19, 2021 at 2:16 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > In case the elf's header e_shstrndx contains SHN_XINDEX,
> > we need to call elf_getshdrstrndx to get the proper
> > string table index.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  dutil.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/dutil.c b/dutil.c
> > index 7b667647420f..321f4be6669e 100644
> > --- a/dutil.c
> > +++ b/dutil.c
> > @@ -179,13 +179,17 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
> >  {
> >         Elf_Scn *sec = NULL;
> >         size_t cnt = 1;
> > +       size_t shstrndx = ep->e_shstrndx;
> > +
> > +       if (shstrndx == SHN_XINDEX && elf_getshdrstrndx(elf, &shstrndx))
> > +               return NULL;
> >
> 
> see comment for patch #3, no need for SHN_XINDEX checks,
> elf_getshdrstrndx() handles this transparently

ok, will change

jirka

> 
> >         while ((sec = elf_nextscn(elf, sec)) != NULL) {
> >                 char *str;
> >
> >                 gelf_getshdr(sec, shp);
> > -               str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
> > -               if (!strcmp(name, str)) {
> > +               str = elf_strptr(elf, shstrndx, shp->sh_name);
> > +               if (str && !strcmp(name, str)) {
> >                         if (index)
> >                                 *index = cnt;
> >                         break;
> > --
> > 2.27.0
> >
> 

