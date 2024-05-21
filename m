Return-Path: <bpf+bounces-30150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ADC8CB3C9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D712EB222B1
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95919149009;
	Tue, 21 May 2024 18:44:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D015148FF0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317067; cv=none; b=KRmQmAIDbX8VXkGBiidI/K/MK3bP0CaH6CGiZwUhu2iRGTQ8UbjWBOKFcrRdFXYijzBAp4+FnvJak925XgxsOsiRygnidyUMr0uRqoYoW5fblo++eYy2s59Jp+WuARzPLbCUxMBSlTy4bRX1pIYfNNKfUC3A19oS2cE176MaxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317067; c=relaxed/simple;
	bh=t5oE24M4GTg2QTw2LuU0uX0+CQX/Kiv1ak8aO2QP52I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oMtIXpK9Ycaga9fTkwDsn0RoyAjosfupGwARIZlK5Bly44VwGLGWObHfXjEwmI6wWKkgj7mGcIaE9HhN2K/9IxiFq+p/1E3qGyrVSX+p0blhEs6LT0bH9Mg4DN3bqUk2nbhDY1Pgh2zCpUmPwOyyv3ApzmS+zNpN/YYtJHw5El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36c74ef7261so156508355ab.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 11:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716317064; x=1716921864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ub1Qfgzyz16AXLqqFBWpaTqTT0gYsFl8TjucI1Nq20=;
        b=D/sG7P7ljUjIf8RPGVTZEZFaBy24zP674c9PKpfnJI1RErAXb1WQQF15gBCAzAoQjb
         2L1G0VlTtGK1U4RIHtFk3B9c/vSfRYOUUFW2W77tiBdbRarNRl8Yx303I3FAsAnvldBV
         3SftlDH6Nhq/mm+Nknw2gUyWX1rPZH3tdKqMY+0rtjAXdgiF2h83L0XRnG/4shhDYb4e
         85nfRK5Wh8aBo92uA53yy8q9kpzhr1CIlqDNVPJEIvD8QhwKeUsWyaJ1SASRC/PPPDtJ
         tZoI74MDtpHSxY/vKKlusMbZz77Zp2oZj4jLKZg9NHN8m8c37cTeWwzdh1AyRgmX3n2w
         /OEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXVi8VhPF+PCoYSiWcwxKhn/P+puhZ+X228rMmN93BZYCFqL3erTmtsvryi904bhtCbuWffOIn0zhbWk02715KJZhb
X-Gm-Message-State: AOJu0YxeGpOZ7+FcjE5R93ahGS1U48oshtyvU+8NAH9Q3Tg84NJ1Qf/F
	x4gSDci0dhsGp0JwKfyDBqytHAnhVA52ZsVdeFcd9+MbKsotkKpJFpcSFN86aHzsQCN1ho85iUF
	/uUb8enBCrtnJ509L+yH5EA3ciBvYrpu6vH2x0yngbDwrChjki4Bm/B8=
X-Google-Smtp-Source: AGHT+IHeNo4igSLmP3uCOEtcXzZKRn8zxye1hk4q5+EKwTdsl5++U0qyL9dehIre5pRVecd4b57reO7WL0+llhGc+1WBHLyh62mE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d1c6:0:b0:36c:4cc9:5923 with SMTP id
 e9e14a558f8ab-36cc1446f5emr5653125ab.2.1716317064444; Tue, 21 May 2024
 11:44:24 -0700 (PDT)
Date: Tue, 21 May 2024 11:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2cd940618fb34fd@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in sys_sendto (7)
From: syzbot <syzbot+041bf9d823ca07fe3563@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c75962170e49 Add linux-next specific files for 20240517
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12bcb182980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fba88766130220e8
dashboard link: https://syzkaller.appspot.com/bug?extid=041bf9d823ca07fe3563
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1232f96c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16054e3f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21696f8048a3/disk-c7596217.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8c71f928633/vmlinux-c7596217.xz
kernel image: https://storage.googleapis.com/syzbot-assets/350bfc6c0a6a/bzImage-c7596217.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+041bf9d823ca07fe3563@syzkaller.appspotmail.com

yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
 P4537/1:b..l
 P5233/3:b..l
 P5232/1:b..l

