Return-Path: <bpf+bounces-56583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8502A9AB00
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D11F1943011
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654D22B588;
	Thu, 24 Apr 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kROr0HKm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3791214813;
	Thu, 24 Apr 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491809; cv=none; b=fepRGVYK/30iOUxC42bOdo6hwkWW7l1EkFIWbmff4fYGfWlnG2uPZoD1HL+l5vlkUCcLckdA/7rp+4z3JuOqKS3PCDrXcZscp0xO2D/Ysyvh8JiQVxt6vkFDKSHNX3swfteWuD9wXAG6nlOQBCTMQEziJNqJBmHW2zaZttd5+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491809; c=relaxed/simple;
	bh=MnqykwymzwHERo6nKnawUDD2AsCMTGXbvqod8pxseEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3uqwtXTP7FzQzCYGZgPW+CBK/OepfQDF8fik5EfGlV4wyewEWy8CNaLlQK7J9sUjfxjzeJRlWBhC+zI3DpIWUJwtstrwEogFUcH+Qrt77aQe978NmnX2smWcWT+3S27Dm70EBrQjD0PBPO18YkUnrjTFzPUbn0x3gXP1GW+Zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kROr0HKm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736a72220edso853007b3a.3;
        Thu, 24 Apr 2025 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491807; x=1746096607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otKFGdVb+uXNzYPZbaE8wgcboqR2b2qzgL6mIMQa4V8=;
        b=kROr0HKmWLVVs7sEVTEB9374U+w5XFy0aNb27OXwo28n+O2VMfdVbxuHI2xG8ueDqF
         nmH/yOvGfY6PaCAIhkphAMwZDJAqxUQ/3vDtheJlPERVk+N1xBl/vhi0co3Q5qOn29uj
         1sWJUSkEf7WHkQKo6uhJzHe1z1P8lNRXVI5IFSOFCb7cA5oRG832f5Tfi71xnDQaFmup
         9mE3kSIpZQUod78ZzBXj3quYhNfP/6ZioPDS5pK7fwddE3OHiNuvxx5KPr3leL+BlCkA
         WaLaT1sO/05Y6t1feglH8h94qQIxqmq0How7eYN1DCIFvhuvwFUHgD0tWt82A16y9BJf
         Ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491807; x=1746096607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otKFGdVb+uXNzYPZbaE8wgcboqR2b2qzgL6mIMQa4V8=;
        b=oNX5KgLQWS3u+rUW4pB1EtKGoYDZXzaWOaB064S3bJl4jEi4hKr3Il3/wFNEdhr0Ay
         Ljq3VfD1/jhCegxtrKxRnY2TeXF26tXAuAFP3E9xIKbmuwrLGc3zJ9w3qdIzKStM95Dl
         o4vVHvKmhvSvoQ02A65+zrdjUENRf8Zb97QW5ljwRqZS124O3SLjMUHbwXEIYa9CcWzx
         y73smhJEFlEyqee7MtXhjI9SKOraBUsfft1FoHo5feNtzbff3sK/4bgNnR8FUrPa9327
         R3cyRASiU16ANb89Rd6Yo+iaUuPT4WNJcKXx5x8lZ+ccuES/UbuezbxHdYEvAI+BPWtZ
         /4eg==
X-Forwarded-Encrypted: i=1; AJvYcCUE2ZoRex5Nj7KBFR2ycK3EIhuBaaZn0PF0Oinfwz8k6SFLn155Rs3r2ibPLvgopN4muPA=@vger.kernel.org, AJvYcCVPjIYih1a1qqmuNukYVBMYmKnY8HM42GZ0xvdCk2P4S2N4OZLvG/eEhx4eEnXcyClezteXwjvhummC9K0R@vger.kernel.org, AJvYcCWiGuUa2NH16fraoZ1N3CRFuFxfwzXD0unxrBqg+Z1oJzAMqxfObElX+5w2lkMXxKHTO4XHJSkM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7a/KpVGdpw7XT26R7I58n8gjnlXer7CzOfJg88fMrtatOtC2J
	+DYwyTJZ0fxf6+2oP3ZXAoyFuWbUGBOjsR16KEgy7HBa1QaT1y2H
X-Gm-Gg: ASbGnctCBUfLNAG2cLExsroer/UtoXpo2oxAIgEy1j9SkoqJBw++z/bKPbyJydtchCY
	JOC/hURwAKUvPthXfynBxRyNnTIyKaL/dgAOA6dJAhdDXddW7T78Pldur3ojL5myIghvfrrPQEt
	AGSVFhMEI2FgzbIJlHTtZVEec0R+lPaQCooGoOTZa73nEdvBSUHhzK0AMgqqX6F6cuDIy783wts
	ZvCzFka7y15nZGoS2HufcwCbKO3sULkFpT5IhijoYuCfs74uK1sKDZXujQJ+guvCi+ZNyI9WeRU
	SdaFwbJ7EEVO+pbkSEzK8VKopAAyClCucAXjQI1XHEiByF60AbsPRBXp
X-Google-Smtp-Source: AGHT+IGgeHDm6WkVamJnp/W1II7ZDrehvPmtPJEYMjp/1PGWmVR9+feWN1Ivt1NcPJM+kVc7pr6mIQ==
X-Received: by 2002:a05:6a00:2410:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-73e243c6011mr2778211b3a.5.1745491807205;
        Thu, 24 Apr 2025 03:50:07 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:50:06 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Thu, 24 Apr 2025 17:47:16 +0700
Message-ID: <20250424104716.40453-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
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
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 07cddb19ba35..5447785c286e 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_input_xfrm.py \
 	tso.py \
+	xsk_reconfig.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
new file mode 100755
index 000000000000..031de97a974d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This is intended to be run on a virtio-net guest interface.
+# The test binds the XDP socket to the interface without setting
+# the fill ring to trigger delayed refill_work. This helps to
+# make it easier to reproduce the deadlock when XDP program,
+# XDP socket bind/unbind, rx ring resize race with refill_work on
+# the buggy kernel.
+#
+# The Qemu command to setup virtio-net
+# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
+# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
+
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv
+from lib.py import bkg, ip, cmd, ethtool
+import time
+
+def _get_rx_ring_entries(cfg):
+    output = ethtool(f"-g {cfg.ifname}", json=True)
+    return output[0]["rx"]
+
+def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
+    # Probe for support
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
+    if xdp.ret == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.ret > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    # Retry xsk setup 3 times
+    i = 0
+    while True:
+        try:
+            return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                       '{xdp_queue_id} -z', ksft_wait=3)
+        except:
+            if i == 3:
+                raise KsftSkipEx('Failed to bind XDP socket in zerocopy.\n' \
+                                 'Please consider adding iommu_platform=on ' \
+                                 'when setting up virtio-net-pci')
+            else:
+                i += 1
+                time.sleep(1)
+                continue
+
+def check_xdp_bind(cfg):
+    with setup_xsk(cfg):
+        ip(f"link set dev %s xdp obj %s sec xdp" %
+           (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
+        ip(f"link set dev %s xdp off" % cfg.ifname)
+
+def check_rx_resize(cfg):
+    with setup_xsk(cfg):
+        rx_ring = _get_rx_ring_entries(cfg)
+        ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring // 2))
+        ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
+
+def main():
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


