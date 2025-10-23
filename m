Return-Path: <bpf+bounces-71878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA7C000CF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCFC189B9B9
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C7304BAF;
	Thu, 23 Oct 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKtiwkt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535D2FAC0E
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209934; cv=none; b=uiLzCVfinn1r6U22FAbFxIEwPH1ynVCb9mnH5b6hItcCuPAfurm/n8fWnAaScfZ99UVd57wNlTSfEVMMrvmQqfhmjCvX+hl46wWK7paRoitLNEQn5qG19itfJc8mePkMp8XHUVXO2bf81cpRKpkLwGu6GT4ZWux5R7Z2OG93D3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209934; c=relaxed/simple;
	bh=7+QdE7u95F2srOVEyYJsJ3K+vNzuW01jxQiAAFCgJZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gM/4+IgfQVgxsUGYdg0UAVcCQuABl5xVWgSF+C3eK5N9R1sLsgKvXRBAgAHNdP/6Bpc9ugA2DPE2Xp2yNXnIEjXuJqHIw+H7Fq47eaSO+OXb1eHZC3zchHGtg4EJ4/w82v08DFKCfsa1LHLBpYIjKJF7hYbrXDuCToWBWITPuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuKtiwkt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27c369f8986so4594705ad.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761209932; x=1761814732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RU4IedZsSTtJdpKj+rxbznt86HzuF4sa6O2zsfwDOE=;
        b=FuKtiwktcS/S7+3zUX0bzd8Q8g5y6mHRuzHm1yznUrcCfZ47HXJzwjmEPk9wj4t5bW
         NQYLWhMNGD5/RBwczLZDZ8ydsrfXu/yXwEwa5lqhbolwVo4WVmJ7P4/3HusNOcATsB7E
         OEAntUXDb/ZeEa/euj96kX7QDpcAtYkMAgAk3FF6efxReQIBSOaKHmW62MgD+G0vgxdy
         38IFN9DuXPJulAngtsMy/+GXatrtdpAT9RYDggdVxLBvcvzIq7j5qT+OIXiXwTB8R46y
         YqEzK5tHMXVywrBrPXEcM7h9LsvmyS9P0YDPvCos2cRXg1XkO/VH+VNZ0SnrOywKkWyq
         6leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209932; x=1761814732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RU4IedZsSTtJdpKj+rxbznt86HzuF4sa6O2zsfwDOE=;
        b=LatE2wksC7yjpXSfIbQSG/98KkR2Zqcax69hQeymAZmcp9PCBXsw70T/pwVYYC0NIl
         bUNvX62S2jNjf8yDFoDyrOG1Ds8lS3vE6ifYuGIbsANP+IdeRHPVEigqHatUxsTNAKmM
         V2ZIfb59TFqKOeYLGGQtdKGFsLhHrWXHXBeE2wlP1kurNvXfcy9NUOhaoyVOOWNaTdLL
         kQMMhF76A0EFwp0myepe033cbx80O1X4TXqS7RrjDTOL45yCkyG/yw77Oo+ztqxIoOZ0
         09xq5wIp6YOCKz83hor8/nK/XD2pc3fEGnl5jXT1PImy59R1MYOXXMsIqY9ZncQUwP/n
         PvqQ==
X-Gm-Message-State: AOJu0YyueIC7NWhFU8e4qFzNNCHd851j/37VEbsY++Xiw+bzkyDasdw+
	poHCO8Kox+szzbwC1WV2rl/eiDcP0Cv3rjCMhvPeur3bbAvdyjyCIB3m
X-Gm-Gg: ASbGncuwK+bcitJQmrhQQrrx6MEPCtAypvGes+WjxTq04ygM4zVdULhA6QeiwkgtmN0
	vkSmg2eyX05MvG7ipiWMrrTOTkSyN9k+sOLbpLXFVNrahZMkmSjXq+vaFhtJgSzYbr8C6wDVi8+
	6PtS4o++4Rc+D4EgRonWU4ZpGedyhlBPhYA5tHBowDO+WCKrJ0Om2mQfgE9MpDZ8pbZ0FeRa+9a
	h9V6WUo8jTjhfWsxwi5w2jQzTSZ4yrABYNfRo8Wk2MS6u9KhQ5qRXoFpSL+09RY2r76D7w5D74k
	oDXBHB0aOFuSHqXX5W5vCs7Kw8lKo7xNcLpJgbGyb+v+DF1qRtJSxzCF6qpzv02iKi3gnfpl5lR
	kdcnLly/y185FWu1+vFp7tz86krQZ66zvsPaShfM2Y3VOeT3O51PziQZhscHBuQ5y+6+Gdh2CrF
	hVhhSNkyZJqkGDcQG4wQiIkdu0kL69foj3QZ4UshYKYFUris232T9FUo8huwLg4sF4wubQk2Dr
X-Google-Smtp-Source: AGHT+IEVUoymZeiSVlE/Uk+XC59V5IvcJHH/cBg60zVNVyFpWSnT3ANMTmgq33TFbobFjHJXmeQC8A==
X-Received: by 2002:a17:903:2990:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-290ccab59b1mr303357615ad.59.1761209932109;
        Thu, 23 Oct 2025 01:58:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e12d6asm1448513a12.21.2025.10.23.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:58:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next] xsk: add indirect call for xsk_destruct_skb
Date: Thu, 23 Oct 2025 16:58:43 +0800
Message-Id: <20251023085843.25619-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric proposed an idea about adding indirect call for UDP and
managed to see a huge improvement[1], the same situation can also be
applied in xsk scenario.

This patch adds an indirect call for xsk and helps current copy mode
improve the performance by around 1% stably which was observed with
IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
will be magnified. I applied this patch on top of batch xmit series[2],
and was able to see <5% improvement.

[1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
[2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h | 5 +++++
 net/core/skbuff.c      | 8 +++++---
 net/xdp/xsk.c          | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..431de372d0a0 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -125,6 +125,7 @@ struct xsk_tx_metadata_ops {
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(struct list_head *flush_list);
+void xsk_destruct_skb(struct sk_buff *skb);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
@@ -218,6 +219,10 @@ static inline void __xsk_map_flush(struct list_head *flush_list)
 {
 }
 
+static inline void xsk_destruct_skb(struct sk_buff *skb)
+{
+}
+
 static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 					    struct xsk_tx_metadata_compl *compl)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4bc8b1c7d5..00ea38248bd6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -1140,12 +1141,13 @@ void skb_release_head_state(struct sk_buff *skb)
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
 #ifdef CONFIG_INET
-		INDIRECT_CALL_3(skb->destructor,
+		INDIRECT_CALL_4(skb->destructor,
 				tcp_wfree, __sock_wfree, sock_wfree,
+				xsk_destruct_skb,
 				skb);
 #else
-		INDIRECT_CALL_1(skb->destructor,
-				sock_wfree,
+		INDIRECT_CALL_2(skb->destructor,
+				sock_wfree, xsk_destruct_skb,
 				skb);
 
 #endif
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..8e6ccb2f79c0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,7 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 	return XSKCB(skb)->num_descs;
 }
 
-static void xsk_destruct_skb(struct sk_buff *skb)
+void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
 
-- 
2.41.3


