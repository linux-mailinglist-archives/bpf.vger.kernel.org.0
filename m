Return-Path: <bpf+bounces-78389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E7D0C500
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D6A30754F3
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1533EAF8;
	Fri,  9 Jan 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QN2MNKgU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD733D4F2;
	Fri,  9 Jan 2026 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994024; cv=none; b=VgpnhpW8lg5XQkXzNx/a0sjr9LzyRGxuE+bbafcZ5zm32yKonUiJjduHGwkWOdAHbx5Dun4jyVSEz4kwGf8Pgz1AHsH+r3FgB2dO+EgAQJ5AI+SMUxSuEEgfA7+nyoESBuLrvrPWHyDTYTrrhOeFSLv6gkPnUOYLO9bR2UgcX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994024; c=relaxed/simple;
	bh=HUgwPka4M0yHQeXNjfZtBMFVEz2wHjLcGoeWfhGa++k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbcsEnxhxY/CndVisX+2X3Q3k09X5J4g5X/j2WABTKQ5lL+6zAQuy0zNq4IBV66LSbhqaXMlee+xgE2Aszbt9PbOVVYSZb3aoAM4gTBx1UohdQvcqx76Qt3T3NrS1M6u+RQxWVpRxU+ZNErEL8UC3y8qywArRpf8JimvKF5BIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QN2MNKgU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WbFsLRJzYxDV/0xfkCioZe7RTbFdJTzm5jUQXguqsYM=; b=QN2MNKgUUlkZW3MghD4GiFjZ0q
	mzUDZs1MluxGLrapE0mAN2l5FP9krIYqYE4evkVxX8aihf9xoR/abS06SHTaOZ1tA/BavmH/gAVOU
	J6+QA41gOS7HDzQm0vmjbAkucofZbqFVc3Vb2Fo1w3bLegwbwgwVrALfoAD9qIW3TjdhuFBqqOSl5
	Lu8IAO0wxlzAI18TN4/zqQj8GbJPdWLQsDKQRcCooAaqTbSkN3uWAPlBXRksQV6dmOELXhbOwLFuF
	vvd1Aw9DYKWBLirF2AUmCXeaqt2Z8Tx/L6wEHdfUVbOL+76iZhQ/gIHhVhr90Udg/9qOHwSZgK/xm
	NJOoBIkQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0P-00055Z-2q;
	Fri, 09 Jan 2026 22:26:49 +0100
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
Subject: [PATCH net-next v5 14/16] selftests/net: Add env for container based tests
Date: Fri,  9 Jan 2026 22:26:30 +0100
Message-ID: <20260109212632.146920-15-daniel@iogearbox.net>
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

Add an env NetDrvContEnv for container based selftests. This automates
the setup of a netns, netkit pair with one inside the netns, and a BPF
program that forwards skbs from the NETIF host inside the container.

Currently only netkit is used, but other virtual netdevs e.g. veth can
be used too.

Expect netkit container datapath selftests to have a publicly routable
IP prefix to assign to netkit in a container, such that packets will
land on eth0. The BPF skb forward program will then forward such packets
from the host netns to the container netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/README.rst  |   7 ++
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 107 +++++++++++++++++-
 4 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..b94e81c2e030 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,13 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses (for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 766bfc4ad842..9a0dd482258d 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment (hardware-only tests).
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -29,7 +30,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -44,8 +45,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-               "Iperf3Runner"]
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+               "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8b75faa9af6d..be3a8a936882 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment.
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -43,12 +44,12 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
 
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-                "Iperf3Runner"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+                "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 8b644fd84ff2..3cc94d1e53ed 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import ipaddress
 import os
+import re
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
-from lib.py import cmd, ethtool, ip, CmdExitFailure
+from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -285,3 +287,106 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding traffic
+    between the physical interface and a network namespace.
+    """
+
+    def __init__(self, src_path, nk_rxqueues=1, **kwargs):
+        super().__init__(src_path, **kwargs)
+
+        self.require_ipver("6")
+        local_prefix = self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
+        self.ipv6_prefix = f"{local_prefix}::"
+        self.nk_host_ipv6 = f"{local_prefix}::2:1"
+        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
+
+        self.netns = None
+        self._nk_host_ifname = None
+        self._nk_guest_ifname = None
+        self._tc_attached = False
+        self._bpf_prog_id = None
+
+        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {nk_rxqueues}")
+
+        all_links = ip("-d link show", json=True)
+        netkit_links = [link for link in all_links
+                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
+                        and 'UP' not in link.get('flags', [])]
+
+        if len(netkit_links) != 2:
+            raise KsftSkipEx("Failed to create netkit pair")
+
+        netkit_links.sort(key=lambda x: x['ifindex'])
+        self._nk_host_ifname = netkit_links[1]['ifname']
+        self._nk_guest_ifname = netkit_links[0]['ifname']
+        self.nk_host_ifindex = netkit_links[1]['ifindex']
+        self.nk_guest_ifindex = netkit_links[0]['ifindex']
+
+        self.netns = NetNS()
+        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
+        ip(f"link set dev {self._nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+
+        ip("link set lo up", ns=self.netns)
+        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
+        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
+
+        bpf_obj = self.test_dir / "nk_forward.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog not found")
+
+        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._tc_attached = True
+
+        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
+        match = re.search(r'pref (\d+).*nk_forward\.bpf.*id (\d+)', tc_info)
+        if not match:
+            raise Exception("Failed to get BPF prog ID")
+        self._bpf_prog_pref = int(match.group(1))
+        self._bpf_prog_id = int(match.group(2))
+
+        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
+        map_ids = prog_info.get("map_ids", [])
+
+        bss_map_id = None
+        for map_id in map_ids:
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id = map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find .bss map")
+
+        ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
+        ipv6_bytes = ipv6_addr.packed
+        ifindex_bytes = self.nk_host_ifindex.to_bytes(4, byteorder='little')
+        value = ipv6_bytes + ifindex_bytes
+        value_hex = ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def __del__(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}").stdout
+            self._tc_attached = False
+
+        if self._nk_host_ifname:
+            cmd(f"ip link del dev {self._nk_host_ifname}")
+            self._nk_host_ifname = None
+            self._nk_guest_ifname = None
+
+        if self.netns:
+            del self.netns
+            self.netns = None
+
+        super().__del__()
-- 
2.43.0


