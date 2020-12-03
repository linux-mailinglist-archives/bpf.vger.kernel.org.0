Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91482CCB59
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLCA65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA65 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:58:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53ABC0617A7
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:58:16 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so1506916wmg.4
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZYCT9jq3ErnM4xxNvbt1lypE7V52HO8UFemG7ypah0=;
        b=dwvKht+ral/LB39DWR/3WAJOMSBv9z3KmQAikuVPHVzHluk/RxExMPgywwvmCBpF9A
         7thrJU5Wq+jN9933Qn4pUILZla7zVPKRYp+SYxv9HkN70OghkR1HdWe1uYGFrUIOP1Yd
         UD8piVLECOC/lKSs509fMexvd2LjT84hMp5So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZYCT9jq3ErnM4xxNvbt1lypE7V52HO8UFemG7ypah0=;
        b=MjWgPpp+FhQZkHukmps4SE7DUmCoF20Qp+sokjgeAewLMEuEi0u6qtuUX3YiC7g91x
         HPLjnBjFpnodzgS9E1eWQffX6Z3WQewfacLfyuUWkDx/SBn/0N7y03pNXnpWgbUtLJCs
         +vYynRxxtbLBt2I5o4H2i79kLzm7REHhquvAY9cMvfZR2RnEr/w2KtjnId8pY7NLsvGu
         u6oVPu8o6vvkRFXPrru9q2RWBqknYKmrYDG4cYI+VZp8gTo3izVpsP044g5VBvrHyJyY
         S/5Iuh3JujVoEaw0fSi2ggtw6TT4JeJ5RwjcdogoxNerDqoHeEbCdnVhHndg/I9fHL3B
         dtbg==
X-Gm-Message-State: AOAM5323HmPxTAI5sI+B56zteMOiScVrD/bhdD4veUWJ10LD/hiyxYNv
        oV/Cvq9zWBBLS/GyVu//VhgbECbKsNUySUyL
X-Google-Smtp-Source: ABdhPJynkRsmJfZjY/FFgbpB47SwlS3PXEd+Isq2z6AGTd4ihuSTkWhDXFkwMZIQ3YLuy2cBP5SgFw==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr555338wmh.2.1606957094980;
        Wed, 02 Dec 2020 16:58:14 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m4sm217960wmi.41.2020.12.02.16.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:58:14 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Update ima_setup.sh for busybox
Date:   Thu,  3 Dec 2020 00:58:04 +0000
Message-Id: <20201203005807.486320-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203005807.486320-1-kpsingh@chromium.org>
References: <20201203005807.486320-1-kpsingh@chromium.org>
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

