Return-Path: <bpf+bounces-76273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF7CAC943
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 09:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C163304E161
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876BD2EC569;
	Mon,  8 Dec 2025 08:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CD2DA769
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184308; cv=none; b=Lyf506xj00Ks2qSGcdbuarT/cXcE9EH2ZF3Y2if2n3EfIP4A2q9DOaPR/UCZQJaYdcpWCBh25Y82kspI2AaKugCooW8i5XDbAYSGJn2naWtfvPpJf0Hh1+HpjWTQaTZivxt7kk8rnZTWY8aiEMOKt48qi3Zujh9W2Op9LFpUKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184308; c=relaxed/simple;
	bh=wp8MwnSLOMiDJKd1sOq8ThIthz8O7uCx2RCJUSbYhtU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=omMnrVcieasSJhNFR2d5wFH1ujLEkzBW9npoNye63YWfM7+tddDB/OwLacKkvJmeL+PHEOBTBFqEtBWpPkeJyStPN9+2YyERAG1wFE/0bo7+1ZjfpPrgh2ghXodKnSlcFWTdvwKihwnEFUFD9D6/Xi0oRZiJID9dRfIRzPGcNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-657a6c9d45eso2956350eaf.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184305; x=1765789105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWxEuG2Te9THcEN6TKv3cNenNvqC8+NtJLsMxa9AyPc=;
        b=m4Ajx7LQJgVm1Em7Dc35hVZ2WvoAK+yqeZz/HqhCkEMVm81G2PyfyQQoZ5DowBI7w2
         865zuwYGAg4KmkTU5FLwZDpxS92JRMv2gMiaxPAIdy1lDQZMl9Ycgm2x/O6brenSPG9Y
         pyP77lG8UoCINwEzs7a/Q4hv+vVrH25PsuRrm60+ZM8rMkyoqT87N+GpoNknmuciYXXl
         qJGyQbK/d5U3yWJryccBBa0cSzI3fWs72o/mGudU4KcExxn577X8nJnm6SBeBZbapDEt
         uA5jsVhKXXMRv/HHlOz3E/bEa01KhxqSB4uxPWe9Pk5Uj/4D5vzl5DqHPHpDofCApVs/
         2fUA==
X-Forwarded-Encrypted: i=1; AJvYcCWFxTICahEqQhBKD97z2xiSjVoYyxgB+rWhJwgftLl248TNsvsKKtV/xx6UIFG0rbkakLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvF1n3vdqNef81TX9HoFErrvpr4XDsn1uITQ5wI4vhBJ4oNQRQ
	uG5u8OndmBRRQL6e+M7gRaKdEKB/BfuavTMSE9qWT5R8Pmi8q8uuE0dyaoN20R6mpvJVq79MMFG
	Fa0KCkvL6S5y5o4MBPbHxDIJAdGEvxR3HmAVzMtd5rS2eyCov0Gb5wcBgy9w=
X-Google-Smtp-Source: AGHT+IE93KA4DO9il2f1SrXdptHACJTwjhwUi0Lo99HY/svuNve52z2gw6vQLVT6uVtAa36q0KrpyIqCA4CkKRoByycbHkehXU93
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:811:b0:659:9a49:90c5 with SMTP id
 006d021491bc7-6599a977508mr3014043eaf.68.1765184305444; Mon, 08 Dec 2025
 00:58:25 -0800 (PST)
Date: Mon, 08 Dec 2025 00:58:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69369331.a70a0220.38f243.009c.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-use-after-free Write in defer_free
From: syzbot <syzbot+7a25305a76d872abcfa1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    559e608c4655 Merge tag 'ntfs3_for_6.19' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1080b192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35a67601c980c167
dashboard link: https://syzkaller.appspot.com/bug?extid=7a25305a76d872abcfa1
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1574b01a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a33cc2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-559e608c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ff565203729/vmlinux-559e608c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/28d6e57737b9/Image-559e608c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a25305a76d872abcfa1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in defer_free+0x3c/0xbc mm/slub.c:6537
Write at addr f3f000000854f020 by task kworker/u8:6/983
Pointer tag: [f3], memory tag: [fe]

CPU: 0 UID: 0 PID: 983 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound bpf_map_free_deferred
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x108/0x61c mm/kasan/report.c:482
 kasan_report+0x88/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:330 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:342 [inline]
 __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:384
 do_bad_area+0x68/0x78 arch/arm64/mm/fault.c:484
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:857
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:933
 el1_abort+0x44/0x68 arch/arm64/kernel/entry-common.c:303
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:437
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
 defer_free+0x3c/0xbc mm/slub.c:6537 (P)
 do_slab_free mm/slub.c:6619 [inline]
 kfree_nolock+0x1a0/0x1d4 mm/slub.c:6930
 range_tree_destroy+0x74/0x90 kernel/bpf/range_tree.c:253
 arena_map_free+0x64/0x90 kernel/bpf/arena.c:196
 bpf_map_free kernel/bpf/syscall.c:894 [inline]
 bpf_map_free_deferred+0x70/0x180 kernel/bpf/syscall.c:921
 process_one_work+0x178/0x2cc kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x24c/0x354 kernel/workqueue.c:3421
 kthread+0x130/0x1fc kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 3570:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:56
 save_stack_info+0x40/0x158 mm/kasan/tags.c:106
 kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:142
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 poison_kmalloc_redzone mm/kasan/common.c:373 [inline]
 __kasan_kmalloc+0xb4/0xb8 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 kmalloc_nolock_noprof+0x1dc/0x4fc mm/slub.c:5751
 range_tree_set+0x644/0x778 kernel/bpf/range_tree.c:237
 arena_map_alloc+0x11c/0x17c kernel/bpf/arena.c:141
 map_create+0x19c/0xa98 kernel/bpf/syscall.c:1514
 __sys_bpf+0x348/0x1a88 kernel/bpf/syscall.c:6146
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6272
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x128 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596

Freed by task 983:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:56
 save_stack_info+0x40/0x158 mm/kasan/tags.c:106
 __kasan_save_free_info+0x18/0x24 mm/kasan/tags.c:147
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x80/0x84 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 kfree_nolock+0xcc/0x1d4 mm/slub.c:6929
 range_tree_destroy+0x74/0x90 kernel/bpf/range_tree.c:253
 arena_map_free+0x64/0x90 kernel/bpf/arena.c:196
 bpf_map_free kernel/bpf/syscall.c:894 [inline]
 bpf_map_free_deferred+0x70/0x180 kernel/bpf/syscall.c:921
 process_one_work+0x178/0x2cc kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x24c/0x354 kernel/workqueue.c:3421
 kthread+0x130/0x1fc kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

The buggy address belongs to the object at fff000000854f000
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 32 bytes inside of
 64-byte region [fff000000854f000, fff000000854f040)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xfbf000000854f200 pfn:0x4854f
flags: 0x1ffc00000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: f5(slab)
raw: 01ffc00000000000 f9f0000003001600 dead000000000100 dead000000000122
raw: fbf000000854f200 000000008040003f 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff000000854ee00: f6 f6 f7 f7 fa fa f9 f9 f5 f5 fb fb f6 f6 fc fc
 fff000000854ef00: f8 f8 f6 f6 f0 f0 f2 f2 f9 f9 f2 f2 f0 f0 fb fb
>fff000000854f000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                         ^
 fff000000854f100: fa fa fa fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff000000854f200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


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

