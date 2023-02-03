Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0D689F20
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBCQZK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjBCQZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADFDA6BA0
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C11AB82B49
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77446C433D2;
        Fri,  3 Feb 2023 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441497;
        bh=a2kTHOG6G1Q9n9XbhYCeVVdVyxTUf+B1MLk8lMfeT3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/1pLOBzMytCNVEOnIFy1/9w80QHTS/6P7fzHW5Z+LGlgwb6Pi6Y6lm+h+ji/+iFm
         7aLmPPkkWn4yunEjZT84h8R7sJE7MldMDFzho/6nOTN29zl+746/VerxTuy2MXCK8W
         ZALMoL1om3AVbYQ4QwYQd7nIfUMViHis/hykxMJ3GOo06+9REfcLscpbNgoddKAedN
         /IdaGGWbQN936tMkS7RRnVovhjXoGLf9QS+Z64w7rUTuN745FBA/Bo5AmK74xpt2IW
         b82bIB/BIfTr44D1eTIUuKgW4rUIW6EfDaB0f4ONpQp4De2rwnUqrtjvyKNYi++lvH
         vXJQxdb+/O1ig==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 7/9] selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
Date:   Fri,  3 Feb 2023 17:23:34 +0100
Message-Id: <20230203162336.608323-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the test_verifier allows test to specify kfunc symbol
and search for it in the kernel BTF.

Adding the possibility to search for kfunc also in bpf_testmod
module when it's not found in kernel BTF.

To find bpf_testmod btf we need to get back SYS_ADMIN cap.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
 1 file changed, 139 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 14f11f2dfbce..0a570195be37 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -879,8 +879,140 @@ static int create_map_kptr(void)
 	return fd;
 }
 
+static void set_root(bool set)
+{
+	__u64 caps;
+
+	if (set) {
+		if (cap_enable_effective(1ULL << CAP_SYS_ADMIN, &caps))
+			perror("cap_disable_effective(CAP_SYS_ADMIN)");
+	} else {
+		if (cap_disable_effective(1ULL << CAP_SYS_ADMIN, &caps))
+			perror("cap_disable_effective(CAP_SYS_ADMIN)");
+	}
+}
+
+static inline __u64 ptr_to_u64(const void *ptr)
+{
+	return (__u64) (unsigned long) ptr;
+}
+
+static struct btf *btf__load_testmod_btf(struct btf *vmlinux)
+{
+	struct bpf_btf_info info;
+	__u32 len = sizeof(info);
+	struct btf *btf = NULL;
+	char name[64];
+	__u32 id = 0;
+	int err, fd;
+
+	/* Iterate all loaded BTF objects and find bpf_testmod,
+	 * we need SYS_ADMIN cap for that.
+	 */
+	set_root(true);
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT)
+				break;
+			perror("bpf_btf_get_next_id failed");
+			break;
+		}
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			perror("bpf_btf_get_fd_by_id failed");
+			break;
+		}
+
+		memset(&info, 0, sizeof(info));
+		info.name_len = sizeof(name);
+		info.name = ptr_to_u64(name);
+		len = sizeof(info);
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			close(fd);
+			perror("bpf_obj_get_info_by_fd failed");
+			break;
+		}
+
+		if (strcmp("bpf_testmod", name)) {
+			close(fd);
+			continue;
+		}
+
+		btf = btf__load_from_kernel_by_id_split(id, vmlinux);
+		if (!btf) {
+			close(fd);
+			break;
+		}
+
+		/* We need the fd to stay open so it can be used in fd_array.
+		 * The final cleanup call to btf__free will free btf object
+		 * and close the file descriptor.
+		 */
+		btf__set_fd(btf, fd);
+		break;
+	}
+
+	set_root(false);
+	return btf;
+}
+
+static struct btf *testmod_btf;
+static struct btf *vmlinux_btf;
+
+static void kfuncs_cleanup(void)
+{
+	btf__free(testmod_btf);
+	btf__free(vmlinux_btf);
+}
+
+static void fixup_prog_kfuncs(struct bpf_insn *prog, int *fd_array,
+			      struct kfunc_btf_id_pair *fixup_kfunc_btf_id)
+{
+	/* Patch in kfunc BTF IDs */
+	while (fixup_kfunc_btf_id->kfunc) {
+		int btf_id = 0;
+
+		/* try to find kfunc in kernel BTF */
+		vmlinux_btf = vmlinux_btf ?: btf__load_vmlinux_btf();
+		if (vmlinux_btf) {
+			btf_id = btf__find_by_name_kind(vmlinux_btf,
+							fixup_kfunc_btf_id->kfunc,
+							BTF_KIND_FUNC);
+			btf_id = btf_id < 0 ? 0 : btf_id;
+		}
+
+		/* kfunc not found in kernel BTF, try bpf_testmod BTF */
+		if (!btf_id) {
+			testmod_btf = testmod_btf ?: btf__load_testmod_btf(vmlinux_btf);
+			if (testmod_btf) {
+				btf_id = btf__find_by_name_kind(testmod_btf,
+								fixup_kfunc_btf_id->kfunc,
+								BTF_KIND_FUNC);
+				btf_id = btf_id < 0 ? 0 : btf_id;
+				if (btf_id) {
+					/* We put bpf_testmod module fd into fd_array
+					 * and its index 1 into instruction 'off'.
+					 */
+					*fd_array = btf__fd(testmod_btf);
+					prog[fixup_kfunc_btf_id->insn_idx].off = 1;
+				}
+			}
+		}
+
+		prog[fixup_kfunc_btf_id->insn_idx].imm = btf_id;
+		fixup_kfunc_btf_id++;
+	}
+}
+
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
-			  struct bpf_insn *prog, int *map_fds)
+			  struct bpf_insn *prog, int *map_fds, int *fd_array)
 {
 	int *fixup_map_hash_8b = test->fixup_map_hash_8b;
 	int *fixup_map_hash_48b = test->fixup_map_hash_48b;
@@ -905,7 +1037,6 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
 	int *fixup_map_timer = test->fixup_map_timer;
 	int *fixup_map_kptr = test->fixup_map_kptr;
-	struct kfunc_btf_id_pair *fixup_kfunc_btf_id = test->fixup_kfunc_btf_id;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -1106,25 +1237,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 		} while (*fixup_map_kptr);
 	}
 
