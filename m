Return-Path: <bpf+bounces-30054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B58CA3DE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FD28232F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BB139D17;
	Mon, 20 May 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="seD2tPjl"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20731369BA;
	Mon, 20 May 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241420; cv=none; b=GpyGbjCqvdQoMSb39e/nSTWgpr9J5jcQI3N3V5b2AwHowpwVMbj4abYd1ErlOy9livOE1NqZPFPQxLn0aIxYZ7cKKfOR7DRpRWM+LyYNaAfGCCuzGchfjP+S0YxY4/X0N9pbsTr8onBIfP8+5UDdnnlMxWWcfXygxw44qA/lva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241420; c=relaxed/simple;
	bh=7WNiq+m24TdoDjrU3CX4peS8kSGwsRE718xgtAGf3kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qWDNnsVGHX/ngbpKuE7ipFiqnKOmceqOi6ItxLNSyeHWzVOrttpW0gQrtd++r1F+EZ7UTWwnM29yFOOaXHeno8m5+jsuSHZemQffVhQLVKHkCHq/0Syba8ZXQJyOL9Vt/v+ujRbfzNSMCYyl98CFMIvAmf+uNXtILEp93e1zeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=seD2tPjl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nRaPtaGD+w2O2Xn9ZyX0XaVoJoGCp+hsvN0C/YGO87c=; b=seD2tPjl1ZuwN0XVfUGP6eptAZ
	sFqT3ZVRnQ4KqYU0/klnL16OJ0w3SqdGWyuVocLw0s/PyXaC3lihbPnHFNs/GRN+I1D2GZhP29Nzz
	2kHJofFAuP3jC+m2TLcP9Tu+ehaq3Dw04E7GbMMeErovazgcOFOZwCyIfTh9LKHjKWLNWS7IIJT9y
	WNCpjMzEf/93DsWb/lNQpCXSPXxxThgIWgOvi2kFq8i2ISpnqetMY7LWu+FAbJ0m8obXdUD8wEHgj
	1FAL8ZBXb8vi04I3ClMPdQnmybbmItKk68GvzVudO4TLEE7HUFm8VbPU73PCKtAPVtZXy2LtCtaUx
	+M4tjvZQ==;
Received: from 179-125-79-244-dinamico.pombonet.net.br ([179.125.79.244] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s9Amv-00AOaJ-Mf; Mon, 20 May 2024 23:43:22 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] sock_map: avoid race between sock_map_close and sk_psock_put
Date: Mon, 20 May 2024 18:41:53 -0300
Message-Id: <20240520214153.847619-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_get will return NULL if the refcount of psock has gone to 0, which
will happen when the last call of sk_psock_put is done. However,
sk_psock_drop may not have finished yet, so the close callback will still
point to sock_map_close despite psock being NULL.

This can be reproduced with a thread deleting an element from the sock map,
while the second one creates a socket, adds it to the map and closes it.

That will trigger the WARN_ON_ONCE:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
Modules linked in:
CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 unix_release+0x87/0xc0 net/unix/af_unix.c:1048
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbe/0x240 net/socket.c:1421
 __fput+0x42b/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb37d618070
Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Use sk_psock, which will only check that the pointer is not been set to
NULL yet, which should only happen after the callbacks are restored. If,
then, a reference can still be gotten, we may call sk_psock_stop and cancel
psock->work.

After that change, the reproducer does not trigger the WARN_ON_ONCE
anymore.

Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_map_close()")
Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 net/core/sock_map.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9402889840bf..13267e667a4c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeout)
 
 	lock_sock(sk);
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
+	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
+		saved_close = READ_ONCE(sk->sk_prot)->close;
 		rcu_read_unlock();
 		release_sock(sk);
-		saved_close = READ_ONCE(sk->sk_prot)->close;
 	} else {
 		saved_close = psock->saved_close;
 		sock_map_remove_links(sk, psock);
+		psock = sk_psock_get(sk);
 		rcu_read_unlock();
-		sk_psock_stop(psock);
+		if (psock)
+			sk_psock_stop(psock);
 		release_sock(sk);
-		cancel_delayed_work_sync(&psock->work);
-		sk_psock_put(sk, psock);
+		if (psock) {
+			cancel_delayed_work_sync(&psock->work);
+			sk_psock_put(sk, psock);
+		}
 	}
 
 	/* Make sure we do not recurse. This is a bug.
-- 
2.34.1


