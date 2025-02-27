Return-Path: <bpf+bounces-52721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A835A476F7
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 08:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BBF3B1196
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105D224890;
	Thu, 27 Feb 2025 07:59:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76111E832D;
	Thu, 27 Feb 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643154; cv=none; b=DWZnjKLQ3WDy2QLp0HaJZTnqGtKBG8z6megdkSQgkP9Ir+OW5MVWiRyC9Lpx9/Gy7J0DcHyA7aK6Tv86j5S2SfEOkTFRESi59lJIzE6qWaQQNEmbCUS3yIU7BFUQtIuJwcKZivDbSJQ5SMnRlLK2cyyUrZFe0N/yo6ap5WNu4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643154; c=relaxed/simple;
	bh=JaRfSDvS8larS0GgAbOOpOdpFla50DxW1p/0Lzrzxew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Au7VPG/0IumT/H/JcxAz8RbS4tEBqh0h63fkH7nABT8HNAVTmMg/3DIBY8yjJpKoNzVsQOEtk7HRhqiSrgggzfmGHYCORldHBA7oNOfy2JMN36J5kzR6FHhVW3XlMN1OsLD9cYlQXtGLdmU01YWvKue+/UCScm1zMO2aN8iHpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z3Nv832CBz21p4R;
	Thu, 27 Feb 2025 15:56:04 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 679DB1400D5;
	Thu, 27 Feb 2025 15:59:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 27 Feb
 2025 15:59:07 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] xsk: fix __xsk_generic_xmit() error code when cq is full
Date: Thu, 27 Feb 2025 16:10:52 +0800
Message-ID: <20250227081052.4096337-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200005.china.huawei.com (7.202.181.32)

When the cq reservation is failed, the error code is not set which is
initialized to zero in __xsk_generic_xmit(). That means the packet is not
send successfully but sendto() return ok.

Considering the impact on uapi, return -EAGAIN is a good idea. The cq is
full usually because it is not released in time, try to send msg again is
appropriate.

Suggested-by: Magnus Karlsson <magnus.karlsson@gmail.com>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..e04809a4c5d3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,8 +802,11 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		if (xsk_cq_reserve_addr_locked(xs->pool, desc.addr))
+		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		if (err) {
+			err = -EAGAIN;
 			goto out;
+		}
 
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
-- 
2.34.1


