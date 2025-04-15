Return-Path: <bpf+bounces-55928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98AA89582
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3133A42F4
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B827F738;
	Tue, 15 Apr 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FILAHZgz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBE27FD6E;
	Tue, 15 Apr 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703107; cv=none; b=LvDQ9TyFW3GKmwcKnzsgbr9wHf4ZCHtUmWBokSalpCUJbCsTpoZV3DlREJlg1BvEkokHTPAb4OLGKbBuDCkOyBsY/NaKhrMUWMs/51e5iq0ZEkJ76d1YO1tcJIN0BUQPO+LEzzPO6J17K111KwzDQUWOgwtVgyw3OiBwAN3sYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703107; c=relaxed/simple;
	bh=1niKW98sQ32RMpVs4DRJjX8QJwWQRiEGm9x2KiIx0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqHa+2h8M2VO/Ro5hjMrXnW4LlBaLzocvK2fzCMaWrEuikG0SCf6BwvRvT8bP5RVG55m2iYTy4OZdrtaeuCu93aU4sJupeavnRT65T90mexI0CzPT1Am4CWVNgeTnh3uz/pYc/oeVQm0ZFXfp5CD/yQGhQGU69cy4HqLuop7BFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FILAHZgz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4307930a12.2;
        Tue, 15 Apr 2025 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703105; x=1745307905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=FILAHZgzmECdlZnlG0WGee0VxvVjQMHm5NHeRWE3JogKUSXvr+LJXpJlJlhxfkLRWP
         SSAGmcCrHhb9gdyBXU9NEpbBjsFPjyBlWaC3tNBcnpwK6AM95UIx0RJ4Mfnzk5gjFewD
         XAtHnr/UX0fswtucVW3Kn9AwC9TowyU+cvArJVOtsbM4fHeC8tTgLj3d9iJ0VDyamcQv
         kY+dTRcrT6eMkZ0l6/L7eOtbs3YkwLO8iS52N5BfhdQNiYRzGrSSm7MYzuGhgAm3iaBx
         5xAlhTC6v32TlCQ7TOg189ZSJ+bQF0g1rOquqgd1Y1FjkNDCLHpL9fs5bXhmKQCEKsoP
         Iztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703105; x=1745307905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=aau4UQlC5Zj9hLjpESYHYkTkwYXKJXSjgx3gGlBltAblw+7m6c0CHN2pFmqIjt/MJ2
         0amg1hJy4JQsKcas2UXfaKVjrz4hldKvx7nmV51X6TaWLwGh24LlLCCaXHl/2gA0WB9H
         wsbLk8SjOEf3Qgjq3dDu7/0FWbltu6/q2WzQqsyFnfJ+oRNp/nPz315+KTncXyzk2AOb
         bTuh9R1Zy4EupzQi3dqoQcDoc6Ocz/IN+5DuJ4c3p1Bw0NwG8sla5NFOnrsSSgdwsviK
         CfXP6nQLWHOQ9I8rU38pMID+bPPSXmFqBuPuuZjUPfDUx23q3X815jpEIcj9w9DRXrSH
         3w/A==
X-Forwarded-Encrypted: i=1; AJvYcCWvmrLhr0vMpVZIusKrZj1XGA9W1UOsqa+J8ly0S2tocjwdriiz+s3zj3LekqlOr4MN6hLtdTs9DzpKzSLu@vger.kernel.org, AJvYcCXLV/fgdNG6LwtE7N67nYfVeUgh6Ka95hDUyTTSuGMNdukVBLUqa89JZtQwgojxH6Qg1ZI=@vger.kernel.org, AJvYcCXnp7uONSKo9X9RnSFqNzYbqGQGti11bBTRCuiTF355Onfy3K2aAPkLwHbQ98Nd4GR1p/AF+I7w@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyeUGA0EQJQKBlRuu+TD8W826AlJlbht5u0D8MfGFIblmpxuw
	jy5vwaQJRsu2EPcscSVkAP8hcktmcM9r7aIkVe3KlIanOaLSQg+T
