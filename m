Return-Path: <bpf+bounces-34707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D1930232
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 00:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0251C21170
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B546CDB3;
	Fri, 12 Jul 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpVONovv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD61FF5
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824294; cv=none; b=DXbMi4qC+/ULhNGMp5vO+q1B1gk+x3+HREa6J5Kg+vwcThDR06WtRusq9reBnzJ5LGr9DOAqD0WodlmVrKpWMdZIpM3B0SUA2edef6NBd7SgDxV/gQXJcvgqMQHca21a4jNmtwLVl/ztwX9HO5QMa/572lnHLRqaTw+XimzcllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824294; c=relaxed/simple;
	bh=VbglsXQsaynruoPOdmdJr2zExkjBGOquuOpSt52iLmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gw/naDDZhUsAFyRHrmsgtkYknV4RfRR3w49F6U0D/2YNArYAW0ZawzyiCCjlel8MBZqoMY+Br4OGHCCWFF3e17j4MINjzjhJRI4BPIFAvJzA11WzMJOL/KcAydnnJqKEAtJHan63crXRldM/WZkuCzBEX8+f8wTA3VrNnBtpR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpVONovv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8721BC32782;
	Fri, 12 Jul 2024 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720824293;
	bh=VbglsXQsaynruoPOdmdJr2zExkjBGOquuOpSt52iLmE=;
	h=From:To:Cc:Subject:Date:From;
	b=QpVONovvtDyw5RSLJ+WU2ddFtXeFm8WyXTcKEYzD4jC0aK/vPqQwX24xD2lEOGB/B
	 4wWkU6Fz2Gm9nQrsrugGA2d8XPvehbQl+mSwsiJnwgH6ZZ9WuZtZ417LZKVegzeVAZ
	 wC+qlgjOIMY7Q7J82E6EDlfJgUKxfuj2qG/ajOUXLtP9iBtX6DNqyXFUWDLDWZ5U4c
	 XgJ+60z5z9+RkN5n6YpFWyeNP4C+vraJfh2hUAQCqJumrirCTwof/uVFIeidBhyBBs
	 msnSWTqppnFcF8z91i5b/8AKfotegDc9qV6UhjNP2FUuG1YN5vksQcCkk8ZH3XbiOm
	 mHhLx3UTjcW8A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next] libbpf: fix no-args func prototype BTF dumping syntax
Date: Fri, 12 Jul 2024 15:44:42 -0700
Message-ID: <20240712224442.282823-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For all these years libbpf's BTF dumper has been emitting not strictly
valid syntax for function prototypes that have no input arguments.

Instead of `int (*blah)()` we should emit `int (*blah)(void)`.

This is not normally a problem, but it manifests when we get kfuncs in
vmlinux.h that have no input arguments. Due to compiler internal
specifics, we get no BTF information for such kfuncs, if they are not
declared with proper `(void)`.

The fix is trivial. We also need to adjust a few ancient tests that
happily assumed `()` is correct.

Reported-by: Tejun Heo <tj@kernel.org>
Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c                                  | 8 +++++---
 .../selftests/bpf/progs/btf_dump_test_case_multidim.c     | 4 ++--
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c       | 4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..894860111ddb 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1559,10 +1559,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			 * Clang for BPF target generates func_proto with no
 			 * args as a func_proto with a single void arg (e.g.,
 			 * `int (*f)(void)` vs just `int (*f)()`). We are
-			 * going to pretend there are no args for such case.
+			 * going to emit valid empty args (void) syntax for
+			 * such case. Similarly and conveniently, valid
+			 * no args case can be special-cased here as well.
 			 */
-			if (vlen == 1 && p->type == 0) {
-				btf_dump_printf(d, ")");
+			if (vlen == 0 || (vlen == 1 && p->type == 0)) {
+				btf_dump_printf(d, "void)");
 				return;
 			}
 
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
index ba97165bdb28..a657651eba52 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
@@ -14,9 +14,9 @@ typedef int *ptr_arr_t[6];
 
 typedef int *ptr_multiarr_t[7][8][9][10];
 
-typedef int * (*fn_ptr_arr_t[11])();
+typedef int * (*fn_ptr_arr_t[11])(void);
 
-typedef int * (*fn_ptr_multiarr_t[12][13])();
+typedef int * (*fn_ptr_multiarr_t[12][13])(void);
 
 struct root_struct {
 	arr_t _1;
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index ad21ee8c7e23..29d01fff32bd 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -100,7 +100,7 @@ typedef void (*printf_fn_t)(const char *, ...);
  *   `int -> char *` function and returns pointer to a char. Equivalent:
  *   typedef char * (*fn_input_t)(int);
  *   typedef char * (*fn_output_outer_t)(fn_input_t);
- *   typedef const fn_output_outer_t (* fn_output_inner_t)();
+ *   typedef const fn_output_outer_t (* fn_output_inner_t)(void);
  *   typedef const fn_output_inner_t fn_ptr_arr2_t[5];
  */
 /* ----- START-EXPECTED-OUTPUT ----- */
@@ -127,7 +127,7 @@ typedef void (* (*signal_t)(int, void (*)(int)))(int);
 
 typedef char * (*fn_ptr_arr1_t[10])(int **);
 
-typedef char * (* (* const fn_ptr_arr2_t[5])())(char * (*)(int));
+typedef char * (* (* const fn_ptr_arr2_t[5])(void))(char * (*)(int));
 
 struct struct_w_typedefs {
 	int_t a;
-- 
2.43.0


