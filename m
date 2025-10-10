Return-Path: <bpf+bounces-70755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F38BCE087
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40B674F936B
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE752144CF;
	Fri, 10 Oct 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8jRE7Fp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB821019E
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115865; cv=none; b=gDLAUhGJ5IWNVAzKrJ6Cw/eigxyLUHr6uQj94Y+8aKhK9UYk0hRvh2lkgVZYiXI+GQ2R1NkKig3j97993wWYMsZEY53GPHcr1g1bxhTt8wEGWxL+JWlL18ZVuKgPfZUTQgcHlYvguvXRr6N7eUMaBo5eyxYJAL787hnUtJrSTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115865; c=relaxed/simple;
	bh=snUHAHTbKXCJ8ho4O0paiXMzF2WwmONvtkFyiC3PpNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwaPHF10gL+/4UXVNmD6hJlk/K/+S+ZS+GGYaB+nHyNL4KG3TlpA2V/QVLnxHqJGtwYCbCKi58JhNs0FvM1GW5SZr1b8OK6hi0k9H0HFl+6adR2r5nFuw3gscMJuMG26DUZ/oPKVE3YIFEzEWrTjkH5Tnsi0khPirQS8zGNyDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8jRE7Fp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2118992a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760115863; x=1760720663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C5FPBnGs6eCoFCoDNtFqzg7IcnJsqvjEp65pfaCvb4=;
        b=U8jRE7FpQi+Icz8dYuuKRTFGaN0Qt9dUUjeagthnX67i0Xb0j4dhTAQM8X2cnUnmJO
         Clv7jWX1UXsrukgvjJoqimxFfweqmTm91Bul0bWksBzMf6czbJAG3adgPQRDwbT1kI7K
         wzK+560xSil3OEtyfVy8CDH+50fM1gKCnTbROCSu8S0DAdlY12yS6c+7PziUhsfc29us
         BPIksmCKMAlQowvRXZzoX6Vo41XWiLxrLvhQjICMS07cvWdRxs9Ip39nQnl/YKNm5rnU
         /3K5dKJNwdnAofx7IAWPSzWSu6ViwPkROAc9CRm3RCaUs2fBwv+NgJNyNzx+U8NK7wv6
         ycZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115863; x=1760720663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C5FPBnGs6eCoFCoDNtFqzg7IcnJsqvjEp65pfaCvb4=;
        b=HlJ+uWT/vbBZ4jvuuXSQ4g+jVf1o2ejkb+odueDlR3CjVLYlspqu4sIRtqmVnNED/P
         YNl1+2ZdhFW9+Yrlx92PzaVnoxeh+3tvnKzeY85bFkZKSqebMWwrUw0Z1IjdZOLHNxdg
         cOMm6NrMFX/s9IxXONWl4VURiMrCHmSDljqoHt9sZuFLxbm66Z9XMWbwgIvPuvUsXqch
         dFQOJz23GCoqwRwDt4fsatqHxYfn2IpxuA8R0R4ta5ZjfjifES8AO1T3QgTiZoPNSXqF
         HTTELdln51igYWWwR7Q/hE7B96iCHcoxzg58PDhZoLuP9Vyqo6vrjITsBvOEQf4RIJ/T
         IJ8A==
X-Gm-Message-State: AOJu0Yz2VBoeWPr9gs+uwzMeTYmihEsDyt7ZKqFDT3dGgdN1Vay1P5pV
	LAwin0C/LMpwJuzikhH0yUm1seNqYMkrk1XvsE+5PSIcR+XDNOxbWANPOME6v9bWw7JonNx4R9B
	i+lC+ambkgY6UxdhS+LO03RUZw+vPFyM=
