Return-Path: <bpf+bounces-529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE9702E7A
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2B1C20B56
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336BC8FA;
	Mon, 15 May 2023 13:39:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581DC8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7B9C433EF;
	Mon, 15 May 2023 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157963;
	bh=FDOvcgH3+/MO+0zN2RTIAol1NlN9+7y5aTSYEIT6Aks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjxMm/wS6vfIa5cjQHtvmYoO+Sd8P6kiFwnAeb74fw7Ycev0P1QyzDzgkIIDBXKjT
	 L6q9eu900rHuTPE1kwvuK5/KsRi56YkOwxuM+UQ+uinLKqiMl326I2zfY/ey0+G5Ue
	 MJJZIIATUaC8aiV2jIckLySQoL6Aw1sNCuuQhi4zFShB3BDiCa8fxVErtpDUGhntiu
	 DasxgpZxD10COYMOdA88m8RRf6vwcVBx5YAkXXlfGH1SEI4Xys40yIFZTvIE8FNvPP
	 XvDdf+a/BF064ZzX7GDvon6iLgiCHYM9Dk0kRDkTmYQ5kX2xTrUXdakCioHmgMx81M
	 +l+qbymNakRJg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 08/10] selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
Date: Mon, 15 May 2023 15:37:54 +0200
Message-Id: <20230515133756.1658301-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the test_verifier allows test to specify kfunc symbol
and search for it in the kernel BTF.

Adding the possibility to search for kfunc also in bpf_testmod
module when it's not found in kernel BTF.

To find bpf_testmod btf we need to get back SYS_ADMIN cap.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
 1 file changed, 139 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 285ea4aba194..71704a38cac3 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -874,8 +874,140 @@ static int create_map_kptr(void)
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
+static __u64 ptr_to_u64(const void *ptr)
+{
+	return (uintptr_t) ptr;
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
@@ -900,7 +1032,6 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
 	int *fixup_map_timer = test->fixup_map_timer;
 	int *fixup_map_kptr = test->fixup_map_kptr;
-	struct kfunc_btf_id_pair *fixup_kfunc_btf_id = test->fixup_kfunc_btf_id;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -1101,25 +1232,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
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
@@ -1446,6 +1559,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int run_errs, run_successes;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
+	int fd_array[2] = { -1, -1 };
 	int saved_errno;
 	int fixup_skips;
 	__u32 pflags;
@@ -1459,7 +1573,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (!prog_type)
 		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
 	fixup_skips = skips;
-	do_test_fixup(test, prog_type, prog, map_fds);
+	do_test_fixup(test, prog_type, prog, map_fds, &fd_array[1]);
 	if (test->fill_insns) {
 		prog = test->fill_insns;
 		prog_len = test->prog_len;
@@ -1493,6 +1607,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	else
 		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
+	if (fd_array[1] != -1)
+		opts.fd_array = &fd_array[0];
 
 	if ((prog_type == BPF_PROG_TYPE_TRACING ||
 	     prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
@@ -1719,6 +1835,7 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 	}
 
 	unload_bpf_testmod(verbose);
+	kfuncs_cleanup();
 
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
-- 
2.40.1


