Return-Path: <bpf+bounces-68995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD99B8B68F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAFD1C84D12
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCCB2D3230;
	Fri, 19 Sep 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A5ZSs+Fm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C435942;
	Fri, 19 Sep 2025 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318711; cv=none; b=d8V337KZ7wQwGy7gvpZZBbLk15DD0336drmvkpKbHt3vA25xNUaGvNxJGh4DPrNxc15cgilviI6w+5LhK/YY/IshjG7aXEqiKf2AGVrKPkMSeRrJnkcm7GcgWzXmG6TFIBkYIAbKmWlNEyQsO3dxmvAwOB0cLo7+1pLXoQQkGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318711; c=relaxed/simple;
	bh=XpRAjFWiMbnLBylD4kIvXcmEQK9LmPo36RvBqQ/eAXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laYRS+MtvnxV7fj4Our7fGrJDKy5f6AjLAbe/1VxH263Vgvlz1MemjhdREhPojmhNplJ3tRnLkEotG+E6SdtN+4YPoVX4C+0l11S6aXACu7xNqdWBEfZUPcb2vL/Hr8SA4hNdJhgxP4cD0SgNzkDPG7li5rycf/vGh14yMp0Ddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A5ZSs+Fm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jc5PGH0EiyDi6xMPYH23nO2Xi3HCzGq+3jFp/xWZibg=; b=A5ZSs+FmVdg13I1QRwyqqQAjMT
	PsXAJd8sHIoN3FmtXo1QWvmhbslCgc5O2YwZlOWi9MT0j8TrWRYFk60HUmSId3mt9ZV2gJaImvLwg
	Ycw8XU7/amtg91EsBPb+bmYvN5kCdyVFcTbDhof783lZTCECM2iO2rn2ua/bR/DttsRNtrjbwSv7z
	EabQYPNe2h6KJWmxNlD90B3QcWMnFWm/fwTzmg7zx4TiKxwcU2nrcSafuPqpdBj6l3p/Sy2n5q38O
	1JJC7MvDLwQ6nlrRwobMv7rSV8FfKvgX9wuEIqs9zU7/PkM+J5JD/oyICT+48Z+tC5MWFgle4BIt3
	KLTQoNEQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uziiD-000NtZ-1r;
	Fri, 19 Sep 2025 23:32:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 20/20] tools, ynl: Add queue binding ynl sample application
Date: Fri, 19 Sep 2025 23:31:53 +0200
Message-ID: <20250919213153.103606-21-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

Add a ynl sample application that calls bind-queue to bind a real rxq
to a mapped rxq in a virtual netdev.

  # ethtool -X eth0 start 0 equal 15
  # ethtool -X eth0 start 15 equal 1 context new
  # ethtool --config-ntuple eth0 flow-type [...] action 15
  # ip link add numrxqueues 2 nk type netkit single
  # ethtool -l nk
  Channel parameters for nk:
  Pre-set maximums:
  RX:           2
  TX:           1
  Other:        n/a
  Combined:     1
  Current hardware settings:
  RX:           1
  TX:           1
  Other:        n/a
  Combined:     0
  # ip a
  4: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
      link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
  # ynl-bind eth0 15 nk
  bound eth0, queue 15 to nk, queue 1
  # ethtool -l nk
  [...]
  Current hardware settings:
  RX:           2
  TX:           1
  Other:        n/a
  Combined:     0

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/net/ynl/samples/bind.c | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tools/net/ynl/samples/bind.c

diff --git a/tools/net/ynl/samples/bind.c b/tools/net/ynl/samples/bind.c
new file mode 100644
index 000000000000..a6426121cbd4
--- /dev/null
+++ b/tools/net/ynl/samples/bind.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#include <ynl.h>
+#include <net/if.h>
+
+#include "netdev-user.h"
+
+int main(int argc, char **argv)
+{
+	struct netdev_bind_queue_req *req;
+	struct netdev_bind_queue_rsp *rsp;
+	char if_src[IF_NAMESIZE] = {};
+	char if_dst[IF_NAMESIZE] = {};
+	struct ynl_sock *ys;
+	struct ynl_error yerr;
+	int src_ifindex = 0, dst_ifindex = 0;
+	int src_queue_id = 0;
+
+	if (argc > 1)
+		src_ifindex = if_nametoindex(argv[1]);
+	if (argc > 2)
+		src_queue_id = strtol(argv[2], NULL, 0);
+	if (argc > 3)
+		dst_ifindex = if_nametoindex(argv[3]);
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = netdev_bind_queue_req_alloc();
+	netdev_bind_queue_req_set_src_ifindex(req, src_ifindex);
+	netdev_bind_queue_req_set_src_queue_id(req, src_queue_id);
+	netdev_bind_queue_req_set_dst_ifindex(req, dst_ifindex);
+
+	rsp = netdev_bind_queue(ys, req);
+	netdev_bind_queue_req_free(req);
+	if (!rsp)
+		goto err;
+
+	assert(rsp->_present.dst_queue_id);
+	printf("bound %s, queue %d to %s, queue %d\n",
+	       if_indextoname(src_ifindex, if_src), src_queue_id,
+	       if_indextoname(dst_ifindex, if_dst), rsp->dst_queue_id);
+
+	netdev_bind_queue_rsp_free(rsp);
+	ynl_sock_destroy(ys);
+	return 0;
+err:
+	fprintf(stderr, "YNL: %s\n", ys->err.msg);
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.43.0


