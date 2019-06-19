Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907A04C11E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2019 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfFSS6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jun 2019 14:58:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39484 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSS6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jun 2019 14:58:32 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so973637iod.6
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2e3DEoladpLs8H3K3Mp2fiGhxN4Yp9scwziIC/YjDQ=;
        b=U0f7JwIn5QRerxwauJ065oiF+oLXtyzHhIUra7UhqCpav15QPTk/xbbfX2s61nygat
         p8mjtBR5sEkNnZXLKIgxt+U/PLfxPf2HUsphakGZqLS4mZ1I1Z9iiJBdMPoVV5Ck7I4q
         Y1L26zznACwOtIRlJZMxaaUFiskKCiOn9aR8tDPOnkiaqIHHI3HpX6P+jlaUITlpx3Up
         1DptA7W/D1L8EkNW93w9YT6LYcYTjM3FDQ7p/5E+iptqzwetVaJgrszH5gG1qI0II5nh
         TgMErBSIY0YLYiZ79vl1Qk7Xcw4MfTQJ3LSRpZbGb/j7fbmvwgAYNDad6LVACo6nozS2
         NL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2e3DEoladpLs8H3K3Mp2fiGhxN4Yp9scwziIC/YjDQ=;
        b=QCkZyElnfaVJVQo9Tk65TuEdhEMVlwRGrodGQPNDy3RZ5YMr0n9mimgHW7fYQ8wMqK
         JLc6VWAF+QqZdMtO9AVMvRSRcg2XqoBzEq1C2E7Q6JUPgKCAT2FQMNTQlfMPBd6rNRLb
         fAUng+hSCM/sv30lX8ekezlDaAqXxfC+gI8XlchqpGYjLCVXS3VeCsVZNujbqtFhZXLD
         Qhqe+ZWiOaKxSzo1HzI/xOeX2DnuEB5+7UNUj056LbzpPved65PVzcnkGggJcOaeDv11
         WZv+0tvVhwWThwbfbzjvfJ+qA8lYd7icKsRz7cofb4HZFo7twRYofyaL+YJLYwKT3anW
         91/g==
X-Gm-Message-State: APjAAAXOOKdGw32QrWKGt3GKV3TFne14H7sS2/rd1/yEfnj6omjOT/FB
        QzOoeWXYEYVzhAhfehbYI1Pb0fnSnD8OStT1uoujcA==
X-Google-Smtp-Source: APXvYqxjLjqskOYy1HthCNZMRUuYC/TCExZ4vEuVJwF+B+izgNaNUmsiFEMPVEWPZqScBmjdaqlsqGLPjJwjpRlOPk8=
X-Received: by 2002:a6b:8d92:: with SMTP id p140mr12604322iod.144.1560970711470;
 Wed, 19 Jun 2019 11:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000017c9e2058baf4825@google.com>
In-Reply-To: <00000000000017c9e2058baf4825@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Jun 2019 20:58:19 +0200
Message-ID: <CACT4Y+ZXjFs8uDhSY-WV75cG4nX5n9COdqQJH8efrK-9AhnzDw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in __do_softirq
To:     syzbot <syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        jacob.jun.pan@linux.intel.com, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, puwen@hygon.cn,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 19, 2019 at 5:57 PM syzbot
<syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d7464ea00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b224895cb9454584de1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1076d132a00000

