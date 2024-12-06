Return-Path: <bpf+bounces-46271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB89E6FC2
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB5316C922
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC590209F53;
	Fri,  6 Dec 2024 13:58:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBD207DF9
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493504; cv=none; b=Q+X8ucZaM5irXVauqn+qOCABRo8iHSiGP4W/MwQVTONoD7x6CncspEmFVMIwSJFfyLJybWXY/3PSukXYB+Ms6FdyPaO1jGVyVS2N5Y3JOEfmlFjMyfF3KugN7hkzIXxQP+IpjoLF69b66YKYb6TY28Mt57VFCFFiFk9gDCo9j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493504; c=relaxed/simple;
	bh=Q2F40TmgJ1tTXfT8xpAFnAYBKpk+MbHcFWk76Y7/TIk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FYT9N/yv97j5c6WbsND+ns9EV1rMKAKjrLJ/donYmN12DgqH9V765gJPNAhPU6+Pc4+IKSFMMEOqChDzPNLfKOZHkyk786KL4F5/Li+Iwir2vJdUJRsT4MNws/m10h1KYZJ9n9hAujW9r0Ol5zoliTMlpd/7/5n3jdrk/GIusuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so1268085ab.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 05:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493502; x=1734098302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDObkOj765Fglu8+R0TAdh8kvitDtM61nvPTLDd8+Lg=;
        b=H+j/eYSUWFczi+7ZTdaC6wCuKb7v47i+r2qDp09XWUQUnYtBUfLjgW43UgFBTpBYcK
         Qsx9RpxMlmfvOZXBAoPaO5ORo7rYRrWZG6CRUgQ8YMApAKI2+LAeq0iXzpjbpJk+oBtN
         Gx6Z6WHrVb/UzWMNQonOMKseVil80dm18FsAk0p4syGVGkOtrNV6RlR3n2B+1Q9bqDDk
         g9Ty/tgER0UNNNDpEjdVFagbAKA7fKqtbY3yzBWy7aiEu1o3GG/MrxD/KqqNRvU29Lil
         zqyu139rTXS8g8MQcdOLTdeSXv9mVfonJLXQu4zt3zlPGr+TWTWcft4BGzb26g8ZtV18
         fL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL5dmwRX2T8vZPYzdr1nayzcpn3OwSbtysz9BP4DmMtctGjRMuv5PPEG3zG5iqyHRwbjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcHTxnpzDS7utq3VSGaYTe9nD+sHYJz56HMhLvtKDJCyN2fdu
	ZFHkaHrMYUznVXBjX8iqozPxMdxTH5SBbm+WV55JaLr17WEIP0ui3FVc8+8BhTnzMOt4Q+6REbt
	ikEihHJ7SDtFKSrIXCjxcROu+SoAA3IvCP38O0B+zK6zirHRx07SjtjQ=
X-Google-Smtp-Source: AGHT+IGDdd+mMJzOcmNNl7oQHze1PkX0Duxw3G3BMfOqupBwA57Ovc46Dew7MgHhVzZWV5Moy++EwKO7bt7t1+Pzkk3L1yNS6j6D
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3a811e61639mr30950815ab.16.1733493501797; Fri, 06 Dec 2024
 05:58:21 -0800 (PST)
Date: Fri, 06 Dec 2024 05:58:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675302fd.050a0220.2477f.0004.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in htab_lru_map_delete_elem
From: syzbot <syzbot+0a26db48dcd6d80be6c0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1476e0f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
dashboard link: https://syzkaller.appspot.com/bug?extid=0a26db48dcd6d80be6c0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d9c8df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276e0f8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9751e7030ea/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7bf928b44d6/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a26db48dcd6d80be6c0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0 Not tainted
------------------------------------------------------
syz-executor207/6807 is trying to acquire lock:
ffff88802632eca0 (&htab->lockdep_key#434){....}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
ffff88802632eca0 (&htab->lockdep_key#434){....}-{2:2}, at: htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484

but task is already holding lock:
ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->lockdep_key#435){....}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
       bpf_prog_2c29ac5cdc6b1842+0x43/0x47
       bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
       __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
       __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
       __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
       class_preempt_notrace_destructor include/linux/preempt.h:481 [inline]
       trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events/lock.h:95
       __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinlock.c:402
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
       bpf_prog_2c29ac5cdc6b1842+0x43/0x47
       bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
       __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
       __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
       trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
       __mutex_lock_common kernel/locking/mutex.c:587 [inline]
       __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
       futex_cleanup_begin kernel/futex/core.c:1070 [inline]
       futex_exit_release+0x2a/0x220 kernel/futex/core.c:1122
       exit_mm_release+0x19/0x30 kernel/fork.c:1660
       exit_mm kernel/exit.c:543 [inline]
       do_exit+0x88b/0x2d70 kernel/exit.c:925
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
       __do_sys_exit_group kernel/exit.c:1098 [inline]
       __se_sys_exit_group kernel/exit.c:1096 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
       x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&htab->lockdep_key#434){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
       bpf_prog_2c29ac5cdc6b1842+0x43/0x47
       bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
       __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
       __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
       __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
       class_preempt_notrace_destructor include/linux/preempt.h:481 [inline]
       trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events/lock.h:95
       __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinlock.c:402
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
       bpf_prog_2c29ac5cdc6b1842+0x43/0x47
       bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
       __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
       __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
       trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
       __mutex_lock_common kernel/locking/mutex.c:587 [inline]
       __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
       uprobe_clear_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
       __mmput+0x79/0x4c0 kernel/fork.c:1349
       mmput+0x62/0x70 kernel/fork.c:1375
       exit_mm kernel/exit.c:570 [inline]
       do_exit+0x9bf/0x2d70 kernel/exit.c:925
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
       __do_sys_exit_group kernel/exit.c:1098 [inline]
       __se_sys_exit_group kernel/exit.c:1096 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
       x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->lockdep_key#435);
                               lock(&htab->lockdep_key#434);
                               lock(&htab->lockdep_key#435);
  lock(&htab->lockdep_key#434);

 *** DEADLOCK ***

4 locks held by syz-executor207/6807:
 #0: ffffffff8e2d69e8 (delayed_uprobe_lock){+.+.}-{4:4}, at: uprobe_clear_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
 #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2350 [inline]
 #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2392
 #2: ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 #2: ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
 #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2350 [inline]
 #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2392

stack backtrace:
CPU: 3 UID: 0 PID: 6807 Comm: syz-executor207 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
 bpf_prog_2c29ac5cdc6b1842+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
 bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
 __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
 __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 class_preempt_notrace_destructor include/linux/preempt.h:481 [inline]
 trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinlock.c:402
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
 htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
 bpf_prog_2c29ac5cdc6b1842+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
 bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
 __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
 __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
 trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
 uprobe_clear_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
 __mmput+0x79/0x4c0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1375
 exit_mm kernel/exit.c:570 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:925
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe3838cedf9
Code: Unable to access opcode bytes at 0x7fe3838cedcf.
RSP: 002b:00007ffd9c887888 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe3838cedf9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe38395b390 R08: ffffffffffffffb0 R09: 00007ffd9c887910
R10: 00007ffd9c887910 R11: 0000000000000246 R12: 00007fe38395b390
R13: 0000000000000000 R14: 00007fe38395bf20 R15: 00007fe38389c900
 </TASK>


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

