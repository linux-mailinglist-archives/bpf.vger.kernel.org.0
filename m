Return-Path: <bpf+bounces-67780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E6B499D1
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257111BC28EF
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4326CE3F;
	Mon,  8 Sep 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTbn2Jng"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254226B0BE
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359246; cv=none; b=FCJVii+wjSj/7o+pUx/ulqOIJMw4JxdceWxUquJjp8L42at7h0NkNdH/6gr1yHPiIClfjQBXSr81ckqQDh+XmfMeycPo2flkW+nUP09jSw4/HZgypQ/BuqQdZLt8GFLdm3nhiNnWhcsseSEMNf6OqJb4exjDKMIOzes9GUWJ4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359246; c=relaxed/simple;
	bh=/eF8vJh5lfqU24o5Xs8Onjv6xoTEzJS+lF9YLVdseno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gx//kSlNFCVvIYSrPVYc21mF87CmxpYf0HmhxrggSyMnkCqXZmihxPpIcfkgUgeAf6eRgTMpaOTWlFus3BpR1DjdWtQtGxSCEM4IDsf/5OVS1FoF79tJ70TOaZMtpj2Qr/d0ABLIOOAKutLqsmGfKIIPVjY9VI1RJDPFTkDxVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTbn2Jng; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3277c603b83so2970445a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359245; x=1757964045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ha2aNQaX2iPmhpL6ru+o8/Hy2t1rvP5IDw1RdmvqOZw=;
        b=WTbn2Jngk9mok4/XJOV+KKBWVhZuE7sZOdOUdIXXmdicNT+sHqm2zfeo3IltTiz+Vw
         MrdJemRXKtY6L6PsEV+Uozf60Z5t0ZZu/VUaVko0Xt5W8iwdOsjem47YLdRIkjzFbI8W
         1zGjPJGV/LPcgB0Fnv92WIYoeRcWc/51eNescGyEEgxzhPq50T1EI9njqlSylxlHEx0s
         2tah6Hql52njbLyrNnYDQLmjxaKNC9gB1CPsLHmCt4AhifwkHDJJtumrbfv/ukageFX3
         ratEpj2GGI6Qqutje5a9CafzAMTcX4750FeRUwX7bJbW90DBT6UPf59OVjg2nNMXF7A2
         fHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359245; x=1757964045;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ha2aNQaX2iPmhpL6ru+o8/Hy2t1rvP5IDw1RdmvqOZw=;
        b=bYiE5qEQ3yvryEpA5oB99aWNdvdrKzCVxmvHLCDKfzR8DoILz0ukqgLr9ef8pJMs4w
         Ag+fKTKMg4F4hRl0si/3Pkx0u6amxoEtLMZL2I8uOStgbXz4avcOBJcSO7gEebCZB+1e
         NZL1m81EtpWGdA3oxm/bgkyz8fNkIW+0n+3S6YuhmqtEHj3bJAeXLFf3L5CloUhLvjoD
         4j7ffqmP884+c5RV2lZV486+lhyiL7/qXva2h14EpIUevirYbNzysK9h++4hmdtBXNHq
         U0yjrX/VBXFxQ1RvAu0nU4IC6jFQjLz55iyIm/sklhWK6MLCfvzi5KFyJlF1Kd8RTdSI
         4gOw==
X-Forwarded-Encrypted: i=1; AJvYcCWNgFWvv0/1e9salrji6CroqCWOGkNgqazYBaPZPSvsqhT7ub3s60EhSUPLLTMKmS3O1Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5W5Bhj23ScaVdy+Rr5jYLDOyqjY24bq39aBz+S/6dedA+gL4
	3q13vHUkSWmvw3EthRFHQFisgr6/k8cGgrktejRUc8iEJCqSQd4TTH3s
X-Gm-Gg: ASbGncvyFblA/caZwtAsqgG+AuOM8feCws3pRm4NmnPoVrVDSFn2kD0ck6X/efu8Htz
	kZBAZKJPKiFb7VLTpHlija2f3OyvLEoAZRT4RmDsF6UuOelecf0bsMX1VKpXzmUYstbx+bhAJlV
	YsgO/hJioRpJOnib/kh9lUsuTBHTrbI90fq/09NwKe772joKQI9P83osS7UT3+ubelfDfWVvwGg
	Jxr2/WnQIQqh7cSXNGW5Bjg/XXm/DdE7NTvPeQDPR/O9hXh6dGzC2rZG6e0f7CvSKJHJB7BHmVe
	hdjGK5f+MU5ekMZQoPCRE/lwQEMqDEmQhtyaOlx8tXyEofXNwlt3xP2RuIrmhSDqUGkgkJomURg
	JdIVDkBwLD64LK2pIMzOT5gcxZYFmLM8mLKMp5KRDcLOX0XQcNpNz+AimmA==
