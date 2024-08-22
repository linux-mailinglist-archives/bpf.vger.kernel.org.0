Return-Path: <bpf+bounces-37822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C495AD0F
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 07:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8051C2294B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143B6F099;
	Thu, 22 Aug 2024 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3pMlWgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FB36AE0
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305943; cv=none; b=fW+5PYwzZ6wtd6W8YRfnhdvSjQeJTjFYY9XGKZSVzYQfQu3M76u9kiONkQhy+549+6DVZK6OXX40H86GwXqMH9F0DQam/gdvAtXzpMsqin1ih0yOFHI3dDh6tjjAiBYreglT8A9Km4GsAeyURIWhU11z6qArwOH7DvoCF3+hyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305943; c=relaxed/simple;
	bh=ZDPRDTlLhRB8Ca5AowgVDx3jfAvGtbwAcPsMhXtWWrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kKN39GVtXzEhKlEOgDgX08NW+zfff1++pz1tmrNwL23LQ6GRLLTPuEmhu5ma9K6kbrb7PBINgGRGgz/uHitF/MWQ+YzQ3jU4ojgYAELBEn+QBHKt7QoARvJIlfeD/5eW55XnCfjeKnxFUETUUfPAn2iSSVi9IANWH6jcU3XKBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3pMlWgg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11741a4c92so718663276.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724305941; x=1724910741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=04JaEmUuzFfbKL4CGnL5ZC4xtx6kxsSTreaHJ5A6DDg=;
        b=U3pMlWggtRE4AjLO2WvUhyfWMSX5BadmYCADPoZ+t9FX5BK8DN0xwd5sttY3g+qv3G
         MKTa+AtPxSELwZoNkLCHPXkyD5lWaCcxcfcGVKKBNXz9pSj8OsybUBSafOOPy+/YF4iR
         rJ7m3tUC2aSS0qsLJ3NckU1H8n1Fr07piNgysdxbQlP5al5vCvu+Uws6lCbn1OZvWmfz
         Gx3xLDI+2Mmlvb41JpiT/MAoH73tkNuv+LGxC0o3KYEVqFQJPIF+9U9M3P4gUWRl4lLs
         BvQ5Bjv7RHrROUh9MoF27RlsFdMp4voQCIkjQIG9D3Iv0E+asD9c1MwbAHsOLcyYpBqP
         IQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305941; x=1724910741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04JaEmUuzFfbKL4CGnL5ZC4xtx6kxsSTreaHJ5A6DDg=;
        b=d5ozgzsucAOny6Fhkq7CAQW6+lq8zdYBDaI5je7b357SJIZNev8uOYmq3KBieoh87l
         fBAP8CD9IxMes2P4TowJ6l6JPKUXJiYNUjU0ZTsEFeWGpITomYCmNQiz0I3tuOIGtYA0
         6nhOWHeOhhgiH1bnmROCKEVPqTd8eEbsIqTNshGjSSLgaMKB+bIskW22thC9sVNUdFYV
         not2/IuxnB1lDPJf26HpySEwmUSyiOVL/8eQhreII3vkhYyPUruZAnhv3/YXVa52NLoE
         1SXuPnUQfZcViq/a0ipyt8sedo12EmkXLm1ZXFE8dVlFzxE1fJEuyC39mQXrAA1m12ME
         VPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrU4wTCY7+itTA/NlyYUS+Rvmkmf9/B+7xz48k/07SJ6riHtVx8kWhBJAUMSheyhqli38=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJsKg98MM3n1ZYTBHFWG7Yb/dACfMGDEJPHpOQYxm7rBvTnIj
	8gLwGRj1xAg4ZVBx5Qtp4Dl/Ez7WKgPhD22SEM80xi6I/whKYOYeLTNBiDTDsOYMpSJGNz8jXax
	lZNDx4MxA4rTtGu4T2q3UXA==
X-Google-Smtp-Source: AGHT+IETrPBlj0Tv3ojSIAQFzaGbRbQ3B+XAZxSguR7Lp9ncSuSBoJfqKynKHzdekC+vdVaJRzY63BBhLOJMi+USHg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1370:b0:e16:5303:7bcc with
 SMTP id 3f1490d57ef6-e166553ae90mr12157276.10.1724305940891; Wed, 21 Aug 2024
 22:52:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 05:51:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822055154.4176338-1-almasrymina@google.com>
Subject: [PATCH net-next v2] net: refactor ->ndo_bpf calls into dev_xdp_propagate
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When net devices propagate xdp configurations to slave devices,
we will need to perform a memory provider check to ensure we're
not binding xdp to a device using unreadable netmem.

Currently the ->ndo_bpf calls in a few places. Adding checks to all
these places would not be ideal.

Refactor all the ->ndo_bpf calls into one place where we can add this
check in the future.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Don't refactor the calls in net/xdp/xsk_buff_pool.c and
  kernel/bpf/offload.c (Jakub)
---
 drivers/net/bonding/bond_main.c | 8 ++++----
 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 include/linux/netdevice.h       | 1 +
 net/core/dev.c                  | 9 +++++++++
 4 files changed, 15 insertions(+), 5 deletions(-)

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
index 614ec5d3d75b..f0ff269ce262 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3923,6 +3923,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
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
-- 
2.46.0.295.g3b9ea8a38a-goog


