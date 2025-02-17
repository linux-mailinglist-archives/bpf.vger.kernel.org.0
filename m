Return-Path: <bpf+bounces-51740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A936A38658
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EF43BBA58
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6352248BA;
	Mon, 17 Feb 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AInv2E/P"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76B223316;
	Mon, 17 Feb 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801976; cv=none; b=UbZhghi152GRZkbn7U4psKInQMOJwyB8z42+DQ61bvNWPF4Fasu64S2PINuyNCG8R/EAKCs6OljriG/E48zqZDAZjGEpXDekZPmNgZli+AGS7WMxZlU69CK6Wc++t6oWTV+xzjuvRn7vPWvoZbgjfhrzIbGNxBIPQcwjDD29AoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801976; c=relaxed/simple;
	bh=V9hqS+AXY7AiYLWCPLmQNTLAQOyoxIH0VR7ObxKpZ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJQbrtJN/WqSmXaJV8dtjVVG9Rd/htzyGXvyY7b69XXEDJ1UbPoLv3yCbeKaNudH6m8AazWXpwcMil0YksWG+EwLf8oG1XpuuS8ea8rVicLhMfLT1/iuwGsbEt0mhg2Rn0qa0CW+xPqYzk0qpusQUGBXfMZSvYdDW9eHF/Klzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AInv2E/P; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KwLwX
	O1E7gDZUNC+t9Rm7/a/828TjhQi7X77bBqPp5s=; b=AInv2E/P462zuHdfTxN0Z
	6rIEtL1CSmGx3d9Ty/nExnq9NmoUhqxaqIwIFhMK+sfvJm/9NXwcoldMh6S421Xc
	ygxj3wi5siBWs9VRSlQFfrGpNgddyBNTb/Rc2GZUPTGO7s9LzX65+WiHTbdaH8GV
	Xb3ikicxjgmCWuZc1KjhLE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3H+xARbNnCmVpMw--.21229S4;
	Mon, 17 Feb 2025 22:18:41 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: kuba@kernel.org,
	louis.peens@corigine.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	haoxiang_li2024@163.com,
	qmo@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
Date: Mon, 17 Feb 2025 22:18:37 +0800
Message-Id: <20250217141837.2366663-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H+xARbNnCmVpMw--.21229S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tr48Zw43Gry7AF4kCrg_yoWfCwbEkF
	129Fn3C395Kr1Ykr4jgw4avry3trn0qryruFW3KrWSvryUJr48Xr9Y9ryrAF9rWF4xAa9r
	X3s7JryxAa42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gz2bmey5vIHlQADsW

Add check for the return value of nfp_app_ctrl_msg_alloc() in
nfp_bpf_cmsg_alloc() to prevent null pointer dereference.

Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..09ea1bc72097 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,9 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skb) {
+		return NULL;
+	}
 	skb_put(skb, size);
 
 	return skb;
-- 
2.25.1


