Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E824C455
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgHTRPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgHTRPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 13:15:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B858BC061386
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 10:15:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so1723479qtn.9
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=424up9fRXsuplUqex8JuKJ4P67ivI7g/11qg3X2brrU=;
        b=JmjpW6tpJxpmlmER/V+lEb7+vVPrpClcfvWoeMKntJNV5zlykvfG8b7O71gh1eN+fv
         G5Y9NdDehL3kLIhehElg/dP5K4FuQL9G8vxrUSz9pM2CG2VF1/IcKqMtA/FC+ET5ktWc
         lijIlMoeqfAsxiXjbaqDyQRyk50axCMAd8cRBCkF9zTM7BbrTrJJUkiSDV7u+/wWfWD6
         4qzeGQWv7VjDx7F25x4KvbF8zeNIa/JrsBJgVy8V0dMgeBic7a/z+Lj78KfPcBT3byCr
         OzhJE3D4NNwxzRrXapKNmrKzc4AtbCadPQuwMzYo/iDOZZQjVcHhT4bpMmXf/cQYCVyT
         1i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=424up9fRXsuplUqex8JuKJ4P67ivI7g/11qg3X2brrU=;
        b=sLE6g5Wkb7RLXwxWsWZbmZBJmmZB9R5dpNcoKtXLMiIsEWoe1aEbQkgdT5n5CvIJhT
         p3FwKKT7BIfhobcXtVsqBSoyJTTaXebwOA0TcGu2h+NlMFO6P6qvc4+IlwYLJxsPFfW/
         SF637se68E8VeCRJu2vvFyfcW5gNycNFCpIwUzbuXwueMtvUFnz7zVb1Oy2Cl5LeMTcW
         e2f6h580CtyzAl5FvyxYHjep8WnlUCW5YwDfyY10NMWgLT+ZmFYA1COvd1RDY45bWRon
         sTe9yRwkf+Y7LrumDRhzfO63Ps5Bwwxb4ZOjthJAEAmfchQMHojvnYYU9kc6gD5btYQD
         XCGQ==
X-Gm-Message-State: AOAM531Qg6plj35ogUfymkDvl81knoKmtiy9ML8WZvNBgiRm2RZEOUP8
        jy7UpJqz5jgs/oES6IZiZthvc7Ca4+YhWEMqXppekw==
X-Google-Smtp-Source: ABdhPJzYoJN1dKfspxwMxJB4tZMPYOymu0BBSs/+T5H0coi/llS74fnfsvlE1ZRo/WWhYpivmjqX0Il2hYKtx6/uPBY=
X-Received: by 2002:ac8:7609:: with SMTP id t9mr3599622qtq.158.1597943727622;
 Thu, 20 Aug 2020 10:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000568fc005ad3b57c3@google.com> <CACT4Y+bxvHp9gq_OEBAYdMTsm9vxw3CuviuDpxHCXcZHv_A0nw@mail.gmail.com>
 <CAEf4BzYHJgAtO2+6R70MYKQmXjiGy8OVgojNpvEPJ+FQb_DnKg@mail.gmail.com>
In-Reply-To: <CAEf4BzYHJgAtO2+6R70MYKQmXjiGy8OVgojNpvEPJ+FQb_DnKg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Aug 2020 19:15:16 +0200
Message-ID: <CACT4Y+aYWgq853nPn3EoW4A0TU9pTJb+vwWHwTiguYy_T3K5rw@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (4)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     syzbot <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 7:07 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > On Wed, Aug 19, 2020 at 3:54 PM syzbot
> > <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1710d97a900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=df400f2f24a1677cd7e0
> > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15859986900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1228fea1900000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com
> > >
> > > unregister_netdevice: waiting for lo to become free. Usage count = 1
> >
> > Based on the repro, it looks bpf/bpf link related:
> >
> > syz_emit_ethernet(0x86, &(0x7f0000000000)={@local, @empty=[0x2],
> > @void, {@ipv4={0x800, @udp={{0x5, 0x4, 0x0, 0x0, 0x78, 0x0, 0x0, 0x0,
> > 0x11, 0x0, @empty, @empty}, {0x0, 0x1b59, 0x64, 0x0,
> > @wg=@response={0x5, 0x0, 0x0, "020000010865390406030500000000010900",
> > "9384bbeb3018ad591b661fe808b21b77",
> > {"694c875dfb1be5d2a0057a62022a1564",
> > "a329d3a73b8268129e5fa4316a5d8c69"}}}}}}}, 0x0)
> > mkdirat(0xffffffffffffff9c, &(0x7f0000000000)='./file0\x00', 0x0)
> > mount(0x0, &(0x7f0000000080)='./file0\x00',
> > &(0x7f0000000040)='cgroup2\x00', 0x0, 0x0)
> > r0 = openat$cgroup_root(0xffffffffffffff9c, &(0x7f0000000000), 0x200002, 0x0)
> > r1 = bpf$PROG_LOAD(0x5, &(0x7f0000000080)={0x9, 0x4,
> > &(0x7f0000000000)=@framed={{}, [@alu={0x8000000201a7f19, 0x0, 0x6,
> > 0x2, 0x1}]}, &(0x7f0000000100)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, [],
> > 0x0, 0x0, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x70)
> > bpf$BPF_LINK_CREATE(0x1c, &(0x7f0000000100)={r1, r0, 0x2}, 0x10)
> >
>
> The only place where BPF link-related code is bumping refcount for
> net_device is in bpf_xdp_link_attach(), but both success and failure
> code paths always do dev_put() in the end. bpf_link itself has a
> pointer on net_device, but it's protected by rtnl_lock() only, no
> refcnt associated with it. So I don't see how bpf_link can cause this.
> I also couldn't reproduce this locally, using the provided C
> reproducer.

I was able to reproduce this in qemu the first time.
