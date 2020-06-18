Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075971FDC07
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgFRBQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 21:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgFRBQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61B221D79;
        Thu, 18 Jun 2020 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442980;
        bh=RNPq6SF4ZWwRpZosC3065GmzXtKZyf+9MuZsESPrs74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwvtPiCqJGuWzQ8ASi0VS4gbnyLklRgGx71JGVSWxNqGzGCBBL1JfP8rbs5M36LIr
         cDp3+uE9Eid+xEhSJ4MC5ZaAsFIXSEReuF9weNDPjfZemNWJxTHxJ2E6Y1jJEvK7Jh
         zHA6H/f3CpGtSUhoi8lm0Xwx/Kjc7LpCLUu+GzII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 382/388] xdp: Fix xsk_generic_xmit errno
Date:   Wed, 17 Jun 2020 21:07:59 -0400
Message-Id: <20200618010805.600873-382-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit aa2cad0600ed2ca6a0ab39948d4db1666b6c962b ]

Propagate sock_alloc_send_skb error code, not set it to
EAGAIN unconditionally, when fail to allocate skb, which
might cause that user space unnecessary loops.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/1591852266-24017-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c350108aa38d..a4676107fad0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -397,10 +397,8 @@ static int xsk_generic_xmit(struct sock *sk)
 
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
-		if (unlikely(!skb)) {
-			err = -EAGAIN;
+		if (unlikely(!skb))
 			goto out;
-		}
 
 		skb_put(skb, len);
 		addr = desc.addr;
-- 
2.25.1

