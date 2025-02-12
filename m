Return-Path: <bpf+bounces-51251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873DA3275E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF72165ECC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FADD2512EB;
	Wed, 12 Feb 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AkBlLJSS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA722068B
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367733; cv=none; b=qOs2h1UsaDH7sFLkO9uoXITpmTFYUFY5jwLt4rdx3PlTKl3w/zoBpJ+TH5sUyPd9Q24DpsmaL8ZJGhMPChZ46OqA+bN1HsjEJZIIz/R3PxUY1gHq00AU+WUXWaUkoEAdczJk1P92V2qS6zBtXNyRaXDl54GQmOuaBuh1UCruY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367733; c=relaxed/simple;
	bh=B/bkdcPECmOVVcvnmIyV3GZdC0bKkk+lmx8zg/q5iJ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv8Dcw6RkoxoC9k0STQJ8nDReMP+zAfPZKOg2wwy8KzniCgOjNCvEUYort9Nf468nlEfM4DPE4hdyCX9vMLZFXy62Qqx7t5IIQEFg7EZeZ6VK4jrv7QiUex9TI8ZkD7CQ2uXd7hduTBGwYGEn83KshxgtGu/t+CsnEgIo+cZjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AkBlLJSS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so1167792a12.2
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 05:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367728; x=1739972528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KT2qa2gDnH5KuN6tVrB0wVz27ZkqW61x9pQBjG+eFG0=;
        b=AkBlLJSSnuaC+IR7xIfwmbKKPFbRjSTXUfVNrdNSoVVHpKGfqwGhO3w+m2Q3Z1g45z
         eL78m7ZsFIzjhGkAGd7/DKO0BNSwTMdNgXCTNyunr3gO2dhdSkjclpFbSj3bl91DyTmy
         uTU/0NrG5+YSgVgu7OO45twfbF4w9q6aBjvpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367728; x=1739972528;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KT2qa2gDnH5KuN6tVrB0wVz27ZkqW61x9pQBjG+eFG0=;
        b=i+o7bkUXm65sKmQIIjhqZpOQAWFn+g/mYJiU7tnEOGWWZm34xF2lC3CQ2dbz+fTQmO
         PWbYJYsoVWupdgXBj2EkIw3maSKKFskVdR7s7yT+6wG2+U2bt+z9wMzNEaoqlndvc3Yu
         fjac28VKzRCfoDDkqdgRFC7DbF3Veaq+MdeoVymHvVO7KHtckaaT3byrAxo1z26+6LIj
         B7m9qesmo103FE72cgpnWk68cdyhL8NnSi1dXNW3eIyh+QRsOk08gRp1/rtljzLjwvjW
         Bps6a0fqe2+aHKgQkXfnvDjVgpjxK8pMbAMvMaXt8LZy/x0E7fCFC6+pJyGHzL1uaLZz
         ihpw==
X-Forwarded-Encrypted: i=1; AJvYcCUdB6opztbXoDb3qVQqSS5jmfEMrw2t2qgh5zYsjJxfYZ0wrJVE0Obd+fd0bed2J7zbsNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILi+ouMpDzvYz04Nc0fn9c9E0Wk6rXSYzVAJ6uYBQUAn03bgq
	2MnBMjkmzmZKPkmrjGf6hpYiAzwxkcCzd4Aqjjpqq/3uzb5QnXzhpr+soIDwwaZxBwyo/4bL5K1
	YmEa80ut11FXJui60swN7pXAnAHSvbLCAnSP6DQ==
X-Gm-Gg: ASbGncvPqQ8zJ2Zssmry8IAoik+keOp4KN8JQaoswS31jmYcilBdSpZvewni5qpeGHp
	vVZ4S0UbBohPdsb5gs986lM/7wttbCpb5IHS8o2NsCrYWpqcIZauIyzBkq0MYt5mBU/VdCw/Dz7
	NZiQX9r4/zjQdtl/mJ7QlDiBvN
X-Google-Smtp-Source: AGHT+IGcoiTyC9NI+8g0zyxi1UmfPM3Bz4dg0MpmtDqpzepmOwmidA0CtfUy6XiKLngxQeySMMt41F8C2mERBcXGBdY=
X-Received: by 2002:a17:907:2ce3:b0:ab7:c6a2:7a43 with SMTP id
 a640c23a62f3a-ab7f33d5286mr346061166b.31.1739367728435; Wed, 12 Feb 2025
 05:42:08 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 13:42:08 +0000
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212134148.388017-1-jdamato@fastly.com>
References: <20250212134148.388017-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 13:42:08 +0000
X-Gm-Features: AWEUYZlqLxnwzEvRUqnqijaR1s2qFB9SsPKuvj9xu0tqP7TJOdq69dB2yI1SHVU
Message-ID: <CALALjgyE9BdZHLKWkYt61DKkAGOKqHEiba2biXA1mb-m-k9B+Q@mail.gmail.com>
Subject: [PATCH net-next v7 3/3] selftests: drv-net: Test queue xsk attribute
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Test that queues which are used for AF_XDP have the xsk nest attribute.
The attribute is currently empty, but its existence means the AF_XDP is
being used for the queue. Enable CONFIG_XDP_SOCKETS for
selftests/drivers/net tests, as well.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v7:
   - Added CONFIG_XDP_SOCKETS=y to selftests/drivers/net/config.
   - Updated xdp_helper to return -1 on AF_XDP non-existence, 1 for
     other failures.
   - Updated queues.py to skip if AF_XDP does not not exist, fail
     otherwise.

 v3:
   - Change comment style of helper C program to avoid kdoc warnings as
     suggested by Jakub. No other changes.

 v2:
   - Updated the Python test after changes to patch 1 which expose an
     empty nest
   - Updated Python test with general Python coding feedback

 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 5 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore
b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..ec746f374e85
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile
b/tools/testing/selftests/drivers/net/Makefile
index 28b6d47f812d..68127c449c24 100644
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
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/config
b/tools/testing/selftests/drivers/net/config
index a2d8af60876d..f27172ddee0a 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -4,3 +4,4 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/queues.py
b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..5fdfebc6415f 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -2,13 +2,16 @@
 # SPDX-License-Identifier: GPL-2.0

 from lib.py import ksft_disruptive, ksft_exit, ksft_run
-from lib.py import ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
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
@@ -21,6 +24,39 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None

+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper",
f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE,
stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+    defer(xdp.kill)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    if xdp.returncode == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.returncode > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
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
@@ -81,7 +117,7 @@ def check_down(cfg, nl) -> None:

 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down],
args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down,
check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()


diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c
b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..2a40cc35d800
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
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
+		/* if the kernel doesnt support AF_XDP, let the test program
+		 * know with -1. All other error paths return 1.
+		 */
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	ifindex = atoi(argv[1]);
+	queue = atoi(argv[2]);
+
+	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			MAP_ANONYMOUS, -1, 0);
+	if (umem_area == MAP_FAILED) {
+		perror("mmap failed");
+		return 1;
+	}
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
+		munmap(umem_area, UMEM_SZ);
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

