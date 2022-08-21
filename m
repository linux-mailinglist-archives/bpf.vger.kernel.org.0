Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78659B2B8
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiHUIRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiHUIP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 04:15:28 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18961C90C
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 01:15:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i4-20020a056e0212c400b002e5c72b3bd7so6259692ilm.6
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 01:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=5NNw78fjZsnUXvVEAxNq4Tv/jLfrtC69PnIsZeDg9vw=;
        b=2aCoRnr6Eyty/4XXIqvwrrdKqXy2kXyJlo/MO+3sVfyvUo5pUdWyNqE3qRnA9pXDZs
         Cu5qRZJswu9xzG3qN4kleMf9JpbDzXOgugTRhXoLNckec8Avy73+iRIzbvOEPkA7e+M3
         Ee5mpGI/H+ZvZKpsdunXCVMP1tvPx0pKQb5SoPfHBgoB0pRlwEQ5QdwsqyF6hLuOYfro
         1GscXqP9+tYziLfBVH30dspf7fPsYB3IXYy/4UYxYQkSoQwej5Zpnl8vo5ploJob28ar
         nFG8Xj5qATukPvpSDodxCD8mwF8k0OsANlnAq4PTm1CfA4cr4HFVFlumro2S+EBYZwC2
         705g==
X-Gm-Message-State: ACgBeo3eTmPaLZOR5bOw2qWxowb4YPR/8fkwHEF1oBrNdoM3TpBhaEj7
        u3gCFE9F4fBNelloDDI9zCV0SLCF9K3zt6GNyhPCDiFmMO0r
X-Google-Smtp-Source: AA6agR5EnAm50Et/OCwgPw0eNqolIi56KqTa8X1oagg72eJ8BBxEUERfECSFLAALPm1UeYtemL+67P9apSCbCk3yyqM2OGLaXio5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:2e5:f6d2:4ea9 with SMTP id
 u15-20020a056e02170f00b002e5f6d24ea9mr7142704ill.146.1661069725030; Sun, 21
 Aug 2022 01:15:25 -0700 (PDT)
Date:   Sun, 21 Aug 2022 01:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e85eff05e6bbeed3@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in mm_alloc
From:   syzbot <syzbot+0c4c86507aef43117d25@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, david@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, luto@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    ad57410d231d usb: gadget: rndis: use %u instead of %d to p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15b2b1a5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=0c4c86507aef43117d25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c4c86507aef43117d25@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000328: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000001940-0xfff8200000001947]
CPU: 0 PID: 266 Comm: kworker/u4:2 Not tainted 6.0.0-rc1-syzkaller-00005-gad57410d231d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x15d/0x4a0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 7c 02 00 00 48 85 c0 0f 84 73 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 7b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900015dfe18 EFLAGS: 00010246
RAX: ffff000000000000 RBX: ffff88810e746600 RCX: 0000000000000328
RDX: 0000000000000338 RSI: 0000000000000cc0 RDI: 000000000003e3f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810016d8c0
R13: 0000000000000cc0 R14: ffffffff811440e9 R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mm_alloc+0x19/0xc0 kernel/fork.c:1171
 bprm_mm_init fs/exec.c:369 [inline]
 alloc_bprm+0x1c3/0x900 fs/exec.c:1534
 kernel_execve+0xab/0x500 fs/exec.c:1974
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x15d/0x4a0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 7c 02 00 00 48 85 c0 0f 84 73 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 7b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900015dfe18 EFLAGS: 00010246
RAX: ffff000000000000 RBX: ffff88810e746600 RCX: 0000000000000328
RDX: 0000000000000338 RSI: 0000000000000cc0 RDI: 000000000003e3f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810016d8c0
R13: 0000000000000cc0 R14: ffffffff811440e9 R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	51                   	push   %rcx
   1:	08 48 8b             	or     %cl,-0x75(%rax)
   4:	01 48 83             	add    %ecx,-0x7d(%rax)
   7:	79 10                	jns    0x19
   9:	00 48 89             	add    %cl,-0x77(%rax)
   c:	04 24                	add    $0x24,%al
   e:	0f 84 7c 02 00 00    	je     0x290
  14:	48 85 c0             	test   %rax,%rax
  17:	0f 84 73 02 00 00    	je     0x290
  1d:	49 8b 3c 24          	mov    (%r12),%rdi
  21:	41 8b 4c 24 28       	mov    0x28(%r12),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 7b 02 00 00    	jne    0x2af
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
