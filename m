Return-Path: <bpf+bounces-78400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57BD0C4FC
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B08C3305DE61
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6233DECB;
	Fri,  9 Jan 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WMpA2VPT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013A340263;
	Fri,  9 Jan 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994038; cv=none; b=kUcG9f+bqTz7lFz8QQHoiq2s0SSpJIqsiKzWQ66xsuG65suyvV/XAjjdZxljJ2BMeHfrNQ5MgTcBSQvpuJUFQHlBeSfPGfw7rTvGXD/l80NI5Xv9jiQtRMElP7Kn3LVZOtuFd76jUfW7BbW/Z03Lo0qmtKj3TEuK0KfzydxZF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994038; c=relaxed/simple;
	bh=ds3vmtRO482oJ4L9zl1gi+HwQInYAfVxpdU9illDGlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzHAZVY/eXlb7uv6758d/fIC4kDykrrRSIOk40kzk6TNpxhFw8hh1/b4xxAFWn9iI+s2gQXf01tcJ3sSF4lL7S818ygs0JRvnrxYjVrXjFQBixYvWlSeX1+kcd8/4gkHUEteMdpiYh4nbxVBIkyCRDlQ+Voto8UtkUNumcXX87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WMpA2VPT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A3JhZ4YZgwR/rLOGJb+FXJJbVesXMoF+77HTdLn+a1E=; b=WMpA2VPTK6beS1GaMaGAkR9fVL
	ybbQBmnTMvs/WcjEAsmm197H8s6OAu2hXIP3eWUsEXt3B8MnTPVEy4ho0SymARNJO7Ail/m/rcSSk
	EHje5LVcJe46BrSzDETZQMkxc+H5E7Q33RNik4wR1xtODMlZlbp+cjyLnTc3o7XzEaBh6TGYRLR3Y
	DVoVrp62UBEAlxpX7BHbymA0rZNUVbYYL+ko18o494lqqM6oxO4kr6E1W546x7ReMJIq1RQuAJE69
	mKUl9EkoEsetMYHT3PBlO/4nMpKyI+2smrONHdN+0Ng+kKbqmS8J/YHuyc4BxZNxi7duieQAX1VEu
	2yubTsoQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0S-00056W-02;
	Fri, 09 Jan 2026 22:26:52 +0100
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
Subject: [PATCH net-next v5 16/16] selftests/net: Add netkit container tests
Date: Fri,  9 Jan 2026 22:26:32 +0100
Message-ID: <20260109212632.146920-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109212632.146920-1-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27875/Fri Jan  9 08:26:02 2026)

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


