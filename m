Return-Path: <bpf+bounces-71356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A1BEFA52
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C9674EDA4D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8332BEC31;
	Mon, 20 Oct 2025 07:15:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 36EE12DAFDE
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944524; cv=none; b=but+9Eqj3cVzYDdqSojclHpgO82ALk7Q0Kav3FkmfYqO1Qj8jWttx7Gac8GqpXO5U8vJsFUDkS29ML2pivFX+GaYKoYQdrBDfXdfhGTWpZL7YN3hFblhKq21+++wZCsgHkwWX+6YzAIstqj29b52j5RnAgIdMBzHPFpSrZa0mEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944524; c=relaxed/simple;
	bh=PLzS2gUQYKZS74PMiwxmn9p4m1HpxEX8J6w9MZGOpsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBWuFiFDdN51eS5RQRu/Hvm2HTro8xR0YC+Zw2kam56Jbdwt7eF5/N7oLlr21EtCJQ3dPHhg+ODhHi5eCdLIXmPufjd/CaU/YV00M/nhve3Ky2/7KzFhq8WyaqmPFao8PHQcS1XhfJwhXT6P5IxFniHD0GgxS+KKk9aSzJWd0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 100.100.5.9 (helo [100.100.5.9])
    (reverse as null)
    by 100.100.3.18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.20-cur)
    for kerneljasonxing@gmail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Mon, 20 Oct 2025 09:15:20 +0200
Message-ID: <921fd025-9159-4221-9cd8-bbfef202ffed@nop.hu>
Date: Mon, 20 Oct 2025 09:15:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
Content-Language: en-US
From: mc36 <csmate@nop.hu>
In-Reply-To: <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 10/20/25 08:41, Jason Xing wrote:
>> this happens 10/10 on host or in qemu-system-x86_64-kvm running 6.16.12 or 6.17.2...
> 
> Thanks for the report.
> 
> I'm wondering if you have time to bisect which recent commit has
> brought this problem. It looks like it never happens before 6.16?
> 

no bisect done from my side yet, but i'll try to narrow this down a bit...

(i also just got the report from a packager of freertr.org and found the trigger)


all new info from my side is the decoded stack trace below, i'll do the same

for 6.17 and take a look on earlier kernels to see where it appeared first...

have a nice day,

csaba


mc36@noti:~/Downloads/linux-6.16.12/scripts$ ./decode_stacktrace.sh ../../usr/lib/debug/boot/vmlinux-6.16.12+deb14+1-amd64 < /nfs/temp/linux-xsk.txt

p4emu login: [  119.074634] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  119.076747] #PF: supervisor read access in kernel mode
[  119.078334] #PF: error_code(0x0000) - not-present page
[  119.079855] PGD 0 P4D 0
[  119.080648] Oops: Oops: 0000 [#1] SMP NOPTI
[  119.081993] CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
[  119.085247] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  119.088065] RIP: 0010:xsk_destruct_skb (net/xdp/xsk.c:573 net/xdp/xsk.c:613)
[ 119.089502] Code: 40 10 48 89 cf 89 28 e8 9e 7e 07 00 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c8 cc da ff 48 8b 7b 30 4c 8d 5b 30 <48> 8b 07 4c 8d 67 f8 4c 8d 70 f8 
49 39 fb 74 b7 48 89 5c 24 10 4c
All code
========
    0: 40 10 48 89           rex adc %cl,-0x77(%rax)
    4: cf                    iret
    5: 89 28                 mov    %ebp,(%rax)
    7: e8 9e 7e 07 00        call   0x77eaa
    c: 48 89 df              mov    %rbx,%rdi
    f: 48 83 c4 18           add    $0x18,%rsp
   13: 5b                    pop    %rbx
   14: 5d                    pop    %rbp
   15: 41 5c                 pop    %r12
   17: 41 5d                 pop    %r13
   19: 41 5e                 pop    %r14
   1b: 41 5f                 pop    %r15
   1d: e9 c8 cc da ff        jmp    0xffffffffffdaccea
   22: 48 8b 7b 30           mov    0x30(%rbx),%rdi
   26: 4c 8d 5b 30           lea    0x30(%rbx),%r11
   2a:* 48 8b 07              mov    (%rdi),%rax  <-- trapping instruction
   2d: 4c 8d 67 f8           lea    -0x8(%rdi),%r12
   31: 4c 8d 70 f8           lea    -0x8(%rax),%r14
   35: 49 39 fb              cmp    %rdi,%r11
   38: 74 b7                 je     0xfffffffffffffff1
   3a: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
   3f: 4c                    rex.WR

