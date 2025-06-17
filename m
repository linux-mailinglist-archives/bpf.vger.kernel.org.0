Return-Path: <bpf+bounces-60793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B652ADC112
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 06:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A9D188DF74
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FD238151;
	Tue, 17 Jun 2025 04:50:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE07221F09
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135813; cv=none; b=r78AUMyJnBb4gBepandONBcdSKqataWM5zqJhgnfGbU/NsGKaVCMo97P+m5irsVaELAPcLKmDE16O5vdC/A/Q/d+uQjblZ0bsxseIizbUcMv07xfT4p+NrBWHGnJ2vMRVNAtFEa8yfin6TdGN7h5Kq3WVPv4kQmHE9IxbDd4E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135813; c=relaxed/simple;
	bh=EYh7ZovI2c7m/RqW4i/blSH2PmCjJVBC7F0PSDngRak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQCU2Dvl5KyZYs4/fn0GVshcc1UM0xpgVetOj2WbEnwF+2V7+8l1Lor65LUi8yV9nS2dMLXfm54vxlAiR6lb8MD+obvgS9V2JuOEf66TBViZ5YkKBW9GRkNkXbB1aGTj1ApX8qP/JmWlwq14TcV8Pi/nVbxPZMynNI0H8aE8Zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 40A449C3E05F; Mon, 16 Jun 2025 21:49:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix RELEASE build failure with gcc14
Date: Mon, 16 Jun 2025 21:49:56 -0700
Message-ID: <20250617044956.2686668-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

With gcc14, when building with RELEASE=3D1, I hit four below compilation
failure:

Error 1:
  In file included from test_loader.c:6:
  test_loader.c: In function =E2=80=98run_subtest=E2=80=99: test_progs.h:=
194:17:
      error: =E2=80=98retval=E2=80=99 may be used uninitialized in this f=
