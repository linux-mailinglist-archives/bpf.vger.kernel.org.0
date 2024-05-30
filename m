Return-Path: <bpf+bounces-30932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94338D4AB1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56436282585
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F14174ED4;
	Thu, 30 May 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yrX8G/+r"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79017836F;
	Thu, 30 May 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068253; cv=none; b=fX18eq9IcqCgY4ubUJcEFmkxyj8zBi/uAzSFLOfWzwQmhYnlDs7yTaxyEG7nlK/rUfGkV/tYUXu4FMvMQ2vr9S8cW/d0EEVCM2BYBenwFRzPYvNCG0PiR5ukGd7Ne+reh6M3HfWa7jf2yZYMwRbWrFl9HeWtzOvqT6Of9UmunU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068253; c=relaxed/simple;
	bh=Fi7/c7g+puHUQ1OYntO/NDOhQoKSgiLQU1LT5HSrXzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QX03fzkfOT3JoeIFwHBNjt4iWI88owa+AoeXaayPKwqRvJrTsG1T48jBK9U85DjxjYMthkjbGcjhUDKe1iKHkmbTbkSoVU0MWo6uGlobCdCfSQUrWQp8EMEwV0Rdhj5rr/BW/7zNR8OZydXudpRHWGRiTjN58xuGzNRsntirgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yrX8G/+r; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068248; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OV9DEz92e7vXkROotTgqBNRUWlum5/QNgAsRioLqDwA=;
	b=yrX8G/+rxtwIVNRXdPSi7BVWs0G4EVRVvsZmifUWZYIZUJ8doX0WzGab72VMDvgfiGnoNaiR3KrjFmwFIFPizGTs7sMPVRhYCeP9dxuNsKT96hFuTN9Vg3vfYADrYd1NsfbfzV8TkCobogU7awDtcoWiGBUxz8RenVEWvPY3Lik=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WnmkS_1717068247;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WnmkS_1717068247)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 01/12] virtio_net: independent directory
Date: Thu, 30 May 2024 19:23:55 +0800
Message-Id: <20240530112406.94452-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
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
index 27367ad339ea..e426fdbaacb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23776,7 +23776,7 @@ F:	Documentation/devicetree/bindings/virtio/
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
index 13743d0e83b5..505385d7f6b7 100644
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


