Return-Path: <bpf+bounces-79004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF79D23268
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A833082A31
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD333506C;
	Thu, 15 Jan 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GVOIne+9"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97F331A40;
	Thu, 15 Jan 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465606; cv=none; b=Zg1ckJFIYe+s+4sSxycqki3VI5fj2+FA3axT3OFdu12G79ZUWd2BtZhtsSZOmBXTT/Y8RpALZRPV+HrbKRyx0Ug1xnXcTNwZC4B9OOR83iVg0xyZtSqB4VuYBJRqeDLAISIXsyzWsSi5pJ7pOAKkTocdCnH5gquhGR0k6/TGRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465606; c=relaxed/simple;
	bh=ds3vmtRO482oJ4L9zl1gi+HwQInYAfVxpdU9illDGlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ypFYnVl4HZ1An0rQ5cCQffROIRn9+7WXLlvJqNm7qHV3DeQBy0WzUTHZkkwXokIny96uN+QBFEQZxLv3DhlwSVscLTee6n4EXbim61wruAD6Krq//cadjs1wiRtutrbrXCSxTTvms92/8BhLuU/qpxJCRW8V1/aywfeJu9+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GVOIne+9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A3JhZ4YZgwR/rLOGJb+FXJJbVesXMoF+77HTdLn+a1E=; b=GVOIne+9qrj9thDef3MU2gbPTo
	2urAdT9TOi8iqQEkT+29ViU+G6D6dwO7PZT9MTu5aI1z9TBKXhT5yjd8A1rnhTyTe0LjaQQBmHWos
	rzo1re2kn5QhE6rmCUticlghmlscgS8ji774HRWy7wqgKMz49pLQp4Vgibjwp4mtPn4p+1H5okSS+
	hznG5xsuhf5MPacJZRwTt9F3WlQ59F5xWou+ZKAdg184cHVGRvwWtTwkyTyFDr5xF4gzEvlndVa/t
	OmHtxgmCFiH+6EiM8iml+GpfUvO3UvghBrRDpuNxTvJYgxAn8EIMZZTO+eXSpftTHjfSZpHAie6e1
	l22yK2/g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgR-000NsN-0R;
	Thu, 15 Jan 2026 09:26:23 +0100
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v7 16/16] selftests/net: Add netkit container tests
Date: Thu, 15 Jan 2026 09:26:03 +0100
Message-ID: <20260115082603.219152-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

From: David Wei <dw@davidwei.uk>

Add two tests using NetDrvContEnv. One basic test that sets up a netkit
pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
program to ping from a remote host to the netkit in netns.

Second is a selftest for netkit queue leasing, using io_uring zero copy
test binary inside of a netns with netkit. This checks that memory
providers can be bound against virtual queues in a netkit within a
netns that are leasing from a physical netdev in the default netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |  2 +
 .../selftests/drivers/net/hw/nk_netns.py      | 23 ++++++++
 .../selftests/drivers/net/hw/nk_qlease.py     | 55 +++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 9c163ba6feee..39ad86d693b3 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,8 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
+	nk_qlease.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..afa8638195d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import cmd
+
+
+def test_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=cfg.remote)
+    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=cfg.netns)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__) as cfg:
+        ksft_run([test_ping], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
new file mode 100755
index 000000000000..738a46d2d20c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import re
+from os import path
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
+
+
+def create_rss_ctx(cfg):
+    output = ethtool(f"-X {cfg.ifname} context new start {cfg.src_queue} equal 1").stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    return int(values)
+
+
+def set_flow_rule(cfg):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.src_queue}").stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
+def set_flow_rule_rss(cfg, rss_ctx_id):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} context {rss_ctx_id}").stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
+def test_iou_zcrx(cfg) -> None:
+    cfg.require_ipver('6')
+
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__, lease=True) as cfg:
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+        cfg.port = rand_port()
+        ksft_run([test_iou_zcrx], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


