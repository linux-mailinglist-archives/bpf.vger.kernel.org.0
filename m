Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E750A413568
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhIUOgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhIUOgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 10:36:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046FC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 07:34:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so2101575pjc.3
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oye7XSlGg9q5Kb0NQt0utXSa8Bwn/tNarwPB/wGI9sw=;
        b=T/qMzw/Lw1o2aHcA6qFmcfnRCCYL+ydKwpcCOnsqDM6M1d/Seq39ZqtflbtaBwQZ6X
         HUsm3bFc80awhXCPT2NRSnY+GKucYRhqC/s8dMDv1C7Llp9ottJuo1SSILjSGpPSq4Is
         47RLieV5St2xAM2wzJglODG+DDggL0ELXFxRRsp3LAJdFkPFr0D/KwnmYftojMEQEW68
         4XvreMcFOA/LEPLwpR4o44P1dIFz4Hj71YrPZdfVrM8J8Lx/0CEnlABPYTMoRygGYIkU
         U5q1RR6z5h3L3BoBUZUkGuqGbnVjqf46KDXwH7ymF+z0c/hwH+4ELa/mRO/RAJKSWxOE
         +ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oye7XSlGg9q5Kb0NQt0utXSa8Bwn/tNarwPB/wGI9sw=;
        b=mvb61f3tX1j7IW11BzNGx+hrJTdSv0ujVkeRNWYuAn0oVrEPP8xnC7/009Y8jeqRvU
         mMKfCVb9t3WgoZ0IG+LBBBHL4pXPPQPxxGN4ux0nbq4kmzHTJXZg0wAdPA4Q768prmyQ
         8e/rghq3331pKoL7WOTzzCMFpYU8q/Q/TBhIDjYBpE6vZMWvPOXuLU91DluJVlP5hW6X
         gxc+Uxt99ASVfq3aTrLgN+Io8CfHXSP3WwUYjg31pvCFzokVG/Ekesx0N04mzflCN5wF
         Liqv9vSbWqhnwqCTPQxAoi9dy5ipmMwxqn5th23EfSmYvBwuI0edTBljrR/60WZs8mBv
         wOXA==
X-Gm-Message-State: AOAM532Fmn+bqTuwzUuzG1bap71UcErBIFmfAfpkIdmurcPvZIQbQwVo
        rRfArj2xZQ0tzLgmtfIB75vYD7EWDt/jXto+t+ulO9Bq
X-Google-Smtp-Source: ABdhPJyQS8y+7pL+4BkrYAgUXVxuNMVrb2rcH+YTBi/7U+FoiMa0ZaO5oA0/vFE2XlgxXF9GOyNPOVoy608zipK6diE=
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr5649633pjj.122.1632234883989;
 Tue, 21 Sep 2021 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
In-Reply-To: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Sep 2021 07:34:33 -0700
Message-ID: <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 4:50 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi,
>
> We just had a close shave with bpf_jit_limit. Something on our edge
> caused us to cross the default limit, which made seccomp and xt_bpf
> filters fail to load. Looking at the source made me realise that we
> narrowly avoided taking out our load balancer, which would've been
> pretty bad. We still run the LB with CAP_SYS_ADMIN instead of narrower
> CAP_BPF, CAP_NET_ADMIN. If we had migrated to the lesser capability
> set we would've been prevented from loading new eBPF:
>
> int bpf_jit_charge_modmem(u32 pages)
> {
>     if (atomic_long_add_return(pages, &bpf_jit_current) >
>         (bpf_jit_limit >> PAGE_SHIFT)) {
>         if (!capable(CAP_SYS_ADMIN)) {
>             atomic_long_sub(pages, &bpf_jit_current);
>             return -EPERM;
>         }
>     }
>
>     return 0;
> }
>
> Does it make sense to include !capable(CAP_BPF) in the check?

Good point. Makes sense to add CAP_BPF there.
Taking down critical networking infrastructure because of this limit
that supposed to apply to unpriv users only is scary indeed.

> This limit reminds me a bit of the memlock issue, where a global limit
> causes coupling between independent systems / processes. Can we remove
> the limit in favour of something more fine grained?

Right. Unfortunately memcg doesn't distinguish kernel module
memory vs any other memory. All types of memory are memory.
Regardless of whether its type is per-cpu, bpf map memory, bpf jit memory, etc.
That's the main reason for the independent knob for JITed memory.
Since it's a bit special. It's a crude knob. Certainly not perfect.
