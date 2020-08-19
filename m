Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281324A114
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHSOEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgHSODu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 10:03:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1977C061757
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 07:03:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so21653741qkn.4
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6uVxpmjtJrh49bROR/GEwsOKP2TcklwbBBYVDi6akw=;
        b=k40ZfWjhNmOpU2w4xEJdm6hYDexLqDT/XT/LZhLcfGTms42rQmhxdYak5ItY+rLPAz
         YE6o6c69VVxhMZQ8PrAU7Lf3yYPZeUa8Y8VIi1vzNWmB+IuDu+YnHG8rEqkaodSJ89tI
         QKGsuWe7VZu4zUwr9Jq+nJjCtUfmsMBCgNTXbwvqY4Gt3+meRIVaKm5OiwnG2+XhezGn
         15vK/bG82LdWRR2CCQbuImgrbBwkXcXHROOa+he4ZIH944XGveontqahgE+lmKX61azb
         cgGwtr+7TZhOjl/67qnhlIItNmjd4f2MxemxLUK+yItzvbfGS/ID51nularJ2zC/s02z
         MLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6uVxpmjtJrh49bROR/GEwsOKP2TcklwbBBYVDi6akw=;
        b=Wj9KnS3QKKMe9ATPOWK+gv8H0edys31i7gQ2HOHLu9zJq6OUGzmKiCX54FhGWGtqfa
         2KnxL4xHtCjH2RV94n5KafNGVIhIr6oVnRYjxIEpIeNw6jycFcAm3G1wNSAv0ErPJE5y
         UQzdaO10o8b7M0L8wpND6qOYe6/+GlK7MKF+fO+sM62Fsn9CZCDOe4I75i4QEyg6ZFxA
         m7K1Rq2Cn+ZEL2RMctM9y+1OB/8OhJ9Fel5ihE7Wc1MS/AxrdPXyXkyzdd8E/jTLnJmd
         OSj1/oq2AwC3H60+1AU4cGjQSnWbawty+J0fgtAp3BpLHddznoadU7qpjyGxZQ14VSH8
         +KeA==
X-Gm-Message-State: AOAM533X8j9DgzTxGasJIERwKGN8kCZBuvzE1e3bVkchX+lnCH1saCN7
        q5VnzIZfw+RkvyFtoIW/R4FOsaJqA05lwG0Pphb6NA==
X-Google-Smtp-Source: ABdhPJzTU07eK90u56ieNkfWEiPbP/yb2qqk/uvaOdJWRiNqHdKO0nVyVmzZ2bxLFNkDl7vPDYck14pkaFJl67yPxyY=
X-Received: by 2002:a05:620a:15c9:: with SMTP id o9mr17316392qkm.8.1597845824618;
 Wed, 19 Aug 2020 07:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000568fc005ad3b57c3@google.com>
In-Reply-To: <000000000000568fc005ad3b57c3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Aug 2020 16:03:33 +0200
Message-ID: <CACT4Y+bxvHp9gq_OEBAYdMTsm9vxw3CuviuDpxHCXcZHv_A0nw@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (4)
To:     syzbot <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 3:54 PM syzbot
<syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1710d97a900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> dashboard link: https://syzkaller.appspot.com/bug?extid=df400f2f24a1677cd7e0
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15859986900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1228fea1900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com
>
> unregister_netdevice: waiting for lo to become free. Usage count = 1

Based on the repro, it looks bpf/bpf link related:

syz_emit_ethernet(0x86, &(0x7f0000000000)={@local, @empty=[0x2],
@void, {@ipv4={0x800, @udp={{0x5, 0x4, 0x0, 0x0, 0x78, 0x0, 0x0, 0x0,
0x11, 0x0, @empty, @empty}, {0x0, 0x1b59, 0x64, 0x0,
@wg=@response={0x5, 0x0, 0x0, "020000010865390406030500000000010900",
"9384bbeb3018ad591b661fe808b21b77",
{"694c875dfb1be5d2a0057a62022a1564",
"a329d3a73b8268129e5fa4316a5d8c69"}}}}}}}, 0x0)
mkdirat(0xffffffffffffff9c, &(0x7f0000000000)='./file0\x00', 0x0)
mount(0x0, &(0x7f0000000080)='./file0\x00',
&(0x7f0000000040)='cgroup2\x00', 0x0, 0x0)
r0 = openat$cgroup_root(0xffffffffffffff9c, &(0x7f0000000000), 0x200002, 0x0)
r1 = bpf$PROG_LOAD(0x5, &(0x7f0000000080)={0x9, 0x4,
&(0x7f0000000000)=@framed={{}, [@alu={0x8000000201a7f19, 0x0, 0x6,
0x2, 0x1}]}, &(0x7f0000000100)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, [],
0x0, 0x0, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x70)
bpf$BPF_LINK_CREATE(0x1c, &(0x7f0000000100)={r1, r0, 0x2}, 0x10)

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