X-Google-Smtp-Source: AGHT+IGrBpvC8O2PvAVp5xPEvlhGgDoTKOfXPm+mMygS7uV9URys3NMk7uWr0sYxcNkkW3/lFa/lOw==
X-Received: by 2002:a17:90b:3c08:b0:329:e9da:35dd with SMTP id 98e67ed59e1d1-32d43f77076mr11472254a91.27.1757359244624;
        Mon, 08 Sep 2025 12:20:44 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeebe16sm31845461a91.26.2025.09.08.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:20:44 -0700 (PDT)
Message-ID: <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com
Date: Mon, 08 Sep 2025 12:20:42 -0700
In-Reply-To: <20250908044025.77519-2-leon.hwang@linux.dev>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
	 <20250908044025.77519-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
> When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
> selftests by './test_progs -t timer':
>=20
> [   35.955287] BUG: sleeping function called from invalid context at kern=
el/locking/spinlock_rt.c:48
> [   35.955312] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 120=
, name: test_progs
> [   35.955315] preempt_count: 1, expected: 0
> [   35.955316] RCU nest depth: 0, expected: 0
> [   35.955317] 2 locks held by test_progs/120:
> [   35.955319]  #0: ffffffff8f1c3720 (rcu_read_lock_trace){....}-{0:0}, a=
t: bpf_prog_test_run_syscall+0xc9/0x240
> [   35.955358]  #1: ffff9155fbd331c8 ((&c->lock)){+.+.}-{3:3}, at: ___sla=
b_alloc+0xb0/0xd20
> [   35.955388] irq event stamp: 100
> [   35.955389] hardirqs last  enabled at (99): [<ffffffff8dfcd890>] do_sy=
scall_64+0x30/0x2d0
> [   35.955414] hardirqs last disabled at (100): [<ffffffff8d4a9baa>] __bp=
f_async_init+0xca/0x310
> [   35.955428] softirqs last  enabled at (0): [<ffffffff8d296cbb>] copy_p=
rocess+0x9db/0x2000
> [   35.955449] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   35.955482] CPU: 1 UID: 0 PID: 120 Comm: test_progs Tainted: G        =
   OE       6.17.0-rc1-gc5f5af560d8a #30 PREEMPT_{RT,(full)}
> [   35.955487] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   35.955488] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   35.955491] Call Trace:
> [   35.955493]  <TASK>
> [   35.955499]  dump_stack_lvl+0x73/0xb0
> [   35.955514]  dump_stack+0x14/0x20
> [   35.955518]  __might_resched+0x167/0x230
> [   35.955537]  rt_spin_lock+0x66/0x180
> [   35.955543]  ? ___slab_alloc+0xb0/0xd20
> [   35.955549]  ? bpf_map_kmalloc_node+0x7c/0x200
> [   35.955560]  ___slab_alloc+0xb0/0xd20
> [   35.955575]  ? __lock_acquire+0x43d/0x2590
> [   35.955601]  __kmalloc_node_noprof+0x10b/0x410
> [   35.955605]  ? __kmalloc_node_noprof+0x10b/0x410
> [   35.955607]  ? bpf_map_kmalloc_node+0x7c/0x200
> [   35.955616]  bpf_map_kmalloc_node+0x7c/0x200
> [   35.955624]  __bpf_async_init+0xf8/0x310

The error is reported because of the kmalloc call in the __bpf_async_init, =
right?
Instead of disabling timers for PREEMPT_RT, would it be possible to
switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() instead?

> [   35.955633]  bpf_timer_init+0x37/0x40
> [   35.955637]  bpf_prog_2287350dd5909839_start_cb+0x5d/0x91
> [   35.955642]  bpf_prog_0d54653d8a74e954_start_timer+0x65/0x8a
> [   35.955650]  bpf_prog_test_run_syscall+0x111/0x240
> [   35.955660]  __sys_bpf+0x81c/0x2ab0
> [   35.955665]  ? __might_fault+0x47/0x90
> [   35.955700]  __x64_sys_bpf+0x1e/0x30
> [   35.955703]  x64_sys_call+0x171d/0x20d0
> [   35.955715]  do_syscall_64+0x6a/0x2d0
> [   35.955722]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   35.955728] RIP: 0033:0x7fee4261225d
> [   35.955734] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
> [   35.955736] RSP: 002b:00007fee424e5bd8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000141
> [   35.955742] RAX: ffffffffffffffda RBX: 00007fee424e6cdc RCX: 00007fee4=
261225d
> [   35.955744] RDX: 0000000000000050 RSI: 00007fee424e5c20 RDI: 000000000=
000000a
> [   35.955745] RBP: 00007fee424e5bf0 R08: 0000000000000003 R09: 00007fee4=
24e5c20
> [   35.955747] R10: 00007fffc266f910 R11: 0000000000000202 R12: 00007fee4=
24e66c0
> [   35.955748] R13: ffffffffffffff08 R14: 0000000000000016 R15: 00007fffc=
266f650
> [   35.955766]  </TASK>

[...]

