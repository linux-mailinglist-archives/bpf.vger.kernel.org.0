Return-Path: <bpf+bounces-15885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3247F9882
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 06:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2809280CBB
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77076539D;
	Mon, 27 Nov 2023 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A912F
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 21:04:03 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 534912A8B644D; Sun, 26 Nov 2023 21:03:42 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Fix a few selftest failures due to llvm18 change
Date: Sun, 26 Nov 2023 21:03:42 -0800
Message-Id: <20231127050342.1945270-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest upstream llvm18, the following test cases failed:
  $ ./test_progs -j
  #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
  #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
  #13      bpf_cookie:FAIL
  #77      fentry_fexit:FAIL
  #78/1    fentry_test/fentry:FAIL
  #78      fentry_test:FAIL
  #82/1    fexit_test/fexit:FAIL
  #82      fexit_test:FAIL
  #112/1   kprobe_multi_test/skel_api:FAIL
  #112/2   kprobe_multi_test/link_api_addrs:FAIL
  ...
  #112     kprobe_multi_test:FAIL
  #356/17  test_global_funcs/global_func17:FAIL
  #356     test_global_funcs:FAIL

Further analysis shows llvm upstream patch [1] is responsible
for the above failures. For example, for function bpf_fentry_test7()
in net/bpf/test_run.c, without [1], the asm code is:
  0000000000000400 <bpf_fentry_test7>:
     400: f3 0f 1e fa                   endbr64
     404: e8 00 00 00 00                callq   0x409 <bpf_fentry_test7+0=
x9>
     409: 48 89 f8                      movq    %rdi, %rax
     40c: c3                            retq
     40d: 0f 1f 00                      nopl    (%rax)
and with [1], the asm code is:
  0000000000005d20 <bpf_fentry_test7.specialized.1>:
    5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_test7.=
specialized.1+0x5>
    5d25: c3                            retq
and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_tes=
t7>
and this caused test failures for #13/#77 etc. except #356.

For test case #356/17, with [1] (progs/test_global_func17.c)),
the main prog looks like:
  0000000000000000 <global_func17>:
       0:       b4 00 00 00 2a 00 00 00 w0 =3D 0x2a
       1:       95 00 00 00 00 00 00 00 exit
which passed verification while the test itself expects a verification
failure.

Let us add 'barrier_var' style asm code in both places to prevent
function specialization which caused selftests failure.

  [1] https://github.com/llvm/llvm-project/pull/72903

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/bpf/test_run.c                                     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9fdcc5cdce1..711cf5d59816 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -542,7 +542,7 @@ struct bpf_fentry_test_t {
=20
 int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
 {
-	asm volatile ("");
+	asm volatile ("": "+r"(arg));
 	return (long)arg;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/too=
ls/testing/selftests/bpf/progs/test_global_func17.c
index a32e11c7d933..5de44b09e8ec 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -5,6 +5,7 @@
=20
 __noinline int foo(int *p)
 {
+	barrier_var(p);
 	return p ? (*p =3D 42) : 0;
 }
=20
--=20
2.34.1


