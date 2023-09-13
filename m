Return-Path: <bpf+bounces-9877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA379E263
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB901C20EA0
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D0179BD;
	Wed, 13 Sep 2023 08:41:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0028F0
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:41:54 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D4E73
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:41:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41667e0d3ecso27621cf.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694594513; x=1695199313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vYkKTZQhnheseFWELcIvsSRa/uxYdJJ6yMzg5vRWAE=;
        b=2vd0F4oCuk+DtBaN+uD00WDYr86iAhXwNjty5dr+KL/jDtYw8hi8udgjC5U9Vj+JA8
         qWKGDho+DBBf5r7h3QO/zhtbwV8zISA78O+5nHCrDSg6PKjL705FL4QoUQFGeCDXmyIk
         STDMq7ABkePe1yLLgIC9YHSX7hs6xZaiG2NEWSuPzvIkzB1MvQy6r6MQ+/GbMX4zAoQ1
         5dMzADNE6EWzuK5FWGZb6+AJFSn1Q5Q9M5fEcfiPYb6tnc0hnUK3IUuLOzSwJtdHRznE
         WB2FlViAcWiBYC59LKeiAmoSubwubdrF/oUk50tcOx7UDe9nziXf6U2nd8Cc9JqF4KFW
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594513; x=1695199313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vYkKTZQhnheseFWELcIvsSRa/uxYdJJ6yMzg5vRWAE=;
        b=v8y7dM5vdbehf1Jxwu2d3LblJiGGg1QxKaTtEk4XGwcVNiJT4J3+iiIWCyvql73Unl
         1pkCbPPDyqb8PaSrNEbxrld6mqKWcWxzjx7ENCRR1Lx2tz1HFb32ChyJgxWuNXujsOH8
         12YbHWdKNRr9AP9h20zdr47cusI7I/oofsTVernCR25MWVFnjdgOX8vquHqKswmqoIl8
         Mi/gnMRcXNTBYSAqgqAVXsZ6elcAVqad+WU7ToLhFNTdx4gpCc2MNoqOg5qDfmyK6DD/
         C231s1z+6U+NfJxgx3wLVioqzuju7Hhzz9SLXoMHc+3n8h6U3t+5RE9+BMBDzS+BC4It
         l6Gw==
X-Gm-Message-State: AOJu0YwULZiu746eMMlqfNQUH5lEpC48ot35K4eysnq6+MSIC4P1X48h
	qb0EB+sFYr7Xnzwp9UzcoiVGzzlanUA32U83G21zuw==
X-Google-Smtp-Source: AGHT+IEPvPoP/N4UVak/L9vq8/rjuLTHtSXPO7S3/p/Eobnv657JE1/x30F6I/MdThy/U3lOsYs1DTPdAcl+Npdj0bo=
X-Received: by 2002:a05:622a:547:b0:3f6:97b4:1a4d with SMTP id
 m7-20020a05622a054700b003f697b41a4dmr150643qtx.23.1694594512584; Wed, 13 Sep
 2023 01:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000001c12b30605378ce8@google.com>
In-Reply-To: <0000000000001c12b30605378ce8@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Sep 2023 10:41:41 +0200
Message-ID: <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
To: syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>, 
	David Howells <dhowells@redhat.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 8:19=E2=80=AFAM syzbot
<syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git=
...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D142177f468000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db273cdfbc13e9=
a4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D62cbf263225ae13=
ff153
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11f37a0c680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10034f3fa8000=
0
>

CC David

Warning added in

commit ce650a1663354a6cad7145e7f5131008458b39d4
Author: David Howells <dhowells@redhat.com>
Date:   Wed Aug 2 08:36:50 2023 +0100

    udp6: Fix __ip6_append_data()'s handling of MSG_SPLICE_PAGES


> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/74df7181e630/dis=
k-65d6e954.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8455d5988dfe/vmlinu=
x-65d6e954.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8ee7b79f0dfd/b=
zImage-65d6e954.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_data=
.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
> Modules linked in:
> CPU: 1 PID: 5042 Comm: syz-executor133 Not tainted 6.5.0-syzkaller-11938-=
g65d6e954e378 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/26/2023
> RIP: 0010:__ip6_append_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:18=
00
> Code: db f6 ff ff e8 09 d5 97 f8 49 8d 44 24 ff 48 89 44 24 60 49 8d 6c 2=
4 07 e9 c2 f6 ff ff 4c 8b b4 24 90 01 00 00 e8 e8 d4 97 f8 <0f> 0b 48 8b 44=
 24 10 45 89 f4 48 8d 98 74 02 00 00 e8 d2 d4 97 f8
> RSP: 0018:ffffc90003a1f3b8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000001004 RCX: 0000000000000000
> RDX: ffff88801fe70000 RSI: ffffffff88efcf18 RDI: 0000000000000006
> RBP: 0000000000001000 R08: 0000000000000006 R09: 0000000000001004
> R10: 0000000000001000 R11: 0000000000000000 R12: 0000000000000001
> R13: dffffc0000000000 R14: 0000000000001004 R15: ffff888019f31000
> FS:  0000555557280380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045ad50 CR3: 0000000072666000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip6_append_data+0x1e6/0x510 net/ipv6/ip6_output.c:1895
>  l2tp_ip6_sendmsg+0xdf9/0x1cc0 net/l2tp/l2tp_ip6.c:631
>  inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:840
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg+0xd9/0x180 net/socket.c:753
>  splice_to_socket+0xade/0x1010 fs/splice.c:881
>  do_splice_from fs/splice.c:933 [inline]
>  direct_splice_actor+0x118/0x180 fs/splice.c:1142
>  splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
>  do_splice_direct+0x1af/0x280 fs/splice.c:1194
>  do_sendfile+0xb88/0x1390 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1308 [inline]
>  __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6b11150469
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffd14e71a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fffd14e7378 RCX: 00007f6b11150469
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
> RBP: 00007f6b111c3610 R08: 00007fffd14e7378 R09: 00007fffd14e7378
> R10: 000000010000a006 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fffd14e7368 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
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

