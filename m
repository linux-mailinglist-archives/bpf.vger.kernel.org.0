Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC02962611
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfGHQV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 12:21:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46960 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfGHQVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 12:21:25 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so36501177iol.13;
        Mon, 08 Jul 2019 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=SmN5EFIMBB9EcBNdZWlkN540cp3oExz4pb0qA9L1qq0=;
        b=C8s8BDKlkCJFkRR5YpKL5tKi67LYuNipSHTx3qPwA1l1k/ZvVkNibT8UrpI3XNyNo/
         CluZ44BMK/ziV5W7KzBNH0NXzmoX2Jq6jeIyEm4qaJAbwonTJu9c0JLcDxIOyeqqLKAj
         mACxKh062/YsxNYiByf54n9NWqIxfJGoCu2X+yE3DqP4XOmSEbCnqADGtU/ydWJK+naG
         4CNjv13KimDZJwuQ9Q4cNsNaQHJwuximAIrITUj0tZQRk4RV7Vc9/OY4F6nZ4zDre93Y
         vjhd/EoSWSIv2CBNs7UuMO1Ueo7nEe3xUJyu3RisUWi92iFMOXGeGgC4SP9PXFXUfBDe
         sqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=SmN5EFIMBB9EcBNdZWlkN540cp3oExz4pb0qA9L1qq0=;
        b=gXamSzP3aN7DT2nSKOzN1nx8Qs5XWv83vMxXh8i26LI6641kQo5+ycg37oD7mSSIkl
         wM60akWDNOQQib4GQazh4KNsRk+41nMA7mpmfFBayQqaNam1nia+ua3sK5oJKyT0qLAu
         u+NEBYE4ZiddUYgOmD7xoF8NxTybFMhroq0LSXCLDzyiEf4excif1ddwZtmY18nU0tv1
         qhfd0o+TExCzW2cZnTIrX/oHHDv1pvqHyZpyeCmv3x37UqeG238+0z6LEddAlVMjHKV3
         d4qtFW97CcxvdrF6FJD2oP8lh7vl0YKyg6bQVRbWaiEDp1nb2v2HTozGttg+sluTZ695
         ciNQ==
X-Gm-Message-State: APjAAAVmWeB62vCExQJQ/QKvmJ/4bt3hZYf52+HY7YEXOQQ1tyJuUSea
        5b7yJ2xttAfNCcvYhhjD+kQ=
X-Google-Smtp-Source: APXvYqzxYEml55UqQKfbWptdyh8ixilXO5dGlZCem+0W98DhejyZCoJ3/cmypwI1xnh3L3ZN/AdIyQ==
X-Received: by 2002:a6b:7b07:: with SMTP id l7mr15646304iop.225.1562602884883;
        Mon, 08 Jul 2019 09:21:24 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id d25sm16525839iom.52.2019.07.08.09.21.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:21:24 -0700 (PDT)
Date:   Mon, 08 Jul 2019 09:21:17 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, ebiggers@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Message-ID: <5d236d7dc1db6_75f52af7c83505bcc3@john-XPS-13-9370.notmuch>
In-Reply-To: <0000000000007eb42d058c9836ac@google.com>
References: <5d199ad457036_1dd62b219ced25b86e@john-XPS-13-9370.notmuch>
 <0000000000007eb42d058c9836ac@google.com>
Subject: Re: WARNING in mark_lock
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> KASAN: use-after-free Read in class_equal
> 
> ==================================================================
> BUG: KASAN: use-after-free in class_equal+0x40/0x50  
> kernel/locking/lockdep.c:1527
> Read of size 8 at addr ffff88808a268ba0 by task syz-executor.1/9270
> 
> CPU: 0 PID: 9270 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
> 
> Allocated by task 2647419968:
> BUG: unable to handle page fault for address: ffffffff8c00b020
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 8a70067 P4D 8a70067 PUD 8a71063 PMD 0
> Thread overran stack, or stack corrupted
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9270 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:stack_depot_fetch+0x10/0x30 lib/stackdepot.c:203
> Code: e9 7b fd ff ff 4c 89 ff e8 8d b4 62 fe e9 e6 fd ff ff 90 90 90 90 90  
> 90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 20  
> 6c 04 8b 48 8d 47 18 48 89 06 8b 47 0c c3 0f 1f 00
> RSP: 0018:ffff88808a2688e8 EFLAGS: 00010006
> RAX: 00000000001f8880 RBX: ffff88808a269304 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff88808a2688f0 RDI: 0000000000003ff0
> RBP: ffff88808a268908 R08: 0000000000000020 R09: ffffed1015d044fa
> R10: ffffed1015d044f9 R11: ffff8880ae8227cf R12: ffffea0002289a00
> R13: ffff88808a268ba0 R14: ffff8880aa58ec40 R15: ffff88808a269300
> FS:  00005555570ba940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c00b020 CR3: 000000008dd00000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> Modules linked in:
> CR2: ffffffff8c00b020
> ---[ end trace 4acfe4b59fbc9cdb ]---
> RIP: 0010:stack_depot_fetch+0x10/0x30 lib/stackdepot.c:203
> Code: e9 7b fd ff ff 4c 89 ff e8 8d b4 62 fe e9 e6 fd ff ff 90 90 90 90 90  
> 90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 20  
> 6c 04 8b 48 8d 47 18 48 89 06 8b 47 0c c3 0f 1f 00
> RSP: 0018:ffff88808a2688e8 EFLAGS: 00010006
> RAX: 00000000001f8880 RBX: ffff88808a269304 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff88808a2688f0 RDI: 0000000000003ff0
> RBP: ffff88808a268908 R08: 0000000000000020 R09: ffffed1015d044fa
> R10: ffffed1015d044f9 R11: ffff8880ae8227cf R12: ffffea0002289a00
> R13: ffff88808a268ba0 R14: ffff8880aa58ec40 R15: ffff88808a269300
> FS:  00005555570ba940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c00b020 CR3: 000000008dd00000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> Tested on:
> 
> commit:         0b58d013 bpf: tls, implement unhash to avoid transition ou..
> git tree:       git://github.com/cilium/linux ktls-unhash
> console output: https://syzkaller.appspot.com/x/log.txt?x=153368a3a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc918d28ebd06b4
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 

#syz test: git://github.com/cilium/linux fix-unhash
