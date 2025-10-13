Return-Path: <bpf+bounces-70844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF6BD6B81
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB6B4063C0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB7295DA6;
	Mon, 13 Oct 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXld8+fI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E26211F
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397552; cv=none; b=tm+I2E5XRxYzRmvHiXUrHRPDpl4QobnxoE6rVwqM5QdV17VNH50Id0NUJcKeRZmbfCfMbM/efAF2MqdlFSIwupU9zX5XAwjr4FGdcEBpzBxcu/7dwZ7E1AEtmXyDDQpJE8xer4YLbRWUxp5TImNmKSCSy5izWqIT82wzBFvFSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397552; c=relaxed/simple;
	bh=EWvRxqFjr0eLq4mLXGiAw8Ol682tdFNVtgkWR8aDgOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXe5PI3/5SFUhPez4bHhqaROQQ34k+pYgwjmEuSF6MNtgberADfHbkCo70Igg0zy8P4KewXtkvCnZjnf88tj5cKVUyP6q8Jkb0ga4P37S/au/6pqfBaBiydBkTS6a4H9keeeRM+gwVT4dmaktBAAdiWabMUEDZts0ansaN7GCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXld8+fI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3734334b3a.2
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760397550; x=1761002350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYbAvTxr8HE4n8CRrjWMtPJcwuMvvZUoLZpGLOD9c4w=;
        b=WXld8+fI2DujAEYKpZFzF/4uhz9/IYlBQ/hJiUEMxFLqpOsiuSsd8SSWwTqa/kHyPm
         5V96U+n17QCKR+JaB0meI8hLpA807jWxqkjWG+lrbZXkXYP513+Z1NxqsR0tjDLDvoiJ
         pIMVUKk7F27AJUQY9J0id6HM+pg5lIENiC9TwE7pKeBrn2VWhN449YeLGhwjRlrVQgrP
         dehZzHSUXNqaaSANUOHJm6TodG2jpIy38lgg5hNXsYSdfGK/fNegV/yr++TrRtV7erqq
         rVaoCQy+Jky65E/sCDmYtPx1s2ADMeFhe1zP391u3VJg5cftA5/iGGB9RmLAVFlFdk6Q
         z7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760397550; x=1761002350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYbAvTxr8HE4n8CRrjWMtPJcwuMvvZUoLZpGLOD9c4w=;
        b=M08hHUtG32MoFjuew9pfVdiEvJTQfU5crguybclMy25fee+zHK+YgRVgw8+mKhBOSA
         wivCYyT8fPBvb0ZNNwHU8B464jcfPffzxtrTyl06fzNr+i7qituEE7Akejo2PRIJB5o5
         8AKPoD+deyCFljxivkFEVyEEHl02Np1vfazavsOUKtzYSZPiQeHzVEiOYXRKX0u9qui4
         wENNIrAA81drJM0gS8kCyxIIWinH7JMXnI57qPNsIlA3MB3CY6eWxwjZTEWQcNceA1Iu
         tjgtbOF8ll2h2/SFL1pyFlUfL7W7iYV7S7uMm2/8JQyC99/EDsJKAB2w+/NLDU5waT8N
         TubA==
X-Gm-Message-State: AOJu0YxUXaqsDrX989Xx9DnCOoirr6KxUp6F/ZFR49nHBWpmWyKxQg5Z
	KTDpd0cNbM3ft7XBJSr30NoIwZr9Nqd6Vsq40YhsGEWMd0l1HvU/eKKVoEXsB6F95g2Z5oUUEsb
	E6j8Z8j5EtO07hUJfK3bVpSLruLLlkN8=
X-Gm-Gg: ASbGncv6dJsHcN8/RSyZ2j9OxmPCKgk4Ex9Zffon54fok+0S3MXzZ/oqcUlFf4yplXp
	VSJwYVDDiKZOdw+5waq1tOLAgTDHzrcQZo6AQ2OYrWYwvxUiiu62VLVR+WF+w3zjrz9mmig6zHt
	PfOn1rZyF8o6zQGCOdRAFNl86QAKoqAFfI5/3g5Ln+LAg/cJezLIJEQBokWrK+HaI0doMHHqWKx
	24F+1njdZanIVjzjfi/4/mz+Imo4KyLjj+nHOobpws0NCyZvUW6
