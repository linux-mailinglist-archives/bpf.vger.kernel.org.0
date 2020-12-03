Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D614C2CCB56
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgLCA7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:59:01 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97235C061A48
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:58:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id f190so1573436wme.1
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAj4CijO6YaK2Nh/ag2HPX9Fm7SDZZ1Y+XvbprTUDuk=;
        b=T6HgMPXL8eoNA8sMJQmWAkZmNXT4qzO3/C9lWx10pqKj41FX4yO6eTdd7ffoBfh32e
         p4yoOHb2rqo4ZObNzJcd+NCkODKmOikHEZdEOA9Qt/0KELj6ezQbljLhwmQ4yoCL5cIY
         2kFsuVP1xxVBXkhBTD44lAGLpkDHmjBeG4ndc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAj4CijO6YaK2Nh/ag2HPX9Fm7SDZZ1Y+XvbprTUDuk=;
        b=Nzh3pt+XN04NCBdHBTbSR6WDdYHOF9rtyFeauZ91OzE6caE8+5UhuElAVB3yV7dl4S
         MuTJj5LpXiVGGXnwi4RiyUFGRSBtsQRO7qIY65HsPoF5I9/7xjltMYD5FBJMPywbewBX
         Dwd3C0fbMhrNg5OiRtrZ9yJq/YqrYQO/PVbjxr2IuRD3CA4dj1d7xA606BpZAQROgt5e
         Lj2ZjqFi8/IoF8uVnu/YPoSPXlUlL0ROsWuyKNxo6l6XoHhtwYSwCPdCSH48/ZlPltga
         5AdSjjQ1OG+1twE3iXFV5stAYtqUdvBXu1bGgIVvmn4ZN6Bb+8gnZHau4QAmP2bxdc4V
         x2qA==
X-Gm-Message-State: AOAM531PHUVi0rsuz2F8rxPgKjmnQpz29vemJbH6+lM0yLH5HW0utl2a
        ona2UmeZpZoK21pcsp+j5OsIklRCb2PPyH4z
X-Google-Smtp-Source: ABdhPJzE/b7YBJH4ZyiiJ4IndE0U8AJjCDEU18S/JA3AhmnsS1nbtYPZncydsHcLGLVGZIQIkkwn/g==
X-Received: by 2002:a05:600c:410d:: with SMTP id j13mr504329wmi.95.1606957097138;
        Wed, 02 Dec 2020 16:58:17 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m4sm217960wmi.41.2020.12.02.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:58:16 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
Date:   Thu,  3 Dec 2020 00:58:07 +0000
Message-Id: <20201203005807.486320-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203005807.486320-1-kpsingh@chromium.org>
References: <20201203005807.486320-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 108 +++++++++++------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index b1ee4bf06996..2bfc646bc230 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -10,90 +10,90 @@ TEST_BINARY="/bin/true"
 
 usage()
 {
-        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
-        exit 1
+	echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
+	exit 1
 }
 
 ensure_mount_securityfs()
 {
-        local securityfs_dir=$(grep "securityfs" /proc/mounts | awk '{print $2}')
+	local securityfs_dir=$(grep "securityfs" /proc/mounts | awk '{print $2}')
 
-        if [ -z "${securityfs_dir}" ]; then
-                securityfs_dir=/sys/kernel/security
-                mount -t securityfs security "${securityfs_dir}"
-        fi
+	if [ -z "${securityfs_dir}" ]; then
+		securityfs_dir=/sys/kernel/security
+		mount -t securityfs security "${securityfs_dir}"
+	fi
 
-        if [ ! -d "${securityfs_dir}" ]; then
-                echo "${securityfs_dir}: securityfs is not mounted" && exit 1
-        fi
+	if [ ! -d "${securityfs_dir}" ]; then
+		echo "${securityfs_dir}: securityfs is not mounted" && exit 1
+	fi
 }
 
 setup()
 {
-        local tmp_dir="$1"
-        local mount_img="${tmp_dir}/test.img"
-        local mount_dir="${tmp_dir}/mnt"
-        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
-        mkdir -p ${mount_dir}
+	local tmp_dir="$1"
+	local mount_img="${tmp_dir}/test.img"
+	local mount_dir="${tmp_dir}/mnt"
+	local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
+	mkdir -p ${mount_dir}
 
-        dd if=/dev/zero of="${mount_img}" bs=1M count=10
+	dd if=/dev/zero of="${mount_img}" bs=1M count=10
 
-        losetup -f "${mount_img}"
-        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
+	losetup -f "${mount_img}"
+	local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
 
-        mkfs.ext2 "${loop_device:?}"
-        mount "${loop_device}" "${mount_dir}"
+	mkfs.ext2 "${loop_device:?}"
+	mount "${loop_device}" "${mount_dir}"
 
-        cp "${TEST_BINARY}" "${mount_dir}"
-        local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
+	cp "${TEST_BINARY}" "${mount_dir}"
+	local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
 
-        ensure_mount_securityfs
-        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
+	ensure_mount_securityfs
+	echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
 }
 
 cleanup() {
-        local tmp_dir="$1"
-        local mount_img="${tmp_dir}/test.img"
-        local mount_dir="${tmp_dir}/mnt"
+	local tmp_dir="$1"
+	local mount_img="${tmp_dir}/test.img"
+	local mount_dir="${tmp_dir}/mnt"
 
-        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
+	local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
 
-        for loop_dev in "${loop_devices}"; do
-                losetup -d $loop_dev
-        done
+	for loop_dev in "${loop_devices}"; do
+		losetup -d $loop_dev
+	done
 
-        umount ${mount_dir}
-        rm -rf ${tmp_dir}
+	umount ${mount_dir}
+	rm -rf ${tmp_dir}
 }
 
 run()
 {
-        local tmp_dir="$1"
-        local mount_dir="${tmp_dir}/mnt"
-        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
+	local tmp_dir="$1"
+	local mount_dir="${tmp_dir}/mnt"
+	local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
 
-        exec "${copied_bin_path}"
+	exec "${copied_bin_path}"
 }
 
 main()
 {
-        [[ $# -ne 2 ]] && usage
-
-        local action="$1"
-        local tmp_dir="$2"
-
-        [[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
-
-        if [[ "${action}" == "setup" ]]; then
-                setup "${tmp_dir}"
-        elif [[ "${action}" == "cleanup" ]]; then
-                cleanup "${tmp_dir}"
-        elif [[ "${action}" == "run" ]]; then
-                run "${tmp_dir}"
-        else
-                echo "Unknown action: ${action}"
-                exit 1
-        fi
+	[[ $# -ne 2 ]] && usage
+
+	local action="$1"
+	local tmp_dir="$2"
+
+	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
+
+	if [[ "${action}" == "setup" ]]; then
+		setup "${tmp_dir}"
+	elif [[ "${action}" == "cleanup" ]]; then
+		cleanup "${tmp_dir}"
+	elif [[ "${action}" == "run" ]]; then
+		run "${tmp_dir}"
+	else
+		echo "Unknown action: ${action}"
+		exit 1
+	fi
 }
 
 main "$@"
-- 
2.29.2.576.ga3fc446d84-goog

