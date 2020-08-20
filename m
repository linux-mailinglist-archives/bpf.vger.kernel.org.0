Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379FF24C427
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgHTRJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgHTRIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 13:08:15 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA78C061387;
        Thu, 20 Aug 2020 10:07:11 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id m200so1489233ybf.10;
        Thu, 20 Aug 2020 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glbSY9AfO3c8Ilt34Mm40yHeC6Eq+qmYUQCGg5s1K0U=;
        b=G40t2fYW0FhXMcs05aomQTRQxrdlOpkX/PnxGcUCLWyKhms/BoNlmCrutAjwhgn3gW
         kr6hbH7rHVs77A+tTAmg5+CfvNiTNs+2ZXOHPCAYMXybwieTG7aFMImHSW5rgfcOjtzt
         mWMtIZBvvy346pwDG2jYbKAKbXr5z0AuQGYagW8fOYtnkG9ymeh6Cyek+XgM8BH8hGkz
         ko7pWuBxDlR4c8L299wc4COwVSVc8KE4HIlR5vzvV0f2UxO/VvpAeHiMmpPzfYMuZI+0
         er1AUffqw/sjoKcBRhgQbk/rlui05AToJrRrgel0WfvCJxmCtvt+aavfjXNXEGhSwK3A
         RkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glbSY9AfO3c8Ilt34Mm40yHeC6Eq+qmYUQCGg5s1K0U=;
        b=MLHoFEaqUHzmdUGwRWYQnJ5gfq/h0ArUO1fvPHN8Ln5AMxXAfJeUQouERqPHXPtnhr
         HX7CwkJJ79LbvriCy06lf9n2O86MDtm8bdilGGU8UjSN1eo6ZHqBRbWvRy+aB1oRqpDQ
         3AyEVNRU8798aHTQ+ZQcCnx1qlR8TSbOPHxHdBY6nlPUJgxXsom6SezMURts6ldrIIWr
         +Z1AgjJ7Td+IHUm+CdxtDhmnwtgcV0Wi7ZH+ayse9JQB4bvxxniU6NhJBmXUBWh2TErB
         Ti1rbAMsaPQaKPFyxVgbtklVhcgwlnGXpz3BmCh0D7uS8lZb6+o0SwbK5D9D2LVV3XEb
         pkOQ==
X-Gm-Message-State: AOAM533EYimiw6LAXNz7/k2SQkNrIlhABJDClymqF+iG3/9ivGItiC9a
        stQGhsTlF+W02jhKNcf9+uvfaWuK5ZjnVB4qK/k=
X-Google-Smtp-Source: ABdhPJxVweS8wTcW+9Gn3U434vsgVIpBXkGRmzYW1MOeLGuvJQyj3w61ppDG3Iinwf6rEdXgfkSObizgTjEYOLgziAI=
X-Received: by 2002:a25:84cd:: with SMTP id x13mr5973103ybm.425.1597943231062;
 Thu, 20 Aug 2020 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000568fc005ad3b57c3@google.com> <CACT4Y+bxvHp9gq_OEBAYdMTsm9vxw3CuviuDpxHCXcZHv_A0nw@mail.gmail.com>
In-Reply-To: <CACT4Y+bxvHp9gq_OEBAYdMTsm9vxw3CuviuDpxHCXcZHv_A0nw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Aug 2020 10:07:00 -0700
Message-ID: <CAEf4BzYHJgAtO2+6R70MYKQmXjiGy8OVgojNpvEPJ+FQb_DnKg@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (4)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 7:06 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Aug 19, 2020 at 3:54 PM syzbot
> <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1710d97a900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=df400f2f24a1677cd7e0
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15859986900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1228fea1900000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com
> >
> > unregister_netdevice: waiting for lo to become free. Usage count = 1
>
> Based on the repro, it looks bpf/bpf link related:
>
> syz_emit_ethernet(0x86, &(0x7f0000000000)={@local, @empty=[0x2],
> @void, {@ipv4={0x800, @udp={{0x5, 0x4, 0x0, 0x0, 0x78, 0x0, 0x0, 0x0,
> 0x11, 0x0, @empty, @empty}, {0x0, 0x1b59, 0x64, 0x0,
> @wg=@response={0x5, 0x0, 0x0, "020000010865390406030500000000010900",
> "9384bbeb3018ad591b661fe808b21b77",
> {"694c875dfb1be5d2a0057a62022a1564",
> "a329d3a73b8268129e5fa4316a5d8c69"}}}}}}}, 0x0)
> mkdirat(0xffffffffffffff9c, &(0x7f0000000000)='./file0\x00', 0x0)
> mount(0x0, &(0x7f0000000080)='./file0\x00',
> &(0x7f0000000040)='cgroup2\x00', 0x0, 0x0)
> r0 = openat$cgroup_root(0xffffffffffffff9c, &(0x7f0000000000), 0x200002, 0x0)
> r1 = bpf$PROG_LOAD(0x5, &(0x7f0000000080)={0x9, 0x4,
> &(0x7f0000000000)=@framed={{}, [@alu={0x8000000201a7f19, 0x0, 0x6,
> 0x2, 0x1}]}, &(0x7f0000000100)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, [],
> 0x0, 0x0, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x70)
> bpf$BPF_LINK_CREATE(0x1c, &(0x7f0000000100)={r1, r0, 0x2}, 0x10)
>

The only place where BPF link-related code is bumping refcount for
net_device is in bpf_xdp_link_attach(), but both success and failure
code paths always do dev_put() in the end. bpf_link itself has a
pointer on net_device, but it's protected by rtnl_lock() only, no
refcnt associated with it. So I don't see how bpf_link can cause this.
I also couldn't reproduce this locally, using the provided C
reproducer.

> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
