Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBC2D6D11
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLKBIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 20:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390297AbgLKBH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 20:07:56 -0500
From:   KP Singh <kpsingh@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3] selftests/bpf: Silence ima_setup.sh when not running in verbose mode.
Date:   Fri, 11 Dec 2020 01:07:11 +0000
Message-Id: <20201211010711.3716917-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, ima_setup.sh spews outputs from commands like mkfs and dd
on the terminal without taking into account the verbosity level of
the test framework. Update test_progs to set the environment variable
SELFTESTS_VERBOSE=1 when a verbose output is requested. This
environment variable is then used by ima_setup.sh (and can be used by
other similar scripts) to obey the verbosity level of the test harness
without needing to re-implement command line options for verbosity.

In "silent" mode, the script saves the output to a temporary file, the
contents of which are echoed back to stderr when the script encounters
an error.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/ima_setup.sh | 24 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.c | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 2bfc646bc230..8e62581113a3 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -7,6 +7,8 @@ set -o pipefail
 
 IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
 TEST_BINARY="/bin/true"
+VERBOSE="${SELFTESTS_VERBOSE:=0}"
+LOG_FILE="$(mktemp /tmp/ima_setup.XXXX.log)"
 
 usage()
 {
@@ -75,6 +77,19 @@ run()
 	exec "${copied_bin_path}"
 }
 
+catch()
+{
+	local exit_code="$1"
+	local log_file="$2"
+
+	if [[ "${exit_code}" -ne 0 ]]; then
+		cat "${log_file}" >&3
+	fi
+
+	rm -f "${log_file}"
+	exit ${exit_code}
+}
+
 main()
 {
 	[[ $# -ne 2 ]] && usage
@@ -96,4 +111,13 @@ main()
 	fi
 }
 
+trap 'catch "$?" "${LOG_FILE}"' EXIT
+
+if [[ "${VERBOSE}" -eq 0 ]]; then
+	# Save the stderr to 3 so that we can output back to
+	# it incase of an error.
+	exec 3>&2 1>"${LOG_FILE}" 2>&1
+fi
+
 main "$@"
+rm -f "${LOG_FILE}"
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 5ef081bdae4e..7d077d48cadd 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -587,6 +587,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 				return -EINVAL;
 			}
 		}
+
+		if (env->verbosity > VERBOSE_NONE) {
+			if (setenv("SELFTESTS_VERBOSE", "1", 1) == -1) {
+				fprintf(stderr,
+					"Unable to setenv SELFTESTS_VERBOSE=1 (errno=%d)",
+					errno);
+				return -1;
+			}
+		}
+
 		break;
 	case ARG_GET_TEST_CNT:
 		env->get_test_cnt = true;
-- 
2.29.2.576.ga3fc446d84-goog