rcu: 	(detected by 0, t=10505 jiffies, g=5897, q=114 ncpus=2)
task:syz-executor142 state:R
  running task     stack:26416 pid:5232  tgid:5232  ppid:5114   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 zap_pte_range mm/memory.c:1682 [inline]
 zap_pmd_range mm/memory.c:1730 [inline]
 zap_pud_range mm/memory.c:1759 [inline]
 zap_p4d_range mm/memory.c:1780 [inline]
 unmap_page_range+0x4206/0x4d00 mm/memory.c:1801
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1891
 exit_mmap+0x264/0xc80 mm/mmap.c:3341
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:565
 do_exit+0x9aa/0x27e0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f089f6322ab
RSP: 002b:00007fffee3373e0 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffc RBX: 0000000000000003 RCX: 00007f089f6322ab
RDX: 00007fffee3384b0 RSI: 0000000080085502 RDI: 0000000000000003
RBP: 00007fffee3384b0 R08: 0000000000000010 R09: 00322e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000800000000
R13: 00007f089f6ab3c0 R14: 00007fffee337480 R15: 00007fffee339510
 </TASK>
task:syz-executor142 state:R
  running task     stack:27088 pid:5233  tgid:5233  ppid:5115   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 filemap_map_pages+0x1707/0x1e70 mm/filemap.c:3655
 do_fault_around mm/memory.c:4884 [inline]
 do_read_fault mm/memory.c:4917 [inline]
 do_fault mm/memory.c:5056 [inline]
 do_pte_missing mm/memory.c:3903 [inline]
 handle_pte_fault+0x3bff/0x70f0 mm/memory.c:5380
 __handle_mm_fault mm/memory.c:5523 [inline]
 handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f089f630433
RSP: 002b:00007fffee3393f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f089f630433
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 7fffffffffffffff
R10: 0000555563b7f650 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffee33950c R14: 00007fffee339520 R15: 00007fffee339510
 </TASK>
task:klogd           state:R  running task     stack:23672 pid:4537  tgid:4537  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7067
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
Code: 2b 00 74 08 4c 89 f7 e8 ca ad 89 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000365f140 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920006cbe34 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcacae0 RDI: ffffffff8c1fe400
RBP: ffffc9000365f288 R08: ffffffff92fb8587 R09: 1ffffffff25f70b0
R10: dffffc0000000000 R11: fffffbfff25f70b1 R12: 1ffff920006cbe30
R13: dffffc0000000000 R14: ffffc9000365f1a0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 is_bpf_text_address+0x46/0x2a0 kernel/bpf/core.c:768
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4043
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:1972
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f564abe09b5
RSP: 002b:00007ffc60f0d2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f564abe09b5
RDX: 0000000000000065 RSI: 000055a8742bdcb0 RDI: 0000000000000003
RBP: 000055a8742b9910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f564ad6e212 R14: 00007ffc60f0d3f8 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 1165 jiffies! g5897 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:24880 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2202
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 4761 Comm: dhcpcd Not tainted 6.9.0-next-20240517-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x3a/0xb0 kernel/rcu/tree.c:724
Code: e8 ab d9 0e 0a 89 c3 83 f8 08 73 7a 49 bf 00 00 00 00 00 fc ff df 4c 8d 34 dd e0 b9 db 8d 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 <74> 08 4c 89 f7 e8 fc bd 7f 00 48 c7 c3 08 7d 03 00 49 03 1e 48 89
RSP: 0018:ffffc90002f9fcd0 EFLAGS: 00000246

RAX: 1ffffffff1bb773c RBX: 0000000000000000 RCX: ffff88802aca0000
RDX: dffffc0000000000 RSI: ffffffff8c1fe3e0 RDI: ffffffff8c1fe3a0
RBP: ffffc90002f9fdf0 R08: ffffffff92fb8587 R09: 1ffffffff25f70b0
R10: dffffc0000000000 R11: fffffbfff25f70b1 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff8ddbb9e0 R15: dffffc0000000000
FS:  00007fc5d90f3740(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffee3393f8 CR3: 000000002e10c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 rcu_read_lock_held_common kernel/rcu/update.c:109 [inline]
 rcu_read_lock_held+0x15/0x50 kernel/rcu/update.c:349
 sched_mm_cid_remote_clear_old kernel/sched/core.c:11898 [inline]
 task_mm_cid_work+0x438/0x7c0 kernel/sched/core.c:11957
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5d91c1d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fffb1c3abb8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 000055f8670b3190 RCX: 00007fc5d91c1d49
RDX: 00007fffb1c3abc0 RSI: 0000000000008921 RDI: 0000000000000011
RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000036
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffb1c3abc0
R13: 000055f866e63f88 R14: 000055f8670b3190 R15: 000055f8670b9740
 </TASK>
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

