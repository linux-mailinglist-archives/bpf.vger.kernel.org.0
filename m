Return-Path: <bpf+bounces-67313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C843B426B9
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912467C3221
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2A2C0F76;
	Wed,  3 Sep 2025 16:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440928F948
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916440; cv=none; b=EZLL5sd1AgRQqtfXkOwG3Ht0smbib6e4On5SOp4gzoHmCgP2MHn0J7IoogSkQbKgfvqmjxx/QMFF9JJjZmQ0DjPzV679jADNOK5ymcHYsbnfITC+b3TWuNxkjYI8vbyskk9w6vcqw/A5uwcrTjpd98U7vACzkJM3qBMCHqqVHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916440; c=relaxed/simple;
	bh=MJ+hOYM0xYx9RTqyxpkuDg/HtSLuqe1fKTmw6TmqLtU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u4HyNjC9tbwZC1BMS/oyO608W572SyiPCJCCU1hbQCw3gMI0t/F4XacK6EaDzRWP/QxrkAl5MDOwYOS7elY0vBM86VS255vPZa3mCYqFxJmTsl8+Lyd3kQ1rm5vNFBGA+OFDTX/VRZ5JIQX+MS+51OXkGGDooRdmMMFOteJs5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f46ca1f136so313965ab.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 09:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916438; x=1757521238;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne1sbICVvddwd6AuruJKbf9hL2yygBbdnhHoBV7WzMY=;
        b=pL6U5cFlk4XPFHsU3BKJlA8ibHIXpvR6rpcc+xTzO25jNpUCgxWCnY1R3nWG10O4os
         W8Fnolahj3uEsWOAzu9tQMUPZMSLMJw31VrIRSkka0SQupSF9GMdty84zkDeYECxY5aR
         dPTDyoabZM8BPOvp8FNOwIUyTedboE+q4RmqeYiPSG6iGa0a1JBsOphQFKONRjZSg+9W
         of0bLk/gvwqFej9VFqu3xc/SoZ48DmP7KEB25M2FuJ+tUJFNsHRKek0FhyCegQ9lusuc
         4HbOeiTbv099JMVUZ20L9fXKKdjH6OG9zjhtcjuGA022G4ddXcoGRxppFxsgTOiT9SpZ
         L14g==
X-Forwarded-Encrypted: i=1; AJvYcCXDKGbcfmdYjbfPhIJioB3ByhemN+Tn1HM3Au+7uE9hX7mfjnKjbeBhBysacmHDr1+T5nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgGvAP0gXOVh9cLzSHCoHr/GLIWV/uqDScgNgtq8jZ4tEl1EB
	ov0hJn/N7zKqerWTyNLfIy0pHvse5vyDcAwk87Eoo7XfcPNcXrgL2I37Y+Bqn4YnCwZBHNf9evs
	uB0OR0ea6xjWTRSBUluzei2zWntBUDA0FoN1hik/7H/oUVd762GpMx65fQJU=
X-Google-Smtp-Source: AGHT+IHqE/81WZO4JO1QzMvBbgv3oJ8HqsxCqArABYMYFUBGB3SugcnkXjmJD/4AO0BM6d1frLLLS5dZYT8SgCLAtul39VCWRfN+
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3e5:5357:6dd4 with SMTP id
 e9e14a558f8ab-3f401fcf532mr241983595ab.20.1756916437900; Wed, 03 Sep 2025
 09:20:37 -0700 (PDT)
Date: Wed, 03 Sep 2025 09:20:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b86ad5.050a0220.3db4df.01f7.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] WARNING in sock_hash_delete_elem (2)
From: syzbot <syzbot+ca62aaf39105978cd946@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c3b3264e585 Merge tag 'x86_urgent_for_v6.17_rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142cae34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=ca62aaf39105978cd946
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37953b384dff/disk-5c3b3264.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df5cc1c4e51d/vmlinux-5c3b3264.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ed6195eae9f/bzImage-5c3b3264.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca62aaf39105978cd946@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
WARNING: CPU: 1 PID: 9889 at kernel/softirq.c:172 __local_bh_disable_ip+0x342/0x400 kernel/softirq.c:172
Modules linked in:
CPU: 1 UID: 0 PID: 9889 Comm: syz.3.1233 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__local_bh_disable_ip+0x342/0x400 kernel/softirq.c:172
Code: 0f b6 04 28 84 c0 0f 85 b5 00 00 00 83 3d 59 8e 98 0d 00 75 19 90 48 c7 c7 00 b2 09 8b 48 c7 c6 40 b2 09 8b e8 df 61 fe ff 90 <0f> 0b 90 90 90 e9 fc fd ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc9000439f980 EFLAGS: 00010246
RAX: 313d6c056ac6e300 RBX: 1ffff92000873f34 RCX: 0000000000080000
RDX: ffffc9000e563000 RSI: 000000000000025d RDI: 000000000000025e
RBP: ffffc9000439fa80 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffff110049edc89
R13: dffffc0000000000 R14: ffffffff8184ca61 R15: ffff888024f6e44c
FS:  00007f22097a66c0(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000504d4000 CR4: 00000000003526f0
DR0: 0000000000000006 DR1: 0000000000000003 DR2: 0000000000000401
DR3: 0000000000000404 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 local_bh_disable include/linux/bottom_half.h:20 [inline]
 spin_lock_bh include/linux/spinlock_rt.h:87 [inline]
 sock_hash_delete_elem+0xc6/0x320 net/core/sock_map.c:952
 bpf_prog_0fcbc4c83748eeda+0x46/0x4e
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:742 [inline]
 bpf_flow_dissect+0x132/0x400 net/core/flow_dissector.c:1024
 bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1416
 bpf_prog_test_run+0x2ca/0x340 kernel/bpf/syscall.c:4590
 __sys_bpf+0x581/0x870 kernel/bpf/syscall.c:6047
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f220b53ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f22097a6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f220b775fa0 RCX: 00007f220b53ebe9
RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
RBP: 00007f220b5c1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f220b776038 R14: 00007f220b775fa0 R15: 00007fff2055aba8
 </TASK>


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

