Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3312A0E87
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 20:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgJ3TW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgJ3TVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 15:21:54 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC35C0613D8
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:21:54 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id u202so1694192vkb.4
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I5vCt7sQpLxqO9fFZglUpeymmnJZb+1HjzCHkxiFnI=;
        b=SuJtxiwkoB6tT6rUkiqexK55I2Znto0HzbzoxVsqOK/P6c9gFQuP6oaZkgRXt529ZU
         a+bJWmyqi0+flho90rhtlkwHEs/7it0kmTdVLD/LJTnan7DMQe7EUfH5HwKopELvdr6c
         zUX1a7CTPjVwz/VH/TBiLoorR+ZXggEpvShSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I5vCt7sQpLxqO9fFZglUpeymmnJZb+1HjzCHkxiFnI=;
        b=ktuKjKULBlYbJI0p3lH+AnmcJ01s/nZpthDR0OuurRw39t2+7LXIBY+RyK0eJCTKpQ
         JnmHGbQ9E1lIVgfbhtrKZNN9tO2s0uu9mW55kblkcsu+D8w4wYHbToMmQJe8MCW8RCTN
         RbjioMampoCEkbcpsCwjt23UuK9lw0xNqe76X2FVsJalI6LAJXdXcUfowrj0GiN18dZw
         tZ2wybJ1ovsyEQE68GkKASPCmSsbC0BjhIiQS0cLyvB52mDs/a7OR/2JD2e4a1SqwIrP
         AkI9pHnR8hJ7lWhTS6UqfrCZ58t4m32y9rCXhCRFXUHzeZ3efeCFkSzV7h0TTTNz9Pe0
         fOng==
X-Gm-Message-State: AOAM532+orIehXGmSsKBeWQd/i5EWjeU8rmzPEhnEzM4GIpZR7fbC09b
        vswCbXODcXBXIXCwREt6IBfZjKrz6722Prt8r2XjtQ==
X-Google-Smtp-Source: ABdhPJxhGLBaazY1X0XxdFRD1fbdQdiuFWbQMhMjddSkpPS+9nVoe7eHxNfL0vqo7pYecWi6tpSi1Itb0ThaHuhtKN4=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr8477163vkj.11.1604085713313;
 Fri, 30 Oct 2020 12:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008caae305ab9a5318@google.com> <000000000000a726a405ada4b6cf@google.com>
 <CAFqZXNvQcjp201ahjLBhYJJCuYqZrYLGDA-wE3hXiJpRNgbTKg@mail.gmail.com>
 <CAJfpegtzQB09ind8tkYzaiu6ODJvhMKj3myxVS75vbjTcOxU8g@mail.gmail.com> <CACT4Y+Yyxdju4FR-E3bc5ERM6xhecnos6mkJR5==xS+RS_DUuw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yyxdju4FR-E3bc5ERM6xhecnos6mkJR5==xS+RS_DUuw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 20:21:42 +0100
Message-ID: <CAJfpegsAabASuHYtoi_DoooV1vM7Evfrd8ESZDDTx2oXHiR6cw@mail.gmail.com>
Subject: Re: general protection fault in security_inode_getattr
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 7:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 2:02 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Aug 24, 2020 at 11:00 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Mon, Aug 24, 2020 at 9:37 PM syzbot
> > > <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com> wrote:
> > > > syzbot has found a reproducer for the following issue on:
> > >
> > > Looping in fsdevel and OverlayFS maintainers, as this seems to be
> > > FS/OverlayFS related...
> >
> > Hmm, the oopsing code is always something like:
> >
> > All code
> > ========
> >    0: 1b fe                sbb    %esi,%edi
> >    2: 49 8d 5e 08          lea    0x8(%r14),%rbx
> >    6: 48 89 d8              mov    %rbx,%rax
> >    9: 48 c1 e8 03          shr    $0x3,%rax
> >    d: 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1)
> >   12: 74 08                je     0x1c
> >   14: 48 89 df              mov    %rbx,%rdi
> >   17: e8 bc b4 5b fe        callq  0xfffffffffe5bb4d8
> >   1c: 48 8b 1b              mov    (%rbx),%rbx
> >   1f: 48 83 c3 68          add    $0x68,%rbx
> >   23: 48 89 d8              mov    %rbx,%rax
> >   26: 48 c1 e8 03          shr    $0x3,%rax
> >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
> >   2f: 74 08                je     0x39
> >   31: 48 89 df              mov    %rbx,%rdi
> >   34: e8 9f b4 5b fe        callq  0xfffffffffe5bb4d8
> >   39: 48 8b 1b              mov    (%rbx),%rbx
> >   3c: 48 83 c3 0c          add    $0xc,%rbx
> >
> >
> > And that looks (to me) like the unrolled loop in call_int_hook().  I
> > don't see how that could be related to overlayfs, though it's
> > definitely interesting why it only triggers from
> > overlay->vfs_getattr()->security_inode_getattr()...
>
>
> >   26: 48 c1 e8 03          shr    $0x3,%rax
> >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
>
>
> This access is part of KASAN check. But the original address kernel
> tries to access is NULL, so it's not an issue with KASAN.
>
> The line is this:
>
> int security_inode_getattr(const struct path *path)
> {
>     if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
>         return 0;
>
> So it's either path is NULL, or something in d_backing_inode
> dereferences NULL path->dentry.
>
> The reproducer does involve overlayfs:
>
> mkdir(&(0x7f0000000240)='./file1\x00', 0x0)
> mkdir(&(0x7f0000000300)='./bus\x00', 0x0)
> r0 = creat(&(0x7f00000000c0)='./bus/file1\x00', 0x0)
> mkdir(&(0x7f0000000080)='./file0\x00', 0x0)
> mount$overlay(0x400002, &(0x7f0000000000)='./bus\x00',
> &(0x7f0000000100)='overlay\x00', 0x0,
> &(0x7f00000003c0)=ANY=[@ANYBLOB='upperdir=./file1,lowerdir=./bus,workdir=./file0,metacopy=on'])
> link(&(0x7f0000000200)='./bus/file1\x00', &(0x7f00000002c0)='./bus/file0\x00')
> write$RDMA_USER_CM_CMD_RESOLVE_ADDR(r0, 0x0, 0x0)
> acct(&(0x7f0000000040)='./bus/file0\x00')
>
> Though, it may be overlayfs-related, or it may be a generic bug that
> requires a tricky reproducer and the only reproducer syzbot come up
> with happened to involve overlayfs.
> But there are 4 reproducers on syzbot dashboard and all of them
> involve overlayfs and they are somewhat different. So my bet would be
> on overlayfs.

Seems there's no C reproducer, though.   Can this be reproduced
without KASAN obfuscating the oops?

Thanks,
Miklos
