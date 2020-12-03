Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147A2CDE99
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLCTP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:15:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7735C061A4F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:14:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so5036502wme.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8J/w1vYL09UzAzi8602VoSkrOGO0D/bhvaHOEFu6hMc=;
        b=ANp3Tcj3/UuHs5Rp+fT1drvw4SM1uZ91+FxC1c6RLNMe55T/NHfPLFLRHknW54Ef6a
         GhJnysSFt8TR1uswCec22ItfBPa5Gf5zpRjZkXdmXkQ1ixTfS7xLxzFcj8xs6SGrLks0
         CDYfV4ro3s2IaXqJkJ3LFNKV2KLp9DFoASp+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8J/w1vYL09UzAzi8602VoSkrOGO0D/bhvaHOEFu6hMc=;
        b=KCZcTdDkINOTaF7EpzdODk7vC7djTgnpPNuBdcRJ+jnmvr8W6E/qIpG/nltwrss0Mo
         kLQzMRIjAXaOCXb8GuZL+hhlyh4RkZiNKWpEunsU73HgoSFhFa4wD/+3wlhJRkrBsit2
         2gvR3QvmOsoGJ7iA2Ko176FsVpSOJYmwwwS99SK1LCw0mDP8V9BeP6K+5dV4eRKITzvF
         7b6OVb1lTRcZxIMvok9DbxYG8TIy4JfZFceudaZBRhv2THApqJHqhBVpaO6sAAcozgqd
         0wiaID3upRG0qM68u5O5a8rXzdX8woXGisIIgvUbraaTl4BVU+CtOnTdlqsC6TtL9Tv/
         NE0w==
X-Gm-Message-State: AOAM530VEyihZyQnJQa43Uc5coYrnAn/mwYz0V6C5shQsyycC7tGaJtm
        Ywc0/LcpOjtuxMHIXdcSPA5hRqFIxz0/j6RD
X-Google-Smtp-Source: ABdhPJypqerqINxs8hu/3QRjvFNuheQdKi2rztZ7v8iz7iXPKFljO2IuD++xzMTVV4aMMv1BH5TMLA==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr321675wma.152.1607022880187;
        Thu, 03 Dec 2020 11:14:40 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm516480wro.36.2020.12.03.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:14:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 1/4] selftests/bpf: Update ima_setup.sh for busybox
Date:   Thu,  3 Dec 2020 19:14:34 +0000
Message-Id: <20201203191437.666737-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
References: <20201203191437.666737-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

losetup on busybox does not output the name of loop device on using
-f with --show. It also doesn't support -j to find the loop devices
for a given backing file. losetup is updated to use "-a" which is
available on busybox.

blkid does not support options (-s and -o) to only display the uuid, so
parse the output instead.

Not all environments have mkfs.ext4, the test requires a loop device
with a backing image file which could formatted with any filesystem.
Update to using mkfs.ext2 which is available on busybox.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 15490ccc5e55..137f2d32598f 100755
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
+        local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
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

