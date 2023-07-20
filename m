Return-Path: <bpf+bounces-5476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6075B202
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F61C21303
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788418B0A;
	Thu, 20 Jul 2023 15:06:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D018AF9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:06:10 +0000 (UTC)
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFC1BC8
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:06:09 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9f057f6daso1525003a34.0
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865568; x=1690470368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKVBvLPG0X3iK7tBptTq+Ag6ZQ3K/JZ4/J9b/33HYx0=;
        b=jBK4OnVwRnkXyW6MbhWnp9sx5eVg+kTqQc94NGehGCtKhZM41QnXLaAlg30bjPLwRw
         1eGtjcEsv5kB9GvO0ndI4TqTS7wqN4R07WK3eM2rtwh9sbEFjYOpo3lEE0mI6VCKQ71b
         GTiEshAI1HZMqY9CHvVMukEsKyXWYH3aswErIwCChsd0b6HPveVPL8pUSF17/SIBe+gP
         QcJQzB4hY4vjw5VToopleZdCH7bxcooNoIE/uu+kEq3R6inoLhqS++xLBxbrw6uHDHbL
         8lb0yZRcYVBzL57e9EyGbn0Wok1TliJYctXevVRAfwVLvbtJ4pNv/PYwb/vbGjxtuRq2
         CTvQ==
X-Gm-Message-State: ABy/qLYPePMa+NTLFPft9XVm41wLK5BSbRxHP5VOc1NJrGNnx7h9mWpH
	419yYEReITFMrAl4/z0N6kEffvpLsDzixT6mznpTFmMKFZMW
X-Google-Smtp-Source: APBJJlHHXuaOTeRId5gNXQ+tDR5YOI1aFTzat+v+7c6DbDdGpzRv8lFcTImDAHbvoeovUaRkkJ4HcvnWlTExuo+hU3354885WXpm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:6503:0:b0:6b7:4ec4:cbb1 with SMTP id
 i3-20020a9d6503000000b006b74ec4cbb1mr3697830otl.7.1689865568542; Thu, 20 Jul
 2023 08:06:08 -0700 (PDT)
Date: Thu, 20 Jul 2023 08:06:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee69e80600ec7cc7@google.com>
Subject: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
From: syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ac9ffaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f36c6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8e73aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/disk-03b123de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmlinux-03b123de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041/bzImage-03b123de.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff88801529b000 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 57 at lib/debugobjects.c:514 debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 57 Comm: kworker/u4:4 Not tainted 6.5.0-rc1-syzkaller-00458-g03b123debcbc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 49 48 8b 14 dd c0 20 c8 8a 41 56 4c 89 e6 48 c7 c7 20 14 c8 8a e8 b2 fa 28 fd <0f> 0b 58 83 05 5c 8b 87 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90001587828 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888016ee5940 RSI: ffffffff814d4986 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8ac81a80
R13: ffffffff8a6df720 R14: 0000000000000000 R15: ffff88802a6b65c8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000c776000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x32b/0x490 lib/debugobjects.c:733
 debug_rcu_head_queue kernel/rcu/rcu.h:226 [inline]
 kvfree_call_rcu+0x30/0xbe0 kernel/rcu/tree.c:3359
 tcx_entry_free include/net/tcx.h:96 [inline]
 tcx_uninstall+0x2fd/0x630 kernel/bpf/tcx.c:115
 dev_tcx_uninstall include/net/tcx.h:174 [inline]
 unregister_netdevice_many_notify+0x5e7/0x1a20 net/core/dev.c:10899
 ip6gre_exit_batch_net+0x3ea/0x580 net/ipv6/ip6_gre.c:1642
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

