Return-Path: <bpf+bounces-55840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94AA87730
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112D716EA71
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4001A4E9D;
	Mon, 14 Apr 2025 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuxTVK24"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9941714C0;
	Mon, 14 Apr 2025 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607392; cv=none; b=aij61syNp7f0NnfHnyiw1LNu9hw3L9kHx+6qF9lMkB27xl697P5VyARu6WM/D8bLK5McI6ndMhCVqqA4FQcttwOEBJPW5+Lf/YKM+QflO44kx4ZkCTEkltE6VyiPg7EgVSvAJgmpe5CjYZudj9fo7VFkKShvILh8UGvQ0dVSGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607392; c=relaxed/simple;
	bh=1niKW98sQ32RMpVs4DRJjX8QJwWQRiEGm9x2KiIx0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZlLKjJqeGf22bwkQ/ubipesXvmiAMTknx86/gkw02a/be04Rm5fdZgAAyHkWFX4pZ1s4/2GNWjRO2Ip3ZmUvSt3zJv93BD+02CQuJaPFEziU6AXHrSekyVwzMVponkp2RDo6k9v21FEOty1zu6B7P7TIO7VOAEE6EhX9cTp/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuxTVK24; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2241053582dso52160805ad.1;
        Sun, 13 Apr 2025 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607390; x=1745212190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=kuxTVK24Sg2+jq4W+raf6kKUL3xYvuLHvhFrx0+eLJddU7jTU0k7vJcZ26o+nBxFzB
         frNQEZabg6rJKzey6dcV/3N1oJ5qzVr7cAYPV2z6/qKYvR3+w2FHWAt3KqJ/CAHgb27h
         9IdbCU9tNQX+6E3xsDNtTr9qzX3QW4GW+bKGIIPIl8asaG+sY3LhMLnEOUchXUhintJD
         jjy/EWqXFK6M8wRukFjV5ZBWFz2Lzr3LEFynbR31hhtNP7eFfngPf1d1m9xkA/iSmsUJ
         ONZ5fWhDdQJqsv51wLnqzbhH6kifDE6qnkUboxP0Vzyk7lRiAcVgrrFMUEocAKS+DKJ6
         Kf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607390; x=1745212190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=f2aeKWRKDiKlbZ0f2+xUHZKr0MSRUik/RYM9GJydcOgrnsfir/BHtX3Dd0FaDrWpI2
         LkPTFZBIQJ9iCq+rDI0qSMQBVadNMNBNVbWffxUuIlTjpmY325Eo8XJS1V6EnjME2/WO
         3VYU/BYVBmXL3AUeEh51zxOUtbrig2CFJugkYdoaeFu/XFoh37IAgiGU3uID5GwYZyUU
         jodox6CfS63U/dl6o3DTTCpmLquNuk+jSBVm9eCV1JcbCZD5wq2jCs64YWik+MQm/njC
         K9NxN4bxt4pPyxU5ZJkRv3QQ2pgrU/mWSeTvrMrw9RLPCiDfVn2CrOcDtrINVnRQ+idf
         FVqw==
X-Forwarded-Encrypted: i=1; AJvYcCUsu3ewS4Hxa029bV5MVZZG1aX2ffSLkBI/D4XmHY5gJ7YfPIRMSgx33FEXW67cBtpZwbbj5set@vger.kernel.org, AJvYcCXH7QYdDgedSNdJYUH6WF/UMXz2OtBel+/+5Z35uLzWyXvAf8cRQME7f3E6E+8QjRSyl3M=@vger.kernel.org, AJvYcCXMKi7WqFBKzB3jmIjjhR4k/8xS/NlYwc6yNhSwXnHDL5MsQlPsMo+KGVf6yCjYYUiCZBv6DCp5zXexcUgC@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY4JHvVQHGkB5DE3aoorhly1G0SrTZhFGLxxuCv+o8C5IA87P
	KwDrxoJvQ7TvG6g3TMtLRdIf5FM52LZzJT+eI7jFzpi24PDywIH9
X-Gm-Gg: ASbGncsmx+gwGr2indNi6rQseWKjfB/3A1VFnoVkueNVSDIhawOeTQMsoJEov8OzlbJ
	g5P0PQTYzwaEPe8Gj7wTacYbph0m/LOAOoR69X0K0s99LfvYw4LVFayVk6qNGB3+i/1PVe4rbU0
	upKd5NQtXLH4bxBSrhCBIELBkLL+q9oLK+6V7QKvGfk59jgjHDsYmSDicaZkrXFY60MGaleZFfy
	4KarVSShDlDZoNyA1c/wkHQyZpxuQfxTAURhfhsT1lpHStDNBHMBbM4kOmlYrVNAm1T77RHJkpx
	hLHZcUM0Xrfqr3Tea/XoUpTyk5KLwSddbppMAh88yMhjONOOmc9abWf6KFgzGYdgdw==
X-Google-Smtp-Source: AGHT+IFZXGJl9vCA/38nvO5q4mKzdH+dsnkuUuXFqvhgmC9J/jIRkCxTQToRLnncH8s2H/loWvS+7Q==
X-Received: by 2002:a17:903:fae:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22bea4c6beemr181805855ad.28.1744607389401;
        Sun, 13 Apr 2025 22:09:49 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:49 -0700 (PDT)
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
Subject: [PATCH v2 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Mon, 14 Apr 2025 12:08:37 +0700
Message-ID: <20250414050837.31213-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414050837.31213-1-minhquangbui99@gmail.com>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
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


