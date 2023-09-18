Return-Path: <bpf+bounces-10275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87047A4755
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF411C209C7
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364938FBB;
	Mon, 18 Sep 2023 10:33:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65138FAD
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:33:36 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E212E
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 03:33:33 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a9f2f6d356so7138179b6e.2
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 03:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033213; x=1695638013;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGRLeptGZvLp1hUYEMjYiRhp/wDfnF1GLg92JMr4Fig=;
        b=pnyEc2TPI+9nMRDmueOENJc2RkHDzE54oqmBndKvxyI7fM2qNzEVfqEBk6SpGAkZec
         5ef1rkq0mpDAllvdf7iliE/SQgMWTcsPVxvgpfKIFMRw67wB0ha5mB0hwn3GJ+FudisF
         juzna43YH1WhjcQ6UDLL9AWwh0oWL4hIJthFNOisx+MiEBAM1RqLlYwfg1KaP2Jz/L1J
         six2BhECBSc6LZ8KiWwCmBrX063JqLPLAzytnHgXO2mnrdmiehoOIsOfIWzvNWwxwaBz
         atBECGs4at9FDLV35s27C2npQbwmdMNppjYadcXhB4nlyhfJjjsIGDEWyGRbO0i088DO
         6axg==
X-Gm-Message-State: AOJu0YwF92sC7NdS/vTU7NTQm2Rs794fKGncmYGFXAvtauJxezkN+kvB
	16Fjizv37/M0xlEybp74v8TsPg/z1bg0sAScrXap38WyNcI982k=
X-Google-Smtp-Source: AGHT+IEhT6lrIQ3NypWojHeJGdRpTkqBG7gOMcP6APFSfTvf2EDMdZgPLQy/VATxZvrCrEux6Exk/iXUwchO/8G02Ie0b9nn54uK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1f:b0:3ac:ab4f:ef3 with SMTP id
 bk31-20020a0568081a1f00b003acab4f0ef3mr3979852oib.6.1695033212795; Mon, 18
 Sep 2023 03:33:32 -0700 (PDT)
Date: Mon, 18 Sep 2023 03:33:32 -0700
In-Reply-To: <3905313.1695031861@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088066006059fac87@google.com>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
From: syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ip6_append_data

l2tp_ip6_sendmsg()
MAXPLEN
check 0 4100 65575 40, 4 65536
l2tp_ip6_sendmsg()
MAXPLEN
check 4100 4100 65575 40, 0 65536
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5455 at net/ipv6/ip6_output.c:1812 __ip6_append_data.isra.0+0x1c6d/0x4900 net/ipv6/ip6_output.c:1812
Modules linked in:
CPU: 0 PID: 5455 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:__ip6_append_data.isra.0+0x1c6d/0x4900 net/ipv6/ip6_output.c:1812
Code: c4 f6 ff ff e8 84 d4 97 f8 49 8d 44 24 ff 48 89 44 24 68 49 8d 6c 24 07 e9 ab f6 ff ff 4c 8b b4 24 90 01 00 00 e8 63 d4 97 f8 <0f> 0b 48 8b 44 24 10 45 89 f4 48 8d 98 74 02 00 00 e8 4d d4 97 f8
RSP: 0018:ffffc90004f373b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000001004 RCX: 0000000000000000
RDX: ffff888019e8bb80 RSI: ffffffff88efcf9d RDI: 0000000000000006
RBP: 0000000000001000 R08: 0000000000000006 R09: 0000000000001004
R10: 0000000000001000 R11: 0000000000000001 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000001004 R15: ffff888027b1d640
FS:  00007feae40ff6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f01e4e378 CR3: 000000007d467000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6_append_data+0x1e6/0x510 net/ipv6/ip6_output.c:1909
 l2tp_ip6_sendmsg+0xe0c/0x1ce0 net/l2tp/l2tp_ip6.c:633
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:840
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 splice_to_socket+0xade/0x1010 fs/splice.c:881
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feae347cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feae40ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007feae359bf80 RCX: 00007feae347cae9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007feae34c847a R08: 0000000000000000 R09: 0000000000000000
R10: 000000010000a006 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007feae359bf80 R15: 00007ffc444d03c8
 </TASK>


Tested on:

commit:         65d6e954 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12133ac4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=62cbf263225ae13ff153
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139cae54680000