X-Gm-Gg: ASbGncuiza0GAGsjQL9XN7WdTkDVapxODMmOML0DvN6GiyL2P+sf1odprtoUEIDComH
	IHBYVPYDUhjIw0LwLuTWMg29sC2QmCkatY846A1BpBABfcOAVqXc6qO834Cp5C5mCS1BVmVuZ8J
	Stns0j/RRpc+HHY5YCu/+TKYIw3Vl+C3i2Zb+HTfCBKCgzSiLayqK/yS2cAknVo7x687skFXl0b
	KmV5QSzp1hiASO4nJ1v4HcxDCeA/L3m0YZnU/gFEn+aiPJhS+sg
X-Google-Smtp-Source: AGHT+IH7TkAGeVvQiABe0haNC1rzIVoEhWsxLx0c2OolQXqUvJNq0PO+fJG9j9IJ2EDcCnjKg3S+GstCG6p94v6Fz7Y=
X-Received: by 2002:a17:90b:3911:b0:338:2ef8:14af with SMTP id
 98e67ed59e1d1-33b513bee03mr15677623a91.37.1760115862603; Fri, 10 Oct 2025
 10:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
 <20241206110622.1161752-7-houtao@huaweicloud.com> <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
 <acebb5f8-d669-5fa7-aad5-41f6ec508609@huaweicloud.com> <CAEf4BzaoP-aL1EABf9G=StReMxhVL=5JUJNDKOPDOg-9=+-m5A@mail.gmail.com>
In-Reply-To: <CAEf4BzaoP-aL1EABf9G=StReMxhVL=5JUJNDKOPDOg-9=+-m5A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Oct 2025 10:04:08 -0700
X-Gm-Features: AS18NWC53r7v6SOFwy-J6dA2mejFgAue1cu1FBmLElQBQtz-2PhFfJEos8yOHek
Message-ID: <CAEf4Bza_QBPpxE-OX03eCo0+r1hC9iNVXW91cRzSmOr-qnh99A@mail.gmail.com>
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

