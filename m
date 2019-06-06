Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9299376FE
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfFFOls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 10:41:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33059 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfFFOls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 10:41:48 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so410226iop.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUBzruiX0poMVnebHkNCtUzf308xan955Nhmvp3Y24o=;
        b=N8oLfhfCoP/t5PYG52TcjF2tc8yM9MUIV91XTL1dQyRXANlO4TMjLOYVQCRmv8WS6G
         dPw0BjG98OS26hm3NjvwDU7LkcKsojQNR+HtJHfn0Uu01UYlMw6RpKw5CnAKrKbgERRc
         2B9n2VfK+C2+t1MKp0rZkCMTUbOPSMd4tw2wsCq3Lq6LQzBNAOEMbAzcOb/PxPAJyKLf
         028o5J4GgWK6IRAQT6Ab31TogjeE80cmxwOJdjspx80QtGRG9ICcAFNCpapC7hbZ59bs
         i24iWVXGStx0+mKUkyKF5GE86Vfs3BkmG5/DCWI3rUSsj1jkzj6Gx8qKJK1N71cii1jt
         8NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUBzruiX0poMVnebHkNCtUzf308xan955Nhmvp3Y24o=;
        b=TgpfwqLkr+RQX+BPIQhILBUgJhHqcRzGEi6ktH8ArYanhyPsbXtC47Ac2Ti3Ry+/FC
         XJsKIOapkBEaUZFId5lIUJXAt/c+C+bl4NjkeRdgwkx927EB1Wabj4YlVGdFkR6oChSF
         Csr2Dy9933Txi7UWShBWqK/7H8QGao2CHzT7uad1vmFQ+Ko9VIFd6o5FYKwMTVzbozsS
         h8ihnfepYBta8FvL6mytbs+UPZ56wzI5JrIoe6O9lyxuamu7LiUx4sRmGshHkB+gK/G7
         N9h+5N8Ilf7+4ZIKcW1ON8YK0GDcA5rWE1VoCG7Hgsn4OxJmMHkRkRjhWYfTiNR3GJFT
         iiKQ==
X-Gm-Message-State: APjAAAUUSYe+nTyW449JFfHim9pgnwRvsIVo24veuy+Jtus/hYI9QPvR
        QkqHsk+MlFcR65rKY0YR0xZIoDc+/BXbAeYKuIGvDw==
X-Google-Smtp-Source: APXvYqz8hOqO9k3wIdvVxhHX1nxpHAKAeuDw82/eM+fgXI+5jTsEKJYqN9UOwv8HWhW3FUMfi6A1SwZfoXGCqRs3Edg=
X-Received: by 2002:a6b:8d92:: with SMTP id p140mr28286627iod.144.1559832107426;
 Thu, 06 Jun 2019 07:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000454279058aa80535@google.com>
In-Reply-To: <000000000000454279058aa80535@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 16:41:36 +0200
Message-ID: <CACT4Y+bk4=avQpdiHM7BTRjZ+NahivshytP5-eVU7vDCxR2udA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usage_accumulate
To:     syzbot <syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 6, 2019 at 3:52 PM syzbot
<syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f2095aa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0d730107e2ca6cb952f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a8fb61a00000

Looks +bpf related from the repro.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in usage_accumulate+0x9e/0xb0
> kernel/locking/lockdep.c:1676
> Read of size 8 at addr ffff8880a59cfed0 by task syz-executor.1/9366
>
> CPU: 1 PID: 9366 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> Allocated by task 0:
> (stack is not available)
>
> Freed by task 0:
> (stack is not available)
>
> The buggy address belongs to the object at ffff8880a59ce6c0
>   which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 2064 bytes to the right of
>   4096-byte region [ffff8880a59ce6c0, ffff8880a59cf6c0)
> The buggy address belongs to the page:
> page:ffffea0002967380 refcount:1 mapcount:0 mapping:ffff8880aa400dc0
> index:0x0 compound_mapcount: 0
> flags: 0x1fffc0000010200(slab|head)
> raw: 01fffc0000010200 ffffea000296a008 ffffea000233fe08 ffff8880aa400dc0
> raw: 0000000000000000 ffff8880a59ce6c0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8880a59cfd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8880a59cfe00: fc fc fc fc f1 f1 f1 f1 00 f2 f2 f2 00 f2 f2 f2
> > ffff8880a59cfe80: 00 f2 f2 f2 00 f2 f2 f2 fc fc fc fc 00 00 00 f2
>                                                   ^
>   ffff8880a59cff00: f2 f2 f2 f2 fc fc fc fc 00 00 00 f3 f3 f3 f3 f3
>   ffff8880a59cff80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> ==================================================================
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000454279058aa80535%40google.com.
> For more options, visit https://groups.google.com/d/optout.
