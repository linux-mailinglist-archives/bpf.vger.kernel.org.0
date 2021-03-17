Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0B33E573
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 02:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhCQBEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 21:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCQBCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 21:02:55 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADEC06174A;
        Tue, 16 Mar 2021 18:02:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b10so38839191ybn.3;
        Tue, 16 Mar 2021 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIb34wpPh8cC/DgOe6rXjatNRyKqWt62pqfEiFalnoM=;
        b=ApwUnD7IBzHsUxqZwXCFK6kZS0kY+YO6gjZMVVeh6pbceuGaHmafobge4u15dPM8Pw
         fz04rI4Hd0hExmZAbG66Zi6LkJzqV68NsO9c2atrUO8pf4YNXOFhe+iBuczJKMfbxt4/
         i83YjsydYgLPK6ZXsUOlffOpTpGSIJHnEU9OwUIPOZXlwQukhq7Bksx4p1MJbk/ezER0
         BZ2Dh1jLW6qayZl2IG1fFrU/mVrmFt2Svo1BnYrjDCqyEElpVvaZ33bQpFAxdu5qe28K
         QvJDXYrQLEwokCIQ4qDT2/hnHAbaVpegFNqbqxpHs9THOUZie4uqasCVrsIS+0w+Ds9d
         vZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIb34wpPh8cC/DgOe6rXjatNRyKqWt62pqfEiFalnoM=;
        b=b2WYPQ5cKXhB5ooCUFJ03S+eCMAVkb/I+JwurP6GomxJCq0+MaslKIY8i9hJo89rWQ
         lFX5Ngtv0CJuU6UDV3UEY3oo5K5KKRRBIiD0q2Po3sZ+WZcyf4g/y6wRdb68BG6w12s7
         OC2wcZ5z04a+7I+Ba/SeGIr/uUHmgUk5qwIMlwuRF3mr4Ww/61ntap0DIjt0EPsQ9p13
         hJMRx3R7fScsx2JL/D9KfTo1OzgdXw2RHnMk3XnaVWyoVSkG6Bd3NqltH1Y50REjqKKs
         quGzElhYe4fmEDCAq796CP6siV1+a0rdi449CIL20HNXGISW+kRMuDUCGPh0z1Jy6h0Y
         beMQ==
X-Gm-Message-State: AOAM531luiFVhRcUnbokarHnJp6rCszOwoNN2juDMViM5kD1fag1YXUR
        /qkuEZeuO2Rw+/fOOERdjzrCCMJBucw1ktVM9EI=
X-Google-Smtp-Source: ABdhPJwA6qllRtWDdmhhHyUfYIdbtNVM33XaIe5rFL7CEcCAnb7hzvIElSV06BQ656ozwhVIqPOKepXo8RFeG75ZvUw=
X-Received: by 2002:a25:74cb:: with SMTP id p194mr1914303ybc.347.1615942972993;
 Tue, 16 Mar 2021 18:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
 <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
 <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com> <CABRcYm+6By6_j+BaRMkw2-fnrJHKQYsoBMGkUKDXxYnm_AH88Q@mail.gmail.com>
In-Reply-To: <CABRcYm+6By6_j+BaRMkw2-fnrJHKQYsoBMGkUKDXxYnm_AH88Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Mar 2021 18:02:42 -0700
Message-ID: <CAEf4BzbiK8vTO_-rgwr43+auTsSfNuTc_zLyR9qH9Dz4NLWsXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Florent Revest <revest@chromium.org>
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

On Tue, Mar 16, 2021 at 5:46 PM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, Mar 17, 2021 at 1:35 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Mar 16, 2021 at 4:58 PM Florent Revest <revest@chromium.org> wrote:
> > > On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > > > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > > > +               struct bpf_map *map = reg->map_ptr;
> > > > > +               int map_off, i;
> > > > > +               u64 map_addr;
> > > > > +               char *map_ptr;
> > > > > +
> > > > > +               if (!map || !bpf_map_is_rdonly(map)) {
> > > > > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > > > > +                       return -EACCES;
> > > > > +               }
> > > > > +
> > > > > +               if (!tnum_is_const(reg->var_off)) {
> > > > > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > > > > +                       return -EACCES;
> > > > > +               }
> > > > > +
> > > > > +               if (!map->ops->map_direct_value_addr) {
> > > > > +                       verbose(env, "no direct value access support for this map type\n");
> > > > > +                       return -EACCES;
> > > > > +               }
> > > > > +
> > > > > +               err = check_helper_mem_access(env, regno,
> > > > > +                                             map->value_size - reg->off,
> > > > > +                                             false, meta);
> > > >
> > > > you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> > > > use check_map_access(). And double-check that register is of expected
> > > > type. just the presence of ref->map_ptr might not be sufficient?
> > >
> > > Sorry, just making sure I understand your comment correctly, are you
> > > suggesting that we:
> > > 1- skip the check_map_access_type() currently done by
> > > check_helper_mem_access()? or did you implicitly mean that we should
> > > call it as well next to check_map_access() ?
> >
> > check_helper_mem_access() will call check_map_access() for
> > PTR_TO_MAP_VALUE and we expect only PTR_TO_MAP_VALUE, right? So why go
> > through check_helper_mem_access() if we know we need
> > check_map_access()? Less indirection, more explicit. So I meant
> > "replace check_helper_mem_access() with check_map_access()".
>
> Mhh I suspect there's still a misunderstanding, these function names
> are really confusing ahah.
> What about check_map_access*_type*. which is also called by
> check_helper_mem_access (before check_map_access):
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c#n4329
>
> Your message sounds like we should skip it so I was asking if that's
> what you also implicitly meant or if you missed it?

ah, you meant READ/WRITE access? ok, let's keep
check_helper_mem_access() then, never mind me

>
> > > 2- enforce (reg->type == PTR_TO_MAP_VALUE) even if currently
> > > guaranteed by compatible_reg_types, just to stay on the safe side ?
> >
> > I can't follow compatible_reg_types :( If it does, then I guess it's
> > fine without this check.
>
> It's alright, I can keep an extra check just for safety. :)
