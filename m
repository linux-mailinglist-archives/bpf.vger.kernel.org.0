Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8C15FEF7
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2020 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBOPdQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Feb 2020 10:33:16 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52263 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBOPdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Feb 2020 10:33:16 -0500
Received: by mail-il1-f200.google.com with SMTP id o5so10267329ilg.19
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2020 07:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=i1ZtrzvsphpDvmdslly7GxdVaV3LFE9gOyvz4k2Kd4o=;
        b=RVO5b6FrKvv3woIc9M8BU9KudAsVgivpyzZAyMLuyBWUrbnH34bJYab2aXjlLWP4FV
         vbUCqx1HbSt2UwXHkCDHEwBrXVcOifkL6un2lJfO2wKi1coEP3ibAo51z3VLotUG9fuf
         jpTa8HlR8IKz1gdMhpC1FfsBkcW/YF0htBRAfGFGfQTxjlSGlXe2jBPAkAZbb6nQbsRV
         xKm0o9wtHG+nyM641ikJY7HX4LkaxWvM/S43OztppHI2tE6MXt0b5ctw7RjXA51EG4pv
         nag/mPDmKwoIJ2GDnsBHxtvw50jOQl33Sce8xqGZLuFwO1GcwrX1nP1hg7/NHTh+P5Yr
         njWw==
X-Gm-Message-State: APjAAAVYi3HYk34GdO/RXpGYST/p+PAYNmweiwgaS9PSt03XWc5q3Chl
        Xb3QiBDZwzuDM7d25PC+FVu6KbsF8OEiFlOxSFbJ2NrXe0Av
X-Google-Smtp-Source: APXvYqwaf1rvNvL+yMEH5bZ2WsGu2SzzPqdBvJEz74lk96rib3k0fOVblHOHXJfNsAW+wX5QVomcBi9oS1AMk6CC1Qg43VCdt2Z2
MIME-Version: 1.0
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr6058924ior.129.1581780793813;
 Sat, 15 Feb 2020 07:33:13 -0800 (PST)
Date:   Sat, 15 Feb 2020 07:33:13 -0800
In-Reply-To: <000000000000fd119d0597d12a56@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053f643059e9f0a89@google.com>
Subject: Re: kernel panic: stack is corrupted in vhost_net_ioctl
From:   syzbot <syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        jasowang@redhat.com, john.fastabend@gmail.com, kuba@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    2019fc96 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1677602de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6780df5a5f208964
dashboard link: https://syzkaller.appspot.com/bug?extid=f2a62d07a5198c819c7b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dcd87ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1135fa31e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13204371e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a04371e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17204371e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f2a62d07a5198c819c7b@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vhost_net_ioctl+0x1d83/0x1db0 drivers/vhost/net.c:366
CPU: 0 PID: 8673 Comm: syz-executor239 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 panic+0x264/0x7a9 kernel/panic.c:221
 __stack_chk_fail+0x1f/0x20 kernel/panic.c:667
 vhost_net_ioctl+0x1d83/0x1db0 drivers/vhost/net.c:366
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
 __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440259
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdeb5890b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440259
RDX: 0000000020f1dff8 RSI: 000000004008af30 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401ae0
R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

