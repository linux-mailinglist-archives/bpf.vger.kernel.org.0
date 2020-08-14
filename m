Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B57244EC1
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNTQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgHNTQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 15:16:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3ADC061385
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r13so4928342iln.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Wp6t4uQBQ5dF3zDMIDTsLP9qXJPmzukRhj8KqkAa5g=;
        b=AwPk4Pq+mDQDsQPzV638UrKi1S6PPEzapqxfoyOSyVzstuXQpR28qaowIB8XUtrVtu
         H7IsDSrMjySc16VbaVttF+6fu4qo8exS5qDV3EzLL4QmJX+N98isBKFc4F1OvxTlBLRa
         PIvpqWZ3BiMewwtfcmBmaZboMXXTZw10YaMLZP593KQHEyKKdp24wsieb1PA3aLK9gXe
         /Uxt0aYp3eu23Hc0uA+4eSgtj+mELnn6yRUnmrp4J0mV+/d034NnL/ipJYyGtwgx5B5a
         x6E6ILkKCN6iaklrHwujkfVcnFZ44iQugYn6jghr4IbIQtqVHkuojc9UoX/nmAh4/sAy
         l/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Wp6t4uQBQ5dF3zDMIDTsLP9qXJPmzukRhj8KqkAa5g=;
        b=ugfE6r7gnMguRRBLbdyiv+Yw3XDI7eV35uQmTl5KGC7dmozQCF9X7fBqYGGCqEbAWu
         yeaXZ38KVYMgLH1JkuJpU6O3kB09CwIpsvGoyy1Y2TxFBJQlOfwBTQGpEzM5Q+UNmClU
         MWvVHRxpY/FtY5unmEEI+OGqjefJn4bXb5lWU2JqWo9Id6FYUCgjGeWtBITnZ6szlqfZ
         R/xsM24s6Digbqi6hxfAQqaJu5jULotDsBCfrosiHADLuBn++Uxxt8citnVxxmbQu82f
         lMqfC84sodgYtt3GIZXrfI0BMrjWqjdk2PLccVCOnV+hnHaXdiwLrpHR/mfatIk2C2o0
         o7PQ==
X-Gm-Message-State: AOAM533jZqs2O1hFGLkUnUe26gVWarsFg43aLIOf6tlTVdab9BpqWZ9V
        +o3pfvkB9x2o+NgFn+XMgdl5afXeRcK3dw==
X-Google-Smtp-Source: ABdhPJzhvgnia7DjBgHzkNhml8UKq3CP4fchQgCEgGzOIGwHgEzcWJkhDVPiXolpdDQQqQh817uvTw==
X-Received: by 2002:a92:cf09:: with SMTP id c9mr3890308ilo.38.1597432566374;
        Fri, 14 Aug 2020 12:16:06 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id f15sm4521028ilc.51.2020.08.14.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:16:05 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: Test bpftool loading and dumping metadata
Date:   Fri, 14 Aug 2020 14:15:58 -0500
Message-Id: <58804d7707fdd2918654b86f5235b201951aa8a9.1597427271.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597427271.git.zhuyifei@google.com>
References: <cover.1597427271.git.zhuyifei@google.com>
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
index e7a8cf83ba48..5f559c79a977 100644
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

