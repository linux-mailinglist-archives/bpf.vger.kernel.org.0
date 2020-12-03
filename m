Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D258E2CDE97
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgLCTPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:15:22 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75681C061A51
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:14:42 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w206so3272250wma.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1b2sG2SIN3nDPtUc25i64mqNZeXcPSGhHhM6es0j9s=;
        b=OLhcLPPXuwLc+Di3BkYVe5yTBmotq1VupwQ3hc2wQBMSKJ6kjTgOEnKuOcdzjF67IQ
         MaBaXpBdWm+kctZO2eDSzC6I+d1FKm/B5KSV9UHSvBvKWa3nsHWns/+N2J2BzzJKu69O
         RAUZd5j12JO7Rio7u2r8pymAZwOhH0pUOHxBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1b2sG2SIN3nDPtUc25i64mqNZeXcPSGhHhM6es0j9s=;
        b=VqgXZNG6snBAlIxfzrDNnyhF4uXCVk9JeRoQXTr6x7TW99D9wRjwuzmkH/asSdDdVK
         eJIMjP6Eg1bI87DYH2HXUNHNCIGrQv5ix/fcgPGYaXx1EcDlKJYhejmzY+m/yOPhKKVR
         AOq3hBnR5gO/6uBGJ8k7dS70UbuPEMweoGH4c0LMaMA2pvElpr4i1TyHKhegY1ruB2zC
         2nl0ERm5j6oeqgxRzw58zEGN8mLwclhsEuf5xZkUzUR6WAp6ltuE5d/grMPTJBYY6uGh
         xiDQY5FcoYlFTKAjvQkzvvaUYZPJ6hgedUL41T8hiM3yz6RS/1ix+LXpYzQ3RC7foPef
         /Opg==
X-Gm-Message-State: AOAM530k1JOuuh9nKuzMy50cLl7czG1bua++MK9UKUS0FQOqDbmo6wCi
        0ON13V5yf+JFLF671AhImIMDbwdZFBpRkBv8
X-Google-Smtp-Source: ABdhPJyg5QW5KX7IxNx0LzZJNMkY1Ki6yPOZ0nRKMsGStDuDfKam6HdLQQobakL+HqRqTzFlSPIXgQ==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr346325wmh.58.1607022880932;
        Thu, 03 Dec 2020 11:14:40 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm516480wro.36.2020.12.03.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:14:40 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 2/4] selftests/bpf: Ensure securityfs mount before writing ima policy
Date:   Thu,  3 Dec 2020 19:14:35 +0000
Message-Id: <20201203191437.666737-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
References: <20201203191437.666737-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

SecurityFS may not be mounted even if it is enabled in the kernel
config. So, check if the mount exists in /proc/mounts by parsing the
file and, if not, mount it on /sys/kernel/security.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

