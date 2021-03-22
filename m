Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA7344BA9
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCVQh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 12:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231851AbhCVQhD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 12:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C56961974;
        Mon, 22 Mar 2021 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431023;
        bh=x2BUkSXOpgvtXio7p9AVNFbXcJAfDsJjt4jn1G7ZYow=;
        h=From:To:Cc:Subject:Date:From;
        b=KOLnYNxPZafa7KTNbwsuBahV4Yf/NkK6IpRUeVx7h4ncSEGYQwLm6oP5qY4I46BiQ
         bMlm10M4TPscfns/7qoN05aBuMRN/YqED6klUcFdfEODBTR7aDUIi6nU8THUcSN9s7
         Pcaibozj+KDam4pKvTUcKt6B2Dz0WXzq6H63xoYs4sdXyI2lNtGWxK6kWn0/oZXYDK
         GLUGpNB3lbpR1P54U6SJutvlWgsJHQKvsyDHF4pMvM1Hmk4kjBikIzaOn2Q8/58WBv
         qDOTbyk6FHfL12oO+Fh/Roj4FxsUuq/tH/7mU/3acTTUIBXtPhVXg8iBei7sTEELch
         NaNCVH8TTF8kw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Add an option for a debug shell in vmtest.sh
Date:   Mon, 22 Mar 2021 16:36:59 +0000
Message-Id: <20210322163659.2873534-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The newly introduced -s command line option starts an interactive shell
after running the intended command in instead of powering off the VM.
It's useful to have a shell especially when debugging failing
tests or developing new tests.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/vmtest.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 22554894db99..3f248e755755 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -24,7 +24,7 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
 usage()
 {
 	cat <<EOF
-Usage: $0 [-i] [-d <output_dir>] -- [<command>]
+Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
 tools/testing/selftests/bpf. e.g:
@@ -49,6 +49,8 @@ Options:
 	-d)		Update the output directory (default: ${OUTPUT_DIR})
 	-j)		Number of jobs for compilation, similar to -j in make
 			(default: ${NUM_COMPILE_JOBS})
+	-s)		Instead of powering off the VM, run an interactive debug
+			shell after <command> finishes.
 EOF
 }
 
@@ -149,6 +151,7 @@ update_init_script()
 	local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
 	local init_script="${init_script_dir}/S50-startup"
 	local command="$1"
+	local exit_command="$2"
 
 	mount_image
 
@@ -175,7 +178,7 @@ echo "130" > "/root/${EXIT_STATUS_FILE}"
 	stdbuf -oL -eL ${command}
 	echo "\$?" > "/root/${EXIT_STATUS_FILE}"
 } 2>&1 | tee "/root/${LOG_FILE}"
-poweroff -f
+${exit_command}
 EOF
 
 	sudo chmod a+x "${init_script}"
@@ -277,8 +280,9 @@ main()
 	local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
 	local command="${DEFAULT_COMMAND}"
 	local update_image="no"
+	local exit_command="poweroff -f"
 
-	while getopts 'hkid:j:' opt; do
+	while getopts 'hskid:j:' opt; do
 		case ${opt} in
 		i)
 			update_image="yes"
@@ -289,6 +293,9 @@ main()
 		j)
 			NUM_COMPILE_JOBS="$OPTARG"
 			;;
+		s)
+			exit_command="bash"
+			;;
 		h)
 			usage
 			exit 0
@@ -355,7 +362,7 @@ main()
 	fi
 
 	update_selftests "${kernel_checkout}" "${make_command}"
-	update_init_script "${command}"
+	update_init_script "${command}" "${exit_command}"
 	run_vm "${kernel_bzimage}"
 	copy_logs
 	echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
-- 
2.31.0.rc2.261.g7f71774620-goog

