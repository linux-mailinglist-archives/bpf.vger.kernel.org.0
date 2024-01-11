Return-Path: <bpf+bounces-19381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CE82B5C5
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 21:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B641F2471D
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC956B83;
	Thu, 11 Jan 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLVO6ej8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A656B63;
	Thu, 11 Jan 2024 20:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE4C433F1;
	Thu, 11 Jan 2024 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705004226;
	bh=Wn/R667HLOu9IarBZBF7S2YrJGWsIKf4kWdjkOuJOCY=;
	h=From:Date:Subject:To:Cc:From;
	b=MLVO6ej8gPFD/oEWh94ZTPcIVeyGLp1dDA2t+UqFozWCTldoLwopGD6XuTP7ipNf0
	 ur9ohAGmfPNYk3Q/r+pX8zgSCHznwrqUaAAtsSs7UjpNnW+Ds6/bxjZ31FtZnpGgNh
	 /GAiCTObn7LxdjgvxZJHrVGjQfrQLVKTy786pA09QwHJpzAt8D4fWTSVKqlFqYl2Yq
	 T5vMBu4TKQky7c50B0xU6qDXjJu1DsoNAZa+8BGmNLobFfpKan0wln2qxZ+Eo8iihA
	 8fAkVeEFY1B+mm0TLuIfEpBR276zHJsmAPZQrpgbDK29IV0GYdheoLfusbEN4Gsn2P
	 82rTY7aFYm3tw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 11 Jan 2024 13:16:48 -0700
Subject: [PATCH bpf-next v2] selftests/bpf: Update LLVM Phabricator links
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-bpf-update-llvm-phabricator-links-v2-1-9a7ae976bd64@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK9MoGUC/x2NQQqDMBAAvyJ77kJMRYhfKT1Es9HFNIZNFEH8e
 9Me5zAzF2QSpgxDc4HQwZm3WEE/GpgWG2dCdpVBK92pVhkck8c9OVsIQzg+mBY7Ck+2bIKB45r
 Rqac3ru8MtQS1k4Q8n//HC356pLPA+76/Nr1pAX0AAAA=
To: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc: mykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
 patches@lists.linux.dev, llvm@lists.linux.dev, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7969; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Wn/R667HLOu9IarBZBF7S2YrJGWsIKf4kWdjkOuJOCY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkLfA5KS7Ql8Uv4zf6l/ykl0fOH2okKD1W16z6+c28zL
 MybalrZUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbSIsnI0Lt4V8j0CQqMft7q
 lZx8PTf/NrC+6p1RFy78b+nypUmeAYwMV1LMV93+2v2ac9n1dz4LE4IYDixisWTY67U29I/DFQ5
 9fgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

reviews.llvm.org was LLVM's Phabricator instances for code review. It
has been abandoned in favor of GitHub pull requests. While the majority
of links in the kernel sources still work because of the work Fangrui
has done turning the dynamic Phabricator instance into a static archive,
there are some issues with that work, so preemptively convert all the
links in the kernel sources to point to the commit on GitHub.

Most of the commits have the corresponding differential review link in
the commit message itself so there should not be any loss of fidelity in
the relevant information.

Additionally, fix a typo in the xdpwall.c print ("LLMV" -> "LLVM") while
in the area.

Link: https://discourse.llvm.org/t/update-on-github-pull-requests/71540/172
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Split patch off from rest of series, as BPF folks would like to take
  it separately from the rest of the series.
- Fix link in xdpwall section of README (Yonghong)
- Add Yonghong's ack
- Link to v1: https://lore.kernel.org/r/20240109-update-llvm-links-v1-1-eb09b59db071@kernel.org
---
 tools/testing/selftests/bpf/README.rst             | 32 +++++++++++-----------
 tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
 .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 9af79c7a9b58..9b974e425af3 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -115,7 +115,7 @@ the insn 20 undoes map_value addition. It is currently impossible for the
 verifier to understand such speculative pointer arithmetic.
 Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
 
-__ https://reviews.llvm.org/D85570
+__ https://github.com/llvm/llvm-project/commit/ddf1864ace484035e3cde5e83b3a31ac81e059c6
 
 The corresponding C code
 
@@ -165,7 +165,7 @@ This is due to a llvm BPF backend bug. `The fix`__
 has been pushed to llvm 10.x release branch and will be
 available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
 
-__  https://reviews.llvm.org/D78466
+__  https://github.com/llvm/llvm-project/commit/3cb7e7bf959dcd3b8080986c62e10a75c7af43f0
 
 bpf_verif_scale/loop6.bpf.o test failure with Clang 12
 ======================================================
@@ -204,7 +204,7 @@ r5(w5) is eventually saved on stack at insn #24 for later use.
 This cause later verifier failure. The bug has been `fixed`__ in
 Clang 13.
 
-__  https://reviews.llvm.org/D97479
+__  https://github.com/llvm/llvm-project/commit/1959ead525b8830cc8a345f45e1c3ef9902d3229
 
 BPF CO-RE-based tests and Clang version
 =======================================
@@ -221,11 +221,11 @@ failures:
 - __builtin_btf_type_id() [0_, 1_, 2_];
 - __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
 
