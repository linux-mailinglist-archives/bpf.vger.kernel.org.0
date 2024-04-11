Return-Path: <bpf+bounces-26529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506BD8A1674
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1E71F2368F
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1DD1509AE;
	Thu, 11 Apr 2024 14:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106214E2C5;
	Thu, 11 Apr 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844024; cv=none; b=ULvJ8Rdme/nIM5uO3wVB3t6z/2aAprXc7OSk8D3UJQmX3d0EH6h0OOJeYRBz471ICSeaAhtDYHGjLeLvaIwHEsGWtDVzJKF6bMPGGp6pLhn2uvxtZ4vmvQV/eUtpQ0M4tOE2pdRm5RQdfGcymcnMVACHU+vyJ9Jw9NeF4PkZLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844024; c=relaxed/simple;
	bh=mpHu4d4Q4JeZIMZ5puvyvVG8jptaMTEuga2ont41Wdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhedyc3BGLvlZZ1QmMRB5VBealgK9dMIoiZb+jUC2N5Asjyhbt+adJuflnA9fJQqD+/dpAvkIL4/ivuvL4HYIQgIanGnqkgha3znm5Kkjv1uvgeJny2SKfRbP28pgKbGDEhxg2o4gpQKPIoDHg1f64qZeGbAboGNUA7coMa5GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so5418675a12.0;
        Thu, 11 Apr 2024 07:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844021; x=1713448821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GDpaKQ90WYO0sLid+cb+1t26hG02cHYGSR1vXVItmw=;
        b=iW5Jb/gkSqWcjpGuQQ0GHGStOysXQOfhd1n1t7yF/XQpYsl3CG2qZRH/U29ME0//tE
         wKBzshEtMJO9EyJKsVrtCYO5tUiE+jg+fUwyF7f04weuECOgZurtRsnGDNiJzf6MNcSA
         7GmWxAuFQ27x9k36LSF06tiqeOu48lwb3fwjU1ZlW5rjKXpOar47M0D5YFxojhJTJw59
         ibd/i48ziuR/uakoEBmRhIiv60SN0FQAx1PEwy2HEn9ng9ZcnY2DmLbgpbJtqDETwZMn
         EBNaqQDOA+QXe/P4uOEgzk80G83uyFJ5LnPqSib4arbVtEh1MjmgJYCoRzxYAym6YZ7h
         /OCA==
X-Forwarded-Encrypted: i=1; AJvYcCX4CDTll29xIsNc4V7Cgma2uCle+IU4N4EuyCUpHpKim5+iBAI9NN0rGus4uRCh9dPzakBXBjWNRsisGIG6il/3oOVT6ftjcaBMDnt/85gmDHk3FluLpGLL/wBG10hyt062AunynVamD1qSJHq2pOGfOmgOHWy+/63qioroJ2CPsAP3IaN7MHZCKEu6RN3CsHH3t3jKh4cYjm4=
X-Gm-Message-State: AOJu0YxOvpmEYTWHRT1vxCJpDNe7Nre2gpquNPGOU9r6+ezo0y3BqEWZ
	PHFPSemy9KEX00KC/42h0cJHRgnwG9MfP5HJRAGGURTgy9QeYOKOE6tWqw==
X-Google-Smtp-Source: AGHT+IFQB7CTD5vVZVKJvYchQtBMUSZkhyhJfcrxmoTEhqiVxx5mJf3J2kvOSx8nJClwvF+BlqBtkw==
X-Received: by 2002:a50:9fc1:0:b0:56d:f00c:2b13 with SMTP id c59-20020a509fc1000000b0056df00c2b13mr3238272edf.32.1712844021389;
        Thu, 11 Apr 2024 07:00:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id i29-20020a0564020f1d00b0056fe8a3d7d3sm597256eda.8.2024.04.11.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:21 -0700 (PDT)
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
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v6 03/10] net: create a dummy net_device allocator
Date: Thu, 11 Apr 2024 06:59:27 -0700
Message-ID: <20240411135952.1096696-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411135952.1096696-1-leitao@debian.org>
References: <20240411135952.1096696-1-leitao@debian.org>
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
 net/core/dev.c            | 54 ++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 18 deletions(-)

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
index c74b42bc6888..417abfd12871 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10414,25 +10414,12 @@ int register_netdevice(struct net_device *dev)
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
@@ -10453,8 +10440,28 @@ void init_dummy_netdev(struct net_device *dev)
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
@@ -11074,6 +11081,17 @@ void free_netdev(struct net_device *dev)
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


