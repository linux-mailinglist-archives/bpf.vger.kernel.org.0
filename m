Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F95B460
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 07:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfGAFvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 01:51:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35028 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfGAFvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 01:51:01 -0400
Received: by mail-io1-f72.google.com with SMTP id w17so14071133iom.2
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2019 22:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qCv6O8PlYg+ZT3/7zG6DuN2UhJzRl942UxJbgb+Ot2U=;
        b=T1sfTOtXmnnMnP+ahbU5+BF4LfrJ+qnNdOUKPfuNnPf5TFUye7ch32cwgYymnQRvXo
         w43LUl3PMzVBVCrL6nwz+QHx5or5fKv0T2j154OC6XLKNMdXv/6A0em1eHOB/gASWqqo
         OxVrPkE5yrwg3OObPirdv6Ni43AVafDM5tNiu5K6zZS+U7VbT6gOZnQWDKaUhEpfJluM
         oReb0becEvzInuXeRIkdDzkt2fq+OYGc0QX60ZE8HCju8mvGciW6KZ73ehdnvvXb24Sz
         cYqwsIRt6KdHFxl9izAbZQRS6sm3HZJ0x4qgVjsWZdt//TbHsSpeCPxEjbZSCGz5xQVn
         shnA==
X-Gm-Message-State: APjAAAVPY0WGmJmSBHEn3n3eZpO0BOJC9sIjMDSFZYSV78Eo4EOym4kz
        xF1I0Kar2SNifbJNkrrCjHX9r/oP0Mi1iINv0Fof4B55s8nT
X-Google-Smtp-Source: APXvYqz9w2zVcH6kNVua0uWx+iYzOLbIPZQ+5rE5IxWvE2bRVxNupp6tM2dPKMXEakSe0K50uQHi7ZAYlzPAfHaFjnJqyTIn5ocg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e4:: with SMTP id s4mr27121967jaq.141.1561960260741;
 Sun, 30 Jun 2019 22:51:00 -0700 (PDT)
Date:   Sun, 30 Jun 2019 22:51:00 -0700
In-Reply-To: <5d199ad457036_1dd62b219ced25b86e@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007eb42d058c9836ac@google.com>
Subject: Re: WARNING in mark_lock
From:   syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, ebiggers@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KASAN: use-after-free Read in class_equal

==================================================================
BUG: KASAN: use-after-free in class_equal+0x40/0x50  
kernel/locking/lockdep.c:1527
Read of size 8 at addr ffff88808a268ba0 by task syz-executor.1/9270

CPU: 0 PID: 9270 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 2647419968:
BUG: unable to handle page fault for address: ffffffff8c00b020
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 8a70067 P4D 8a70067 PUD 8a71063 PMD 0
Thread overran stack, or stack corrupted
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9270 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:stack_depot_fetch+0x10/0x30 lib/stackdepot.c:203
Code: e9 7b fd ff ff 4c 89 ff e8 8d b4 62 fe e9 e6 fd ff ff 90 90 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 20  
6c 04 8b 48 8d 47 18 48 89 06 8b 47 0c c3 0f 1f 00
RSP: 0018:ffff88808a2688e8 EFLAGS: 00010006
RAX: 00000000001f8880 RBX: ffff88808a269304 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88808a2688f0 RDI: 0000000000003ff0
RBP: ffff88808a268908 R08: 0000000000000020 R09: ffffed1015d044fa
R10: ffffed1015d044f9 R11: ffff8880ae8227cf R12: ffffea0002289a00
R13: ffff88808a268ba0 R14: ffff8880aa58ec40 R15: ffff88808a269300
FS:  00005555570ba940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c00b020 CR3: 000000008dd00000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
CR2: ffffffff8c00b020
---[ end trace 4acfe4b59fbc9cdb ]---
RIP: 0010:stack_depot_fetch+0x10/0x30 lib/stackdepot.c:203
Code: e9 7b fd ff ff 4c 89 ff e8 8d b4 62 fe e9 e6 fd ff ff 90 90 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 20  
6c 04 8b 48 8d 47 18 48 89 06 8b 47 0c c3 0f 1f 00
RSP: 0018:ffff88808a2688e8 EFLAGS: 00010006
RAX: 00000000001f8880 RBX: ffff88808a269304 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88808a2688f0 RDI: 0000000000003ff0
RBP: ffff88808a268908 R08: 0000000000000020 R09: ffffed1015d044fa
R10: ffffed1015d044f9 R11: ffff8880ae8227cf R12: ffffea0002289a00
R13: ffff88808a268ba0 R14: ffff8880aa58ec40 R15: ffff88808a269300
FS:  00005555570ba940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c00b020 CR3: 000000008dd00000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         0b58d013 bpf: tls, implement unhash to avoid transition ou..
git tree:       git://github.com/cilium/linux ktls-unhash
console output: https://syzkaller.appspot.com/x/log.txt?x=153368a3a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc918d28ebd06b4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

