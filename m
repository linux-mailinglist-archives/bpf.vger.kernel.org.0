Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51085B07AC
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGO5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIGO4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:56:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0426BA0249
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 07:56:36 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id b16-20020a5d8950000000b006891a850acfso9167566iot.19
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 07:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=M0ck3zhRmF4k7FihEXUJjiDZ+fwtcv/W6kVeRN0u1vs=;
        b=4+lSIafrh/o5CBOTJ9V8KjpEyZn+6jeNfp4iaYzGmjlcQqY0MUm5VOopyWPGGWYSLC
         8OW9ljFT406lFx5hw+yK2zURlvgJOyy5ywloqDXfjiAVoIU4kNvqg65euC3Hcn/sDITC
         c0hC0yc1lrRmLZ7G46UgF3QUsrQODLJePmQOsSEli4c3qi7oajcekxG0WNDeZSxcLd8q
         0chatr46vDx76UEp3IXwjXVlh6bEuaeR+o7K/7AIoGTWgLdG9SfvGGxwiAQkPmn1/egC
         CPESzeOafgAxbeM/Xlv78jxbq6dPIOr0PI+vZhKD0IgJaKsHQRF8GwtyeBzN1BVS2EUc
         V9fg==
X-Gm-Message-State: ACgBeo0Ey2/MaFsTh96ry+p68bq6lvH05NtkO5AGateck3Ix3UCx5DkQ
        PsPF+RpFg8yNZErJ/KZZWQ2M29YSZ7Kv+hpavDzhVxrJlaiR
X-Google-Smtp-Source: AA6agR5t4AwuXZ/KT7KOUPlU+Fqk4GKe6LTMbwtLXUILoPhKonA+fzxicNDNAuz6+DQ9BNf8wM2+uEsL1bKVD9Zf81QNeCFbN0ub
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3720:b0:352:7d09:a327 with SMTP id
 k32-20020a056638372000b003527d09a327mr2274515jav.283.1662562594927; Wed, 07
 Sep 2022 07:56:34 -0700 (PDT)
Date:   Wed, 07 Sep 2022 07:56:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e33bb005e817847a@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in copy_process
From:   syzbot <syzbot+d3cb3281a93037d5a02e@syzkaller.appspotmail.com>
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

HEAD commit:    4e55e22d3d9a USB: hcd-pci: Drop the unused id parameter fr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15ba5d7d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=d3cb3281a93037d5a02e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26cea6f2cda1/disk-4e55e22d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00aba451c439/vmlinux-4e55e22d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3cb3281a93037d5a02e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000300: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000001800-0xfff8200000001807]
CPU: 0 PID: 36 Comm: kworker/u4:2 Not tainted 6.0.0-rc1-syzkaller-00049-g4e55e22d3d9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x15d/0x4a0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 7c 02 00 00 48 85 c0 0f 84 73 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 7b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900004778f0 EFLAGS: 00010246

RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000300
RDX: 0000000000000580 RSI: 0000000000000dc0 RDI: 000000000003e300
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff88de9657
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810016d500
R13: 0000000000000dc0 R14: ffffffff811486fe R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 copy_signal kernel/fork.c:1689 [inline]
 copy_process+0x256e/0x6de0 kernel/fork.c:2253
 kernel_clone+0xe7/0xab0 kernel/fork.c:2673
 user_mode_thread+0xad/0xe0 kernel/fork.c:2742
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
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