X-Google-Smtp-Source: AGHT+IFsPHFjNmUUHwF4UXzMlAb+/d1B8Cr/NPVeHiVh3HCYwE1hDl5ZSMw2DNXPGslJK6LA/kL8jhwSLa4LCNZCmDM=
X-Received: by 2002:a17:90b:1b11:b0:330:7f80:bbd9 with SMTP id
 98e67ed59e1d1-33b5139a422mr29378172a91.31.1760397549977; Mon, 13 Oct 2025
 16:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
 <20241206110622.1161752-7-houtao@huaweicloud.com> <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
 <acebb5f8-d669-5fa7-aad5-41f6ec508609@huaweicloud.com> <CAEf4BzaoP-aL1EABf9G=StReMxhVL=5JUJNDKOPDOg-9=+-m5A@mail.gmail.com>
 <CAEf4Bza_QBPpxE-OX03eCo0+r1hC9iNVXW91cRzSmOr-qnh99A@mail.gmail.com> <6e513e88-747b-e0b1-3c43-b2491830a764@huaweicloud.com>
In-Reply-To: <6e513e88-747b-e0b1-3c43-b2491830a764@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 16:18:52 -0700
X-Gm-Features: AS18NWAz0DwzSkBD7fGSvQCkjDHAlaZp4SB5jAw5NdPu-qiTiplFVwaI7jYVeos
Message-ID: <CAEf4BzZFA4K1c6j7v8qXD_5fvccwcMN0k7oaF67wOYqQTtq0JA@mail.gmail.com>
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

