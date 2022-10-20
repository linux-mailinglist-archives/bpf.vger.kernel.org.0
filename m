Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E2605FE6
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJTMPn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJTMPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:15:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770E161FD0
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:15:41 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d24-20020a05660225d800b006a466ec7746so16315876iop.3
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e9ZO5SOsYzlwVYG1Clmk+zxKnqFrS6VDsFqsHX5Zi0=;
        b=MNJxXMra9zj/mK8DHM/A3sVy1UANn+ONVXveNrGLNCrF9EkVKgE/FPW4MekRYCEcUl
         9unkdZ3k39D0E537nXR14Jy6+N0hEQnDey3EShCAIe3b+ocadmsGBQQAPiL0KxclCHa7
         jXnrWrLnARvIffj2W6FBqnlYmRrthSYziRTVhbTBHgXlEw0/Ib3EnSRV5EV1tcqI7up/
         r6I7Mj3Io//85epQAkzT70CJRRHzVpTf1Y7geOg1CdU/TS/QI1vmPHvjGM2/3ntGwt2T
         ZBAil2XR+gMUzUmTJveyxIpKE0JOHxPDU+kx2/2ywKzccQO79w8/5Otk6m5Zr/HyuCRS
         oaKQ==
X-Gm-Message-State: ACrzQf02AzFJc+TDzwkvqPqCTY/UEK+tbpQZQEzEj/VSf3Ie6Wzh3wMS
        WHX3G0Tu/3bpED+VRgorjULtRCdixruBIumb6sF/gnk8+xvU
X-Google-Smtp-Source: AMsMyM7eitf9zHTov5cWQfhDpPO/mCD1WxZFGeso1nNVhmqJoAp5tKf+cmzlpvuHMIJWSrCYOwqWP9K7jfxYG2Wbn3tHSKP99wR5
MIME-Version: 1.0
X-Received: by 2002:a92:c514:0:b0:2f9:2b06:6283 with SMTP id
 r20-20020a92c514000000b002f92b066283mr9691757ilg.287.1666268140641; Thu, 20
 Oct 2022 05:15:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 05:15:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fa63105eb7648d8@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in vm_area_dup
From:   syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13cdacba880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8806, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8806 Comm: syz-executor.0 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
 might_alloc include/linux/sched/mm.h:274 [inline]
 slab_pre_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3323 [inline]
 slab_alloc mm/slub.c:3411 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
 kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 copy_vma+0x376/0x8d0 mm/mmap.c:3216
 move_vma+0x449/0xf60 mm/mremap.c:626
 __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe5a1e8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe5a30a7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007fe5a1fabf80 RCX: 00007fe5a1e8b5a9
RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
RBP: 00007fe5a1ee6580 R08: 00000000202ef000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee646383f R14: 00007fe5a30a7300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
