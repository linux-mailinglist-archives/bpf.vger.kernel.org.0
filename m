Return-Path: <bpf+bounces-68258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495BB55730
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC63D16ED94
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5234F473;
	Fri, 12 Sep 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMhclOse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFE34321A
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706851; cv=none; b=dCT060bGEJO+vswwRRCE5bkjUejhzMTHx5pWAgtS6mfwNV5Hz+tvjKIKJknyYLu+BSiqcdbpEZh1i7Gm/3L10IIq+iygYzdiVMUMOR75vE5PNeqN/wb9OfqTV/69moH7I1GP4eJtseh3XicK7dTaE0Hnk9m9cRGpxOkVqzAfU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706851; c=relaxed/simple;
	bh=UaxWZRT2eVzBCGKMziU2Aq9Id91zLIcnt32JB283AaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0Hqu/D6+pE1hx8VHVJBr6dJI2Vt0BdE9hoaaU4pD+z12tal4E3oIHGQdKWmdM6TJW3YOoHScCWHL2maLj3MAnFdoAcKXr1tiWgCyLazndTs5FBj56xyB1deJKk15YpPO7uPH32eh3tv8NNy/avfP3NNgEFwONQJvqdV7Y4+whU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMhclOse; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso1668240f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706847; x=1758311647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crP5kybyDKEP1L3Fsm57wKH5BFdIt0syo+qIG2jEqhk=;
        b=mMhclOseYfvl0cVXhPsgKksq+KCwHXTcQEx/CbGjJcA842LJo3sh8SJ2HiBFPdyIb6
         FWH+LD7NLongLCEUYafG5+L06PRXcbjvlzmEu+IBfH0fy1JsF8lieMSGYccPhjJhbFrd
         o42ijR1lnTljOjxydmiyGRh6szSXeLYS+1lOGoxjakPfUF1xX2XzaPvAPmA47cGVrY3Q
         j13hO1dTfJWDjlTVCO0yZ1uXOTUS0+LvP7QJRY4SaqjB4ai7EB1AMtEYICwn8tRRVKjq
         0PMSByvAHCN0o7KU8xcnN94Zf2DJPorJVqSRvZRbvzSCiRJUVoERPoa90rFVAiaxfYTa
         geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706847; x=1758311647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crP5kybyDKEP1L3Fsm57wKH5BFdIt0syo+qIG2jEqhk=;
        b=bBovivJagrGj5pLPIGOZ+tahPVPIXgPNnuo8kP0RLlb/zb0n+/OdYlLdAf5Yzq9X5V
         zKqjXNPTaRCSjbWbiTJFEjD6z+0ahZiweXj7mvRkklNvUIdY4uFwNZzRfwqgNiKu/YFI
         NypAqF8KuNNebx68EPwrJzYscS/1UScPVPPeiXJnVlS1I0WRKWcpYCSnCrCdY3ZybXce
         l2UKWQAH6tP6EbXOt7qy7nG7f1kky3VZALeUpuHEHIwCQPfC86xGRcaC11GtMv82GXIQ
         yDe1kv7KElnQotHXPew0WPkwlLl3D4VlsfCBdHMENMrsOR/fbstpvp/5UqMJSG06yU5T
         zfPw==
X-Forwarded-Encrypted: i=1; AJvYcCWJss9mAtEvWzbeQJSWuWVDCG1VSFa2zyWH1UAj4cU8SIBBbbxf7I87ewcJBq1lvEkwsEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPJPUjrOKECIgnXVff/gzM69eecKWk8EBiGjXS4RmsHavh82c
	4H4zEbly8kQllYwSqEpvn1g1RrUEjrAu99ILGnd7xtO6vI+eJjcdNmue
