Return-Path: <bpf+bounces-51793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B559A39148
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3453818903A0
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107318787A;
	Tue, 18 Feb 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IKbx/RJI"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406518E1F;
	Tue, 18 Feb 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849051; cv=none; b=gQx1WoyVW0VgUf58NrTDz0ZfPJ4g/jF/MuqLsA1inKodOtzyVp2fjZPZZYj0P8hvxN6QrP3WJzCfydCal59IStfh3ExyvzdzLwYl6ZEO865+YsCW/dru3nNeYKqgBpsIRtXiZuRy3D45ImHqxoLDMtPluKB49na7VH9RExs/CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849051; c=relaxed/simple;
	bh=YJwQ56MevDZ9ZYQuremXiyKEvKkBRGC/R9BJu26M0XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESAyEPAnZDTusW7Nei/a7auGgDguZfF3SNSw7+E5rsnvGwjrtQTSKCN4uDxfXir0MLKcsQ2uPmUs+9zwCsoLcqxgPuy2xQdwmoH1lXSJMd4rD9dwM8MjxMBMIeTs+cyCKeX8RRmnpybl45Xnz2EdQ9ZEI0INN9tyLu7Qs1//rgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IKbx/RJI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KZodN
	t1cshXHiodAWx+wxQbRKgFIgZ9m7uvCtiXcJJE=; b=IKbx/RJIr1lOZEmhCFPJ+
	DH9xFT5fnjrR9j8hXz207W03amCloB5BGfwKjYVffNRJZnf5F1raTuSPJU8N+8QZ
	EvHM5ULfRqZAkkDHGr+ez1LKv2VNlhL8LQh+4kbzcXyU8m+gZCWoWM7NzlfIXhjz
	is31BLssGgpO4yOioSMySo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHm36q+LNn2wt_MQ--.33774S4;
	Tue, 18 Feb 2025 11:04:12 +0800 (CST)
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
Subject: [PATCH net v3] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
Date: Tue, 18 Feb 2025 11:04:09 +0800
Message-Id: <20250218030409.2425798-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHm36q+LNn2wt_MQ--.33774S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tr48Zw43Gry7Kw17Wrg_yoWDZFgEkF
	129Fnak3yrKr1Ykr4jgw4avr9Iywn0qryruF9xKrZa9ry3Cr18Xr95ur95ZF9rWF4xAa9r
	X3s7try7Aa42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNCJmUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gP3bmez8hDUbwAAsF

Add check for the return value of nfp_app_ctrl_msg_alloc() in
nfp_bpf_cmsg_alloc() to prevent null pointer dereference.

Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v3:
- modify a spell error. Thanks, Kalesh!
Changes in v2:
- remove the bracket for one single-statement. Thanks, Guru!
---
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..59486fe2ad18 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
 	skb_put(skb, size);
 
 	return skb;
-- 
2.25.1