-	/* Patch in kfunc BTF IDs */
-	if (fixup_kfunc_btf_id->kfunc) {
-		struct btf *btf;
-		int btf_id;
-
-		do {
-			btf_id = 0;
-			btf = btf__load_vmlinux_btf();
-			if (btf) {
-				btf_id = btf__find_by_name_kind(btf,
-								fixup_kfunc_btf_id->kfunc,
-								BTF_KIND_FUNC);
-				btf_id = btf_id < 0 ? 0 : btf_id;
-			}
-			btf__free(btf);
-			prog[fixup_kfunc_btf_id->insn_idx].imm = btf_id;
-			fixup_kfunc_btf_id++;
-		} while (fixup_kfunc_btf_id->kfunc);
-	}
+	fixup_prog_kfuncs(prog, fd_array, test->fixup_kfunc_btf_id);
 }
 
 struct libcap {
@@ -1451,6 +1564,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int run_errs, run_successes;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
+	int fd_array[2] = { -1, -1 };
 	int saved_errno;
 	int fixup_skips;
 	__u32 pflags;
@@ -1464,7 +1578,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (!prog_type)
 		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
 	fixup_skips = skips;
-	do_test_fixup(test, prog_type, prog, map_fds);
+	do_test_fixup(test, prog_type, prog, map_fds, &fd_array[1]);
 	if (test->fill_insns) {
 		prog = test->fill_insns;
 		prog_len = test->prog_len;
@@ -1498,6 +1612,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	else
 		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
+	if (fd_array[1] != -1)
+		opts.fd_array = &fd_array[0];
 
 	if ((prog_type == BPF_PROG_TYPE_TRACING ||
 	     prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
@@ -1740,6 +1856,7 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 	}
 
 	unload_bpf_testmod(verbose);
+	kfuncs_cleanup();
 
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
-- 
2.39.1

