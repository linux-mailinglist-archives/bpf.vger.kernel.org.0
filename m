Return-Path: <bpf+bounces-44380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355159C2538
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9351C20FCD
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CE1A9B5D;
	Fri,  8 Nov 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xq5j5PJA"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CB233D96
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092302; cv=none; b=qdJzLA+Vb0kcxACefDPcBSp9J3nKTLXSXWLVNLre/iJVpNZG4JchSlIHvXf50jZczhguFPTkOUM/+I54tF9LlXJw72SHFkXmo+9671cE9snuJqu2vpBGqgfc67EPX9VDVpvhTC1cbskFUBP75QFGjprQsqeh7rw8mir4I2hK1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092302; c=relaxed/simple;
	bh=y5z+A9NupvZs4nnBpZrmvKCzP+8ZODrJ/XnKXmyBZO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nn6Tg/1wxAOhlGVPdUI1hR+qpopLGYihYhPUmsC7XKKCzwD8MBp8gPvqn3wfIuVc/3H+6PS5+CVeKB3j/jZs+9bscD6nU5a/AbgxQdsef6r0dtY2cR1BRe4/wmIhNb7TaMhplVvKb37rvd6X6Z4mAy3J2x1XnYSUiW3YoJNkKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xq5j5PJA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4833d40-31d9-4de6-94b2-964870671006@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731092297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKOz2Ke3deWKx3LB9Ol2VggCwIo/TvK8NNumftjVwTM=;
	b=Xq5j5PJA9CgtkmeafRikaDn8aGf9Tv9Nhpqunc9lWXEq7vCl1W4FWeC/HaS7GkGFr8Xf7k
	eq7io/Hys8sHq5dO135k6r/GkvSNv0pAri6W735l6BrK387GeAuR7OuE/u8/1bh6HVTALi
	KDwjsa00h6dPh+bKaEbi8c3yVT6f0Gk=
Date: Fri, 8 Nov 2024 10:58:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] WARNING: at lib/vsprintf.c:2659 format_decode+0x121a/0x1c00
To: Yeqi Fu <fufuyqqqqqq@gmail.com>,
 "jakub@cloudflare.com" <jakub@cloudflare.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 bonan.ruan@u.nus.edu
References: <D47BDD2E-217F-4F16-A74C-ADE4DA025FED@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <D47BDD2E-217F-4F16-A74C-ADE4DA025FED@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 6:28 AM, Yeqi Fu wrote:
> Hi there,
> A warning is triggered in lib/vsprintf.c due to an unsupported '%' in a format string. This issue occurs in the function format_decode at line 2659 of kernel version 6.12.0-rc3-gb22db8b8befe. A proof-of-concept is available, and I have manually reproduced this bug.

I think the below patch set (not merged yet)
   https://lore.kernel.org/bpf/20241028195343.2104-1-rabbelkin@mail.ru/
should fix this issue.

>
> Report:
> ```
> Please remove unsupported % in format string
> WARNING: CPU: 1 PID: 29307 at lib/vsprintf.c:2659 format_decode+0x121a/0x1c00 lib/vsprintf.c:2659
> Modules linked in:
> CPU: 1 UID: 0 PID: 29307 Comm: syz.5.9298 Not tainted 6.12.0-rc3-gb22db8b8befe #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:format_decode+0x121a/0x1c00 lib/vsprintf.c:2659
> Code: 8b 9c 24 80 00 00 00 48 89 d8 48 c1 e8 03 42 8a 04 30 84 c0 0f 85 d5 09 00 00 0f b6 33 48 c7 c7 00 bd eb 92 e8 b7 59 67 fc 90 <0f> 0b 90 90 4d 89 f7 48 8b 5c 24 18 e9 d7 fc ff ff 89 d1 80 e1 07
> RSP: 0018:ffff888041197600 EFLAGS: 00010246
> RAX: ea46d93351edcc00 RBX: ffff88804119792c RCX: ffff888009a78000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff8880411976f0 R08: ffffffff8ebc8e3b R09: 1ffff1100d9e515a
> R10: dffffc0000000000 R11: ffffed100d9e515b R12: ffff0000ffffff00
> R13: ffff888041197700 R14: dffffc0000000000 R15: dffffc0000000000
> FS: 00007fbe06321640(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020a8c000 CR3: 00000000404b6005 CR4: 0000000000370ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> bstr_printf+0x136/0x1260 lib/vsprintf.c:3232
> ____bpf_trace_printk kernel/trace/bpf_trace.c:389 [inline]
> bpf_trace_printk+0x1a1/0x220 kernel/trace/bpf_trace.c:374
> bpf_prog_7ee8fe4dad0c4460+0x4e/0x50
> bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
> __bpf_prog_run include/linux/filter.h:692 [inline]
> bpf_prog_run include/linux/filter.h:708 [inline]
> bpf_test_run+0x7a9/0x910 net/bpf/test_run.c:433
> bpf_prog_test_run_skb+0xc47/0x1750 net/bpf/test_run.c:1094
> bpf_prog_test_run+0x2df/0x350 kernel/bpf/syscall.c:4247
> __sys_bpf+0x484/0x850 kernel/bpf/syscall.c:5652
> __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
> __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xd8/0x1c0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7fbe07ccd72d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fbe06320f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fbe07ea5f80 RCX: 00007fbe07ccd72d
> RDX: 0000000000000050 RSI: 0000000020000700 RDI: 000000000000000a
> RBP: 00007fbe07d57584 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fbe07ea5f80 R15: 00007fbe06301000
> </TASK>
> irq event stamp: 39314
> hardirqs last enabled at (39324): [<ffffffff8ed766cb>] __up_console_sem kernel/printk/printk.c:344 [inline]
> hardirqs last enabled at (39324): [<ffffffff8ed766cb>] __console_unlock+0xfb/0x130 kernel/printk/printk.c:2844
> hardirqs last disabled at (39335): [<ffffffff8ed766b0>] __up_console_sem kernel/printk/printk.c:342 [inline]
> hardirqs last disabled at (39335): [<ffffffff8ed766b0>] __console_unlock+0xe0/0x130 kernel/printk/printk.c:2844
> softirqs last enabled at (38482): [<ffffffff9195aaea>] bpf_test_run+0x31a/0x910
> softirqs last disabled at (38484): [<ffffffff9195aaea>] bpf_test_run+0x31a/0x910
> ---[ end trace 0000000000000000 ]---
> ```
[...]

