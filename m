Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734DC471712
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhLKWEW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 17:04:22 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:34754 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhLKWEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Dec 2021 17:04:22 -0500
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021b8a00b002a3f246adeaso12771915ili.1
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 14:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=31ZnY55RFUp+GSZ4GBgxn8B/M7nKKxdMX7CbhSvMYSI=;
        b=sFa1xz24aGD7x+5O1yy5au9M3HjReY6lnW0pz8MllIjxtjauRQGBeGZ5992RjU3EeU
         EuMWxDmdmlN9vyJX/VqGSgu18gvh3b38avq9fDlNwt5MiwcVaC5w8KnBdtwJW6ziCSiP
         9528Ni/n1UTdn4f3wZNIi6lk4R2S5Yy0lGMx4LsKdboQR2GWC/kpn6FKp9cXSPk92WFL
         0zCklNu+awbbcVfwQXcs2t12wWV35LzIb99VGPEfDO/2+nQ46X8LW9Cyc3w9Yb/F6x73
         a5Pp7rEPHypakcMkqa23VKEtgyGXCZ02J6Tuw6WdGBB8cSLSEhZSmd8phQUqxFJrzUxu
         1Pdg==
X-Gm-Message-State: AOAM532EW3PtcwAONUgUI+jTcOObSP9L3o9kqzKAqcT18Y7qwWRz2hLV
        QxJymaj4t+IggI0ldy6PAX+eHo0JIbXaWCdf4K+VRV1s6rJk
X-Google-Smtp-Source: ABdhPJzUMJWKdauYpJPL8xZ4g221gRRdIbAR8sRmFOqXTCpVmPOeKmuzXgn75jEla4APahQV3JImixl9pqF4gd7D7xpGQQ5zFhvm
MIME-Version: 1.0
X-Received: by 2002:a05:6602:218d:: with SMTP id b13mr27860356iob.19.1639260261717;
 Sat, 11 Dec 2021 14:04:21 -0800 (PST)
Date:   Sat, 11 Dec 2021 14:04:21 -0800
In-Reply-To: <00000000000069e12f05d0b78c2d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000981d5005d2e60598@google.com>
Subject: Re: [syzbot] BUG: MAX_LOCKDEP_CHAINS too low! (3)
From:   syzbot <syzbot+8a249628ae32ea7de3a2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, andy@greyhouse.net,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, glider@google.com, hawk@kernel.org,
        j.vosburgh@gmail.com, john.fastabend@gmail.com,
        john.ogness@linutronix.de, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        songliubraving@fb.com, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6f513529296f Merge tag 'for-5.16-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8954db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=8a249628ae32ea7de3a2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12777551b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a99a05b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a249628ae32ea7de3a2@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 0 PID: 6709 Comm: kworker/u4:7 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bond1948 bond_netdev_notify_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 add_chain_cache kernel/locking/lockdep.c:3649 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3748 [inline]
 validate_chain kernel/locking/lockdep.c:3769 [inline]
 __lock_acquire.cold+0x372/0x3ab kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 process_one_work+0x921/0x1690 kernel/workqueue.c:2274
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

