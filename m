Return-Path: <bpf+bounces-44338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDF9C17B9
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 09:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80ECDB22D1B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBF1DF723;
	Fri,  8 Nov 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="smORHAsT"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4131DACA1;
	Fri,  8 Nov 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053950; cv=none; b=f5UGPk9jS0ohws4EX57QmrGDB4sZWCjjbXktly+kbAW8wVbHD+NEJGwZk51CK93ceqjBq88KjzVpkjFE8Ifo2d+1SHDSGrA7dmdYiB93EKDG/aZOSLfmQ6R9aLxM78z1cG/RktYdh8DjIUumxe5QBZugZ++gv0Vx/eIRNHiVng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053950; c=relaxed/simple;
	bh=iXHrBL4LQP1zfCQw9hd4nGFRXBxeQitQM7MrOkznPzc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UsHfPaDE+xjH4Sd8KyYp8p7yQwvAr3bBIpcjxCDefjzLZP4zDjXIfOIgZX0yiNRXR9PaaVQT0yFx8skd12af5feueo0lFaiw8JPT8Ye4dyAPrF5mbK4YlQJJZ5AH7O3WcYK7j46RHBppaD7QFbtSBIpX4GF40WS3ddt2SdKnZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=smORHAsT; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1731053935;
	bh=G5AasHwJUPIvWba5jjKssBCTEs7Viz1urDez9UtIGzc=;
	h=From:To:Cc:Subject:Date;
	b=smORHAsTdH+SaYHmUQE6XY8GXKLweSmecF3RMEPV+3Dw6wMLRHW3LU4hVjPtFkmns
	 ouvugG75fFU1qt6xs3KcPEOgO6ieoP6UdWYqXybBMlQ5YEHCKaPICDZhnW1jsPDxnX
	 8UIwpKHCoV/+jqWS/7riFW07/5XZViW5iettoZzI=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 4B4A2013; Fri, 08 Nov 2024 16:18:52 +0800
X-QQ-mid: xmsmtpt1731053932tsxe9qji1
Message-ID: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
X-QQ-XMAILINFO: MvTK+AXQ7a4FRRnkPllYZNdQ/lMUxf8qYP61N+F2M9eOeuDg+Aj2hJ9HXQwA+p
	 gNx7R6MEjXFKeDh0fJ9SZ3e1PIvZf3SAhotqftLNRborP5RWDmdt+H3SPw6dvoGk5yniv+j2VQym
	 yf6XWlLOfBDgueGwlt+T1p2ncskLXiY6bLp98czjmafHe4yLNRLqWzY7HQaW2d0khiYjNfBgTk13
	 VQNoJ/QyFdzJWhcsLWjSJmtOVGX/cRzq3qkiGQnJQrcRymn2gTJDNLAULQkrWxwHX8R5DxD+xek6
	 plyuNE093/ypGQotP4QrcqTIba3vsahKnKAdv+AdFV7KOLOptM8heC2rp8hu1NaSmhfTuX+Mndky
	 RSuG5e+7XpjBxcBS8prgBSTUezTPPgRpCHh/VdSF7fGLBRKdAVTPwAMpRPa3wU5m8RLkBmoQ4S9Z
	 VOeC2GuvJSHTQr21AG8rJlZ1YBPsbDS+zMAazYSB5oIfAXAIkmlKFiNlPjRLGNWRx4TeSMSjjjNS
	 zTsLdfr2PZ1zd06BEl/BG5b5GpaSJoBObGjJ7cOXoauKO2TbfUlja1d2f8hyx2Ng8GR4aRdTVYCK
	 No+1LvEp0foOqU0OM2CSPa11eKbCWh2ZTN7cQVc+nNqJJIjJ4vtIfvXfgqwHv9xGVMN1MfAOqHtb
	 R2tUKk18MJf829paRMGMGGW9m+kC3rzRuZYMX/9KUbUCbAB0F7R/zHKVwmWNtRVHKimhxtiibZ5P
	 GwtNAtycL6SU0R7cDubYNGrL/LR0jo1OHgLAvMJmAnKCtEbsamYwIIXWN6EGo0UZJQQVPp4ARO2C
	 QBkjD8cYJ4xk++MvLUCN2LXVlgGLLElYcW2Rn85jgd5KGikxypShUyuWBd8Xtd+/9hp3zr54l/cJ
	 Fb6+hoOAfi8GNf8DFq3TdH0MWFYdYxWcYiPVDSxxzHViZY/ZWENcq0B5WSVfNAk8CAMl+NXRg5JR
	 k8bKpgnYEvdkLHLK0Bti4MUvirFOyLtHQFCt8PWUhRIHXO0lxIZkBpiZDh42deZ2+0Dz1CofWwk9
	 0u17MGAzyCkMSr2sO/orLwcy1Og7D7qWXsVfvgtw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6
Date: Fri,  8 Nov 2024 08:18:52 +0000
X-OQ-MSGID: <20241108081852.2188323-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the bpf_out_neigh_v6 function, rcu_read_lock() is used to begin an RCU
read-side critical section. However, when unlocking, one branch
incorrectly uses a different RCU unlock flavour rcu_read_unlock_bh()
instead of rcu_read_unlock(). This mismatch in RCU locking flavours can
lead to unexpected behavior and potential concurrency issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

This patch corrects the mismatched unlock flavour by replacing the
incorrect rcu_read_unlock_bh() with the appropriate rcu_read_unlock(),
ensuring that the RCU critical section is properly exited. This change
prevents potential synchronization issues and aligns with proper RCU
usage patterns.

Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 64248d0ac4ad..44bbc1dbfb50 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2232,7 +2232,7 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 		rcu_read_unlock();
 		return ret;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 	if (dst)
 		IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
 out_drop:
-- 
2.34.1


