Return-Path: <bpf+bounces-45868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C59DC331
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC281281D36
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5819ABA3;
	Fri, 29 Nov 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYPjmwCG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EE155A59
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881692; cv=none; b=DdO4GzPfh/LUve6BGzFA3Qn5t5aH3r8wwgR/lLmaP6aU8ElyCdPXOYHZafeM4/wZpQAL0QgzR7mQJwEVPkLVwUKvEba6njNyr8wgmpuyh3gnAWRIlk2eLw+yZ+aVJ+s9SVcILEe+TuibdgFfcr/RP5JpEoT0u0mkHgfjREtV/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881692; c=relaxed/simple;
	bh=gRevtJy/bHV/qgnFY4kB7YwAJe6PmPTtlCgLkcrFDrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsbhZ0VAw64lCxJOPTeOvRBRnmngnDzvC4eFkLiVdch27UV26pHlkjJh7lpVLLJR36flKvFXRVQQvrbZKb2TH/z0bjkW/hnoVsPbaD7Is7Aa82ytnFzial+QeL3ifwOM+VTVu0L8ZJq96yHDL5IrGpNesJmC8P0jRHfmF7K6w5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYPjmwCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732881689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vBh02CQAn+Tj9vd1eIzhymeRAJ9Xq8doZzvHCmf7z4=;
	b=YYPjmwCG/WvR9YYOrdzVM8w/NwqdOj8QKbgu6TKOnNCbOWpLA//PhTXytoUw5OwOnvpMhy
	zd9FybZfg7J/TX+BjjetDqTdE09NipL2d32W+CWrr2E8c7PewgFwHW/Pe/PLvrHTCWER5U
	CZTEVdsv8EbZL1/q7FlFnP+nD+f/9gU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-0sdsxraCNOakGVogF2N-XA-1; Fri, 29 Nov 2024 07:01:27 -0500
X-MC-Unique: 0sdsxraCNOakGVogF2N-XA-1
X-Mimecast-MFC-AGG-ID: 0sdsxraCNOakGVogF2N-XA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d735965bso634240f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 04:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732881686; x=1733486486;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vBh02CQAn+Tj9vd1eIzhymeRAJ9Xq8doZzvHCmf7z4=;
        b=iBK4A7COrVoqXUbO2zalQoySqQ3vEvMD4t8uhaoOt44KzQYK30s3+mTLB7ZWWYP8dJ
         H7+f4MDUfk+39GENcWJuZ6aMrO08dvrBUzn/+SFts88kOpXfddm6V1FrBMGFq+9kd5xU
         y2Fx1BQ/sGgBUdcYnCR8IUWjNmiy3q/9TSTeFct5skpcjkhjEGWzsmEnlYkhaJ7n6kQT
         h+ut6FyURUVgN7hAvn4qrofzFcnBygTqHqdM1uPyA7Ao+3VUKmDal043zS4sKoKmwdRO
         Y9ISBLVpxrAn+/bFlMIZRb9IWWtnYuKkC3iF/N+eQCtaAE9kSIPIKk9Olbn8Q7kq9Hr5
         kbfw==
X-Forwarded-Encrypted: i=1; AJvYcCWwAH4k0eQaNnoUIWh5t38AW41uWgHA8/joXKil1wW79TrBtv5b82LWHN6xjWaja+wRLm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMGs3fyhHZ2HYLjhpAfz7bjfmpUCxT7Dl8z6tbZENXyFJDcpd
	9eGOmZCe2QAdIdoDoY19c9lGE4E+Va8ldaN6SVv2SM4d9GcZ38Xldws52Kxa9PuKrKkKAscynCJ
	Py8DlD4yJwLLn9YofLSiWR1gPZhrV5uMUv1FWrchKOBxjeyH6Cw==
X-Gm-Gg: ASbGncvSoJ2LJ/J8HpPmGGXkj8v1RbqlH+ijFPblt3hqX4trlP2xkxFp7sNxiAvlXmo
	PNWxF2s6681022LABgKLTBf/AVud2KbYAInndJCvlCfh0QXz3UFwM4jC3Q7ONymtsLzYau+WIKP
	VStBA+l0uiQx8V+PXM8lwJ0qhhDwz/y5ljaYxZBwHAVYryW/4teigYNTIu2krDauNF0sDlI5xwE
	kTOD+r95u+tugr80gRyNWqKCt53g7Ui/mR03JoaCTJ1D2Qr7EI43kImjg/OttdyKe1GnJFqH6s=
X-Received: by 2002:a05:6000:23c2:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-385c6ebab89mr7132395f8f.20.1732881684802;
        Fri, 29 Nov 2024 04:01:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7xoQ1zcYko4fkv+LD9+/p2QInSWakUL0YDcGXMtiuyRQrGzgZM5JGwvVvYOnws3iZqQpe+A==
X-Received: by 2002:a05:6000:23c2:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-385c6ebab89mr7132270f8f.20.1732881683471;
        Fri, 29 Nov 2024 04:01:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32793sm51143965e9.31.2024.11.29.04.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 04:01:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D13A5164E38B; Fri, 29 Nov 2024 13:01:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
In-Reply-To: <20241127004641.1118269-7-houtao@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-7-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 29 Nov 2024 13:01:20 +0100
Message-ID: <87iks6i6zz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

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
> Two aspects of this change require explanation:
>
> 1. Intermediate and leaf nodes are allocated from the same allocator.
> The value size of LPM trie is usually small and only use one allocator
> reduces the memory overhead of BPF memory allocator.
>
> 2. nodes are freed before invoking spin_unlock_irqrestore(). Therefore,
> there is no need to add paired migrate_{disable|enable}() calls for
> these free operations.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

I agree with Alexei's comments, but otherwise:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


