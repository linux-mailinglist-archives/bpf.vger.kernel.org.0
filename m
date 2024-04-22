Return-Path: <bpf+bounces-27413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F78ACCF1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191412811F0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E27150990;
	Mon, 22 Apr 2024 12:39:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01814A095;
	Mon, 22 Apr 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789594; cv=none; b=Fkom5qdy01uIm7lqKinuGAmwMzsUr8rkPTjFFqgo29c8yTqVViXST4xL8dcVNjHWR3w1EQ5KIsDa0D1W8bxJQsFw0Ns4a4T18BEu5CgJqmUYCznpIJzY2sDuJ+5X/IVak7WWArBZIN0niVUnpqxqsEkl64caTO/QpVc/FEw3wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789594; c=relaxed/simple;
	bh=Z+Txdnt9x/7T06GjIU8kHEi+gZvIuRcOQEeUX4DOAak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO+RwTIk9aDbPHoi1LSGeHy+K77e7Q5uN8Pu+xYB17zI39rY4pHKCMV65aNgoF2cCf+hKiARymczCbnTxJKO2TAvPSmCRW/BGsp0Xgdu27ouPbL4qfaP6wOwbH2KkBFGSlYbbBLriTbOLaybyKn7poZ1M894r4gi6RH0opBuJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a55bf737cecso68460666b.0;
        Mon, 22 Apr 2024 05:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789591; x=1714394391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShvXVcuHKM27ZU0oRYsT/Zoz+8yVSDnGcsCzeAiDpLM=;
        b=Z0cjbkLRuWP1OCQq9bjBgyXyRZIRl/ZdvNWrWdy2Ta+wUoIyS9G/Z/57QLe9OZc1GY
         j0Nk6gLRLMYdrByAAv1mbj/mksEM6aW9qjFModXSpIMVApTmCKuTv/Ik8m6+1FUjzGcR
         uM6iRcX90LRC+2vH/GcUuPcAqccm2Zuig64EecQYT12DcV+3p3z8wc9g2FvECiDhfTnW
         UOxkI8yVPegc316x2t9RneFaqEPkUsGv0+st/D66/Ja1vOqpDAHc8FpmBqccxGTomYiF
         TsUXV4mn9nB+/z28DdOgl8AiCaiC7DbqcgWSMga5y2dCxJfYsor1HzqhNqXvw2hDZcYd
         +QXg==
X-Forwarded-Encrypted: i=1; AJvYcCWSsdUcgzzrgPpZ+zTrEB6s/AUhbtnSdwLCx67EI+sf5pACa62yy44TZbrgausFaS4cVnChzbz0djvB0MXYLXPlaoUqK4hw7VhPFK7FcPSQbPyLjJhiVnf8BRt/kZd0gArEmbUglpHN8lVNrNS6ngCGOipKVqJ8vE181rVGwMOtEpGu2SC61NDnzd4yKmVFZoneX+WLKymBCOg=
X-Gm-Message-State: AOJu0YxqoUJGZ65mtgRv960E1rGP/l5rxLFlLE3fSY5/9xp/LyCaG2CA
	aZKXZUukAVRDN6KrKuYZnlp64YawIaMpxBMA1BaEQnlbvS0y1dyB
X-Google-Smtp-Source: AGHT+IGHXbG42TBUs2qM4JFDBLm1Sczss7RLzeg45Q/pfNGgTnWOgk3VY3uvoEjCD/lPGpvH1Ft/ig==
X-Received: by 2002:a17:907:94c5:b0:a55:9e16:f005 with SMTP id dn5-20020a17090794c500b00a559e16f005mr4187823ejc.57.1713789590608;
        Mon, 22 Apr 2024 05:39:50 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906361700b00a56c0866c71sm419551ejb.69.2024.04.22.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	geomatsi@gmail.com,
	kvalo@kernel.org
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v7 03/10] net: create a dummy net_device allocator
Date: Mon, 22 Apr 2024 05:38:56 -0700
Message-ID: <20240422123921.854943-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422123921.854943-1-leitao@debian.org>
References: <20240422123921.854943-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is impossible to use init_dummy_netdev together with alloc_netdev()
as the 'setup' argument.

