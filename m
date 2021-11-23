Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9767F4598FF
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhKWAMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhKWAMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:12:41 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698CC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:09:34 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so18039100ybg.9
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KRzJ/dWrWfzzg1egg6OO/+zNMXyWkAW4RukKlIBFyM=;
        b=OPySmW/H80RsrY4oNNpjKiaVua34x8HjM2/4rTGC+Mkopr1N+iwGvmOiUtoLzGkWo8
         Z+Frqo2q9w/OdWWje4kRUp/3qmckOYiUyObOrzaGspEJ5Y9s2B2NRCU5cg7+AYtgM+MQ
         de0Qd+gCLPsSapGkEU9gT3MD9opTJiLPoMYJHvbe2TG4FxD3nHTGX+QeC7t49Z7uwepB
         OEa4j1ALCAj/owBxvRbWAcK1ph94N3zBgqy648g0exujKWJiM0NZMIER/uTr0p9/XxzO
         ICAexDl7pY1n/7zzElJhmUYXXJ3eBJLPhYCHfGswfiBAMS7/4DQCq/yLMBsTxGsbC3kL
         cKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KRzJ/dWrWfzzg1egg6OO/+zNMXyWkAW4RukKlIBFyM=;
        b=qHlxlfChL4n+Unspn3YBvg1sPSkiYqMK4eOp+Lb/M/STpARmpBWc7KSIRrwhKFb86s
         XtKnDB3Te4DMcOTcxGMdUlnmDJ0/KAd9Vj+2EJXhjh1WFQW/B7bO+keucDH40sdMOl+b
         EYM6JzPUeeuWBJJvKJomi5BKs3HgZfw+sUXrcoyUmDRf+Mil2+GuCjwbWwOp00/5t0p2
         Wccn2hvNwvuIh3Jf67aOVpQZCMe+LCTIot27qkB7ziuYJauaOy5X7S1warbujzfv4OVf
         jEFL4tS4osHa1YzbYEq0/Qaq6AXsB9zw+N26aRVqZGt+HpTFe83ZmbzfZrufXwLlR/y1
         /obQ==
X-Gm-Message-State: AOAM530PKi23pgKHnXw0b+HE8XF9awTZ5b8ZWE+psorj3JdwcqUFHZLK
        aN4dGDmIreVhw9iQRQz4ruYF5n2tbCd99SoEkgc=
X-Google-Smtp-Source: ABdhPJydBCK34FnoN0xnGfGqGDfaD0KdUfgWbs6uwr4V/Mo5T04ORiXLAC4PoXbPs3TIE97Zt6MYNQgijRe/ecs3La0=
X-Received: by 2002:a05:6902:68d:: with SMTP id i13mr1398027ybt.2.1637626173805;
 Mon, 22 Nov 2021 16:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-13-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 16:09:23 -0800
Message-ID: <CAEf4BzbR6a3UrPZj9DcJtARYL74iZJKndkKhHkrKSNuhLGfDyA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/13] selftests/bpf: Additional test for
 CO-RE in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Additional test where randmap() function is appended to three different bpf
> programs. That action checks struct bpf_core_relo replication logic and offset

typo: replication -> relocation?

> adjustment.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/core_kern.c      | 14 +++++
>  tools/testing/selftests/bpf/progs/core_kern.c | 60 +++++++++++++++++++
>  3 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
>  create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4fd040f5944b..139d7e5e0a5f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -326,7 +326,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h               \
>
>  LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
>         test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
> -       map_ptr_kern.c
> +       map_ptr_kern.c core_kern.c
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
>  SKEL_BLACKLIST += $$(LSKELS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern.c b/tools/testing/selftests/bpf/prog_tests/core_kern.c
> new file mode 100644
> index 000000000000..561c5185d886
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/core_kern.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include "test_progs.h"
> +#include "core_kern.lskel.h"
> +
> +void test_core_kern_lskel(void)
> +{
> +       struct core_kern_lskel *skel;
> +
> +       skel = core_kern_lskel__open_and_load();
> +       ASSERT_OK_PTR(skel, "open_and_load");
> +       core_kern_lskel__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
> new file mode 100644
> index 000000000000..3b4571d68369
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/core_kern.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, u32);
> +       __type(value, u32);
> +       __uint(max_entries, 256);
> +} array1 SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, u32);
> +       __type(value, u32);
> +       __uint(max_entries, 256);
> +} array2 SEC(".maps");
> +
> +int randmap(int v)
> +{
> +       struct bpf_map *map = (struct bpf_map *)&array1;
> +       int key = bpf_get_prandom_u32() & 0xff;
> +       int *val;
> +
> +       if (bpf_get_prandom_u32() & 1)
> +               map = (struct bpf_map *)&array2;
> +
> +       val = bpf_map_lookup_elem(map, &key);
> +       if (val)
> +               *val = bpf_get_prandom_u32() + v;
> +
> +       return 0;

If I understand correctly the intent, this function should have had
some CO-RE relocations, no? So that after its code is appended to the
three entry-level progs below CO-RE relocations are performed
correctly, right? But as far as I can see, this function doesn't do
any CO-RE relocations or am I missing something? If it was accessing
map->type or something along those lines (probably through
BPF_CORE_READ() macro), then it would have CO-RE relocs.

> +}
> +
> +SEC("tp_btf/xdp_devmap_xmit")
> +int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device
> +            *from_dev, const struct net_device *to_dev, int sent, int drops,
> +            int err)
> +{
> +       return randmap(from_dev->ifindex);
> +}
> +
> +SEC("fentry/eth_type_trans")
> +int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
> +            struct net_device *dev, unsigned short protocol)
> +{
> +       return randmap(dev->ifindex + skb->len);
> +}
> +
> +SEC("fexit/eth_type_trans")
> +int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
> +            struct net_device *dev, unsigned short protocol)
> +{
> +       return randmap(dev->ifindex + skb->len);
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> --
> 2.30.2
>
