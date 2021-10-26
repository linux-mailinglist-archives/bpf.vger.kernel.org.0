Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D723943BAA4
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhJZTZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhJZTZ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 15:25:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE450C061570
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 12:23:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso2769386pjf.3
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7D9v5vC2G1VkcRwXV3PeMijgjvh1vq7pDFGQycc+b+k=;
        b=gwwRszebr5XwGNTCQhLiY1KUxb7oYHUNIpASL42VL+fRozEZsRrdKe7FT96CbXgvBM
         0CisUUnSr1e5zJUBThdbxh9J2BPgfp3xPqFGyzdhHxRP/9wAFxsVL/El8WPuo0hnsG45
         l9MYKsM6ZeINyobt3NeDw/44W7eW8HkCULqJH66kSWVsJedqf1VJF54qPh7rKOimi3OR
         KDzuKsKArLtx32KL4uytXoE73mvGGsulxI6kE6ErVulqJQ9IwynAr1GlMrIAxJUyC0oG
         ugxlsMNxuVmO6HWF4ugkIOjXLKIquCfTLNWwqgk/qisePkcG6pKaQmMb1Qbq6WW6qOJ1
         Y95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D9v5vC2G1VkcRwXV3PeMijgjvh1vq7pDFGQycc+b+k=;
        b=VQF6t+DzEDq0AMSFQqi5mtp9GrDUfcupsQVXvFWSzdBZc3h8SUpOsFiEoo8Wl7y2ds
         RTmMs14YRvoEQk2x8ctZ2aa+XqqzrCIYiurxc2WrmEZCEFzapk9nqW2fzBkh+Ct6qI0t
         /Q5Wzhmrc1Or+ar6ynxbGx8cBi6ne238LsSfTHlH/zf9y8WsAPyg2f9pmLDk/hNqVij9
         rQTAxJYTqxu0cW51c6BChL1vS6beacR4ndtT93XE2NJ3hNOsRyg4QzYVexjNLNtAw3ym
         ChknclB3ahRLrWTVkIX4qr3OwRfiBzhuRF7/meCGXMTM9Meszj+t7dxJPIvtvTQr07ry
         zzhA==
X-Gm-Message-State: AOAM532E0tfXQphulzOEQ9rfi23id/j1P3FPZl6kzR37Fh7r+FVL3LeZ
        0HR7cFuduIHQkB4lb1+YJfeQncZIlxVOBDQkAJw=
X-Google-Smtp-Source: ABdhPJzsDo876xV0JRz/qElj8u51sQ/ISM8tSgHmAZOQsbfRL1WBdyWyiRTQhaVWgh1PE/9GKWy5ayp+J08cAnsA6ZY=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr24859204pll.22.1635276183085; Tue, 26
 Oct 2021 12:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com>
 <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com> <CAEf4Bzb2LdZrYVP+h5HxKS+H5tj-s7h_4xir_c3+bihaU5z_yQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2LdZrYVP+h5HxKS+H5tj-s7h_4xir_c3+bihaU5z_yQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 12:22:51 -0700
Message-ID: <CAADnVQKo+jrFO4FVm=rm8q--hkHwBe9-iwDrdBzWW_aFxQ5KxA@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 11:45 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 10:59 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 10:14 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Instead of adding new types,
> > > > can we do something like this instead:
> > > >
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > index c8a78e830fca..5dbd2541aa86 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -68,7 +68,8 @@ struct bpf_reg_state {
> > > >                         u32 btf_id;
> > > >                 };
> > > >
> > > > -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > > +               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > > +               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > >
> > > This seems more confusing, it's technically possible to express a
> > > memory pointer from which you can read X bytes, but can write Y bytes.
> >
> > I'm fine it being a new flag instead of wr_mem_size.
> >
> > > I actually liked the idea that helpers will be explicit about whether
> > > they can write into a memory or only read from it.
> > >
> > > Apart from a few more lines of code, are there any downsides to having
> > > PTR_TO_MEM vs PTR_TO_RDONLY_MEM?
> >
> > because it's a churn and non scalable long term.
> > It's not just PTR_TO_RDONLY_MEM.
> > It's also ARG_PTR_TO_RDONLY_MEM,
> > and RET_PTR_TO_RDONLY_MEM,
> > and PTR_TO_RDONLY_MEM_OR_NULL
> > and *_OR_BTF_ID,
> > and *_OR_BTF_ID_OR_NULL.
> > It felt that expressing readonly-ness as a flag in bpf_reg_state
> > will make it easier to get right in the code and extend in the future.
>
> That's true, but while it's easy to add a flag to bpf_reg_state, it's
> not easy to do the same for BPF helper input (ARG_PTR_xxx) and output
> (RET_PTR_xxx) restrictions. So unless we extend ARG_PTR and RET_PTR
> with flags, it seems more consistent to keep the same pure enum
> approach for reg_state.
>
> > May be we will have a kernel vs user flag for PTR_TO_MEM in the future.
> > If we use different name to express that we will have:
> > PTR_TO_USER_RDONLY_MEM and
> > PTR_TO_USER_MEM
> > plus all variants of ARG_* and RET_* and *_OR_NULL.
> > With a flag approach it will be just another flag in bpf_reg_state.
>
> All true, but then maybe we should rethink how we do all those enums.
> And instead of having all the _OR_NULL variants, it should be
> ARG_NULLABLE/REG_NULLABLE/RET_NULLABLE flag that can be or-ed with the
> basic set of register/input/output type enums? Same for ARG_RDONLY
> flag. Same could technically be done for USER vs KERNEL memory in the
> future.

Exactly. OR_NULL is such a flag and we already struggled to
differentiate that flag with truly_not_equal_to_NULL and may_be_NULL.
That's why all bpf_skc* helpers have additional run-time !NULL check.

ARG_NULLABLE/REG_NULLABLE/RET_NULLABLE would make it cleaner.
And ARG_RDONLY would fit that model well.

> It's definitely a bunch of code changes, but if we are worried about
> an explosion of enum values, it might be the right move?
>
> On the other hand, if there are all those different variations and
> each is handled slightly differently, we'll have to have different
> logic for each of them. And whether it's an enum + flags, or a few
> more enumerators, doesn't change anything fundamentally. I feel like
> enums make code discovery a bit simpler in practice, but it's
> subjective.

I think it's a bit of a mess already.
ARG_PTR_TO_BTF_ID has may_be_NULL flag.
Just like ARG_PTR_TO_BTF_ID_SOCK_COMMON.
but RET_PTR_TO_BTF_ID doesn't.
PTR_TO_BTF_ID doesn't have that may_be_NULL assumption either.

imo cleaning up OR_NULL will be very nice.
RDONLY would be an addition on top.
We can probably fold UNINIT as a flag too.

All that will be a big change, but I think it's worth it.
