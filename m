Return-Path: <bpf+bounces-27030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931778A7F76
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB931F21F07
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA5131BD6;
	Wed, 17 Apr 2024 09:15:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE650130484
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345324; cv=none; b=Rvo288HEey8xi2/n+yLz1c9gDULIKeTdbN9HQ63YSWUfsI+8n0phFI0lwuJsK4RhHxReRpB9tZtIJFQ4P+Jmw8OPqfvSGTRxCV7TmQW2ZZnaXKkSVgCuDpb05jWl+YyVaLqYBotw7578s+UKWskjqAlTWgJBlvJbjq7fOwDzKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345324; c=relaxed/simple;
	bh=tNUgxFQw6eMCYlR6Ekzg2/SYAJVF+N2IQw803Gb6PyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=urX6pfksGs6CcVd1rz+cbvgu8zMEWDO/Q720hZojmwHK49m5QVPD8YQNyZH7iZaCGkj9UU/ut0/R98QpEe2y4mDMszTahQSAnmRJbVlIbSnOEBhdApletVWaEuWKDuJG469r0bEKRFLxK4zXTezqChBmmWXRa1owiS7E5nys+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso161736039f.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 02:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713345322; x=1713950122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMHDWXruCDKqdIqw0iUevbAqhPVYOFER4yVLIRlEfe8=;
        b=TfnlXiJB/XRaB3Kbr3yzOUSc3XI59ctwc+sMYrCsICd80a9N9FJ74PqQbyOZEsVwNu
         GZXIxJhou+lmKKwNr8pcjvE8Bbohh6umENPlVPi+ZwsCom8toGCrgU/f63sK2Gds0kbK
         VfcQ9ivUO7IBcYw+OPbcyhK7+EAjej/dj7R1vZAHlZb/yPTSQq63+d82kzIO62Nn2lq5
         IgPOiVPUp5lDy6STDdvSZX2+XFVxb/nApAZN/A1YMhzK6HCtlA9ZvA1hPFYh9BGzbRQj
         AYz0WVqepYIJMTHJSrV+R7cn4p+l5p5Sc9DR8fQhbjNq71q28m9axZsDp++k0EwpQOSC
         z98Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI+2cJRhU7+tjzJqJVsv5lDee858+FexP6Wvx+sMAvEgayhNlRHNyeombCHyOpOoUnKHI0LOKoHAbUiASiRJBTuvzn
X-Gm-Message-State: AOJu0Yypx67nESBt6PYDBPudjXhEh9pTXaEUUh+j3CkvIwNtD9u9Ctdr
	rsoJ8VjydPDcfASR04VRnGmMesGi39VRfpoog1cXWZrsyXVkP90o66Ou4LR+K+78fRkQ1Q3YUDv
	9aA2fRjUGjG2VooWhYcw/zZhIE85LTonvyyOvvyX/t50rXVU6gidWdhY=
X-Google-Smtp-Source: AGHT+IG783qjym/uoLFNulcfb2mQcdjbO/UaIe+3eiYM1979Fo/fvMutrN4Uj6cPOPD5D1cYFW8foWxF+deScaJxkQXdYhR5sdyo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8929:b0:482:c7c8:5019 with SMTP id
 jc41-20020a056638892900b00482c7c85019mr918925jab.0.1713345322069; Wed, 17 Apr
 2024 02:15:22 -0700 (PDT)
Date: Wed, 17 Apr 2024 02:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cc3030616474b1e@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1502f36d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com

RDX: 0000000000000050 RSI: 0000000020000000 RDI: 000000000000000a
RBP: 00007ffebb32f750 R08: 00007ffebb32f4e7 R09: 00007f2c42da0038
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffebb32f9b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5065 at net/core/xdp.c:299 __xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299
Modules linked in:
CPU: 0 PID: 5065 Comm: syz-executor883 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299
Code: 89 c5 85 c0 79 62 e8 c6 b4 3e f8 eb a5 e8 bf b4 3e f8 4c 89 ff e8 97 a9 96 f8 4d 63 fd 48 c7 c7 80 27 39 8f e8 a8 36 23 02 90 <0f> 0b 90 e9 f8 01 00 00 e8 9a b4 3e f8 48 8d 7c 24 60 48 89 f8 48
RSP: 0018:ffffc90003d0f640 EFLAGS: 00010246
RAX: 1158ab1705932a00 RBX: dffffc0000000000 RCX: ffffffff8b7974ad
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc90003d0f5c0
RBP: ffffc90003d0f710 R08: ffffc90003d0f5c7 R09: 1ffff920007a1eb8
R10: dffffc0000000000 R11: fffff520007a1eb9 R12: 0000000000000002
R13: ffff88802ead6000 R14: 1ffff920007a1ed0 R15: fffffffffffffff4
FS:  0000555581756480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000020174000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xdp_reg_mem_model+0x22/0x40 net/core/xdp.c:344
 xdp_test_run_setup net/bpf/test_run.c:188 [inline]
 bpf_test_run_xdp_live+0x365/0x1e90 net/bpf/test_run.c:377
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2c42ddb279
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffebb32f748 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2c42ddb279
RDX: 0000000000000050 RSI: 0000000020000000 RDI: 000000000000000a
RBP: 00007ffebb32f750 R08: 00007ffebb32f4e7 R09: 00007f2c42da0038
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffebb32f9b8 R14: 0000000000000001 R15: 0000000000000001
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