Code starting with the faulting instruction
===========================================
    0: 48 8b 07              mov    (%rdi),%rax
    3: 4c 8d 67 f8           lea    -0x8(%rdi),%r12
    7: 4c 8d 70 f8           lea    -0x8(%rax),%r14
    b: 49 39 fb              cmp    %rdi,%r11
    e: 74 b7                 je     0xffffffffffffffc7
   10: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
   15: 4c                    rex.WR
[  119.094947] RSP: 0018:ffffcd5b4012cd48 EFLAGS: 00010002
[  119.096499] RAX: ffffcd5b40fcf000 RBX: ffff898e05dfcf00 RCX: ffff898e043cf9e8
[  119.098612] RDX: ffff898e048ccc80 RSI: 0000000000000246 RDI: 0000000000000000
[  119.100687] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff898e01d21900
[  119.102794] R10: 0000000000000000 R11: ffff898e05dfcf30 R12: ffff898e05f95000
[  119.104880] R13: ffff898e043cf900 R14: ffff898e7dd32bd0 R15: 0000000000000002
[  119.107000] FS:  00007f0cd9e0a6c0(0000) GS:ffff898ede530000(0000) knlGS:0000000000000000
[  119.109358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  119.111080] CR2: 0000000000000000 CR3: 00000000043ba003 CR4: 0000000000372ef0
[  119.113175] Call Trace:
[  119.113996]  <IRQ>
[  119.114662] ? napi_complete_done (include/linux/list.h:37 (discriminator 2) include/net/gro.h:533 (discriminator 2) include/net/gro.h:528 (discriminator 2) net/core/dev.c:6592 
(discriminator 2))
[  119.115952] ip_rcv_core (include/linux/skbuff.h:3329 net/ipv4/ip_input.c:539)
[  119.117050] ip_rcv (net/ipv4/ip_input.c:565)
[  119.118014] __netif_receive_skb_one_core (net/core/dev.c:5989 (discriminator 4))
[  119.119468] process_backlog (include/linux/rcupdate.h:873 net/core/dev.c:6455)
[  119.120617] __napi_poll (net/core/dev.c:7426)
[  119.121685] net_rx_action (net/core/dev.c:7492 net/core/dev.c:7617)
[  119.122850] handle_softirqs (kernel/softirq.c:579)
[  119.124003] ? handle_edge_irq (kernel/irq/chip.c:799)
[  119.125218] do_softirq.part.0 (kernel/softirq.c:480 (discriminator 20))
[  119.126422]  </IRQ>
[  119.127085]  <TASK>
[  119.127753] __local_bh_enable_ip (kernel/softirq.c:482 kernel/softirq.c:407)
[  119.128998] __dev_direct_xmit (net/core/dev.c:4786)
[  119.130128] __xsk_generic_xmit (net/xdp/xsk.c:907)
[  119.131184] ? __remove_hrtimer (kernel/time/hrtimer.c:1121 (discriminator 1))
[  119.132199] ? __xsk_generic_xmit (net/xdp/xsk.c:941)
[  119.133300] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:562 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:204 
include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[  119.134637] xsk_sendmsg (net/xdp/xsk.c:949 net/xdp/xsk.c:1003 net/xdp/xsk.c:1013)
[  119.135580] __sys_sendto (net/socket.c:714 (discriminator 1) net/socket.c:729 (discriminator 1) net/socket.c:2182 (discriminator 1))
[  119.136509] __x64_sys_sendto (net/socket.c:2189 (discriminator 1) net/socket.c:2185 (discriminator 1) net/socket.c:2185 (discriminator 1))
[  119.137493] do_syscall_64 (arch/x86/entry/syscall_64.c:66 (discriminator 1) arch/x86/entry/syscall_64.c:97 (discriminator 1))
[  119.138452] ? __pfx_pollwake (fs/select.c:209)
[  119.139454] ? __rseq_handle_notify_resume (kernel/rseq.c:439 (discriminator 1))
[  119.140718] ? restore_fpregs_from_fpstate (arch/x86/kernel/fpu/xstate.h:240 arch/x86/kernel/fpu/core.c:205)
[  119.141999] ? switch_fpu_return (arch/x86/kernel/fpu/context.h:49 (discriminator 5) arch/x86/kernel/fpu/context.h:76 (discriminator 5) arch/x86/kernel/fpu/core.c:830 
(discriminator 5))
[  119.143023] ? do_syscall_64 (arch/x86/include/asm/entry-common.h:57 arch/x86/include/asm/entry-common.h:66 include/linux/entry-common.h:332 include/linux/entry-common.h:414 
include/linux/entry-common.h:449 arch/x86/entry/syscall_64.c:103)
[  119.144007] ? do_syscall_64 (arch/x86/include/asm/entry-common.h:57 arch/x86/include/asm/entry-common.h:66 include/linux/entry-common.h:332 include/linux/entry-common.h:414 
include/linux/entry-common.h:449 arch/x86/entry/syscall_64.c:103)
[  119.144990] ? do_syscall_64 (arch/x86/include/asm/entry-common.h:57 arch/x86/include/asm/entry-common.h:66 include/linux/entry-common.h:332 include/linux/entry-common.h:414 
include/linux/entry-common.h:449 arch/x86/entry/syscall_64.c:103)
[  119.146022] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  119.147278] RIP: 0033:0x7f0cde0a49ee
[ 119.148217] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 
0f 1f 80 00 00 00 00 48 83 ec 08
All code
========
    0: 08 0f                 or     %cl,(%rdi)
    2: 85 f5                 test   %esi,%ebp
    4: 4b ff                 rex.WXB (bad)
    6: ff 49 89              decl   -0x77(%rcx)
    9: fb                    sti
    a: 48 89 f0              mov    %rsi,%rax
    d: 48 89 d7              mov    %rdx,%rdi
   10: 48 89 ce              mov    %rcx,%rsi
   13: 4c 89 c2              mov    %r8,%rdx
   16: 4d 89 ca              mov    %r9,%r10
   19: 4c 8b 44 24 08        mov    0x8(%rsp),%r8
   1e: 4c 8b 4c 24 10        mov    0x10(%rsp),%r9
   23: 4c 89 5c 24 08        mov    %r11,0x8(%rsp)
   28: 0f 05                 syscall
   2a:* c3                    ret  <-- trapping instruction
   2b: 66 2e 0f 1f 84 00 00  cs nopw 0x0(%rax,%rax,1)
   32: 00 00 00
   35: 0f 1f 80 00 00 00 00  nopl   0x0(%rax)
   3c: 48 83 ec 08           sub    $0x8,%rsp

