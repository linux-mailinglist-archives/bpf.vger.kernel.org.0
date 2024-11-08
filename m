Return-Path: <bpf+bounces-44388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BB9C25EC
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113911C22C9D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2361C1F0B;
	Fri,  8 Nov 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmvhJ9ql"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F01A9B23
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095725; cv=none; b=TfaWnFVHEOMp8JI95MWTHL/mXBMZPQy7/FTaGUt3QPyaJi+47QYh/p6o3U5/sa8AxZVy63rdu8Ci4QrIqIxihOZyFLAKHm1TsCIONq4h6RS9j1uzZBAqMUMEqKOE6oFZkP+QPEpc4l44Hdr4a4IZA1rkArzEBcgJaP1bHVvjTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095725; c=relaxed/simple;
	bh=MwrC5FLXNXStRMhkqjNtIUZvG3XK7saUC/W+RlDHrJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3nftVyMNOYzJz/erUtjFpreH8Lv/p/tDqVE423hpu1qMVzgACf6HMKf4gbZktw3cS2PtxwCS++k/NE4gRTOffUvnRN0zfAJRwQNYY1E4+nnza8gzlgg9xYL/pJpqPLdZtCBpcJlMLtmdU910VASTFxXFombMaikVI4A3HVEFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmvhJ9ql; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d533b5412so1751943f8f.2
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731095722; x=1731700522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L/bFwvJoQ5WQYCZRfYo7QkRGdhQdGpWjYhQwe18j+M=;
        b=JmvhJ9qlprN6eaG1yB+Gn/OGiFJnjM4kxq3mC3bplgq2Ync205DeooiCgXNZt5MDlD
         Ihh/zlwgxVrVxjj+1VLDO+0A8U3VZfZ1+6uDkefUaANPfaLTY/qf8HH8FHuPOzpGOCpF
         P+CTMBjh8+stB6yBwNz4wB97x1RwgtMXsPd7QsEbFlaqZhZvukjCKOFLhwKaBY6Vn6K3
         FeeTnFdFju25pCCPycpbusgmP6sgnfzG11eHBareQ4jlvfqiCP74zOYL599xf9SKrqrn
         K69kdW8NdNMPleMJOs3MEqW+ISo6xnTbeHBA9pNxnmCFv+X84RJqcFpNT2czcboRxESv
         1wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095722; x=1731700522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L/bFwvJoQ5WQYCZRfYo7QkRGdhQdGpWjYhQwe18j+M=;
        b=PuRHN/3q15JI+oP3ITS+DdDB9jjh4wbynhPDCzJ7ICg0pL9HbukjP+D1xu0DbBpT3b
         7QxqC7ZhApOXA+XYZJWF6jzP7DJtT7dhhOzVMOQAcscSgu2xqP5MYRJXDl2IOYhrTCFY
         qMNMriabmk9Blp+8KzvUFlUhJoOilX10G7doS7baW1ZMPQaLzVKbeGb/NqkX6toPlwAQ
         YWfRnJMTBvVLXE8Ihy63L5bBca2/5cm3cbVaHAG5cMwEWW983DA9f+l9pnfWsJbTalQP
         FX3Aa9KnIo2n7Y5684VCBif5UHLQNPRN0YM0bj8VHbCgql7OxEF1QBmW5BbafAyuXSNX
         HSjw==
X-Gm-Message-State: AOJu0YwQBhiqFfTwN5Jaib+oQ6jfdtKOTGleAN3Uin9iDq+FMgchLw9y
	icB0dFCM1T9HeTGXT/XiZ+C7KImxJNQezJTjDIpr8MHj3NseauFhIIXjNqFX/nFmXOgYRasY58c
	aN62RhBE27BloP2dzrdyhYFuLV9Q=
