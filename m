Return-Path: <bpf+bounces-41834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805599BB3F
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 21:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DE71C210AD
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFED148FF5;
	Sun, 13 Oct 2024 19:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6417BCE
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728847951; cv=none; b=TvYH3mvEsdPDeTX0lRcT2JfQvHDHnktsKla+7HlaNyEUbEWXqphyQob/2HMKhrJjgsgA36hg5LczXhgCo2CbL7bdr79THL6vZwGW8rIAYqthp5zoXIpYRQgeG9i2ucbrpFWEhvw6fBjylvbNEXEF2BthIkUv3QBODs/ZQPHSZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728847951; c=relaxed/simple;
	bh=5IMCkh7XK+8hzLI7GtjWMJ3bu/ultQoSdOa70YKazZ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Augv43zPQwWAykC2P4QJfsPeqw/4glyv3+aj1Gjl0JC2J7GPb/QsQHuQF5jAnxSzKEU+9zoaukS1ZBKZgKq2em9I7E4fVWRoku8FCdeEu61wWiWBZLlCD9kLkWDukedzUDGDzLNJwmTFCToZU9nBxdm72MBVXIJT3I0UwrQFSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so18412055ab.2
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 12:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728847949; x=1729452749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5vxLDF4f9NGdanT/PV+W/Ynxu0cCem0tCTu7tK9OAQ=;
        b=J1gzIaD2tWYnOKClbOm9diRnbPB5jwI6d4rVmfiU5Ejqp+D1vfUn0axs3PYFh/tiCR
         oIeGlh5jwd5k3dUiK15OIAjqIRWPyc4dXHoThTkZnoTHiaTRdD1AXEYbEe+G7F5K8TqL
         9IOrsdWv0GAfeno+QqCUb/LEm6/9Mewm5NUIm+E3YJr6s2XIIbSg0k0iAHoRhtWPCvO4
         K96iXwgCQ/IAnH5Nrxo3fvNpLZt1XhM2UdBLMKaakrm8Nyv4f+wYfXHAuvIKouo55t75
         iJ7sTbvxVLw+eP64siRNq02uHvc0YI3zXNQ5Qoo1e4I7tSeA+w5wFRUPjSaN+covAcRH
         Pftw==
X-Forwarded-Encrypted: i=1; AJvYcCWnzRoCPDtOhwhkGc0b8YYPSP4NYUdLNwPmGk54CW2MCSHi6VsgRt4i25+G9kqr/s7+lj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhnVWrz2dfd6itZ4/khNZZOvEOAo/UwK4+Q7oszqByM83QKP0
	9+lpEG8p7v+50jCKC1ym9qIwFgoc0AMd2qjecBTzxDZXQGWCK22J5AoO7fMkvZ+R/XT6M99llHZ
	R+rE8bmNWvdqvrmw6Pz4cBTxyRT63CKw6XVgys86RiRrv29LDkaJ+u/Y=
X-Google-Smtp-Source: AGHT+IG8qjvwAtLyhycOsHiEOdPCCpwtKgV09YbYTxtre+KgVeuGMFBDND42QQGVZRXLYACNlctRnmUhG8ZodkAVrbTvXNv3n4dC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3a3:9337:4cf4 with SMTP id
 e9e14a558f8ab-3a3b5f21b3cmr61233895ab.4.1728847949230; Sun, 13 Oct 2024
 12:32:29 -0700 (PDT)
Date: Sun, 13 Oct 2024 12:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c204d.050a0220.3e960.0045.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in page_pool_put_unrefed_netmem
From: syzbot <syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80cb3fb61135 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15485780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f31443a725c681
dashboard link: https://syzkaller.appspot.com/bug?extid=204a4382fcb3311f3858
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1e78177ae84/disk-80cb3fb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/656db61d4272/vmlinux-80cb3fb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5b0b3f63a30/Image-80cb3fb6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in page_pool_put_unrefed_netmem+0x8b8/0x11f4
Read of size 8 at addr ffff0000c924c708 by task syz-executor/7103

CPU: 0 UID: 0 PID: 7103 Comm: syz-executor Not tainted 6.12.0-rc1-syzkaller-g80cb3fb61135 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 page_pool_put_unrefed_netmem+0x8b8/0x11f4
 page_pool_put_netmem include/net/page_pool/helpers.h:323 [inline]
 page_pool_put_full_page include/net/page_pool/helpers.h:368 [inline]
 __xdp_return+0x3b8/0x760 net/core/xdp.c:387
 xdp_return_frame+0x94/0x2cc net/core/xdp.c:422
 tun_do_read+0x4dc/0x13b8 drivers/net/tun.c:2246
 tun_chr_read_iter+0x114/0x25c drivers/net/tun.c:2274
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x740/0x970 fs/read_write.c:569
 ksys_read+0x15c/0x26c fs/read_write.c:712
 __do_sys_read fs/read_write.c:722 [inline]
 __se_sys_read fs/read_write.c:720 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:720
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:732
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:750
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 7090:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_node_noprof+0x274/0x3b8 mm/slub.c:4308
 kmalloc_node_noprof include/linux/slab.h:901 [inline]
 page_pool_create_percpu+0x94/0xa48 net/core/page_pool.c:335
 page_pool_create+0x24/0x34 net/core/page_pool.c:364
 xdp_test_run_setup net/bpf/test_run.c:182 [inline]
 bpf_test_run_xdp_live+0x27c/0x1a90 net/bpf/test_run.c:382
 bpf_prog_test_run_xdp+0x6a0/0xfc4 net/bpf/test_run.c:1317
 bpf_prog_test_run+0x294/0x33c kernel/bpf/syscall.c:4247
 __sys_bpf+0x314/0x5f0 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5739
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:732
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:750
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 6473:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x64/0x8c mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x184/0x47c mm/slub.c:4728
 __page_pool_destroy net/core/page_pool.c:1018 [inline]
 page_pool_release+0x780/0x820 net/core/page_pool.c:1056
 page_pool_release_retry+0x30/0x24c net/core/page_pool.c:1068
 process_one_work+0x7bc/0x1600 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:551
 insert_work+0x54/0x2d4 kernel/workqueue.c:2183
 __queue_work+0xe20/0x1308 kernel/workqueue.c:2339
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
 call_timer_fn+0x1b4/0x8e8 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2419 [inline]
 __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2449
 handle_softirqs+0x2e0/0xbf8 kernel/softirq.c:554
 __do_softirq+0x14/0x20 kernel/softirq.c:588

The buggy address belongs to the object at ffff0000c924c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1800 bytes inside of
 freed 2048-byte region [ffff0000c924c000, ffff0000c924c800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x109248
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0002000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0002000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3249201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c924c600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c924c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c924c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff0000c924c780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c924c800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

