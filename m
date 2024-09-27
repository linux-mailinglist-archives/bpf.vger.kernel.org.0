Return-Path: <bpf+bounces-40381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE714987D56
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 05:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7313A1F24683
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 03:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6716EBE6;
	Fri, 27 Sep 2024 03:52:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783223B0
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409142; cv=none; b=j0Ph+XXma0V8FqFSBPkXitgbigAGqR1I7L1+B9kEHj1JzPqebOW0ZB5l6rfHWyAP/yDu0NlksNFBGavx66C5jlh7lgt1/x2337adwdFgS2wF3yhbGJ6HSpBEGDEsa6CrYD3tpcgFAoZbuA0JeW/NOtomrUOzKFuT7KXWsUqFc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409142; c=relaxed/simple;
	bh=tijYP/eR2PHioC3KgAgMi4QXGnwkmGd0Dgeb/FN19k0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hcSv2CPKes8DzHxJkJeMsOlpD3dOc4JHIRAnEl7x2VBZDseKa+5zkW3jW0D7kuqth2qlB7D+ElpGKu2Jm+0+BzzQe9fHXuNSS0dHSU3tpOzm/a+Nvd9cQxSkcXGQCv0jtdWyTG5kUFRWJkuk4pZH/JrBc7Y2wQeeQaCwheJ6Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e872a7so11750565ab.3
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 20:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409140; x=1728013940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3auWreLAZ73QzV0Lv0K1wMlu78NrY1VI+H7gTuEZZNg=;
        b=peGNVPe+3IBh5vuqP80nC/GV3/sONWdepB7X11XTMYXoE1HptmsOgbwiaHX80d/U7r
         j6IbByITXMszOTHj9r+5YDfrLhjbD0tj8OsVHS9HbGaOCd/wJw4k91GxeP6mutI77jEr
         ptUfvF9kXDC5K45wqQ3Qk4sKoJB89Rm4lot5Uatr3ueEulckov/j2kwRg9LDDCJcFVRt
         6iBopIYlqd+BRChgMOYqBDZamueWbSVozFgaL8+b3sbSXwNksYjbiCwQzcoQD+pG68r4
         7lXpF9JwvIMzv4eU11aIjKD7IRJWnBbOMYssWTeVTLh/QZVn2HpAd60iAsrL+VESRs5o
         P7og==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q7+MRwU8m7XxcrLPF3pdt1BxFG8GaqaSFc5HGguVcU4p318h74ES3U5f6DyAm8kbM9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Fxn5u9lmixU25dxhQ5Y5mYop1JOUaugAA018rstofRmBvmI0
	LC0Dwr9ZVUNuMG0fkLqkGbMel+RmTCee/8hV4QvJs9HZsUbb0fQ0F6XEMvApzsM8IpYB6efo+cy
	MwO7/CWhMoM1HTf8u7ljH8Y79B+dyLKH9rl8XQgOt64FYx+JvnD50kws=
X-Google-Smtp-Source: AGHT+IE/eMe8L5X79DJcyc3g++cEfn8GM0JPpB9NtO+cctnAc2JcrwKhO3x5h2Ylk2bpVDbMqAZ8cGNF4hg6MH0vGn+lnXTetJZ0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a34514832bmr16835235ab.2.1727409140018; Thu, 26 Sep 2024
 20:52:20 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:52:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f62bf3.050a0220.38ace9.0007.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
From: syzbot <syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=100fc99f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee7107980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367fc75d0a34/disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8df13e2678de/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/138b13f7dbdb/bzImage-abf2050f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 save_trace+0x926/0xb50 kernel/locking/lockdep.c:579
 check_prev_add kernel/locking/lockdep.c:3219 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x2bde/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
 htab_map_delete_elem+0x1df/0x6b0 kernel/bpf/hashtab.c:1430
 bpf_prog_bc20a984d57ef3f1+0x67/0x6b
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
 __traceiter_kfree+0x2b/0x50 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x35e/0x440 mm/slub.c:4715
 security_task_free+0xa4/0x1a0 security/security.c:3178
 __put_task_struct+0xf9/0x290 kernel/fork.c:977
 put_task_struct include/linux/sched/task.h:144 [inline]
 delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

