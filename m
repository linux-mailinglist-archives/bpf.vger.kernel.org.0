Return-Path: <bpf+bounces-23250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B486F17B
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A62F283255
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA392241E7;
	Sat,  2 Mar 2024 16:50:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A22F0D
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398249; cv=none; b=RHAD4nczh6UUF97d5Tyv0WAzQsIlhHVM8gzvx9gOKWGanukzBPuc10EXEARwb2kvjygJzSFxNrhDsagpdKXCnred1Nplen6XDgAfVPmk0qpP5sTWgi4kQ+QT+a+R8a0mU2QBbrI8TVXSZtda6mbfFqU6fCOVUhQOXyYbiu5Q2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398249; c=relaxed/simple;
	bh=BhYRMw/JbHPDeiLEkih1Uj7FeJ6A2IBeH3+doHNoIwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsxuSJ58ykRqwZwr3YV3L8D+993d1AmKaNR8MOTAiNj4JA+1YeEv0mrmLVsUQK/vICxdbZoulljJx2/FFeO04RSMUbnd6C+odo0Y+hFPs5nBhUBRUiWBHMffINaOzRLVO+DpBsuGQWtDzqAyfqbyDsg2Yimjaz1ajbN8FCVw0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4D3D711F1241; Sat,  2 Mar 2024 08:50:38 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Fix possible kprobe_multi_bench_attach test failure with LTO kernel
Date: Sat,  2 Mar 2024 08:50:38 -0800
Message-ID: <20240302165038.1628632-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302165017.1627295-1-yonghong.song@linux.dev>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In my locally build clang LTO kernel (enabling CONFIG_LTO and
CONFIG_LTO_CLANG_THIN), kprobe_multi_bench_attach/kernel subtest
failed like:
  test_kprobe_multi_bench_attach:PASS:get_syms 0 nsec
  test_kprobe_multi_bench_attach:PASS:kprobe_multi_empty__open_and_load 0=
 nsec
  libbpf: prog 'test_kprobe_empty': failed to attach: No such process
  test_kprobe_multi_bench_attach:FAIL:bpf_program__attach_kprobe_multi_op=
ts unexpected error: -3
  #114/1   kprobe_multi_bench_attach/kernel:FAIL

There are multiple symbols in /sys/kernel/debug/tracing/available_filter_=
functions
are renamed in kallsyms due to cross file inlining. One example is for
  static function __access_remote_vm in mm/memory.c.
In a non-LTO kernel, we have the following call stack:
  ptrace_access_vm (global, kernel/ptrace.c)
    access_remote_vm (global, mm/memory.c)
      __access_remote_vm (static, mm/memory.c)

With LTO kernel, it is possible that access_remote_vm() is inlined by
ptrace_access_vm(). So we end up with the following call stack:
  ptrace_access_vm (global, kernel/ptrace.c)
    __access_remote_vm (static, mm/memory.c)
The compiler renames __access_remote_vm to __access_remote_vm.llvm.<hash>
to prevent potential name collision.

This patch removed __access_remote_vm and other similar functions from
kprobe_multi_attach by checking if the symbol like __access_remote_vm
does not exist in kallsyms with LTO kernel. The test succeeded after this=
 change:
  #114/1   kprobe_multi_bench_attach/kernel:OK

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 05000810e28e..2aad5f9cdb84 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -341,10 +341,15 @@ static int get_syms(char ***symsp, size_t *cntp, bo=
ol kernel)
 	size_t cap =3D 0, cnt =3D 0, i;
 	char *name =3D NULL, **syms =3D NULL;
 	struct hashmap *map;
+	bool lto_kernel;
 	char buf[256];
 	FILE *f;
 	int err =3D 0;
=20
+	lto_kernel =3D kernel && check_lto_kernel() =3D=3D 1;
+	if (lto_kernel && !ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return -EINVAL;
+
 	/*
 	 * The available_filter_functions contains many duplicates,
 	 * but other than that all symbols are usable in kprobe multi
@@ -393,6 +398,8 @@ static int get_syms(char ***symsp, size_t *cntp, bool=
 kernel)
 		if (!strncmp(name, "__ftrace_invalid_address__",
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
+		if (lto_kernel && ksym_get_addr(name) =3D=3D 0)
+			continue;
=20
 		err =3D hashmap__add(map, name, 0);
 		if (err =3D=3D -EEXIST) {
--=20
2.43.0


