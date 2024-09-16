Return-Path: <bpf+bounces-39997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F17979F0E
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCAD1F22BC9
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAF1509B3;
	Mon, 16 Sep 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbjfP299"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFF14C5BE;
	Mon, 16 Sep 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481663; cv=none; b=aIc+GPlvnXrM/xLVZrrivGoFLWUV91U0mGFC25Tm2k7u9Ep6wMG6JwptFHiwTSmhn+tu/F9+vCzNlAubsW45xZ/dhIkdzZO8Q9mfTxCWEHgCT2fw40Y8LK6SSE3oFAhDHGvpDdyu3DxZyRr9zaujMmLVz/3L45ARyscAX55Zako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481663; c=relaxed/simple;
	bh=WzkrBChHJ36YKRbBm353jn1KFaPOZmb/kSOGEjd9Rqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOlzusu3GCQdGtq6jJi0TH83HFmHOLdq9YGnYZBvHy1iK7o4LV+BCtStcXDAAX84uURu+C7FBbum8n4fyTpO9N9cX+76G9Boa17HOaA+BU4vinLv3Z3GjtWSEXJ1yM5qMgmL6e5JJRBdkCixcRZ0j17s7zMZOXoe1r0k7S3mhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbjfP299; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECC4C4CEC4;
	Mon, 16 Sep 2024 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726481662;
	bh=WzkrBChHJ36YKRbBm353jn1KFaPOZmb/kSOGEjd9Rqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbjfP299ot5pJWGIn35Nqjl/g6lw5tDCeamfZ1NEmWI0QMztgcViEAZZw5YfSWfP+
	 /52Z8J5hsvtX7fvXpVqXFat2H/kvw/iKlO2MCNxuZc0nornmsCRwK3rEowGL/PEBWN
	 VLB3Me5EJA5/jy24dXqDU0fRJVqttdQHHsocZRYga6gmzLXhNvrHeMDX1cdCDufMfM
	 qJN1avJRTRSzlwe6UaeYJC+kAVQQwy0wqv8om58OX81gqSDAZ8ajlcWg42k0eBbUae
	 +Wv7m3QfBojEtpkfxD/jXw8ZhuPXuuE1JdhisGEcvL5iLjQfHpKfVoZwQLMsPBoVjb
	 nQqvQRMH/dZtQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	dxu@dxuuu.xyz,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	lorenzo.bianconi@redhat.com
Subject: [RFC/RFT v2 2/3] net: add napi_threaded_poll to netdevice.h
Date: Mon, 16 Sep 2024 12:13:44 +0200
Message-ID: <c7c77fe51a64747d964a2205e7172c0f7ce560f4.1726480607.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726480607.git.lorenzo@kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move napi_threaded_poll routine declaration in netdevice.h and remove
static keyword in order to reuse it in cpumap codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c4c3ae2170f0..3bf7e22965cd5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2628,6 +2628,7 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
+int napi_threaded_poll(void *data);
 int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
 		      int (*poll)(struct napi_struct *, int), int weight);
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
diff --git a/net/core/dev.c b/net/core/dev.c
index c87c510abc05b..8c1b3d1df261d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1417,8 +1417,6 @@ void netdev_notify_peers(struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_notify_peers);
 
-static int napi_threaded_poll(void *data);
-
 static int napi_kthread_create(struct napi_struct *n)
 {
 	int err = 0;
@@ -6922,7 +6920,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 	}
 }
 
-static int napi_threaded_poll(void *data)
+int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
 
-- 
2.46.0


