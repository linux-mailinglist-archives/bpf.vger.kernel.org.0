Return-Path: <bpf+bounces-67782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7AB499EB
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6904E000A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991527F000;
	Mon,  8 Sep 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVJmc1iy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E825634
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359786; cv=none; b=oTzCGKJn1kW0GdE4ug6U0JigjkDpV7dLT1bWCEjjZtNTidWQxL0OK3Tyxjan3wZQ1YKBQR7LkGUQtFQoa89tWTVx3J/dSW6hlhPa34GobFvluNzZzwkuY/A+xhoaePo1DiRMnQ+rrJ61WSifYyXZx/SgG11b8oCUhnTiktUrHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359786; c=relaxed/simple;
	bh=eypYIHAGCDqRrFByDGVlMsv+wV8HsCOf+oVpLaoVMVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anFtX666UH0dK7Yr5qvqQLT+sOn0xWFwQymmcCdfndIr4imCDWnYunTVg2csewf9Ny3PyvCKxuw6PU9/m+3krh2g6fYCVULVFRBn0k8kPZshZEAMjQbrsAmIJrmlmhMdQ54ByvbYP2Geb1mlBCfBG9K/CFjX+NX145VGfHfWh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVJmc1iy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so2985102a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359785; x=1757964585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Wh1pmErzA4T5g/k2ByBY4Fxfmmbxqc2T9D32et5awE=;
        b=SVJmc1iyQbxoC/AbThd8ArJUBffGdaC69I3Ib1wXhzkYtPw0oBSy/aLCA508hJRl8i
         Bgnp/WaauLeljzuF7hG04GXysn4h/qzBblGeaTcjrMeuV5tuEUxggfAD3A/3fkEu04Xz
         hUBRRhtpYj3La/VphLunQASEaWVrqinnX8PYu5xifeaGqIugDMJ21IEX3SPOfUahxC2y
         Bcwi04I/jMHxnadU2mmLUO1OWqzumTVv9jIXsb99WrSiEI9v0Tih9HzXI9NuJKmi9JBR
         rjI3doYSl0difq4VxMXWe6LCImxIr3lQGMyc2UmOEkBBlPmuqBqXUqV6Bw5tjOvk9mrX
         if2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359785; x=1757964585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Wh1pmErzA4T5g/k2ByBY4Fxfmmbxqc2T9D32et5awE=;
        b=XnHeoeau3VimcvLpwbUS+K96iqrFjbljho69nf1cj+/ViwjaWaNeVcpj66zmLIUAcn
         zBTDnjQh6Ce40814x0OLC7Wkm4+Po2RRrGC+Y+GShlajsCegq7Tk8KL3kwwb29tReLCa
         0l598qzvLmfNetwHVwAErb0xsZWir86Kuz8y+L3CYultNcU0nJLF5y3tHlwf0V59NUKE
         172zF+L1pJirJIS1/qbwdaqUxTFlvWI/4/V7itiHlYb2gq0R00t3KsN7JCP2diFBrgKv
         r56EBYDKk9+zbrqW74R2Vo/9ktIXcoTZXCyEI8SsGNcm2jnRKlzhgwF+X/b0rs5fMN16
         5cCg==
X-Forwarded-Encrypted: i=1; AJvYcCWciiurA9M3K/AjumCLlZMPoJ7o14lcZUnJv3cQZrsdXGgkL1b1CJ0Keon/kU8sCwxYnok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw201Udn0Wk23BLODxTbhw3hW4OMYswSHrR3GJwwI7P0623UJpi
	26jf+6ueIRl1b1BMa8osXVuDMVj7nsVtbHIcrSOGpJVPF2q0bfihJbU/
X-Gm-Gg: ASbGncvGHLbizNN2vuP2BtDZr9cBUoA9x3Ib/PMk9xIwPYaxoAghDY17a5oaBrBqlzU
	6GT9OtjbfuVGnCfinbx3LxnYaXMNp7qoaJWv2EblS6qw0QrkoWZ4pPYf9FWXmXrWbwVRTU6nHtD
	ie25EbOMBWGKfJgfmYUdYJkCr9cMt0xlUhD4ncm+36mSpC57w3j66GSidIWK0o/NeMTLs49O6qF
	2IWIgPB+fnRtuNEhPCg5oSbBf4TG8rNs5FIigcKlSS80+0C01zFRtXcnx6+QrCRWQYK6r5W28Hx
	ewRuOwUQL6S3wO4fxW4bAmkQZIkARKelLYjM8JeMGMgRFrT5Vn141sGMjd1vFzoSnt1xkH7uapw
	luvNG0iIuPV8M8oClHoc5ZVeW1or3hUsjNgqUX5U6ekl0/ZonNwXQwkpIKUCzuCSZmc7J
X-Google-Smtp-Source: AGHT+IEg+HTCcZslsLJP3CtpRGAl42+5oEj3VYyWwBAEKJiFuU7ooJFzwTSs58UtTic91fCXEa962A==
X-Received: by 2002:a17:902:d48c:b0:250:5ff5:3f4b with SMTP id d9443c01a7336-2516fdc77a2mr147571915ad.15.1757359784739;
        Mon, 08 Sep 2025 12:29:44 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccc79a363sm121960725ad.142.2025.09.08.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:29:44 -0700 (PDT)
