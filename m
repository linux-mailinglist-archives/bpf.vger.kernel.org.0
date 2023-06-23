Return-Path: <bpf+bounces-3278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D973BA98
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FE1C2122B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C8A95C;
	Fri, 23 Jun 2023 14:49:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4A3D9E
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:49:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30861B4
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687531789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa4vlkVpSuIcMxiE6ScAPKNIum7CDC6DiEwC59Fl7QI=;
	b=I6AUKsWgOsjHpfxfryMwOlQXKI3QeyNWCiNmmxwBpxOR/FDMhxwevLS/ODKfHAgsA+g9j8
	BcyVV3xL6Y6oJ6F5nnb9htOE2230jY7WWYv/L/18PdBVorhhKjFA+ZLYzvSf/NT9LM0jBu
	iY2UpE96t1O2Xy3X350EyoYt58lVOyw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-ftrvGkQkOg2jNqptbst6bA-1; Fri, 23 Jun 2023 10:49:48 -0400
X-MC-Unique: ftrvGkQkOg2jNqptbst6bA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-78f229d2217so31226241.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 07:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531788; x=1690123788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sa4vlkVpSuIcMxiE6ScAPKNIum7CDC6DiEwC59Fl7QI=;
        b=eLVJxUIWAJxHrcCo2buWCTDKYhhyPZRb8l9UakKtSpsipZEF//nqUMICcd1/PznSNL
         rTugRx9wtl3PsOrl+vlgfVeKHvhvjNTdPK+il4RUeTN4uD7w5Dr7wxlQrGAxbClgj5zj
         uH0/Uruq7FDAvf6HrtcrrCw4z2jHUs88ud/jpipcgn6PKmOzVGAsSwRkaCy5sYH5lUhq
         hrvfcnLHsvBgjIXI11aSzJx1a3tTk/hNDARixATFmpA0DxBVZP1bK9UjTMu6+ML4sLZH
         orn5LyodvXkQ8SYRGUOmeS43276uBNeBy1et02VU35peWwqQNbbF/bW2mBnZtgf9hith
         2x3A==
X-Gm-Message-State: AC+VfDxukCGL5njgxVYEhXWBv4Z572agTxtc157rrYXQSSAu/1X9QrU6
	ayAQP8GgYy8+jHhE1vAL4bOx3QzRWwzReNmfuSZuMsUR7aWrAnYmmImJJxu9d0O6nGUN8DWwDEf
	RS9BdKJqGmPnV
X-Received: by 2002:a05:6102:10c9:b0:440:9332:dc3d with SMTP id t9-20020a05610210c900b004409332dc3dmr9319052vsr.0.1687531787893;
        Fri, 23 Jun 2023 07:49:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47g/cMFGitkPreu/12ViEE/tTIHcui6yOL1l8vVTNojDwsaM1rCmqd5kLJmMgbAJF9NFz2gQ==
X-Received: by 2002:a05:6102:10c9:b0:440:9332:dc3d with SMTP id t9-20020a05610210c900b004409332dc3dmr9319044vsr.0.1687531787591;
        Fri, 23 Jun 2023 07:49:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id y17-20020a0cf151000000b0062629cbff10sm5079280qvl.114.2023.06.23.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:49:47 -0700 (PDT)
