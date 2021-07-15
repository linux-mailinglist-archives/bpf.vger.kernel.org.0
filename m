Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8383C9574
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 03:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGOBQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 21:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGOBQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 21:16:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B660C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 18:13:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y7so5781857ljm.1
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5WK73N+1TmCFciFbz07KbM1H2tub03EqHNVkUSA4bU=;
        b=lwae6qeM3NJ4Z0WVuMuHkU3wHtAIKXhtL+gJ/hJ4+fz2sHKDwZANLbH7ycj1+6oFhI
         fXaOtBuNH70iuzDO6gU64sHT76LyzmatxElLLdmMWE6v4lo4DbQ3HITIrAtC1GUzMCW4
         7ALguA4Qf3ps1fWMiaHvJjmbDawH2vrI3FOybvQN17cXjXW0PcuiY11ZWMLPvn2jdz/9
         B9ziRc3C8Vag52BfII5rYT1L1wQdBXMV1lJIaTydeT8QHycYwc8ykMQEWR8bUdGS9Cak
         oPe0FvkfZ0Ocvetqx9AOoYnlZU0Vzf6I/H/lX02BAlZ0RcIKv8OpFAQTU4LSzdciCtIo
         8AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5WK73N+1TmCFciFbz07KbM1H2tub03EqHNVkUSA4bU=;
        b=BQsbPDRkbZmOKYdRUUk95sVYz+y/2IUh0K8ykYof6uGEx/R1CmM5g2ru48NpcM6Bkn
         pQRrNyqqLChSJgDgUrsZkrQptJIB1BdLmF2gyMlESDnpAhbV6v0FRZIgONujD05iPOIz
         1oNi3p5sLtz51+wbfIlF5ZKojuwoWr7kAmx+nl1OrhLc4iZTLfI2JpHvUU/UWgJGUxCy
         1pgNeQvJXWmzlEYgdSJWF93z9VAWI03y0/ua5z37lMzzWIxNERJUCx8NL/bUmqjQqXZ8
         gSXxJ/NzWSF/9qxLM8kL1siZ/X5MHoV+tCs79VEXxmIIcgIzGJfAPWgwEoVPtv5cAbtt
         W5bQ==
X-Gm-Message-State: AOAM530c+d2K42EU5Mty7ISBFJg7mMq7qaFH7i07FMM7gfcvFf/oBNFm
        ghXrXYTRmCj2Sgt5kK671x0wLIOSAse2ocGJWxc=
X-Google-Smtp-Source: ABdhPJw6K5nf75Q3p8MFScYzR2ShyZqP/Key/diTIrBtP1XvoKB3xq3eF5NjtQZtKUcx5ClQYrXWRHSEbDM/Se2AIhk=
X-Received: by 2002:a2e:b5d6:: with SMTP id g22mr550819ljn.236.1626311608553;
 Wed, 14 Jul 2021 18:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210714124317.67526-1-kuniyu@amazon.co.jp> <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
 <60ef772a443e3_5a0c120884@john-XPS-13-9370.notmuch>
In-Reply-To: <60ef772a443e3_5a0c120884@john-XPS-13-9370.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 14 Jul 2021 18:13:17 -0700
Message-ID: <CAADnVQLQChxC_UQnaoYLoOwMdt=_zuvCH=2z3hkQD+pmm2ZLSg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix a typo of reuseport map in bpf.h.
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 4:45 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Martin KaFai Lau wrote:
> > On Wed, Jul 14, 2021 at 09:43:17PM +0900, Kuniyuki Iwashima wrote:
> > > Fix s/BPF_MAP_TYPE_REUSEPORT_ARRAY/BPF_MAP_TYPE_REUSEPORT_SOCKARRAY/ typo
> > > in bpf.h.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > It could be bpf-next.
> >
> > Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
>
> LGTM with fixes and bpf-next.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Applied. Thanks
