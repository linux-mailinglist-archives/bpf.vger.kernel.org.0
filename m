Return-Path: <bpf+bounces-54887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E7A75472
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 07:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B241D18916F2
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463371684AC;
	Sat, 29 Mar 2025 06:05:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12F29A5;
	Sat, 29 Mar 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743228347; cv=none; b=BXwyJHymm2DLqLYlalidLRNko5ypQUbAqZyNBXfx5Y9aa8Pky/qus3jTy7gHEH+ahifn5wwsmTMerLFQMR7pxLwuWa4ZxyesULZWcWecKvjl3H6UiNDsbO7u/g4QsFPKFkUIp2Y0ZvoT2eChlaTHWtwphe8nUIWNBlBwhDZTW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743228347; c=relaxed/simple;
	bh=W8MmLsj+XhL7MTpl51FpqYMyJ6d9AWnF7Yt4WP4kx7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rEab40FgSDlLWt6N3092GkfuaftkarsbKJjWH4TSXSB/Qq1gDDhViDlZ7YuiYlfTWJlqO0HblY0b62NkmkxKHm8hgrXiM6ae7/QQbQ4Uigllrwci0SdBtyWFmGEyzSvJ4oy80BZ5lyufZjBjluM0P4V0B6M9jo2v6ptxQLZABKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZPmxS4kjFzCsK4;
	Sat, 29 Mar 2025 14:01:48 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D8CF5140203;
	Sat, 29 Mar 2025 14:05:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 29 Mar
 2025 14:05:27 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
Date: Sat, 29 Mar 2025 14:15:48 +0800
Message-ID: <20250329061548.1357925-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200005.china.huawei.com (7.202.181.32)

The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_RING
option but do not reserve tx ring. Because xsk_poll() try to wakeup the
driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
tx_ring_empty_descs count increases once the xsk_poll()is called:

  xsk_poll
    xsk_generic_xmit
      __xsk_generic_xmit
        xskq_cons_peek_desc
          xskq_cons_read_desc
            q->queue_empty_descs++;

To avoid this count error, add check for tx descs before send msg in poll.

Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not support ndo_xsk_wakeup")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..fb01e6736677 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -989,7 +989,7 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
 	if (pool->cached_need_wakeup) {
 		if (xs->zc)
 			xsk_wakeup(xs, pool->cached_need_wakeup);
-		else if (xs->tx)
+		else if (xs->tx && xskq_has_descs(xs->tx))
 			/* Poll needs to drive Tx also in copy mode */
 			xsk_generic_xmit(sk);
 	}
-- 
2.34.1


