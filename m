Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922433E2CF
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 01:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCQAfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 20:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCQAfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 20:35:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110EBC06174A;
        Tue, 16 Mar 2021 17:35:45 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y133so297365ybe.12;
        Tue, 16 Mar 2021 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ngn7haq1qBllu5daK/Tb7VbRSaka7EgYa27dkLkNk20=;
        b=Z4ILGhaw6jcDEIG18PQJANlC59RDjSupVTY3X9MTjXOwCoFoZz31OdEcOvV+HFn9AO
         tkonpmUNDh1Qcyey5aQjJYuTo4ayST63VHYRpnEhLi4R7l5mArQE4nRUt3am5vpwFryq
         eQfvpZ7cFH9Q+uh1TInPifhlT0ugKROax+0okeEDQGdIACEyh+WVHZvqIHTkQy76CzCf
         4veyqJUVC8dnb5BWkZKG5b3CkNBQY0TToqkryHNqEOPGWYW00i54vlciz8tIGMQz29nx
         E1H09F6lEOfynRHSMKCUAbyEn/0fgszCiDE6WdH3dL86vzOEKuo97Knm1/+5yPfctdz0
         O4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ngn7haq1qBllu5daK/Tb7VbRSaka7EgYa27dkLkNk20=;
        b=CLQ3FqyGxl5ZBI1sO/Nx1biFd0PlP5LbIt1zp5WWwj4MWkkb07pGcyt9EPaNV9JNmk
         YOmphmNoSAo2M/QKYqcgtQKyCZd146mUMIqqH2sxmjD4VjQimfZb2rspPOEXmDmIkSFT
         3ACWejW1zk3JAQVMwNNfXebci19XfC2SkYOa4olEUAZWIzG9VuykLiQ0d7FygrFjtvQc
         xz1CkjD1OeBNhY9FiPoL2vfzArZNakvrrQOFnM00y+M61Gxhafgw8AWtV0oJBDlnJPT8
         x4P/OhII0PYKpCq2pdqmfhzqOcZcPDs72ObMpVD3JwppGNVS9GBmkNMWeCl7h2nYHDYo
         6MPw==
X-Gm-Message-State: AOAM5314Pg6g9RyDk3OMTMK5cznIuWjA4/UWtEbZXYqE2BvRsC5yQTZe
        XWGYpyIPZjZDRp/6I7fVDA/GA1BlpdwBLNXBgaQ=
X-Google-Smtp-Source: ABdhPJyzszlNE+4shGBQHUzH1cInKrj1Ln5NI4xgcZ0p839yXqCa5lmqG5ugLJfeRdl+CxgUiiNnTS8d4iM6lN/YbK8=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr1969768ybf.260.1615941344232;
 Tue, 16 Mar 2021 17:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com> <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
In-Reply-To: <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Mar 2021 17:35:33 -0700
Message-ID: <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com>
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

On Tue, Mar 16, 2021 at 4:58 PM Florent Revest <revest@chromium.org> wrote:
>
> On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > +               struct bpf_map *map = reg->map_ptr;
> > > +               int map_off, i;
> > > +               u64 map_addr;
> > > +               char *map_ptr;
> > > +
> > > +               if (!map || !bpf_map_is_rdonly(map)) {
> > > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > > +                       return -EACCES;
> > > +               }
> > > +
> > > +               if (!tnum_is_const(reg->var_off)) {
> > > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > > +                       return -EACCES;
> > > +               }
> > > +
> > > +               if (!map->ops->map_direct_value_addr) {
> > > +                       verbose(env, "no direct value access support for this map type\n");
> > > +                       return -EACCES;
> > > +               }
> > > +
> > > +               err = check_helper_mem_access(env, regno,
> > > +                                             map->value_size - reg->off,
> > > +                                             false, meta);
> >
> > you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> > use check_map_access(). And double-check that register is of expected
> > type. just the presence of ref->map_ptr might not be sufficient?
>
> Sorry, just making sure I understand your comment correctly, are you
> suggesting that we:
> 1- skip the check_map_access_type() currently done by
> check_helper_mem_access()? or did you implicitly mean that we should
> call it as well next to check_map_access() ?

check_helper_mem_access() will call check_map_access() for
PTR_TO_MAP_VALUE and we expect only PTR_TO_MAP_VALUE, right? So why go
through check_helper_mem_access() if we know we need
check_map_access()? Less indirection, more explicit. So I meant
"replace check_helper_mem_access() with check_map_access()".

> 2- enforce (reg->type == PTR_TO_MAP_VALUE) even if currently
> guaranteed by compatible_reg_types, just to stay on the safe side ?

I can't follow compatible_reg_types :( If it does, then I guess it's
fine without this check.
