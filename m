Return-Path: <bpf+bounces-56109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC9A9154A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0256446A9C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC1224239;
	Thu, 17 Apr 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAphGrvB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21521D599;
	Thu, 17 Apr 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874986; cv=none; b=ixbL2zAWkQ5lksyS7v7IOEIlzMecFbQG0eIKqXjRNdrbSI0gxqMuwrb3Nd/VENnDnnoEICiwwLJb4YOWWT+9Z3UessbjZfO0NSu5A1cFCSivlTtQ9YZ0VZsN61tBLPkQ7P7TN/lGuGyjzdKqvq1OtkEgCERG2rhRdhypi01Z0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874986; c=relaxed/simple;
	bh=8TizWOwqu3GwN2fiGsHw8X4OMKIAXAGE1CXOpps+ka0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/scuB5GseJzNA/Mgqhma93jVyGo5rH1K11OvcP8j1gbeAg48RSw6T/1OJ2yIw8UNrYVIxEa2gja7gVDB7kJv/4SSLbKKmwK+HZPcKoVD3LS+4X5P954+2OrMIJ4I7CFUlzdInfekFPIHD+Zr39HHIAvAgsRlZnybzdkHEeMQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAphGrvB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso561702b3a.2;
        Thu, 17 Apr 2025 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874984; x=1745479784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJO7LyGExRfq4nKL5SVSlHdNbKD8n5gs12N9jLBapQU=;
        b=QAphGrvBTit428FaKJPfaL3VfMQLv9HkiC1R9pITU2ZgCK6BHURrnwhs9mja2phxxq
         CeVE+tBGc1JVlNzvHlcHCL231ZLxr3sKfr0URdZfVv0682Mn4D4dBfcrHtL7wqRyfg+p
         30EoR8eZAdPt3cmY4qH6hsYIl5vFeuyclidBNHA7d8lKm+p8BDMq4Aziyfn4hqh7CzuX
         AYvBx+CVk5OvJ81hmelQ+zZI/yvvSysgCRbRa14GgkbF8K6NlyDjX6GCxUXReaiX6FgS
         8OB35kAtdcDP0ss6IedFHisV/Mhs/UQ1N8uelUlPYE985woIToGQHZ8oAhnN/d9HfAvf
         YMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874984; x=1745479784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJO7LyGExRfq4nKL5SVSlHdNbKD8n5gs12N9jLBapQU=;
        b=dbMfN1Beq4QrPJ0AAdLHEg2OmCv9kVlb8sP+CD+eWUVbYZ7O3eEK4o8F8UkAI6DZ8D
         KdYWFBi6OVNyZA8cUdhRfiGhX2nEZwWPYUqCH34Z4A0k5N39B0S/2AGWlvocK/SwXm3N
         zgfXWfFYlBRtkuS7GM43ptgui2LZ8W8CFKjUjs3yNR6H2DT2+qi6Biu1/CjxRpqF7Go0
         K5ic59furKALyTfu1qvB54QRJe4un6vm5BfVQ/WA7q08NOgN7tLlXbY+twlclf0gqgub
         f5ly6fVsxOEFIEAuDWNFkIhK/iJ9Mg/I8j2h2iGvdYaN9kuVoGtibP5/ftuVvOu824li
         rtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHh5rJfGCsVqWxW1KqerL4M+48hiR7z/jM49KeDQBn1XwXKYraAwWOinGD74j9XrKIspXTp8hx4Wdk2ndD@vger.kernel.org, AJvYcCXitdyxNBb4hUUmiTbOfSiq1+Fjroo19A0k5vvlP4z6wLY6TLjn4EvMvRkuo3CMhQ8jwc4=@vger.kernel.org, AJvYcCXydzeMs/Ggk5nzUg7rE0+pb7YSH6jdJuD+AVYQjjfyZ0yNZ6+cwOaMqmVR0NVjgUFVA45vUWZk@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8It3L7xD3y3PpCHlMvX/gMDJ9brZCIkuaA2jNTiYXZjrC9vf
	g2NXPiF6pLxw2Gi3yT57Kh1t7fuYq/9YMFz7OigIWEv/g/KiGHWF
X-Gm-Gg: ASbGncvsHPh6DY4Wq/EK2ncVBLLYRlr4Ily+W7nbKbCaX+JqrnskNJDA5bCVpi/1het
	E2Mh1ULGl2u5I5CsJJxpXe+5XBnDSonjgI+iMavuMdqh/C7enXQJt6YgHjIYmvFwWwzwL2mitUG
	Ab4GFCkbA/3fhrFTh1C3/JI1XHE1xJ5egYHrgSlTTZVDOn4705FLNtHoOBfb8MOcfxgBdIUlaMp
	EcydvqbqMekvEU45IvSFfyw4l5EPDUoXaWfBJRSEeP+w3BYYWTpXz4uboDiqxfe0DVrdCGyIQRu
	yAbYp4VmaoxMJLsc0w2fMnNF4jAEXghz8MstbCnVWVpil3TRQKX2nWZL
X-Google-Smtp-Source: AGHT+IGNH4XYkq81bCriDB/5ZWI5rMHEk/ZZFNYuEACnhmopqi5kSRd+SZ67knR5813pGgdy8GwUJQ==
X-Received: by 2002:a05:6a00:2985:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73c264bf96amr7064882b3a.0.1744874984214;
        Thu, 17 Apr 2025 00:29:44 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:43 -0700 (PDT)
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
Subject: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
Date: Thu, 17 Apr 2025 14:28:06 +0700
Message-ID: <20250417072806.18660-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
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
 .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 07cddb19ba35..b5af7c1412bf 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_input_xfrm.py \
 	tso.py \
+	virtio_net.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/virtio_net.py b/tools/testing/selftests/drivers/net/hw/virtio_net.py
new file mode 100755
index 000000000000..7cad7ab98635
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/virtio_net.py
@@ -0,0 +1,65 @@
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
+    try:
+        xsk_bkg = bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                      '{xdp_queue_id} -z', ksft_wait=3)
+        return xsk_bkg
+    except:
+        raise KsftSkipEx('Failed to bind XDP socket in zerocopy. ' \
+                         'Please consider adding iommu_platform=on ' \
+                         'when setting up virtio-net-pci')
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
+        try:
+            xsk_bkg = setup_xsk(cfg)
+        except KsftSkipEx as e:
+            print(f"WARN: xsk pool is not set up, err: {e}")
+
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


