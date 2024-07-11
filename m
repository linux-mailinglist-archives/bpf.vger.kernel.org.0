Return-Path: <bpf+bounces-34584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84E92ECF7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A61F23DA7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189D16D4CA;
	Thu, 11 Jul 2024 16:42:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170D16D326
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716145; cv=none; b=dNon3R/450ZSHjvTccU8ySK+gn3GwuP8bpMWYkGV5r6RSEpfpbTQca8Q3ioZyVovE4HRdHVHQGlTB6xaDWSh0z5nIKC9pHWSAomD+1kSBesPS68GRnWViY9L1mzPVKF4mhuJyhz9JBifq2hMlYTPjZsfm8gBdZWwpcD2nflpR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716145; c=relaxed/simple;
	bh=WevulfSre09TfdW6tXa3ZUb0p+KM3YULMaC5cuna8eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9se0dry7Qk+gHKbDNcK2fkFJq6NZJEhU85I9nNGUQFpH8LrjmfNFjPQVDiw+20IXZQqa6WoDWdwbZKjOpewpJS+xhXNygUhgX7AjEv8fTX5GtqNjTv1pOG9ASCLR+XtNvx0tt3HVDGgzCDoRLR2OXHke7WszHN23gRNGDpzx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7FE25678B93C; Thu, 11 Jul 2024 09:42:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark runtime performance with private stack
Date: Thu, 11 Jul 2024 09:42:09 -0700
Message-ID: <20240711164209.1658101-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711164204.1657880-1-yonghong.song@linux.dev>
References: <20240711164204.1657880-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This patch intends to show some benchmark results comparing a bpf
program with vs. without private stack. The patch is not intended
to land since it hacks existing kernel interface in order to
do proper comparison.

The jited code without private stack:

0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 48 81 ec 60 00 00 00    sub    rsp,0x60
1a: 48 bf 00 20 1a 00 00    movabs rdi,0xffffc900001a2000
21: c9 ff ff
24: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
28: 48 83 c6 01             add    rsi,0x1
2c: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
30: 31 ff                   xor    edi,edi
32: 48 89 7d f8             mov    QWORD PTR [rbp-0x8],rdi
36: be 05 00 00 00          mov    esi,0x5
3b: 89 75 f8                mov    DWORD PTR [rbp-0x8],esi
3e: 48 89 7d f0             mov    QWORD PTR [rbp-0x10],rdi
42: 48 89 7d e8             mov    QWORD PTR [rbp-0x18],rdi
46: 48 89 7d e0             mov    QWORD PTR [rbp-0x20],rdi
4a: 48 89 7d d8             mov    QWORD PTR [rbp-0x28],rdi
4e: 48 89 7d d0             mov    QWORD PTR [rbp-0x30],rdi
52: 48 89 7d c0             mov    QWORD PTR [rbp-0x40],rdi
56: 48 89 7d c8             mov    QWORD PTR [rbp-0x38],rdi
5a: 48 89 7d b8             mov    QWORD PTR [rbp-0x48],rdi
5e: 48 89 7d b0             mov    QWORD PTR [rbp-0x50],rdi
62: 48 89 7d a8             mov    QWORD PTR [rbp-0x58],rdi
66: 48 89 7d a0             mov    QWORD PTR [rbp-0x60],rdi
6a: bf 0a 00 00 00          mov    edi,0xa
6f: 89 7d c0                mov    DWORD PTR [rbp-0x40],edi
72: 48 89 ee                mov    rsi,rbp
75: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
79: 48 bf 00 f8 4b 0a 81    movabs rdi,0xffff88810a4bf800
80: 88 ff ff
83: e8 e0 1d 5f e1          call   0xffffffffe15f1e68
88: 48 85 c0                test   rax,rax
8b: 74 04                   je     0x91
8d: 48 83 c0 60             add    rax,0x60
91: 48 85 c0                test   rax,rax
94: 75 1f                   jne    0xb5
96: 48 89 ee                mov    rsi,rbp
99: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
9d: 48 89 ea                mov    rdx,rbp
a0: 48 83 c2 a0             add    rdx,0xffffffffffffffa0
a4: 48 bf 00 f8 4b 0a 81    movabs rdi,0xffff88810a4bf800
ab: 88 ff ff
ae: 31 c9                   xor    ecx,ecx
b0: e8 73 d7 5e e1          call   0xffffffffe15ed828
b5: 48 89 ee                mov    rsi,rbp
b8: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
bc: 48 bf 00 f8 4b 0a 81    movabs rdi,0xffff88810a4bf800
c3: 88 ff ff
c6: e8 0d e0 5e e1          call   0xffffffffe15ee0d8
cb: 31 c0                   xor    eax,eax
cd: c9                      leave
ce: c3                      ret

