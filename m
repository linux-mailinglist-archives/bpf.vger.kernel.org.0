Return-Path: <bpf+bounces-71368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE24BF00BB
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF43BB090
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4395C2C0261;
	Mon, 20 Oct 2025 08:55:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 732A92EB875
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950510; cv=none; b=W989KvcrnflLswCcM9qtrN2O3fc+RqiMUy9A/nSJi4qgKnq33LCjj9OboQRJjXpSz8AKDFkMs1yzd8UWPlO0qWlBFpj3DsWXYodviq1x2Avi5egfsrWoF2kCItiUg8Elci1fy87CjPkbL9CvItVPhRCt7xEiDn1s9vIsZjMmeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950510; c=relaxed/simple;
	bh=B2XoDy5imgLvEK/09h3ifNLGJGy1izC6R78Ip85z6jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjJE0/akOWv6zPOpLGrjhVcDcC3sH+i6mBxrcEEAyE7jHM1IDp2LDQLbvku9H/rYvFsQoKCEgwfvNjPNtPEy5S9aQDIBTx4jXVBUSv3+uWZTYRqcHOO6jkiJZM43owksvT6xz7MpYHly2v6vot5jDRf2tlfg7WZky6KTismn8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 100.100.5.9 (helo [100.100.5.9])
    (reverse as null)
    by 100.100.3.18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.20-cur)
    for kerneljasonxing@gmail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Mon, 20 Oct 2025 10:55:05 +0200
Message-ID: <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
Date: Mon, 20 Oct 2025 10:55:04 +0200
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
> Hi,
> 
>> this happens 10/10 on host or in qemu-system-x86_64-kvm running 6.16.12 or 6.17.2...
> 
> Thanks for the report.
> 
> I'm wondering if you have time to bisect which recent commit has
> brought this problem. It looks like it never happens before 6.16?
> 

and now confirming that 6.16.7 survives the reproducer code and 6.16.8 crashes...

below is the decoded and raw 6.17 trace... regarding the exact commit hash, i

would leave the chance for someone with much more resources than i have at hand....

have a nice day,

csaba