Code starting with the faulting instruction
===========================================
    0: c3                    ret
    1: 66 2e 0f 1f 84 00 00  cs nopw 0x0(%rax,%rax,1)
    8: 00 00 00
    b: 0f 1f 80 00 00 00 00  nopl   0x0(%rax)
   12: 48 83 ec 08           sub    $0x8,%rsp
[  119.152877] RSP: 002b:00007f0cd9e09c98 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  119.154774] RAX: ffffffffffffffda RBX: 00007f0cd9e0a6c0 RCX: 00007f0cde0a49ee
[  119.156526] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000029
[  119.158317] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[  119.160078] R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000405
[  119.161893] R13: 00007f0ccc055ce0 R14: 0000000000000001 R15: 00007f0cde8db900
[  119.163646]  </TASK>
[  119.164243] Modules linked in: veth intel_rapl_msr intel_rapl_common iosf_mbi binfmt_misc kvm_intel kvm irqbypass ghash_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel rapl 
button evdev sg efi_pstore configfs nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables autofs4 sd_mod 
sr_mod cdrom ata_generic ata_piix libata virtio_net scsi_mod net_failover serio_raw failover scsi_common
[  119.174216] CR2: 0000000000000000
[  119.175068] ---[ end trace 0000000000000000 ]---
[  119.176224] RIP: 0010:xsk_destruct_skb (net/xdp/xsk.c:573 net/xdp/xsk.c:613)
[ 119.177432] Code: 40 10 48 89 cf 89 28 e8 9e 7e 07 00 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c8 cc da ff 48 8b 7b 30 4c 8d 5b 30 <48> 8b 07 4c 8d 67 f8 4c 8d 70 f8 
49 39 fb 74 b7 48 89 5c 24 10 4c
All code
========
    0: 40 10 48 89           rex adc %cl,-0x77(%rax)
    4: cf                    iret
    5: 89 28                 mov    %ebp,(%rax)
    7: e8 9e 7e 07 00        call   0x77eaa
    c: 48 89 df              mov    %rbx,%rdi
    f: 48 83 c4 18           add    $0x18,%rsp
   13: 5b                    pop    %rbx
   14: 5d                    pop    %rbp
   15: 41 5c                 pop    %r12
   17: 41 5d                 pop    %r13
   19: 41 5e                 pop    %r14
   1b: 41 5f                 pop    %r15
   1d: e9 c8 cc da ff        jmp    0xffffffffffdaccea
   22: 48 8b 7b 30           mov    0x30(%rbx),%rdi
   26: 4c 8d 5b 30           lea    0x30(%rbx),%r11
   2a:* 48 8b 07              mov    (%rdi),%rax  <-- trapping instruction
   2d: 4c 8d 67 f8           lea    -0x8(%rdi),%r12
   31: 4c 8d 70 f8           lea    -0x8(%rax),%r14
   35: 49 39 fb              cmp    %rdi,%r11
   38: 74 b7                 je     0xfffffffffffffff1
   3a: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
   3f: 4c                    rex.WR