The jited code with private stack:

0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 49 b9 40 af c1 08 7e    movabs r9,0x607e08c1af40
1a: 60 00 00
1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
24: 02 00
26: 48 bf 00 60 68 00 00    movabs rdi,0xffffc90000686000
2d: c9 ff ff
30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
34: 48 83 c6 01             add    rsi,0x1
38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
3c: 31 ff                   xor    edi,edi
3e: 49 89 79 f8             mov    QWORD PTR [r9-0x8],rdi
42: be 05 00 00 00          mov    esi,0x5
47: 41 89 71 f8             mov    DWORD PTR [r9-0x8],esi
4b: 49 89 79 f0             mov    QWORD PTR [r9-0x10],rdi
4f: 49 89 79 e8             mov    QWORD PTR [r9-0x18],rdi
53: 49 89 79 e0             mov    QWORD PTR [r9-0x20],rdi
57: 49 89 79 d8             mov    QWORD PTR [r9-0x28],rdi
5b: 49 89 79 d0             mov    QWORD PTR [r9-0x30],rdi
5f: 49 89 79 c0             mov    QWORD PTR [r9-0x40],rdi
63: 49 89 79 c8             mov    QWORD PTR [r9-0x38],rdi
67: 49 89 79 b8             mov    QWORD PTR [r9-0x48],rdi
6b: 49 89 79 b0             mov    QWORD PTR [r9-0x50],rdi
6f: 49 89 79 a8             mov    QWORD PTR [r9-0x58],rdi
73: 49 89 79 a0             mov    QWORD PTR [r9-0x60],rdi
77: bf 0a 00 00 00          mov    edi,0xa
7c: 41 89 79 c0             mov    DWORD PTR [r9-0x40],edi
80: 4c 89 ce                mov    rsi,r9
83: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
87: 48 bf 00 e0 22 0c 81    movabs rdi,0xffff88810c22e000
8e: 88 ff ff
91: 41 51                   push   r9
93: e8 10 1d 5f e1          call   0xffffffffe15f1da8
98: 41 59                   pop    r9
9a: 48 85 c0                test   rax,rax
9d: 74 04                   je     0xa3
9f: 48 83 c0 60             add    rax,0x60
a3: 48 85 c0                test   rax,rax
a6: 75 23                   jne    0xcb
a8: 4c 89 ce                mov    rsi,r9
ab: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
af: 4c 89 ca                mov    rdx,r9
b2: 48 83 c2 a0             add    rdx,0xffffffffffffffa0
b6: 48 bf 00 e0 22 0c 81    movabs rdi,0xffff88810c22e000
bd: 88 ff ff
c0: 31 c9                   xor    ecx,ecx
c2: 41 51                   push   r9
c4: e8 9f d6 5e e1          call   0xffffffffe15ed768
c9: 41 59                   pop    r9
cb: 4c 89 ce                mov    rsi,r9
ce: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
d2: 48 bf 00 e0 22 0c 81    movabs rdi,0xffff88810c22e000
d9: 88 ff ff
dc: 41 51                   push   r9
de: e8 35 df 5e e1          call   0xffffffffe15ee018
e3: 41 59                   pop    r9
e5: 31 c0                   xor    eax,eax
e7: c9                      leave
e8: c3                      ret

It is clear that the main overhead is the push/pop r9 for
three calls.

Five runs of the benchmarks:

[root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
no-private-stack:    0.662 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/s)
private-stack:       0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s)
[root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
no-private-stack:    0.684 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
private-stack:       0.676 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s)
[root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
no-private-stack:    0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s)
private-stack:       0.683 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
[root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
no-private-stack:    0.680 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s)
private-stack:       0.626 =C2=B1 0.050M/s (drops 0.000 =C2=B1 0.000M/s)
[root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
no-private-stack:    0.686 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
private-stack:       0.683 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)

