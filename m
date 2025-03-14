Return-Path: <bpf+bounces-54026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE54A60B22
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3048E3A708B
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86F1A5B84;
	Fri, 14 Mar 2025 08:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135421624FC;
	Fri, 14 Mar 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940437; cv=none; b=K83Tg7Ccm9vxec01mYUNSAD6yWRH/VTDH0EPGatdNMe6uQVG1ZUtLt3IpIea9arQLhFRDB9LCAtgNMjzNaeNbS32ScdBPBRVOl3y8klzUqjrm//zAiHgM9+yy8yXiqJc+pVES6A42EpJAaPMEE+0gXlvcH8ldQzkpwvGCSqmGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940437; c=relaxed/simple;
	bh=BB3c1APHZaJlvJZHN3q8R3iBKJEj1Lik3mKzQ/joIus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONlE/LOhKEcb6z7qFr7rSuWl9NK8U090Pqxec91tgGVTLRq6uVg2vB6jLvcK/NwMp9P5vt4PblnUskpuuqkgslj+zf8m/0qSQPR+xE0sVcPRiLRS1bOcb84mj5O7Z16Bm3SPRKZtREqbfKfN5Uzi4D3/MazNS0b34qF+xK+dyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZDcdG3D5gz1f0pd;
	Fri, 14 Mar 2025 16:16:02 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 05D2D14022D;
	Fri, 14 Mar 2025 16:20:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:25 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stfomichev@gmail.com>,
	<mrpre@163.com>, <xiyou.wangcong@gmail.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net 1/2] bpf, sockmap: Avoid sk_prot reset on sockmap unlink with ULP set
Date: Fri, 14 Mar 2025 16:20:03 +0800
Message-ID: <20250314082004.2369712-2-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314082004.2369712-1-dongchenchen2@huawei.com>
References: <20250314082004.2369712-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100023.china.huawei.com (7.221.188.33)

WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
Modules linked in:
CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
RIP: 0010:sock_map_close+0x3c4/0x480
Call Trace:
 <TASK>
 inet_release+0x144/0x280
 __sock_release+0xb8/0x270
 sock_close+0x1e/0x30
 __fput+0x3c6/0xb30
 __fput_sync+0x7b/0x90
 __x64_sys_close+0x90/0x120
 do_syscall_64+0x5d/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The root cause is:
bpf_prog_attach(BPF_SK_SKB_STREAM_VERDICT)
tcp_set_ulp //set ulp after sockmap add
	icsk->icsk_ulp_ops = ulp_ops;
sock_hash_update_common
  sock_map_unref
    sock_map_del_link
      psock->psock_update_sk_prot(sk, psock, false);
	sk->sk_prot->close = sock_map_close
sk_psock_drop
  sk_psock_restore_proto
    tcp_bpf_update_proto
       tls_update //not redo sk_prot to tcp prot
inet_release
  sk->sk_prot->close
    sock_map_close
      WARN(sk->sk_prot->close == sock_map_close)

commit e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
has moved ulp check from tcp_bpf_update_proto() to psock init.
If sk sets ulp after being added to sockmap, it will reset sk_prot to
BPF_BASE when removed from sockmap. After the psock is dropped, it will
not reset sk_prot back to the tcp prot, only tls context update is
performed. This can trigger a warning in sock_map_close() due to
recursion of sk->sk_prot->close.

To fix this issue, skip the sk_prot operations redo when deleting link
from sockmap if ULP is set.

Fixes: e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82a14f131d00..a3ed1f2cf8a2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -170,7 +170,7 @@ static void sock_map_del_link(struct sock *sk,
 		if (verdict_stop)
 			sk_psock_stop_verdict(sk, psock);
 
-		if (psock->psock_update_sk_prot)
+		if (!(sk_is_inet(sk) && inet_csk_has_ulp(sk)) && psock->psock_update_sk_prot)
 			psock->psock_update_sk_prot(sk, psock, false);
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
-- 
2.34.1


