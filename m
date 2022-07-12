Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B9572870
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiGLVVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiGLVVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:21:37 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C75BE0FB
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:21:35 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 44563240028
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657660894; bh=75uv+CAVHwRQa5YiroufAwxwKrYXSIGpqf/kgRzpZ4c=;
        h=From:To:Cc:Subject:Date:From;
        b=nBlQQhhIJBPzK/H2rZZPUfnu6LNRQjXNMTH747XUn5FK8XUPzlKIxl1BXEXTVYOxn
         FM7wf/mQY+jeuxIlj39EcKq2GUnl9axgXjt3CnQSa/P7313bu3Ml5djfugEUYSOzei
         D+kKkRlLvATgKVdMaSeLMzptX+sBdzK5bbaABLxBy9gmi2cjzrpvOz/brOrV44nGut
         gXwSH80QXWYihkE0dOUyZpkXBUEN3VVWxKDkMOh4fpMO/cDqwE7cK/OEt7dPOFe2FP
         3Nl5GEf0zHTAdtb8CLmCU5Fpm5LjD5xNMd36456mukNqoE1Di/qQWHk4CA7Zc27gXh
         7NgYiAD5AJYnw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjDG53pm9z9rxM;
        Tue, 12 Jul 2022 23:21:33 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Adjust vmtest.sh to use local kernel configuration
Date:   Tue, 12 Jul 2022 21:21:24 +0000
Message-Id: <20220712212124.3180314-4-deso@posteo.net>
In-Reply-To: <20220712212124.3180314-1-deso@posteo.net>
References: <20220712212124.3180314-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

So far the vmtest.sh script, which can be used as a convenient way to
run bpf selftests, has obtained the kernel config safe to use for
testing from the libbpf/libbpf GitHub repository [0].
Given that we now have included this configuration into this very
repository, we can just consume it from here as well, eliminating the
necessity of remote accesses.
With this change we adjust the logic in the script to use the
configuration from below tools/testing/selftests/bpf/configs/ instead of
pulling it over the network.

[0]: https://github.com/libbpf/libbpf

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/vmtest.sh | 28 ++++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index e0bb04a..fdab48 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -30,8 +30,7 @@ DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
-KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/config-latest.${ARCH}"
-KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/config-latest.${ARCH}"
+KCONFIG_REL_PATH="tools/testing/selftests/bpf/configs/config-latest.${ARCH}"
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -271,20 +270,17 @@ is_rel_path()
 
 update_kconfig()
 {
-	local kconfig_file="$1"
-	local update_command="curl -sLf ${KCONFIG_URL} -o ${kconfig_file}"
-	# Github does not return the "last-modified" header when retrieving the
-	# raw contents of the file. Use the API call to get the last-modified
-	# time of the kernel config and only update the config if it has been
-	# updated after the previously cached config was created. This avoids
-	# unnecessarily compiling the kernel and selftests.
+	local kernel_checkout="$1"
+	local kconfig_file="$2"
+	local kconfig_src="${kernel_checkout}/${KCONFIG_REL_PATH}"
+	local update_command="cp ${kconfig_src} ${kconfig_file}"
 	if [[ -f "${kconfig_file}" ]]; then
-		local last_modified_date="$(curl -sL -D - "${KCONFIG_API_URL}" -o /dev/null | \
-			grep "last-modified" | awk -F ': ' '{print $2}')"
-		local remote_modified_timestamp="$(date -d "${last_modified_date}" +"%s")"
-		local local_creation_timestamp="$(stat -c %Y "${kconfig_file}")"
-
-		if [[ "${remote_modified_timestamp}" -gt "${local_creation_timestamp}" ]]; then
+		local src_modified="$(stat -c %Y "${kconfig_src}")"
+		local local_modified="$(stat -c %Y "${kconfig_file}")"
+		# Only update the config if it has been updated after the
+		# previously cached config was created. This avoids
+		# unnecessarily compiling the kernel and selftests.
+		if [[ "${src_modified}" -gt "${local_modified}" ]]; then
 			${update_command}
 		fi
 	else
@@ -372,7 +368,7 @@ main()
 
 	mkdir -p "${OUTPUT_DIR}"
 	mkdir -p "${mount_dir}"
-	update_kconfig "${kconfig_file}"
+	update_kconfig "${kernel_checkout}" "${kconfig_file}"
 
 	recompile_kernel "${kernel_checkout}" "${make_command}"
 
-- 
2.30.2

