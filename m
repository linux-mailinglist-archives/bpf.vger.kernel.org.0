Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7645544243
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 06:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiFIEB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiFIEB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 00:01:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB67CB4E
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 21:01:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y22-20020a056602049600b006698cdaed88so2468766iov.7
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 21:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RSLiPAtENbTkSowwv2uPq1Qvn2KqDjp9roHFS/8AUSY=;
        b=EW9NCK1+pzgnsSHvAqMEjTuemHGiMGqnjAZp6QvfKIyGUVTv1Tt+lbO1SyiN3dQW97
         M0wrqlDDh4mxcKXMsQsmaHcV6uy90j+x7tdqHEyhdqy/VUMU7kPnNeQa7MKrQ/EsSA6/
         Ss1BAFGyuRKZJAjR4ipgk93KYq+hsqTQqSAlhIzHdYm5BDSX7cDSqsednCivmIYDaGR8
         Flvt3ApC88hjCTPg+fBI/CU0yxpO6k+rHbkHwq1m6Hoehsqgs/bf6b3RcCUx9/3UpbcK
         9eL1kHtEhtQ6/BH43PHE4GigMKe+9Dgxg0MlEHjXIgVhzmlG3gQHEt6OlK+SlPBS0XNa
         QY8A==
X-Gm-Message-State: AOAM5314nBBh0Rn4xx1pKoHGbsRAjY8RnV85TOgRu8SVET/dpFRLeIkY
        FZ4HVRUT35VGzeWKsuxDZTk84iIIO3xxuUF+TDL7aORt2YU8
X-Google-Smtp-Source: ABdhPJzyyKP5vrE2Hdhnme0jjwLAT91coYM95JWyNU9CSxjGxkjNdnqp5wWX5vLENY+BTkGhKSApw8vnAMk8Hjrua/U/wupKTUa0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:2d6:5dd3:e627 with SMTP id
 v5-20020a056e02164500b002d65dd3e627mr3465147ilu.268.1654747284259; Wed, 08
 Jun 2022 21:01:24 -0700 (PDT)
Date:   Wed, 08 Jun 2022 21:01:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000124e9105e0fbe047@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in
 corrupted (2)
From:   syzbot <syzbot+efe1afd49d981d281ae4@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, wangyufen@huawei.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    03c312cc5f47 Add linux-next specific files for 20220608
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155a4b73f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0a0f5184fb46b
dashboard link: https://syzkaller.appspot.com/bug?extid=efe1afd49d981d281ae4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d9ebff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125c6e5ff00000

The issue was bisected to:

commit d8616ee2affcff37c5d315310da557a694a3303d
Author: Wang Yufen <wangyufen@huawei.com>
Date:   Tue May 24 07:53:11 2022 +0000

    bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138a4b57f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104a4b57f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=178a4b57f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efe1afd49d981d281ae4@syzkaller.appspotmail.com
Fixes: d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")

BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3611, name: syz-executor124
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor124/3611:
 #0: ffff888073295c10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:742 [inline]
 #0: ffff888073295c10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x280 net/socket.c:649
 #1: ffff888073ff1ab0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
 #1: ffff888073ff1ab0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x1e/0xc0 net/ipv4/tcp.c:2908


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