On Sun, Oct 12, 2025 at 5:59=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Andrii,
>
> On 10/11/2025 1:04 AM, Andrii Nakryiko wrote:
> > On Wed, Sep 24, 2025 at 4:31=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Mon, Sep 22, 2025 at 6:33=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>>
> >>>
> >>> On 9/20/2025 5:28 AM, Andrii Nakryiko wrote:
> >>>> On Fri, Dec 6, 2024 at 2:54=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>
> >>>>> Multiple syzbot warnings have been reported. These warnings are mai=
nly
> >>>>> about the lock order between trie->lock and kmalloc()'s internal lo=
ck.
> >>>>> See report [1] as an example:
> >>>>>
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>>>> WARNING: possible circular locking dependency detected
> >>>>> 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
> >>>>> ------------------------------------------------------
> >>>>> syz.3.2069/15008 is trying to acquire lock:
> >>>>> ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node =
...
> >>>>>
> >>>>> but task is already holding lock:
> >>>>> ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ..=
.
> >>>>>
> >>>>> which lock already depends on the new lock.
> >>>>>
> >>>>> the existing dependency chain (in reverse order) is:
> >>>>>
> >>>>> -> #1 (&trie->lock){-.-.}-{2:2}:
> >>>>>        __raw_spin_lock_irqsave
> >>>>>        _raw_spin_lock_irqsave+0x3a/0x60
> >>>>>        trie_delete_elem+0xb0/0x820
> >>>>>        ___bpf_prog_run+0x3e51/0xabd0
> >>>>>        __bpf_prog_run32+0xc1/0x100
> >>>>>        bpf_dispatcher_nop_func
> >>>>>        ......
> >>>>>        bpf_trace_run2+0x231/0x590
> >>>>>        __bpf_trace_contention_end+0xca/0x110
> >>>>>        trace_contention_end.constprop.0+0xea/0x170
> >>>>>        __pv_queued_spin_lock_slowpath+0x28e/0xcc0
> >>>>>        pv_queued_spin_lock_slowpath
> >>>>>        queued_spin_lock_slowpath
> >>>>>        queued_spin_lock
> >>>>>        do_raw_spin_lock+0x210/0x2c0
> >>>>>        __raw_spin_lock_irqsave
> >>>>>        _raw_spin_lock_irqsave+0x42/0x60
> >>>>>        __put_partials+0xc3/0x170
> >>>>>        qlink_free
> >>>>>        qlist_free_all+0x4e/0x140
> >>>>>        kasan_quarantine_reduce+0x192/0x1e0
> >>>>>        __kasan_slab_alloc+0x69/0x90
> >>>>>        kasan_slab_alloc
> >>>>>        slab_post_alloc_hook
> >>>>>        slab_alloc_node
> >>>>>        kmem_cache_alloc_node_noprof+0x153/0x310
> >>>>>        __alloc_skb+0x2b1/0x380
> >>>>>        ......
> >>>>>
> >>>>> -> #0 (&n->list_lock){-.-.}-{2:2}:
> >>>>>        check_prev_add
> >>>>>        check_prevs_add
> >>>>>        validate_chain
> >>>>>        __lock_acquire+0x2478/0x3b30
> >>>>>        lock_acquire
> >>>>>        lock_acquire+0x1b1/0x560
> >>>>>        __raw_spin_lock_irqsave
> >>>>>        _raw_spin_lock_irqsave+0x3a/0x60
> >>>>>        get_partial_node.part.0+0x20/0x350
> >>>>>        get_partial_node
> >>>>>        get_partial
> >>>>>        ___slab_alloc+0x65b/0x1870
> >>>>>        __slab_alloc.constprop.0+0x56/0xb0
> >>>>>        __slab_alloc_node
> >>>>>        slab_alloc_node
> >>>>>        __do_kmalloc_node
> >>>>>        __kmalloc_node_noprof+0x35c/0x440
> >>>>>        kmalloc_node_noprof
> >>>>>        bpf_map_kmalloc_node+0x98/0x4a0
> >>>>>        lpm_trie_node_alloc
> >>>>>        trie_update_elem+0x1ef/0xe00
> >>>>>        bpf_map_update_value+0x2c1/0x6c0
> >>>>>        map_update_elem+0x623/0x910
> >>>>>        __sys_bpf+0x90c/0x49a0
> >>>>>        ...
> >>>>>
> >>>>> other info that might help us debug this:
> >>>>>
> >>>>>  Possible unsafe locking scenario:
> >>>>>
> >>>>>        CPU0                    CPU1
> >>>>>        ----                    ----
> >>>>>   lock(&trie->lock);
> >>>>>                                lock(&n->list_lock);
> >>>>>                                lock(&trie->lock);
> >>>>>   lock(&n->list_lock);
> >>>>>
> >>>>>  *** DEADLOCK ***
> >>>>>
> >>>>> [1]: https://syzkaller.appspot.com/bug?extid=3D9045c0a3d5a7f1b119f7
> >>>>>
> >>>>> A bpf program attached to trace_contention_end() triggers after
> >>>>> acquiring &n->list_lock. The program invokes trie_delete_elem(), wh=
ich
> >>>>> then acquires trie->lock. However, it is possible that another
> >>>>> process is invoking trie_update_elem(). trie_update_elem() will acq=
uire
> >>>>> trie->lock first, then invoke kmalloc_node(). kmalloc_node() may in=
voke
> >>>>> get_partial_node() and try to acquire &n->list_lock (not necessaril=
y the
> >>>>> same lock object). Therefore, lockdep warns about the circular lock=
ing
> >>>>> dependency.
> >>>>>
> >>>>> Invoking kmalloc() before acquiring trie->lock could fix the warnin=
g.
> >>>>> However, since BPF programs call be invoked from any context (e.g.,
> >>>>> through kprobe/tracepoint/fentry), there may still be lock ordering
> >>>>> problems for internal locks in kmalloc() or trie->lock itself.
> >>>>>
> >>>>> To eliminate these potential lock ordering problems with kmalloc()'=
s
> >>>>> internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equiva=
lent
> >>>>> BPF memory allocator APIs that can be invoked in any context. The l=
ock
> >>>>> ordering problems with trie->lock (e.g., reentrance) will be handle=
d
> >>>>> separately.
> >>>>>
> >>>>> Three aspects of this change require explanation:
> >>>>>
> >>>>> 1. Intermediate and leaf nodes are allocated from the same allocato=
r.
> >>>>> Since the value size of LPM trie is usually small, using a single
> >>>>> alocator reduces the memory overhead of the BPF memory allocator.
> >>>>>
> >>>>> 2. Leaf nodes are allocated before disabling IRQs. This handles cas=
es
> >>>>> where leaf_size is large (e.g., > 4KB - 8) and updates require
> >>>>> intermediate node allocation. If leaf nodes were allocated in
> >>>>> IRQ-disabled region, the free objects in BPF memory allocator would=
 not
> >>>>> be refilled timely and the intermediate node allocation may fail.
> >>>>>
> >>>>> 3. Paired migrate_{disable|enable}() calls for node alloc and free.=
 The
