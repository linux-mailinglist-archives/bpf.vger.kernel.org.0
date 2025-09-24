Return-Path: <bpf+bounces-69639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07BB9C96C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28E816BA7F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6C2BD5A8;
	Wed, 24 Sep 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFVp6Ewz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AC28935A
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756724; cv=none; b=tp3mGhE5/kYJyrRbyhq3mBbjG9f4nAfcNwb3Mjicu9gzNHm/9xfWYiK7T2Cs+83E3qS3Dj/OUKmFbuTa0b6mzUe+l9MKZp3HB5SrXoEhvzNHn+j/0PhF8M09u+kDBJTyCRj3/F5PrFeRtTLK16Zy4QiUFGk/TAIVzXeNcMNF9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756724; c=relaxed/simple;
	bh=lj0l7+BirGeLird5uKbBQD2J7LyQwT1x96rHoasXYLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKuJIJx2MYssjSSd5798vDZq2E16p6vze58fsrpFaUKo9wdQTUH5tXGVjiqGUGYBVJiFlgxpaS3ED/w7NLfLObZqGkAcU1G+4QxbjCL6kfODtyGzQlmuAHz7ZvM+ElnJ929H4+CVs+LxYC1/4KERyyWeXgwegGkiE4dQvCJiDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFVp6Ewz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304a57d842so308689a91.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756721; x=1759361521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiTWBIBBubRN9otW82Nfq+sKRJTpI0EqqY5OOcEQf2Q=;
        b=BFVp6EwzKhDaJzP68rfSoK46nAEw0DTEg4+ud/XW+LDK2JfKH15wid5AoGcrUPwIT3
         H2Bry82c9G2TWYg8SFj5W3+lUhBEt+Boi9rBIvKtxH51thQM3AZXzJSkVuHEPmQhYoPU
         VAJGHlBRqFy2nE2DcI9Yi3icRa01FBDsyiK0RJyLmiQDIHtOrHgFRuQxXYC4DXE62h3K
         XbGD6ucCSoqTuW2xhQmu1ER/F3AZUYScvaEryfDuJb784/8a0VhXTowiQxSfy4H1ooCc
         OlZvaUA3SRShds2JLiuQVOL8r0mlnppcpsoGVAMX8PAbgsm/PvbZidoo6Vnx25FUgQ6m
         Cp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756721; x=1759361521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiTWBIBBubRN9otW82Nfq+sKRJTpI0EqqY5OOcEQf2Q=;
        b=hdm08ZpUEqiAKEMd7pR6hjePAIKjxwofaIgU2/yoZ8r5/jtFqgVyCZK6UzdgEzudbd
         w1k8PKF4xsWeHVkz9lVivkkDwvltHzXgVmJrX3S8FAE7VsnyzyjQQS0nnLTfAedRl/gq
         /BiOKB1Hk5SXrRYCaPT/6ngLbN5uocK5JZAL0orZYYwasDTfzT9Yi7CA6FYMK9dzGdpv
         JmrRe8HlfmUivWxBRXgdjt1eqDEtHBqnDtJRWRhCCI+yOstco1/Io40zjDgGZA/ESp5X
         orM3vO0tsXJevqpE1JYDpqTDRCaCyQiUalu6DCmFvRnuNgEMRH9YmXGfi7tyuGlxDcvN
         N+9Q==
X-Gm-Message-State: AOJu0YwV7g527ObNHLbe5BDM7nZp8c4iynnRzBcWNL70yrnpLc6nArUt
	4jfH1cGhgGGjf0RfaFjGf9uquqX7WD3+TbGG+uTGU4IDcj3QT1FANvFt9hlryhp+ctKKOY3pK1m
	82yQbRfkOWOzWFFvwzdMRXLQAkfL9wGmACtUJ
X-Gm-Gg: ASbGnctuyn41Ce9DJF6FGHSgpgD/fVD4Ej7r75QNv5dTpowAOKnmfjEyRWkOe2pKgRk
	zENCiIsYuI1moc+OHuf5IqvMri6z9uXdideNf5RlAAW9aQpbr7HY1w3Z7piMe04//wAX6V97p4b
	QYuxb+hWfnp0jLp89aUIQtyvGGUrxXeKKi62XylSVTC7nsmJAj3i6DZWPeQyX7tgv+wDotkzy58
	8/wdodXogSC/SQ0Knnu31k=
X-Google-Smtp-Source: AGHT+IFhje/9sAekI5tk0xeEntxW8MrBDpXx/OUEUczfAzEwhCYbRX3VdotbHU16o3NlcUZkJBdbYDypo7SG/y/pgm8=
X-Received: by 2002:a17:90b:4d88:b0:32d:d714:b3eb with SMTP id
 98e67ed59e1d1-3342a2437b9mr1453033a91.4.1758756721092; Wed, 24 Sep 2025
 16:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
 <20241206110622.1161752-7-houtao@huaweicloud.com> <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
 <acebb5f8-d669-5fa7-aad5-41f6ec508609@huaweicloud.com>
