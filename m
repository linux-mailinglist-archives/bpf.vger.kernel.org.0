Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA924B336
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHTJnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgHTJmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A85C061387
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p18so1082606ilm.7
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dw9oaIsYVsMP//1WkW1HJx6Q5+EKILk45et8oS2R3QM=;
        b=sVZlRY07kRjb4dbSVaeWrm/fiscDnw8pwYegx05Vwxe0cbQRHClfe8YYitQLVgLTAg
         poSDmjrHug5HJmAWyo0+r+1cwRrfqP4AioM6V9zvR0Cj+savlCiCceQIfry6T6FGKHGm
         Pl71z9W29U/gX/MrO1oZyrNU0XRx6jmVKtPRC+kc+QvLxFkDnDP2Iga7jgpN8cV2/EGM
         ktCxbqbYDnp7gp6xUWMcMlrOw3IdamupkeV52clZH1mDY8NwaBt8qmYgC+zWzLbdr8m8
         1WZpIhYPPMJW82vky3V3h0vhjqq4m4zTpFa50F5e5LdXP9T4o/Jtk6dHkf4L6+D1ZRND
         5rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dw9oaIsYVsMP//1WkW1HJx6Q5+EKILk45et8oS2R3QM=;
        b=WG+S0O+VAplet0odjEVDohrpVD/Z4K3xiKlpgnZqHr/VMcIuLGZS5Cbxhkmak2c32n
         VBfw0AqNXbdQI6m2FtHyODZ3GEbTmzXBZH7mHMtky8QWRJqBHJfXpFLKtTTDmmzMYAdP
         dUKKAbgXCAQoWfkJDHa2B2bZSEPwtFve0S1XYNMOYjRnriu2dNWRBvF6w4fUM9D6W7Lm
         niytiRZ9z7QwU9GpAp0xHHEyt0urokkIP3OlHsnCsKKNWE95YelHBcNxC8gZw4qI17gg
         dZa22s5EFuAawJmdRPsu4VvKDRcTwep+IyPPYh/hHC7RF16/FCVCRhj0qfaV+tRhrDGS
         wSjA==
X-Gm-Message-State: AOAM531hzYsxQhehkrW1FF7rAq/B+bmag359iJXL71zynvztPMf02FlI
        Ctm6aq4MfqyrZ4Pe4rhRrckqlqxnTB1lAEi8
X-Google-Smtp-Source: ABdhPJy7a2S45kGnGIY3R1X0Oas8sGCXxWlSptQ4hSfIzkBJPi2AhRzJvRFc7JS3XybrOL31XZrJwQ==
X-Received: by 2002:a92:c60f:: with SMTP id p15mr624614ilm.173.1597916539146;
        Thu, 20 Aug 2020 02:42:19 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:18 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Test bpftool loading and dumping metadata
Date:   Thu, 20 Aug 2020 04:42:11 -0500
Message-Id: <788b0e49bd5dfc292b71a57f21cbf010821a0aca.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597915265.git.zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This is a simple test to check that loading and dumping metadata
works, whether or not metadata contents are used by the program.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../selftests/bpf/progs/metadata_unused.c     | 15 ++++
 .../selftests/bpf/progs/metadata_used.c       | 15 ++++
 .../selftests/bpf/test_bpftool_metadata.sh    | 82 +++++++++++++++++++
 4 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a83b5827532f..04e56c6843c6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -68,7 +68,8 @@ TEST_PROGS := test_kmod.sh \
 	test_tc_edt.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
-	test_bpftool.sh
+	test_bpftool.sh \
+	test_bpftool_metadata.sh \
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
diff --git a/tools/testing/selftests/bpf/progs/metadata_unused.c b/tools/testing/selftests/bpf/progs/metadata_unused.c
new file mode 100644
index 000000000000..523b3c332426
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/metadata_unused.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char metadata_a[] SEC(".metadata") = "foo";
+int metadata_b SEC(".metadata") = 1;
+
+SEC("cgroup_skb/egress")
+int prog(struct xdp_md *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/metadata_used.c b/tools/testing/selftests/bpf/progs/metadata_used.c
new file mode 100644
index 000000000000..59785404f7bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/metadata_used.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char metadata_a[] SEC(".metadata") = "bar";
+int metadata_b SEC(".metadata") = 2;
+
+SEC("cgroup_skb/egress")
+int prog(struct xdp_md *ctx)
+{
+	return metadata_b ? 1 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
new file mode 100755
index 000000000000..a7515c09dc2d
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+TESTNAME=bpftool_metadata
+BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
+BPF_DIR=$BPF_FS/test_$TESTNAME
+
+_cleanup()
+{
+	set +e
+	rm -rf $BPF_DIR 2> /dev/null
+}
+
+cleanup_skip()
+{
+	echo "selftests: $TESTNAME [SKIP]"
+	_cleanup
+
+	exit $ksft_skip
+}
+
+cleanup()
+{
+	if [ "$?" = 0 ]; then
+		echo "selftests: $TESTNAME [PASS]"
+	else
+		echo "selftests: $TESTNAME [FAILED]"
+	fi
+	_cleanup
+}
+
+if [ $(id -u) -ne 0 ]; then
+	echo "selftests: $TESTNAME [SKIP] Need root privileges"
+	exit $ksft_skip
+fi
+
+if [ -z "$BPF_FS" ]; then
+	echo "selftests: $TESTNAME [SKIP] Could not run test without bpffs mounted"
+	exit $ksft_skip
+fi
+
+if ! bpftool version > /dev/null 2>&1; then
+	echo "selftests: $TESTNAME [SKIP] Could not run test without bpftool"
+	exit $ksft_skip
+fi
+
+set -e
+
+trap cleanup_skip EXIT
+
+mkdir $BPF_DIR
+
+trap cleanup EXIT
+
+bpftool prog load metadata_unused.o $BPF_DIR/unused
+
+METADATA_PLAIN="$(bpftool prog --metadata)"
+echo "$METADATA_PLAIN" | grep 'metadata_a = "foo"' > /dev/null
+echo "$METADATA_PLAIN" | grep 'metadata_b = 1' > /dev/null
+
+bpftool prog --metadata --json | grep '"metadata":{"metadata_a":"foo","metadata_b":1}' > /dev/null
+
+bpftool map | grep 'metada.metadata' > /dev/null
+
+rm $BPF_DIR/unused
+
+bpftool prog load metadata_used.o $BPF_DIR/used
+
+METADATA_PLAIN="$(bpftool prog --metadata)"
+echo "$METADATA_PLAIN" | grep 'metadata_a = "bar"' > /dev/null
+echo "$METADATA_PLAIN" | grep 'metadata_b = 2' > /dev/null
+
+bpftool prog --metadata --json | grep '"metadata":{"metadata_a":"bar","metadata_b":2}' > /dev/null
+
+bpftool map | grep 'metada.metadata' > /dev/null
+
+rm $BPF_DIR/used
+
+exit 0
-- 
2.28.0