X-Gm-Gg: ASbGncu9yp68R0C/byEntdT03ChMM0G9M2aCnihv74mt1CpjIzblXu0gMCC4mNlPnQh
	yRA9pngniTwqN1apTY/4Jvyb320I7OOtJA+7Jze+x1VNryqUELKmm2BEfGP8PbT3j5eXRPvr00O
	hZdRAdlZp8Vb6JPJkq6pZHX/dEpMhj3Xzeq24Ne8a3mqLuafoBLee/6AfovTcwBGL83tf2Px9jK
	1Qw2RVsepzvgbRaLlhywBn81okACwdhRC/XP5XFBwHc4sF/BLd/rGXdQk80ueZ+C8W1iDmYJHiB
	D5jgCofdV1uPZiWmqtvRR2Agv5a9oPXgk9SlKFrn+ItfCBIuMWie1HUL6PkZmAFvD2Bt7NiRJBi
	yoNHd7NoVZRYKObnhPIyKGYrV9a/M0BSyFrWl957OOtNBSjYJ0VwG5CfWMEJWBsnZ6TqN8vZm7B
	9ek7NP+YA=
X-Google-Smtp-Source: AGHT+IHYbSxBKDnneqMGe4B4GqdstQRPwP2TMBkU5KGjwaP3qxT6Gii/ajCV1viHAEQt0HDASC1PLw==
X-Received: by 2002:a05:6000:40cb:b0:3da:d015:bf84 with SMTP id ffacd0b85a97d-3e7659cc7e2mr4361632f8f.25.1757706846599;
        Fri, 12 Sep 2025 12:54:06 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:06 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 10/15] selftests: net: genetlink: add packet capture test infrastructure
Date: Fri, 12 Sep 2025 22:53:33 +0300
Message-Id: <20250912195339.20635-11-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for monitoring Netlink traffic during test execution

Require CONFIG_NLMON.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/Makefile    |   6 +
 tools/testing/selftests/net/genetlink.c | 234 ++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 tools/testing/selftests/net/genetlink.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 69c58362c0ed..0c325ccc5f03 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -71,6 +71,7 @@ TEST_GEN_FILES += bind_bhash
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_PROGS += test_ingress_egress_chaining.sh
+TEST_GEN_PROGS += genetlink
 
 TEST_FILES := settings
 
