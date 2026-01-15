Return-Path: <bpf+bounces-79003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98203D231B4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D27F3031823
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15CD32E690;
	Thu, 15 Jan 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JY4Dilq2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD11331A4D;
	Thu, 15 Jan 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465605; cv=none; b=Elih4NZg7uK6GypOsxSQOT8eaOAMOzGYnLW2UY/9OZfagZB6txwxsm+3EdAJch8/TJQCToCWscaZ1Q/yMHnJJuQ/HDwwShN/wJ2hJSeJAAEMdgJXi83plr5Gge8PfsXAAENJpV/ew52MpeJilYgGZGDYsJKoIhplE3MHAbeQbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465605; c=relaxed/simple;
	bh=Ia767jD5QTfwOLlKZHEVNJ6tsIOrQM4HVVSa9wMtPGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/sny86HtJk7/DcM7VAmIKS887pEyPM+uU7xque9Xo2jE/d2oWlq5tRuwRy74jLfsIicEOTbs1j6JDKXJA00cXlP5ImUqQpd7OboG1j+HomnSWv5jUIaaNoBhiOCsv1YuwfY4zm0LCxvuO3oDAkzzJmXGuQmZOL+BeMDE/HwOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JY4Dilq2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vDYMdV1AE4rtkBYHgjF8DcoM9t6uF/pZLj8zQ1xSHsI=; b=JY4Dilq2xWgTxTZ6FMu6BvosYG
	61j2Wrg73BkjO0ennyBjPf1OYqzetzFT+7xtxH9/yDIsqviG9IUo/IBgQUu/iIde4EgoE10MU9cZV
	kqeEmqfxcRp0H2DHBoKtRbhKjQ/2k6CB5836knj+ie4dlDmAX6j/yEe+FxaF6HTo0VWDKbku3mEMZ
	oFDBaBKez8WobOvnUc4LaQ3/Lvb7sSx3I9xznVBeai4qX8D//VAD6i8mVuZPkrx7n5kANUmuC/zV3
	MmH+gs4kyw+e9zbP6jcrYLB0GL3rnnEgpEpFS+Smmx0ZqFlKjeMEceod/r7TcIR5ESWJ4ARpaJNXQ
	hPRmgGPw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgQ-000NsA-0B;
	Thu, 15 Jan 2026 09:26:22 +0100
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
Subject: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv support queue leasing
Date: Thu, 15 Jan 2026 09:26:02 +0100
Message-ID: <20260115082603.219152-16-daniel@iogearbox.net>
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

Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
in the env.

The NETIF also has some ethtool parameters changed to support memory
provider tests. This is needed in NetDrvContEnv rather than individual
test cases since the cleanup to restore NETIF can't be done, until the
netns in the env is gone.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/drivers/net/lib/py/env.py       | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 5b12c4c59e09..7066d78395c6 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -9,6 +9,7 @@ from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
+from lib.py import NetdevFamily, EthtoolFamily
 from .remote import Remote
 from . import bpftool
 
@@ -300,7 +301,7 @@ class NetDrvContEnv(NetDrvEpEnv):
     between the physical interface and a network namespace.
     """
 
-    def __init__(self, src_path, nk_rxqueues=1, **kwargs):
+    def __init__(self, src_path, lease=False, **kwargs):
         super().__init__(src_path, **kwargs)
 
         self.require_ipver("6")
@@ -308,6 +309,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not local_prefix:
             raise KsftSkipEx("LOCAL_PREFIX_V6 required")
 
+        self.netdevnl = NetdevFamily()
+        self.ethnl = EthtoolFamily()
+
         local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
         self.ipv6_prefix = f"{local_prefix}::"
         self.nk_host_ipv6 = f"{local_prefix}::2:1"
@@ -319,7 +323,11 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
+        self._leased = False
 
+        nk_rxqueues = 1
+        if lease:
+            nk_rxqueues = 2
         ip(f"link add type netkit mode l2 forward peer forward numrxqueues {nk_rxqueues}")
 
         all_links = ip("-d link show", json=True)
@@ -336,6 +344,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
+        if lease:
+            self._lease_queues()
+
         self._setup_ns()
         self._attach_bpf()
 
@@ -353,8 +364,42 @@ class NetDrvContEnv(NetDrvEpEnv):
             del self.netns
             self.netns = None
 
+        if self._leased:
+            self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                                  'tcp-data-split': 'unknown',
+                                  'hds-thresh': self._hds_thresh,
+                                  'rx': self._rx_rings})
+            self._leased = False
+
         super().__del__()
 
+    def _lease_queues(self):
+        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
+        channels = channels['combined-count']
+        if channels < 2:
+            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
+
+        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
+        self._rx_rings = rings['rx']
+        self._hds_thresh = rings.get('hds-thresh', 0)
+        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                            'tcp-data-split': 'enabled',
+                            'hds-thresh': 0,
+                            'rx': 64})
+        self.src_queue = channels - 1
+        bind_result = self.netdevnl.queue_create(
+            {
+                "ifindex": self.nk_guest_ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": self.ifindex,
+                    "queue": {"id": self.src_queue, "type": "rx"},
+                },
+            }
+        )
+        self.nk_queue = bind_result['id']
+        self._leased = True
+
     def _setup_ns(self):
         self.netns = NetNS()
         ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
-- 
2.43.0


