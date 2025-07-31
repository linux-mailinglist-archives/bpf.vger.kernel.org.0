Return-Path: <bpf+bounces-64814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8128B17373
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B6163E96
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C101ACED5;
	Thu, 31 Jul 2025 14:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A61A5BA0
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973558; cv=none; b=de8e+rjDzeZnJfo30gFstg47QT9d8YrdzrB/MOu4smuR2zwa5J6L5g8xiBo/6PJqn9jcFDRZk9lZxmH4ezpA5osYHLxNFhWI5kZL9YQe3ABmvNQQycbasTMD8OKp6PoePgdGVkt60Wo2bL1a/SEfrfwXWeLwwe8AWhOkoymRnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973558; c=relaxed/simple;
	bh=l7WkyU6OfODE963yZOYzLSQGYFONLhRPuPnn0x4LV2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FDLdwadZYYwdeob9IARhAJ+HQB/UfbveG+XKKgC3Qi0gkHVp1emOG5uLTJE8PlX2YH3QnNg8EWH8cgraXsptFFJG06Ay4kSDOa4WmIUagdwGw/Xh9LkHrbYBarVcs6Tt5krNtkWFbMhtZ3vQ144pDDIaiSD29FAFpA5fyfGKw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3f0287933so16507385ab.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 07:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973554; x=1754578354;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ymwzw1M9GyTwkEtdG06+DHmrfOOeM02MHVcedVv5kx8=;
        b=wG7QOsuXIJI6NIoHHj3m88ERwYbMlXOl8MePiwPgdMfSWMP4WzZ74EV0QpE1oQnaim
         IGsw8s+BuxQToWIUYsDX8pFlrSsjuaYxzry3zhfcAZcfI0IypHODFGuC80AWfTLT1ENU
         MJY4z+JQO18fWBlKmT5LEwfosniIz3tNGWSUlmD/IuOgQ8cvaZHTKU+VkRVQq0P99zxn
         IYT+NqAkW69+JGJrt8ZxoJW7BlqklyjawXIBOpyTssXbMnkEbxm6jl/zGEEWYaXnGL+k
         h2fz6ttfNQbKEWwR5CsfZjMgZ7pLJScy+n6i1+uTlrw62S+xPsQT7sOQhyuAjHhMZKZF
         wczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYA7CwpIQNozVtMEC1vn3CPLgijA8B7y/YPqXqQk8ZAmuN6YK13Vuq4o6lx0fo8nACi94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0tN0NPvMhwQJhKsI33SOp0Yr4VcVnJqCfUGPI0sySl4md66q
	q/aFKw6PX267dfzPfBRPgri81dKkxd8udPTWeq4ja1k5M9Jb+N5lDFzrtck7YMZQ4rNV7uz5DbQ
	zr36If9vlkBhUkjQfNIQaO+BXpr8RzMzL5OLqQaKAr6TdWKWYcbWrXDgd7ck=
X-Google-Smtp-Source: AGHT+IG25XfNbNYUv28uJ3XUFspdMt70vNFmzQpYG4SVQz9FyRSMrC4L9Ta/bpkNQYeWCsCnyUrA/9iX2K79azVp/cNTsBE28sJ/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb83:0:b0:3e3:e732:aef6 with SMTP id
 e9e14a558f8ab-3e3f62802e9mr126564965ab.18.1753973554618; Thu, 31 Jul 2025
 07:52:34 -0700 (PDT)
Date: Thu, 31 Jul 2025 07:52:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b8332.a00a0220.26d0e1.0044.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in trace_suspend_resume
From: syzbot <syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102f69bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af26dbd5a30735
dashboard link: https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-260f6f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/091b40479433/vmlinux-260f6f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54ef37cd1da7/zImage-260f6f4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4102 at mm/highmem.c:622 kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 4102 Comm: syz.0.84 Not tainted 6.16.0-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: 
[<80201a24>] (dump_backtrace) from [<80201b20>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:8281f77c r5:00000000 r4:8224af5c
[<80201b08>] (show_stack) from [<8021faf0>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201b08>] (show_stack) from [<8021faf0>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<8021fa9c>] (dump_stack_lvl) from [<8021fb30>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82a6bd18
[<8021fb18>] (dump_stack) from [<80202624>] (vpanic+0x10c/0x360 kernel/panic.c:440)
[<80202518>] (vpanic) from [<802028ac>] (trace_suspend_resume+0x0/0xd8 kernel/panic.c:574)
 r7:804bdb5c
[<80202878>] (panic) from [<802548dc>] (check_panic_on_warn kernel/panic.c:333 [inline])
[<80202878>] (panic) from [<802548dc>] (get_taint+0x0/0x1c kernel/panic.c:328)
 r3:8280c684 r2:00000001 r1:82231a24 r0:822393ec
[<80254868>] (check_panic_on_warn) from [<80254a40>] (__warn+0x80/0x188 kernel/panic.c:845)
[<802549c0>] (__warn) from [<80254cc0>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:872)
 r8:00000009 r7:82265508 r6:df9f9d1c r5:83a93000 r4:00000000
[<80254b4c>] (warn_slowpath_fmt) from [<804bdb5c>] (kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622)
 r10:00000000 r9:deb56a18 r8:debb2f48 r7:00a00000 r6:00000003 r5:83a93000
 r4:ffefd000
[<804bd950>] (kunmap_local_indexed) from [<80538be4>] (__kunmap_local include/linux/highmem-internal.h:102 [inline])
[<804bd950>] (kunmap_local_indexed) from [<80538be4>] (move_pages_pte mm/userfaultfd.c:1457 [inline])
[<804bd950>] (kunmap_local_indexed) from [<80538be4>] (move_pages+0xb24/0x19c8 mm/userfaultfd.c:1868)
 r7:00a00000 r6:00000000 r5:846e9ec4 r4:84add6c0
[<805380c0>] (move_pages) from [<805c02ec>] (userfaultfd_move fs/userfaultfd.c:1914 [inline])
[<805380c0>] (move_pages) from [<805c02ec>] (userfaultfd_ioctl+0xff8/0x21c4 fs/userfaultfd.c:2037)
 r10:84add6c0 r9:df9f9e98 r8:21000000 r7:00000001 r6:00000000 r5:20000040
 r4:85955000
[<805bf2f4>] (userfaultfd_ioctl) from [<80568ccc>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<805bf2f4>] (userfaultfd_ioctl) from [<80568ccc>] (do_vfs_ioctl fs/ioctl.c:552 [inline])
[<805bf2f4>] (userfaultfd_ioctl) from [<80568ccc>] (__do_sys_ioctl fs/ioctl.c:596 [inline])
[<805bf2f4>] (userfaultfd_ioctl) from [<80568ccc>] (sys_ioctl+0x130/0xba0 fs/ioctl.c:584)
 r10:83a93000 r9:00000003 r8:85935840 r7:20000040 r6:85935841 r5:00000000
 r4:c028aa05
[<80568b9c>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf9f9fa8 to 0xdf9f9ff0)
9fa0:                   00000000 00000000 00000003 c028aa05 20000040 00000000
9fc0: 00000000 00000000 002f6300 00000036 002e0000 00000000 00006364 76b450bc
9fe0: 76b44ec0 76b44eb0 000193a4 00131fc0
 r10:00000036 r9:83a93000 r8:8020029c r7:00000036 r6:002f6300 r5:00000000
 r4:00000000
Rebooting in 86400 seconds..


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

