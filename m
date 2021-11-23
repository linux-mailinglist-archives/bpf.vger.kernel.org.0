Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0A4599D1
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 02:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhKWBr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 20:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 20:47:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B87C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 17:44:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v7so55293870ybq.0
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBdpwbIkcHigs0Jy3z07cs4e2JnlmQ5JBif970W1adE=;
        b=GM0tAHdFir2ugMYucsqUL0S9r3xD1oDK+6ZYf7d4737wRJHzNixc3wxxn3kKWkeL5c
         GUImN1yJXCKS/2oMZ85yyvxM8jOqeWX5WhdMmVaXmJoz6hwntxqrA1k4jRhI775AG5Vq
         WqY/7ceTr0pDr6fCqZspZejJ58afnfPVLDdbgzXBrBHg3camwiNvpBTWkjeW6N3JOIha
         sRDsPH6sM+Ce4ZHeBC6q8YFYCNhrCNtjk+s3zjgq0PpxoTRgCMweEU2uw+IYLIgJEjxn
         8Mgs/ClRHuI4eHlAKtbRMqCutQiNGGIK87AskaRiy9k2ZuB9LVDZP6gSOCFPCuNc1cLf
         5rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBdpwbIkcHigs0Jy3z07cs4e2JnlmQ5JBif970W1adE=;
        b=0+SSb1K/VW9L9wlG7CzDCsAOCWkemxuUvuxJIDOKYRpM9WjrmJkJnnOsJshHDzdQlA
         PqoPDyaMZP+BIhiupkeNiKbvXTTEDBLbqHjAijcKzWB/CLWK1M5EhSECHzgSnepCEZiZ
         /VErcp+grZKiHAKagpBIg6YdvCZFsMal/DSDbDieLc7aoegOTBe34tnw8vmxA/ZEzr9j
         p7jiejUWh1B+Xo4UP0NJTviPGxDEVUC6eHSGe4jPxStHwp6M1iYHiL1Q7rctfLQyZNAM
         P9osD48IwGkDziwoU6Qz2Cg5tmR6o1WBSZ218t6o7eH6J4Sc2J0XmDWxCth40EK2NNFs
         eZYw==
X-Gm-Message-State: AOAM531xVc8cZeAEAGjBWwY43N8MyzkEaFh/PCBEQpZ2yH4En1X9ZLi/
        4ujS3H95mF1j9rW9Wpws4Wt6yudKCsiU3S3WS68=
X-Google-Smtp-Source: ABdhPJwqGmtD2E9Itt2TJnHAV3ckgiyBUHfSjSEXc6nHamOIInd8JmcM3cAS90JiV+D1zNOMrnS3qCfLpZ7RJ1hzy9A=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr1675370yba.433.1637631860075;
 Mon, 22 Nov 2021 17:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
In-Reply-To: <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 17:44:08 -0800
Message-ID: <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
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

On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > a possible candidate.
> > > Then wire the result into bpf_core_apply_relo_insn().
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > >
> >
> > [...]
> >
> > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > >                    int relo_idx, void *insn)
> > >  {
> > > -       return -EOPNOTSUPP;
> > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > +               struct bpf_core_cand_list *cands;
> > > +
> > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> >
> > this is wrong for many reasons:
> >
> > 1. you will overwrite previous ctx->cands, if it was already set,
> > which leaks memory
> > 2. this list of candidates should be keyed by relo->type_id ("root
> > type"). Different root types get their own independent lists; so it
> > has to be some sort of look up table from type_id to a list of
> > candidates.
> >
> > 2) means that if you had a bunch of relos against struct task_struct,
> > you'll crate a list of candidates when processing first relo that
> > starts at task_struct. All the subsequent relos that have task_struct
> > as root type will re-used that list and potentially trim it down. If
> > there are some other relos against, say, struct mm_struct, they will
> > have their independent list of candidates.
>
> right.
> Your prior comment confused me. I didn't do this reuse of cands
> to avoid introducing hashtable here like libbpf does,
> since it does too little to actually help.

Since when avoiding millions of iterations for each relocation is "too
little help"?

BTW, I've tried to measure how noticeable this will be and added
test_verif_scale2 to core_kern with only change to use vmlinux.h (so
that __sk_buff accesses are CO-RE relocated). I didn't manage to get
it loaded, so something else is going there. So please take a look, I
don't really know how to debug lskel stuff. Here are the changes:

diff --git a/tools/testing/selftests/bpf/progs/core_kern.c
b/tools/testing/selftests/bpf/progs/core_kern.c
index 3b4571d68369..9916cf059883 100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -4,6 +4,10 @@

 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define ATTR __always_inline
+#include "test_jhash.h"

 struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
@@ -57,4 +61,27 @@ int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
  return randmap(dev->ifindex + skb->len);
 }

+SEC("tc")
+int balancer_ingress(struct __sk_buff *ctx)
+{
+ void *data_end = (void *)(long)ctx->data_end;
+ void *data = (void *)(long)ctx->data;
+ void *ptr;
+ int ret = 0, nh_off, i = 0;
+
+ nh_off = 14;
+
+ /* pragma unroll doesn't work on large loops */
+
+#define C do { \
+ ptr = data + i; \
+ if (ptr + nh_off > data_end) \
+ break; \
+ ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+ } while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+ C30;C30;C30; /* 90 calls */
+ return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
index f024154c7be7..9e2c2a6954cb 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #define ATTR __always_inline
 #include "test_jhash.h"


The version with libbpf does load successfully, while lskel one gives:

#35 core_kern_lskel:FAIL
test_core_kern_lskel:FAIL:open_and_load unexpected error: -22

Same stuff with libbpf skeleton successfully loaded.

If you manage to get it working, you'll have a BPF program 181 CO-RE
relocations, let's see how noticeable it will be to do 181 iterations
over ~2mln vmlinux BTF types.

> I think I will go back to the prior version: linear search for every relo.

I don't understand the resistance, the kernel has both rbtree and
hashmaps, what's the problem just using that?

> If we actually need to optimize this part of loading
> we better do persistent cache of
> name -> kernel btf_type-s
> and reuse it across different programs.

You can't reuse it because the same type name in a BPF object BTF can
be resolved to different kernel types (e.g., if we still had
ring_buffer name collision), so this is all per-BPF object (or at
least per BPF program). We still have duplicated types in some more
fuller kernel configurations, and it can always happen down the road.
