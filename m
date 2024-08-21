Return-Path: <bpf+bounces-37670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6F9593C0
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B8A1C21436
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 04:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E961662FE;
	Wed, 21 Aug 2024 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V7Dwul5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF10179A7
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216194; cv=none; b=RlYnfobu4jq6yrUJE/iJMY+2fOEJFrXnYHlmmEJpuKLr4MB3Mtg27GYtLhLCzVwafTWhP8VLHDpsOVFyeQfEwFWrhVW3DrcKC/zcRXTeZrythn6gBk8yQloETfIQiv671gkjO/QYkoxpBYN+soK9i+g3hrPvbv/7WkgqZjBIgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216194; c=relaxed/simple;
	bh=s5P37GIKG3G2oO0kyQUYXjGllNocGKKr7kNww5rDLSc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YTczPRUXLjlyV4cdWobQlj/ikTMgcOPnd7LWNxmdPfL/h60G3CggfOQ0cVA+Pi2xIDfwzVAjeEls2gosFfpH4Mc7V3MkzOXtxxdZ9/u4dvIu5ww3pv5o5zjpam9t+7RpkIiiy4G7Fwu+DJCz4BKsa9N4tmNryNo1qHqXi41UF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V7Dwul5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70d1df50db2so412185b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 21:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724216192; x=1724820992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8H8zZJTSLIZA5Kni0eGxHGJpUzBApQQ4vV/yayZ8VI=;
        b=0V7Dwul5eeaZ8FDpKPnpM4Nt8TFN0CALvHABPBFno5Ob+uHsC8gWiIDrJcXH6+52ix
         bJTyulhHgDoAsG+TM1CGl9b9GLLl6/lUQa2BqslI2/g+u6GSI6BIcAMCRCsc6mNwbsbB
         D5mLZ23YkrvvnsG/2QVLDXNPgN/RbukUgDxrEmUWqAbQb2UWQY+5FdaBbiYOWc+cVwpN
         QNAnjDn4aGdW0Gr3jw+fsS5OhYK5MHf3lmmoBrLvL0sW7gpGsM7zDjzdoxsLb5++sbsd
         WOiQNEiKXa5K9lelNQWU9C0dS3AS6gw/9aKXUB+eGpwHFICuRZu2ad7JRbRWvrp4BfqJ
         VLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724216192; x=1724820992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8H8zZJTSLIZA5Kni0eGxHGJpUzBApQQ4vV/yayZ8VI=;
        b=nyL0w1Y7TfNfmsge/glp5F2T6tV4/cvy6jUS36cdlYseSQzknteqcwy3a9IdtYf6vO
         YKT4xEhyFU33cZIZi6JEno++8QJGzyACQRvNTFpEl6fQLSSi5+g39YIUczlwddOzK7V1
         VKakfgHfWFK3JqLtmdWe4F0o4DDb2tqQWA7CkwNzmcEEEwaq1v1j7S4K0Wxo9WFY1Sen
         YRMbAw40xNy7msoclLIYwrQlIn6zbsK9UL4GlNl8gbLI09nE61TLnOQ1uXQbhgIeLnDP
         nzLJhR2ikxacZ/qLCGOT5Zv9Ep/da2uHJNCDri20ocMOFBGvlfAknPxHgUJpQVUwdiC0
         yu1A==
X-Forwarded-Encrypted: i=1; AJvYcCW7Kz1Gj48tzpPcXtWF9c4ftarwQdWq9PrklROPeAy+dH5CS/55LL84Sg1PqJHU5/n1EFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3UjGAOGUsy9xDWUO+OF1yYWsfkmPVk/SJl4Zt8zvpNk3hnAc
	ssh+QGWugPblr7dpZYkTRDKLTF8GH/sLdI4aUxGctj/gPZ7Mv01GDJ0Yqp4OodW+UK237Z501m4
	WwCWWaByNJ/56vpzedlXwdw==
