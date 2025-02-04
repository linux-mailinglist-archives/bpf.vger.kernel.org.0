Return-Path: <bpf+bounces-50455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCBA27AF0
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DD1167CF5
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500F21A437;
	Tue,  4 Feb 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CbGRX6lr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52421A424
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696284; cv=none; b=rT2OO8gH/KW5a2kHEW00ZoDAjaihgVoSDwf9PjDka7851vuGwHeIbtClykYhHffe31ApqMtGs49j2jbis/oKsMGOKsnxsW9PvNCJC3nyhnwcBViWn4rToHbd/wXN3rK8GNUFXmYVYUijOtl4IOysbN5cu3HilLJxWOU7ZLe4ixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696284; c=relaxed/simple;
	bh=bYYjg7d9qN/DD+W8ShQxohpoNa08V7gQHkvh2N+qd10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T28z1I1xAxUz68P55ryXmJ+8jH2xYnfEGSDetVg7rhcI5GvYGxdNX4Tu7NicZP2qW3B9cywFJlHeHJK3P/tMoXy4R/0GuaJSZcPh2/EID/NkmPs16lawZBdF62HpdWDOquHyQxkrRMAqdsGDdtUMeG7VLFES+4BP0nNtMl0Ge7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CbGRX6lr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9dbd7d80dso382685a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738696282; x=1739301082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFOiMjg7PXIIN05OHT1LbZo8p0N7HvJ6NT6kMG2Y/FA=;
        b=CbGRX6lrYfpvZ5cjo5OyI4PgwoLmLXzxTolLSC5I+RH0mRXaJq//w6YFaO0VgVitQU
         uHGwG+QmB0Hkg2v7GICi6HHAhXohRnR34cKADnkvTw4X5yeHsWVMAt+BKm2LgfpyOKVp
         Qlw81oVCEkb92g6rjUkaBnmejh65bd09Fl338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696282; x=1739301082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFOiMjg7PXIIN05OHT1LbZo8p0N7HvJ6NT6kMG2Y/FA=;
        b=cx+5pmtWLLrDpSvYbKoM2f++w3DhWbHeyZkcupYLwM5eM7aabJ4qA5lOWDHH95FRz5
         lhznkuskyK5MRyUO8rqVV+PzZfB/Jkc99tF9NEk/zHDjGA7IfxDdnthIwNnex6LpTnOD
         TtYsmD2cfqFyDYQcKGEOcZHDChmR5navIFGYKXB0m8xpnxXvoz/4KwPEwdRPHO3QqDgJ
         kIah2U9uqMraQaB7yVkIVEnOFxq8gEyxWNLz/4C0ULJIVPaL6Hkm8vPQJTYoeNrEL8wW
         bqhzxiqZkAb16R6sfrGQRdpmRbd8ePdVd3EAP9AmpeKrpEiNbgNVEifrIIX0SqDcC8DC
         gtXg==
X-Forwarded-Encrypted: i=1; AJvYcCWUfQu5COnv6yoOeELZiQnnLhC7peSnTTF6tSNdPvfhvOqE5Mfylygjmm+ca5UWyTSfP2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0rcWlFSLcGD575H6rhVXhawfjE5wIczaUjZnxZ+Lfb+lInpr
	OSVfFUyWB3/YWAxzO1B3SFXRmqAGX8ZnZ1YP25Ih5mdGRZFDzZnPytq+gXsVXZE=
X-Gm-Gg: ASbGncthZUXEw7WVW0Ku2QYFiq8Jkkj/cKiBxr3cuGRH+FPjqlhYMez9ikLnvknM5op
	XHTpVScv/tSSaWFZQJ+l2CQdIXysucoJntMnkRw2sRr1hpcc4N7AOvtBi3ZVp0Sz0CkWznK7ReV
	JPE+5icTAuVFp6h9aE9EUw5FcGf6jUZBrugEGvzhf/ayO2V/eT+9D1rOsK4+oc/d0ey/ttHMH/9
	DFa0JuLzwQyko4uoyWwLEV+aYlKxO48lO3pDwByPi1q6dtAl5yJJKORZ2S1rPbiNqiizIl8yKdI
	K7NpFW0Az1xXsdXb4S+xIi0=