In-Reply-To: <acebb5f8-d669-5fa7-aad5-41f6ec508609@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 16:31:46 -0700
X-Gm-Features: AS18NWDcIjgKXGXqJyyMH8F2JacFLnHKys_BX1QZYla5DH6W4k2IGWxQDX4l71I
Message-ID: <CAEf4BzaoP-aL1EABf9G=StReMxhVL=5JUJNDKOPDOg-9=+-m5A@mail.gmail.com>
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

On Mon, Sep 22, 2025 at 6:33=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 9/20/2025 5:28 AM, Andrii Nakryiko wrote:
> > On Fri, Dec 6, 2024 at 2:54=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Multiple syzbot warnings have been reported. These warnings are mainly
> >> about the lock order between trie->lock and kmalloc()'s internal lock.
> >> See report [1] as an example:
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> WARNING: possible circular locking dependency detected
> >> 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
> >> ------------------------------------------------------
> >> syz.3.2069/15008 is trying to acquire lock:
> >> ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node ...
> >>
> >> but task is already holding lock:
> >> ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ...
> >>
> >> which lock already depends on the new lock.
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #1 (&trie->lock){-.-.}-{2:2}:
> >>        __raw_spin_lock_irqsave
> >>        _raw_spin_lock_irqsave+0x3a/0x60
> >>        trie_delete_elem+0xb0/0x820
> >>        ___bpf_prog_run+0x3e51/0xabd0
> >>        __bpf_prog_run32+0xc1/0x100
> >>        bpf_dispatcher_nop_func
> >>        ......
> >>        bpf_trace_run2+0x231/0x590
> >>        __bpf_trace_contention_end+0xca/0x110
> >>        trace_contention_end.constprop.0+0xea/0x170
> >>        __pv_queued_spin_lock_slowpath+0x28e/0xcc0
> >>        pv_queued_spin_lock_slowpath
> >>        queued_spin_lock_slowpath
> >>        queued_spin_lock
> >>        do_raw_spin_lock+0x210/0x2c0
> >>        __raw_spin_lock_irqsave
> >>        _raw_spin_lock_irqsave+0x42/0x60
> >>        __put_partials+0xc3/0x170
> >>        qlink_free
> >>        qlist_free_all+0x4e/0x140
> >>        kasan_quarantine_reduce+0x192/0x1e0
> >>        __kasan_slab_alloc+0x69/0x90
> >>        kasan_slab_alloc
> >>        slab_post_alloc_hook
> >>        slab_alloc_node
> >>        kmem_cache_alloc_node_noprof+0x153/0x310
> >>        __alloc_skb+0x2b1/0x380
> >>        ......
> >>
> >> -> #0 (&n->list_lock){-.-.}-{2:2}:
> >>        check_prev_add
> >>        check_prevs_add
> >>        validate_chain
> >>        __lock_acquire+0x2478/0x3b30
> >>        lock_acquire
> >>        lock_acquire+0x1b1/0x560
> >>        __raw_spin_lock_irqsave
> >>        _raw_spin_lock_irqsave+0x3a/0x60
> >>        get_partial_node.part.0+0x20/0x350
> >>        get_partial_node
> >>        get_partial
> >>        ___slab_alloc+0x65b/0x1870
> >>        __slab_alloc.constprop.0+0x56/0xb0
> >>        __slab_alloc_node
> >>        slab_alloc_node
> >>        __do_kmalloc_node
> >>        __kmalloc_node_noprof+0x35c/0x440
> >>        kmalloc_node_noprof
> >>        bpf_map_kmalloc_node+0x98/0x4a0
> >>        lpm_trie_node_alloc
> >>        trie_update_elem+0x1ef/0xe00
> >>        bpf_map_update_value+0x2c1/0x6c0
> >>        map_update_elem+0x623/0x910
> >>        __sys_bpf+0x90c/0x49a0
> >>        ...
> >>
> >> other info that might help us debug this:
> >>
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(&trie->lock);
> >>                                lock(&n->list_lock);
> >>                                lock(&trie->lock);
> >>   lock(&n->list_lock);
> >>
> >>  *** DEADLOCK ***
> >>
> >> [1]: https://syzkaller.appspot.com/bug?extid=3D9045c0a3d5a7f1b119f7
> >>
> >> A bpf program attached to trace_contention_end() triggers after
> >> acquiring &n->list_lock. The program invokes trie_delete_elem(), which
> >> then acquires trie->lock. However, it is possible that another
> >> process is invoking trie_update_elem(). trie_update_elem() will acquir=
e
> >> trie->lock first, then invoke kmalloc_node(). kmalloc_node() may invok=
e
> >> get_partial_node() and try to acquire &n->list_lock (not necessarily t=
he
> >> same lock object). Therefore, lockdep warns about the circular locking
> >> dependency.
> >>
> >> Invoking kmalloc() before acquiring trie->lock could fix the warning.
> >> However, since BPF programs call be invoked from any context (e.g.,
> >> through kprobe/tracepoint/fentry), there may still be lock ordering
> >> problems for internal locks in kmalloc() or trie->lock itself.
> >>
> >> To eliminate these potential lock ordering problems with kmalloc()'s
> >> internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equivalen=
t
> >> BPF memory allocator APIs that can be invoked in any context. The lock
> >> ordering problems with trie->lock (e.g., reentrance) will be handled
> >> separately.
> >>
> >> Three aspects of this change require explanation:
> >>
> >> 1. Intermediate and leaf nodes are allocated from the same allocator.
> >> Since the value size of LPM trie is usually small, using a single
> >> alocator reduces the memory overhead of the BPF memory allocator.
> >>
> >> 2. Leaf nodes are allocated before disabling IRQs. This handles cases
> >> where leaf_size is large (e.g., > 4KB - 8) and updates require
> >> intermediate node allocation. If leaf nodes were allocated in
> >> IRQ-disabled region, the free objects in BPF memory allocator would no=
t
> >> be refilled timely and the intermediate node allocation may fail.
> >>
> >> 3. Paired migrate_{disable|enable}() calls for node alloc and free. Th=
e
> >> BPF memory allocator uses per-CPU struct internally, these paired call=
s
> >> are necessary to guarantee correctness.
> >>
> >> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++-------------=
-
> >>  1 file changed, 48 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> >> index 9ba6ae145239..f850360e75ce 100644
> >> --- a/kernel/bpf/lpm_trie.c
> >> +++ b/kernel/bpf/lpm_trie.c
> >> @@ -15,6 +15,7 @@
> >>  #include <net/ipv6.h>
> >>  #include <uapi/linux/btf.h>
> >>  #include <linux/btf_ids.h>
> >> +#include <linux/bpf_mem_alloc.h>
> >>
> >>  /* Intermediate node */
> >>  #define LPM_TREE_NODE_FLAG_IM BIT(0)
> >> @@ -22,7 +23,6 @@
> >>  struct lpm_trie_node;
> >>
> >>  struct lpm_trie_node {
> >> -       struct rcu_head rcu;
> >>         struct lpm_trie_node __rcu      *child[2];
> >>         u32                             prefixlen;
> >>         u32                             flags;
> >> @@ -32,6 +32,7 @@ struct lpm_trie_node {
> >>  struct lpm_trie {
> >>         struct bpf_map                  map;
> >>         struct lpm_trie_node __rcu      *root;
> >> +       struct bpf_mem_alloc            ma;
> >>         size_t                          n_entries;
> >>         size_t                          max_prefixlen;
> >>         size_t                          data_size;
> >> @@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map *ma=
p, void *_key)
> > Hey Hao,
>
> Hi Andrii,
>
> Actually my name is Hou Tao :)

Oops, I'm sorry for butchering your name, Hou!

> >
> > We recently got a warning from trie_lookup_elem() triggered by
> >
> > rcu_dereference_check(trie->root, rcu_read_lock_bh_held())
> >
> > check in trie_lookup_elem, when LPM trie map was used from a sleepable
> > BPF program.
> >
> > It seems like it can be just converted to bpf_rcu_lock_held(), because
> > with your switch to bpf_mem_alloc all the nodes are now both RCU and
> > RCU Tasks Trace protected, is my thinking correct?
> >
> > Can you please double check? Thanks!
>
> No. Although the node is freed after one RCU GP and one RCU Task Trace
> GP, the reuse of node happens after one RCU GP. Therefore, for the
> sleepable program when it looks up the trie, it may find and try to read
> a reused node, the returned result will be unexpected due to the reuse.
>

That's two different things, no? Because we do lookup without lock,
it's possible for (non-sleepable or sleepable, doesn't matter) BPF
program to update/delete trie node while some other BPF program looks
it up without locking. I don't think anything fundamentally changes
here. We have similar behavior for other BPF maps (hashmap, for
example), regardless of sleepable or not.

But the problem here is specifically about overly eager
rcu_dereference_check check. That memory is not going to be freed, so
it's "safe" to dereference it, even if it might be reused for another
node.

Either that, or we need to disable LPM trie map for sleepable until we
somehow fix this memory reuse, no?

> >
> > [...]
>

