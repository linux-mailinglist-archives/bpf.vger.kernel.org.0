Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541CC36C555
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhD0LjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 07:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237966AbhD0LjK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Apr 2021 07:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619523507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnFEYH2ir5X1i0lkoWLMXh/bSKWjZ05zbFcheXKiHLo=;
        b=UCvnqM9aQjc2HLzch22OwuTZgKj7liZ7Fq7cVD7B0+G8geuGd1CVXqzum+H7EE1ZJbbZwW
        pyT3PUKwK1BOjkbHHNB720Xtai1ldDsRtH6qjg6kRbOsQeNdR5B4pQCgkEl16jJXFrf0ej
        /g0prMApisl3OrHq7jhfZnlkthY+5c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-dG4WkvbnO2q6rE-GMwNdBg-1; Tue, 27 Apr 2021 07:38:24 -0400
X-MC-Unique: dG4WkvbnO2q6rE-GMwNdBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37BD480ED8B;
        Tue, 27 Apr 2021 11:38:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6835F62AF7;
        Tue, 27 Apr 2021 11:38:21 +0000 (UTC)
Date:   Tue, 27 Apr 2021 13:38:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIf3rHTLqW7yZxFJ@krava>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > BTF is currently generated for functions that are in ftrace list
> > or extern.
> >
> > A recent use case also needs BTF generated for functions included in
> > allowlist.  In particular, the kernel
> > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > functions are specified under an ELF section .BTF_ids.  The symbols
> > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > set to ensure they are in the ftrace list but this kconfig dependency
> > is unnecessary.
> >
> > pahole can generate BTF for those kernel functions if it knows they
> > are in the allowlist.  This patch is to capture those symbols
> > in the .BTF_ids section and generate BTF for them.
> >
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> 
> I wonder if we just record all functions how bad that would be. Jiri,
> do you remember from the time you were experimenting with static
> functions how much more functions we'd be recording if we didn't do
> ftrace filtering?

hum, I can't find that.. but should be just matter of removing
that is_ftrace_func check

if we decided to do that, maybe we could add some bit indicating
that the function is traceable? it would save us check with
available_filter_functions file

jirka

> 
> >  btf_encoder.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  libbtf.c      |  10 ++++
> >  libbtf.h      |   2 +
> >  3 files changed, 142 insertions(+), 6 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 80e896961d4e..48c183915ddd 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -106,6 +106,121 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
> >         return 0;
> >  }
> >
> > +#define BTF_ID_FUNC_PREFIX "__BTF_ID__func__"
> > +#define BTF_ID_FUNC_PREFIX_LEN (sizeof(BTF_ID_FUNC_PREFIX) - 1)
> > +
> > +static char **listed_functions;
> > +static int listed_functions_alloc;
> > +static int listed_functions_cnt;
> 
> maybe just use struct btf as a container of strings, which is what you
> need here? You can do btf__add_str() and btf__find_str(), which are
> both fast and memory-efficient, and you won't have to manage all the
> memory and do sorting, etc, etc.
> 
> [...]
> 

