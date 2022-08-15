Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AB59345B
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiHOR7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiHOR70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 13:59:26 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031D28E2B
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 10:59:24 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id v5-20020a5d9405000000b0067c98e0011dso4523004ion.1
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 10:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=hWOOJX8NuM+oPIFYN51dx1eD//PoLJa22GbFPJ3c01w=;
        b=ZWFBgHTtFR82utEmv0w4tiHs9LitRRWBCEbMmmHfkO9UzVJeoIHOo65QYQrRltMVMI
         p1ulfO+iDSfOM30UyY//10yc3QOvRJOhb0BH/AGTIUBGfaV1g1ddEdqz7Xy0u9PhuPfw
         GvkAy6qHsQ1AFV1/1GO5+TZyZ9FuT//zl3pGimGOK7iCjk8gO3jAnYWaoGFnTG6TfoUm
         AAYTaLg7HkmuX3PWwPm5TdPSIlcj70IJ9/vl4FKRQgTCu00kffWLLuqIayRebviW/XB8
         wwB9AdMp7pjjnk4jXi/PY+FNWIV/0g0p0P1+DwkqA8XbmlWDcAJg+UQ/rmyLiZ+2KP57
         oxlg==
X-Gm-Message-State: ACgBeo3zew0zpaKY7/PobcVJET2vRsCeTru1zqYWb4dKU14e1Wuu5nNd
        cmHGYqElxKtkydaBn+Xsdk7NTGttEdKMGUBQK1R3wDrZph9k
X-Google-Smtp-Source: AA6agR7O1GWq6dDpyGR/ua+eY6Qvu/0jJUV5+uS50D+L4CPtkHI+uQrFFRwdA53mRA9LX3HkRKDRRavZHFUiX8KkqWMGCi1wBKAI
MIME-Version: 1.0
X-Received: by 2002:a6b:2a05:0:b0:688:d09:1e45 with SMTP id
 q5-20020a6b2a05000000b006880d091e45mr3334659ioq.128.1660586364091; Mon, 15
 Aug 2022 10:59:24 -0700 (PDT)
Date:   Mon, 15 Aug 2022 10:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059c5b005e64b64ef@google.com>
Subject: [syzbot] upstream boot error: general protection fault in mm_alloc
From:   syzbot <syzbot+97f830ad641de86d08c0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, david@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5d6a0f4da927 Merge tag 'for-linus-6.0-rc1b-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1668343d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f83c035536d7b2e3
dashboard link: https://syzkaller.appspot.com/bug?extid=97f830ad641de86d08c0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97f830ad641de86d08c0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff00d300000338: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff82698000019c0-0xfff82698000019c7]
CPU: 1 PID: 1155 Comm: kworker/u4:4 Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x12d/0x310 mm/slub.c:3268
Code: 84 1c 01 00 00 48 83 78 10 00 0f 84 11 01 00 00 49 8b 3f 40 f6 c7 0f 0f 85 e3 01 00 00 45 84 c0 0f 84 dc 01 00 00 41 8b 47 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 0f 0f 94 c0 a8 01
RSP: 0000:ffffc90004bcfda8 EFLAGS: 00010202
RAX: 0000000000000338 RBX: 0000000000000cc0 RCX: 0000000000000000
RDX: 0000000000000b89 RSI: 0000000000000cc0 RDI: 0000000000040aa0
RBP: ffffffff8150835f R08: dffffc0000000001 R09: fffffbfff1c4ade6
R10: fffffbfff1c4ade6 R11: 1ffffffff1c4ade5 R12: ffffffff8d38ce40
R13: ffff00d300000000 R14: ffffffff8150835f R15: ffff8881400068c0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mm_alloc+0x1f/0xb0 kernel/fork.c:1171
 bprm_mm_init fs/exec.c:369 [inline]
 alloc_bprm+0x1ef/0x3b0 fs/exec.c:1534
 kernel_execve+0x97/0xa00 fs/exec.c:1974
 call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x12d/0x310 mm/slub.c:3268
Code: 84 1c 01 00 00 48 83 78 10 00 0f 84 11 01 00 00 49 8b 3f 40 f6 c7 0f 0f 85 e3 01 00 00 45 84 c0 0f 84 dc 01 00 00 41 8b 47 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 0f 0f 94 c0 a8 01
RSP: 0000:ffffc90004bcfda8 EFLAGS: 00010202
RAX: 0000000000000338 RBX: 0000000000000cc0 RCX: 0000000000000000
RDX: 0000000000000b89 RSI: 0000000000000cc0 RDI: 0000000000040aa0
RBP: ffffffff8150835f R08: dffffc0000000001 R09: fffffbfff1c4ade6
R10: fffffbfff1c4ade6 R11: 1ffffffff1c4ade5 R12: ffffffff8d38ce40
R13: ffff00d300000000 R14: ffffffff8150835f R15: ffff8881400068c0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	84 1c 01             	test   %bl,(%rcx,%rax,1)
   3:	00 00                	add    %al,(%rax)
   5:	48 83 78 10 00       	cmpq   $0x0,0x10(%rax)
   a:	0f 84 11 01 00 00    	je     0x121
  10:	49 8b 3f             	mov    (%r15),%rdi
  13:	40 f6 c7 0f          	test   $0xf,%dil
  17:	0f 85 e3 01 00 00    	jne    0x200
  1d:	45 84 c0             	test   %r8b,%r8b
  20:	0f 84 dc 01 00 00    	je     0x202
  26:	41 8b 47 28          	mov    0x28(%r15),%eax
* 2a:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx <-- trapping instruction
  2f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  33:	4c 89 e8             	mov    %r13,%rax
  36:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3b:	0f 94 c0             	sete   %al
  3e:	a8 01                	test   $0x1,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