X-Google-Smtp-Source: AGHT+IFh2y500D6uKb4c3MFUUFmM4E7777mmV19vX5QgPa3qn+uNgh1Vax2bsLm5Q0SW4nQDq3/gqZfFU3Z5EFbNvQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:6f48:b0:714:1fad:bd2d with
 SMTP id d2e1a72fcca58-71423f10777mr22515b3a.3.1724216191415; Tue, 20 Aug 2024
 21:56:31 -0700 (PDT)
Date: Wed, 21 Aug 2024 04:56:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240821045629.2856641-1-almasrymina@google.com>
Subject: [PATCH net-next v21] net: refactor ->ndo_bpf calls into dev_xdp_propagate
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When net devices propagate xdp configurations to slave devices, or when
core propagates xdp configuration to a device, we will need to perform
a memory provider check to ensure we're not binding xdp to a device
using unreadable netmem.

Currently ->ndo_bpf calls are all over the place. Adding checks to all
these places would not be ideal.

Refactor all the ->ndo_bpf calls into one place where we can add this
check in the future.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/bonding/bond_main.c | 8 ++++----
 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 include/linux/netdevice.h       | 1 +
 kernel/bpf/offload.c            | 2 +-
 net/core/dev.c                  | 9 +++++++++
 net/xdp/xsk_buff_pool.c         | 4 ++--
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..73f9416c6c1b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2258,7 +2258,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			goto err_sysfs_del;
 		}
 
-		res = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
@@ -2394,7 +2394,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 			.prog	 = NULL,
 			.extack  = NULL,
 		};
-		if (slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp))
+		if (dev_xdp_propagate(slave_dev, &xdp))
 			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");
 	}
 
@@ -5584,7 +5584,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			goto err;
 		}
 
-		err = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		err = dev_xdp_propagate(slave_dev, &xdp);
 		if (err < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_err(dev, slave_dev, "Error %d calling ndo_bpf\n", err);
@@ -5616,7 +5616,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (slave == rollback_slave)
 			break;
 
-		err_unwind = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		err_unwind = dev_xdp_propagate(slave_dev, &xdp);
 		if (err_unwind < 0)
 			slave_err(dev, slave_dev,
 				  "Error %d when unwinding XDP program change\n", err_unwind);
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 4a9522689fa4..e01c5997a551 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	xdp.command = XDP_SETUP_PROG;
 	xdp.prog = prog;
 
-	ret = vf_netdev->netdev_ops->ndo_bpf(vf_netdev, &xdp);
+	ret = dev_xdp_propagate(vf_netdev, &xdp);
 
 	if (ret && prog)
 		bpf_prog_put(prog);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..a4f876767423 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3918,6 +3918,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..a5b06bd5fe9b 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -130,7 +130,7 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 	/* Caller must make sure netdev is valid */
 	netdev = offmap->netdev;
 
-	return netdev->netdev_ops->ndo_bpf(netdev, &data);
+	return dev_xdp_propagate(netdev, &data);
 }
 
 static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
diff --git a/net/core/dev.c b/net/core/dev.c
index e7260889d4cb..165e9778d422 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9369,6 +9369,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+{
+	if (!dev->netdev_ops->ndo_bpf)
+		return -EOPNOTSUPP;
+
+	return dev->netdev_ops->ndo_bpf(dev, bpf);
+}
+EXPORT_SYMBOL_GPL(dev_xdp_propagate);
+
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
 	struct bpf_prog *prog = dev_xdp_prog(dev, mode);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c0e0204b9630..f44d68c8d75d 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -149,7 +149,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 		bpf.xsk.pool = NULL;
 		bpf.xsk.queue_id = pool->queue_id;
 
-		err = pool->netdev->netdev_ops->ndo_bpf(pool->netdev, &bpf);
+		err = dev_xdp_propagate(pool->netdev, &bpf);
 
 		if (err)
 			WARN(1, "Failed to disable zero-copy!\n");
@@ -215,7 +215,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
-	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
+	err = dev_xdp_propagate(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
 
-- 
2.46.0.184.g6999bdac58-goog


