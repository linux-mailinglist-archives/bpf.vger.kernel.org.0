Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0253E2CF0B1
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLDP0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 10:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgLDP0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 10:26:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F046C061A4F
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 07:25:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so7364448wmb.5
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hic/XpvzRuloEZpQVdrgdBOJJTvvPLQNiZI/UPKXh7w=;
        b=HtkP+dbXhAYdm4kDmA2QEGRpfxFUyxzccusYShxZ7s8s60hZJ4ENYzUtHW1V0mauwW
         nOnF/bUoU+H+6ajbzTW+M+6msef7MfiVYu+J7mfNLY7UssNUg9ZdduDC2G727fs1Ucyj
         znEGfobj/33pVYo8omKAqz87jX+ss3MCYGZyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hic/XpvzRuloEZpQVdrgdBOJJTvvPLQNiZI/UPKXh7w=;
        b=Xn51We50LoWaxvRUqL41AzZnrmp9e7l9MinquNYP76Sjh19iRphhr5IAc6sHy6Jih5
         MCQ4E0P1ECnPTBfeFcgFCRyIWwqXUPRkCKF1L8/sbBAr+U3nQz+1ElBZTNL8gApIQZW7
         CRTdSENR4VlmNA0R/m3p4b0b1+mTl9Ycy06F4ircO5IybrH29hjmMb/p+dv/XwNLGgux
         oKttx6UysS5Cnhp6yYcW0Nicem/050u4Y7qxAXNNrg0ZL8Ir2Q4HnV5yozv9hdA367sC
         zxZt6p1azEiSpbFVt8O3qrKjAupKH5wc7jqBb0LDZTPyv+Ax5IepRF0Ba28ug0+QdMAU
         Rx6A==
X-Gm-Message-State: AOAM533lfRYZGa3IAn4rtZJL5tN+jDcmvG+aVjAdx88qQ8lvHFLkGfPr
        DlfYtJmk3QCjWjvblat1LVAupwA8Bz+19aK6
X-Google-Smtp-Source: ABdhPJy/3ldl0fPqftSHed6W5Pz9elR8I7COdW4nvrW3JemlnwGp7YPJd9XZmpk8/UcVDX/p2s6VtA==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr4966210wml.31.1607095556465;
        Fri, 04 Dec 2020 07:25:56 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm4144379wro.36.2020.12.04.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:25:55 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] selftests/bpf: Add verbosity to ima_setup.sh
Date:   Fri,  4 Dec 2020 15:25:54 +0000
Message-Id: <20201204152554.955599-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Currently, ima_setup.sh spews outputs from commands like mkfs and dd
on the terminal without taking into account the verbosity level of
the test framework. Add an option to specify the verbosity for the
shell script and only print output when verbosity > VERBOSE_NONE.

Since the command line parsing got complicated with the addition of
verbosity, switched "action" (-a, --action) and "directory" (-d, --dir)
to command line switches as well.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh      | 36 ++++++++++++++++---
 .../selftests/bpf/prog_tests/test_ima.c       | 11 ++++--
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 2bfc646bc230..d8d063fa7781 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -10,7 +10,7 @@ TEST_BINARY="/bin/true"
 
 usage()
 {
-	echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
+	echo "Usage: $0 -a <setup|cleanup|run> -d <existing_tmp_dir> -v <yes|no>"
 	exit 1
 }
 
@@ -77,12 +77,40 @@ run()
 
 main()
 {
-	[[ $# -ne 2 ]] && usage
+	local tmp_dir=""
+	local action=""
+	local verbosity="no"
+
+	while [[ $# -gt 0 ]]; do
+		case "$1" in
+		-v | --verbosity)
+			shift
+			verbosity="$1"
+			shift
+			;;
+		-a | --action)
+			shift
+			action="$1"
+			shift
+			;;
+		-d | --dir)
+			shift
+			tmp_dir="$1"
+			shift
+			;;
+		* )
+			break
+			;;
+		esac
+	done
 
-	local action="$1"
-	local tmp_dir="$2"
+	if [[ "${verbosity}" == "no" ]]; then
+		exec 1> /dev/null
+		exec 2>&1
+	fi
 
 	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
+	[[ -z "${action}" ]] && usage
 
 	if [[ "${action}" == "setup" ]]; then
 		setup "${tmp_dir}"
diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index 61fca681d524..debf53976997 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -12,6 +12,8 @@
 
 #include "ima.skel.h"
 
+#define HELPER_VERBOSITY() (env.verbosity == VERBOSE_NONE ? "no" : "yes")
+
 static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
 {
 	int child_pid, child_status;
@@ -19,7 +21,8 @@ static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
 	child_pid = fork();
 	if (child_pid == 0) {
 		*monitored_pid = getpid();
-		execlp("./ima_setup.sh", "./ima_setup.sh", "run", measured_dir,
+		execlp("./ima_setup.sh", "./ima_setup.sh", "-v",
+		       HELPER_VERBOSITY(), "-a", "run", "-d", measured_dir,
 		       NULL);
 		exit(errno);
 
@@ -52,7 +55,8 @@ void test_test_ima(void)
 	if (CHECK(measured_dir == NULL, "mkdtemp", "err %d\n", errno))
 		goto close_prog;
 
-	snprintf(cmd, sizeof(cmd), "./ima_setup.sh setup %s", measured_dir);
+	snprintf(cmd, sizeof(cmd), "./ima_setup.sh -v %s -a setup -d %s",
+		 HELPER_VERBOSITY(), measured_dir);
 	if (CHECK_FAIL(system(cmd)))
 		goto close_clean;
 
@@ -67,7 +71,8 @@ void test_test_ima(void)
 	      "ima_hash = %lu\n", skel->bss->ima_hash);
 
 close_clean:
-	snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
+	snprintf(cmd, sizeof(cmd), "./ima_setup.sh -v %s -a cleanup -d %s",
+		 HELPER_VERBOSITY(), measured_dir);
 	CHECK_FAIL(system(cmd));
 close_prog:
 	ima__destroy(skel);
-- 
2.29.2.576.ga3fc446d84-goog

