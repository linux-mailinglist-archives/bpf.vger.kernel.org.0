Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E632B26C2
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 22:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKMV3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 16:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgKMV3S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 16:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605302956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Yt4Yf/8RWFm42EEeYFCNqKzy2uiuXfYp7W6ukYao1A=;
        b=d5iz8mI7piuLPixK+sjrqXlj+EdTVvHpFd2pHBKLsHpr2sHcj3NDLNW0dKkzBXuG8nDTPI
        HHp3pbZzKeqM8guLcuy3Xj2a3VyD/mTNpaVGc82Ajjw3HTgr7DQD+XCs6E43igKe4stJ4d
        NVDshwGzWvO485ENOJVr8a3qlJM3hbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-4f7lXoerNWK7sFSgomwCkQ-1; Fri, 13 Nov 2020 16:29:12 -0500
X-MC-Unique: 4f7lXoerNWK7sFSgomwCkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B00A1006C8B;
        Fri, 13 Nov 2020 21:29:10 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 11F486115F;
        Fri, 13 Nov 2020 21:29:07 +0000 (UTC)
Date:   Fri, 13 Nov 2020 22:29:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201113212907.GD842058@krava>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
 <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 12:56:40PM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Current conditions for picking up function records break
> > BTF data on some gcc versions.
> >
> > Some function records can appear with no arguments but with
> > declaration tag set, so moving the 'fn->declaration' in front
> > of other checks.
> >
> > Then checking if argument names are present and finally checking
> > ftrace filter if it's present. If ftrace filter is not available,
> > using the external tag to filter out non external functions.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> I tested locally, all seems to work fine. Left few suggestions below,
> but those could be done in follow ups (or argued to not be done).
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> BTW, for some stats.
> 
> BEFORE allowing static funcs:
> 
> .BTF ELF section
> =======================================
> Data size:      4101624
> Header size:    24
> Types size:     2472836
> Strings size:   1628764
> 
> BTF types
> =======================================
> Total        2472836 bytes (83310 types)
> Struct:       920436 bytes (10305 types)
> FuncProto:    638668 bytes (18869 types)
> Func:         308304 bytes (25692 types)
> Enum:         184308 bytes (2293 types)
> Ptr:          173484 bytes (14457 types)
> Array:         89064 bytes (3711 types)
> Union:         81552 bytes (1961 types)
> Const:         34368 bytes (2864 types)
> Typedef:       32124 bytes (2677 types)
> Var:            4688 bytes (293 types)
> Datasec:        3528 bytes (1 types)
> Fwd:            1656 bytes (138 types)
> Volatile:        360 bytes (30 types)
> Int:             272 bytes (17 types)
> Restrict:         24 bytes (2 types)
> 
> 
> AFTER allowing static funcs:
> 
> .BTF ELF section
> =======================================
> Data size:      4930558
> Header size:    24
> Types size:     2914016
> Strings size:   2016518
> 
> BTF types
> =======================================
> Total        2914016 bytes (108282 types)
> Struct:       920436 bytes (10305 types)
> FuncProto:    851528 bytes (24814 types)
> Func:         536664 bytes (44722 types)
> Enum:         184308 bytes (2293 types)
> Ptr:          173484 bytes (14457 types)
> Array:         89064 bytes (3711 types)
> Union:         81552 bytes (1961 types)
> Const:         34368 bytes (2864 types)
> Typedef:       32124 bytes (2677 types)
> Var:            4688 bytes (293 types)
> Datasec:        3528 bytes (1 types)
> Fwd:            1656 bytes (138 types)
> Volatile:        360 bytes (30 types)
> Int:             256 bytes (16 types)

nice, is this tool somewhere in the tree?

> 
> So 25692 vs 44722 functions, but the increase in func_proto is smaller
> due to dedup. Good chunk is strings data for all those function and
> parameter names.
> 
> 
> >  btf_encoder.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index d531651b1e9e..de471bc754b1 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                 const char *name;
> >
> >                 /*
> > -                * The functions_cnt != 0 means we parsed all necessary
> > -                * kernel symbols and we are using ftrace location filter
> > -                * for functions. If it's not available keep the current
> > -                * dwarf declaration check.
> > +                * Skip functions that:
> > +                *   - are marked as declarations
> > +                *   - do not have full argument names
> > +                *   - are not in ftrace list (if it's available)
> > +                *   - are not external (in case ftrace filter is not available)
> >                  */
> > +               if (fn->declaration)
> > +                       continue;
> > +               if (!has_arg_names(cu, &fn->proto))
> > +                       continue;
> >                 if (functions_cnt) {
> > -                       /*
> > -                        * We check following conditions:
> > -                        *   - argument names are defined
> > -                        *   - there's symbol and address defined for the function
> > -                        *   - function address belongs to ftrace locations
> > -                        *   - function is generated only once
> > -                        */
> > -                       if (!has_arg_names(cu, &fn->proto))
> > -                               continue;
> >                         if (!should_generate_function(btfe, function__name(fn, cu)))
> 
> Seeing Arnaldo's confusion, I remember initially I was similarly
> confused. I think this p->generated = true should be moved out of
> should_generate_function() and done here explicitly. Let's turn
> should_generate_function() into find_allowed_function() or something,
> to encapsulate bsearch. Checking !p || p->generated could be done here
> explicitly.

ok, that should be more obvious, I'll send new version

> 
> >                                 continue;
> >                 } else {
> > -                       if (fn->declaration || !fn->external)
> > +                       if (!fn->external)
> 
> Hm.. why didn't you drop this fallback? For non-vmlinux, do you think
> it's a problem to generate all FUNCs? Mostly theoretical question,
> though.

because it would probably allowed all static functions,
(ftrace data has only static functions that are traceable)
and who knows what a can of worms we'd open here ;-)

jirka

