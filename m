Return-Path: <bpf+bounces-70514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B3BBC1D4B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CF919A473A
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6632E265A;
	Tue,  7 Oct 2025 14:58:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56817A30A
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849110; cv=none; b=PdMIWIUcSrn4q9FMagm+j4uIYIt7kAnhVX3VHWKqAUkOQNp0fQylldaD76494vlhX6hgeU9qnWL1GW5N09/5FOI12vn36HkCLsgOXHynILODXkpRpzdVTy8zSOT2nkGhVxDJjI33dpQuCnPkFz019dA6SgtT86dBWOzihsf9nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849110; c=relaxed/simple;
	bh=gcMNWwZ/e3DRKSodF++OXdvUX8M3nnifxAsMK8KggFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lcVEsieSbfpBXbd8mYfQCKYrkQwDvNheSqA/yGKk4T7xNFzpynZZNVtWNpoYpRHet7rZCSUR/aRGsT+hCxsz6zon3plphTgEs82D0GFRHuSbzYVBQyn08Ie8VprzzIHaVnZlvQZL86VGe9804j0tx81aS9VKR3wXXSVDGAr4GCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso188848839f.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759849108; x=1760453908;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq0etGHr3tuVSJmhaHs7TSQonXu7G5oQewLRYeJ0qig=;
        b=oFTz0P7Nl6oOPk85XJ9sln8NWDM9TiQLG/RC7ftG/8Dhd0/nT8xsRyywua9h+ankFX
         sHbU1xYDoBUf1YodEP2zSxdP0u8qEp1oJjSipxgqIEIZ9tfnp3vq3JyF6BF/MCxr/zEs
         8gEW7GHmwZx0FEpRwMUAxYVwImyapNuluXkP0nw2lc9i+ythbNBXqi8Ol/Pe4kTSrbYk
         iaIMUqmdmPdLgSNlR0SI2fFFaKnRNm3oqsLT0/yvA6ZoT0bClAKrkdsbPLCf0ixNhblk
         p6deTTMTke40ivBFDELE2UDudSGkNmiKDJ9T4WxBmVVBvVzp5DI4HaaFXTlbMmUbRVY9
         SFmw==
X-Forwarded-Encrypted: i=1; AJvYcCWIhCHsCStySnulNfHudU7mUq0XBHAdyyHsGg0LDRpH+3HdQf7wGS0G4eRyrUo5K7Ui1p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgDcriOo3Xo/ulbn1RcCmB/W/YDgaWeT5fkXl+3wHn0gOVQ8V
	pv3CiN/6HAgefBLAyjtRJeUGDv/7LYcI12uLGpH6/bx1j8s2lZjLMGNFAivscZnnFG+kr3mH9mc
	q6/SHKhiSy6f9yFJf4TiR6XJr89st3I+qwud7fejqSaLqfqNqoWJXiQVVQ68=
X-Google-Smtp-Source: AGHT+IFAMXk9B3RkaqHBAZ9jULTRRaMTcn/LZjHSjolC/THXWawUebW7OQ8BUHk5WzPiu2EzGdyyq+m8EWNNHfhtsBXcN1kTUepQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:427:5e1d:4200 with SMTP id
 e9e14a558f8ab-42e7ad995a0mr242929655ab.29.1759849108180; Tue, 07 Oct 2025
 07:58:28 -0700 (PDT)
Date: Tue, 07 Oct 2025 07:58:28 -0700
In-Reply-To: <68e243a2.050a0220.1696c6.007d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e52a94.a00a0220.298cc0.047c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: invalid-access Write in do_bad_area
From: syzbot <syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c746c3b51698 Merge tag 'for-6.18-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149b5a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f49b7d923ce867a
dashboard link: https://syzkaller.appspot.com/bug?extid=997752115a851cb0cf36
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ee792f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163955cd980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-c746c3b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85796940f78d/vmlinux-c746c3b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d82d6550867/Image-c746c3b5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-access in __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250
Write at addr f0ff800083d6d268 by task syz.2.17/3596
Pointer tag: [f0], memory tag: [fe]

CPU: 1 UID: 0 PID: 3596 Comm: syz.2.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x108/0x61c mm/kasan/report.c:482
 kasan_report+0x88/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:326 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:338 [inline]
 __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:380
 do_bad_area+0x68/0x78 arch/arm64/mm/fault.c:480
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:853
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:929
 el1_abort+0x44/0x68 arch/arm64/kernel/entry-common.c:325
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:459
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
 __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250 (P)
 do_misc_fixups+0x174/0x1aac kernel/bpf/verifier.c:22553
 bpf_check+0x1348/0x2a24 kernel/bpf/verifier.c:24686
 bpf_prog_load+0x63c/0xcd4 kernel/bpf/syscall.c:3062
 __sys_bpf+0x2e0/0x1a88 kernel/bpf/syscall.c:6134
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6242
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596

The buggy address belongs to a 1-page vmalloc region starting at 0xf0ff800083d6d000 allocated at bpf_check+0x8c/0x2a24 kernel/bpf/verifier.c:24529
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x544b2
flags: 0x1fffc0000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0xf)
raw: 01fffc0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff800083d6d000: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
 ffff800083d6d100: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 fe fe fe fe
>ffff800083d6d200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                     ^
 ffff800083d6d300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff800083d6d400: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