This is because alloc_netdev() initializes some fields in the net_device
structure, and later init_dummy_netdev() memzero them all. This causes
some problems as reported here:

	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/

Split the init_dummy_netdev() function in two. Create a new function called
init_dummy_netdev_core() that does not memzero the net_device structure.
Then have init_dummy_netdev() memzero-ing and calling
init_dummy_netdev_core(), keeping the old behaviour.

init_dummy_netdev_core() is the new function that could be called as an
argument for alloc_netdev().

Also, create a helper to allocate and initialize dummy net devices,
leveraging init_dummy_netdev_core() as the setup argument. This function
basically simplify the allocation of dummy devices, by allocating and
initializing it. Freeing the device continue to be done through
free_netdev()

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 56 ++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d45f330d083d..f849e7d110ed 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4519,6 +4519,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
 
 void ether_setup(struct net_device *dev);
 
+/* Allocate dummy net_device */
+struct net_device *alloc_netdev_dummy(int sizeof_priv);
+
 /* Support for loadable net-drivers */
 struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 				    unsigned char name_assign_type,
diff --git a/net/core/dev.c b/net/core/dev.c
index 62b39d6b1d8f..e09aa3785c15 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10420,25 +10420,12 @@ int register_netdevice(struct net_device *dev)
 }
 EXPORT_SYMBOL(register_netdevice);
 
-/**
- *	init_dummy_netdev	- init a dummy network device for NAPI
- *	@dev: device to init
- *
- *	This takes a network device structure and initializes the minimum
- *	amount of fields so it can be used to schedule NAPI polls without
- *	registering a full blown interface. This is to be used by drivers
- *	that need to tie several hardware interfaces to a single NAPI
- *	poll scheduler due to HW limitations.
+/* Initialize the core of a dummy net device.
+ * This is useful if you are calling this function after alloc_netdev(),
+ * since it does not memset the net_device fields.
  */
-void init_dummy_netdev(struct net_device *dev)
+static void init_dummy_netdev_core(struct net_device *dev)
 {
-	/* Clear everything. Note we don't initialize spinlocks
-	 * as they aren't supposed to be taken by any of the
-	 * NAPI code and this dummy netdev is supposed to be
-	 * only ever used for NAPI polls
-	 */
-	memset(dev, 0, sizeof(struct net_device));
-
 	/* make sure we BUG if trying to hit standard
 	 * register/unregister code path
 	 */
@@ -10459,8 +10446,28 @@ void init_dummy_netdev(struct net_device *dev)
 	 * its refcount.
 	 */
 }
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
+/**
+ *	init_dummy_netdev	- init a dummy network device for NAPI
+ *	@dev: device to init
+ *
+ *	This takes a network device structure and initializes the minimum
+ *	amount of fields so it can be used to schedule NAPI polls without
+ *	registering a full blown interface. This is to be used by drivers
+ *	that need to tie several hardware interfaces to a single NAPI
+ *	poll scheduler due to HW limitations.
+ */
+void init_dummy_netdev(struct net_device *dev)
+{
+	/* Clear everything. Note we don't initialize spinlocks
+	 * as they aren't supposed to be taken by any of the
+	 * NAPI code and this dummy netdev is supposed to be
+	 * only ever used for NAPI polls
+	 */
+	memset(dev, 0, sizeof(struct net_device));
+	init_dummy_netdev_core(dev);
+}
+EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
 /**
  *	register_netdev	- register a network device
@@ -11080,6 +11087,19 @@ void free_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(free_netdev);
 
+/**
+ * alloc_netdev_dummy - Allocate and initialize a dummy net device.
+ * @sizeof_priv: size of private data to allocate space for
+ *
+ * Return: the allocated net_device on success, NULL otherwise
+ */
+struct net_device *alloc_netdev_dummy(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "dummy#", NET_NAME_UNKNOWN,
+			    init_dummy_netdev_core);
+}
+EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
+
 /**
  *	synchronize_net -  Synchronize with packet receive processing
  *
-- 
2.43.0


