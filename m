Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFC3E4E46
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhHIVJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 17:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbhHIVJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 17:09:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07239C061796
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 14:09:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p4so567381yba.3
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eE5RnXn+nxyGtmIiOFEjc4NNh6LheMKV56ThPtd3TA=;
        b=dnQa1OUhlQ4V4gtcGXqnb02y2Jr83661KI9NAGzRn3gE5zFJUxB70jLOyq38ewkRw9
         1TdXjEokIYjJ811wTaOHrPUIuZvjAwaZkVWbU6bW70uojoB3gP0ByYG2j8F68B5jM/EG
         730sNQFMQ1t7zPDO/ht3pYCzD8bkx8NvHK1SS8bHqjrpYTXrrz1QvfhVNiVLORPyUE7L
         VpIN9/12LLAzbsVV9vqFPg+DjVTnJkc1aZoRRtGjN6aZUUV6HtIaGMXcBRUNPgrA0ANg
         EKsuOvdUyBXqkbIUjIFfJrlSRI1EVu6mZZe9Y141FufuSTivAVSY6C44OaJHItEnehEK
         h0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eE5RnXn+nxyGtmIiOFEjc4NNh6LheMKV56ThPtd3TA=;
        b=QdGc9RPJ4Fff1GAAChIQ6dGwWBxeZ/55r5bztkeCUyrVsXXGfbgSjvs8s0I1bED3T0
         HPjFEk/Uf8z8G8cEL2LpEss+dq/5nbS4KSbEZdfCgkF0hJWEtt+MjQuIxeMEjxyBawf9
         LbrBeBeiJvQ/87RIbmjo/i7EMPZ6ff2Tqcn/zAtNTeWz51dzjikC11N1Esf7JCW9cut1
         gtArLuXkZ/Clp8jYaYSqL6rJjr2/mslWcMTz7kfGxd73HNK7CZH66CdWaGRHb3YLIZqg
         67poitizqN4Zxi5cBmWwa1jN+ui2kwFH2q1hXEYCeEOuWq2KF4IABrbtvmoRjgRilEKC
         e1Fw==
X-Gm-Message-State: AOAM533Yu32EuQzDXw8ERfEatfYGzMlKsOT2QH5KElM6mqqNepPPzooo
        g7/Gb6CZPkC1SJV78atnOL0qgo8eA+3gFMuHSbkc6w==
X-Google-Smtp-Source: ABdhPJx9eumFNGFQw6SMB8vCbwojQrEzVNo1c8lSOUWLuHlHUTCjfJzamxOYdz9XTmh5pGbNQFJVeabV5AaS8OVJ2WU=
X-Received: by 2002:a25:cece:: with SMTP id x197mr32428631ybe.402.1628543356249;
 Mon, 09 Aug 2021 14:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
 <20210809093437.876558-5-johan.almbladh@anyfinetworks.com> <2f97353921497b8d603cd5fff05e136d4bfcb430.camel@linux.ibm.com>
In-Reply-To: <2f97353921497b8d603cd5fff05e136d4bfcb430.camel@linux.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Mon, 9 Aug 2021 23:09:14 +0200
Message-ID: <CAM1=_QSZhtvgpECnhpMwkdrfjV3UTMKTtRBnty58nM+Zgw2=Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] s390: bpf: Fix off-by-one in tail call count limiting
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        illusionist.neo@gmail.com, zlim.lnx@gmail.com,
        Paul Burton <paulburton@kernel.org>,
        naveen.n.rao@linux.ibm.com, sandipan@linux.ibm.com,
        Luke Nelson <luke.r.nels@gmail.com>, bjorn@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, davem@davemloft.net,
        udknight@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 2:24 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2021-08-09 at 11:34 +0200, Johan Almbladh wrote:
> > Before, the eBPF JIT allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
> > Now, precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
> > behaviour of the interpreter. Verified with the test_bpf test suite
> > on qemu-system-s390x.
> >
> > Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> > ---
> >  arch/s390/net/bpf_jit_comp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/net/bpf_jit_comp.c
> > b/arch/s390/net/bpf_jit_comp.c
> > index 88419263a89a..f6cdf13285ed 100644
> > --- a/arch/s390/net/bpf_jit_comp.c
> > +++ b/arch/s390/net/bpf_jit_comp.c
> > @@ -1363,7 +1363,7 @@ static noinline int bpf_jit_insn(struct bpf_jit
> > *jit, struct bpf_prog *fp,
> >                                  jit->prg);
> >
> >                 /*
> > -                * if (tail_call_cnt++ > MAX_TAIL_CALL_CNT)
> > +                * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
> >                  *         goto out;
> >                  */
> >
> > @@ -1377,8 +1377,8 @@ static noinline int bpf_jit_insn(struct bpf_jit
> > *jit, struct bpf_prog *fp,
> >                 EMIT6_DISP_LH(0xeb000000, 0x00fa, REG_W1, REG_W0,
> > REG_15, off);
> >                 /* clij %w1,MAX_TAIL_CALL_CNT,0x2,out */
>
> This comment needs to be updated as well.
>
> >                 patch_2_clij = jit->prg;
> > -               EMIT6_PCREL_RIEC(0xec000000, 0x007f, REG_W1,
> > MAX_TAIL_CALL_CNT,
> > -                                2, jit->prg);
> > +               EMIT6_PCREL_RIEC(0xec000000, 0x007f, REG_W1,
> > +                                MAX_TAIL_CALL_CNT - 1, 2, jit->prg);
> >
> >                 /*
> >                  * prog = array->ptrs[index];
>
> With that:
>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>

Fixing it. Thanks!
