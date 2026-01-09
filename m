Return-Path: <bpf+bounces-78399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7237D0C4F7
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72CDE305AF1F
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADE33DED4;
	Fri,  9 Jan 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jIrPEqCe"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192C33D6CE;
	Fri,  9 Jan 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994030; cv=none; b=pJ2qIdPrRpXrZznebmCySt9NqrO9T0oVKE7YxyFQxTtNkbHxOu1otWolG2jWr4WyFqq2szSylsKmTANrJlzZYervVNI79Tm9G2eOEh2iT/4GHx6rYO3fRFXdvsX0gPg7ANJP8YFVM1tgzC9QJaBVIpNCigEkK/9e/tkfa95Xoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994030; c=relaxed/simple;
	bh=hm64NVqa0wnApRUIEH4rk1x3qR4aLVEMBxvK8HqoySE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW1T8CqSHS3UTLP+zTPeiA8mBY16YibA4agdngMmYGuOeAZ8O5WvMjkYMM2exH62thKO6hvcnjrqNzLw8H8kitSlH2Pp8QIzbG8v2jixGW4LGSsIy6zp1p/+Z8bi+a5uQgQhkCoMtMsWx1PjKwfM8C8zrNitTnCQPqnP61RJzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jIrPEqCe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mDM1MZzq3Y/3/wmI0ODQX70XTHCDBRZPTgcSWjWwtCE=; b=jIrPEqCem1YjUFZ5utXsihupwK
	ROzOYZNpsyngQXadAcB1oSmkm2zA+PpfvxDNYtpKX+Fa1wJNieTdCEitqGvS56SqlYjZN/2T12qRL
	rWpdA7/srXOKpS86p4j7YX0wqVYRv7+ljecv8wx2fM/xxK6qs3czLp/vAGyH89G2W0JYHh0eDSB/U
	KM+KUxrMjz26qICf3VfH9hZAq9qifVpdzobb+rSgfRqL0vVq6AsGJbpEacm5tWadtYjYG2h3GuPpk
	07bziknEqaB5eTFa4gyw9wVEPo6sUuNe0X17vuFYKYQ6gsYbL/6D42qTmVN4yDzXy63ZA1sj22++C
	OnVLWm4A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0Q-000566-35;
	Fri, 09 Jan 2026 22:26:51 +0100
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
Subject: [PATCH net-next v5 15/16] selftests/net: Make NetDrvContEnv support queue leasing
Date: Fri,  9 Jan 2026 22:26:31 +0100
Message-ID: <20260109212632.146920-16-daniel@iogearbox.net>
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

Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
in the env.

The NETIF also has some ethtool parameters changed to support memory
provider tests. This is needed in NetDrvContEnv rather than individual
test cases since the cleanup to restore NETIF can't be done, until the
netns in the env is gone.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/drivers/net/lib/py/env.py       | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 3cc94d1e53ed..705bb09066fb 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -7,8 +7,9 @@ import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
-from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
+from lib.py import cmd, defer, ethtool, ip, CmdExitFailure, bpftool
 from lib.py import NetNS, NetdevSimDev
+from lib.py import NetdevFamily, EthtoolFamily
 from .remote import Remote
 
 
@@ -295,7 +296,7 @@ class NetDrvContEnv(NetDrvEpEnv):
     between the physical interface and a network namespace.
     """
 
-    def __init__(self, src_path, nk_rxqueues=1, **kwargs):
+    def __init__(self, src_path, lease=False, **kwargs):
         super().__init__(src_path, **kwargs)
 
         self.require_ipver("6")
@@ -303,6 +304,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not local_prefix:
             raise KsftSkipEx("LOCAL_PREFIX_V6 required")
 
+        self.netdevnl = NetdevFamily()
+        self.ethnl = EthtoolFamily()
+
         local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
         self.ipv6_prefix = f"{local_prefix}::"
         self.nk_host_ipv6 = f"{local_prefix}::2:1"
@@ -313,7 +317,11 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._nk_guest_ifname = None
         self._tc_attached = False
         self._bpf_prog_id = None
+        self._lease = lease
 
+        nk_rxqueues = 1
+        if lease:
+            nk_rxqueues = 2
         ip(f"link add type netkit mode l2 forward peer forward numrxqueues {nk_rxqueues}")
 
         all_links = ip("-d link show", json=True)
@@ -330,6 +338,32 @@ class NetDrvContEnv(NetDrvEpEnv):
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
+        if self._lease:
+            channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
+            channels = channels['combined-count']
+            if channels < 2:
+                raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
+
+            rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
+            self._rx_rings = rings['rx']
+            self._hds_thresh = rings.get('hds-thresh', 0)
+            self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                                'tcp-data-split': 'enabled',
+                                'hds-thresh': 0,
+                                'rx': 64})
+            self.src_queue = channels - 1
+            bind_result = self.netdevnl.queue_create(
+                {
+                    "ifindex": self.nk_guest_ifindex,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": self.ifindex,
+                        "queue": {"id": self.src_queue, "type": "rx"},
+                    },
+                }
+            )
+            self.nk_queue = bind_result['id']
+
         self.netns = NetNS()
         ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
         ip(f"link set dev {self._nk_host_ifname} up")
@@ -389,4 +423,11 @@ class NetDrvContEnv(NetDrvEpEnv):
             del self.netns
             self.netns = None
 
+        if self._lease:
+            self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                                  'tcp-data-split': 'unknown',
+                                  'hds-thresh': self._hds_thresh,
+                                  'rx': self._rx_rings})
+            self._lease = False
+
         super().__del__()
-- 
2.43.0


