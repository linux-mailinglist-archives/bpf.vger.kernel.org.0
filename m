Return-Path: <bpf+bounces-14260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A987E15EE
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E8DB20E1F
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B72C9E;
	Sun,  5 Nov 2023 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F459210B
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 18:54:17 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7613EE
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 10:54:12 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6B4D3295D45FA; Sun,  5 Nov 2023 10:53:58 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] libbpf: Add tail padding check for LIBBPF_OPTS_RESET macro
Date: Sun,  5 Nov 2023 10:53:58 -0800
Message-Id: <20231105185358.1036619-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Martin reported that there is a libbpf complaining of non-zero-value tail
padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modifie=
d
to have a 4-byte tail padding. This only happens to clang compiler.
The commend line is: ./test_progs -t tc_netkit_multi_links
Martin and I did some investigation and found this indeed the case and
the following are the investigation details.

Clang 18:
  clang version 18.0.0 (https://github.com/llvm/llvm-project.git e00d32af=
b9d33a1eca48e2b041c9688436706c5b)
  <I tried clang15/16/17 and they all have similar results>

tools/lib/bpf/libbpf_common.h:
  #define LIBBPF_OPTS_RESET(NAME, ...)                                   =
   \
        do {                                                             =
   \
                memset(&NAME, 0, sizeof(NAME));                          =
   \
                NAME =3D (typeof(NAME)) {                                =
     \
                        .sz =3D sizeof(NAME),                            =
     \
                        __VA_ARGS__                                      =
   \
                };                                                       =
   \
        } while (0)

  #endif

tools/lib/bpf/libbpf.h:
  struct bpf_netkit_opts {
        /* size of this struct, for forward/backward compatibility */
        size_t sz;
        __u32 flags;
        __u32 relative_fd;
        __u32 relative_id;
        __u64 expected_revision;
        size_t :0;
  };
  #define bpf_netkit_opts__last_field expected_revision
In the above struct bpf_netkit_opts, there is no tail padding.

prog_tests/tc_netkit.c:
  static void serial_test_tc_netkit_multi_links_target(int mode, int targ=
et)
  {
        ...
        LIBBPF_OPTS(bpf_netkit_opts, optl);
        ...
        LIBBPF_OPTS_RESET(optl,
                .flags =3D BPF_F_BEFORE,
                .relative_fd =3D bpf_program__fd(skel->progs.tc1),
        );
        ...
  }

Let us make the following source change, note that we have a 4-byte
tailing padding now.
  diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
  index 6cd9c501624f..0dd83910ae9a 100644
  --- a/tools/lib/bpf/libbpf.h
  +++ b/tools/lib/bpf/libbpf.h
  @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program =
*prog, int ifindex,
   struct bpf_netkit_opts {
        /* size of this struct, for forward/backward compatibility */
        size_t sz;
  -       __u32 flags;
        __u32 relative_fd;
        __u32 relative_id;
        __u64 expected_revision;
  +       __u32 flags;
        size_t :0;
   };
  -#define bpf_netkit_opts__last_field expected_revision
  +#define bpf_netkit_opts__last_field flags

The clang 18 generated asm code looks like below:
    ;       LIBBPF_OPTS_RESET(optl,
    55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
    55e7: 31 f6                         xorl    %esi, %esi
    55e9: ba 20 00 00 00                movl    $0x20, %edx
    55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_ne=
tkit_multi_links_target+0x18d3>
    55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rb=
p)
    55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
    5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
    5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_ne=
tkit_multi_links_target+0x18ee>
    560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
    5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
    561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp=
)
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
    5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
    563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
    563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
    5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
    5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
    5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
    ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifindex,=
 &optl);

At -O0 level, the clang compiler creates an intermediate copy.
We have below to store 'flags' with 4-byte store and leave another 4 byte
in the same 8-byte-aligned storage undefined,
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
and later we store 8-byte to the original zero'ed buffer
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)

This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
may be garbage.

gcc (gcc 11.4) does not have this issue as it does zeroing struct first b=
efore
doing assignments:
  ;       LIBBPF_OPTS_RESET(optl,
    50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
    5104: ba 20 00 00 00                movl    $0x20, %edx
    5109: be 00 00 00 00                movl    $0x0, %esi
    510e: 48 89 c7                      movq    %rax, %rdi
    5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_ne=
tkit_multi_links_target+0x1522>
    5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
    511a: 48 8b 40 18                   movq    0x18(%rax), %rax
    511e: 48 89 c7                      movq    %rax, %rdi
    5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_ne=
tkit_multi_links_target+0x1532>
    5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp=
)
    5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp=
)
    513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp=
)
    5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp=
)
    5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rb=
