Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EED93F43C4
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 05:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhHWDN3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Aug 2021 23:13:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48192
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233843AbhHWDLj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 22 Aug 2021 23:11:39 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5443C40316
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629687744;
        bh=mu4K9UEbVVgKl8wqKqQriHgKtmS1iIjJ4mnsH+d8LhI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uhITjlCfwpl74B8LkNa3N7830qMD2izkZn7lBBUakdL7+cY83m8JT1MUoKiAK1l02
         EAAtV2HMhN5E+GfrMgjXj/WdwiUQjss5LCpUvSFbJcUelDTtI9i3AvnXsM5bdgtUXQ
         iIbKFMs7qvjXqB0q5y1LGJ+gbiZfMZE3jS1/jcasgAYsntnTjYGcgvPnx2FpBfhpFP
         iPMi78BqFS5Vz+kCRX58qYxIeNBlE8ZJJQGrimPsGA6qH6XNmL2Hm9nVtDnZPOPwT6
         9sUChxZdKIQ78P75zFK8gnOiW48X6XPQqK1pbijpsACw7xVbZdyLOQi5zZIz2KrypW
         5fR6cxHwj0BTA==
Received: by mail-pl1-f198.google.com with SMTP id f17-20020a170902ab91b029012c3bac8d81so3680887plr.23
        for <bpf@vger.kernel.org>; Sun, 22 Aug 2021 20:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mu4K9UEbVVgKl8wqKqQriHgKtmS1iIjJ4mnsH+d8LhI=;
        b=M6DrSzKivAbhkjxHhjZToE4wX16C8CrfVcX/Za87KinzZnuXhFmqB1gWSZ+X8v9Ae3
         c7PcIcBlmvYdmZdBfTFs8bJrtr+QBJmbUL+lpSX6J+pAJQXQbVxd4NoqJoO3KjklkYwc
         lJy1Ff9/3NphAnCscr27SUGoFHQtSSR8xKXm38xr6k30Ykw4uyHrLa0NesehLTsYGwWE
         ByGOeEltfwJG3H3WcbD+2hGLuaDc7WfXQP5VVJVgivrDPLVAdkKnLEYXpu/lyTHvL6Eb
         A3AD0CbS7v8Ltpwb2AzKYe21gq3LQ+hML+Vag2MhUsmprA/+4MWHv2Zix0Sd7omTLo7/
         uRYw==
X-Gm-Message-State: AOAM531vYQg3Q6oKk+C4PewY/R827y7THfVrRRjW0yCHVFS6HFkIFM+k
        Auu17U+CJMR8S6Eg55JiWQYyLAlCJGWQsnSbaCnhvUftrYM4yaLE/4ign8YpByEOjyBx2cbHP/C
        iZ3ffQ8gm/TAQdMhlB5xt7cR+aTFB
X-Received: by 2002:a62:5304:0:b029:3c7:9dce:8a4c with SMTP id h4-20020a6253040000b02903c79dce8a4cmr31320752pfb.37.1629687742871;
        Sun, 22 Aug 2021 20:02:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+vzGPc4KrjtFTFTzCJYdN8VamfWYiJRRG4JYPzYCNxJQfvTUy+Dzq+sDO9ovEM8y9xdHDjw==
X-Received: by 2002:a62:5304:0:b029:3c7:9dce:8a4c with SMTP id h4-20020a6253040000b02903c79dce8a4cmr31320728pfb.37.1629687742612;
        Sun, 22 Aug 2021 20:02:22 -0700 (PDT)
Received: from localhost.localdomain (223-137-217-38.emome-ip.hinet.net. [223.137.217.38])
        by smtp.gmail.com with ESMTPSA id y7sm12655675pfi.204.2021.08.22.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 20:02:21 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, hawk@kernel.org, kuba@kernel.org,
        davem@davemloft.net, kpsingh@kernel.org, john.fastabend@gmail.com,
        yhs@fb.com, songliubraving@fb.com, kafai@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] selftests/bpf: Use kselftest skip code for skipped tests
Date:   Mon, 23 Aug 2021 11:01:43 +0800
Message-Id: <20210823030143.29937-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are several test cases in the bpf directory are still using
exit 0 when they need to be skipped. Use kselftest framework skip
code instead so it can help us to distinguish the return status.

Criterion to filter out what should be fixed in bpf directory:
  grep -r "exit 0" -B1 | grep -i skip

This change might cause some false-positives if people are running
these test scripts directly and only checking their return codes,
which will change from 0 to 4. However I think the impact should be
small as most of our scripts here are already using this skip code.
And there will be no such issue if running them with the kselftest
framework.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/bpf/test_bpftool_build.sh | 5 ++++-
 tools/testing/selftests/bpf/test_xdp_meta.sh      | 5 ++++-
 tools/testing/selftests/bpf/test_xdp_vlan.sh      | 7 +++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index ac349a5..b6fab1e 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 case $1 in
 	-h|--help)
 		echo -e "$0 [-j <n>]"
@@ -22,7 +25,7 @@ KDIR_ROOT_DIR=$(realpath $PWD/$SCRIPT_REL_DIR/../../../../)
 cd $KDIR_ROOT_DIR
 if [ ! -e tools/bpf/bpftool/Makefile ]; then
 	echo -e "skip:    bpftool files not found!\n"
-	exit 0
+	exit $ksft_skip
 fi
 
 ERROR=0
diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh b/tools/testing/selftests/bpf/test_xdp_meta.sh
index 637fcf4..fd3f218 100755
--- a/tools/testing/selftests/bpf/test_xdp_meta.sh
+++ b/tools/testing/selftests/bpf/test_xdp_meta.sh
@@ -1,5 +1,8 @@
 #!/bin/sh
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 cleanup()
 {
 	if [ "$?" = "0" ]; then
@@ -17,7 +20,7 @@ cleanup()
 ip link set dev lo xdp off 2>/dev/null > /dev/null
 if [ $? -ne 0 ];then
 	echo "selftests: [SKIP] Could not run test without the ip xdp support"
-	exit 0
+	exit $ksft_skip
 fi
 set -e
 
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh b/tools/testing/selftests/bpf/test_xdp_vlan.sh
index bb8b0da..1aa7404 100755
--- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
+++ b/tools/testing/selftests/bpf/test_xdp_vlan.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Author: Jesper Dangaard Brouer <hawk@kernel.org>
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # Allow wrapper scripts to name test
 if [ -z "$TESTNAME" ]; then
     TESTNAME=xdp_vlan
@@ -94,7 +97,7 @@ while true; do
 	    -h | --help )
 		usage;
 		echo "selftests: $TESTNAME [SKIP] usage help info requested"
-		exit 0
+		exit $ksft_skip
 		;;
 	    * )
 		shift
@@ -117,7 +120,7 @@ fi
 ip link set dev lo xdpgeneric off 2>/dev/null > /dev/null
 if [ $? -ne 0 ]; then
 	echo "selftests: $TESTNAME [SKIP] need ip xdp support"
-	exit 0
+	exit $ksft_skip
 fi
 
 # Interactive mode likely require us to cleanup netns
-- 
2.7.4

