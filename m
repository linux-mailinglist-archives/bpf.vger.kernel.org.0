Return-Path: <bpf+bounces-31957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CEC9058C5
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542621C21D46
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4539181B81;
	Wed, 12 Jun 2024 16:26:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E7180A9C
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209585; cv=none; b=pARuy+90pP4/8CQOiXC1yDCIoeJycIpkvHtg8Jc8+QsIE/fuo3GBYpfRdOJzEkjLEFTzcMXV9W0mxGHiNtmuRDNJhL1FvHm9lpRb3XW+QDLMT5xHT9qlQMHn5m6E5YhDnKG6D0mCxa1Tyb4S4vcCLpIJ4j60nlj93K1gwG44eL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209585; c=relaxed/simple;
	bh=v+4+a+HTHLTgO7hxv1jZ5OsOtxeDEq+Mt8tBAF0eHvU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WQe+h13H6HLnOI5GRTXnxksk554zHDM3jDu7kF6fwjW/kK5lvF5zNUhAJzPl6dqW45qvLuH9tyC0SCapBaewGhOEMU0QT0dtXZ0qqznOiDQIVmhyuUupngNbio21HwElXCwWNggJiVdTTnFvQtj6xphGZ4Q8QtzwSx7+BLvBkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ebd7c57a35so33391739f.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 09:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209583; x=1718814383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtsP29K0Q6706Qq7mLsa+x4VxRNJjog6MhC7GzgYXnQ=;
        b=dfr5E6RqyqYenel/G7MdwPhr00rR8SwZDVreA00ZOpRwD6GvqNNOVYF3WdTC7hjEiJ
         Rnkz5TEAYyr8nC/bfevf20eHjtqF38VREE8wxnrV2eKF03+WvuiBDIszr8OzIew1dmiH
         5KsXwlvdCoPoc25BhvdAgtmUOWa0vU3alO3232v1dk6+zRla/c0cM5uWgXZDDt5GsmAt
         2h7Wr15in1XOvOolP0uHqNQ9gjh/oCQEu8d9+fwTIg4htvK8NPCxElZP64EDK8U7+YaL
         x5M7M05ZWWbe5/uyluKomen7NYFpOOPV+b2073IIkZVF+WwtmvsP9pwIq+sPXlqycn7L
         L6pg==
X-Forwarded-Encrypted: i=1; AJvYcCWhrOi11t/gSeoNHDV8hJbqIAxvOtGfjfyTE3clmYfgvV67edUgQIY5V29FhgKUH9qD55o9mdKh5gDVXVR84O48UNQN
X-Gm-Message-State: AOJu0YxZ3Z0WZUS6/yIXvpZWJN/9IFecWWM9vQ78S5nfQScCWqcCLuG3
	8aErTu7AbfTjsKeQOzvpVIsYMQVr1iQq7sfxHQXX+bpSDKoR12iBSybp+WOAWLNpimt0PJVwumu
	dgn+6A0c8E+NXO0si8SFx8gXQ/qddjue/WfO42f+17O6ZyCzb3pSEQ4M=
X-Google-Smtp-Source: AGHT+IGRlBTkVSTyJ4DKNMLBoLRFp9pg3qr1yC/6JFMdFq4kqH3Micx7Jxffp4WrGwBeEVTR1Fbj4fhseehd68UvOcSSxxKyU6Nd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c3:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b93ec0ef35mr159485173.1.1718209583121; Wed, 12 Jun 2024
 09:26:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da1703061ab3d7cb@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in bstr_printf (2)
From: syzbot <syzbot+3d98610f9d9bdb4a57ce@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=133d9a36980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3d98610f9d9bdb4a57ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1631e6f6980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160d3126980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d98610f9d9bdb4a57ce@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 ____bpf_snprintf kernel/bpf/helpers.c:1064 [inline]
 bpf_snprintf+0x1c8/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 bpf_bprintf_prepare+0x1393/0x23c0 kernel/bpf/helpers.c:1027
 ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
 bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425

CPU: 1 PID: 5042 Comm: syz-executor235 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