Message-ID: <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com, 	yepeilin@google.com
Date: Mon, 08 Sep 2025 12:29:42 -0700
In-Reply-To: <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
		 <20250908044025.77519-2-leon.hwang@linux.dev>
	 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 12:20 -0700, Eduard Zingerman wrote:
> On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
> > When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
> > selftests by './test_progs -t timer':

Related discussions:
- https://lore.kernel.org/bpf/b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6d=
wldz2@hoofqufparh5/T/
- https://lore.kernel.org/bpf/lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezhepgu=
qkxag@wolz4r2fazu2/T/

CC'ing Peilin.

> >=20
> > [   35.955287] BUG: sleeping function called from invalid context at ke=
rnel/locking/spinlock_rt.c:48
> > [   35.955312] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1=
20, name: test_progs
> > [   35.955315] preempt_count: 1, expected: 0
> > [   35.955316] RCU nest depth: 0, expected: 0
> > [   35.955317] 2 locks held by test_progs/120:
> > [   35.955319]  #0: ffffffff8f1c3720 (rcu_read_lock_trace){....}-{0:0},=
 at: bpf_prog_test_run_syscall+0xc9/0x240
> > [   35.955358]  #1: ffff9155fbd331c8 ((&c->lock)){+.+.}-{3:3}, at: ___s=
lab_alloc+0xb0/0xd20
> > [   35.955388] irq event stamp: 100
> > [   35.955389] hardirqs last  enabled at (99): [<ffffffff8dfcd890>] do_=
syscall_64+0x30/0x2d0
> > [   35.955414] hardirqs last disabled at (100): [<ffffffff8d4a9baa>] __=
bpf_async_init+0xca/0x310
> > [   35.955428] softirqs last  enabled at (0): [<ffffffff8d296cbb>] copy=
_process+0x9db/0x2000
> > [   35.955449] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [   35.955482] CPU: 1 UID: 0 PID: 120 Comm: test_progs Tainted: G      =
     OE       6.17.0-rc1-gc5f5af560d8a #30 PREEMPT_{RT,(full)}
> > [   35.955487] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > [   35.955488] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   35.955491] Call Trace:
> > [   35.955493]  <TASK>
> > [   35.955499]  dump_stack_lvl+0x73/0xb0
> > [   35.955514]  dump_stack+0x14/0x20
> > [   35.955518]  __might_resched+0x167/0x230
> > [   35.955537]  rt_spin_lock+0x66/0x180
> > [   35.955543]  ? ___slab_alloc+0xb0/0xd20
> > [   35.955549]  ? bpf_map_kmalloc_node+0x7c/0x200
> > [   35.955560]  ___slab_alloc+0xb0/0xd20
> > [   35.955575]  ? __lock_acquire+0x43d/0x2590
> > [   35.955601]  __kmalloc_node_noprof+0x10b/0x410
> > [   35.955605]  ? __kmalloc_node_noprof+0x10b/0x410
> > [   35.955607]  ? bpf_map_kmalloc_node+0x7c/0x200
> > [   35.955616]  bpf_map_kmalloc_node+0x7c/0x200
> > [   35.955624]  __bpf_async_init+0xf8/0x310
>=20
> The error is reported because of the kmalloc call in the __bpf_async_init=
, right?
> Instead of disabling timers for PREEMPT_RT, would it be possible to
> switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() instea=
d?
>=20
> > [   35.955633]  bpf_timer_init+0x37/0x40
> > [   35.955637]  bpf_prog_2287350dd5909839_start_cb+0x5d/0x91
> > [   35.955642]  bpf_prog_0d54653d8a74e954_start_timer+0x65/0x8a
> > [   35.955650]  bpf_prog_test_run_syscall+0x111/0x240
> > [   35.955660]  __sys_bpf+0x81c/0x2ab0
> > [   35.955665]  ? __might_fault+0x47/0x90
> > [   35.955700]  __x64_sys_bpf+0x1e/0x30
> > [   35.955703]  x64_sys_call+0x171d/0x20d0
> > [   35.955715]  do_syscall_64+0x6a/0x2d0
> > [   35.955722]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   35.955728] RIP: 0033:0x7fee4261225d
> > [   35.955734] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
> > [   35.955736] RSP: 002b:00007fee424e5bd8 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000141
> > [   35.955742] RAX: ffffffffffffffda RBX: 00007fee424e6cdc RCX: 00007fe=
e4261225d
> > [   35.955744] RDX: 0000000000000050 RSI: 00007fee424e5c20 RDI: 0000000=
00000000a
> > [   35.955745] RBP: 00007fee424e5bf0 R08: 0000000000000003 R09: 00007fe=
e424e5c20
> > [   35.955747] R10: 00007fffc266f910 R11: 0000000000000202 R12: 00007fe=
e424e66c0
> > [   35.955748] R13: ffffffffffffff08 R14: 0000000000000016 R15: 00007ff=
fc266f650
> > [   35.955766]  </TASK>
>=20
> [...]

