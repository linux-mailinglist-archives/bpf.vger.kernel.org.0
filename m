Return-Path: <bpf+bounces-68975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A192B8B54A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F622A022F4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB22D0617;
	Fri, 19 Sep 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHxCz1S6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1D23FC54
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317318; cv=none; b=PRwG2z7YhsPwrwJmIkg0qMLsxaEyGzNylIXV7SMXidS0KIi7o9tOVD5iVYV6WTuR4GxrFw00dkYgAj2nazlEJv/YowFTYXNQ2gDll13mMTJlpd9df5/zPISyBB2SS6qaEI0bup0auHNxLD9nKtnY9OUKv44E4Qr4J1SQhV42qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317318; c=relaxed/simple;
	bh=Uw4VgCFQ45ucHVft297B/h5SB6oYPwTf2mQlhvGWZKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmTA+01lrD1QI9DyOhJXI9S2LOmvIA4wRlIFVHUAfkEQ70ZBuTrot1M/w9DkOnmDzr9u5HZhFeDTwpD+Xx4i14A//GAka6HJw3ieaBvNvWyy2JlZbSbgkwfYXevZKBKb4MHaQnky55dzaF/VhUvGulunHD+xBtiloQkFsDD4w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHxCz1S6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2435926a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758317316; x=1758922116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7uU4VqdItPNCbV0vqy9aUvcj6VKOwzP5JwOuft1inQ=;
        b=nHxCz1S69oLNbHvQ4V5zPnbwJ3BEGPHYgw3AQFgWmDiW7fCirvtjIDfXnCJfOrxz2g
         kA0aTrJ6ZdnwNvfRJzpvFcx9wkh+dAJQxtm3QiniJmTPAsOiLeGOcQDAo6LNcWvFKB+j
         PKMxZcefS8lO+R/kORCb1uv1HkLP+qMg2owTujvFgDcL48XiO828YBaJRDir9x4skGpe
         Gt0r9fvZAGTTfUJq0ztVRugzhbg3o6fwX04utXM+6qDi3mpfvUBCRZ8kDHEdijdcwcB8
         eOFkhZrnhPY+YSDICqsYN1S4Ym86jGzeYmpWQIc8Im4/1n3kpKTzZZQaMzGMWs+GimZq
         iddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758317316; x=1758922116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7uU4VqdItPNCbV0vqy9aUvcj6VKOwzP5JwOuft1inQ=;
        b=RzqklegjPyOOrYMnr4n2CHlKJVhw6llE3l4izmZXvIlbOlYmSKJdvn4UhLJGaNXUyB
         0j/NxsDrHiKpE9L8c2e5VDjKARubj1WsRjuwAx6u71xCZFBC8vWYGApwSVe/Tr3sIN4F
         Nca7JGqDPfgJfYmFny0VOroHmirDDcCOemNxISEiDsxR/A9IesAG8Iz5ceP1hxCKcKVh
         2t6lZjYdiTtqotLoC5dsFc6AYUOWiZDaNdEEC2+Jea5eOTxFXPbn6Odo4whkgR18BbYy
         0tMAzKaQvExPsqdBoGK6ZZcH0xpHLRoFUL9ia0a2lzHZZsRg6SD8EbMSc2YyIifPTLOZ
         oO0A==
X-Gm-Message-State: AOJu0YwWRl3q918M+DGbSxKcbSO0ssMMlVhiSE3y/OJZw/zNIYSryko7
	WvfU4tN3DMWxWk7atJP/RfMwVHdgs2Kx+RFoZ8gxR4LDpH3B2ntIAkpzSGVihyTnZD+OfBDFvJf
	sYrNhzP1KfZwIoK/5sIwAgLlrj9trA9w=
X-Gm-Gg: ASbGnctM0MaaO80I/VDGqMG65adLnfsrkK2s1rgEin7tJ/9XYyVzLlb1Dah7BDDWNHY
	GmNYyaErGSNsWS9Y6Dpi3yYLoX2vW14/xuY/0lAt57w53LmIk1FuymaKFP3pDrEMhPY/xeN1KE6
	WxBcwoHkxsmVAH8NoYIVIeD5PJjcQoi2icbaZWhw6XZQOxOZ+Hq7lRVgmmfxv6s6Ux5V3ito1vb
	wGHt8okhtdNLo9OZjlN2q36MKYLnm8OWA==
X-Google-Smtp-Source: AGHT+IF6hHYull/0Inh6818aB0oHWX/ygfNnH3FQKh8GwE7ONLfoNUegCfxW0ChS9ykp/gdmZSEMDv2pdWNq1DI6uhw=
X-Received: by 2002:a17:90b:1a8c:b0:32b:d8bf:c785 with SMTP id
 98e67ed59e1d1-3309834a0c4mr6492385a91.20.1758317316097; Fri, 19 Sep 2025
 14:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206110622.1161752-1-houtao@huaweicloud.com> <20241206110622.1161752-7-houtao@huaweicloud.com>