p)
    515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
    5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
  ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifindex, &=
optl);

It is not clear how to resolve the compiler code generation as the compil=
er
generates correct code w.r.t. how to handle unnamed padding in C standard=
.
So this patch changed LIBBPF_OPTS_RESET macro by adding a static_assert
to complain if there is a non-zero-byte tailing padding. This will effect=
ively
enforce all *_opts struct used by LIBBPF_OPTS_RESET must have zero-byte t=
ailing
padding.

With the above changed bpf_netkit_opts layout, building the selftest with
clang compiler, the following error will occur:

  .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: =
error:
    static assertion failed due to requirement 'sizeof (optl) =3D=3D (__b=
uiltin_offsetof(struct bpf_netkit_opts, flags)
      + sizeof ((((struct bpf_netkit_opts *)0)->flags)))': Unexpected tai=
l padding
  331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  332 |                 .flags =3D BPF_F_BEFORE,
      |                 ~~~~~~~~~~~~~~~~~~~~~~
  333 |                 .relative_fd =3D bpf_program__fd(skel->progs.tc1)=
,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  334 |         );
      |         ~
  .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_commo=
n.h:98:4: note: expanded from macro 'LIBBPF_OPTS_RESET'
   98 |                         sizeof(NAME) =3D=3D offsetofend(struct TY=
PE,            \
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
   99 |                                                     TYPE##__last_=
field),    \
      |                                                     ~~~~~~~~~~~~~=
~~~~~~
  .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: =
note: expression evaluates to '32 =3D=3D 28'
  331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  332 |                 .flags =3D BPF_F_BEFORE,
      |                 ~~~~~~~~~~~~~~~~~~~~~~
  333 |                 .relative_fd =3D bpf_program__fd(skel->progs.tc1)=
,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  334 |         );
      |         ~
  .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_commo=
n.h:98:17: note: expanded from macro 'LIBBPF_OPTS_RESET'
   98 |                         sizeof(NAME) =3D=3D offsetofend(struct TY=
PE,            \
      |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
   99 |                                                     TYPE##__last_=
field),    \

Note that this patch does not provide a C++ version of changed LIBBPF_OPT=
S_RESET macro.
It looks C++ complaining about offsetof()
  #define offsetof(type, member)    ((unsigned long)&((type *)0)->member)
to be used in static_assert.

Cc: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf_common.h                 |   7 +-
 .../selftests/bpf/prog_tests/tc_links.c       |  70 ++++-----
 .../selftests/bpf/prog_tests/tc_netkit.c      |   4 +-
 .../selftests/bpf/prog_tests/tc_opts.c        | 144 +++++++++---------
 4 files changed, 115 insertions(+), 110 deletions(-)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
index b7060f254486..f74e5f3cde9c 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -77,8 +77,13 @@
  * syntax as varargs can be provided as well to reinitialize options str=
uct
  * specific members.
  */
-#define LIBBPF_OPTS_RESET(NAME, ...)					    \
+#define LIBBPF_OPTS_RESET(TYPE, NAME, ...)				    \
 	do {								    \
+		_Static_assert(						    \
+			sizeof(NAME) =3D=3D offsetofend(struct TYPE,	    \
+						    TYPE##__last_field),    \
+			"Unexpected tail padding"			    \
+		);							    \
 		memset(&NAME, 0, sizeof(NAME));				    \
 		NAME =3D (typeof(NAME)) {					    \
 			.sz =3D sizeof(NAME),				    \
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/te=
sting/selftests/bpf/prog_tests/tc_links.c
index bc9841144685..69d24e5139ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -197,7 +197,7 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
@@ -210,7 +210,7 @@ static void test_tc_links_before_target(int target)
=20
 	lid3 =3D id_from_link_fd(bpf_link__fd(skel->links.tc3));
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_LINK,
 		.relative_id =3D lid1,
 	);
@@ -351,7 +351,7 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -364,7 +364,7 @@ static void test_tc_links_after_target(int target)
=20
 	lid3 =3D id_from_link_fd(bpf_link__fd(skel->links.tc3));
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER | BPF_F_LINK,
 		.relative_fd =3D bpf_link__fd(skel->links.tc2),
 	);
@@ -670,7 +670,7 @@ static void test_tc_links_replace_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 		.relative_id =3D pid1,
 		.expected_revision =3D 2,
@@ -713,7 +713,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_REPLACE,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc2),
 		.expected_revision =3D 3,
