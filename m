Return-Path: <bpf+bounces-44795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC49C7AB4
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 19:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D40B2A191
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6C202F66;
	Wed, 13 Nov 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WBiuXIO8"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A31632CC
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521289; cv=none; b=YsNXlcG5YXHfIoX+AbwHr6KX1hmyBmkWFb++HWcIws3BWP5CgLDQ7KApfYEUgufGfjbkyPDQSOPWMguk7yBGw3CpiOvuJgCq/bVv/eoXrAQOSTXWbTd/AM0u5RsoE8i9fPMdpDIVnP877cUEKzMcDMLWX699C9gCAUMd3oJpf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521289; c=relaxed/simple;
	bh=Fw0tuQZwEtyHainmwIdlNHIQ0p4ERYoViANRc5R0cEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIBBLyEClEhY5zMX1KZyVztJtiF6EGDE+eyGCm/CmTt564Y42sEhuf7eFolLVliwyKzxv9c2wdnm3IuRjrgaGNiBbpJjVmckaS0pfvX1w5j2Oy4NfwLa1vMcBgvXi7W6WKoldHqC40aCtuZoO/ViUx6+EE85vMKXIUcMupv0ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WBiuXIO8; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12c598fe-b799-4f30-b871-a8b7191935ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731521285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw0tuQZwEtyHainmwIdlNHIQ0p4ERYoViANRc5R0cEw=;
	b=WBiuXIO8c2t5eSV23O9hObLiJH5zT0Ah8HdbYicl7+1+/AhukdjQymH+wo8M+0zLATBy8J
	BznGUHUyKCQ3yZONUI7oOY22hAuNlPrJhL08RSm0+zrL6d2YRS5XktqrgVBKkMG3iji+lF
	+CmWkXkB4Qc1hUXD9gcTUUNZrnFBuis=
Date: Wed, 13 Nov 2024 10:07:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] BUG: unable to handle page fault for address:
 ffffffffa6df0480
Content-Language: en-GB
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
References: <B80BDA8B-4F1C-4293-8E98-AF78AEA7B3FA@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <B80BDA8B-4F1C-4293-8E98-AF78AEA7B3FA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 6:26 AM, Yeqi Fu wrote:
> Hi there,
> A kernel page fault occurred at address ffffffffa6df0480 due to a supervisor read access in kernel mode. The error indicates a "not-present page" issue, leading to an Oops in the system. The fault address appears to be an invalid memory access, possibly due to incorrect handling of pointers or memory allocation within the BPF JIT compilation path.
> A proof-of-concept is available, and I have manually reproduced this bug.

I compiled your C file and run it with latest bpf-next for a few minutes
and there is no crash. Please give more details e.g. kernel config, which may help to reproduce.

>
> Report:
> ```
> BUG: unable to handle page fault for address: ffffffffa6df0480
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 75a87067 P4D 75a87067 PUD 75a88063 PMD 43c4063 PTE 800fffff8920f062
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 11294 Comm: syz.0.3563 Not tainted 6.12.0-rc3-gb22db8b8befe #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__arch_prepare_bpf_trampoline+0x53d/0x3810 arch/x86/net/bpf_jit_comp.c:2974
> Code: 8b 44 24 18 48 8b 5c 24 30 e9 a4 00 00 00 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 77 28 00 00 <41> 8b 1e bf 66 0f 1f 00 89 de e8 24 d6 3d 00 81 fb 66 0f 1f 00 75
> RSP: 0018:ffff888029b072e0 EFLAGS: 00010246
> RAX: 1ffffffff4dbe000 RBX: 0000000000000006 RCX: dffffc0000000000
> RDX: ffff88800b053780 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffff888029b074c0 R08: ffffffffa099ba3a R09: 0000000000000006
> R10: fffffbfff8095000 R11: ffffed100020a30d R12: ffff888029b07440
> R13: 0000000000000030 R14: ffffffffa6df0480 R15: 0000000000000008
> FS: 00007fba28dc1640(0000) GS:ffff888065800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffa6df0480 CR3: 00000000281b4006 CR4: 0000000000370ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> arch_bpf_trampoline_size+0xd3/0x150 arch/x86/net/bpf_jit_comp.c:3212
> bpf_trampoline_update+0x78b/0x1020 kernel/bpf/trampoline.c:435
> __bpf_trampoline_link_prog+0x50a/0x6c0 kernel/bpf/trampoline.c:565
> bpf_trampoline_link_prog+0x2d/0x40 kernel/bpf/trampoline.c:578
> bpf_tracing_prog_attach+0x9e4/0xe50 kernel/bpf/syscall.c:3432
> bpf_raw_tp_link_attach+0x3ec/0x630 kernel/bpf/syscall.c:3798
> bpf_raw_tracepoint_open+0x172/0x1e0 kernel/bpf/syscall.c:3861
> __sys_bpf+0x3ae/0x850 kernel/bpf/syscall.c:5676
> __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
> __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xd8/0x1c0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7fba2a76d72d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fba28dc0f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fba2a945f80 RCX: 00007fba2a76d72d
> RDX: 0000000000000010 RSI: 0000000020000a80 RDI: 0000000000000011
> RBP: 00007fba2a7f7584 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fba2a945f80 R15: 00007fba28da1000
> </TASK>
> Modules linked in:
> CR2: ffffffffa6df0480
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__arch_prepare_bpf_trampoline+0x53d/0x3810 arch/x86/net/bpf_jit_comp.c:2974
> Code: 8b 44 24 18 48 8b 5c 24 30 e9 a4 00 00 00 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 77 28 00 00 <41> 8b 1e bf 66 0f 1f 00 89 de e8 24 d6 3d 00 81 fb 66 0f 1f 00 75
> RSP: 0018:ffff888029b072e0 EFLAGS: 00010246
> RAX: 1ffffffff4dbe000 RBX: 0000000000000006 RCX: dffffc0000000000
> RDX: ffff88800b053780 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffff888029b074c0 R08: ffffffffa099ba3a R09: 0000000000000006
> R10: fffffbfff8095000 R11: ffffed100020a30d R12: ffff888029b07440
> R13: 0000000000000030 R14: ffffffffa6df0480 R15: 0000000000000008
> FS: 00007fba28dc1640(0000) GS:ffff888065800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffa6df0480 CR3: 00000000281b4006 CR4: 0000000000370ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> note: syz.0.3563[11294] exited with irqs disabled
> ----------------
> Code disassembly (best guess):
> 0: 8b 44 24 18 mov 0x18(%rsp),%eax
> 4: 48 8b 5c 24 30 mov 0x30(%rsp),%rbx
> 9: e9 a4 00 00 00 jmp 0xb2
> e: 4c 89 f0 mov %r14,%rax
> 11: 48 c1 e8 03 shr $0x3,%rax
> 15: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
> 1c: fc ff df
> 1f: 8a 04 08 mov (%rax,%rcx,1),%al
> 22: 84 c0 test %al,%al
> 24: 0f 85 77 28 00 00 jne 0x28a1
> * 2a: 41 8b 1e mov (%r14),%ebx <-- trapping instruction
> 2d: bf 66 0f 1f 00 mov $0x1f0f66,%edi
> 32: 89 de mov %ebx,%esi
> 34: e8 24 d6 3d 00 call 0x3dd65d
> 39: 81 fb 66 0f 1f 00 cmp $0x1f0f66,%ebx
> 3f: 75 .byte 0x75
> ```
[...]

