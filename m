Return-Path: <bpf+bounces-56673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4473A9BF79
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303692035D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A462356A8;
	Fri, 25 Apr 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqsb79me"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1323534D;
	Fri, 25 Apr 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565131; cv=none; b=dXj2+wYmtrmMIDDlaPdccxJWwWqPCNbDxqcfA4gHhv1ppfgo8421HEWeZGZQ1hJW9Mt1Xi+HM8QzwS1z06HQLkhONtxNJdG2edAGqfzLn8A3MHbwbtOPnA74Jfv3Nwmad58xadN5GJDkWNV6F5HWry2o37p3bfXhcrM4RkX6Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565131; c=relaxed/simple;
	bh=2QfJQ7dcrhKuX+Tq551J8RtKTlD3rjHY/Eo0FkW4GEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA8JZsrkUnCWJXs9FBXcTD2LZ7sPZRZP/RkHGchkI4iUzAbcPQfXX5eDqdy2pOSCnr+hhyN0DuSjcmdDY0ngb3El03flLDYyMAF5xra6luqqfTbl/aGSHlhq6KH6Q4MaaLNgL3+hQCT0kT2fWrteAbHmBDUS8ER+Ie/nBFeoM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqsb79me; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so32741125ad.0;
        Fri, 25 Apr 2025 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565129; x=1746169929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KTzXr+eJ6VOU6pnmjI7NKvMZ52qKy79/3M/WgxOiNU=;
        b=Fqsb79meejnPo0TFhO3QPfTLdROsANcGHNXMTExSIEFSoECLjchcJN5JLRjekZHEcK
         50m4p2GhRqUaScycOL6PV6XCnRl0R72dYFIGAvzUVDNSdU7coiia1fMwJmBqrGdMfvaP
         PMxG3EnaVC0NqElkcDg9tHrbiYkHHxeQC1S+TQOwKbRUy88FE08GarCe53oHm+EFaeSc
         HIwMsRgh+0KLEXbu8Z4YgF2Ml40iy3boduyOiPkyCP0pFwZCwDiFB5Cpts13t1qBLWFp
         n4HRTXc/hQVJC2AmtdCZo1Ia6dEeLj8ZKfvxwBJW/xY9a2NMvm7vyZl/InsIoPvFQVcn
         +mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565129; x=1746169929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KTzXr+eJ6VOU6pnmjI7NKvMZ52qKy79/3M/WgxOiNU=;
        b=myiESHk9gCf5A+KfyAqG4EU2/gg4B9ZG7xIEdPJ9BwrxD4mw73sVvlb8TAKabF0tEM
         j7rqEPOgsFPiX8kt26iRXtYoAobzYX7mD34dJJhVHqhizwNfee7lR8w2kR+QgWcvVaNx
         VnYJnbktsELXL5eEDOxJ3Zxwu0FahuBBx0AEhsrlma7zkkjray93+u9XrzpmWy7Qt5dN
         qxDPvk+umh+oA+lC2H8fnPVUjxN+q6sdBpgMBgw4QcJdgu6PYqgjkTY37Or2+o1FH51o
         2bZoTGOmRt1cD/ZBJat8uHGy4gmjfWyPVJoX/i+Yj215m9bKClC9swVGA1TzbRYCMGKS
         DZzA==
X-Forwarded-Encrypted: i=1; AJvYcCW6lkdgfMiwhARV0N/ktNl27LddVB8Rt9mgNzJc99l/8dyrvcwJJr4ODUVS2chA3ZrGoac=@vger.kernel.org, AJvYcCXYbEj/WyQdPn9O80gjXFaxheA6t6YBVIbc1w7fwboVq/Im6gplvOE4YncesJ16GGcAKnVO3ggu@vger.kernel.org, AJvYcCXohx6xmf/PYWwlvLmXn3/AB+QJVkJFTtIgpMVI4yirKaPSXDK/r6F/oY8X3desFWOBCgfELozgOj/wd+Lj@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq5U6zrXON4vh12YrCNJyfEsSVlmTsT50cg++Z+U6S6NZqjBu
	Lbe6mLViKSyEyaQRmDXXu+cfahPYVdEfD6laJ/xXEE6GvjdWUlZq
X-Gm-Gg: ASbGncttQa9Hv6/hzgW1178kPIPs8F/Yeudy3l1ZYoMrYYlJO5LpG5njgmsokxdNHh4
	CA20Cf0Mx9NkZ8HHHDoibLcYnmNG47/s4fmH/nwi81+sJ9VKnSzhFvy6Yqiwhw8r2ztH8hJ8XQN
	wCWGWKYvz5w7z5Xqfz3Pys8cGbQ/LZ1/3ssOmfkyvJOQrWe3r4nqrfa51xjOXqjBuOuht1lOx03
	8bIG16R/8e63xLhjyZUuDln7820hSLxdxm4qhjZPqj+lsqGgsdM2tAfn0FqLAknqVcfhgiyDsZP
	mYjKdt3Y1UGXosBCPYxWPW7KMZBG3oNzwD7oYwZVYIZ97MkE1WvppOtr
X-Google-Smtp-Source: AGHT+IHbdQaaI+TlUD8wQDF+D7xEsxbXV0AtWO6xb3b+HZ9IeIZ1AgtMWePNiAGk/CXJX9Q3ks1G9w==
X-Received: by 2002:a17:903:94c:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22dbf62335emr20904505ad.42.1745565129029;
        Fri, 25 Apr 2025 00:12:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:12:08 -0700 (PDT)
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
Subject: [PATCH v6 4/4] selftests: net: add a virtio_net deadlock selftest
Date: Fri, 25 Apr 2025 14:10:18 +0700
Message-ID: <20250425071018.36078-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
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
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
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
index 000000000000..d19d1d518208
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
@@ -0,0 +1,60 @@
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
+    try:
+        return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                   '{xdp_queue_id} -z', ksft_wait=3)
+    except:
+        raise KsftSkipEx('Failed to bind XDP socket in zerocopy.\n' \
+                         'Please consider adding iommu_platform=on ' \
+                         'when setting up virtio-net-pci')
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