@@ -727,7 +727,7 @@ static void test_tc_links_replace_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_REPLACE | BPF_F_LINK,
 		.relative_fd =3D bpf_link__fd(skel->links.tc2),
 		.expected_revision =3D 3,
@@ -741,7 +741,7 @@ static void test_tc_links_replace_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_REPLACE | BPF_F_LINK | BPF_F_AFTER,
 		.relative_id =3D lid2,
 	);
@@ -889,7 +889,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_ID,
 	);
=20
@@ -901,7 +901,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER | BPF_F_ID,
 	);
=20
@@ -913,7 +913,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_ID,
 	);
=20
@@ -925,7 +925,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_LINK,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
@@ -938,7 +938,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_LINK,
 	);
=20
@@ -950,7 +950,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
=20
@@ -962,7 +962,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_AFTER,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
@@ -975,7 +975,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -988,7 +988,7 @@ static void test_tc_links_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_ID,
 		.relative_id =3D pid2,
 	);
@@ -1001,7 +1001,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_ID,
 		.relative_id =3D 42,
 	);
@@ -1014,7 +1014,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1027,7 +1027,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_LINK,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1040,7 +1040,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1053,7 +1053,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl);
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl);
=20
 	link =3D bpf_program__attach_tcx(skel->progs.tc1, 0, &optl);
 	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
@@ -1063,7 +1063,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER | BPF_F_LINK,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1076,7 +1076,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optl);
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl);
=20
 	link =3D bpf_program__attach_tcx(skel->progs.tc1, loopback, &optl);
 	if (!ASSERT_OK_PTR(link, "link_attach"))
@@ -1088,7 +1088,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER | BPF_F_LINK,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1101,7 +1101,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID,
 		.relative_id =3D ~0,
 	);
@@ -1114,7 +1114,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID,
 		.relative_id =3D lid1,
 	);
@@ -1127,7 +1127,7 @@ static void test_tc_links_invalid_target(int target=
)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_ID,
 		.relative_id =3D pid1,
 	);
@@ -1139,7 +1139,7 @@ static void test_tc_links_invalid_target(int target=
)
 	}
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE | BPF_F_LINK | BPF_F_ID,
 		.relative_id =3D lid1,
 	);
@@ -1211,7 +1211,7 @@ static void test_tc_links_prepend_target(int target=
)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1253,7 +1253,7 @@ static void test_tc_links_prepend_target(int target=
)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1265,7 +1265,7 @@ static void test_tc_links_prepend_target(int target=
)
=20
 	lid3 =3D id_from_link_fd(bpf_link__fd(skel->links.tc3));
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1367,7 +1367,7 @@ static void test_tc_links_append_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1409,7 +1409,7 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1421,7 +1421,7 @@ static void test_tc_links_append_target(int target)
=20
 	lid3 =3D id_from_link_fd(bpf_link__fd(skel->links.tc3));
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_tcx_opts, optl,
 		.flags =3D BPF_F_AFTER,
 	);
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/t=
esting/selftests/bpf/prog_tests/tc_netkit.c
index 15ee7b2fc410..cc69c697b0c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -328,7 +328,7 @@ static void serial_test_tc_netkit_multi_links_target(=
int mode, int target)
 	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
=20
-	LIBBPF_OPTS_RESET(optl,
+	LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -442,7 +442,7 @@ static void serial_test_tc_netkit_multi_opts_target(i=
nt mode, int target)
 	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd1,
 	);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/tes=
ting/selftests/bpf/prog_tests/tc_opts.c
index 196abf223465..5772088a790c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -173,7 +173,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd2,
 	);
@@ -196,7 +196,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
 	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_id =3D id1,
 	);
@@ -325,7 +325,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -348,7 +348,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], id2, "prog_ids[2]");
 	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 		.relative_id =3D id2,
 	);
@@ -475,7 +475,7 @@ static void test_tc_opts_revision_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 1,
 	);
=20
@@ -485,7 +485,7 @@ static void test_tc_opts_revision_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 1,
 	);
=20
@@ -495,7 +495,7 @@ static void test_tc_opts_revision_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 2,
 	);
=20
@@ -526,7 +526,7 @@ static void test_tc_opts_revision_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.expected_revision =3D 2,
 	);
=20
@@ -535,7 +535,7 @@ static void test_tc_opts_revision_target(int target)
 	assert_mprog_count(target, 2);
