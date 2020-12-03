Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8B2CCB5A
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgLCA65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA65 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:58:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B6C061A04
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:58:17 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so1063108wmc.2
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvYLzb/2awFSWopGgD9GTzNT2RYp2qPIFj0IFXraBdY=;
        b=E25QxQmDCkpJmSC1os7qKy1fMHCuQFApYmSE91srYNav6CBs+/YGCklvH3kCihVzHO
         jD12Wu4+Y7rOaPe32CaO4lub4xpDOWOxr5XiA6jvoWdgSFf26lH0Ez4XQh+7ELrPErom
         RlV+reWXgFJloZBGG3q2VCCrr+y+FhAJEBxuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvYLzb/2awFSWopGgD9GTzNT2RYp2qPIFj0IFXraBdY=;
        b=UErwVve5lxO0/p+dJl0EGuX9bP2zvBDPKmY2MEzk9pHmFjc/+4FojbWfg0UHDvyGcT
         11oNo9kngAFUDQWz0TY7Ye8X5HtvQxVE2s9gQDGTO7r18xBRp+hSZKAME8GGXYRDFy66
         pNcLnQYdq2uDzTTTtXXEyHFHXVtC7ED61DHdWhBJeGJIg/7u8WAdkF7L2TdHVRTG51cN
         F1p3ATwffeg7+M4i5dW5V9VPwbWIzv6zW7AZgpzA0W0XpeuMPg4Vk6A6qxVOYJphOn9X
         Brn1FYZjk1ofvxHHn+SHUQ8B7bG701LlYpzb0Rq02S2DafXlFtAkW1EgRMkdYwwSxOor
         XMzA==
X-Gm-Message-State: AOAM5338fh0dzFZCTx3Y1p9P+wheWVS845R+Ru8D1GU8mf5vcIEXsqHW
        fQOWig3Ai+8k71eXCufKBmzVrVi6L9+zYzX5
X-Google-Smtp-Source: ABdhPJyjXOSKoVz9HnG6lc2ZaPfk5ZWA2KK74qjKe0l1kWR9uDvIX3VngBVlZucFr2sqDuOnfBzjOg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr494874wme.189.1606957095672;
        Wed, 02 Dec 2020 16:58:15 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m4sm217960wmi.41.2020.12.02.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:58:15 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Ensure securityfs mount before writing ima policy
Date:   Thu,  3 Dec 2020 00:58:05 +0000
Message-Id: <20201203005807.486320-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203005807.486320-1-kpsingh@chromium.org>
References: <20201203005807.486320-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

SecurityFS may not be mounted even if it is enabled in the kernel
config.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 137f2d32598f..b1ee4bf06996 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -14,6 +14,20 @@ usage()
         exit 1
 }
 
+ensure_mount_securityfs()
+{
+        local securityfs_dir=$(grep "securityfs" /proc/mounts | awk '{print $2}')
+
+        if [ -z "${securityfs_dir}" ]; then
+                securityfs_dir=/sys/kernel/security
+                mount -t securityfs security "${securityfs_dir}"
+        fi
+
+        if [ ! -d "${securityfs_dir}" ]; then
+                echo "${securityfs_dir}: securityfs is not mounted" && exit 1
+        fi
+}
+
 setup()
 {
         local tmp_dir="$1"
@@ -33,6 +47,7 @@ setup()
         cp "${TEST_BINARY}" "${mount_dir}"
         local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
 
+        ensure_mount_securityfs
         echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
 }
 
-- 
2.29.2.576.ga3fc446d84-goog