In-Reply-To: <20241206110622.1161752-7-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 14:28:21 -0700
X-Gm-Features: AS18NWAJS_7AjWbxHbh3sjCmsSyuLZcgC0gH26nO0A9tAns2t2wrr7Gl0-6O4uA
Message-ID: <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 6/9] bpf: Switch to bpf mem allocator for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:54=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Multiple syzbot warnings have been reported. These warnings are mainly
> about the lock order between trie->lock and kmalloc()'s internal lock.
> See report [1] as an example:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
> ------------------------------------------------------
> syz.3.2069/15008 is trying to acquire lock:
> ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node ...
>
> but task is already holding lock:
> ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ...
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&trie->lock){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave
>        _raw_spin_lock_irqsave+0x3a/0x60
>        trie_delete_elem+0xb0/0x820
>        ___bpf_prog_run+0x3e51/0xabd0
>        __bpf_prog_run32+0xc1/0x100
>        bpf_dispatcher_nop_func
>        ......
>        bpf_trace_run2+0x231/0x590
>        __bpf_trace_contention_end+0xca/0x110
>        trace_contention_end.constprop.0+0xea/0x170
>        __pv_queued_spin_lock_slowpath+0x28e/0xcc0
>        pv_queued_spin_lock_slowpath
>        queued_spin_lock_slowpath
>        queued_spin_lock
>        do_raw_spin_lock+0x210/0x2c0
>        __raw_spin_lock_irqsave
>        _raw_spin_lock_irqsave+0x42/0x60
>        __put_partials+0xc3/0x170
>        qlink_free
>        qlist_free_all+0x4e/0x140
>        kasan_quarantine_reduce+0x192/0x1e0
>        __kasan_slab_alloc+0x69/0x90
>        kasan_slab_alloc
>        slab_post_alloc_hook
>        slab_alloc_node
>        kmem_cache_alloc_node_noprof+0x153/0x310
>        __alloc_skb+0x2b1/0x380
>        ......
>
> -> #0 (&n->list_lock){-.-.}-{2:2}:
>        check_prev_add
>        check_prevs_add
>        validate_chain
>        __lock_acquire+0x2478/0x3b30
>        lock_acquire
>        lock_acquire+0x1b1/0x560
>        __raw_spin_lock_irqsave
>        _raw_spin_lock_irqsave+0x3a/0x60
>        get_partial_node.part.0+0x20/0x350
>        get_partial_node
>        get_partial
>        ___slab_alloc+0x65b/0x1870
>        __slab_alloc.constprop.0+0x56/0xb0
>        __slab_alloc_node
>        slab_alloc_node
>        __do_kmalloc_node
>        __kmalloc_node_noprof+0x35c/0x440
>        kmalloc_node_noprof
>        bpf_map_kmalloc_node+0x98/0x4a0
>        lpm_trie_node_alloc
>        trie_update_elem+0x1ef/0xe00
>        bpf_map_update_value+0x2c1/0x6c0
>        map_update_elem+0x623/0x910
>        __sys_bpf+0x90c/0x49a0
>        ...
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&trie->lock);
>                                lock(&n->list_lock);
>                                lock(&trie->lock);
>   lock(&n->list_lock);
>
>  *** DEADLOCK ***
>
> [1]: https://syzkaller.appspot.com/bug?extid=3D9045c0a3d5a7f1b119f7
>
> A bpf program attached to trace_contention_end() triggers after
> acquiring &n->list_lock. The program invokes trie_delete_elem(), which
> then acquires trie->lock. However, it is possible that another
> process is invoking trie_update_elem(). trie_update_elem() will acquire
> trie->lock first, then invoke kmalloc_node(). kmalloc_node() may invoke
> get_partial_node() and try to acquire &n->list_lock (not necessarily the
> same lock object). Therefore, lockdep warns about the circular locking
> dependency.
>
> Invoking kmalloc() before acquiring trie->lock could fix the warning.
> However, since BPF programs call be invoked from any context (e.g.,
> through kprobe/tracepoint/fentry), there may still be lock ordering
> problems for internal locks in kmalloc() or trie->lock itself.
>
> To eliminate these potential lock ordering problems with kmalloc()'s
> internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equivalent
> BPF memory allocator APIs that can be invoked in any context. The lock
> ordering problems with trie->lock (e.g., reentrance) will be handled
> separately.
>
> Three aspects of this change require explanation:
>
> 1. Intermediate and leaf nodes are allocated from the same allocator.
> Since the value size of LPM trie is usually small, using a single
> alocator reduces the memory overhead of the BPF memory allocator.
>
> 2. Leaf nodes are allocated before disabling IRQs. This handles cases
> where leaf_size is large (e.g., > 4KB - 8) and updates require
> intermediate node allocation. If leaf nodes were allocated in
> IRQ-disabled region, the free objects in BPF memory allocator would not
> be refilled timely and the intermediate node allocation may fail.
>
> 3. Paired migrate_{disable|enable}() calls for node alloc and free. The
> BPF memory allocator uses per-CPU struct internally, these paired calls
> are necessary to guarantee correctness.
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 9ba6ae145239..f850360e75ce 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -15,6 +15,7 @@
>  #include <net/ipv6.h>
>  #include <uapi/linux/btf.h>
>  #include <linux/btf_ids.h>
> +#include <linux/bpf_mem_alloc.h>
>
>  /* Intermediate node */
>  #define LPM_TREE_NODE_FLAG_IM BIT(0)
> @@ -22,7 +23,6 @@
>  struct lpm_trie_node;
>
>  struct lpm_trie_node {
> -       struct rcu_head rcu;
>         struct lpm_trie_node __rcu      *child[2];
>         u32                             prefixlen;
>         u32                             flags;
> @@ -32,6 +32,7 @@ struct lpm_trie_node {
>  struct lpm_trie {
>         struct bpf_map                  map;
>         struct lpm_trie_node __rcu      *root;
> +       struct bpf_mem_alloc            ma;
>         size_t                          n_entries;
>         size_t                          max_prefixlen;
>         size_t                          data_size;
> @@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map *map, =
void *_key)

Hey Hao,

We recently got a warning from trie_lookup_elem() triggered by

rcu_dereference_check(trie->root, rcu_read_lock_bh_held())

check in trie_lookup_elem, when LPM trie map was used from a sleepable
BPF program.

It seems like it can be just converted to bpf_rcu_lock_held(), because
with your switch to bpf_mem_alloc all the nodes are now both RCU and
RCU Tasks Trace protected, is my thinking correct?

Can you please double check? Thanks!

[...]

