Return-Path: <bpf+bounces-8893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4A78C19C
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12082281004
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7C14F7D;
	Tue, 29 Aug 2023 09:38:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2A14F67
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:38:13 +0000 (UTC)
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222819A
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 02:38:06 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-68a6cd7c6c0so4192275b3a.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301886; x=1693906686;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsaVmTHT6KB1afBBEa7ZwHcj95DEU0gGBnb9UPz3zzE=;
        b=cuh1hE0pN4iI67sQzjiP/Oau/Rle0PD0keMf5HlXOhkxdEGcS+6R57CZlcjRqX6iy+
         moVtBB4NUXyjeIXdjYlPrjSUrpP4QObIn1BE0yHfOPMdZ2He+drZwzVwxJI6iHT7v4d7
         5GhUL4d0/bieaGoaPGnxxL9msQrItIJQKQUulwVXY+1ZnCXl5cs+mnc6UJmzGDG049Ya
         QVmnVP8B8ZBOnJWalAXc4Yam2TirmVxwUfwnfbr3hQsBJGZfI7wdvn3ai19y3l61zEv4
         OPaOpbxk7PjPThnUWUkBrD1gPEVSx4YLMPtmF4J4/2fjki9EEOBE+Iao4gANog0F3vUs
         Zx2g==
X-Gm-Message-State: AOJu0YyDmRqq/Nl+PAC9mLUJ3+lV0Wc0CXqe8iuVNVY3m0jNVL7rPDAD
	jDRWTA8HiZHjC6Kd4IGI2O6SNgwMvc1srnjCWlK38X2IfYl/
X-Google-Smtp-Source: AGHT+IF+4hFAnZZsvQ6TzFuyHP2CXHfuuM0kkM6p9wmyfxXVBiB+kq5ndYh5lsAUPJaPJUVLggG0toyy5u4zDyknld6bX6Y9S2yh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a04:b0:668:95c1:b4fb with SMTP id
 fj4-20020a056a003a0400b0066895c1b4fbmr11061432pfb.1.1693301886057; Tue, 29
 Aug 2023 02:38:06 -0700 (PDT)
Date: Tue, 29 Aug 2023 02:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a842806040c91b5@google.com>
Subject: [syzbot] [netfilter?] INFO: rcu detected stall in tcp_setsockopt
From: syzbot <syzbot+1a11c39caf29450eac9f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, fw@strlen.de, haoluo@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, 
	kadlec@netfilter.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    2dde18cd1d8f Linux 6.5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D176cb7eba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D33d0e0022fa231d=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1a11c39caf29450ea=
c9f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D162d9beba8000=
0

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1fedeec6ef0b/disk-=
2dde18cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d76084fd6305/vmlinux-=
2dde18cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33a99d14581e/bzI=
mage-2dde18cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+1a11c39caf29450eac9f@syzkaller.appspotmail.com

Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
 P1021/1:b..l

rcu: 	(detected by 1, t=3D10559 jiffies, g=3D10501, q=3D842 ncpus=3D2)
task:kworker/u4:5    state:R
  running task     stack:25728 pid:1021  ppid:2      flags:0x00004000
Workqueue: bat_events batadv_nc_worker

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 preempt_schedule_notrace+0x5f/0xe0 kernel/sched/core.c:6972
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:46
 rcu_is_watching+0x86/0xb0 kernel/rcu/tree.c:696
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x464/0x510 kernel/locking/lockdep.c:5732
 rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 rcu_read_lock include/linux/rcupdate.h:749 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x175/0x10f0 net/batman-adv/network-coding.c:719
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
rcu: rcu_preempt kthread starved for 10557 jiffies! g10501 f0x0 RCU_GP_WAIT=
_FQS(5) ->state=3D0x0 ->cpu=3D1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expec=
ted behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:28320 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1808
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5066 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/26/2023
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152=
 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:1=
94
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 96 ea 30 f7 48 89 df e8 =
6e 69 31 f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e=
8 15 0c 23 f7 65 8b 05 e6 99 cd 75 85 c0 74 12 5b
RSP: 0018:ffffc900001e0c90 EFLAGS: 00000246

RAX: 0000000000000012 RBX: ffff888064ee4218 RCX: 1ffffffff231714a
RDX: 0000000000000000 RSI: ffffffff8a6c8080 RDI: ffffffff8ac813c0
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff2309ff0
R10: ffffffff9184ff87 R11: ffffffffffff7010 R12: ffff888064ee4110
R13: 1ffff9200003c196 R14: ffffffff86a85b20 R15: 0000000000000001
FS:  000055555635b480(0000) GS:ffff8880b9900000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f994d17a1f8 CR3: 000000002140f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
645
RIP: 0010:write_comp_data+0x3c/0x90 kernel/kcov.c:236
Code: 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 a9 00 01 ff 00 74 0e 85 =
f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b 82 e0 15 00 00 <83> f8 03 75 44 4=
8 8b 82 e8 15 00 00 8b 92 e4 15 00 00 48 8b 38 48
RSP: 0018:ffffc90003e0f718 EFLAGS: 00000246

RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8193ed61
RDX: ffff888019b3bb80 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007f994d07e800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8173dd50
R13: ffffc90003e0f838 R14: 0000000000000000 R15: ffff888019b3bb80
 rcu_read_unlock include/linux/rcupdate.h:778 [inline]
 is_bpf_text_address+0x131/0x1a0 kernel/bpf/core.c:721
 kernel_text_address kernel/extable.c:125 [inline]
 kernel_text_address+0x85/0xf0 kernel/extable.c:94
 __kernel_text_address+0xd/0x30 kernel/extable.c:79
 unwind_get_return_address+0x55/0xa0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x9d/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node+0x60/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:720 [inline]
 xt_alloc_table_info+0x3e/0xa0 net/netfilter/x_tables.c:1192
 do_replace net/ipv6/netfilter/ip6_tables.c:1139 [inline]
 do_ip6t_set_ctl+0x53c/0xbd0 net/ipv6/netfilter/ip6_tables.c:1636
 nf_setsockopt+0x87/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x12b/0x190 net/ipv6/ipv6_sockglue.c:1017
 tcp_setsockopt+0x9d/0x100 net/ipv4/tcp.c:3697
 __sys_setsockopt+0x2ca/0x5b0 net/socket.c:2263
 __do_sys_setsockopt net/socket.c:2274 [inline]
 __se_sys_setsockopt net/socket.c:2271 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f994d07e83a
Code: ff ff ff c3 0f 1f 40 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 48 c7 c0 =
ff ff ff ff eb b7 0f 1f 00 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 06 c3 0f 1f 44 00 00 48 c7 c2 b0 ff ff ff f7
RSP: 002b:00007fff051377c8 EFLAGS: 00000202
 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fff05137850 RCX: 00007f994d07e83a
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00000000000003b8 R09: 0079746972756365
R10: 00007f994d176ba0 R11: 0000000000000202 R12: 00007f994d176b40
R13: 00007fff051377ec R14: 0000000000000000 R15: 00007f994d178d00
 </TASK>
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98025
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8870 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20144kB local_p=
cp:7960kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98025
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8863 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20092kB local_p=
cp:7960kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8846 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20048kB local_p=
cp:7916kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8846 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20048kB local_p=
cp:7916kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8846 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20048kB local_p=
cp:7916kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8844 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:20040kB local_p=
cp:7916kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8839 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:19972kB local_p=
cp:7916kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8817 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:19932kB local_p=
cp:7876kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98076
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8817 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:19932kB local_p=
cp:7876kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10231 inactive_anon:489 isolated_anon:0
 active_file:0 inactive_file:44779 isolated_file:0
 unevictable:768 dirty:39 writeback:0
 slab_reclaimable:20277 slab_unreclaimable:98101
 mapped:7048 shmem:1257 pagetables:544
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1429090 free_pcp:8815 free_cma:0
Node 0 active_anon:40924kB inactive_anon:1956kB active_file:0kB inactive_fi=
le:179036kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped=
:28192kB dirty:144kB writeback:0kB shmem:3492kB shmem_thp: 0kB shmem_pmdmap=
ped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10548kB pagetables:21=
76kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:80kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
12kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_th=
p: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0k=
B all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1771508kB boost:0kB min:35408kB low:44260kB high:53112kB =
reserved_highatomic:0KB active_anon:40880kB inactive_anon:1952kB active_fil=
e:0kB inactive_file:177980kB unevictable:1536kB writepending:140kB present:=
3129332kB managed:2680488kB mlocked:0kB bounce:0kB free_pcp:19924kB local_p=
cp:7876kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:12kB boost:0kB min:12kB low:12kB high:12kB reserved_high=
atomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file=
:1056kB unevictable:0kB writepending:4kB present:1048576kB managed:1128kB m=
locked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3929480kB boost:0kB min:54480kB low:68100kB high:81720kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:80kB unevictable:1536kB writepending:12kB present:4194304kB m=
anaged:4117620kB mlocked:0kB bounce:0kB free_pcp:15324kB local_pcp:6944kB f=
ree_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 143*4kB (UE) 1403*8kB (UE) 740*16kB (UME) 1*32kB (U) 2*64kB (=
ME) 2*128kB (UM) 2*256kB (UE) 2*512kB (ME) 3*1024kB (UME) 1*2048kB (M) 425*=
4096kB (M) =3D 1771508kB
Node 0 Normal: 1*4kB (M) 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*5=
12kB 0*1024kB 0*2048kB 0*4096kB =3D 12kB
Node 1 Normal: 64*4kB (UME) 23*8kB (UME) 19*16kB (UE) 29*32kB (UME) 10*64kB=
 (UME) 1*128kB (U) 2*256kB (UE) 1*512kB (E) 2*1024kB (ME) 2*2048kB (UE) 957=
*4096kB (M) =3D 3929480kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
46036 total pagecache pages
0 pages in swap cache
Free swap  =3D 124996kB
Total swap =3D 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393402 pages reserved
0 pages cma reserved


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

