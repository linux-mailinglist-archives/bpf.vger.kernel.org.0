Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA67297147
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750556AbgJWO0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 10:26:24 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:52973 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750554AbgJWO0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 10:26:23 -0400
Received: by mail-il1-f200.google.com with SMTP id y15so1331345ilp.19
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 07:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Z4Tr5QAzJ2lgG9KcvZ/0qJAH0HusoMoqaOHz0jBjIaI=;
        b=RBW0D7TEm34GgI7LinvvyLzNQcp8DZvuvzCHlQewR8YJjxT0mcg/pujOysmsGqr38x
         eeS1JzlJOfG6Bw0ur19CMdaBc9yhfVpQymeb7Yey/aG5dFEW2b4xOli/W+3DBR+PTO90
         S1upV7C3XYeJ3sc8LaP603U/ZmNTEgiOhYmRO5Kz6brSiXEMp53EuuIMfUSL6g+1N8O+
         Mn8i/WzHVl4+ctqCXKGPd3vhj3dqsKUfvWBuNiQN+rWmBa/+A5uvPYPWuPEUR/dQx80M
         wZ9CJ3NHWLtgWg2kgaEvsJ5qcWWGvdKBASznl4bXOc7DFtUmRlNOUd/H9zmukhiiQPvY
         mQdg==
X-Gm-Message-State: AOAM533/s+0UDWS3iL7IkxPBEvYrJRS7/GSWs3/+BZf46UvvhzuTDVrk
        kyBeu/cxQWo5UkQ4ZtKPBNJBhrdiYSa8PHeCLOWxnEvcre1j
X-Google-Smtp-Source: ABdhPJzk4dcF/J0Wz+uXYl+HclT4T5n1i7kObeQdlcQAz/kIqfGHvOjOEZbAfOVCThSryxrSWYp2eXuQ9Z8QH5LfDSm+F91vCNe7
MIME-Version: 1.0
X-Received: by 2002:a92:99d7:: with SMTP id t84mr1074072ilk.108.1603463182790;
 Fri, 23 Oct 2020 07:26:22 -0700 (PDT)
Date:   Fri, 23 Oct 2020 07:26:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bb5d505b2575d29@google.com>
Subject: memory leak in xdp_umem_create
From:   syzbot <syzbot+eb71df123dc2be2c1456@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bjorn.topel@intel.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f804b315 Merge tag 'linux-watchdog-5.10-rc1' of git://www...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1797677f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=504c0405f28172a
dashboard link: https://syzkaller.appspot.com/bug?extid=eb71df123dc2be2c1456
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f27544500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fc4de8500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb71df123dc2be2c1456@syzkaller.appspotmail.com

Warning: Permanently added '10.128.10.22' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888110c1e400 (size 96):
  comm "syz-executor230", pid 8462, jiffies 4294942469 (age 13.280s)
  hex dump (first 32 bytes):
    00 50 e0 00 00 c9 ff ff 00 00 02 00 00 00 00 00  .P..............
    00 00 00 00 00 10 00 00 20 00 00 00 20 00 00 00  ........ ... ...
  backtrace:
    [<00000000c4608c2b>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000c4608c2b>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000c4608c2b>] xdp_umem_create+0x33/0x630 net/xdp/xdp_umem.c:229
    [<00000000551a05ed>] xsk_setsockopt+0x4ad/0x590 net/xdp/xsk.c:852
    [<00000000f143ff32>] __sys_setsockopt+0x1b0/0x360 net/socket.c:2132
    [<0000000076c65982>] __do_sys_setsockopt net/socket.c:2143 [inline]
    [<0000000076c65982>] __se_sys_setsockopt net/socket.c:2140 [inline]
    [<0000000076c65982>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2140
    [<00000000d47a7174>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000fb8e5852>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810e018f00 (size 256):
  comm "syz-executor230", pid 8462, jiffies 4294942469 (age 13.280s)
  hex dump (first 32 bytes):
    00 00 4f 04 00 ea ff ff 40 00 4f 04 00 ea ff ff  ..O.....@.O.....
    80 00 4f 04 00 ea ff ff c0 00 4f 04 00 ea ff ff  ..O.......O.....
  backtrace:
    [<00000000257d0c74>] kmalloc_array include/linux/slab.h:594 [inline]
    [<00000000257d0c74>] kcalloc include/linux/slab.h:605 [inline]
    [<00000000257d0c74>] xdp_umem_pin_pages net/xdp/xdp_umem.c:89 [inline]
    [<00000000257d0c74>] xdp_umem_reg net/xdp/xdp_umem.c:207 [inline]
    [<00000000257d0c74>] xdp_umem_create+0x3cc/0x630 net/xdp/xdp_umem.c:240
    [<00000000551a05ed>] xsk_setsockopt+0x4ad/0x590 net/xdp/xsk.c:852
    [<00000000f143ff32>] __sys_setsockopt+0x1b0/0x360 net/socket.c:2132
    [<0000000076c65982>] __do_sys_setsockopt net/socket.c:2143 [inline]
    [<0000000076c65982>] __se_sys_setsockopt net/socket.c:2140 [inline]
    [<0000000076c65982>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2140
    [<00000000d47a7174>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000fb8e5852>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
