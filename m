Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16D2D5442
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 08:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgLJG6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 01:58:51 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45558 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387694AbgLJG6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 01:58:51 -0500
Received: by mail-il1-f200.google.com with SMTP id x10so3551027ilq.12
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 22:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aaJCcC8Sm2rMoASehVPhtArVK1xTKmJbN46GqeFlACc=;
        b=WcEJUYEhr+ECLqJNfstDNlM8Y7sQsL6keZRIQu8qxrs3pvMbiOgGQmY1GgVnizy8l/
         bEQH9J+aesR5/mb4u0VnsCfZt7iAuyWjjCas98OC6NdiHP+VbNPByAGBwt7Lhh2UoZsD
         rImEtSyQyzIBfsoXXE5IIVx17wPzsEOyz9bU11f016NPmy+f0rL/blGRBNoEwkJ6PHF3
         TMz6b7jnYhytN2wjd62ZkTE4/f7O6MBg2liReXXgDtAW4iZCoxal/+QcYmhWLDihCeDy
         jtZOYTNJp6MFwtTWy7DHfbPdjl6XMh28g68+nhiZOWKCeiv8SBMZyPLTh+iJn1zRu3i9
         tN+g==
X-Gm-Message-State: AOAM530SD2K1pC7O7Rd1LNEBECevMKRd23uqFyZfhHlY0LHMmq921pO4
        Sk3ulP1LiGhaMpuwwYMhkzQ+eyNFraqrxIv/5tYbd2HVee5K
X-Google-Smtp-Source: ABdhPJyE32kAOjZX/8Ff5hJ1mHIx2zLec/RC3L+2S9Yo8qudw63GLqTcPzi8XX5qHvpZAu0ZDHsstR0eSihZyA5LziDZhlx75opp
MIME-Version: 1.0
X-Received: by 2002:a6b:c3c5:: with SMTP id t188mr7341300iof.209.1607583490465;
 Wed, 09 Dec 2020 22:58:10 -0800 (PST)
Date:   Wed, 09 Dec 2020 22:58:10 -0800
In-Reply-To: <000000000000911d3905b459824c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e56a2605b616b2d9@google.com>
Subject: Re: memory leak in bpf
From:   syzbot <syzbot+f3694595248708227d35@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11facf17500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4305fa9ea70c7a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=f3694595248708227d35
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159a9613500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bf7123500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3694595248708227d35@syzkaller.appspotmail.com

Debian GNU/Linux 9 syzkaller ttyS0
Warning: Permanently added '10.128.0.9' (ECDSA) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810efccc80 (size 64):
  comm "syz-executor334", pid 8460, jiffies 4294945724 (age 13.850s)
  hex dump (first 32 bytes):
    c0 cb 14 04 00 ea ff ff c0 c2 11 04 00 ea ff ff  ................
    c0 56 3f 04 00 ea ff ff 40 18 38 04 00 ea ff ff  .V?.....@.8.....
  backtrace:
    [<0000000036ae98a7>] kmalloc_node include/linux/slab.h:575 [inline]
    [<0000000036ae98a7>] bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:94 [inline]
    [<0000000036ae98a7>] bpf_ringbuf_alloc kernel/bpf/ringbuf.c:135 [inline]
    [<0000000036ae98a7>] ringbuf_map_alloc kernel/bpf/ringbuf.c:183 [inline]
    [<0000000036ae98a7>] ringbuf_map_alloc+0x1be/0x410 kernel/bpf/ringbuf.c:150
    [<00000000d2cb93ae>] find_and_alloc_map kernel/bpf/syscall.c:122 [inline]
    [<00000000d2cb93ae>] map_create kernel/bpf/syscall.c:825 [inline]
    [<00000000d2cb93ae>] __do_sys_bpf+0x7d0/0x30a0 kernel/bpf/syscall.c:4381
    [<000000008feaf393>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e1f53cfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