X-Google-Smtp-Source: AGHT+IEhmm9uKFeNxZ0WnV3akc8+Ex9X7O5Pyx6zTOrdO4LwB+5MPt6BUmDHo6N2afZrBOWY2liXXQjBWRen3pqF9JE=
X-Received: by 2002:a05:6000:1448:b0:37d:2d27:cd93 with SMTP id
 ffacd0b85a97d-381f1883dedmr3397125f8f.43.1731095721479; Fri, 08 Nov 2024
 11:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106063542.357743-2-houtao@huaweicloud.com> <102c9956-6e85-36c8-68f5-32115a2744a1@huaweicloud.com>
In-Reply-To: <102c9956-6e85-36c8-68f5-32115a2744a1@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 11:55:10 -0800
Message-ID: <CAADnVQLrPRvPac-CaWScTfaswZtrpy5-C3_8OU1-=oBWj+tBDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Call free_htab_elem() after htab_unlock_bucket()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Xu Kuohai <xukuohai@huawei.com>, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:53=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
>
>
> On 11/6/2024 2:35 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > For htab of maps, when the map is removed from the htab, it may hold th=
e
> > last reference of the map. bpf_map_fd_put_ptr() will invoke
> > bpf_map_free_id() to free the id of the removed map element. However,
> > bpf_map_fd_put_ptr() is invoked while holding a bucket lock
> > (raw_spin_lock_t), and bpf_map_free_id() attempts to acquire map_idr_lo=
ck
> > (spinlock_t), triggering the following lockdep warning:
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >   [ BUG: Invalid wait context ]
> >   6.11.0-rc4+ #49 Not tainted
> >   -----------------------------
> >   test_maps/4881 is trying to lock:
> >   ffffffff84884578 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id.part=
.0+0x21/0x70
> >   other info that might help us debug this:
> >   context-{5:5}
> >   2 locks held by test_maps/4881:
> >    #0: ffffffff846caf60 (rcu_read_lock){....}-{1:3}, at: bpf_fd_htab_ma=
p_update_elem+0xf9/0x270
> >    #1: ffff888149ced148 (&htab->lockdep_key#2){....}-{2:2}, at: htab_ma=
p_update_elem+0x178/0xa80
> >   stack backtrace:
> >   CPU: 0 UID: 0 PID: 4881 Comm: test_maps Not tainted 6.11.0-rc4+ #49
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x6e/0xb0
> >    dump_stack+0x10/0x20
> >    __lock_acquire+0x73e/0x36c0
> >    lock_acquire+0x182/0x450
> >    _raw_spin_lock_irqsave+0x43/0x70
> >    bpf_map_free_id.part.0+0x21/0x70
> >    bpf_map_put+0xcf/0x110
> >    bpf_map_fd_put_ptr+0x9a/0xb0
> >    free_htab_elem+0x69/0xe0
> >    htab_map_update_elem+0x50f/0xa80
> >    bpf_fd_htab_map_update_elem+0x131/0x270
> >    htab_map_update_elem+0x50f/0xa80
> >    bpf_fd_htab_map_update_elem+0x131/0x270
> >    bpf_map_update_value+0x266/0x380
> >    __sys_bpf+0x21bb/0x36b0
> >    __x64_sys_bpf+0x45/0x60
> >    x64_sys_call+0x1b2a/0x20d0
> >    do_syscall_64+0x5d/0x100
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > One way to fix the lockdep warning is using raw_spinlock_t for
> > map_idr_lock as well. However, bpf_map_alloc_id() invokes
> > idr_alloc_cyclic() after acquiring map_idr_lock, it will trigger a
> > similar lockdep warning because the slab's lock (s->cpu_slab->lock) is
> > still a spinlock.
>
> Is it OK to move the calling of bpf_map_free_id() from bpf_map_put() to
> bpf_map_free_deferred() ? It could fix the lockdep warning for htab of
> maps. Its downside is that the free of map id will be delayed, but I
> think it will not make a visible effect to the user, because the refcnt
> is already 0, trying to get the map fd through map id will return -ENOENT=
.

I've applied the current patch, since doing free outside of bucket lock
is a good thing to do anyway.
With that no need to move bpf_map_free_id(), right?
At least offload case relies on id being removed immediately.
I don't remember what else might care.