The performance is very similar between private-stack and no-private-stac=
k.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h                           |   3 +-
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/syscall.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../bpf/benchs/bench_private_stack.c          | 142 ++++++++++++++++++
 .../bpf/benchs/run_bench_private_stack.sh     |   9 ++
 .../selftests/bpf/progs/private_stack.c       |  40 +++++
 10 files changed, 211 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_private_stac=
k.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_private_=
stack.sh
 create mode 100644 tools/testing/selftests/bpf/progs/private_stack.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19a3f5355363..2f8708465c19 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1551,7 +1551,8 @@ struct bpf_prog {
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid()=
 */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				disable_private_stack:1; /* Disable private stack */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..98af8ea8a4d6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1409,6 +1409,9 @@ enum {
=20
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	=3D (1U << 18),
+
+/* Disable private stack */
+	BPF_F_DISABLE_PRIVATE_STACK	=3D (1U << 19),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f69eb0c5fe03..297e76a8f463 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2815,7 +2815,7 @@ EXPORT_SYMBOL_GPL(bpf_prog_free);
=20
 bool bpf_enable_private_stack(struct bpf_prog *prog)
 {
-	if (prog->aux->stack_depth <=3D 64)
+	if (prog->disable_private_stack || prog->aux->stack_depth <=3D 64)
 		return false;
=20
 	switch (prog->aux->prog->type) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 89162ddb4747..bb2b632c9c2c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2715,7 +2715,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
 				 BPF_F_TEST_REG_INVARIANTS |
-				 BPF_F_TOKEN_FD))
+				 BPF_F_TOKEN_FD |
+				 BPF_F_DISABLE_PRIVATE_STACK))
 		return -EINVAL;
=20
 	bpf_prog_load_fixup_attach_type(attr);
@@ -2828,6 +2829,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
=20
 	prog->expected_attach_type =3D attr->expected_attach_type;
 	prog->sleepable =3D !!(attr->prog_flags & BPF_F_SLEEPABLE);