@@ -82,3 +83,8 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
+
+$(OUTPUT)/genetlink: LDLIBS += -lnl-3 -lnl-genl-3
+$(OUTPUT)/genetlink: CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
+
+EXTRA_CLEAN := $(SCRATCH_DIR) $(OUTPUT)/genetlink.pcap
diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
new file mode 100644
index 000000000000..5be9ca68accd
--- /dev/null
+++ b/tools/testing/selftests/net/genetlink.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Netlink and Netlink test cases
+ *
+ * This test suite validates various aspects of Generic Netlink and Netlink communication
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/genl/mngt.h>
+#include <linux/genetlink.h>
+
+#include "../kselftest_harness.h"
+
+#define MY_GENL_FAMILY_NAME "TEST_GENL"
+#define MY_GENL_CMD_UNSPEC 0
+#define MY_GENL_CMD_ECHO 1
+#define MY_GENL_CMD_SET_VALUE 2
+#define MY_GENL_CMD_GET_VALUE 3
+#define MY_GENL_CMD_EVENT 4
+#define MY_GENL_CMD_NO_ATTRS 5
+
+#define MY_GENL_SMALL_CMD_GET 0
+
+#define MY_GENL_ATTR_UNSPEC 0
+#define MY_GENL_ATTR_DATA 1
+#define MY_GENL_ATTR_VALUE 2
+#define MY_GENL_ATTR_PATH 3
+#define MY_GENL_ATTR_NESTED 4
+#define MY_GENL_ATTR_MAX 4
+
+#define THIRD_GENL_FAMILY_NAME "THIRD_GENL"
+
+#define THIRD_GENL_CMD_ECHO 1
+
+#define THIRD_GENL_ATTR_UNSPEC 0
+#define THIRD_GENL_ATTR_DATA 1
+#define THIRD_GENL_ATTR_FLAG 2
+#define THIRD_GENL_ATTR_MAX 2
+
+#define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
+#define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
+#define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
+#define PATH_PARALLEL_GENL_MES "/sys/kernel/parallel_genl/message"
+#define PATH_THIRD_GENL_MES "/sys/kernel/third_genl/message"
+
+#define MY_MCGRP_NAME "MY_MCGRP_GENL"
+
+#define GENL_CTRL "nlctrl"
+#define CTRL_ATTR_POLICY_MAX (__CTRL_ATTR_POLICY_DUMP_MAX - 1)
+
+#define PARALLEL_GENL_FAMILY_NAME "PARALLEL_GENL"
+#define PARALLEL_GENL_ATTR_UNSPEC 0
+#define PARALLEL_GENL_CMD_SEND 1
+#define PARALLEL_GENL_CMD_DUMP_INFO 2
+#define PARALLEL_GENL_CMD_SET_VALUE 3
+#define PARALLEL_GENL_CMD_GET_VALUE 4
+
+#define PARALLEL_GENL_ATTR_DATA 1
+#define PARALLEL_GENL_ATTR_BINARY 2
+#define PARALLEL_GENL_ATTR_NAME 3
+#define PARALLEL_GENL_ATTR_DESC 4
+#define PARALLEL_GENL_ATTR_FLAG_NONBLOCK 9
+#define PARALLEL_GENL_ATTR_FLAG_BLOCK 10
+#define PARALLEL_GENL_ATTR_PATH 12
+#define PARALLEL_GENL_ATTR_MAX 12
+
+#define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
+
+/*
+ * Test cases
+ */
+
+/**
+ * TEST(capture_start) - Starts Netlink traffic capture using nlmon interface
+ *
+ * Creates a virtual nlmon interface, enables it and starts packet capture
+ * with tcpdump. Captured packets are saved to 'genetlink.pcap' file.
+ *
+ * Note:
+ * - Requires root privileges
+ * - Creates temporary interface 'nlmon0'
+ * - Runs tcpdump in background
+ * - Adds small delay to ensure capture starts
+ */
+
+TEST(capture_start)
+{
+	printf("Running Test: starting Netlink traffic capture...\n");
+
+	// Only root can monitor Netlink traffic
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	char command[256];
+	int result;
+
+	snprintf(command, sizeof(command), "ip link add nlmon0 type nlmon");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link set nlmon0 up");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command),
+		 "tcpdump -i nlmon0 -w genetlink.pcap &");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	printf("nlmon is up. Starting netlink process...\n");
+
+	sleep(2);
+
+	printf("Starting Netlink tests...\n");
+}
+
+/**
+ * TEST(capture_end) - Terminates Netlink traffic monitoring session
+ *
+ * Performs controlled shutdown of nlmon capture interface by:
+ * 1. Stopping tcpdump capture process
+ * 2. Bringing down nlmon interface
+ * 3. Deleting nlmon interface
+ *
+ * Test Procedure:
+ * 1. Privilege Check:
+ *    - Verifies root privileges (required for nlmon operations)
+ *    - Gracefully skips if not root
+ *
+ * 2. Capture Termination:
+ *    - Stops tcpdump process (2-second delay for cleanup)
+ *    - Brings nlmon0 interface down
+ *    - Deletes nlmon0 interface
+ *    - Validates each operation succeeds
+ *
+ * 3. Cleanup Verification:
+ *    - Checks system command exit statuses
+ *    - Provides detailed error reporting
+ *
+ * Key Validations:
+ * - Proper termination of monitoring session
+ * - Correct interface teardown
+ * - Root privilege enforcement
+ * - System command error handling
+ *
+ * Expected Behavior:
+ * - tcpdump process should terminate successfully
+ * - nlmon0 interface should deactivate cleanly
+ * - Interface should be removable
+ * - Non-root execution should skip gracefully
+ *
+ * Security Considerations:
+ * - Requires root for network interface control
+ * - Ensures complete capture session cleanup
+ * - Verifies proper resource release
+ *
+ * Note:
+ * - Should be paired with capture_start test
+ * - Includes 2-second delay for process stabilization
+ * - Provides status feedback through printf
+ */
+
+TEST(capture_end)
+{
+	printf("Running Test: stopping Netlink traffic capture...\n");
+
+	// Only root can monitor Netlink traffic
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	char command[256];
+	int result;
+
+	sleep(2);
+
+	snprintf(command, sizeof(command), "pkill tcpdump");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link set nlmon0 down");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link delete nlmon0 type nlmon");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	printf("The capturing is over\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


