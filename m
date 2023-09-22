Return-Path: <bpf+bounces-10650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27C7AB66C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DCD18282101
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112F41E25;
	Fri, 22 Sep 2023 16:46:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C63CD0D;
	Fri, 22 Sep 2023 16:46:45 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626EF1;
	Fri, 22 Sep 2023 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695401204; x=1726937204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT1d4LkDFWmE0sBuTMdCMOZNisLqYmvSr9uOgV4mpuY=;
  b=P97uIQNbw5dk7JMmkCxzAzJ2jk9fOPJfqOmcOEsyVisQCQkKkJp851a3
   lRXWqy/ulM7N/2YHjBPk5ttKRnVUDF84Jdv4VUkBTvkUW/v/VaYOha6rM
   R39qIPE8QXOp/6qcLC6E+vsscoDWkyHgsM26DEpEoe08o+CrLx6QJZGoK
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,167,1694736000"; 
   d="scan'208";a="360139984"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 16:46:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id E40DF103FA7;
	Fri, 22 Sep 2023 16:46:37 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 16:46:37 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.169.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 16:46:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <bpf@vger.kernel.org>, <catalin.marinas@arm.com>, <davem@davemloft.net>,
	<dima@arista.com>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] memory leak in tcp_md5_do_add
Date: Fri, 22 Sep 2023 09:46:26 -0700
Message-ID: <20230922164626.34472-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+EUqRK9RsXn7Gu4iFiBcEZUzkMLmZ9vogFYxBbmaBHkQ@mail.gmail.com>
References: <CANn89i+EUqRK9RsXn7Gu4iFiBcEZUzkMLmZ9vogFYxBbmaBHkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.169.132]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Sep 2023 05:20:34 +0200
> On Fri, Sep 22, 2023 at 1:15 AM Dmitry Safonov <dima@arista.com> wrote:
> >
> > Hi Eric,
> >
> > On 9/21/23 18:01, Dmitry Safonov wrote:
> > > On 9/21/23 17:59, Eric Dumazet wrote:
> > >> On Thu, Sep 21, 2023 at 6:56 PM syzbot
> > >> <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com> wrote:
> > >>>
> > >>> Hello,
> > >>>
> > >>> syzbot found the following issue on:
> > >>>
> > >>> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
> > >>> git tree:       upstream
> > >>> console output: https://syzkaller.appspot.com/x/log.txt?x=1312bba8c80000
> > >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
> > >>> dashboard link: https://syzkaller.appspot.com/bug?extid=68662811b3d5f6695bcb
> > >>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105393a8c80000
> > >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113917f480000
> > >>>
> > >>> Downloadable assets:
> > >>> disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711/disk-ee3f96b1.raw.xz
> > >>> vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vmlinux-ee3f96b1.xz
> > >>> kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425ad6/bzImage-ee3f96b1.xz
> > >>>
> > >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >>> Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com
> > >>>
> > >>> executing program
> > >>> BUG: memory leak
> > >>> unreferenced object 0xffff88810a86f7a0 (size 32):
> > >>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
> > >>>   hex dump (first 32 bytes):
> > >>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>>   backtrace:
> > >>>     [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1061
> > >>>     [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
> > >>>     [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169 [inline]
> > >>>     [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.c:1240
> > >>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
> > >>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
> > >>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
> > >>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
> > >>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
> > >>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
> > >>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
> > >>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >>>
> > >>> BUG: memory leak
> > >>> unreferenced object 0xffff88811225ccc0 (size 192):
> > >>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
> > >>>   hex dump (first 32 bytes):
> > >>>     00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
> > >>>     22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
> > >>>   backtrace:
> > >>>     [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inline]
> > >>>     [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
> > >>>     [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
> > >>>     [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
> > >>>     [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
> > >>>     [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv4.c:1212
> > >>>     [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.c:1253
> > >>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
> > >>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
> > >>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
> > >>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
> > >>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
> > >>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
> > >>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
> > >>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >>>
> > >>>
> > >>>
> > >>> ---
> > >>> This report is generated by a bot. It may contain errors.
> > >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> > >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >>>
> > >>> syzbot will keep track of this issue. See:
> > >>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >>>
> > >>> If the bug is already fixed, let syzbot know by replying with:
> > >>> #syz fix: exact-commit-title
> > >>>
> > >>> If you want syzbot to run the reproducer, reply with:
> > >>> #syz test: git://repo/address.git branch-or-commit-hash
> > >>> If you attach or paste a git patch, syzbot will apply it before testing.
> > >>>
> > >>> If you want to overwrite bug's subsystems, reply with:
> > >>> #syz set subsystems: new-subsystem
> > >>> (See the list of subsystem names on the web dashboard)
> > >>>
> > >>> If the bug is a duplicate of another bug, reply with:
> > >>> #syz dup: exact-subject-of-another-report
> > >>>
> > >>> If you want to undo deduplication, reply with:
> > >>> #syz undup
> > >>
> > >> Dmitry, please take a look at this bug, we need to fix it before your
> > >> patch series.
> > >
> > > Sure, seems reasonable to me to fix before merging something on top.
> >
> > It seems to me that it's related to a race between RCU grace period and
> > kmemleak scan period. There seems to be a patch [1] that likely fixes
> > that, albeit I couldn't verify it as all my attempts to reproduce syzbot
> > issue produced only unrelated to TCP-MD5 log:
> >
> 
> I doubt this, looking at the repro, which seems to abuse a not often
> used feature of TCP (self connect)
> 
> # https://syzkaller.appspot.com/bug?id=323165b5fe193114de7a3a6a8bd16cf3a3c36ecf
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"repeat":true,"procs":1,"slowdown":1,"sandbox":"none","sandbox_arg":0,"leak":true,"netdev":true,"close_fds":true,"usb":true}
> r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
> setsockopt$inet6_tcp_TCP_MD5SIG(r0, 0x6, 0xe,
> &(0x7f0000000040)={@in6={{0xa, 0x0, 0x0, @local}}, 0x0, 0x0, 0x22,
> 0x0, "b05423587c18814d6b1a5f25671d09815a4687d637ffc958defc671aad3d4de8ac7d88560c759d600ab650c07ef0ef162b199da0d017fe6f0ae40cfb4e241cf9a990f20f6b8c2c070a61cfad8a2d2600"},
> 0xd8)
> connect$inet6(r0, &(0x7f0000000180)={0xa, 0x4001, 0x0, @ipv4={'\x00',
> '\xff\xff', @remote}}, 0x1c)
> dup(0xffffffffffffffff)
> setsockopt$SO_BINDTODEVICE(r0, 0x1, 0x19,
> &(0x7f00000001c0)='ip6_vti0\x00', 0xff4a)

FWIW, I had the same report and another report for twsk and MD5.
syzkaller did not find repro though.

---8<---
BUG: memory leak
unreferenced object 0xffff888038513480 (size 192):
  comm "syz-executor.0", pid 36537, jiffies 4295853096 (age 63.376s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 3e fc 43 80 88 ff ff  .........>.C....
    06 02 20 00 ac 14 14 aa 00 00 00 00 00 00 00 00  .. .............
  backtrace:
    [<0000000003e890c3>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<0000000003e890c3>] __kmalloc_node_track_caller+0x4b/0x130 mm/slab_common.c:1005
    [<0000000026777435>] kmemdup+0x2c/0x60 mm/util.c:131
    [<000000000318308e>] kmemdup include/linux/fortify-string.h:765 [inline]
    [<000000000318308e>] tcp_time_wait_init net/ipv4/tcp_minisocks.c:261 [inline]
    [<000000000318308e>] tcp_time_wait+0x25c/0x3b0 net/ipv4/tcp_minisocks.c:318
    [<00000000bb86ba54>] tcp_rcv_state_process+0xb36/0x1990 net/ipv4/tcp_input.c:6668
    [<00000000a26563d5>] tcp_v4_do_rcv+0x18b/0x4a0 net/ipv4/tcp_ipv4.c:1751
    [<00000000b158e1f0>] sk_backlog_rcv include/net/sock.h:1115 [inline]
    [<00000000b158e1f0>] __release_sock+0x177/0x1a0 net/core/sock.c:2982
    [<000000000e8687d8>] __tcp_close+0x252/0x630 net/ipv4/tcp.c:2846
    [<000000006b8a2f7d>] tcp_close+0x2d/0xc0 net/ipv4/tcp.c:2922
    [<00000000d4c1915c>] inet_release+0x82/0xf0 net/ipv4/af_inet.c:433
    [<00000000590c8ed6>] __sock_release+0x4b/0xf0 net/socket.c:657
    [<00000000d49971a8>] sock_close+0x19/0x30 net/socket.c:1399
    [<0000000097cacf4d>] __fput+0x1d0/0x4b0 fs/file_table.c:384
    [<000000006a98802f>] __fput_sync+0x37/0x40 fs/file_table.c:465
    [<00000000a6ebd3a7>] __do_sys_close fs/open.c:1572 [inline]
    [<00000000a6ebd3a7>] __se_sys_close fs/open.c:1557 [inline]
    [<00000000a6ebd3a7>] __x64_sys_close+0x4a/0xc0 fs/open.c:1557
    [<000000004060032b>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<000000004060032b>] do_syscall_64+0x3c/0x90 arch/x86/entry/common.c:80
    [<00000000e8d61c9b>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
---8<---

In my syzkaller log, only this program had the MD5 operation.
I ran this overnight but had no luck for now.

---8<---
23:51:30 executing program 0:
r0 = socket$inet(0x2, 0x4000000000000001, 0x0)
setsockopt$inet_tcp_TCP_MD5SIG(r0, 0x6, 0xe, &(0x7f0000000780)={@in={{0x2, 0x0, @local}}, 0x0, 0x9, 0x6, 0x0, "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030cf00"}, 0xd8) (async)
bind$inet(r0, &(0x7f0000deb000)={0x2, 0x4e23, @multicast1}, 0x10) (async, rerun: 64)
sendto$inet(r0, 0x0, 0x0, 0x200007b9, &(0x7f0000000040)={0x2, 0x4e23, @local}, 0x10) (async, rerun: 64)
socket$inet6(0xa, 0x0, 0x0) (async)
getsockopt$EBT_SO_GET_INIT_ENTRIES(0xffffffffffffffff, 0x0, 0x83, &(0x7f0000000080)={'filter\x00', 0x0, 0x4, 0x1000, [0x0, 0x8, 0x1, 0x1, 0x0, 0x7fffffff], 0x4, &(0x7f0000000000)=[{}, {}, {}, {}], &(0x7f0000000880)=""/4096}, 0x0) (async, rerun: 32)
socket(0x0, 0x0, 0x0) (async, rerun: 32)
r1 = openat2(0xffffffffffffffff, &(0x7f0000000100)='./file0\x00', &(0x7f0000000140)={0x20000, 0x8, 0x14}, 0x18)
bind$inet(r1, &(0x7f0000000180)={0x2, 0x4e22, @remote}, 0x10) (async)
sendmsg$nl_route(0xffffffffffffffff, 0x0, 0x0)
---8<---


> 
> You could not have KMEMLEAK in the kernel, and run the repro a thousand times.
> 
> Then compare /proc/slabinfo before/after.