mc36@noti:~/Downloads/linux-6.17.2/scripts$ ./decode_stacktrace.sh ../../usr/lib/debug/boot/
System.map-6.17.2-cloud-amd64  vmlinux-6.17.2-cloud-amd64
mc36@noti:~/Downloads/linux-6.17.2/scripts$ ./decode_stacktrace.sh ../../usr/lib/debug/boot/vmlinux-6.17.2-cloud-amd64 <  ../../6172.txt
p4emu login: [  171.272491] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  171.274678] #PF: supervisor read access in kernel mode
[  171.276216] #PF: error_code(0x0000) - not-present page
[  171.277732] PGD 0 P4D 0
[  171.278531] Oops: Oops: 0000 [#1] SMP NOPTI
[  171.279806] CPU: 3 UID: 1 PID: 798 Comm: a.out Not tainted 6.17.2-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.17.2-1~exp1
[  171.282885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  171.285663] RIP: 0010:xsk_destruct_skb (net/xdp/xsk.c:577 net/xdp/xsk.c:617)
[ 171.288015] Code: 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f a5 d9 ff 48 8b 43 30 4c 8d 4b 30 48 89 c7 49 39 c1 74 bf 4c 8d 60 f8 <48> 8b 00 4c 89 3c 24 4d 89 cf 48 
89 5c 24 08 89 d3 48 89 74 24 10
All code
========
    0: 48 89 df              mov    %rbx,%rdi
    3: 48 83 c4 18           add    $0x18,%rsp
    7: 5b                    pop    %rbx
    8: 5d                    pop    %rbp
    9: 41 5c                 pop    %r12
    b: 41 5d                 pop    %r13
    d: 41 5e                 pop    %r14
    f: 41 5f                 pop    %r15
   11: e9 1f a5 d9 ff        jmp    0xffffffffffd9a535
   16: 48 8b 43 30           mov    0x30(%rbx),%rax
   1a: 4c 8d 4b 30           lea    0x30(%rbx),%r9
   1e: 48 89 c7              mov    %rax,%rdi
   21: 49 39 c1              cmp    %rax,%r9
   24: 74 bf                 je     0xffffffffffffffe5
   26: 4c 8d 60 f8           lea    -0x8(%rax),%r12
   2a:* 48 8b 00              mov    (%rax),%rax  <-- trapping instruction
   2d: 4c 89 3c 24           mov    %r15,(%rsp)
   31: 4d 89 cf              mov    %r9,%r15
   34: 48 89 5c 24 08        mov    %rbx,0x8(%rsp)
   39: 89 d3                 mov    %edx,%ebx
   3b: 48 89 74 24 10        mov    %rsi,0x10(%rsp)

Code starting with the faulting instruction
===========================================
    0: 48 8b 00              mov    (%rax),%rax
    3: 4c 89 3c 24           mov    %r15,(%rsp)
    7: 4d 89 cf              mov    %r9,%r15
    a: 48 89 5c 24 08        mov    %rbx,0x8(%rsp)
    f: 89 d3                 mov    %edx,%ebx
   11: 48 89 74 24 10        mov    %rsi,0x10(%rsp)
[  171.293459] RSP: 0018:ffffcb43c0160d48 EFLAGS: 00010086
[  171.295023] RAX: 0000000000000000 RBX: ffff8a660484e500 RCX: 0000000000000000
[  171.297112] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
[  171.299266] RBP: 0000000000000001 R08: ffff8a66023b4780 R09: ffff8a660484e530
[  171.301348] R10: 0000000000000000 R11: fffff1384008ed00 R12: fffffffffffffff8
[  171.303453] R13: ffff8a667ddb2c50 R14: ffff8a6603c59400 R15: ffff8a6603c594e8
[  171.305609] FS:  00007fd4cdcad740(0000) GS:ffff8a66c87ee000(0000) knlGS:0000000000000000
[  171.307969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.309663] CR2: 0000000000000000 CR3: 000000000593e003 CR4: 0000000000372ef0
[  171.311756] Call Trace:
[  171.313372]  <IRQ>
[  171.314083] ? napi_complete_done (include/linux/list.h:37 (discriminator 2) include/net/gro.h:533 (discriminator 2) include/net/gro.h:528 (discriminator 2) include/net/gro.h:540 
(discriminator 2) net/core/dev.c:6593 (discriminator 2))
[  171.315355] ip_rcv_core (include/linux/skbuff.h:3329 net/ipv4/ip_input.c:545)
[  171.316400] ip_rcv (net/ipv4/ip_input.c:571)
[  171.317303] __netif_receive_skb_one_core (net/core/dev.c:5991 (discriminator 6))
[  171.318720] process_backlog (include/linux/rcupdate.h:873 net/core/dev.c:6457)
[  171.319804] __napi_poll (net/core/dev.c:7506)
[  171.320776] net_rx_action (net/core/dev.c:7569 net/core/dev.c:7696)
[  171.321816] handle_softirqs (kernel/softirq.c:579)
[  171.322885] do_softirq.part.0 (kernel/softirq.c:480 (discriminator 25))
[  171.323949]  </IRQ>
[  171.324510]  <TASK>
[  171.325070] __local_bh_enable_ip (kernel/softirq.c:482 kernel/softirq.c:407)
[  171.326122] __dev_direct_xmit (net/core/dev.c:4786)
[  171.327208] __xsk_generic_xmit (net/xdp/xsk.c:912)
[  171.328253] ? obj_cgroup_charge_account (mm/memcontrol.c:2939 (discriminator 2) mm/memcontrol.c:3071 (discriminator 2))
[  171.329506] xsk_sendmsg (net/xdp/xsk.c:953 net/xdp/xsk.c:1007 net/xdp/xsk.c:1017)
[  171.330424] __sys_sendto (net/socket.c:714 (discriminator 20) net/socket.c:729 (discriminator 20) net/socket.c:2228 (discriminator 20))
[  171.331380] __x64_sys_sendto (net/socket.c:2235 (discriminator 1) net/socket.c:2231 (discriminator 1) net/socket.c:2231 (discriminator 1))
[  171.332351] do_syscall_64 (arch/x86/entry/syscall_64.c:66 (discriminator 1) arch/x86/entry/syscall_64.c:97 (discriminator 1))
[  171.333308] ? ttwu_queue_wakelist (kernel/sched/core.c:3988 kernel/sched/core.c:3983)
[  171.334449] ? set_task_cpu (kernel/sched/sched.h:2168 kernel/sched/sched.h:2199 kernel/sched/core.c:3372)
[  171.335449] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:562 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:204 
include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[  171.336685] ? try_to_wake_up (kernel/sched/core.c:4331)
[  171.337696] ? kick_pool (kernel/workqueue.c:1285)
[  171.338643] ? __tty_insert_flip_string_flags (drivers/tty/tty_buffer.c:318 (discriminator 25))
[  171.339978] ? tty_insert_flip_string_and_push_buffer (drivers/tty/tty_buffer.c:565)
[  171.341477] ? remove_wait_queue (include/linux/list.h:215 (discriminator 1) include/linux/list.h:229 (discriminator 1) include/linux/wait.h:209 (discriminator 1) 
kernel/sched/wait.c:74 (discriminator 1))
[  171.342552] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:562 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:204 
include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[  171.343788] ? n_tty_write (drivers/tty/n_tty.c:2428 (discriminator 1))
[  171.344746] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/paravirt.h:562 arch/x86/include/asm/qspinlock.h:57 include/linux/spinlock.h:204 
include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[  171.345974] ? __wake_up (kernel/sched/wait.c:129 kernel/sched/wait.c:146)
[  171.346880] ? file_tty_write.isra.0 (drivers/tty/tty_io.c:1082)
[  171.348058] ? vfs_write (fs/read_write.c:593 fs/read_write.c:686)
[  171.348975] ? ksys_write (fs/read_write.c:739)
[  171.349868] ? do_syscall_64 (arch/x86/include/asm/entry-common.h:65 (discriminator 1) include/linux/irq-entry-common.h:227 (discriminator 1) include/linux/entry-common.h:175 
(discriminator 1) include/linux/entry-common.h:210 (discriminator 1) arch/x86/entry/syscall_64.c:103 (discriminator 1))
[  171.350877] ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
[  171.351993] ? exc_page_fault (arch/x86/include/asm/paravirt.h:666 arch/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532)
[  171.353032] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  171.354303] RIP: 0033:0x7fd4cdeb6687
[ 171.355252] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 
39 83 fa 08 75 de e8 23 ff ff ff
All code
========
    0: 48 89 fa              mov    %rdi,%rdx
    3: 4c 89 df              mov    %r11,%rdi
    6: e8 58 b3 00 00        call   0xb363
    b: 8b 93 08 03 00 00     mov    0x308(%rbx),%edx
   11: 59                    pop    %rcx
   12: 5e                    pop    %rsi
   13: 48 83 f8 fc           cmp    $0xfffffffffffffffc,%rax
   17: 74 1a                 je     0x33
   19: 5b                    pop    %rbx
   1a: c3                    ret
   1b: 0f 1f 84 00 00 00 00  nopl   0x0(%rax,%rax,1)
   22: 00
   23: 48 8b 44 24 10        mov    0x10(%rsp),%rax
   28: 0f 05                 syscall
   2a:* 5b                    pop    %rbx  <-- trapping instruction
   2b: c3                    ret
   2c: 0f 1f 80 00 00 00 00  nopl   0x0(%rax)
   33: 83 e2 39              and    $0x39,%edx
   36: 83 fa 08              cmp    $0x8,%edx
   39: 75 de                 jne    0x19
   3b: e8 23 ff ff ff        call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
    0: 5b                    pop    %rbx
    1: c3                    ret
    2: 0f 1f 80 00 00 00 00  nopl   0x0(%rax)
    9: 83 e2 39              and    $0x39,%edx
    c: 83 fa 08              cmp    $0x8,%edx
    f: 75 de                 jne    0xffffffffffffffef
   11: e8 23 ff ff ff        call   0xffffffffffffff39