On Wed, Sep 24, 2025 at 4:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 22, 2025 at 6:33=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > On 9/20/2025 5:28 AM, Andrii Nakryiko wrote:
> > > On Fri, Dec 6, 2024 at 2:54=E2=80=AFAM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> > >> From: Hou Tao <houtao1@huawei.com>
> > >>
> > >> Multiple syzbot warnings have been reported. These warnings are main=
ly
> > >> about the lock order between trie->lock and kmalloc()'s internal loc=
k.
> > >> See report [1] as an example:
> > >>
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >> WARNING: possible circular locking dependency detected
> > >> 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
> > >> ------------------------------------------------------
> > >> syz.3.2069/15008 is trying to acquire lock:
> > >> ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node .=
..
> > >>
> > >> but task is already holding lock:
> > >> ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ...
> > >>
> > >> which lock already depends on the new lock.
> > >>
> > >> the existing dependency chain (in reverse order) is:
> > >>
> > >> -> #1 (&trie->lock){-.-.}-{2:2}:
> > >>        __raw_spin_lock_irqsave
> > >>        _raw_spin_lock_irqsave+0x3a/0x60
> > >>        trie_delete_elem+0xb0/0x820
> > >>        ___bpf_prog_run+0x3e51/0xabd0
> > >>        __bpf_prog_run32+0xc1/0x100
> > >>        bpf_dispatcher_nop_func
> > >>        ......
> > >>        bpf_trace_run2+0x231/0x590
> > >>        __bpf_trace_contention_end+0xca/0x110
> > >>        trace_contention_end.constprop.0+0xea/0x170
> > >>        __pv_queued_spin_lock_slowpath+0x28e/0xcc0
> > >>        pv_queued_spin_lock_slowpath
> > >>        queued_spin_lock_slowpath
> > >>        queued_spin_lock
> > >>        do_raw_spin_lock+0x210/0x2c0
> > >>        __raw_spin_lock_irqsave
> > >>        _raw_spin_lock_irqsave+0x42/0x60
> > >>        __put_partials+0xc3/0x170
> > >>        qlink_free
> > >>        qlist_free_all+0x4e/0x140
> > >>        kasan_quarantine_reduce+0x192/0x1e0
> > >>        __kasan_slab_alloc+0x69/0x90
> > >>        kasan_slab_alloc
> > >>        slab_post_alloc_hook
> > >>        slab_alloc_node
> > >>        kmem_cache_alloc_node_noprof+0x153/0x310
> > >>        __alloc_skb+0x2b1/0x380
> > >>        ......
> > >>
> > >> -> #0 (&n->list_lock){-.-.}-{2:2}:
> > >>        check_prev_add
> > >>        check_prevs_add
> > >>        validate_chain
> > >>        __lock_acquire+0x2478/0x3b30
> > >>        lock_acquire
> > >>        lock_acquire+0x1b1/0x560
> > >>        __raw_spin_lock_irqsave
> > >>        _raw_spin_lock_irqsave+0x3a/0x60
> > >>        get_partial_node.part.0+0x20/0x350
> > >>        get_partial_node
> > >>        get_partial
> > >>        ___slab_alloc+0x65b/0x1870
> > >>        __slab_alloc.constprop.0+0x56/0xb0
> > >>        __slab_alloc_node
> > >>        slab_alloc_node
> > >>        __do_kmalloc_node
> > >>        __kmalloc_node_noprof+0x35c/0x440
> > >>        kmalloc_node_noprof
> > >>        bpf_map_kmalloc_node+0x98/0x4a0
> > >>        lpm_trie_node_alloc
> > >>        trie_update_elem+0x1ef/0xe00
> > >>        bpf_map_update_value+0x2c1/0x6c0
> > >>        map_update_elem+0x623/0x910
> > >>        __sys_bpf+0x90c/0x49a0
> > >>        ...
> > >>
> > >> other info that might help us debug this:
> > >>
> > >>  Possible unsafe locking scenario:
> > >>
> > >>        CPU0                    CPU1
> > >>        ----                    ----
> > >>   lock(&trie->lock);
> > >>                                lock(&n->list_lock);
> > >>                                lock(&trie->lock);
> > >>   lock(&n->list_lock);
> > >>
> > >>  *** DEADLOCK ***
> > >>
> > >> [1]: https://syzkaller.appspot.com/bug?extid=3D9045c0a3d5a7f1b119f7
> > >>
> > >> A bpf program attached to trace_contention_end() triggers after
> > >> acquiring &n->list_lock. The program invokes trie_delete_elem(), whi=
ch
> > >> then acquires trie->lock. However, it is possible that another
> > >> process is invoking trie_update_elem(). trie_update_elem() will acqu=
ire
> > >> trie->lock first, then invoke kmalloc_node(). kmalloc_node() may inv=
oke
> > >> get_partial_node() and try to acquire &n->list_lock (not necessarily=
 the
> > >> same lock object). Therefore, lockdep warns about the circular locki=
ng
> > >> dependency.
> > >>
> > >> Invoking kmalloc() before acquiring trie->lock could fix the warning=
.
> > >> However, since BPF programs call be invoked from any context (e.g.,
> > >> through kprobe/tracepoint/fentry), there may still be lock ordering
> > >> problems for internal locks in kmalloc() or trie->lock itself.
> > >>
> > >> To eliminate these potential lock ordering problems with kmalloc()'s
> > >> internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equival=
ent
> > >> BPF memory allocator APIs that can be invoked in any context. The lo=
ck
> > >> ordering problems with trie->lock (e.g., reentrance) will be handled
> > >> separately.
> > >>
> > >> Three aspects of this change require explanation:
> > >>
> > >> 1. Intermediate and leaf nodes are allocated from the same allocator=
.
> > >> Since the value size of LPM trie is usually small, using a single
> > >> alocator reduces the memory overhead of the BPF memory allocator.
> > >>
> > >> 2. Leaf nodes are allocated before disabling IRQs. This handles case=
s
> > >> where leaf_size is large (e.g., > 4KB - 8) and updates require
> > >> intermediate node allocation. If leaf nodes were allocated in
> > >> IRQ-disabled region, the free objects in BPF memory allocator would =
not
> > >> be refilled timely and the intermediate node allocation may fail.
> > >>
> > >> 3. Paired migrate_{disable|enable}() calls for node alloc and free. =
The
> > >> BPF memory allocator uses per-CPU struct internally, these paired ca=
lls
> > >> are necessary to guarantee correctness.
> > >>
> > >> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >> ---
> > >>  kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++-----------=
---
> > >>  1 file changed, 48 insertions(+), 23 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > >> index 9ba6ae145239..f850360e75ce 100644
> > >> --- a/kernel/bpf/lpm_trie.c
> > >> +++ b/kernel/bpf/lpm_trie.c
> > >> @@ -15,6 +15,7 @@
> > >>  #include <net/ipv6.h>
> > >>  #include <uapi/linux/btf.h>
> > >>  #include <linux/btf_ids.h>
> > >> +#include <linux/bpf_mem_alloc.h>
> > >>
> > >>  /* Intermediate node */
> > >>  #define LPM_TREE_NODE_FLAG_IM BIT(0)
> > >> @@ -22,7 +23,6 @@
> > >>  struct lpm_trie_node;
> > >>
> > >>  struct lpm_trie_node {
> > >> -       struct rcu_head rcu;
> > >>         struct lpm_trie_node __rcu      *child[2];
> > >>         u32                             prefixlen;
> > >>         u32                             flags;
> > >> @@ -32,6 +32,7 @@ struct lpm_trie_node {
> > >>  struct lpm_trie {
> > >>         struct bpf_map                  map;
> > >>         struct lpm_trie_node __rcu      *root;
> > >> +       struct bpf_mem_alloc            ma;
> > >>         size_t                          n_entries;
> > >>         size_t                          max_prefixlen;
> > >>         size_t                          data_size;
> > >> @@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map *=
map, void *_key)
> > > Hey Hao,
> >
> > Hi Andrii,
> >
> > Actually my name is Hou Tao :)
>
> Oops, I'm sorry for butchering your name, Hou!
>
> > >
> > > We recently got a warning from trie_lookup_elem() triggered by
> > >
> > > rcu_dereference_check(trie->root, rcu_read_lock_bh_held())
> > >
> > > check in trie_lookup_elem, when LPM trie map was used from a sleepabl=
e
> > > BPF program.
> > >
> > > It seems like it can be just converted to bpf_rcu_lock_held(), becaus=
e
> > > with your switch to bpf_mem_alloc all the nodes are now both RCU and
> > > RCU Tasks Trace protected, is my thinking correct?
> > >
> > > Can you please double check? Thanks!
> >
> > No. Although the node is freed after one RCU GP and one RCU Task Trace
> > GP, the reuse of node happens after one RCU GP. Therefore, for the
> > sleepable program when it looks up the trie, it may find and try to rea=
d
> > a reused node, the returned result will be unexpected due to the reuse.
> >
>
> That's two different things, no? Because we do lookup without lock,
> it's possible for (non-sleepable or sleepable, doesn't matter) BPF
> program to update/delete trie node while some other BPF program looks
> it up without locking. I don't think anything fundamentally changes
> here. We have similar behavior for other BPF maps (hashmap, for
> example), regardless of sleepable or not.
>
> But the problem here is specifically about overly eager
> rcu_dereference_check check. That memory is not going to be freed, so
> it's "safe" to dereference it, even if it might be reused for another
> node.
>
> Either that, or we need to disable LPM trie map for sleepable until we
> somehow fix this memory reuse, no?

Hey Hou,

So, it's actually more interesting than what I initially thought.
LPM_TRIE is not currently allowed for sleepable programs, but we have
a bug in the verifier where you can sneak in such map into a sleepable
program through map-in-map. It seems like we are missing checking the
inner map for sleepable compatibility.

The question for you is how hard is it to make LPM_TRIE support
sleepable program? You mentioned some unintended memory reused, can
that be fixed/changed? Can you please take a look? Thanks!

>
> > >
> > > [...]
> >

