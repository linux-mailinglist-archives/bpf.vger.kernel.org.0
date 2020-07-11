Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E321C2EF
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgGKG6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jul 2020 02:58:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52695 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGKG6Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jul 2020 02:58:16 -0400
Received: by mail-il1-f199.google.com with SMTP id o17so5226512ilt.19
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 23:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AkBx8LTbEovSwhwwJ9FeFsD5TmflPO84M/ic/EDjK1M=;
        b=N25b1qn2judRxDyQ/yzUmoFunIKZGRYaIy/jKfHf9DZ61Cg1+sfQoJsnJs/0wN3i7j
         JW8Ewjwfpq3cq4E/JwjFkCK3d45kyk7jOcZan1KjcjipLyeUAYCarG1A2919hFh8UO78
         0QjImkffVKThm0pP/zgP7ww4lXIs2lBvNPXzarrHyG0aXJYLFZcxpVFEDpdFiASzgC8/
         otxx9jIFbu/s4Db2Krf/YO2Ndz+BLdy1k2MFQSY+wqdVdqqHWI1yQ8R+XUOpV79EO391
         iluCbCj+nT+PdBR0iV8Bx1qIUuI0+Img3NjnjySYOYGq9wVuEvvu9fSZNZ/jOXEV4HnT
         y5iQ==
X-Gm-Message-State: AOAM531jsr+Bj7aSyagxuqnWWcuFuSKLQhv6otGJGNleroaRAEmfcvCp
        CDc8L9LIL4D3A0rS13Bf6y9XxBv8nGY8aKHac480MyAQgv9x
X-Google-Smtp-Source: ABdhPJyHkFmFk9sP90ajG41S5cTk8F61qKnof5/Gg9oZeuf3WWRrWJgUgUCEGrpP6Ouw4P/GSXLP5u8lRScyMR0/DNxEF9rwqt1D
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c21:: with SMTP id q1mr5169902ilg.28.1594450694903;
 Fri, 10 Jul 2020 23:58:14 -0700 (PDT)
Date:   Fri, 10 Jul 2020 23:58:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000481e2505aa24fb32@google.com>
Subject: BUG: stack guard page was hit in __bad_area_nosemaphore
From:   syzbot <syzbot+89eb3f606b866757455d@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, jeyu@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135403a3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=89eb3f606b866757455d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+89eb3f606b866757455d@syzkaller.appspotmail.com

BUG: stack guard page was hit at 0000000046f5170d (stack is 00000000087b5eff..00000000b28869c7)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25511 Comm: syz-executor.4 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__bad_area_nosemaphore+0x15/0x480 arch/x86/mm/fault.c:743
Code: ff ff 4c 89 ff e8 8b 35 7f 00 e9 0c ff ff ff 66 0f 1f 44 00 00 41 57 41 56 45 89 c6 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd <53> 4c 8d bd 88 00 00 00 48 83 ec 28 89 4c 24 14 e8 d6 df 3f 00 4c
RSP: 0018:ffffc90016598000 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88804d04c580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffc900165980d8
RBP: ffffc900165980d8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2d59c18700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90016597ff8 CR3: 00000000599e5000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90016598188 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90016598490 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900165984b8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc900165987c0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900165987e8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90016598af0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90016598b18 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90016598e20 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90016598e48 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90016599150 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90016599178 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90016599480 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83967dab RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad5e30 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900165994a8 EFLAGS: 00010046
RAX: 0000000000000000 
Lost 804 message(s)!
---[ end trace ffd1ab463dd60bcc ]---
RIP: 0010:__bad_area_nosemaphore+0x15/0x480 arch/x86/mm/fault.c:743
Code: ff ff 4c 89 ff e8 8b 35 7f 00 e9 0c ff ff ff 66 0f 1f 44 00 00 41 57 41 56 45 89 c6 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd <53> 4c 8d bd 88 00 00 00 48 83 ec 28 89 4c 24 14 e8 d6 df 3f 00 4c
RSP: 0018:ffffc90016598000 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88804d04c580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffc900165980d8
RBP: ffffc900165980d8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2d59c18700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90016597ff8 CR3: 00000000599e5000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
