Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A5325362
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhBYQUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 11:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233230AbhBYQUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A433A64F1C;
        Thu, 25 Feb 2021 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269992;
        bh=TzAh8AoAtU7q2hx7t2aKsQ6z9Q1NkWCfq+o0Mrmdi70=;
        h=From:To:Cc:Subject:Date:From;
        b=rMu41xTnMKWsnkE/AZVrve3/PkflmLrgBUiyQXEsxJP/K3Up7USy15MLL6pLX+pTJ
         5xGiLDSLVl+FXVyTShW/dEJK8sWTPBqEd7N3CF6T+ndKbagxFKheJtejHYxRsLp/Bs
         0/q8PlS/iKJFmpmfG482zN6+3lOR8DtKK0xx65q+X0TRoAE2FhU/m/FGtquVF1mURk
         sK2XA0ngewheU5fPQMXuenr2XsPP9tCxcn75tmP4d1yhKfUuXy37jrkq7PubTTk7Vw
         egYTW5HotvLup5YC4XrtKroTFDN7uG2DsSTL8FRMHhggAht1FRULQC/8jvPdcqfZ2Y
         aJYXpBeKr0bcw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Propagate error code of the command to vmtest.sh
Date:   Thu, 25 Feb 2021 16:19:47 +0000
Message-Id: <20210225161947.1778590-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When vmtest.sh ran a command in a VM, it did not record or propagate the
error code of the command. This made the script less "script-able". The
script now saves the error code of the said command in a file in the VM,
copies the file back to the host and (when available) uses this error
code instead of its own.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 26ae8d0b6ce3..22554894db99 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -17,6 +17,9 @@ KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vm
 KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/latest.config"
 INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
+LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
+LOG_FILE="${LOG_FILE_BASE}.log"
+EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
 
 usage()
 {
@@ -146,7 +149,6 @@ update_init_script()
 	local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
 	local init_script="${init_script_dir}/S50-startup"
 	local command="$1"
-	local log_file="$2"
 
 	mount_image
 
@@ -163,11 +165,16 @@ EOF
 	sudo bash -c "cat >${init_script}" <<EOF
 #!/bin/bash
 
+# Have a default value in the exit status file
+# incase the VM is forcefully stopped.
+echo "130" > "/root/${EXIT_STATUS_FILE}"
+
 {
 	cd /root/bpf
 	echo ${command}
 	stdbuf -oL -eL ${command}
-} 2>&1 | tee /root/${log_file}
+	echo "\$?" > "/root/${EXIT_STATUS_FILE}"
+} 2>&1 | tee "/root/${LOG_FILE}"
 poweroff -f
 EOF
 
@@ -221,10 +228,12 @@ EOF
 copy_logs()
 {
 	local mount_dir="${OUTPUT_DIR}/${MOUNT_DIR}"
-	local log_file="${mount_dir}/root/$1"
+	local log_file="${mount_dir}/root/${LOG_FILE}"
+	local exit_status_file="${mount_dir}/root/${EXIT_STATUS_FILE}"
 
 	mount_image
 	sudo cp ${log_file} "${OUTPUT_DIR}"
+	sudo cp ${exit_status_file} "${OUTPUT_DIR}"
 	sudo rm -f ${log_file}
 	unmount_image
 }
@@ -263,7 +272,6 @@ main()
 {
 	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 	local kernel_checkout=$(realpath "${script_dir}"/../../../../)
-	local log_file="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S.log")"
 	# By default the script searches for the kernel in the checkout directory but
 	# it also obeys environment variables O= and KBUILD_OUTPUT=
 	local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
@@ -347,19 +355,23 @@ main()
 	fi
 
 	update_selftests "${kernel_checkout}" "${make_command}"
-	update_init_script "${command}" "${log_file}"
+	update_init_script "${command}"
 	run_vm "${kernel_bzimage}"
-	copy_logs "${log_file}"
-	echo "Logs saved in ${OUTPUT_DIR}/${log_file}"
+	copy_logs
+	echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
 }
 
 catch()
 {
 	local exit_code=$1
+	local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
 	# This is just a cleanup and the directory may
 	# have already been unmounted. So, don't let this
 	# clobber the error code we intend to return.
 	unmount_image || true
+	if [[ -f "${exit_status_file}" ]]; then
+		exit_code="$(cat ${exit_status_file})"
+	fi
 	exit ${exit_code}
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