The same bpf plague bug...
+bpf mailing list

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com
>
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle page fault for address: ffff88808eb889e0
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0011) - permissions violation
> PGD b401067 P4D b401067 PUD 21ffff067 PMD 800000008ea001e3
> Oops: 0011 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9056 Comm: udevd Not tainted 5.2.0-rc5+ #36
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:0xffff88808eb889e0
> Code: 00 00 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 80 20 a8 94 80
> 88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <10> 8a b8 8e 80
> 88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
> RSP: 0018:ffff8880ae809e00 EFLAGS: 00010246
> RAX: 1ffff11011d71136 RBX: ffff88808eb889b0 RCX: dffffc0000000000
> RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88808eb889a8
> RBP: ffff8880ae809f00 R08: 000000001dda059f R09: ffff888098310d88
> R10: ffff888098310d68 R11: ffff8880983104c0 R12: ffff8880ae809ed8
> R13: ffff88808eb889a8 R14: ffff88808eb889e0 R15: ffff8880ae809e78
> FS:  00007fa9e44d17a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88808eb889e0 CR3: 0000000093130000 CR4: 00000000001406f0
> Call Trace:
>   <IRQ>
>   __do_softirq+0x25c/0x94c kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x180/0x1d0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0x13b/0x550 arch/x86/kernel/apic/apic.c:1068
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
>   </IRQ>
> RIP: 0010:tomoyo_domain_quota_is_ok+0x460/0x540 security/tomoyo/util.c:1039
> Code: 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07
> 0f b6 04 08 38 d0 7f 98 84 c0 74 94 e8 42 ca ab fe eb 8d <e8> 0b 1e 73 fe
> 49 8d 7c 24 1a 48 b9 00 00 00 00 00 fc ff df 48 89
> RSP: 0018:ffff88807a8f77e0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82fda05c
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
> RBP: ffff88807a8f7820 R08: ffff8880983104c0 R09: ffffed100f51ef11
> R10: ffffed100f51ef10 R11: 0000000000000000 R12: ffff8880a9a0d580
> R13: 0000000000000000 R14: 0000000000000185 R15: 0000000000000000
>   tomoyo_supervisor+0x2e8/0xef0 security/tomoyo/common.c:2087
>   tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
>   tomoyo_path_permission security/tomoyo/file.c:587 [inline]
>   tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
>   tomoyo_path_perm+0x31d/0x430 security/tomoyo/file.c:838
>   tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
>   security_inode_getattr+0xf2/0x150 security/security.c:1179
>   vfs_getattr+0x25/0x70 fs/stat.c:115
>   vfs_statx+0x157/0x200 fs/stat.c:191
>   vfs_stat include/linux/fs.h:3193 [inline]
>   __do_sys_newstat+0xa4/0x130 fs/stat.c:341
>   __se_sys_newstat fs/stat.c:337 [inline]
>   __x64_sys_newstat+0x54/0x80 fs/stat.c:337
>   do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7fa9e3bd8c65
> Code: 00 00 00 e8 5d 01 00 00 48 83 c4 18 c3 90 90 90 90 90 90 90 90 83 ff
> 01 48 89 f0 77 18 48 89 c7 48 89 d6 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff
> ff 77 17 f3 c3 90 48 8b 05 a1 51 2b 00 64 c7 00 16
> RSP: 002b:00007ffd19df2268 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
> RAX: ffffffffffffffda RBX: 00007ffd19df2300 RCX: 00007fa9e3bd8c65
> RDX: 00007ffd19df2270 RSI: 00007ffd19df2270 RDI: 00007ffd19df2300
> RBP: 000000000165cf70 R08: 00007ffd19df2310 R09: 00007fa9e3c2efc0
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000165b250
> R13: 0000000000000000 R14: 000000000165b250 R15: 000000000000000b
> Modules linked in:
> CR2: ffff88808eb889e0
> ---[ end trace 9983c7ba6b20cddb ]---
> RIP: 0010:0xffff88808eb889e0
> Code: 00 00 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 80 20 a8 94 80
> 88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <10> 8a b8 8e 80
> 88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
> RSP: 0018:ffff8880ae809e00 EFLAGS: 00010246
> RAX: 1ffff11011d71136 RBX: ffff88808eb889b0 RCX: dffffc0000000000
> RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88808eb889a8
> RBP: ffff8880ae809f00 R08: 000000001dda059f R09: ffff888098310d88
> R10: ffff888098310d68 R11: ffff8880983104c0 R12: ffff8880ae809ed8
> R13: ffff88808eb889a8 R14: ffff88808eb889e0 R15: ffff8880ae809e78
> FS:  00007fa9e44d17a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88808eb889e0 CR3: 0000000093130000 CR4: 00000000001406f0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000017c9e2058baf4825%40google.com.
> For more options, visit https://groups.google.com/d/optout.
