Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9953E43B8DB
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhJZSCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhJZSCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:02:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C8C061767
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 10:59:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso111590pjb.1
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KrqtnWSYzc3yrOGwMhk3/Z+xdhxho6hiCSPbKL+h4w=;
        b=i3BS2e6hiXM0PjSznjFsOpK2KfX8lRppziLXmuDwb3HVdTLv9koB4n4oG0OFOuID2h
         psLHRsTQfJPFRWvHle2wWl3PLWzL+3kZWTvBVfqr9goAXGIxU/UcOlVyeaE6TZVPPpmn
         72myBx4lwwaL+dzyuU1fxd0rtlmMv2FNuY9baVveL8nJZRwHb1T/vpLpoDWA514G4TmV
         vquzWFeb+B3jYRV5vhDbudWyr3CUYwtBRCS1VTkRJOg9wp6/LDkZULSfLPkExAWwaxE3
         yavqhRkA0ICJ0XR4c6Ts+z74iyNmRUB9vqFVdT2mBX6s+zC1AH8LyzDNM+PuwzkOceoJ
         i1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KrqtnWSYzc3yrOGwMhk3/Z+xdhxho6hiCSPbKL+h4w=;
        b=uRvIsx1xMICyp+z4uoEvWnPMn6+NuDV93Tv8qVAas0tww3EXh887SLAAB1EbM+M4Sh
         GfZH+T3QVGWqFpdOjm2PeaAXOSJFSrmZiavmmKm94tqrYmrn+oyPEdApKhuPulxkxsFV
         HTkqXBUB2W70CJfy4HMqz0UvB1NDnubsKIXDE6ok5jN5mmGwyqDPd8eGROtCY0mJbACB
         FFhKqeZHZ2Z28PpvAA0XyEjrosI47B9WmBZ4WrwApm/qH40VeKaeEziGdWmwWyIYMH1X
         O4t/X2QnR4Pf1LJX5TpdMELEFJoryyU1p2sUsug5JayecHObd+AoWX7RtF1k/Xqpw1QV
         5+VA==
X-Gm-Message-State: AOAM533m/1YA148895y2v491iJrVmpU7G8I+7hJzwe9W4L2gMXdXvAof
        J8KKyETsv2rT16sjqqpgoSqbcLNZF1Qb4geQnIM=
X-Google-Smtp-Source: ABdhPJzMGFdV9eqzvMBY7Ij7I+lQjI5pejwljmEHhW1ED4aok24XraujaS/8pSOgMapTKpyZxOFgOAxhfub6+fnRHHo=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr250936pjj.138.1635271197274;
 Tue, 26 Oct 2021 10:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com> <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com>
In-Reply-To: <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 10:59:46 -0700
Message-ID: <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 10:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> >
> > Instead of adding new types,
> > can we do something like this instead:
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index c8a78e830fca..5dbd2541aa86 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -68,7 +68,8 @@ struct bpf_reg_state {
> >                         u32 btf_id;
> >                 };
> >
> > -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > +               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > +               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
>
> This seems more confusing, it's technically possible to express a
> memory pointer from which you can read X bytes, but can write Y bytes.

I'm fine it being a new flag instead of wr_mem_size.

> I actually liked the idea that helpers will be explicit about whether
> they can write into a memory or only read from it.
>
> Apart from a few more lines of code, are there any downsides to having
> PTR_TO_MEM vs PTR_TO_RDONLY_MEM?

because it's a churn and non scalable long term.
It's not just PTR_TO_RDONLY_MEM.
It's also ARG_PTR_TO_RDONLY_MEM,
and RET_PTR_TO_RDONLY_MEM,
and PTR_TO_RDONLY_MEM_OR_NULL
and *_OR_BTF_ID,
and *_OR_BTF_ID_OR_NULL.
It felt that expressing readonly-ness as a flag in bpf_reg_state
will make it easier to get right in the code and extend in the future.
May be we will have a kernel vs user flag for PTR_TO_MEM in the future.
If we use different name to express that we will have:
PTR_TO_USER_RDONLY_MEM and
PTR_TO_USER_MEM
plus all variants of ARG_* and RET_* and *_OR_NULL.
With a flag approach it will be just another flag in bpf_reg_state.
