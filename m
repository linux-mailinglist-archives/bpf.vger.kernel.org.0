Return-Path: <bpf+bounces-13467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D07DA0C4
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399951C210BA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D83D3A0;
	Fri, 27 Oct 2023 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FA3D398
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:42:57 +0000 (UTC)
X-Greylist: delayed 1096 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 11:42:55 PDT
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036A1A5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:42:55 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id F2E9C28FBD0E5; Fri, 27 Oct 2023 11:24:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Eric Dumazet <edumazet@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net-next] net: bpf: Use sockopt_lock_sock() in ip_sock_set_tos()
Date: Fri, 27 Oct 2023 11:24:24 -0700
Message-Id: <20231027182424.1444845-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest sync from net-next tree, bpf-next has a bpf selftest failure:
  [root@arch-fb-vm1 bpf]# ./test_progs -t setget_sockopt
  ...
  [   76.194349] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [   76.194682] WARNING: possible recursive locking detected
  [   76.195039] 6.6.0-rc7-g37884503df08-dirty #67 Tainted: G        W  O=
E
  [   76.195518] --------------------------------------------
  [   76.195852] new_name/154 is trying to acquire lock:
  [   76.196159] ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: ip_s=
ock_set_tos+0x19/0x30
  [   76.196669]
  [   76.196669] but task is already holding lock:
  [   76.197028] ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet=
_listen+0x21/0x70
  [   76.197517]
  [   76.197517] other info that might help us debug this:
  [   76.197919]  Possible unsafe locking scenario:
  [   76.197919]
  [   76.198287]        CPU0
  [   76.198444]        ----
  [   76.198600]   lock(sk_lock-AF_INET);
  [   76.198831]   lock(sk_lock-AF_INET);
  [   76.199062]
  [   76.199062]  *** DEADLOCK ***
  [   76.199062]
  [   76.199420]  May be due to missing lock nesting notation
  [   76.199420]
  [   76.199879] 2 locks held by new_name/154:
  [   76.200131]  #0: ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at:=
 inet_listen+0x21/0x70
  [   76.200644]  #1: ffffffff90f96a40 (rcu_read_lock){....}-{1:2}, at: _=
_cgroup_bpf_run_filter_sock_ops+0x55/0x290
  [   76.201268]
  [   76.201268] stack backtrace:
  [   76.201538] CPU: 4 PID: 154 Comm: new_name Tainted: G        W  OE  =
    6.6.0-rc7-g37884503df08-dirty #67
  [   76.202134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.13.0-1ubuntu1.1 04/01/2014
  [   76.202699] Call Trace:
  [   76.202858]  <TASK>
  [   76.203002]  dump_stack_lvl+0x4b/0x80
  [   76.203239]  __lock_acquire+0x740/0x1ec0
  [   76.203503]  lock_acquire+0xc1/0x2a0
  [   76.203766]  ? ip_sock_set_tos+0x19/0x30
  [   76.204050]  ? sk_stream_write_space+0x12a/0x230
  [   76.204389]  ? lock_release+0xbe/0x260
  [   76.204661]  lock_sock_nested+0x32/0x80
  [   76.204942]  ? ip_sock_set_tos+0x19/0x30
  [   76.205208]  ip_sock_set_tos+0x19/0x30
  [   76.205452]  do_ip_setsockopt+0x4b3/0x1580
  [   76.205719]  __bpf_setsockopt+0x62/0xa0
  [   76.205963]  bpf_sock_ops_setsockopt+0x11/0x20
  [   76.206247]  bpf_prog_630217292049c96e_bpf_test_sockopt_int+0xbc/0x1=
23
  [   76.206660]  bpf_prog_493685a3bae00bbd_bpf_test_ip_sockopt+0x49/0x4b
  [   76.207055]  bpf_prog_b0bcd27f269aeea0_skops_sockopt+0x44c/0xec7
  [   76.207437]  __cgroup_bpf_run_filter_sock_ops+0xda/0x290
  [   76.207829]  __inet_listen_sk+0x108/0x1b0
  [   76.208122]  inet_listen+0x48/0x70
  [   76.208373]  __sys_listen+0x74/0xb0
  [   76.208630]  __x64_sys_listen+0x16/0x20
  [   76.208911]  do_syscall_64+0x3f/0x90
  [   76.209174]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  ...

Both ip_sock_set_tos() and inet_listen() calls lock_sock(sk) which
caused a dead lock.

To fix the issue, use sockopt_lock_sock() in ip_sock_set_tos()
instead. sockopt_lock_sock() will avoid lock_sock() if it is in bpf
context.

Fixes: 878d951c6712 ("inet: lock the socket in ip_sock_set_tos()")
Cc: Eric Dumazet <edumazet@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/ipv4/ip_sockglue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 9c68b6b74d9f..2efc53526a38 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -602,9 +602,9 @@ void __ip_sock_set_tos(struct sock *sk, int val)
=20
 void ip_sock_set_tos(struct sock *sk, int val)
 {
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	__ip_sock_set_tos(sk, val);
-	release_sock(sk);
+	sockopt_release_sock(sk);
 }
 EXPORT_SYMBOL(ip_sock_set_tos);
=20
--=20
2.34.1


