Return-Path: <bpf+bounces-54918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03729A75D94
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 03:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FC07A32B1
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432873451;
	Mon, 31 Mar 2025 01:22:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48E33F3;
	Mon, 31 Mar 2025 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384119; cv=none; b=cs232RyCbOM02EU3wR9/OC9J8Mr7YfDlmjq9Nnh9jbGdXdpP9PW0sNZbLiSeVEkHP7YXvIK/YqFxEvRpDhxplgjxbXiJgHhyCdjHBW4Suwb+dSvdIYlxgUX2l25xf6GzAu6cUNesn5CLF/xTUz6AYh+CxbHHLPcI1SuPospOM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384119; c=relaxed/simple;
	bh=i5EBeJNNbzKqr+aaq9w/1eyGwDCjbtmbFVENMct97XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB+WtNoWyjYzk1512u/k/MWdV0IIU/Tc3AU9na2NJPBKzTPYfiBr+MTNvPypyVQwL0aixcNoN59aHx2B93XUvP+ecp59elC8iMISf5mYokEO6nM2EiFLmcFhkxv+yem8+aXk8yDti9cyewNnS0bs2O03zfek8Z9KlDBgYagT1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZQtbM3PQdz1R7bS;
	Mon, 31 Mar 2025 09:19:59 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D29591A016C;
	Mon, 31 Mar 2025 09:21:48 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 09:21:47 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>, <xiyou.wangcong@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stfomichev@gmail.com>,
	<mrpre@163.com>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v2 1/2] bpf, sockmap: Avoid sk_prot reset on sockmap unlink with ULP set
Date: Mon, 31 Mar 2025 09:21:25 +0800
Message-ID: <20250331012126.1649720-2-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250331012126.1649720-1-dongchenchen2@huawei.com>
References: <20250331012126.1649720-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
Changes for v2:
- Move ULP check from sock_map_del_link() to tcp_bpf_update_proto()
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4..01b3930947cc 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -708,6 +708,9 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 		return 0;
 	}
 
+	if (inet_csk_has_ulp(sk))
+		return 0;
+
 	if (sk->sk_family == AF_INET6) {
 		if (tcp_bpf_assert_proto_ops(psock->sk_proto))
 			return -EINVAL;
-- 
2.25.1


