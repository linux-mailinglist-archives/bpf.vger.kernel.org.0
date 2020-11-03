Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77C32A4FAF
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgKCTGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 14:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727688AbgKCTGM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 14:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604430371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1jv8dAufhwlVyK/l9a+Ro6BDlBegfAhIUHtscx1n3k=;
        b=iL+r4o2HrIasGeVRnAp2BmK+U9UNa6JrTM5vhJ+3oie0DVukM09H8rURX4lySxqoUfWwDp
        kemCfiyAm4k7f/hgi3PMPMSnDJ8kclFhdC/wpWyIjhXZ/kI/rbPDFApeHkL3BWVUkG/ULS
        FeLGj2hdKVFrlTulO15K3RsfMg/RmTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-m51H6txFOT-a2xEXShyqHQ-1; Tue, 03 Nov 2020 14:06:07 -0500
X-MC-Unique: m51H6txFOT-a2xEXShyqHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D746414C;
        Tue,  3 Nov 2020 19:06:06 +0000 (UTC)
Received: from krava (unknown [10.40.195.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id D3A7B60BF1;
        Tue,  3 Nov 2020 19:06:00 +0000 (UTC)
Date:   Tue, 3 Nov 2020 20:05:59 +0100
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
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201103190559.GI3597846@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava>
 <20201102225658.GD3597846@krava>
 <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 03, 2020 at 10:58:58AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 2, 2020 at 2:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Nov 02, 2020 at 10:59:08PM +0100, Jiri Olsa wrote:
> > > On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
> > > > We need to generate just single BTF instance for the
> > > > function, while DWARF data contains multiple instances
> > > > of DW_TAG_subprogram tag.
> > > >
> > > > Unfortunately we can no longer rely on DW_AT_declaration
> > > > tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> > > >
> > > > Instead we apply following checks:
> > > >   - argument names are defined for the function
> > > >   - there's symbol and address defined for the function
> > > >   - function is generated only once
> > > >
> > > > Also because we want to follow kernel's ftrace traceable
> > > > functions, this patchset is adding extra check that the
> > > > function is one of the ftrace's functions.
> > > >
> > > > All ftrace functions addresses are stored in vmlinux
> > > > binary within symbols:
> > > >   __start_mcount_loc
> > > >   __stop_mcount_loc
> > >
> > > hum, for some reason this does not pass through bpf internal
> > > functions like bpf_iter_bpf_map.. I learned it hard way ;-)
> 
> what's the exact name of the function that was missing?
> bpf_iter_bpf_map doesn't exist. And if it's __init function, why does
> it matter, it's not going to be even available at runtime, right?
> 

bpf_map iter definition:

DEFINE_BPF_ITER_FUNC(bpf_map, struct bpf_iter_meta *meta, struct bpf_map *map)

goes to:

#define DEFINE_BPF_ITER_FUNC(target, args...)                   \
        extern int bpf_iter_ ## target(args);                   \
        int __init bpf_iter_ ## target(args) { return 0; }

that creates __init bpf_iter_bpf_map function that will make
it into BTF where it's expected when opening iterator, but the
code will be freed because it's __init function

there are few iteratos functions like that, and I was going to
check if there's more

> 
> > > will check
> >
> > so it gets filtered out because it's __init function
> > I'll check if the fix below catches all internal functions,
> > but I guess we should do something more robust
> >
> > jirka
> >
> >
> > ---
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 0a378aa92142..3cd94280c35b 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -143,7 +143,8 @@ static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
> >                 /* Do not enable .init section functions. */
> >                 if (init_filter &&
> >                     func->addr >= ms->init_begin &&
> > -                   func->addr <  ms->init_end)
> > +                   func->addr <  ms->init_end &&
> > +                   strncmp("bpf_", func->name, 4))
> 
> this looks like a very wrong way to do this? Can you please elaborate
> on what's missing and why it shouldn't be missing?

yes, it's just a hack, we should do something more
robust as I mentioned above

it just allowed me to use iterators finaly ;-)

jirka

