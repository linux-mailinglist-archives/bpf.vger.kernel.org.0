Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E06459A4C
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 03:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhKWDCV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhKWDCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:02:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A872C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 18:59:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v203so19102993ybe.6
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 18:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/pAvLoY9KWaDEb1WGHn4Flqg5Qi1OG+/TG7gmxTVYc=;
        b=Vguj9BLiGvjksfINlYdAT9Dm2QnopHQGhes+2cDu3Z0qloftjNjRjq68A7a5aYBReW
         5Pao2tUSFqbw0ZEPODLWIu4nIQ0e4JSABZUENK51y0LOdYqOjaL/xuANy8XDk8ajrwtO
         MOrG6QqWj5uhut+sxPco26PyvjSen1upYRGvZbr3nJsXshD5n4rYdUs4rDvfR8sHLgm1
         gUk5nYr66e9LWZJijg+OP1/KX69L3gnmLzvwRjNiE6Rb43QyrdS8j0Lx0YVrcvQHnl0O
         eh07zUAe3Bp5MHm6Y6RDorhVnHjLBjErmyITO7AKGqPkaL2ToweFi8WyTR8OJZMR0JUT
         Nzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/pAvLoY9KWaDEb1WGHn4Flqg5Qi1OG+/TG7gmxTVYc=;
        b=g1lBYVBb29HIcMURar7Wo2gerGCjVTwBk/eRzY95dQ6US8BxNycHwL7z+mDDy5iVkZ
         7Q0Dq5hel2kg9RjylBNbaujqHDMMFErdeWziAcz+YimeN9tYAyd2nSh6Cw6OdR2vhLau
         dL/Jzh9ieINxVzLuUkRxEylkErDeK3yV5FpUdD3vW9TD+YwHvKNtyhNyd4rsah1Tj0KY
         tGovhOSY/U9wGw6gbprKP3DEDzIHV23A7KNE5TGJMEunBGw2scRdIrMaVkN3gvab3myr
         OL2qMloZpMU3BiwDSBw+o0Su7V8R3iI5K42yCCUcaRzYYff+wS27WdHGH6BO4hPwHmlF
         nuCg==
X-Gm-Message-State: AOAM533uzn9wtnBrM7eWuGBijHXgWQJlzhwA4DSxG67wfzub2nKQZTXf
        wo4I80ZHoFpYGgPqKnmkh4sdyFf5CivIaO7UCmJgNuQEMKk=
X-Google-Smtp-Source: ABdhPJy7ciUycocOOmhpgMjJ3thMVWHuUeMzLXX7kRMbNsXwF2p55+l9DrdSNtG/KXPDOHUDr09LIYtlkMezXo99JGo=
X-Received: by 2002:a05:6902:114a:: with SMTP id p10mr2335330ybu.267.1637636353342;
 Mon, 22 Nov 2021 18:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com> <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
In-Reply-To: <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 18:59:02 -0800
Message-ID: <CAEf4BzadJiSEe=bpFuzQAAJD-XGseSsigj5imVz4wo0Oqf6uUg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 5:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > > a possible candidate.
> > > > Then wire the result into bpf_core_apply_relo_insn().
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > >
> > >
> > > [...]
> > >
> > > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > > >                    int relo_idx, void *insn)
> > > >  {
> > > > -       return -EOPNOTSUPP;
> > > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > > +               struct bpf_core_cand_list *cands;
> > > > +
> > > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> > >
> > > this is wrong for many reasons:
> > >
> > > 1. you will overwrite previous ctx->cands, if it was already set,
> > > which leaks memory
> > > 2. this list of candidates should be keyed by relo->type_id ("root
> > > type"). Different root types get their own independent lists; so it
> > > has to be some sort of look up table from type_id to a list of
> > > candidates.
> > >
> > > 2) means that if you had a bunch of relos against struct task_struct,
> > > you'll crate a list of candidates when processing first relo that
> > > starts at task_struct. All the subsequent relos that have task_struct
> > > as root type will re-used that list and potentially trim it down. If
> > > there are some other relos against, say, struct mm_struct, they will
> > > have their independent list of candidates.
> >
> > right.
> > Your prior comment confused me. I didn't do this reuse of cands
> > to avoid introducing hashtable here like libbpf does,
> > since it does too little to actually help.
>
> Since when avoiding millions of iterations for each relocation is "too
> little help"?
>
> BTW, I've tried to measure how noticeable this will be and added
> test_verif_scale2 to core_kern with only change to use vmlinux.h (so
> that __sk_buff accesses are CO-RE relocated). I didn't manage to get
> it loaded, so something else is going there. So please take a look, I
> don't really know how to debug lskel stuff. Here are the changes:
>
> diff --git a/tools/testing/selftests/bpf/progs/core_kern.c
> b/tools/testing/selftests/bpf/progs/core_kern.c
> index 3b4571d68369..9916cf059883 100644
> --- a/tools/testing/selftests/bpf/progs/core_kern.c
> +++ b/tools/testing/selftests/bpf/progs/core_kern.c
> @@ -4,6 +4,10 @@
>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#define ATTR __always_inline
> +#include "test_jhash.h"
>
>  struct {
>   __uint(type, BPF_MAP_TYPE_ARRAY);
> @@ -57,4 +61,27 @@ int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
>   return randmap(dev->ifindex + skb->len);
>  }
>
> +SEC("tc")
> +int balancer_ingress(struct __sk_buff *ctx)
> +{
> + void *data_end = (void *)(long)ctx->data_end;
> + void *data = (void *)(long)ctx->data;
> + void *ptr;
> + int ret = 0, nh_off, i = 0;
> +
> + nh_off = 14;
> +
> + /* pragma unroll doesn't work on large loops */
> +
> +#define C do { \
> + ptr = data + i; \
> + if (ptr + nh_off > data_end) \
> + break; \
> + ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
> + } while (0);
> +#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
> + C30;C30;C30; /* 90 calls */
> + return 0;
> +}
> +
>  char LICENSE[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
> b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
> index f024154c7be7..9e2c2a6954cb 100644
> --- a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
> +++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #define ATTR __always_inline
>  #include "test_jhash.h"
>
>
> The version with libbpf does load successfully, while lskel one gives:
>
> #35 core_kern_lskel:FAIL
> test_core_kern_lskel:FAIL:open_and_load unexpected error: -22
>
> Same stuff with libbpf skeleton successfully loaded.
>
> If you manage to get it working, you'll have a BPF program 181 CO-RE
> relocations, let's see how noticeable it will be to do 181 iterations
> over ~2mln vmlinux BTF types.

Just realized that I was off by one order of magnitude, it's about
100K types, not 2 million. But the point stands, it is quite a lot.

>
> > I think I will go back to the prior version: linear search for every relo.
>
> I don't understand the resistance, the kernel has both rbtree and
> hashmaps, what's the problem just using that?
>
> > If we actually need to optimize this part of loading
> > we better do persistent cache of
> > name -> kernel btf_type-s
> > and reuse it across different programs.
>
> You can't reuse it because the same type name in a BPF object BTF can
> be resolved to different kernel types (e.g., if we still had
> ring_buffer name collision), so this is all per-BPF object (or at
> least per BPF program). We still have duplicated types in some more
> fuller kernel configurations, and it can always happen down the road.