Code starting with the faulting instruction
===========================================
    0: 48 8b 07              mov    (%rdi),%rax
    3: 4c 8d 67 f8           lea    -0x8(%rdi),%r12
    7: 4c 8d 70 f8           lea    -0x8(%rax),%r14
    b: 49 39 fb              cmp    %rdi,%r11
    e: 74 b7                 je     0xffffffffffffffc7
   10: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
   15: 4c                    rex.WR
[  119.182155] RSP: 0018:ffffcd5b4012cd48 EFLAGS: 00010002
[  119.183462] RAX: ffffcd5b40fcf000 RBX: ffff898e05dfcf00 RCX: ffff898e043cf9e8
[  119.185237] RDX: ffff898e048ccc80 RSI: 0000000000000246 RDI: 0000000000000000
[  119.187022] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff898e01d21900
[  119.188872] R10: 0000000000000000 R11: ffff898e05dfcf30 R12: ffff898e05f95000
[  119.190693] R13: ffff898e043cf900 R14: ffff898e7dd32bd0 R15: 0000000000000002
[  119.192655] FS:  00007f0cd9e0a6c0(0000) GS:ffff898ede530000(0000) knlGS:0000000000000000
[  119.194681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  119.196244] CR2: 0000000000000000 CR3: 00000000043ba003 CR4: 0000000000372ef0
[  119.198034] Kernel panic - not syncing: Fatal exception in interrupt
[  119.199761] Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  119.202403] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
mc36@noti:~/Downloads/linux-6.16.12/scripts$



