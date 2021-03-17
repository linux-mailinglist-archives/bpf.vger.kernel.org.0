Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9BC33E2FD
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 01:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCQAqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 20:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCQAqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 20:46:08 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A79C06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 17:46:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a7so39204409iok.12
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 17:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+COD45asCD6AViOAc7MrxWQy6+3ypSO2/Rgi0R4u9w=;
        b=nCAmIz5z0Rtq4Zy6d4iypjH+JgXX77D0C1BrmyEH6Mdl+rccaEDL2wis0CQPEUaVQj
         JKiK+ZeDiVtU7Axq1ODLN5mpSjErYkB4gbVMt2r3EDWPZ/RAzphW83Jbf2+8TzpikncG
         4WPZ023Wm1DrVdechGNdeQDLZaOGY9BNN3osI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+COD45asCD6AViOAc7MrxWQy6+3ypSO2/Rgi0R4u9w=;
        b=lMW+j1bIOrI2DisZSO40LgIeEzAMsbfESgOcA8SAGnTkzBK941mE01SB/tUVMKccMa
         s14vcErPZf1zhybAp2l2lPJc6m9fV3IsFr4eZ58jzK8vjDBp8W94YQNXXSBOPGV+9RlW
         mXBOyLUIolz8UAev1HNnvAEcT1GKPxfwhpn8WvdDvre9bET0Oih/8RlZziobW68OKKL/
         XGOlqA0HGRFuhaOYTQgrrFvfJyEQBNBFmMBLZhdrrE/SD3uo1DLCe4FRfk8QdgGikI1n
         PbX7QAaGhX3oEvANo/PyBnzo+Psy/wEU0DBgjqGx3beja4xt2WDMh/91ZDm2PfRdodM7
         duAw==
X-Gm-Message-State: AOAM531tp+rI3YtryNXDvnaR3QeYYkHb+OSAxMcJAYC/wzwyHVBZtGYU
        ZMr2VyvTdSvG5/qhhr2jv6aElHChtIlNrZ4ThQkgWg==
X-Google-Smtp-Source: ABdhPJwB3XvpqehjtxC0Gn0gio1Yg8n6+Cqib9VxyLHpyQSa1ebiGIZB+cDDuNsZ1p92Y9L6rQsylO53XZJfkIqulrM=
X-Received: by 2002:a05:6602:2102:: with SMTP id x2mr5498716iox.83.1615941967649;
 Tue, 16 Mar 2021 17:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
 <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com> <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com>
In-Reply-To: <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 17 Mar 2021 01:45:57 +0100
Message-ID: <CABRcYm+6By6_j+BaRMkw2-fnrJHKQYsoBMGkUKDXxYnm_AH88Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 17, 2021 at 1:35 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Mar 16, 2021 at 4:58 PM Florent Revest <revest@chromium.org> wrote:
> > On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > > +               struct bpf_map *map = reg->map_ptr;
> > > > +               int map_off, i;
> > > > +               u64 map_addr;
> > > > +               char *map_ptr;
> > > > +
> > > > +               if (!map || !bpf_map_is_rdonly(map)) {
> > > > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > > > +                       return -EACCES;
> > > > +               }
> > > > +
> > > > +               if (!tnum_is_const(reg->var_off)) {
> > > > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > > > +                       return -EACCES;
> > > > +               }
> > > > +
> > > > +               if (!map->ops->map_direct_value_addr) {
> > > > +                       verbose(env, "no direct value access support for this map type\n");
> > > > +                       return -EACCES;
> > > > +               }
> > > > +
> > > > +               err = check_helper_mem_access(env, regno,
> > > > +                                             map->value_size - reg->off,
> > > > +                                             false, meta);
> > >
> > > you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> > > use check_map_access(). And double-check that register is of expected
> > > type. just the presence of ref->map_ptr might not be sufficient?
> >
> > Sorry, just making sure I understand your comment correctly, are you
> > suggesting that we:
> > 1- skip the check_map_access_type() currently done by
> > check_helper_mem_access()? or did you implicitly mean that we should
> > call it as well next to check_map_access() ?
>
> check_helper_mem_access() will call check_map_access() for
> PTR_TO_MAP_VALUE and we expect only PTR_TO_MAP_VALUE, right? So why go
> through check_helper_mem_access() if we know we need
> check_map_access()? Less indirection, more explicit. So I meant
> "replace check_helper_mem_access() with check_map_access()".

Mhh I suspect there's still a misunderstanding, these function names
are really confusing ahah.
What about check_map_access*_type*. which is also called by
check_helper_mem_access (before check_map_access):
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c#n4329

Your message sounds like we should skip it so I was asking if that's
what you also implicitly meant or if you missed it?

> > 2- enforce (reg->type == PTR_TO_MAP_VALUE) even if currently
> > guaranteed by compatible_reg_types, just to stay on the safe side ?
>
> I can't follow compatible_reg_types :( If it does, then I guess it's
> fine without this check.

It's alright, I can keep an extra check just for safety. :)
