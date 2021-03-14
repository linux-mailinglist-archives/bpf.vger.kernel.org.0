Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC033A44C
	for <lists+bpf@lfdr.de>; Sun, 14 Mar 2021 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhCNLD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhCNLD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 07:03:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE31C061574
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 04:03:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d20so29011763qkc.2
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLrP4l4H65pb8M2x3DmR+dro99lUOubfCFMxCcIwSs8=;
        b=aqFQ0r0ajDoxAzsNxpA6vK0Zdj3ovoLhw+/jMkUZTnXEBFuxuFhCDIVChyina/YdNL
         TiaChHRMrS2bq6ra3/XwlhKAi448hL+T1ODNfJ9v536uUtYf6IVUoVavpUIjrXILA0aQ
         EXE5As5UjV1qrO0Du4u9rcqqtisZ5WumTKmyt4G85Y7rU3m2iEuTiPwyno8gVaViFGW1
         ohQO7ehjYfrWMXVZwOiQfcUyiy56ZWJ+BV0GlxiMD7RFjQFo0jjnzjra3WZ0yO3WmyCP
         wjcshkgQEmEb2OyJmoUhnxUvF48KQt/9Xg5P6UtdJIksT1m727NGOrsTKH6u9a5ucfWx
         9WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLrP4l4H65pb8M2x3DmR+dro99lUOubfCFMxCcIwSs8=;
        b=c6x4UWAIJVudBROGpq3L0f3D1OopChRmxbkjC6HfZwfe81J5wHb5MepuSI2srVRMCq
         eLDbFC8/R7VA9EOp8UXscu0oMdjk5SMgnGD7XN0am9DXmMqmG8WTZBFYV0TJFTWUK6mx
         p03QhqyhA4Ob7yVAjlYmDuaEShHDBo7ZWpbh97sJv/p1SYVbWHi7ybwy1sJ2LYZ28eYh
         sT63APDLQTfVlkSyroTUz4uWZRyQT4Sp7zQkC5J6sBYrKVcJsT3wa2R3RnoyRc0m4c/D
         jnIk25DH1b+v07x1cwXE+zZjGtevF2Tlu9gSnd1b4hCruaE/kIupYrrgaa3zqIZf4EfT
         je9Q==
X-Gm-Message-State: AOAM533HbL5y0RNnujJKQCDvbR5MFkicr+3BVXXolaEUmnJiPfXiieS7
        d9aHVVsQdDtp15J2YscCLrpzKOS/UJ4dr8GilrlNrQ==
X-Google-Smtp-Source: ABdhPJwEegFcOLhpznys7nGUJ8jy4+601fJsOcZDpPR+EdJcnLdnSVL+p2u/yEUr6V/fvF+FJ96hAtYrDtqWf6oc7wU=
X-Received: by 2002:a37:4743:: with SMTP id u64mr20614742qka.350.1615719834825;
 Sun, 14 Mar 2021 04:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000096cdaa05bd32d46f@google.com> <CACT4Y+ZjdOaX_X530p+vPbG4mbtUuFsJ1v-gD24T4DnFUqcudA@mail.gmail.com>
 <CACT4Y+ZjVS+nOxtEByF5-djuhbCYLSDdZ7V04qJ0edpQR0514A@mail.gmail.com>
In-Reply-To: <CACT4Y+ZjVS+nOxtEByF5-djuhbCYLSDdZ7V04qJ0edpQR0514A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 14 Mar 2021 12:03:43 +0100
Message-ID: <CACT4Y+YXifnCtEvLu3ps8JLCK9CBLzEuUAozfNR9v1hsGWspOg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in sock_ioctl
To:     syzbot <syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     andrii@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, kpsingh@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 14, 2021 at 11:01 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Wed, Mar 10, 2021 at 7:28 PM syzbot
> > <syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=122c343ad00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c23c5421600e9b454849
> > > userspace arch: riscv64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com
> >
> > +riscv maintainers
> >
> > Another case of put_user crashing.
>
> There are 58 crashes in sock_ioctl already. Somehow there is a very
> significant skew towards crashing with this "user memory without
> uaccess routines" in schedule_tail and sock_ioctl of all places in the
> kernel that use put_user... This looks very strange... Any ideas
> what's special about these 2 locations?

I could imagine if such a crash happens after a previous stack
overflow and now task data structures are corrupted. But f_getown does
not look like a function that consumes way more than other kernel
syscalls...



> > > Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000020000300
> > > Oops [#1]
> > > Modules linked in:
> > > CPU: 1 PID: 4488 Comm: syz-executor.0 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> > > Hardware name: riscv-virtio,qemu (DT)
> > > epc : sock_ioctl+0x424/0x6ac net/socket.c:1124
> > >  ra : sock_ioctl+0x424/0x6ac net/socket.c:1124
> > > epc : ffffffe002aeeb3e ra : ffffffe002aeeb3e sp : ffffffe023867da0
> > >  gp : ffffffe005d25378 tp : ffffffe007e116c0 t0 : 0000000000000000
> > >  t1 : 0000000000000001 t2 : 0000003fb8035e44 s0 : ffffffe023867e30
> > >  s1 : 0000000000040000 a0 : 0000000000000000 a1 : 0000000000000007
> > >  a2 : 1ffffffc00fc22d8 a3 : ffffffe003bc1d02 a4 : 0000000000000000
> > >  a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
> > >  s2 : 0000000000000000 s3 : 0000000000008902 s4 : 0000000020000300
> > >  s5 : ffffffe005d2b0d0 s6 : ffffffe010facfc0 s7 : ffffffe008e00000
> > >  s8 : 0000000000008903 s9 : ffffffe010fad080 s10: 0000000000000000
> > >  s11: 0000000000020000 t3 : 982de389919f6300 t4 : ffffffc401175688
> > >  t5 : ffffffc401175691 t6 : 0000000000000007
> > > status: 0000000000000120 badaddr: 0000000020000300 cause: 000000000000000f
> > > Call Trace:
> > > [<ffffffe002aeeb3e>] sock_ioctl+0x424/0x6ac net/socket.c:1124
> > > [<ffffffe0003fdb6a>] vfs_ioctl fs/ioctl.c:48 [inline]
> > > [<ffffffe0003fdb6a>] __do_sys_ioctl fs/ioctl.c:753 [inline]
> > > [<ffffffe0003fdb6a>] sys_ioctl+0x5c2/0xd56 fs/ioctl.c:739
> > > [<ffffffe000005562>] ret_from_syscall+0x0/0x2
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > ---[ end trace a5f91e70f37b907b ]---
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