[  171.359811] RSP: 002b:00007ffcfccf4800 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  171.361671] RAX: ffffffffffffffda RBX: 00007fd4cdcad740 RCX: 00007fd4cdeb6687
[  171.363457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[  171.365232] RBP: 00007ffcfccf4ad0 R08: 0000000000000000 R09: 0000000000000000
[  171.367016] R10: 0000000000000040 R11: 0000000000000202 R12: 0000000000000000
[  171.368807] R13: 00007ffcfccf4bf8 R14: 00007fd4ce082000 R15: 00005646beb2adc8
[  171.370582]  </TASK>
[  171.371203] Modules linked in: veth intel_rapl_msr intel_rapl_common binfmt_misc iosf_mbi kvm_intel kvm irqbypass ghash_clmulni_intel aesni_intel rapl button evdev sg efi_pstore 
configfs nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg autofs4 sr_mod sd_mod cdrom ata_generic ata_piix libata 
virtio_net scsi_mod net_failover serio_raw failover scsi_common
[  171.380065] CR2: 0000000000000000
[  171.380992] ---[ end trace 0000000000000000 ]---
[  171.382231] RIP: 0010:xsk_destruct_skb (net/xdp/xsk.c:577 net/xdp/xsk.c:617)
[ 171.383454] Code: 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f a5 d9 ff 48 8b 43 30 4c 8d 4b 30 48 89 c7 49 39 c1 74 bf 4c 8d 60 f8 <48> 8b 00 4c 89 3c 24 4d 89 cf 48 
89 5c 24 08 89 d3 48 89 74 24 10
All code
========
    0: 48 89 df              mov    %rbx,%rdi
    3: 48 83 c4 18           add    $0x18,%rsp
    7: 5b                    pop    %rbx
    8: 5d                    pop    %rbp
    9: 41 5c                 pop    %r12
    b: 41 5d                 pop    %r13
    d: 41 5e                 pop    %r14
    f: 41 5f                 pop    %r15
   11: e9 1f a5 d9 ff        jmp    0xffffffffffd9a535
   16: 48 8b 43 30           mov    0x30(%rbx),%rax
   1a: 4c 8d 4b 30           lea    0x30(%rbx),%r9
   1e: 48 89 c7              mov    %rax,%rdi
   21: 49 39 c1              cmp    %rax,%r9
   24: 74 bf                 je     0xffffffffffffffe5
   26: 4c 8d 60 f8           lea    -0x8(%rax),%r12
   2a:* 48 8b 00              mov    (%rax),%rax  <-- trapping instruction
   2d: 4c 89 3c 24           mov    %r15,(%rsp)
   31: 4d 89 cf              mov    %r9,%r15
   34: 48 89 5c 24 08        mov    %rbx,0x8(%rsp)
   39: 89 d3                 mov    %edx,%ebx
   3b: 48 89 74 24 10        mov    %rsi,0x10(%rsp)

Code starting with the faulting instruction
===========================================
    0: 48 8b 00              mov    (%rax),%rax
    3: 4c 89 3c 24           mov    %r15,(%rsp)
    7: 4d 89 cf              mov    %r9,%r15
    a: 48 89 5c 24 08        mov    %rbx,0x8(%rsp)
    f: 89 d3                 mov    %edx,%ebx
   11: 48 89 74 24 10        mov    %rsi,0x10(%rsp)
[  171.388004] RSP: 0018:ffffcb43c0160d48 EFLAGS: 00010086
[  171.389300] RAX: 0000000000000000 RBX: ffff8a660484e500 RCX: 0000000000000000
[  171.391131] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
[  171.392879] RBP: 0000000000000001 R08: ffff8a66023b4780 R09: ffff8a660484e530
[  171.394689] R10: 0000000000000000 R11: fffff1384008ed00 R12: fffffffffffffff8
[  171.396490] R13: ffff8a667ddb2c50 R14: ffff8a6603c59400 R15: ffff8a6603c594e8
[  171.398252] FS:  00007fd4cdcad740(0000) GS:ffff8a66c87ee000(0000) knlGS:0000000000000000
[  171.400259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.401669] CR2: 0000000000000000 CR3: 000000000593e003 CR4: 0000000000372ef0
[  171.403446] Kernel panic - not syncing: Fatal exception in interrupt
[  171.405183] Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  171.407880] Rebooting in 10 seconds..