=20
 cleanup_target2:
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.expected_revision =3D 3,
 	);
=20
@@ -544,7 +544,7 @@ static void test_tc_opts_revision_target(int target)
 	assert_mprog_count(target, 1);
=20
 cleanup_target:
-	LIBBPF_OPTS_RESET(optd);
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd);
=20
 	err =3D bpf_prog_detach_opts(fd1, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
@@ -690,7 +690,7 @@ static void test_tc_opts_replace_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 1,
 	);
=20
@@ -700,7 +700,7 @@ static void test_tc_opts_replace_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_id =3D id1,
 		.expected_revision =3D 2,
@@ -742,7 +742,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D fd2,
 		.expected_revision =3D 3,
@@ -776,7 +776,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, true, "seen_tc3");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE | BPF_F_BEFORE,
 		.replace_prog_fd =3D fd3,
 		.relative_fd =3D fd1,
@@ -811,7 +811,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D fd2,
 	);
@@ -820,7 +820,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(err, -EEXIST, "prog_attach");
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE | BPF_F_AFTER,
 		.replace_prog_fd =3D fd2,
 		.relative_fd =3D fd1,
@@ -831,7 +831,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(err, -ERANGE, "prog_attach");
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE | BPF_F_AFTER | BPF_F_REPLACE,
 		.replace_prog_fd =3D fd2,
 		.relative_fd =3D fd1,
@@ -842,7 +842,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(err, -ERANGE, "prog_attach");
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_id =3D id1,
 		.expected_revision =3D 5,
@@ -854,7 +854,7 @@ static void test_tc_opts_replace_target(int target)
 	assert_mprog_count(target, 1);
=20
 cleanup_target:
-	LIBBPF_OPTS_RESET(optd);
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd);
=20
 	err =3D bpf_prog_detach_opts(fd1, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
@@ -892,7 +892,7 @@ static void test_tc_opts_invalid_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE | BPF_F_AFTER,
 	);
=20
@@ -900,7 +900,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ERANGE, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE | BPF_F_ID,
 	);
=20
@@ -908,7 +908,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ENOENT, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER | BPF_F_ID,
 	);
=20
@@ -916,7 +916,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ENOENT, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.relative_fd =3D fd2,
 	);
=20
@@ -924,7 +924,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -EINVAL, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE | BPF_F_AFTER,
 		.relative_fd =3D fd2,
 	);
@@ -933,7 +933,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ENOENT, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_ID,
 		.relative_id =3D id2,
 	);
@@ -942,7 +942,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -EINVAL, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd1,
 	);
@@ -951,7 +951,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ENOENT, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -960,7 +960,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -ENOENT, "prog_attach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta);
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta);
=20
 	err =3D bpf_prog_attach_opts(fd1, loopback, target, &opta);
 	if (!ASSERT_EQ(err, 0, "prog_attach"))
@@ -968,13 +968,13 @@ static void test_tc_opts_invalid_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta);
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta);
=20
 	err =3D bpf_prog_attach_opts(fd1, loopback, target, &opta);
 	ASSERT_EQ(err, -EEXIST, "prog_attach");
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd1,
 	);
@@ -983,7 +983,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -EEXIST, "prog_attach");
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -992,7 +992,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -EEXIST, "prog_attach");
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.relative_fd =3D fd1,
 	);
@@ -1001,7 +1001,7 @@ static void test_tc_opts_invalid_target(int target)
 	ASSERT_EQ(err, -EINVAL, "prog_attach_x1");
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D fd1,
 	);
@@ -1059,7 +1059,7 @@ static void test_tc_opts_prepend_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1092,7 +1092,7 @@ static void test_tc_opts_prepend_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1100,7 +1100,7 @@ static void test_tc_opts_prepend_target(int target)
 	if (!ASSERT_EQ(err, 0, "prog_attach"))
 		goto cleanup_target2;
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1199,7 +1199,7 @@ static void test_tc_opts_append_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1232,7 +1232,7 @@ static void test_tc_opts_append_target(int target)
 	ASSERT_EQ(skel->bss->seen_tc3, false, "seen_tc3");
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1240,7 +1240,7 @@ static void test_tc_opts_append_target(int target)
 	if (!ASSERT_EQ(err, 0, "prog_attach"))
 		goto cleanup_target2;
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1452,7 +1452,7 @@ static void test_tc_opts_mixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1463,7 +1463,7 @@ static void test_tc_opts_mixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
@@ -1474,7 +1474,7 @@ static void test_tc_opts_mixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D bpf_program__fd(skel->progs.tc2),
 	);