X-Gm-Gg: ASbGncuKiRZwj6wdREWmjE6DSlM6dWZ8UamvqcPG8cJroVsEdDWXhQKsG0PA/tJPGEY
	mXJesyxRJixEqpiGiiTcwcrAQK03cxIVhgDSkb3I29abBtcqE4zDNipLV7ZaRYhS0Ug8+uq+iYc
	mWMh4NJAXDHCf+kdxn82sj32IBNC1OMQf9kmfm27bBV370NlVur8oGJniYu15W+hmYcvK7tfA66
	zaAOgl4e8PRwlBY56C+SBpSD3piEXpsrkL34Y7SFCZzJmuqhDE7NQRHL7K0UHFS0Y3iLBwts9ve
	yVsEYxpQ4hF09QzXcVam1AfK58C0cY8lrUdhl1d08Ek0sC5c+uDcDFs3Z7eXt/Qhq74=
X-Google-Smtp-Source: AGHT+IH+G17f4AOelzFwX1SUg4M9HSnGkdTV05DRb9VJ6OVH1IN3h5ijtvA9l3wacdqrXeHJfCrK0Q==
X-Received: by 2002:a17:90b:544c:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3082377c5dbmr22710108a91.13.1744703105441;
        Tue, 15 Apr 2025 00:45:05 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:45:05 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Tue, 15 Apr 2025 14:43:41 +0700
Message-ID: <20250415074341.12461-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftest reproduces the deadlock scenario when binding/unbinding XDP
program, XDP socket, rx ring resize on virtio_net interface.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/Makefile              |  2 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 ++++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 +++++++++++++++++++
 5 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c77c8c8e3d9b..0a6b096f98b7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,7 +130,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw drivers/net/virtio_net,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
index 7ec7cd3ab2cc..82adda96ef15 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/Makefile
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
 TEST_PROGS = basic_features.sh \
+        xsk_pool.py \
         #
 
 TEST_FILES = \
@@ -8,6 +9,7 @@ TEST_FILES = \
         #
 
 TEST_INCLUDES = \
+        $(wildcard lib/py/*.py ../lib/py/*.py) \
         ../../../net/forwarding/lib.sh \
         ../../../net/lib.sh \
         #
diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
index bcf7555eaffe..12e8caa22613 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/config
+++ b/tools/testing/selftests/drivers/net/virtio_net/config
@@ -6,3 +6,4 @@ CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_VRF=m
 CONFIG_VIRTIO_DEBUG=y
 CONFIG_VIRTIO_NET=y
+CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
new file mode 100644
index 000000000000..b582885786f5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+    from drivers.net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py b/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
new file mode 100755
index 000000000000..3f80afd97d4e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This is intended to be run on a virtio-net guest interface.
+# The test binds the XDP socket to the interface without setting
+# the fill ring to trigger delayed refill_work. This helps to
+# make it easier to reproduce the deadlock when XDP program,
+# XDP socket bind/unbind, rx ring resize race with refill_work on
+# the buggy kernel.
+
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv
+from lib.py import bkg, ip, cmd, ethtool
+import re
+
+def _get_rx_ring_entries(cfg):
+    output = ethtool(f"-g {cfg.ifname}").stdout
+    values = re.findall(r'RX:\s+(\d+)', output)
+    return int(values[1])
+
+def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
+    # Probe for support
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
+    if xdp.ret == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.ret > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
+               ksft_wait=3)
+
+def check_xdp_bind(cfg):
+    ip(f"link set dev %s xdp obj %s sec xdp" %
+       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
+    ip(f"link set dev %s xdp off" % cfg.ifname)
+
+def check_rx_resize(cfg, queue_size = 128):
+    rx_ring = _get_rx_ring_entries(cfg)
+    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
+    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
+
+def main():
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        xsk_bkg = setup_xsk(cfg)
+
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


