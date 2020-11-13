Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8E2B274A
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKMVoA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 16:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMVn7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 16:43:59 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC02C0613D1;
        Fri, 13 Nov 2020 13:43:59 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id i186so10003710ybc.11;
        Fri, 13 Nov 2020 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dk5SgpQcBf104ZLRUngK2OqCoa8MQkDmaiu6nkFIudw=;
        b=DUG4fBsk00bGmpSQCWg/1zhCd2siGT6nMph/HZqp+RARExZmo8EPTX6l1g7PIqkpjA
         kruchgsLjIevzjHWF6dJiQ/3LBwPDNVHXW7USXurv9i0yNq/cYc+3wpLoczQvgx6KnDS
         kFyN0jDCSKxsrOHhTuholW1tH0eQaY2VCcqoHRCduQxcDXiulN5kE0lRxtPunLShnKRb
         ZrVSAYdX/3+SVyZVfgopSAf79esSy2SdRwGEEX7vTJhD5XSjm7BSn4NNWS6twGrNKdJ8
         /QIrh8xPLQmCzanCZJyMrt3MUMuZf1dEcecPyru8LIjJ88J5ZCMuEvTBHplmvnYCSdHA
         plAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dk5SgpQcBf104ZLRUngK2OqCoa8MQkDmaiu6nkFIudw=;
        b=FF6OJ5C2q9TuhjyHLt99seqzECe9u0nGKos4twoq+r2OtLXCu7KqdH6kqtxLBonG7a
         yqldCDgq5ZQMrcDAeHm6BXgmao0Ao+VDppopKvpvYBTYDF4UqlJkSgnTd/AZvd9LlMsB
         j9JzPAnsjCq1omOy/ERw/0ZBenGp/2Htc1sWxgyzyC1wjp3Lrs+Oqj1HR14hWOU6sn3a
         zLQhdcRR5DSIZjwtUmGs9PzphVgcH7EUYY29CenYz3WPeEPGozdlFmhwVfg8rbb9ICrW
         oFu+PKG5+EtPfeywPvQ6sZU8hVxZWmYSfYjH9R/VgVY/vn1u/Vih3bP/Odwkw2hjsw5j
         3Lyg==
X-Gm-Message-State: AOAM531sz7M981/btahp6joqhCGTaW8Qoqi/K8iYBNWzuXwgoYDCV+xJ
        vh/+PwLo8Lm+Vs/pQ5QXnVSLOtoR8OusIk3zgtc=
X-Google-Smtp-Source: ABdhPJzbyo8EJThPH6EplnE6bMDpfjhalWKKW5rw2S83+0Nrla6D648PcMJ7CFk6x0cKiI8N0H+DyV8lCfoI22YlY0o=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr6381975ybd.27.1605303838284;
 Fri, 13 Nov 2020 13:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20201113151222.852011-1-jolsa@kernel.org> <20201113151222.852011-3-jolsa@kernel.org>
 <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com> <20201113212907.GD842058@krava>
