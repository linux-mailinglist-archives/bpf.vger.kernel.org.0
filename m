Return-Path: <bpf+bounces-53319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCCA50142
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3537B189226E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172B24113C;
	Wed,  5 Mar 2025 14:02:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769E2E3396;
	Wed,  5 Mar 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183376; cv=none; b=B++t/eIVI/gtre+c9TZyznknBARy3znmCY/1WU8Nrj8vTmjaZRa0SHOwQjhxNOrLrwWJnbl88ARKhgHQgOVas92fdpBUiFVCmD6B2qPJtnT87SzI2mIrjoSYXXLy5lVxiA/mmrw/apbGqcRzcaBGtDOzLJnPn+yzsc8kNizQbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183376; c=relaxed/simple;
	bh=AY+NuMNR5CWph1/BQWdAvt2+Lc3CjLK2QGXJEeGaN+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyKx73vW7FaP/H6wFY3JzINF50AM4sIfC+LqlWQyGh+AiPxGYEwLGahXrz0EKuwPMGmoaUaGf2bSX85Sd/J7PiOCHc5BxgqyAR3NKPm9qZrHDcEfh/5wEBXldQn2SlcCHLssu37ki4R9bP/7PPhAlsS5tqDco5HI65821tiJY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z7Djh2ryhzpbV3;
	Wed,  5 Mar 2025 22:01:12 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 041C318009E;
	Wed,  5 Mar 2025 22:02:43 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 22:02:41 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net] bpf, sockmap: Restore sk_prot ops when psock is removed from sockmap
Date: Wed, 5 Mar 2025 22:02:34 +0800
Message-ID: <20250305140234.2082644-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
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
sock_hash_update_common
  sock_map_unref
    sock_map_del_link
      psock->psock_update_sk_prot(sk, psock, false);
	//false won't restore proto
    sk_psock_put
       rcu_assign_sk_user_data(sk, NULL);
inet_release
  sk->sk_prot->close
    sock_map_close
      WARN(sk->sk_prot->close == sock_map_close)

When psock is removed from sockmap, sock_map_del_link() still set
sk->sk_prot to bpf proto instead of restore it (for incorrect restore
value). sock release will triger warning of sock_map_close() for
recurse after psock drop.

Set restore param of psock_update_sk_prot to true to fix the problem.

Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82a14f131d00..10bc185ef103 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -171,7 +171,7 @@ static void sock_map_del_link(struct sock *sk,
 			sk_psock_stop_verdict(sk, psock);
 
 		if (psock->psock_update_sk_prot)
-			psock->psock_update_sk_prot(sk, psock, false);
+			psock->psock_update_sk_prot(sk, psock, true);
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 }
-- 
2.25.1


