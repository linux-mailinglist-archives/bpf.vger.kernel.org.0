Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135AA33EE58
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCQKdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCQKcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 06:32:51 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD911C06175F
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v3so971569ilj.12
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oqqgjjy0YWzSfTvxYTLofKTklhyvD17RDEYJDR28ejI=;
        b=IpRcg/+jx8PdZst8xvRvgNDjDWBtoJXG01rpFgAI2ssW+vHhZblzX/WGc8kX/svhDq
         wjqWw7IaXOh65z62CgBRPUogmCR9wG0576oZZnDevAP0drTMF++Jaq+TrsFC32i/Wiwr
         nLTBIxCNbMBD24C12F/kBjNKJnu1s0he+m7jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oqqgjjy0YWzSfTvxYTLofKTklhyvD17RDEYJDR28ejI=;
        b=U24Er0nxnjRN6LwOCK3wtmEjGjEeMpsO4Cp0pSWhGJK7v6J/g7FbT5aO30hkjqQn44
         X4GZEN5o0OxmWF08xKyBx0PzyTOgGSPqNt1ceXv2U/I3FvAjMJQvkUI9RChQ1E+8EbV1
         UmSDr0udhkQMIFEcSreHub02mp3fSaQER9vDvpLuHp+hibp0EdlvKUPgCtSep+bXFfvE
         ZPFnW18tWnLWLzjuRaC8GSJysQMuuoaoPxi6LT4FpUy7odS+DeYS43YGaJLV0XdDRQFB
         mlw+EP8vQfBAjX0tXHf0Fg2V54rZGWFiURIyOvtnajLKAarcejitixo5fivJ+0wBO/dt
         HK5w==
X-Gm-Message-State: AOAM53274cH+GP53ZDFxcefLMlT/vpYZ5hCoZIkHZMxCmlNgSICylRxV
        rSYau4hQEbKo11vuvMNKxKjd4v7SyzoVjLD8EEGrsQ==
X-Google-Smtp-Source: ABdhPJxbyBoFfx9KfRMI9Hlmn2f1dJjKSTH5TF5bIvpIC52QAk7wKLeHXMiUH5hO/nkLuZtf7TemZDcuoS5ZZKelBss=
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr6987446ilr.220.1615977171186;
 Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
 <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
 <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com>
 <CABRcYm+6By6_j+BaRMkw2-fnrJHKQYsoBMGkUKDXxYnm_AH88Q@mail.gmail.com> <CAEf4BzbiK8vTO_-rgwr43+auTsSfNuTc_zLyR9qH9Dz4NLWsXA@mail.gmail.com>
In-Reply-To: <CAEf4BzbiK8vTO_-rgwr43+auTsSfNuTc_zLyR9qH9Dz4NLWsXA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 17 Mar 2021 11:32:40 +0100
Message-ID: <CABRcYmJSPsW9QRJywH6dLB2mb4aqZPnR9QnWsWhXQ3NGF9OWLQ@mail.gmail.com>
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

On Wed, Mar 17, 2021 at 2:02 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Mar 16, 2021 at 5:46 PM Florent Revest <revest@chromium.org> wrote:
> > On Wed, Mar 17, 2021 at 1:35 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Tue, Mar 16, 2021 at 4:58 PM Florent Revest <revest@chromium.org> wrote:
> > > > On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > > > > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > > > > +               struct bpf_map *map = reg->map_ptr;
> > > > > > +               int map_off, i;
> > > > > > +               u64 map_addr;
> > > > > > +               char *map_ptr;
> > > > > > +
> > > > > > +               if (!map || !bpf_map_is_rdonly(map)) {
> > > > > > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               if (!tnum_is_const(reg->var_off)) {
> > > > > > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               if (!map->ops->map_direct_value_addr) {
> > > > > > +                       verbose(env, "no direct value access support for this map type\n");
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               err = check_helper_mem_access(env, regno,
> > > > > > +                                             map->value_size - reg->off,
> > > > > > +                                             false, meta);
> > > > >
> > > > > you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> > > > > use check_map_access(). And double-check that register is of expected
> > > > > type. just the presence of ref->map_ptr might not be sufficient?
> > > >
> > > > Sorry, just making sure I understand your comment correctly, are you
> > > > suggesting that we:
> > > > 1- skip the check_map_access_type() currently done by
> > > > check_helper_mem_access()? or did you implicitly mean that we should
> > > > call it as well next to check_map_access() ?
> > >
> > > check_helper_mem_access() will call check_map_access() for
> > > PTR_TO_MAP_VALUE and we expect only PTR_TO_MAP_VALUE, right? So why go
> > > through check_helper_mem_access() if we know we need
> > > check_map_access()? Less indirection, more explicit. So I meant
> > > "replace check_helper_mem_access() with check_map_access()".
> >
> > Mhh I suspect there's still a misunderstanding, these function names
> > are really confusing ahah.
> > What about check_map_access*_type*. which is also called by
> > check_helper_mem_access (before check_map_access):
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c#n4329
> >
> > Your message sounds like we should skip it so I was asking if that's
> > what you also implicitly meant or if you missed it?
>
> ah, you meant READ/WRITE access? ok, let's keep
> check_helper_mem_access() then, never mind me

Ah cool, then we are on the same page :)
