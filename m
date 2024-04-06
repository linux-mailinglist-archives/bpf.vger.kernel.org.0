Return-Path: <bpf+bounces-26105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D805689ACDE
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6041F23147
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2864E1C1;
	Sat,  6 Apr 2024 20:17:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35B4AEFB
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434642; cv=none; b=I0UlLMhKLa4gw4G5N7KdGcch0cKaf8/SML67E54zjhNvV29bHsc3AOCOjJR4lGjkYOUaBY2G0R/Vlu7a4bvOEUqTZbetuJuMEiWLsJSdD8LAYAPgMyyZCnfTMDvP+lFsYmB2aHwZafCKyAR/A3G7i9Xl2YWwHvd4OUahqWmtzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434642; c=relaxed/simple;
	bh=l5PIYq9FbTCxq1f1mZGF0vudjp5WVOOL2Paqpsn7l0s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ILdGV/i348sQsdx0t7Ss61PAqb/zy1xBL7f5GopQdYZetc07WoolW1Yrt5PLRm4nmOczizDp72xYygbFsriWDqTqzeJHKnxtn56i0gUaP9i3rRIyyd2V3JrV5N3ji0qj4DtN0vtxBZXj3k0vvkusvxgCBae6VvvfmrcHOXZ4oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5dbbc3e9fso14004139f.1
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 13:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712434640; x=1713039440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycvPrHEvjrn4zRdk7erEVtCAK7KuU2LMF20y2Gf7rxw=;
        b=cS6oPbBka8YBf9rW7WPMCM9XWgbsBvyB/lAIThnvWuzFayUTqZRv7MhIBb1GQO9yjk
         M8JP8xpABD+q0ds+NM5D4SqnGzQiHca0RwWSfeU5z+kGh8VkUXcEPGdurU/NmCLTWXvf
         ek5BH/n8UVACnWO0EgamcxA09b8lRmQ5D8mWOgq6I3jrJedDMJ4ZM+GxlBvhfluQiDR0
         lurQ1jqg0N0DGhkARStH/oJiAMJolA55TioqS18pjsDJTCv4UH33OIBkFrf/UP2oQMfr
         M2cm6FWmc5Bq+iQCZFqg4BwWIuZE9pJONREt7iMxh9VqbmDj7xeNt+ExwTWhrCoGbv2f
         ozgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDC0VAV2lBvEb9DcS0VlEx2fwpLBMpPCvAl11uMoJGC3GnURQQMAD2LXrjaBi5LBCW3mf+MQpIjWhoC5qqlefWOOlF
X-Gm-Message-State: AOJu0YzIWxAomA1sT6hCYploLCgPFOl4yeiwuyIDkwvVfaVzO3MYJxkl
	VYwFIGaUASu+dKYM2alxbN3xZHYOp/4max+nm4kU8sa2hJHQ59r8N/wWL/2+85wrXiA+4QS/zfI
	chDifNbnLDw7Zc3GxVn3sLRut2Ecbxwgop9rgLMoMGfHzfOPFH4blkiI=
X-Google-Smtp-Source: AGHT+IEZlwJIzLsGHFzp/vi8PSy4ul1ALtE8+7sYQ8ycE9GjtQLPAoqyz+M1ZhapFoobT7VvZWA6KDv7SINUTvqu/HtROMxYpTYv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4090:b0:47f:cea3:5cf6 with SMTP id
 m16-20020a056638409000b0047fcea35cf6mr159620jam.2.1712434640088; Sat, 06 Apr
 2024 13:17:20 -0700 (PDT)
Date: Sat, 06 Apr 2024 13:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c85760615734276@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_map_delete_elem
From: syzbot <syzbot+d40ad71c1ba64324d256@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    026e680b0a08 Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b1fee3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=d40ad71c1ba64324d256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b539b1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e55795180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b5659d2008c/disk-026e680b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fd1552fafde/vmlinux-026e680b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba622b1b0ec4/bzImage-026e680b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d40ad71c1ba64324d256@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in htab_lock_bucket kernel/bpf/hashtab.c:160 [inline]
BUG: KMSAN: uninit-value in htab_lru_map_delete_elem+0x628/0xb20 kernel/bpf/hashtab.c:1459
 htab_lock_bucket kernel/bpf/hashtab.c:160 [inline]
 htab_lru_map_delete_elem+0x628/0xb20 kernel/bpf/hashtab.c:1459
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 kvfree+0x69/0x80 mm/util.c:680
 __bpf_prog_put_rcu+0x37/0xf0 kernel/bpf/syscall.c:2232
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 smap_restore arch/x86/include/asm/smap.h:56 [inline]
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:37 [inline]
 __msan_metadata_ptr_for_load_8+0x2c/0x40 mm/kmsan/instrumentation.c:92
 last_frame arch/x86/kernel/unwind_frame.c:82 [inline]
 is_last_frame arch/x86/kernel/unwind_frame.c:87 [inline]
 is_last_task_frame+0x62/0x420 arch/x86/kernel/unwind_frame.c:156
 unwind_next_frame+0x9d/0x470 arch/x86/kernel/unwind_frame.c:276
 arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
 kmsan_internal_chain_origin+0x57/0xd0 mm/kmsan/core.c:183
 __msan_chain_origin+0xc3/0x150 mm/kmsan/instrumentation.c:251
 __skb_dst_copy include/net/dst.h:282 [inline]
 skb_dst_copy include/net/dst.h:290 [inline]
 __copy_skb_header+0x362/0x850 net/core/skbuff.c:1528
 __skb_clone+0x57/0x650 net/core/skbuff.c:1579
 skb_clone+0x3aa/0x550 net/core/skbuff.c:2070
 __tcp_transmit_skb+0x438/0x4890 net/ipv4/tcp_output.c:1308
 tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
 tcp_write_xmit+0x3ee1/0x8900 net/ipv4/tcp_output.c:2792
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:2977
 tcp_push+0x755/0x7a0 net/ipv4/tcp.c:738
 tcp_sendmsg_locked+0x6079/0x6cb0 net/ipv4/tcp.c:1310
 tcp_sendmsg+0x49/0x90 net/ipv4/tcp.c:1342
 inet_sendmsg+0x142/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:745
 sock_write_iter+0x368/0x3d0 net/socket.c:1160
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 1 PID: 5008 Comm: sshd Not tainted 6.9.0-rc2-syzkaller-00002-g026e680b0a08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

