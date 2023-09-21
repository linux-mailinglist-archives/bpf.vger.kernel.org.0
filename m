Return-Path: <bpf+bounces-10524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1FD7A9639
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839CBB20B59
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231DBE76;
	Thu, 21 Sep 2023 17:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1CBE61
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:00:34 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE81721
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:59:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-414ba610766so14281cf.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315579; x=1695920379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naoJVF9HbMRZX+B7dXjdrn6QCO6e9BTPcTRn9BmRVQo=;
        b=AnxvlAqmL4olb4unt6D9woHHeBL0bIMbR0w619vsXWUQzBTqNZ0V07RSu0SCx7DjF/
         GRusEyXqRkU8WfJABjCSyT1HLDlzR0RrT4MvK6daBvclhOZK7pfURT0Mcq+Oa+eFQxa5
         feYCIHdj+mSPu44sHf5oCTdB24zXQAD+Bnces3M33rYdp5qkD15pCjPbj4+NYOamjk0P
         OPD7sccLv8JivCPXPOXE9GpbjxhjPOtW9lg0893u/SWj4BMlyaU7oeMznPghEY9fa6sU
         vO+esg7/0aosh1nFd3B8UH8C2cKbGt0w/WWO3D8DLW69MliSbPmE9oNqptxkIlH9/H3Z
         hfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315579; x=1695920379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naoJVF9HbMRZX+B7dXjdrn6QCO6e9BTPcTRn9BmRVQo=;
        b=Bx9jp2Uu7e1CdEfpT1Wdxqiiia1eehbgONg+JfUQOSGwe9Qae5BfUXy0ePn1b1R8cs
         bk0BMVSMfp4t5I5nOYE8hrP7HL7hBf9C6Vy8koaJLxGJ9VLEMQpAnfVF9KhEhJwhzNvD
         YgCn6vn7TBEpDCZFu6gUpJS2IhgN2LBLdXOgZzTSjyu2fDmFTDU1Hofc6x62VB18vNyT
         p8zqbAwuuLUCT5DRCZkQ06YTeOMPHPqO9a5+ZoC06ReW7/pE3XGmUXKj8LwarylWZtvF
         K9eZ+sm+Gedht915tRYdlcywhG8EhN8G3RcfuwKui2JdkRFSoEp79qfQqbwP9LZUfxJa
         tD5w==
X-Gm-Message-State: AOJu0YzPOw9pBP+vhf/YxLzy7xZFRJKTmwtESqpYG1cOc55Ekfi6zbQY
	5YXQ/pZ2HYpnS+ENPQgBrB/hc3CgT4jLnn8s+8nV0g==
X-Google-Smtp-Source: AGHT+IEocgCFfss9NjDKifXqo58yzByIGTIgDGjthrt/xt8ZRoOEl9+u4+8EWbujjTPiefCZJnv9frIfvIcjNiHIrmk=
X-Received: by 2002:ac8:4e53:0:b0:403:b1d0:2f0a with SMTP id
 e19-20020ac84e53000000b00403b1d02f0amr288293qtw.28.1695315579116; Thu, 21 Sep
 2023 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004d83170605e16003@google.com>
In-Reply-To: <0000000000004d83170605e16003@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 18:59:27 +0200
Message-ID: <CANn89iJwQ3TCSm+SMs=W90oThgRMLoiSAcTBJ9LH2AVsJY1NBA@mail.gmail.com>
Subject: Re: [syzbot] [net?] memory leak in tcp_md5_do_add
To: syzbot <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>, 
	Dmitry Safonov <dima@arista.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 6:56=E2=80=AFPM syzbot
<syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.o=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1312bba8c8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5733ca175717=
2ad
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D68662811b3d5f66=
95bcb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D105393a8c80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1113917f48000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711/dis=
k-ee3f96b1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vmlinu=
x-ee3f96b1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425ad6/b=
zImage-ee3f96b1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com
>
> executing program
> BUG: memory leak
> unreferenced object 0xffff88810a86f7a0 (size 32):
>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1061
>     [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
>     [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169 [in=
line]
>     [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.c:12=
40
>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_i=
pv6.c:671
>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:37=
20
>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88811225ccc0 (size 192):
>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
>     22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
>   backtrace:
>     [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inline]
>     [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
>     [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
>     [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
>     [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
>     [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv4.c:=
1212
>     [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.c:12=
53
>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_i=
pv6.c:671
>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:37=
20
>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Dmitry, please take a look at this bug, we need to fix it before your
patch series.

Thank you.

