Return-Path: <bpf+bounces-56565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC6A99CFD
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D56E19410E4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0417578;
	Thu, 24 Apr 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CZVwc8F1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B94146D53
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454503; cv=none; b=OZMMUOwu8R4Y3KcqOouk5sZhrSZdMaTvHSH1fcqQmjmC5d2KVgfgOlRa5lfqSuvLaTlxRwg4IluzLuUyfIwkqjmbpiBODT1bDfKc0TbwKTT3MwOSXz4q6zV8IEXZ+e7kzDXUJC/QQEu5EB4cOmuqdDIcSdIW2Ur7437kcOpfjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454503; c=relaxed/simple;
	bh=XfejFVfUeNjlcemQvV2FfBGjQHl1uJWERTzwSMmvtPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3/YuHfrf9KAbrQL+sdEtzi9jMjZuwzuuCPqfM2oAK7grhqEt/Ci73A2OMoLyMJRxfGwsZ235B1ZCoOgreVZ46t/C0A57ox6tCJcsr9fBNncK0cefYq1tUIKiMeXy9BRbgt4tJ32wlYGuhSL08EulCugc341h97iAGsTQJ8Qxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CZVwc8F1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so439111a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454500; x=1746059300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fONRRd0VBHmSB/DlTOXXKEWrq2Lhm3txVCS1ybmwFg0=;
        b=CZVwc8F11k7fY5c1ugrngaTYmJym5j4Dcu5OdVucrMo2750HaMBRAzJlzaahoxeF24
         qObiytR+EFDvHzQ/mQn4YBNW1HiPo8u7X12p786Mk9RDWGUriQroOaViSmEGQVAL6itK
         WMNcX5ycXz4pS2dZ+crZncqfLudYrE8R5n55A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454500; x=1746059300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fONRRd0VBHmSB/DlTOXXKEWrq2Lhm3txVCS1ybmwFg0=;
        b=h4uEvaBkAiMgjctU7Q7MKjLwxd3VkkNJl8tqR/nEiIUIuSVC3Ou/rEu6vGZKsPHOgJ
         H1EkFs6SYtk6zcW22Fi1NUOSU1lreO7eO/ih6wwwtD/clCn6FRxaOY77Kxv5CcWmUvrp
         c8pZy2idAd72TalAxoIqY3/T5SAmi3PAm+Nw8JfdFxTxIBcdcRNtSN0jyN+dnv13QniK
         mHINHJHuglWsk/EahKrSuWkTrttizbIkB9S84ATk73WsB1zRWnPd1Wl44gnfpb054ySq
         WTwOi0L9UxFCQSsaAC7hQXFsvizy8LXLZBGLMH/3n4cM35ZpOipOXmWr9xa+886ey6W6
         yjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6yuOOzH6vokmHIX/m3ipMB/Rr26Pc0rGq0AbMN7/vqenN9zinX90Ne49O9QQlmtSewsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmVwtRl0EXrryl0qmPYrWr3AGo7eQD9rZ3JIU+3JjFRtkGkxO
	j4SnatAkJAwpbRdBAJsFCBXmQ3zPvDgEur9Y5CyW2YvuKaDU+F8ZDFyThbphDns=
X-Gm-Gg: ASbGncuspyjNC0DZMAmgbUc8Wu1oh4QolsBC4dngKIm2ykGDCHAqp6bOa0QoDA4h3jJ
	Wa3TYVPlbCAuNpw4XmWANKgq3Z0FHWPLydem0MhzYu0+tEt3uuEhfibDb8vFPlbom8IBlkYIo26
	o5hgohPlHb4QShYV0DgsnRWyl3Z5GPlSUw63Gv8UDJCjvtVixWc2p6YaBZuN9+p+KqJgJlsA3NT
	JE4DLuXJs4TmKyv+O7hbGgnWEac3pcNxI4CgyyDiswxbE2v2nhK8C6GxNWq295Yylr7hurvA2ef
	AR60FkAaV6CKQ3YnbSZKrtM49rpToJidfFnFYUqdI0d7hOok
X-Google-Smtp-Source: AGHT+IHQIolOk+n262eCIIoMGQ54RpktEuMS5r9p2G6tZQeOFE8Ai42mQoK9PW7YbvD0WD0iY5WqEA==
X-Received: by 2002:a17:90b:2752:b0:305:2d9d:81c9 with SMTP id 98e67ed59e1d1-309ed2805d0mr1116420a91.16.1745454500436;
        Wed, 23 Apr 2025 17:28:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:20 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v4 3/3] selftests: drv-net: Test that NAPI ID is non-zero
Date: Thu, 24 Apr 2025 00:27:33 +0000
Message-ID: <20250424002746.16891-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424002746.16891-1-jdamato@fastly.com>
References: <20250424002746.16891-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
non-zero. This ensures that either the core networking stack or, in some
cases like netdevsim, the driver correctly sets the NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 .../testing/selftests/drivers/net/napi_id.py  | 23 +++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index ec746f374e85..72d2124fd513 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+napi_id_helper
 xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0c95bd944d56..47247c2ef948 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,9 +6,13 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
-TEST_GEN_FILES := xdp_helper
+TEST_GEN_FILES := \
+	napi_id_helper \
+	xdp_helper \
+# end of TEST_GEN_FILES
 
 TEST_PROGS := \
+	napi_id.py \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
new file mode 100755
index 000000000000..356bac46ba04
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, NetNSEnter
+
+def test_napi_id(cfg) -> None:
+    port = rand_port()
+    listen_cmd = f"{cfg.test_dir}/napi_id_helper {cfg.addr_v['4']} {port}"
+
+    with bkg(listen_cmd, ksft_wait=3) as server:
+        cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
+
+    ksft_eq(0, server.ret)
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_napi_id], args=(cfg,))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
new file mode 100644
index 000000000000..7e8e7d373b61
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+
+#include "ksft.h"
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in address;
+	unsigned int napi_id;
+	unsigned int port;
+	socklen_t optlen;
+	char buf[1024];
+	int opt = 1;
+	int server;
+	int client;
+	int ret;
+
+	server = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (server < 0) {
+		perror("socket creation failed");
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	port = atoi(argv[2]);
+
+	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
+		perror("setsockopt");
+		return 1;
+	}
+
+	address.sin_family = AF_INET;
+	inet_pton(AF_INET, argv[1], &address.sin_addr);
+	address.sin_port = htons(port);
+
+	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
+		perror("bind failed");
+		return 1;
+	}
+
+	if (listen(server, 1) < 0) {
+		perror("listen");
+		return 1;
+	}
+
+	ksft_ready();
+
+	client = accept(server, NULL, 0);
+	if (client < 0) {
+		perror("accept");
+		return 1;
+	}
+
+	optlen = sizeof(napi_id);
+	ret = getsockopt(client, SOL_SOCKET, SO_INCOMING_NAPI_ID, &napi_id,
+			 &optlen);
+	if (ret != 0) {
+		perror("getsockopt");
+		return 1;
+	}
+
+	read(client, buf, 1024);
+
+	ksft_wait();
+
+	if (napi_id == 0) {
+		fprintf(stderr, "napi ID is 0\n");
+		return 1;
+	}
+
+	close(client);
+	close(server);
+
+	return 0;
+}
-- 
2.43.0


