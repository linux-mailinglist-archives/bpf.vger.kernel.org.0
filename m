Return-Path: <bpf+bounces-60088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2922AD2831
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B39169CC3
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5B2222D7;
	Mon,  9 Jun 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kig4iVeJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A71221F18;
	Mon,  9 Jun 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502541; cv=none; b=k57mqoG6SOPpVrB31JH4hK3MK++g0vyew3JyBiP1d6pZRu0i8BG9vjj0OgXNYW8+ha9avVclHN1RC8Q1HTbE1P6WbD52zQX8tpg/xa2bJM/VCE9f8RmswjJKR8NKk4P2aWVu251s+BNT1Ou3ThoMNxEfkgRvAaJOT6NXweM/xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502541; c=relaxed/simple;
	bh=ulPoIuEevlMIIKdXPh4CCGzBiapcu453jjJws2ncaOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MSUrua8Hi51kJ27/ONBb1gQG0E3raEH30G1Zwop2NtMfKoLfCBOMZsSivqoJw9si1vGeySB1sjxu8qsriUwr8BSrav7OMdxzSeevHQPcJr+5Q1LFtD/WascrVgS3qUx232D7NkoSaxSdaen8zy6OOuI7X9Na3MJYH8e+0XecQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kig4iVeJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fd7a5b5-ee26-4cc5-8eb0-449c4e326ccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749502525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moMYIgmuLZy1hidmNlTOsqYI1DYCvfc+CrXgD/4VkFs=;
	b=Kig4iVeJuCHUE6f/mmHJ6sXSwW0Pd1uuGgDHlPBkUjF75WIsHkWvd2Qim4qijLLd0auT+I
	JeWEf9YBUgxMdYFkd0axHAE6hqJcAC2dS6s2s9iBUHy+vsQ4byL2zqbLO5AqsiIsZI5Ile
	DnyKL5IakDJqDNw1Gf2IhRmGBQNw5Ls=
Date: Mon, 9 Jun 2025 13:55:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [net?] general protection fault in veth_xdp_rcv
To: syzbot <syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com>,
 Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 wireguard@lists.zx2c4.com, bpf <bpf@vger.kernel.org>
References: <683da55e.a00a0220.d8eae.0052.GAE@google.com>
Content-Language: en-US
Cc: Alexei Starovoitov <ast@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <683da55e.a00a0220.d8eae.0052.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/25 6:21 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4cb6c8af8591 selftests/filesystems: Fix build of anon_inod..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e8300c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5319177d225a42f1
> dashboard link: https://syzkaller.appspot.com/bug?extid=c4c7bf27f6b0c4bd97fe
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4cb6c8af.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bc0e5dfdd686/vmlinux-4cb6c8af.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2cdd323de6ca/bzImage-4cb6c8af.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000098: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000004c0-0x00000000000004c7]
> CPU: 1 UID: 0 PID: 5975 Comm: kworker/1:4 Not tainted 6.15.0-syzkaller-10402-g4cb6c8af8591 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: wg-kex-wg0 wg_packet_handshake_receive_worker
> RIP: 0010:netdev_get_tx_queue include/linux/netdevice.h:2636 [inline]
> RIP: 0010:veth_xdp_rcv.constprop.0+0x142/0xda0 drivers/net/veth.c:912
> Code: 54 d9 31 fb 45 85 e4 0f 85 db 08 00 00 e8 06 de 31 fb 48 8d bd c0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 18 0c 00 00 44 8b a5 c0 04 00
> RSP: 0018:ffffc900006a09b8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff868a1686
> RDX: 0000000000000098 RSI: ffffffff868a0d9a RDI: 00000000000004c0
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffc900006a0ff8 R12: 0000000000000001
> R13: 1ffff920000d4145 R14: ffffc900006a0e58 R15: ffff8880503d0000
> FS:  0000000000000000(0000) GS:ffff8880d686e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe5e3a6ad58 CR3: 000000000e382000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   veth_poll+0x19c/0x9c0 drivers/net/veth.c:979
>   __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7414
>   napi_poll net/core/dev.c:7478 [inline]
>   net_rx_action+0xa9f/0xfe0 net/core/dev.c:7605
>   handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
>   do_softirq kernel/softirq.c:480 [inline]
>   do_softirq+0xb2/0xf0 kernel/softirq.c:467
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
>   kernel_fpu_end+0x5e/0x70 arch/x86/kernel/fpu/core.c:476
>   blake2s_compress+0x7f/0xe0 arch/x86/lib/crypto/blake2s-glue.c:46
>   blake2s_final+0xc9/0x150 lib/crypto/blake2s.c:54
>   hmac.constprop.0+0x335/0x420 drivers/net/wireguard/noise.c:333
>   kdf.constprop.0+0x122/0x280 drivers/net/wireguard/noise.c:360
>   mix_dh+0xe8/0x150 drivers/net/wireguard/noise.c:413
>   wg_noise_handshake_consume_initiation+0x265/0x880 drivers/net/wireguard/noise.c:608
>   wg_receive_handshake_packet+0x219/0xbf0 drivers/net/wireguard/receive.c:144
>   wg_packet_handshake_receive_worker+0x17f/0x3a0 drivers/net/wireguard/receive.c:213
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3321 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:netdev_get_tx_queue include/linux/netdevice.h:2636 [inline]
> RIP: 0010:veth_xdp_rcv.constprop.0+0x142/0xda0 drivers/net/veth.c:912
> Code: 54 d9 31 fb 45 85 e4 0f 85 db 08 00 00 e8 06 de 31 fb 48 8d bd c0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 18 0c 00 00 44 8b a5 c0 04 00
> RSP: 0018:ffffc900006a09b8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff868a1686
> RDX: 0000000000000098 RSI: ffffffff868a0d9a RDI: 00000000000004c0
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffc900006a0ff8 R12: 0000000000000001
> R13: 1ffff920000d4145 R14: ffffc900006a0e58 R15: ffff8880503d0000
> FS:  0000000000000000(0000) GS:ffff8880d686e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe5e3a6ad58 CR3: 000000000e382000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------

