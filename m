Return-Path: <bpf+bounces-26281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CD89D991
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66BA1C22B3D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79112F5BD;
	Tue,  9 Apr 2024 12:58:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2212E1F0;
	Tue,  9 Apr 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667513; cv=none; b=fVHWTHy9tr2Y+MZjXvnD1mNuO5BnH+ICyU6//n7GH/y1XnLgj2HiIHdIOvrX1FaVb8LDsGTOqLCU3s2uCMxVK+VOrOwFg2aAug2QN6M/Od3Tobwoez9z3PufrPCVetPkctGmBOJTA5J/3JZa75122ugdV7s7woUHFflFwpyhxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667513; c=relaxed/simple;
	bh=osqHA7xeMIDaCzNKX6rBX62yOPrRAevaJbKLzTwbsWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNGnNSTF68xmKYKDsIBhdskX4n5o6qZTXDvSF2uHLj1gKrM7FyjuTh8DSUswl3y1aavEUomFqLNYJzyXzte4ubCT2W/6NhQAbnFEtL904nhClRQYNnRGzb49wjmQTbzwyjmZKcdKuI007fJP8TeH3fcIFou8Uatlr5BQAXAY4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516dbc36918so3845464e87.0;
        Tue, 09 Apr 2024 05:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667509; x=1713272309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeyrNbxQo5gOwdkkAEV+0vUgg75RvJ4U5yeN3K4c0b4=;
        b=LFRCwr3iMvsHtXHSDoWOWuu9bHnoIv2msmt3/JG6F+6YmaULCxQJp2CYbTjYa2EjSq
         tPG4O79in+KjSL8Bf3Z8lZXGLSNpR0WLyuZkrscQNMBeSRTSWcPFekqOBSAytCrZP62F
         IzfBUldQ+JdkO46SzP/a0iTH92fc5f6FYXt46PHzIQ5hjTDx8NrNe1yDFQ5QSsVjxirI
         7ctINguiG4PBiUA8dj2wWyCk02bLx6eIshQ5kurRADEJyxGS/m2oapYoQhSzCMMk/NyF
         yMVgYTMu2ZmbJvQxctTzVkHp7TgIoCV9p+jXEOPBQ8dHucbf/Ct+rUl7PjGAzcgQGAXC
         02bw==
X-Forwarded-Encrypted: i=1; AJvYcCUBdBniYTmaC2zR+olY1nkRk7zyo7KrxaWIgY91hZREuP1cRUTJ+ytcIXqjCGL5tLtPs1uV5UiCl4goR5OoYEM9Hrh+5vBL9vMlIOAdoRnl+DFLJy+HxZ0CYmI1dgW8aLwLR2wGzkyIGjTfkQ1QXw06+c54ihA9e2YzIsszAjroTFz2I4o65CN/OrA+vzo9ahMlLDrDvevlk9o=
X-Gm-Message-State: AOJu0YyL8wK8b4aFYzh4x3K/KXFn5sFhPee78iKDvybJ33SNKr7IWbQt
	NJ2JpouNDkKR+6iG8KGjwV2rpkkfiAKQaBKdojkxs9dkq8FgvFFi
X-Google-Smtp-Source: AGHT+IH6XD+fmejUsktY/+7eeYpDSuJZiImwWhbauJPASwZetxxyKDNYTe6x668707j5jS0/7gsbkw==
X-Received: by 2002:a05:6512:499:b0:515:d100:1650 with SMTP id v25-20020a056512049900b00515d1001650mr7312038lfq.57.1712667508768;
        Tue, 09 Apr 2024 05:58:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906448f00b00a51d250a1a4sm2903733ejo.80.2024.04.09.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:28 -0700 (PDT)
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
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v4 2/9] net: create a dummy net_device allocator
Date: Tue,  9 Apr 2024 05:57:16 -0700
Message-ID: <20240409125738.1824983-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409125738.1824983-1-leitao@debian.org>
References: <20240409125738.1824983-1-leitao@debian.org>
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
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 54 ++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c198620ac93..544767d218c0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4517,6 +4517,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
 
 void ether_setup(struct net_device *dev);
 
+/* Allocate dummy net_device */
+struct net_device *alloc_netdev_dummy(int sizeof_priv);
+
 /* Support for loadable net-drivers */
 struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 				    unsigned char name_assign_type,
diff --git a/net/core/dev.c b/net/core/dev.c
index bf0a335781aa..5d2cb97d0ae6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10413,25 +10413,12 @@ int register_netdevice(struct net_device *dev)
 }
 EXPORT_SYMBOL(register_netdevice);
 
-/**
- *	init_dummy_netdev	- init a dummy network device for NAPI
- *	@dev: device to init
- *
- *	This takes a network device structure and initialize the minimum
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
-	 * are they aren't supposed to be taken by any of the
-	 * NAPI code and this dummy netdev is supposed to be
-	 * only ever used for NAPI polls
-	 */
-	memset(dev, 0, sizeof(struct net_device));
-
 	/* make sure we BUG if trying to hit standard
 	 * register/unregister code path
 	 */
@@ -10452,8 +10439,28 @@ void init_dummy_netdev(struct net_device *dev)
 	 * its refcount.
 	 */
 }
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
+/**
+ *	init_dummy_netdev	- init a dummy network device for NAPI
+ *	@dev: device to init
+ *
+ *	This takes a network device structure and initialize the minimum
+ *	amount of fields so it can be used to schedule NAPI polls without
+ *	registering a full blown interface. This is to be used by drivers
+ *	that need to tie several hardware interfaces to a single NAPI
+ *	poll scheduler due to HW limitations.
+ */
+void init_dummy_netdev(struct net_device *dev)
+{
+	/* Clear everything. Note we don't initialize spinlocks
+	 * are they aren't supposed to be taken by any of the
+	 * NAPI code and this dummy netdev is supposed to be
+	 * only ever used for NAPI polls
+	 */
+	memset(dev, 0, sizeof(struct net_device));
+	init_dummy_netdev_core(dev);
+}
+EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
 /**
  *	register_netdev	- register a network device
@@ -11065,6 +11072,17 @@ void free_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(free_netdev);
 
+/**
+ * alloc_netdev_dummy - Allocate and initialize a dummy net device.
+ * @sizeof_priv: size of private data to allocate space for
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