+	prog->disable_private_stack =3D !!(attr->prog_flags & BPF_F_DISABLE_PRI=
VATE_STACK);
 	prog->aux->attach_btf =3D attach_btf;
 	prog->aux->attach_btf_id =3D attr->attach_btf_id;
 	prog->aux->dst_prog =3D dst_prog;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 35bcf52dbc65..98af8ea8a4d6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1409,6 +1409,9 @@ enum {
=20
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	=3D (1U << 18),
+
+/* Disable private stack */
+	BPF_F_DISABLE_PRIVATE_STACK	=3D (1U << 19),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index dd49c1d23a60..44a6a43da71c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -733,6 +733,7 @@ $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/ben=
ch_local_storage_create.ske
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.=
h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
+$(OUTPUT)/bench_private_stack.o: $(OUTPUT)/private_stack.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -753,6 +754,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
+		 $(OUTPUT)/bench_private_stack.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index 627b74ae041b..4f4867cd80f9 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -282,6 +282,7 @@ extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
+extern struct argp bench_private_stack_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -296,6 +297,7 @@ static const struct argp_child bench_parsers[] =3D {
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
+	{ &bench_private_stack_argp, 0, "bpf private stack benchmark", 0 },
 	{},
 };
=20
@@ -542,6 +544,8 @@ extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
+extern const struct bench bench_no_private_stack;
+extern const struct bench bench_private_stack;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -596,6 +600,8 @@ static const struct bench *benchs[] =3D {
 	&bench_htab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
+	&bench_no_private_stack,
+	&bench_private_stack,
 };
=20
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_private_stack.c b/t=
ools/testing/selftests/bpf/benchs/bench_private_stack.c
new file mode 100644
index 000000000000..3d8aa695823e
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_private_stack.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include "bench.h"
+#include "private_stack.skel.h"
+
+static struct ctx {
+	struct private_stack *skel;
+} ctx;
+
+static struct {
+	bool disable_private_stack;
+} args =3D {
+	.disable_private_stack =3D 0,
+};
+
+enum {
+	ARG_DISABLE_PRIVATE_STACK =3D 3000,
+};
+
+static const struct argp_option opts[] =3D {
+        { "disable-private-stack", ARG_DISABLE_PRIVATE_STACK, "DISABLE_P=
RIVATE_STACK",
+		0, "Disable private stack" },
+        {},
+};
+
+static error_t private_stack_parse_arg(int key, char *arg, struct argp_s=
tate *state)
+{
+	long ret;
+
+        switch (key) {
+        case ARG_DISABLE_PRIVATE_STACK:
+                ret =3D strtoul(arg, NULL, 10);
+		if (ret !=3D 1)
+			argp_usage(state);
+		args.disable_private_stack =3D 1;
+                break;
+        default:
+                return ARGP_ERR_UNKNOWN;
+        }
+
+        return 0;
+}
+
+const struct argp bench_private_stack_argp =3D {
+        .options =3D opts,
+        .parser =3D private_stack_parse_arg,
+};
+
+static void private_stack_validate(void)
+{
+	if (env.consumer_cnt !=3D 0) {
+		fprintf(stderr,
+			"The private stack benchmarks do not support consumer\n");
+		exit(1);
+	}
+}
+
+static void common_setup(bool disable_private_stack)
+{
+	struct private_stack *skel;
+	struct bpf_link *link;
+	__u32 old_flags;
+	int err;
+
+	skel =3D private_stack__open();
+	if(!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+	ctx.skel =3D skel;
+
+	if (disable_private_stack) {
+		old_flags =3D bpf_program__flags(skel->progs.stack0);
+		bpf_program__set_flags(skel->progs.stack0, old_flags | BPF_F_DISABLE_P=
RIVATE_STACK);
+	}
+
+	err =3D private_stack__load(skel);
+	if (err) {
+		fprintf(stderr, "failed to load program\n");
+		exit(1);
+	}
+
+	link =3D bpf_program__attach(skel->progs.stack0);
+	if (!link) {
+		fprintf(stderr, "failed to attach program\n");
+		exit(1);
+	}
+}
+
+static void no_private_stack_setup(void)
+{
+	common_setup(true);
+}
+
+static void private_stack_setup(void)
+{
+	common_setup(false);
+}
+
+static void private_stack_measure(struct bench_res *res)
+{
+	struct private_stack *skel =3D ctx.skel;
+	unsigned long total_hits =3D 0;
+	static unsigned long last_hits;
+
+	total_hits =3D skel->bss->hits;
+	res->hits =3D total_hits - last_hits;
+	res->drops =3D 0;
+	res->false_hits =3D 0;
+	last_hits =3D total_hits;
+}
+
+static void *private_stack_producer(void *unused)
+{
+	while (true)
+		syscall(__NR_getpgid);
+	return NULL;
+}
+
+const struct bench bench_no_private_stack =3D {
+	.name =3D "no-private-stack",
+	.argp =3D &bench_private_stack_argp,
+	.validate =3D private_stack_validate,
+	.setup =3D no_private_stack_setup,
+	.producer_thread =3D private_stack_producer,
+	.measure =3D private_stack_measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_private_stack =3D {
+	.name =3D "private-stack",
+	.argp =3D &bench_private_stack_argp,
+	.validate =3D private_stack_validate,
+	.setup =3D private_stack_setup,
+	.producer_thread =3D private_stack_producer,
+	.measure =3D private_stack_measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_private_stack.s=
h b/tools/testing/selftests/bpf/benchs/run_bench_private_stack.sh
new file mode 100755
index 000000000000..e032353f7fa6
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_private_stack.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+summarize "no-private-stack: " "$($RUN_BENCH --disable-private-stack 1 n=
o-private-stack)"
+summarize "private-stack: " "$($RUN_BENCH private-stack)"
diff --git a/tools/testing/selftests/bpf/progs/private_stack.c b/tools/te=
sting/selftests/bpf/progs/private_stack.c
new file mode 100644
index 000000000000..3b062e5b27e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/private_stack.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct data_t {
+        unsigned int d[12];
+};
+
+struct {
+        __uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__type(key, struct data_t);
+	__type(value, struct data_t);
+} htab SEC(".maps");
+
+unsigned long hits =3D 0;
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int stack0(void *ctx)
+{
+	struct data_t key =3D {}, value =3D {};
+	struct data_t *pvalue;
+
+	hits++;
+	key.d[10] =3D 5;
+	value.d[8] =3D 10;
+
+	pvalue =3D bpf_map_lookup_elem(&htab, &key);
+	if (!pvalue)
+		bpf_map_update_elem(&htab, &key, &value, 0);
+	bpf_map_delete_elem(&htab, &key);
+
+	return 0;
+}
+
--=20
2.43.0