> >>>>> BPF memory allocator uses per-CPU struct internally, these paired c=
alls
> >>>>> are necessary to guarantee correctness.
> >>>>>
> >>>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>> ---
> >>>>>  kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++----------=
----
> >>>>>  1 file changed, 48 insertions(+), 23 deletions(-)
> >>>>>
> >>>>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> >>>>> index 9ba6ae145239..f850360e75ce 100644
> >>>>> --- a/kernel/bpf/lpm_trie.c
> >>>>> +++ b/kernel/bpf/lpm_trie.c
> >>>>> @@ -15,6 +15,7 @@
> >>>>>  #include <net/ipv6.h>
> >>>>>  #include <uapi/linux/btf.h>
> >>>>>  #include <linux/btf_ids.h>
> >>>>> +#include <linux/bpf_mem_alloc.h>
> >>>>>
> >>>>>  /* Intermediate node */
> >>>>>  #define LPM_TREE_NODE_FLAG_IM BIT(0)
> >>>>> @@ -22,7 +23,6 @@
> >>>>>  struct lpm_trie_node;
> >>>>>
> >>>>>  struct lpm_trie_node {
> >>>>> -       struct rcu_head rcu;
> >>>>>         struct lpm_trie_node __rcu      *child[2];
> >>>>>         u32                             prefixlen;
> >>>>>         u32                             flags;
> >>>>> @@ -32,6 +32,7 @@ struct lpm_trie_node {
> >>>>>  struct lpm_trie {
> >>>>>         struct bpf_map                  map;
> >>>>>         struct lpm_trie_node __rcu      *root;
> >>>>> +       struct bpf_mem_alloc            ma;
> >>>>>         size_t                          n_entries;
> >>>>>         size_t                          max_prefixlen;
> >>>>>         size_t                          data_size;
> >>>>> @@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map =
*map, void *_key)
> >>>> Hey Hao,
> >>> Hi Andrii,
> >>>
> >>> Actually my name is Hou Tao :)
> >> Oops, I'm sorry for butchering your name, Hou!
> >>
> >>>> We recently got a warning from trie_lookup_elem() triggered by
> >>>>
> >>>> rcu_dereference_check(trie->root, rcu_read_lock_bh_held())
> >>>>
> >>>> check in trie_lookup_elem, when LPM trie map was used from a sleepab=
le
> >>>> BPF program.
> >>>>
> >>>> It seems like it can be just converted to bpf_rcu_lock_held(), becau=
se
> >>>> with your switch to bpf_mem_alloc all the nodes are now both RCU and
> >>>> RCU Tasks Trace protected, is my thinking correct?
> >>>>
> >>>> Can you please double check? Thanks!
> >>> No. Although the node is freed after one RCU GP and one RCU Task Trac=
e
> >>> GP, the reuse of node happens after one RCU GP. Therefore, for the
> >>> sleepable program when it looks up the trie, it may find and try to r=
ead
> >>> a reused node, the returned result will be unexpected due to the reus=
e.
> >>>
>
> Sorry for the delayed response.
> >> That's two different things, no? Because we do lookup without lock,
> >> it's possible for (non-sleepable or sleepable, doesn't matter) BPF
> >> program to update/delete trie node while some other BPF program looks
> >> it up without locking. I don't think anything fundamentally changes
> >> here. We have similar behavior for other BPF maps (hashmap, for
> >> example), regardless of sleepable or not.
> >>
> >> But the problem here is specifically about overly eager
> >> rcu_dereference_check check. That memory is not going to be freed, so
> >> it's "safe" to dereference it, even if it might be reused for another
> >> node.
> >>
> >> Either that, or we need to disable LPM trie map for sleepable until we
> >> somehow fix this memory reuse, no?
> > Hey Hou,
> >
> > So, it's actually more interesting than what I initially thought.
> > LPM_TRIE is not currently allowed for sleepable programs, but we have
> > a bug in the verifier where you can sneak in such map into a sleepable
> > program through map-in-map. It seems like we are missing checking the
> > inner map for sleepable compatibility.
> >
> > The question for you is how hard is it to make LPM_TRIE support
> > sleepable program? You mentioned some unintended memory reused, can
> > that be fixed/changed? Can you please take a look? Thanks!
>
> Instead of updating LPM_TRIE to handle memory reuse, why not use
> bpf_rcu_read_lock/bpf_rcu_read_unlock to ensure the reuse will not
> happen during the lookup ?

That should work as well, I suppose. We'll need some changes on the
verifier side to support this kind of enforcement for map operations,
is that right? Do you plan to work on this?

> >
> >>>> [...]
> > .
>