In-Reply-To: <20201113212907.GD842058@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Nov 2020 13:43:47 -0800
Message-ID: <CAEf4BzZY9SF2rVNXpUUN=rYJ_jvBy1eq+fcQi+iRdv8dV2OVFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 1:29 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 13, 2020 at 12:56:40PM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Current conditions for picking up function records break
> > > BTF data on some gcc versions.
> > >
> > > Some function records can appear with no arguments but with
> > > declaration tag set, so moving the 'fn->declaration' in front
> > > of other checks.
> > >
> > > Then checking if argument names are present and finally checking
> > > ftrace filter if it's present. If ftrace filter is not available,
> > > using the external tag to filter out non external functions.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> >
> > I tested locally, all seems to work fine. Left few suggestions below,
> > but those could be done in follow ups (or argued to not be done).
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > BTW, for some stats.
> >
> > BEFORE allowing static funcs:
> >
> > .BTF ELF section
> > =======================================
> > Data size:      4101624
> > Header size:    24
> > Types size:     2472836
> > Strings size:   1628764
> >
> > BTF types
> > =======================================
> > Total        2472836 bytes (83310 types)
> > Struct:       920436 bytes (10305 types)
> > FuncProto:    638668 bytes (18869 types)
> > Func:         308304 bytes (25692 types)
> > Enum:         184308 bytes (2293 types)
> > Ptr:          173484 bytes (14457 types)
> > Array:         89064 bytes (3711 types)
> > Union:         81552 bytes (1961 types)
> > Const:         34368 bytes (2864 types)
> > Typedef:       32124 bytes (2677 types)
> > Var:            4688 bytes (293 types)
> > Datasec:        3528 bytes (1 types)
> > Fwd:            1656 bytes (138 types)
> > Volatile:        360 bytes (30 types)
> > Int:             272 bytes (17 types)
> > Restrict:         24 bytes (2 types)
> >
> >
> > AFTER allowing static funcs:
> >
> > .BTF ELF section
> > =======================================
> > Data size:      4930558
> > Header size:    24
> > Types size:     2914016
> > Strings size:   2016518
> >
> > BTF types
> > =======================================
> > Total        2914016 bytes (108282 types)
> > Struct:       920436 bytes (10305 types)
> > FuncProto:    851528 bytes (24814 types)
> > Func:         536664 bytes (44722 types)
> > Enum:         184308 bytes (2293 types)
> > Ptr:          173484 bytes (14457 types)
> > Array:         89064 bytes (3711 types)
> > Union:         81552 bytes (1961 types)
> > Const:         34368 bytes (2864 types)
> > Typedef:       32124 bytes (2677 types)
> > Var:            4688 bytes (293 types)
> > Datasec:        3528 bytes (1 types)
> > Fwd:            1656 bytes (138 types)
> > Volatile:        360 bytes (30 types)
> > Int:             256 bytes (16 types)
>
> nice, is this tool somewhere in the tree?

Nope, this is from my personal BTF inspection tool, which I never got
to open-sourcing, too low on the priority list...

>
> >
> > So 25692 vs 44722 functions, but the increase in func_proto is smaller
> > due to dedup. Good chunk is strings data for all those function and
> > parameter names.
> >
> >
> > >  btf_encoder.c | 24 ++++++++++--------------
> > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index d531651b1e9e..de471bc754b1 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >                 const char *name;
> > >
> > >                 /*
> > > -                * The functions_cnt != 0 means we parsed all necessary
> > > -                * kernel symbols and we are using ftrace location filter
> > > -                * for functions. If it's not available keep the current
> > > -                * dwarf declaration check.
> > > +                * Skip functions that:
> > > +                *   - are marked as declarations
> > > +                *   - do not have full argument names
> > > +                *   - are not in ftrace list (if it's available)
> > > +                *   - are not external (in case ftrace filter is not available)
> > >                  */
> > > +               if (fn->declaration)
> > > +                       continue;
> > > +               if (!has_arg_names(cu, &fn->proto))
> > > +                       continue;
> > >                 if (functions_cnt) {
> > > -                       /*
> > > -                        * We check following conditions:
> > > -                        *   - argument names are defined
> > > -                        *   - there's symbol and address defined for the function
> > > -                        *   - function address belongs to ftrace locations
> > > -                        *   - function is generated only once
> > > -                        */
> > > -                       if (!has_arg_names(cu, &fn->proto))
> > > -                               continue;
> > >                         if (!should_generate_function(btfe, function__name(fn, cu)))
> >
> > Seeing Arnaldo's confusion, I remember initially I was similarly
> > confused. I think this p->generated = true should be moved out of
> > should_generate_function() and done here explicitly. Let's turn
> > should_generate_function() into find_allowed_function() or something,
> > to encapsulate bsearch. Checking !p || p->generated could be done here
> > explicitly.
>
> ok, that should be more obvious, I'll send new version
>
> >
> > >                                 continue;
> > >                 } else {
> > > -                       if (fn->declaration || !fn->external)
> > > +                       if (!fn->external)
> >
> > Hm.. why didn't you drop this fallback? For non-vmlinux, do you think
> > it's a problem to generate all FUNCs? Mostly theoretical question,
> > though.
>
> because it would probably allowed all static functions,
> (ftrace data has only static functions that are traceable)
> and who knows what a can of worms we'd open here ;-)
>

Fair enough.

> jirka
>
