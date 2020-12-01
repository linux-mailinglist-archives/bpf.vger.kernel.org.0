Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA002CA5EC
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbgLAOkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 09:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389462AbgLAOkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 09:40:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C7C0613D6
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 06:39:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h21so5552905wmb.2
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2pihj4lnPlLWrJE5+RYdsoHnnsm23fjjkLBO9yU9Fo=;
        b=Al6iKh6uP0Pe8eNjwDhk4hryCPw1FLnBFWVuI3WUdlK3zN8V0Ogi1jlJg/IIwdkxOV
         hnN1rjkuuU9cNfN5CYfJjiBF76j1RtBcGLOSN3bTg7CK1HJysrYnMQXCx+lkAW9/BnOc
         3M5iqCAgTsTfrOxiaLat9gzNjgHHxYy9Hq8Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2pihj4lnPlLWrJE5+RYdsoHnnsm23fjjkLBO9yU9Fo=;
        b=cf34ZSA0Kb75ygK436BNd7fTAk+E0QDNhkG9Aqe/yqKDKT8DNsbGGjtkEfLjaDU7JV
         2n5+MAGxDL+nC3liyJ0VJ0ZXBZLJ6clPg143AGR4fOuV1pff8GBDUQNEp2za2b7gAPVT
         8OdOs+KoxknpjDEKgoKGrorPun4hAhAmRSMPFEsuSTWFJQK/m0iORou54jC/OCkJQViM
         SeX5ijFLLndF8fHZlWeUvphwDDF9iTWUq7JOlap8j0na59EE84J5Awp+MV/fNi8hPhJP
         D7XeAvm4q8YgqaRoLlJJ0yJztRIYXGyfNpS9pyZR/fsdXSnA5XnQXdIj9Uj1jhIJ8y08
         ab9A==
X-Gm-Message-State: AOAM533FRSvj3wyz1W5MCzPszPIJars+KD42O4cuXwrRF8s8smwJZxX8
        PkDlTBolyqUX+GP2xKBl9YUSOwmVXyoVWewF
X-Google-Smtp-Source: ABdhPJzN9O0n66gPhgWlirpIKBrIKkjNBZUxj4csnV5zOjlArWgfs1FpMNMQdX0mWFLnpTFKy9ToQg==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr3098890wmh.48.1606833576193;
        Tue, 01 Dec 2020 06:39:36 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id i8sm61199wma.32.2020.12.01.06.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:39:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Update ima test helper's mount uuid logic
Date:   Tue,  1 Dec 2020 14:39:24 +0000
Message-Id: <20201201143924.2908241-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201201143924.2908241-1-kpsingh@chromium.org>
References: <20201201143924.2908241-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The test uses blkid to determine the uuid which may not be available on
every system. Switch the logic to a good-old for loop iterating over
/dev/disk/by-uuid and reading the symlinks to find the correct UUID for
a given loop device

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index ed29bde26a12..7b8615c30c09 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -31,8 +31,24 @@ setup()
         mount "${loop_device}" "${mount_dir}"
 
         cp "${TEST_BINARY}" "${mount_dir}"
-        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
-        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
+        local mount_uuid=""
+        # This can be done with blkid -s UUID -o value ${loop_device} but
+        # blkid might not be available everywhere, especially in busybox
+        # environments.
+        for uuid in $(ls /dev/disk/by-uuid); do
+                local link_target="$(readlink -f /dev/disk/by-uuid/${uuid})"
+                if [[ "${loop_device}" == "${link_target}" ]]; then
+                        mount_uuid="${uuid}"
+                        break;
+                fi
+        done
+
+        if [[ -z "${mount_uuid}" ]]; then
+                echo "Could not find mount_uuid for ${loop_device}"
+                exit 1;
+        fi
+
+        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid:?}" > ${IMA_POLICY_FILE}
 }
 
 cleanup() {
-- 
2.29.2.454.gaff20da3a2-goog

