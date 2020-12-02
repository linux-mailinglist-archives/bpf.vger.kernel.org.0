Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E93B2CC9B9
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgLBWkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 17:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgLBWka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:40:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38492C0617A6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:39:50 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so5781603wrb.9
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8/10OyIjlZ3CbHmV7X/BEUAsasCZ5FCOwzYE2LIh5A=;
        b=KDIxplTdKW8VBJOyPepd2QrTPr9KsdOGrtHWEs4/WGLDL3Osjr6kZ0TB1ITOw07k+K
         wgp/vXOB3PX1yLQ6WscnxoHHZAxKnLnTGvY3VD/5vYMDhGSuDrgEULxlQMvj3fjBoMLF
         IIPE/qJbSo+K8hKB7ahY+wUiYlgsKjqd2IFkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8/10OyIjlZ3CbHmV7X/BEUAsasCZ5FCOwzYE2LIh5A=;
        b=Oo2ERfGufPnOO4IvUkH/798CeLSFWXbHxiQ06MUlQncL6EnSa74TH25jhBftjy3aN+
         W2apu6qcJO1HgMxyWjBISCk4GYiIoyGsMv39IQdfBe4kn+J3dQnKWmFUiGTMruEmDa+k
         7s52mr0Ah5KGDn//x5OBhe2ZtRXU4Z6Fj3ux+w8RB1Qqby6MBeh1WWG1j3DHD4MqETt4
         ysSvCGDmAvmBBySm7Ki5oXlvukr7BGARiIXEht1huVXV4qgqS6ptPsrn21PnDBfO0jKG
         Btqe711slPSswac6o1GMAK13++5LvLA5C88Bu1UbmL+h2tmNq04uI3YIarmn1j5jmovn
         BTjg==
X-Gm-Message-State: AOAM531KuJFZpxe+anJ1dEtRCcF/poNhtoRVdtW54zvJxqUJHJqw8xhl
        M7gQGrjQyW5/44sAyh5mP+kZWRNIcuF6rhgz
X-Google-Smtp-Source: ABdhPJw5IzQcR9ji3BP2fr/i3O7xGFyF4MnVGfGrGh7Z7Yy6U7g8/P5oJQfEL+32pxmQ5H8ovc97iw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr344590wrn.56.1606948788670;
        Wed, 02 Dec 2020 14:39:48 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id c2sm113068wrv.41.2020.12.02.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:39:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Ensure securityfs mount before writing ima policy
Date:   Wed,  2 Dec 2020 22:39:43 +0000
Message-Id: <20201202223944.456903-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201202223944.456903-1-kpsingh@chromium.org>
References: <20201202223944.456903-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

SecurityFS may not be mounted even if it is enabled in the kernel
config.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index d864c62c1207..1da2d97a0e72 100755
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
+		securityfs_dir=/sys/kernel/security
+		mount -t securityfs security "${securityfs_dir}"
+	fi
+
+	if [ ! -d "${securityfs_dir}" ]; then
+		echo "${securityfs_dir} :securityfs is not mounted" && exit 1
+	fi
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