X-Google-Smtp-Source: AGHT+IEpjianC0AHZ1rNHL0t9jx7XsDrLsqSgCFmgK7H6tu+yNLQgFiDBSZAMy1u0ny3UShqlFg9Jg==
X-Received: by 2002:a17:90b:1f82:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f83ac00c94mr45359126a91.18.1738696282192;
        Tue, 04 Feb 2025 11:11:22 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5f1sm100749785ad.130.2025.02.04.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:11:21 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v3 2/2] selftests: drv-net: Test queue xsk attribute
Date: Tue,  4 Feb 2025 19:10:48 +0000
Message-ID: <20250204191108.161046-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204191108.161046-1-jdamato@fastly.com>
References: <20250204191108.161046-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that queues which are used for AF_XDP have the xsk nest attribute.
The attribute is currently empty, but its existence means the AF_XDP is
being used for the queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v3:
   - Change comment style of helper C program to avoid kdoc warnings as
     suggested by Jakub. No other changes.

 v2:
   - Updated the Python test after changes to patch 1 which expose an
     empty nest
   - Updated Python test with general Python coding feedback

 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 4 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..ec746f374e85
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 137470bdee0c..f6ec08680f48 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,10 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 $(wildcard lib/sh/*.sh) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
+TEST_GEN_PROGS := xdp_helper
+
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_overflow.sh \
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..55c2b296ad3c 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -8,7 +8,10 @@ from lib.py import NetDrvEnv
 from lib.py import cmd, defer, ip
 import errno
 import glob
-
+import os
+import socket
+import struct
+import subprocess
 
 def sys_get_queues(ifname, qtype='rx') -> int:
     folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
@@ -21,6 +24,34 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None
 
+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+    defer(xdp.kill)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if not queues:
+        raise KsftSkipEx("Netlink reports no queues")
+
+    for q in queues:
+        if q['id'] == 0:
+            if q['type'] == 'rx':
+                rx = True
+            if q['type'] == 'tx':
+                tx = True
+
+            ksft_eq(q['xsk'], {})
+        else:
+            if 'xsk' in q:
+                _fail("Check failed: xsk attribute set.")
+
+    ksft_eq(rx, True)
+    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
@@ -81,7 +112,7 @@ def check_down(cfg, nl) -> None:
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..b04d4e0ea30a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <linux/if_xdp.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include <inttypes.h>
+
+#define UMEM_SZ (1U << 16)
+#define NUM_DESC (UMEM_SZ / 2048)
+
+/* this is a simple helper program that creates an XDP socket and does the
+ * minimum necessary to get bind() to succeed.
+ *
+ * this test program is not intended to actually process packets, but could be
+ * extended in the future if that is actually needed.
+ *
+ * it is used by queues.py to ensure the xsk netlinux attribute is set
+ * correctly.
+ */
+int main(int argc, char **argv)
+{
+	struct xdp_umem_reg umem_reg = { 0 };
+	struct sockaddr_xdp sxdp = { 0 };
+	int num_desc = NUM_DESC;
+	void *umem_area;
+	int ifindex;
+	int sock_fd;
+	int queue;
+	char byte;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
+		return 1;
+	}
+
+	sock_fd = socket(AF_XDP, SOCK_RAW, 0);
+	if (sock_fd < 0) {
+		perror("socket creation failed");
+		return 1;
+	}
+
+	ifindex = atoi(argv[1]);
+	queue = atoi(argv[2]);
+
+	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			MAP_ANONYMOUS, -1, 0);
+	if (umem_area == MAP_FAILED)
+		return -1;
+
+	umem_reg.addr = (uintptr_t)umem_area;
+	umem_reg.len = UMEM_SZ;
+	umem_reg.chunk_size = 2048;
+	umem_reg.headroom = 0;
+
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_REG, &umem_reg,
+		   sizeof(umem_reg));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_FILL_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_RX_RING, &num_desc, sizeof(num_desc));
+
+	sxdp.sxdp_family = AF_XDP;
+	sxdp.sxdp_ifindex = ifindex;
+	sxdp.sxdp_queue_id = queue;
+	sxdp.sxdp_flags = 0;
+
+	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
+		perror("bind failed");
+		close(sock_fd);
+		return 1;
+	}
+
+	/* give the parent program some data when the socket is ready*/
+	fprintf(stdout, "%d\n", sock_fd);
+
+	/* parent program will write a byte to stdin when its ready for this
+	 * helper to exit
+	 */
+	read(STDIN_FILENO, &byte, 1);
+
+	close(sock_fd);
+	return 0;
+}
-- 
2.43.0


