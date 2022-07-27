Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1114F581CAE
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 02:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiG0AML (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiG0AML (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 20:12:11 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1952A40F
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 17:12:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AF1D3240028
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 02:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658880727; bh=9ACQZKOkhvUrSY9x58olahJw+M5bofljsIf5P7c5rgM=;
        h=From:To:Cc:Subject:Date:From;
        b=aul496yo5CHs7pKhEEQH0G2OqWephNlzfzWQinjW+OPgzv52QP6OyaUwJcrDfA6ok
         3mAxW7X26aJud82j7J6xFguzQ7oSB02N9OoEtCmYafOxwDXqeVuXsohhpDpqg/lsBB
         91UCQnI9iGMVrQR7Md+0WK3bRcKnmEd9CDEaYkaXnNeonis1AOsnHL0bou9P1OvPEP
         OI3UEXKzZdrP3LddmE8LtjXiT8/1enyZQNuLAxVFfc9X+efXVfcrMW32VsMsCLQDTg
         Dolup37dZQkddWt9/IKLN81jsGE3Nb4/fxar18U+fucxoSh6m3owU1ReV2qgkiDNVE
         Bfz2a0hjq11gg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LsvNR060Kz6tnX;
        Wed, 27 Jul 2022 02:12:07 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com, Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Adjust vmtest.sh to use local kernel configuration
Date:   Wed, 27 Jul 2022 00:11:56 +0000
Message-Id: <20220727001156.3553701-4-deso@posteo.net>
In-Reply-To: <20220727001156.3553701-1-deso@posteo.net>
References: <20220727001156.3553701-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 51 +++++++++++++++++----------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index e0bb04a..b86ae4 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -30,8 +30,7 @@ DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
-KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/config-latest.${ARCH}"
-KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/config-latest.${ARCH}"
+KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config" "tools/testing/selftests/bpf/config.${ARCH}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -269,26 +268,42 @@ is_rel_path()
 	[[ ${path:0:1} != "/" ]]
 }
 
+do_update_kconfig()
+{
+	local kernel_checkout="$1"
+	local kconfig_file="$2"
+
+	rm -f "$kconfig_file" 2> /dev/null
+
+	for config in "${KCONFIG_REL_PATHS[@]}"; do
+		local kconfig_src="${kernel_checkout}/${config}"
+		cat "$kconfig_src" >> "$kconfig_file"
+	done
+}
+
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
+
 	if [[ -f "${kconfig_file}" ]]; then
-		local last_modified_date="$(curl -sL -D - "${KCONFIG_API_URL}" -o /dev/null | \
-			grep "last-modified" | awk -F ': ' '{print $2}')"
-		local remote_modified_timestamp="$(date -d "${last_modified_date}" +"%s")"
-		local local_creation_timestamp="$(stat -c %Y "${kconfig_file}")"
+		local local_modified="$(stat -c %Y "${kconfig_file}")"
 
-		if [[ "${remote_modified_timestamp}" -gt "${local_creation_timestamp}" ]]; then
-			${update_command}
-		fi
+		for config in "${KCONFIG_REL_PATHS[@]}"; do
+			local kconfig_src="${kernel_checkout}/${config}"
+			local src_modified="$(stat -c %Y "${kconfig_src}")"
+			# Only update the config if it has been updated after the
+			# previously cached config was created. This avoids
+			# unnecessarily compiling the kernel and selftests.
+			if [[ "${src_modified}" -gt "${local_modified}" ]]; then
+				do_update_kconfig "$kernel_checkout" "$kconfig_file"
+				# Once we have found one outdated configuration
+				# there is no need to check other ones.
+				break
+			fi
+		done
 	else
-		${update_command}
+		do_update_kconfig "$kernel_checkout" "$kconfig_file"
 	fi
 }
 
@@ -372,7 +387,7 @@ main()
 
 	mkdir -p "${OUTPUT_DIR}"
 	mkdir -p "${mount_dir}"
-	update_kconfig "${kconfig_file}"
+	update_kconfig "${kernel_checkout}" "${kconfig_file}"
 
 	recompile_kernel "${kernel_checkout}" "${make_command}"
 
-- 
2.30.2

