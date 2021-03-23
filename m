Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41F034551B
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 02:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCWBsW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 21:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhCWBr7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 21:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A74A619A9;
        Tue, 23 Mar 2021 01:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616464077;
        bh=w2XzDLfdA1U+ze7ABxuhGs5tGvh3m52+UeeDQh1GyNM=;
        h=From:To:Cc:Subject:Date:From;
        b=DcPkUmKKB9U3rqKlN0Mgy5hVCPSSSQM4ka5fhESvaJW0dtbeZq3fH4tMAIlJCi0if
         wXFIsSGzMjWzjCRItHkvZvUVP3aaa7lltYCPIyR9+p/c+vfnsCy0s5CZTW+QB5UAMD
         ik/6q60DURpQ3ar9Nd7FfFPQowD98e3+LCj87iQtDNGx+J0WZ+GEORIJsv1J514XA2
         +9yy+qWpnz2fPtIY5kE9aOKjV23UE7cBEquR38liQJmh/bNnlNk7tx6tnwaqWs5qJQ
         vuz60YLy+Q2fzBj5t22K77qoLdPm5/uhZUu/zGnJoqeyxgxTKhjWY20Lks2Mn2Z6Cz
         +EJAgG3jpdk/Q==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH v2 bpf-next] selftests/bpf: Add an option for a debug shell in vmtest.sh
Date:   Tue, 23 Mar 2021 01:47:52 +0000
Message-Id: <20210323014752.3198283-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The newly introduced -s command line option starts an interactive shell.
If a command is specified, the shell is started after the command
finishes executing. It's useful to have a shell especially when
debugging failing tests or developing new tests.

Since the user may terminate the VM forcefully, an extra "sync" is added
after the execution of the command to persist any logs from the command
into the log file.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 22554894db99..8889b3f55236 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -24,15 +24,15 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
 usage()
 {
 	cat <<EOF
-Usage: $0 [-i] [-d <output_dir>] -- [<command>]
+Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
 tools/testing/selftests/bpf. e.g:
 
 	$0 -- ./test_progs -t test_lsm
 
-If no command is specified, "${DEFAULT_COMMAND}" will be run by
-default.
+If no command is specified and a debug shell (-s) is not requested,
+"${DEFAULT_COMMAND}" will be run by default.
 
 If you build your kernel using KBUILD_OUTPUT= or O= options, these
 can be passed as environment variables to the script:
@@ -49,6 +49,9 @@ Options:
 	-d)		Update the output directory (default: ${OUTPUT_DIR})
 	-j)		Number of jobs for compilation, similar to -j in make
 			(default: ${NUM_COMPILE_JOBS})
+	-s)		Instead of powering off the VM, start an interactive
+			shell. If <command> is specified, the shell runs after
+			the command finishes executing
 EOF
 }
 
@@ -149,6 +152,7 @@ update_init_script()
 	local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
 	local init_script="${init_script_dir}/S50-startup"
 	local command="$1"
+	local exit_command="$2"
 
 	mount_image
 
@@ -162,9 +166,10 @@ EOF
 
 	fi
 
-	sudo bash -c "cat >${init_script}" <<EOF
-#!/bin/bash
+	sudo bash -c "echo '#!/bin/bash' > ${init_script}"
 
+	if [[ "${command}" != "" ]]; then
+		sudo bash -c "cat >>${init_script}" <<EOF
 # Have a default value in the exit status file
 # incase the VM is forcefully stopped.
 echo "130" > "/root/${EXIT_STATUS_FILE}"
@@ -175,9 +180,12 @@ echo "130" > "/root/${EXIT_STATUS_FILE}"
 	stdbuf -oL -eL ${command}
 	echo "\$?" > "/root/${EXIT_STATUS_FILE}"
 } 2>&1 | tee "/root/${LOG_FILE}"
-poweroff -f
+# Ensure that the logs are written to disk
+sync
 EOF
+	fi
 
+	sudo bash -c "echo ${exit_command} >> ${init_script}"
 	sudo chmod a+x "${init_script}"
 	unmount_image
 }
@@ -277,8 +285,10 @@ main()
 	local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
 	local command="${DEFAULT_COMMAND}"
 	local update_image="no"
+	local exit_command="poweroff -f"
+	local debug_shell="no"
 
-	while getopts 'hkid:j:' opt; do
+	while getopts 'hskid:j:' opt; do
 		case ${opt} in
 		i)
 			update_image="yes"
@@ -289,6 +299,11 @@ main()
 		j)
 			NUM_COMPILE_JOBS="$OPTARG"
 			;;
+		s)
+			command=""
+			debug_shell="yes"
+			exit_command="bash"
+			;;
 		h)
 			usage
 			exit 0
@@ -307,7 +322,7 @@ main()
 	done
 	shift $((OPTIND -1))
 
-	if [[ $# -eq 0 ]]; then
+	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
 		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
 	else
 		command="$@"
@@ -355,10 +370,12 @@ main()
 	fi
 
 	update_selftests "${kernel_checkout}" "${make_command}"
-	update_init_script "${command}"
+	update_init_script "${command}" "${exit_command}"
 	run_vm "${kernel_bzimage}"
-	copy_logs
-	echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
+	if [[ "${command}" != "" ]]; then
+		copy_logs
+		echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
+	fi
 }
 
 catch()
-- 
2.31.0.rc2.261.g7f71774620-goog