unction
   [-Werror=3Dmaybe-uninitialized]
    194 |                 fprintf(stdout, ##format);           \
        |                 ^~~~~~~
  test_loader.c:958:13: note: =E2=80=98retval=E2=80=99 was declared here
    958 |         int retval, err, i;
        |             ^~~~~~

  The uninitialized var 'retval' actaully could cause incorrect result.

Error 2:
  In function =E2=80=98test_fd_array_cnt=E2=80=99:
  prog_tests/fd_array.c:71:14: error: =E2=80=98btf_id=E2=80=99 may be use=
d uninitialized in this
      function [-Werror=3Dmaybe-uninitialized]
     71 |         fd =3D bpf_btf_get_fd_by_id(id);
        |              ^~~~~~~~~~~~~~~~~~~~~~~~
  prog_tests/fd_array.c:302:15: note: =E2=80=98btf_id=E2=80=99 was declar=
ed here
    302 |         __u32 btf_id;
        |               ^~~~~~

  Changing ASSERT_GE to ASSERT_EQ can fix the compilation error. Otherwis=
e,
  there is no functionality change.

Error 3:
  prog_tests/tailcalls.c: In function =E2=80=98test_tailcall_hierarchy_co=
unt=E2=80=99:
  prog_tests/tailcalls.c:1402:23: error: =E2=80=98fentry_data_fd=E2=80=99=
 may be used uninitialized
      in this function [-Werror=3Dmaybe-uninitialized]
     1402 |                 err =3D bpf_map_lookup_elem(fentry_data_fd, &=
i, &val);
          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

  The code is correct. The change intends to slient gcc errors.

Error 4: (this error only happens on arm64)
  In file included from prog_tests/log_buf.c:4:
  prog_tests/log_buf.c: In function =E2=80=98bpf_prog_load_log_buf=E2=80=99=
:
  ./test_progs.h:390:22: error: =E2=80=98log_buf=E2=80=99 may be used uni=
nitialized [-Werror=3Dmaybe-uninitialized]
    390 |         int ___err =3D libbpf_get_error(___res);             \
        |                      ^~~~~~~~~~~~~~~~~~~~~~~~
  prog_tests/log_buf.c:158:14: note: in expansion of macro =E2=80=98ASSER=
T_OK_PTR=E2=80=99
    158 |         if (!ASSERT_OK_PTR(log_buf, "log_buf_alloc"))
        |              ^~~~~~~~~~~~~
  In file included from selftests/bpf/tools/include/bpf/bpf.h:32,
                 from ./test_progs.h:36:
  selftests/bpf/tools/include/bpf/libbpf_legacy.h:113:17:
    note: by argument 1 of type =E2=80=98const void *=E2=80=99 to =E2=80=98=
libbpf_get_error=E2=80=99 declared here
    113 | LIBBPF_API long libbpf_get_error(const void *ptr);
        |                 ^~~~~~~~~~~~~~~~

  Adding a pragma to disable maybe-uninitialized fixed the issue.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/fd_array.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/log_buf.c   | 4 ++++
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 2 +-
 tools/testing/selftests/bpf/test_loader.c          | 6 +++---
 4 files changed, 9 insertions(+), 5 deletions(-)

NOTE: I found these issues when I tried to compare usdt.test.o binaries
      when building selftests with and without RELEASE=3D1.

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/te=
sting/selftests/bpf/prog_tests/fd_array.c
index 9add890c2d37..241b2c8c6e0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -312,7 +312,7 @@ static void check_fd_array_cnt__referenced_btfs(void)
=20
 	/* btf should still exist when original file descriptor is closed */
 	err =3D get_btf_id_by_fd(extra_fds[0], &btf_id);
-	if (!ASSERT_GE(err, 0, "get_btf_id_by_fd"))
+	if (!ASSERT_EQ(err, 0, "get_btf_id_by_fd"))
 		goto cleanup;
=20
 	Close(extra_fds[0]);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/tes=
ting/selftests/bpf/prog_tests/log_buf.c
index 169ce689b97c..d6f14a232002 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -7,6 +7,10 @@
 #include "test_log_buf.skel.h"
 #include "bpf_util.h"
=20
+#if !defined(__clang__)
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
+
 static size_t libbpf_log_pos;
 static char libbpf_log_buf[1024 * 1024];
 static bool libbpf_log_error;
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
index 66a900327f91..0ab36503c3b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1195,7 +1195,7 @@ static void test_tailcall_hierarchy_count(const cha=
r *which, bool test_fentry,
 					  bool test_fexit,
 					  bool test_fentry_entry)
 {
-	int err, map_fd, prog_fd, main_data_fd, fentry_data_fd, fexit_data_fd, =
i, val;
+	int err, map_fd, prog_fd, main_data_fd, fentry_data_fd =3D 0, fexit_dat=
a_fd =3D 0, i, val;
 	struct bpf_object *obj =3D NULL, *fentry_obj =3D NULL, *fexit_obj =3D N=
ULL;
 	struct bpf_link *fentry_link =3D NULL, *fexit_link =3D NULL;
 	struct bpf_program *prog, *fentry_prog;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index 9551d8d5f8f9..2c7e9729d5fe 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1103,9 +1103,9 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
=20
-		do_prog_test_run(bpf_program__fd(tprog), &retval,
-				 bpf_program__type(tprog) =3D=3D BPF_PROG_TYPE_SYSCALL ? true : fals=
e);
-		if (retval !=3D subspec->retval && subspec->retval !=3D POINTER_VALUE)=
 {
+		err =3D do_prog_test_run(bpf_program__fd(tprog), &retval,
+				       bpf_program__type(tprog) =3D=3D BPF_PROG_TYPE_SYSCALL ? true =
: false);
+		if (!err && retval !=3D subspec->retval && subspec->retval !=3D POINTE=
R_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d !=3D %d\n", retval, subspec->retval=
);
 			goto tobj_cleanup;
 		}
--=20
2.47.1


