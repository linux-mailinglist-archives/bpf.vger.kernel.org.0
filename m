Return-Path: <bpf+bounces-52242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B039A40555
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 04:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6757AD7A8
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C570200BB7;
	Sat, 22 Feb 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vyr1QMvV"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03E73451;
	Sat, 22 Feb 2025 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195327; cv=none; b=t0EXWuqyj0rFJ8UpiZzzRVScqlp8kTUSZDeWE0CUPE0jA2IzePK+q4vBmRG7OlKRea16W2LN1pWkGWOl4x5MYdZHLz9IB81yqpq3soORNNpOoobPYxavl5c+vETfA/im5nsYMIJf7I+YqnYTkTJ2Ikbto0H9UBLYKs8rrly2MxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195327; c=relaxed/simple;
	bh=UfNEQhaOfcsBz/l7aTWpL0VyhHpupn3MMMh+IBNC3ME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nr+dXV8b/RGW/XCZAJxyJRgGegwj8yiRrBbl8JDDWpgJ78KLhvUhqjjVn/8jnxYGrVo+p02fx3Z+V05nQ12Hhlm+PmFfs8Uhnj/WIcSI0UtOhK3Y66vZ/Gkd4WbUW/CipG+pgyjC5/Mps6njubwvx4mxdRJhSRfrN8W3doz17nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vyr1QMvV; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740195320; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QseRo1Hoqzm/Lf0FQlgigvtxzlppyz6GuTPwZfMxTeo=;
	b=Vyr1QMvV5M8UMRzzwRMICNRvtgVxFzF2SckOZ9/P6aAqqauI7tUakyUjFA4nuDjP4AHIPKGac3nga3ksArXa6U30/hyM+qzm3jIuVlo70aTZw2PUzVM4YTPeQQCGT+Z81FsHYyjTP3WaR0USVm5sgO/LlhLBKJecsLhE8QqIe9k=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WPyLyfs_1740195318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Feb 2025 11:35:18 +0800
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
	ja@ssi.bg,
	horms@verge.net.au,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 net] ipvs: Always clear ipvs_property flag in skb_scrub_packet()
Date: Sat, 22 Feb 2025 11:35:18 +0800
Message-Id: <20250222033518.126087-1-lulie@linux.alibaba.com>
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

Fixes: 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when SKB net namespace changed")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
v1 -> v2:
 - Add Fixes tag as suggested by Julian Anastasov
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