-.. _0: https://reviews.llvm.org/D74572
-.. _1: https://reviews.llvm.org/D74668
-.. _2: https://reviews.llvm.org/D85174
-.. _3: https://reviews.llvm.org/D83878
-.. _4: https://reviews.llvm.org/D83242
+.. _0: https://github.com/llvm/llvm-project/commit/6b01b465388b204d543da3cf49efd6080db094a9
+.. _1: https://github.com/llvm/llvm-project/commit/072cde03aaa13a2c57acf62d79876bf79aa1919f
+.. _2: https://github.com/llvm/llvm-project/commit/00602ee7ef0bf6c68d690a2bd729c12b95c95c99
+.. _3: https://github.com/llvm/llvm-project/commit/6d218b4adb093ff2e9764febbbc89f429412006c
+.. _4: https://github.com/llvm/llvm-project/commit/6d6750696400e7ce988d66a1a00e1d0cb32815f8
 
 Floating-point tests and Clang version
 ======================================
@@ -234,7 +234,7 @@ Certain selftests, e.g. core_reloc, require support for the floating-point
 types, which was introduced in `Clang 13`__. The older Clang versions will
 either crash when compiling these tests, or generate an incorrect BTF.
 
-__  https://reviews.llvm.org/D83289
+__  https://github.com/llvm/llvm-project/commit/a7137b238a07d9399d3ae96c0b461571bd5aa8b2
 
 Kernel function call test and Clang version
 ===========================================
@@ -248,7 +248,7 @@ Without it, the error from compiling bpf selftests looks like:
 
   libbpf: failed to find BTF for extern 'tcp_slow_start' [25] section: -2
 
-__ https://reviews.llvm.org/D93563
+__ https://github.com/llvm/llvm-project/commit/886f9ff53155075bd5f1e994f17b85d1e1b7470c
 
 btf_tag test and Clang version
 ==============================
@@ -264,8 +264,8 @@ Without them, the btf_tag selftest will be skipped and you will observe:
 
   #<test_num> btf_tag:SKIP
 
-.. _0: https://reviews.llvm.org/D111588
-.. _1: https://reviews.llvm.org/D111199
+.. _0: https://github.com/llvm/llvm-project/commit/a162b67c98066218d0d00aa13b99afb95d9bb5e6
+.. _1: https://github.com/llvm/llvm-project/commit/3466e00716e12e32fdb100e3fcfca5c2b3e8d784
 
 Clang dependencies for static linking tests
 ===========================================
@@ -274,7 +274,7 @@ linked_vars, linked_maps, and linked_funcs tests depend on `Clang fix`__ to
 generate valid BTF information for weak variables. Please make sure you use
 Clang that contains the fix.
 
-__ https://reviews.llvm.org/D100362
+__ https://github.com/llvm/llvm-project/commit/968292cb93198442138128d850fd54dc7edc0035
 
 Clang relocation changes
 ========================
@@ -292,7 +292,7 @@ Here, ``type 2`` refers to new relocation type ``R_BPF_64_ABS64``.
 To fix this issue, user newer libbpf.
 
 .. Links
-.. _clang reloc patch: https://reviews.llvm.org/D102712
+.. _clang reloc patch: https://github.com/llvm/llvm-project/commit/6a2ea84600ba4bd3b2733bd8f08f5115eb32164b
 .. _kernel llvm reloc: /Documentation/bpf/llvm_reloc.rst
 
 Clang dependencies for the u32 spill test (xdpwall)
@@ -304,6 +304,6 @@ from running test_progs will look like:
 
 .. code-block:: console
 
-  test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexpected error: -4007
+  test_xdpwall:FAIL:Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5? unexpected error: -4007
 
-__ https://reviews.llvm.org/D109073
+__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5
diff --git a/tools/testing/selftests/bpf/prog_tests/xdpwall.c b/tools/testing/selftests/bpf/prog_tests/xdpwall.c
index f3927829a55a..4599154c8e9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdpwall.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdpwall.c
@@ -9,7 +9,7 @@ void test_xdpwall(void)
 	struct xdpwall *skel;
 
 	skel = xdpwall__open_and_load();
-	ASSERT_OK_PTR(skel, "Does LLMV have https://reviews.llvm.org/D109073?");
+	ASSERT_OK_PTR(skel, "Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5?");
 
 	xdpwall__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c b/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
index 22aba3f6e344..6fc8b9d66e34 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
@@ -80,7 +80,7 @@ int test_core_type_id(void *ctx)
 	 * to detect whether this test has to be executed, however strange
 	 * that might look like.
 	 *
-	 *   [0] https://reviews.llvm.org/D85174
+	 *   [0] https://github.com/llvm/llvm-project/commit/00602ee7ef0bf6c68d690a2bd729c12b95c95c99
 	 */
 #if __has_builtin(__builtin_preserve_type_info)
 	struct core_reloc_type_id_output *out = (void *)&data.out;

---
base-commit: 3fbf61207c66ff7ac9b60ab76d4bfd239f97e973
change-id: 20240109-bpf-update-llvm-phabricator-links-d03f9d649e1e

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