Got a very similar call trace on current bpf-next (e41079f53e87) [1],
see a paste below.  It's flaky, couldn't reproduce so far.

Any relevant fixes in flight?

#629/1   xdp_veth_broadcast_redirect/0/BROADCAST:OK
#629/2   xdp_veth_broadcast_redirect/0/(BROADCAST | EXCLUDE_INGRESS):OK
#629/3   xdp_veth_broadcast_redirect/DRV_MODE/BROADCAST:OK
#629/4   xdp_veth_broadcast_redirect/DRV_MODE/(BROADCAST | 
EXCLUDE_INGRESS):OK
#629/5   xdp_veth_broadcast_redirect/SKB_MODE/BROADCAST:OK
#629/6   xdp_veth_broadcast_redirect/SKB_MODE/(BROADCAST | 
EXCLUDE_INGRESS):OK
#629     xdp_veth_broadcast_redirect:OK
[  343.217465] BUG: kernel NULL pointer dereference, address: 
0000000000000018
[  343.218173] #PF: supervisor read access in kernel mode
[  343.218644] #PF: error_code(0x0000) - not-present page
[  343.219128] PGD 0 P4D 0
[  343.219379] Oops: Oops: 0000 [#1] SMP NOPTI
[  343.219768] CPU: 1 UID: 0 PID: 7635 Comm: kworker/1:11 Tainted: G 
    W  OE       6.15.0-g2b36f2252b0a-dirty #7 PREEMPT(full)
[  343.220844] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  343.221436] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  343.222356] Workqueue: mld mld_dad_work
[  343.222730] RIP: 0010:veth_xdp_rcv.constprop.0+0x6b/0x380
[  343.223242] Code: 01 48 89 84 24 90 00 00 00 31 c0 48 8b aa 80 0c 00 
00 f3 48 ab e8 f5 e3 48 00 85 c0 0f 85 9c 02 00 00 4c 8d 34 5b 49 c1 e6 
07 <4c> 03 75 18 45 85 e4 0f 8e ec 02 00 00 31 db 31 ed eb 4c 48 83 e6
[  343.224977] RSP: 0018:ffff9aaa400e8ca8 EFLAGS: 00010246
[  343.225475] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
0000000000000002
[  343.226139] RDX: 0000000000000001 RSI: ffff8f22912a5000 RDI: 
ffff9aaa400e8d38
[  343.226808] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000000000000000
[  343.227484] R10: 0000000000000001 R11: ffff9aaa400e8ff8 R12: 
0000000000000040
[  343.228143] R13: ffff9aaa400e8d78 R14: 0000000000000000 R15: 
ffff8f220ad0f000
[  343.228820] FS:  0000000000000000(0000) GS:ffff8f22912a5000(0000) 
knlGS:0000000000000000
[  343.229572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  343.230118] CR2: 0000000000000018 CR3: 000000010ce45005 CR4: 
0000000000770ef0
[  343.230794] PKRU: 55555554
[  343.231061] Call Trace:
[  343.231306]  <IRQ>
[  343.231522]  veth_poll+0x7b/0x3a0
[  343.231856]  __napi_poll.constprop.0+0x28/0x1d0
[  343.232297]  net_rx_action+0x199/0x350
[  343.232682]  handle_softirqs+0xd3/0x400
[  343.233057]  ? __dev_queue_xmit+0x27b/0x1250
[  343.233473]  do_softirq+0x43/0x90
[  343.233804]  </IRQ>
[  343.234016]  <TASK>
[  343.234226]  __local_bh_enable_ip+0xb5/0xd0
[  343.234622]  ? __dev_queue_xmit+0x27b/0x1250
[  343.235035]  __dev_queue_xmit+0x290/0x1250
[  343.235431]  ? lock_acquire+0xbe/0x2c0
[  343.235797]  ? ip6_finish_output+0x25e/0x540
[  343.236210]  ? mark_held_locks+0x40/0x70
[  343.236583]  ip6_finish_output2+0x38f/0xb80
[  343.237002]  ? lock_release+0xc6/0x290
[  343.237364]  ip6_finish_output+0x25e/0x540
[  343.237761]  mld_sendpack+0x1c1/0x3a0
[  343.238123]  mld_dad_work+0x3e/0x150
[  343.238473]  process_one_work+0x1f8/0x580
[  343.238859]  worker_thread+0x1ce/0x3c0
[  343.239224]  ? __pfx_worker_thread+0x10/0x10
[  343.239638]  kthread+0x128/0x250
     [  343.239954]  ? __pfx_kthread+0x10/0x10
     [  343.240320]  ? __pfx_kthread+0x10/0x10
     [  343.240691]  ret_from_fork+0x15c/0x1b0
     [  343.241056]  ? __pfx_kthread+0x10/0x10
     [  343.241418]  ret_from_fork_asm+0x1a/0x30
     [  343.241800]  </TASK>
     [  343.242021] Modules linked in: bpf_testmod(OE) [last unloaded: 
bpf_test_no_cfi(OE)]
     [  343.242737] CR2: 0000000000000018
     [  343.243064] ---[ end trace 0000000000000000 ]---
     [  343.243503] RIP: 0010:veth_xdp_rcv.constprop.0+0x6b/0x380
     [  343.244014] Code: 01 48 89 84 24 90 00 00 00 31 c0 48 8b aa 80 
