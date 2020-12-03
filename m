Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9D2CDE9A
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgLCTPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:15:30 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56483C061A53
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:14:44 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so5002208wmf.3
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSXphco9+xOvc4UUX2/2ViapN7bQcE+sIVhx/aA3cgs=;
        b=apOXbKawCT3vVsxlvdF1L8qxkel2NB7jxnmRpxOziywoG6f6dTGdL8jD2mMFVNAvsA
         bO7sX5JbFYbM7OgDZjHa/tHjlRNXz5nqlW50fM0saXNWn/s11TKajoiOPeOrTnF9ngyL
         Td+fmpoafwomJhegrWbUhMLhaflIQU5Izy+mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSXphco9+xOvc4UUX2/2ViapN7bQcE+sIVhx/aA3cgs=;
        b=SA+iDpjh6SDtm0odt6sW5aZ7WyU1rCqc/iyClQd2cFRMPW8lSs1PbXvMUtS0yEYH4r
         HM8t4R6+PeyfcREe8BRRQUswXmhbtNHaqNM32rO9PCurvskcHDOaYVV6Vziprc6Qo8om
         nqNr9QCznKJLk1EEb9XS+yvp8O2xtA8Jjiy8dW1zHg7JdlK15Dnq3S+7aRSkE89h7v8u
         kI80vOizxySPhpjrbjLvYJy2YTK5NBav6bAPYOjwj93+7AW0ZeAvaoMDLo+uPrmnC6Bo
         3+VHYTl59DOo0ZAzOHvGcob0cf4GBSyEPAA/sCEUk8iJHmYePxFWW2J/nQwWwrmG5YXr
         l3DQ==
X-Gm-Message-State: AOAM532wVuEuJQRVCgGW0NCvlPZbFkDGFRXEYapzQYeujNHuNn3N2KZH
        ymgu2fl1JAt5lQF1U43u3DPqXgVW9zL1T8rl
X-Google-Smtp-Source: ABdhPJyOYA8NUARcVT/aJ+xKLNVNrnMB/cPJFX/hiavpwVO/PjNJiUu+tJjfUbxE+8vXsrf5tBtAXA==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr295893wmj.125.1607022882785;
        Thu, 03 Dec 2020 11:14:42 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm516480wro.36.2020.12.03.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:14:42 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
Date:   Thu,  3 Dec 2020 19:14:37 +0000
Message-Id: <20201203191437.666737-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
References: <20201203191437.666737-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The file was formatted with spaces instead of tabs and went unnoticed
as checkpatch.pl did not complain (probably because this is a shell
script). Re-indent it with tabs to be consistent with other scripts.

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