@@ -1485,7 +1485,7 @@ static void test_tc_opts_mixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D bpf_program__fd(skel->progs.tc1),
 	);
@@ -1508,7 +1508,7 @@ static void test_tc_opts_mixed_target(int target)
=20
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D bpf_program__fd(skel->progs.tc4),
 	);
@@ -1612,7 +1612,7 @@ static void test_tc_opts_demixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1621,7 +1621,7 @@ static void test_tc_opts_demixed_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1719,7 +1719,7 @@ static void test_tc_opts_detach_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -1742,7 +1742,7 @@ static void test_tc_opts_detach_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
 	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1764,7 +1764,7 @@ static void test_tc_opts_detach_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id3, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
=20
-	LIBBPF_OPTS_RESET(optd);
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd);
=20
 	err =3D bpf_prog_detach_opts(fd3, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
@@ -1774,14 +1774,14 @@ static void test_tc_opts_detach_target(int target=
)
 	ASSERT_OK(err, "prog_detach");
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
 	err =3D bpf_prog_detach_opts(0, loopback, target, &optd);
 	ASSERT_EQ(err, -ENOENT, "prog_detach");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -1890,7 +1890,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd2,
 	);
@@ -1914,7 +1914,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
 	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd2,
 	);
@@ -1923,7 +1923,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(err, -ENOENT, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd4,
 	);
@@ -1932,7 +1932,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(err, -ERANGE, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd1,
 	);
@@ -1941,7 +1941,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(err, -ENOENT, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd3,
 	);
@@ -1964,7 +1964,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(optq.prog_ids[1], id4, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 		.relative_fd =3D fd4,
 	);
@@ -1986,7 +1986,7 @@ static void test_tc_opts_detach_before_target(int t=
arget)
 	ASSERT_EQ(optq.prog_ids[0], id4, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_BEFORE,
 	);
=20
@@ -2097,7 +2097,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -2121,7 +2121,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(optq.prog_ids[2], id4, "prog_ids[2]");
 	ASSERT_EQ(optq.prog_ids[3], 0, "prog_ids[3]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -2130,7 +2130,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(err, -ENOENT, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd4,
 	);
@@ -2139,7 +2139,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(err, -ERANGE, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd3,
 	);
@@ -2148,7 +2148,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(err, -ERANGE, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -2157,7 +2157,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(err, -ERANGE, "prog_detach");
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -2180,7 +2180,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(optq.prog_ids[1], id4, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 		.relative_fd =3D fd1,
 	);
@@ -2202,7 +2202,7 @@ static void test_tc_opts_detach_after_target(int ta=
rget)
 	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
=20
-	LIBBPF_OPTS_RESET(optd,
+	LIBBPF_OPTS_RESET(bpf_prog_detach_opts, optd,
 		.flags =3D BPF_F_AFTER,
 	);
=20
@@ -2327,7 +2327,7 @@ static void test_tc_chain_mixed(int target)
 	ASSERT_EQ(skel->bss->seen_tc5, false, "seen_tc5");
 	ASSERT_EQ(skel->bss->seen_tc6, true, "seen_tc6");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.flags =3D BPF_F_REPLACE,
 		.replace_prog_fd =3D fd3,
 	);
@@ -2486,7 +2486,7 @@ static void test_tc_opts_query_target(int target)
=20
 	assert_mprog_count(target, 0);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 1,
 	);
=20
@@ -2496,7 +2496,7 @@ static void test_tc_opts_query_target(int target)
=20
 	assert_mprog_count(target, 1);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 2,
 	);
=20
@@ -2506,7 +2506,7 @@ static void test_tc_opts_query_target(int target)
=20
 	assert_mprog_count(target, 2);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 3,
 	);
=20
@@ -2516,7 +2516,7 @@ static void test_tc_opts_query_target(int target)
=20
 	assert_mprog_count(target, 3);
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D 4,
 	);
=20
@@ -2778,7 +2778,7 @@ static void test_tc_opts_query_attach_target(int ta=
rget)
 	ASSERT_EQ(optq.count, 0, "count");
 	ASSERT_EQ(optq.revision, 1, "revision");
=20
-	LIBBPF_OPTS_RESET(opta,
+	LIBBPF_OPTS_RESET(bpf_prog_attach_opts, opta,
 		.expected_revision =3D optq.revision,
 	);
=20
--=20
2.34.1