Message-ID: <4057c9829b3b018d64190c8b43d3db938c40358c.camel@redhat.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in __lock_sock_fast
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+c54a9e997982d1a7dc11@syzkaller.appspotmail.com>, 
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
Date: Fri, 23 Jun 2023 16:49:43 +0200
In-Reply-To: <0000000000009f59f005feccf27e@google.com>
References: <0000000000009f59f005feccf27e@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-23 at 07:38 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    98e95872f2b8 Merge branch 'mptcp-expose-more-info-and-sma=
l..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D109c5c1b28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da4a7d74e6a7c3=
211
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc54a9e997982d1a=
7dc11
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9846b6358605/dis=
k-98e95872.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c2ebfcba122e/vmlinu=
x-98e95872.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c5c7c23565e4/b=
zImage-98e95872.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c54a9e997982d1a7dc11@syzkaller.appspotmail.com
>=20
> BUG: sleeping function called from invalid context at net/core/sock.c:354=
9
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10350, name: syz-e=
xecutor.3
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 0
> 7 locks held by syz-executor.3/10350:
>  #0: ffffffff8e125408 (sock_diag_mutex){+.+.}-{3:3}, at: sock_diag_rcv+0x=
1b/0x40 net/core/sock_diag.c:279
>  #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_=
rcv_msg net/core/sock_diag.c:259 [inline]
>  #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_=
rcv_msg+0x2d2/0x440 net/core/sock_diag.c:248
>  #2: ffff88802f311688 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{3:3}, at: netlink_d=
ump+0xbe/0xc50 net/netlink/af_netlink.c:2215
>  #3: ffffffff8e29a628 (inet_diag_table_mutex){+.+.}-{3:3}, at: inet_diag_=
lock_handler+0x6e/0x100 net/ipv4/inet_diag.c:63
>  #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: mptcp_diag_dump_li=
steners net/mptcp/mptcp_diag.c:95 [inline]
>  #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: mptcp_diag_dump+0x=
7c8/0x1330 net/mptcp/mptcp_diag.c:197
>  #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock inc=
lude/linux/spinlock.h:350 [inline]
>  #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: mptcp_diag_du=
mp_listeners net/mptcp/mptcp_diag.c:98 [inline]
>  #5: ffffc9000130c330 (&h->lhash2[i].lock){+.+.}-{2:2}, at: mptcp_diag_du=
mp+0x838/0x1330 net/mptcp/mptcp_diag.c:197
>  #6: ffff88805c820cf0 (msk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_diag_get_=
info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 PID: 10350 Comm: syz-executor.3 Not tainted 6.4.0-rc6-syzkaller-01=
415-g98e95872f2b8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  __might_resched+0x358/0x580 kernel/sched/core.c:10153
>  __lock_sock_fast+0x25/0xe0 net/core/sock.c:3549
>  lock_sock_fast include/net/sock.h:1744 [inline]
>  mptcp_diag_fill_info+0x45c/0x9c0 net/mptcp/sockopt.c:930
>  mptcp_diag_get_info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
>  inet_sk_diag_fill+0x1258/0x1fd0 net/ipv4/inet_diag.c:342
>  sk_diag_dump net/mptcp/mptcp_diag.c:24 [inline]
>  sk_diag_dump net/mptcp/mptcp_diag.c:16 [inline]
>  mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:125 [inline]
>  mptcp_diag_dump+0xc5e/0x1330 net/mptcp/mptcp_diag.c:197
>  __inet_diag_dump+0x114/0x2e0 net/ipv4/inet_diag.c:1179
>  inet_diag_dump_compat+0x209/0x290 net/ipv4/inet_diag.c:1287
>  netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2268
>  __netlink_dump_start+0x6c0/0x9b0 net/netlink/af_netlink.c:2375
>  netlink_dump_start include/linux/netlink.h:330 [inline]
>  inet_diag_rcv_msg_compat+0x26d/0x2d0 net/ipv4/inet_diag.c:1321
>  __sock_diag_cmd net/core/sock_diag.c:240 [inline]
>  sock_diag_rcv_msg+0x2eb/0x440 net/core/sock_diag.c:269
>  netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2548
>  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
>  netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
>  netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
>  netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg+0xde/0x190 net/socket.c:747
>  splice_to_socket+0x964/0xee0 fs/splice.c:915
>  do_splice_from fs/splice.c:967 [inline]
>  direct_splice_actor+0x114/0x180 fs/splice.c:1155
>  splice_direct_to_actor+0x34a/0x9c0 fs/splice.c:1101
>  do_splice_direct+0x1ad/0x280 fs/splice.c:1207
>  do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1308 [inline]
>  __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fa74588c389
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa7443fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fa7459ac050 RCX: 00007fa74588c389
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000009
> RBP: 00007fa7458d7493 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000021fd1ee9 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffca549394f R14: 00007fa7443fe300 R15: 0000000000022000
>  </TASK>
>=20
>=20
> ---

#syz fix: mptcp: ensure listener is unhashed before updating the sk status

Sorry for noise,

/P


