Return-Path: <bpf+bounces-78776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC4D1BB53
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69140303E69A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD636BCE4;
	Tue, 13 Jan 2026 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MAbLe5aS"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281436AB70;
	Tue, 13 Jan 2026 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346618; cv=none; b=suHPofTan3Dje3TH3ZMZtpCUbw0XhIx4tOOlnnS8frVjb2XpQckScNEHVSWdMc8c9VjNP7PuKjLHNP5xTvHrkVpSXXOBI5KfzeTny6vP8vnVPAcgkNRuuIUVTCESExH06CxQkM3f6M7C9J8lqG1Y6ZCQbfSuoW93W2aAT9OsjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346618; c=relaxed/simple;
	bh=ht50qx0eWUsXxg6HGzg8ZdcraZV8s6kM+v4/eeBWnoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx3+hHW1dyrJxAclbYKwS4L9pwBrbYYXkON9qfw81NeuvHEsqrbJgQRwFbYLuRN+N82etwLRCdIp0TPwu+S8wpzFz9zwT8nOQdF4vN/3guvXB3prTeuoJpIS0Mqgy5NqmRgHfmaUJMrNlJ79MMNeFCp5aIbu9qQZKT0wNf/Ssx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MAbLe5aS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Dzel2yIddAlfKGkxOKkHid0/2vVYdgQL8nG/zjjyM6M=; b=MAbLe5aSfEMQe+lxUKQlrNQbTW
	voufO3FkcVNATVYZVxLh7ZOzXllGg1hTBl3f7g4PTTysUQGvwEo1fcephrLyEpEoY04sPVoUEOLZk
	q1tTACKFJauyGM8P8rWpPgwjMlm2UFmR8VA48u8kSCKuyrk4XAFIGol7FOh+8XwMR4kzVyGuJxcFd
	XiUdkEH27UcVXrgZ9HNPmWejhnMZXcWEQc82NisLiymDd9SkC2n87tfJHCs+5I6xCGg95gMIdw6F+
	GJvkoYE3/JwjdZ5gewUFPmQWLbUzcRl0Wyf+WrxuwoE9Pmne0hauwk8D729gW8MGByYwlTzEbT5C+
	I24Td2AA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnjI-0003j0-1Q;
	Wed, 14 Jan 2026 00:23:16 +0100
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
Subject: [PATCH net-next v6 15/16] selftests/net: Make NetDrvContEnv support queue leasing
Date: Wed, 14 Jan 2026 00:22:56 +0100
Message-ID: <20260113232257.200036-16-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

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
 .../selftests/drivers/net/lib/py/env.py       | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 3a60c12b9087..25da2c0b98d7 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -9,6 +9,7 @@ from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
 from lib.py import NetNS, NetdevSimDev
+from lib.py import NetdevFamily, EthtoolFamily
 from .remote import Remote
 
 
@@ -296,7 +297,7 @@ class NetDrvContEnv(NetDrvEpEnv):
     between the physical interface and a network namespace.
     """
 
-    def __init__(self, src_path, nk_rxqueues=1, **kwargs):
+    def __init__(self, src_path, lease=False, **kwargs):
         super().__init__(src_path, **kwargs)
 
         self.require_ipver("6")
@@ -304,6 +305,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not local_prefix:
             raise KsftSkipEx("LOCAL_PREFIX_V6 required")
 
+        self.netdevnl = NetdevFamily()
+        self.ethnl = EthtoolFamily()
+
         local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
         self.ipv6_prefix = f"{local_prefix}::"
         self.nk_host_ipv6 = f"{local_prefix}::2:1"
@@ -315,7 +319,11 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
+        self._lease = lease
 
+        nk_rxqueues = 1
+        if lease:
+            nk_rxqueues = 2
         ip(f"link add type netkit mode l2 forward peer forward numrxqueues {nk_rxqueues}")
 
         all_links = ip("-d link show", json=True)
@@ -332,6 +340,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
+        if self._lease:
+            self._lease_queues()
+
         self._setup_ns()
         self._attach_bpf()
 
@@ -349,8 +360,41 @@ class NetDrvContEnv(NetDrvEpEnv):
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
+
     def _setup_ns(self):
         self.netns = NetNS()
         ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
-- 
2.43.0


