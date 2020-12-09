Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3161E2D3750
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgLIACF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 19:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgLIACF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 19:02:05 -0500
From:   KP Singh <kpsingh@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2] selftests/bpf: Silence ima_setup.sh when not running in verbose mode.
Date:   Wed,  9 Dec 2020 00:01:20 +0000
Message-Id: <20201209000120.2709992-1-kpsingh@kernel.org>
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

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/ima_setup.sh |  6 ++++++
 tools/testing/selftests/bpf/test_progs.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 2bfc646bc230..7490a9bae33e 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -81,9 +81,15 @@ main()
 
 	local action="$1"
 	local tmp_dir="$2"
+	local verbose="${SELFTESTS_VERBOSE:=0}"
 
 	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
 
+	if [[ "${verbose}" -eq 0 ]]; then
+		exec 1> /dev/null
+		exec 2>&1
+	fi
+
 	if [[ "${action}" == "setup" ]]; then
 		setup "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
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