0c 00 00 f3 48 ab e8 f5 e3 48 00 85 c0 0f 85 9c 02 00 00 4c 8d 34 5b 49 
c1 e6 07 <4c> 03 75 18 45 85 e4 0f 8e ec 02 00 00 31 db 31 ed eb 4c 48 83 e6
     [  343.245743] RSP: 0018:ffff9aaa400e8ca8 EFLAGS: 00010246
     [  343.246236] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
0000000000000002
     [  343.246897] RDX: 0000000000000001 RSI: ffff8f22912a5000 RDI: 
ffff9aaa400e8d38
     [  343.247557] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000000000000000
     [  343.248219] R10: 0000000000000001 R11: ffff9aaa400e8ff8 R12: 
0000000000000040
     [  343.248868] R13: ffff9aaa400e8d78 R14: 0000000000000000 R15: 
ffff8f220ad0f000
     [  343.249496] FS:  0000000000000000(0000) 
GS:ffff8f22912a5000(0000) knlGS:0000000000000000
     [  343.250109] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     [  343.250651] CR2: 0000000000000018 CR3: 000000010ce45005 CR4: 
0000000000770ef0
     [  343.251320] PKRU: 55555554
     [  343.251548] Kernel panic - not syncing: Fatal exception in interrupt
     [  343.252317] Kernel Offset: 0x27000000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
     Failed to run command

     Caused by:
         0: Failed to QGA guest-exec-status
         1: error running guest_exec_status
         2: Broken pipe (os error 32)
         3: Broken pipe (os error 32)
     ##[error]Process completed with exit code 2.


[1] 
https://github.com/kernel-patches/bpf/actions/runs/15543380196/job/43759847203



> Code disassembly (best guess):
>     0:	54                   	push   %rsp
>     1:	d9 31                	fnstenv (%rcx)
>     3:	fb                   	sti
>     4:	45 85 e4             	test   %r12d,%r12d
>     7:	0f 85 db 08 00 00    	jne    0x8e8
>     d:	e8 06 de 31 fb       	call   0xfb31de18
>    12:	48 8d bd c0 04 00 00 	lea    0x4c0(%rbp),%rdi
>    19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    20:	fc ff df
>    23:	48 89 fa             	mov    %rdi,%rdx
>    26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>    2e:	84 c0                	test   %al,%al
>    30:	74 08                	je     0x3a
>    32:	3c 03                	cmp    $0x3,%al
>    34:	0f 8e 18 0c 00 00    	jle    0xc52
>    3a:	44                   	rex.R
>    3b:	8b                   	.byte 0x8b
>    3c:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
>    3d:	c0                   	.byte 0xc0
>    3e:	04 00                	add    $0x0,%al
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


