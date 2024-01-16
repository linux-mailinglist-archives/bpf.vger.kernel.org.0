Return-Path: <bpf+bounces-19572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6182E98E
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 07:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0561F23A81
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4AA11703;
	Tue, 16 Jan 2024 06:28:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A111BA;
	Tue, 16 Jan 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-l-s8x_1705386525;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-l-s8x_1705386525)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 14:28:46 +0800
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
Subject: [PATCH net-next 3/5] virtio_net: independent directory
Date: Tue, 16 Jan 2024 14:28:40 +0800
Message-Id: <20240116062842.67874-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116062842.67874-1-xuanzhuo@linux.alibaba.com>
References: <20240116062842.67874-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa067ad3645b
Content-Transfer-Encoding: 8bit

Create a separate directory for virtio-net. AF_XDP support will be added
later, then a separate xsk.c file will be added, so we should create a
directory for virtio-net.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS                                 |  2 +-
 drivers/net/Kconfig                         |  9 +--------
 drivers/net/Makefile                        |  2 +-
 drivers/net/virtio/Kconfig                  | 12 ++++++++++++
 drivers/net/virtio/Makefile                 |  8 ++++++++
 drivers/net/{virtio_net.c => virtio/main.c} |  0
 6 files changed, 23 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/main.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39eb0a6a2927..71a41b04ab6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22995,7 +22995,7 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-F:	drivers/net/virtio_net.c
+F:	drivers/net/virtio/
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ca0bc223b30..a14ef645aa01 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -430,14 +430,7 @@ config VETH
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
index 7cab36f94782..a205dd2be77e 100644
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
index 000000000000..15ed7c97fd4f
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
+virtio_net-y := main.o
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio/main.c
similarity index 100%
rename from drivers/net/virtio_net.c
rename to drivers/net/virtio/main.c
-- 
2.32.0.3.g01195cf9f


