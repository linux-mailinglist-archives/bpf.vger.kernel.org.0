Return-Path: <bpf+bounces-7549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A3779122
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487C62823B8
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E74463B3;
	Fri, 11 Aug 2023 13:57:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7129E0D
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:57:09 +0000 (UTC)
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336D430D5
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:57:08 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-56506e5dbfeso2388815a12.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762227; x=1692367027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc3qoaneO1kLx29x6mEA9kwQqviPaSaJh2spRac0iUk=;
        b=WKBvmlQip7aNMbhkRMMK/Ez5gcSUwxRP7fjlgnMYBbnFscDRuUI7B6AGiayd4l9G/U
         fzGEgN6qlYi+xipzK7dWwJ+ufyrWptJW6Ld6gfZj2Ywk7W2OTYCsxMUPk5Ki59Sg8wUI
         R7EjKH1OvYRUVXHN4G2voQY9OWkK1/BaacDcHXLqlXBx8jzxw3LyOdJu1ojCCT4ICblr
         GyjPGrfNlSU0K5Ve7FXqfVuMBEd0Z1HDUSsjr54mfla03yxpkcbl3o8XdjOYhKAGqpSH
         S0UOnwkw+1TjF6Vde0OYyY2a0QU16X+JutMq2q4kSLHlt9695URVJbkhbEL2qnuoUhjC
         uYhA==
X-Gm-Message-State: AOJu0YzzpylSfaSjhiO5wkr+XuTHSbV2ZPMyccFnxqff25Fc3FiU6X2M
	6pQF1GLYFW+V/QEtoXW0gifIE5Lbj0EuG1e2bHvqavlcLEQ+
X-Google-Smtp-Source: AGHT+IEvLw1pgCJ8dc9L/FePNt33WWJHWE9jt76MLuUyu1hyHNTehHaQjoHRZ9JQMizU4v13cW053zokYWalm30iZHN1DqzyBAGl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:a312:0:b0:565:7780:93d9 with SMTP id
 s18-20020a63a312000000b00565778093d9mr297502pge.12.1691762227611; Fri, 11 Aug
 2023 06:57:07 -0700 (PDT)
Date: Fri, 11 Aug 2023 06:57:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f0f9c0602a616ce@google.com>
Subject: [syzbot] [net?] WARNING in ip6_tnl_exit_batch_net
From: syzbot <syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, hawk@kernel.org, 
	idosch@nvidia.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, vladbu@nvidia.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=103213a5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=d810d3cd45ed1848c3f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1475a873a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153cc91ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz

The issue was bisected to:

commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Tue Aug 8 09:35:21 2023 +0000

    vlan: Fix VLAN 0 memory leak

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cbf169a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cbf169a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cbf169a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: netns cleanup_net
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc90000117a30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000070de5201 RCX: 0000000000000000
RDX: ffff88801526d940 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88807d7ee000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81004e11 R12: ffff888018fb2a00
R13: 0000000000000000 R14: 0000000000000002 R15: ffff888018fb2a00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005581d741a950 CR3: 000000007deef000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6_tnl_exit_batch_net+0x57d/0x6f0 net/ipv6/ip6_tunnel.c:2278
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