p4emu login: [  171.272491] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  171.274678] #PF: supervisor read access in kernel mode
[  171.276216] #PF: error_code(0x0000) - not-present page
[  171.277732] PGD 0 P4D 0
[  171.278531] Oops: Oops: 0000 [#1] SMP NOPTI
[  171.279806] CPU: 3 UID: 1 PID: 798 Comm: a.out Not tainted 6.17.2-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.17.2-1~exp1
[  171.282885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  171.285663] RIP: 0010:xsk_destruct_skb+0xd5/0x180
[  171.288015] Code: 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f a5 d9 ff 48 8b 43 30 4c 8d 4b 30 48 89 c7 49 39 c1 74 bf 4c 8d 60 f8 <48> 8b 00 4c 89 3c 24 4d 89 cf 
48 89 5c 24 08 89 d3 48 89 74 24 10
[  171.293459] RSP: 0018:ffffcb43c0160d48 EFLAGS: 00010086
[  171.295023] RAX: 0000000000000000 RBX: ffff8a660484e500 RCX: 0000000000000000
[  171.297112] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
[  171.299266] RBP: 0000000000000001 R08: ffff8a66023b4780 R09: ffff8a660484e530
[  171.301348] R10: 0000000000000000 R11: fffff1384008ed00 R12: fffffffffffffff8
[  171.303453] R13: ffff8a667ddb2c50 R14: ffff8a6603c59400 R15: ffff8a6603c594e8
[  171.305609] FS:  00007fd4cdcad740(0000) GS:ffff8a66c87ee000(0000) knlGS:0000000000000000
[  171.307969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.309663] CR2: 0000000000000000 CR3: 000000000593e003 CR4: 0000000000372ef0
[  171.311756] Call Trace:
[  171.313372]  <IRQ>
[  171.314083]  ? napi_complete_done+0x82/0x1c0
[  171.315355]  ip_rcv_core+0x1bd/0x350
[  171.316400]  ip_rcv+0x30/0x1f0
[  171.317303]  __netif_receive_skb_one_core+0x85/0xa0
[  171.318720]  process_backlog+0x87/0x130
[  171.319804]  __napi_poll+0x2e/0x1e0
[  171.320776]  net_rx_action+0x338/0x420
[  171.321816]  handle_softirqs+0xd4/0x310
[  171.322885]  do_softirq.part.0+0x3b/0x60
[  171.323949]  </IRQ>
[  171.324510]  <TASK>
[  171.325070]  __local_bh_enable_ip+0x60/0x70
[  171.326122]  __dev_direct_xmit+0x146/0x1e0
[  171.327208]  __xsk_generic_xmit+0x4a7/0xba0
[  171.328253]  ? obj_cgroup_charge_account+0x145/0x420
[  171.329506]  xsk_sendmsg+0xe3/0x1c0
[  171.330424]  __sys_sendto+0x1f2/0x200
[  171.331380]  __x64_sys_sendto+0x24/0x30
[  171.332351]  do_syscall_64+0x82/0x2f0
[  171.333308]  ? ttwu_queue_wakelist+0x13d/0x230
[  171.334449]  ? set_task_cpu+0xc4/0x1d0
[  171.335449]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  171.336685]  ? try_to_wake_up+0x371/0x8b0
[  171.337696]  ? kick_pool+0x5f/0x180
[  171.338643]  ? __tty_insert_flip_string_flags+0x93/0x120
[  171.339978]  ? tty_insert_flip_string_and_push_buffer+0x8d/0xc0
[  171.341477]  ? remove_wait_queue+0x24/0x60
[  171.342552]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  171.343788]  ? n_tty_write+0x3e1/0x550
[  171.344746]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  171.345974]  ? __wake_up+0x44/0x60
[  171.346880]  ? file_tty_write.isra.0+0x211/0x2c0
[  171.348058]  ? vfs_write+0x25a/0x480
[  171.348975]  ? ksys_write+0x73/0xf0
[  171.349868]  ? do_syscall_64+0xbb/0x2f0
[  171.350877]  ? do_user_addr_fault+0x21a/0x690
[  171.351993]  ? exc_page_fault+0x74/0x180
[  171.353032]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  171.354303] RIP: 0033:0x7fd4cdeb6687
[  171.355252] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 
e2 39 83 fa 08 75 de e8 23 ff ff ff
[  171.359811] RSP: 002b:00007ffcfccf4800 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  171.361671] RAX: ffffffffffffffda RBX: 00007fd4cdcad740 RCX: 00007fd4cdeb6687
[  171.363457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[  171.365232] RBP: 00007ffcfccf4ad0 R08: 0000000000000000 R09: 0000000000000000
[  171.367016] R10: 0000000000000040 R11: 0000000000000202 R12: 0000000000000000
[  171.368807] R13: 00007ffcfccf4bf8 R14: 00007fd4ce082000 R15: 00005646beb2adc8
[  171.370582]  </TASK>
[  171.371203] Modules linked in: veth intel_rapl_msr intel_rapl_common binfmt_misc iosf_mbi kvm_intel kvm irqbypass ghash_clmulni_intel aesni_intel rapl button evdev sg efi_pstore 
configfs nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg autofs4 sr_mod sd_mod cdrom ata_generic ata_piix libata 
virtio_net scsi_mod net_failover serio_raw failover scsi_common
[  171.380065] CR2: 0000000000000000
[  171.380992] ---[ end trace 0000000000000000 ]---
[  171.382231] RIP: 0010:xsk_destruct_skb+0xd5/0x180
[  171.383454] Code: 48 89 df 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f a5 d9 ff 48 8b 43 30 4c 8d 4b 30 48 89 c7 49 39 c1 74 bf 4c 8d 60 f8 <48> 8b 00 4c 89 3c 24 4d 89 cf 
48 89 5c 24 08 89 d3 48 89 74 24 10
[  171.388004] RSP: 0018:ffffcb43c0160d48 EFLAGS: 00010086
[  171.389300] RAX: 0000000000000000 RBX: ffff8a660484e500 RCX: 0000000000000000
[  171.391131] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
[  171.392879] RBP: 0000000000000001 R08: ffff8a66023b4780 R09: ffff8a660484e530
[  171.394689] R10: 0000000000000000 R11: fffff1384008ed00 R12: fffffffffffffff8
[  171.396490] R13: ffff8a667ddb2c50 R14: ffff8a6603c59400 R15: ffff8a6603c594e8
[  171.398252] FS:  00007fd4cdcad740(0000) GS:ffff8a66c87ee000(0000) knlGS:0000000000000000
[  171.400259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.401669] CR2: 0000000000000000 CR3: 000000000593e003 CR4: 0000000000372ef0
[  171.403446] Kernel panic - not syncing: Fatal exception in interrupt
[  171.405183] Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  171.407880] Rebooting in 10 seconds..


