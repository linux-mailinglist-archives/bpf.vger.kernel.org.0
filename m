Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC092CC9BA
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgLBWkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 17:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLBWkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:40:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC88C0613D6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:39:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so5839870wrt.0
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56zwlFn3s580XsICf7QuJIey5v9E28+9gH7x/gZVe/A=;
        b=QYbejiIHYR+hdUzcL/MiTLNvsm2o5i3z8/ZpXeiqfJixdvzAYwbijDk6OgVtSZbxkc
         +rl+rzq6iTr5NpCsvuxba8gaYnPrf3N1hPT0cfOsr8mH3NMx9zp/o9XWkXLRFSNe+9mb
         7jMqWiG6rAc9Lt4SEmAR3OOW0DIIqWLQl0o5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56zwlFn3s580XsICf7QuJIey5v9E28+9gH7x/gZVe/A=;
        b=sk1G6ZsGRLK66SLO4D79T8qdvGo0MRPjOr6VjtwytuVmn24Uw7atWH7BMvtg7jdQxl
         4iAF5s3oQVx8gGGJTpgazPFy9T5lW/fgytSNIe5sO7VfcARlxud/P41kBAbeOuDawnJI
         C4XcZXU4Nx/iLde8fDK4WNy6MQzg3U4TpTiKjq7IcPT2F8Dgqi7O6e7qwI2egSmywgtC
         KCuKAfj64g1R+d/BMKZo6y9xm8yUfT1g5wd0pkZWNffZ0WoFR4m5Xwb/PLXXMSxwvW6y
         Xiyy/vLDF2SvbtBLKHH3p7x96Ao1V2DP47MXYTA2UrnEH4cJySEfTLcvwNnC2gh1NMnN
         aUSQ==
X-Gm-Message-State: AOAM5309Eu+FZYlBRcGVtrUjBsvNNftCyU3ED6uY5GdeZrTptM7rap02
        F+cd3H4joQhz47fdfx2LDO7EWsu3mFPii5Pc
X-Google-Smtp-Source: ABdhPJxoZ5KaYsNMoFxD8AKpYG+rUXTwzKMNCgtGlTILKdTTcM1NQRL/ZDBq2sAgBlop9zZpVZwU/w==
X-Received: by 2002:adf:f98a:: with SMTP id f10mr331939wrr.154.1606948788081;
        Wed, 02 Dec 2020 14:39:48 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id c2sm113068wrv.41.2020.12.02.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:39:47 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Update ima_setup.sh for busybox
Date:   Wed,  2 Dec 2020 22:39:42 +0000
Message-Id: <20201202223944.456903-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* losetup on busybox does not output the name of loop device on using
  -f with --show. It also dosn't support -j to find the loop devices
  for a given backing file. losetup is updated to use "-a" which is
  available on busybox.
* blkid does not support options (-s and -o) to only display the uuid.
* Not all environments have mkfs.ext4, the test requires a loop device
  with a backing image file which could formatted with any filesystem.
  Update to using mkfs.ext2 which is available on busybox.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 15490ccc5e55..d864c62c1207 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -3,6 +3,7 @@
 
 set -e
 set -u
+set -o pipefail
 
 IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
 TEST_BINARY="/bin/true"
@@ -23,13 +24,15 @@ setup()
 
         dd if=/dev/zero of="${mount_img}" bs=1M count=10
 
-        local loop_device="$(losetup --find --show ${mount_img})"
+        losetup -f "${mount_img}"
+        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
 
-        mkfs.ext4 "${loop_device}"
+        mkfs.ext2 "${loop_device:?}"
         mount "${loop_device}" "${mount_dir}"
 
         cp "${TEST_BINARY}" "${mount_dir}"
-        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
+	local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
+
         echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
 }
 
@@ -38,7 +41,8 @@ cleanup() {
         local mount_img="${tmp_dir}/test.img"
         local mount_dir="${tmp_dir}/mnt"
 
-        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
+        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
+
         for loop_dev in "${loop_devices}"; do
                 losetup -d $loop_dev
         done
-- 
2.29.2.576.ga3fc446d84-goog

