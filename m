Return-Path: <bpf+bounces-52134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B7A3EA25
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA6F3BE1E9
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C878F20;
	Fri, 21 Feb 2025 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pr2JqZ8I"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577C1876;
	Fri, 21 Feb 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101821; cv=none; b=DbTskASCPdTaej2WzsvHvLk5JnuSI2rHyG2eht6it0DvCF/bBFTFtNkhHZETVEXJ68Ky/MWj5Bc7ETH2hs6HVa0V6iwWwyxXU8uYYMaWpWfG5ZIK+8D8IOcfhR9u7/9ZVB45Zqv5uGNKsU3N8pbTGOfTBKS4G+CxCN1ogB8Sy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101821; c=relaxed/simple;
	bh=w9uXlUtp2MUHgEVCKb3zHQZaq49R1+Z0/aG5BVel54M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cthOiCfIBj2ARonJPV6PSc+3t3L6YXKfo2ojJsBglK2FAHCc5eazNvCwFON19RB62fD9iYYMvteaF8Uh7tfyF62jGmx8QOVdd0AsCXGIyIyKlASSn0Rg+5c0QGnSiQnjEN2ku/78aoJnrL5SE/1Vg/mj5bjgrYknMG9HRj62sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pr2JqZ8I; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740101809; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yIFTQsyRa5E5ivx4nFPeX1Tx1YoivCBFKzAh+s3sw6Y=;
	b=pr2JqZ8IMQUbRZwQQqirZTMiyhG7VZJGC0xvkR9x+KwD/chmab5fvGj7Iw0aroWM3MkbPUjICY+CcoSu+1cBfgppAuFQH2Txqvf49skyOLwmZYN2FlmbZZ6V8oLwZgvPpUUh/pNlnGKaQf1EBib9o5K+qDITN53V8vu1qyUUO5o=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WPuR6rc_1740101808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 09:36:48 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	asml.silence@gmail.com,
	willemb@google.com,
	almasrymina@google.com,
	chopps@labn.net,
	aleksander.lobakin@intel.com,
	nicolas.dichtel@6wind.com,
	dust.li@linux.alibaba.com,
	hustcat@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipvs: Always clear ipvs_property flag in skb_scrub_packet()
Date: Fri, 21 Feb 2025 09:36:48 +0800
Message-Id: <20250221013648.35716-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found an issue when using bpf_redirect with ipvs NAT mode after
commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
the same name space"). Particularly, we use bpf_redirect to return
the skb directly back to the netif it comes from, i.e., xnet is
false in skb_scrub_packet(), and then ipvs_property is preserved
and SNAT is skipped in the rx path.

ipvs_property has been already cleared when netns is changed in
commit 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when
SKB net namespace changed"). This patch just clears it in spite of
netns.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
This is in fact a fix patch, and the issue was found after commit
ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
the same name space"). But I'm not sure if a "Fixes" tag should be
added to that commit.
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7b03b64fdcb2..b1c81687e9d8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6033,11 +6033,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->offload_fwd_mark = 0;
 	skb->offload_l3_fwd_mark = 0;
 #endif
+	ipvs_reset(skb);
 
 	if (!xnet)
 		return;
 
-	ipvs_reset(skb);
 	skb->mark = 0;
 	skb_clear_tstamp(skb);
 }
-- 
2.32.0.3.g01195cf9f


