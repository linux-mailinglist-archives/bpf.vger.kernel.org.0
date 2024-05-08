Return-Path: <bpf+bounces-29040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FB8BF803
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374EA1F23383
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039784594A;
	Wed,  8 May 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H5h5FW9e"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357103D996;
	Wed,  8 May 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155525; cv=none; b=mzV0TBIkIvhW4ylK2IcMVRyECIWPDkIDepmStl8yp+q9PT7Z559KSJ0v+1wWa/9hS1DqT7FFo9KjbEkb6Q24k05dgpoqYpRv99xFz7qvrBuiobn5781WYlO4IJJncHaxI6R260L/237WLpraOmSwcWiiUnJ63wCPt1gb7Pz++2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155525; c=relaxed/simple;
	bh=1K0nNQgHUmhCQQud9QmWgPa8j3wkF2GJA1yDKVZTcCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0Aq3qmU2fezUhFUO20MkykNL7e9VlEpfJNQuc9cJI5LBJyWA4dPvIWVqigxU8weiXvvKsYltJXOib9U5vtNSd3kfKJ1R+A5IA6PyPjH7N/YJ/pe4ypq77BDUxeWMhbFUlGCxSrkbAoRNT91poq0dCXHhnhFLSmyToVo93rzrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H5h5FW9e; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155518; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AO7Rn6OtrHdAVvLcDKsYGgcK+Ff9asY2tSYZHaN9CRc=;
	b=H5h5FW9eDYRnlLEBcUhUFc2A8RCu8hyZxWDKdB3c8S8gTeKq7C5BbLOqz3PfbWGKHYKlR1l5aYMVsTABx0J8k6eER3S7/qCiyeTT6bpohCKG1xn80SreBCJYjBQZiDDIq78WX0/U+UiUmIV1dyEIaAPdcVbKJvlxQldEAwom9CE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62slys_1715155516;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62slys_1715155516)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/7] virtio_net: independent directory
Date: Wed,  8 May 2024 16:05:08 +0800
Message-Id: <20240508080514.99458-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

Create a separate directory for virtio-net. AF_XDP support will be added
later, then a separate xsk.c file will be added, so we should create a
directory for virtio-net.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS                                         |  2 +-
 drivers/net/Kconfig                                 |  9 +--------
 drivers/net/Makefile                                |  2 +-
 drivers/net/virtio/Kconfig                          | 12 ++++++++++++
 drivers/net/virtio/Makefile                         |  8 ++++++++
 drivers/net/{virtio_net.c => virtio/virtnet_main.c} |  0
 6 files changed, 23 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 294e472d7de8..56c50e512c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23457,7 +23457,7 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-F:	drivers/net/virtio_net.c
+F:	drivers/net/virtio/
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..b80793a0bd17 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -443,14 +443,7 @@ config VETH
 	  When one end receives the packet it appears on its pair and vice
 	  versa.
 
-config VIRTIO_NET
-	tristate "Virtio network driver"
-	depends on VIRTIO
-	select NET_FAILOVER
-	select DIMLIB
-	help
-	  This is the virtual network driver for virtio.  It can be used with
-	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
+source "drivers/net/virtio/Kconfig"
 
 config NLMON
 	tristate "Virtual netlink monitoring device"
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 9c053673d6b2..9d31802cc3ba 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_NET_TEAM) += team/
 obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
-obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
+obj-$(CONFIG_VIRTIO_NET) += virtio/
 obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
diff --git a/drivers/net/virtio/Kconfig b/drivers/net/virtio/Kconfig
new file mode 100644
index 000000000000..e162535ca213
--- /dev/null
+++ b/drivers/net/virtio/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# virtio-net device configuration
+#
+config VIRTIO_NET
+	tristate "Virtio network driver"
+	depends on VIRTIO
+	select NET_FAILOVER
+	select DIMLIB
+	help
+	  This is the virtual network driver for virtio.  It can be used with
+	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
new file mode 100644
index 000000000000..c4602337c78c
--- /dev/null
+++ b/drivers/net/virtio/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the virtio network device drivers.
+#
+
+obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
+
+virtio_net-y := virtnet_main.o
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio/virtnet_main.c
similarity index 100%
rename from drivers/net/virtio_net.c
rename to drivers/net/virtio/virtnet_main.c
-- 
2.32.0.3.g01195cf9f


