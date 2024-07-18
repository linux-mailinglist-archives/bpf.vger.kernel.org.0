Return-Path: <bpf+bounces-35021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C3935286
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F11B21594
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F81442E8;
	Thu, 18 Jul 2024 20:52:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26978C9E
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335938; cv=none; b=BlL1AfGuGxBxU16sas/u4iq6I0d6sHUQXgcrbP3973ci1Fy115XAOhW5iNRNxU3G549HLOfZMS4a04KhAQUsGfdzyPrwXJPFb1ERfdoM26gqL1uQwksxz7lXL3aH6x8VKAP4R8s2h37jM/T1AIt+qwNEeFhpYh1g73r/0UgZ0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335938; c=relaxed/simple;
	bh=6/SUzLXegkmyP/RMTC5T1I9nRN9VGYap1e1z857DSZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7sIFPnRINAYiP6+PDzzm8haGnjGit5+UGy111SRsyo2ZDHig+27eGgJdgNx9067LpqTC6iawm8lSMxuD/WICuxC1s32qLZ8p8CyxYCONz2c9RC6UIN3doOfmfW/FhvuiRbfaanc9Ig6Z/NiHt8nNRNIM4Z8W387G0/KAeaiBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DAF236BC7629; Thu, 18 Jul 2024 13:52:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark runtime performance with private stack
Date: Thu, 18 Jul 2024 13:52:03 -0700
Message-ID: <20240718205203.3652080-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718205158.3651529-1-yonghong.song@linux.dev>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
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
do proper comparison. The bpf program is similar to
7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel BPF triggerin=
g benchmarks")
where a raw_tp program is triggered with bpf_prog_test_run_opts() and
the raw_tp program has a loop of helper bpf_get_numa_node_id() which
will enable a fentry prog to run. The fentry prog calls three
do-nothing functions to maximumly expose the cost of private stack.

The following is the jited code for bpf prog in progs/private_stack.c
without private stack. The number of batch iterations is 4096.

subprog:
0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 31 c0                   xor    eax,eax
15: c9                      leave
16: c3                      ret

main prog:
0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 48 bf 00 e0 57 00 00    movabs rdi,0xffffc9000057e000
1a: c9 ff ff
1d: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
21: 48 83 c6 01             add    rsi,0x1
25: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
29: e8 6e 00 00 00          call   0x9c
2e: e8 69 00 00 00          call   0x9c
33: e8 64 00 00 00          call   0x9c
38: 31 c0                   xor    eax,eax
3a: c9                      leave
3b: c3                      ret

The following are the jited progs with private stack:

subprog:
0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
1a: 60 00 00
1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
24: 02 00
26: 31 c0                   xor    eax,eax
28: c9                      leave
29: c3                      ret

main prog:
0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
1a: 60 00 00
1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
24: 02 00
26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
2d: c9 ff ff
30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
34: 48 83 c6 01             add    rsi,0x1
38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
3c: 41 51                   push   r9
3e: e8 46 23 51 e1          call   0xffffffffe1512389
43: 41 59                   pop    r9
45: 41 51                   push   r9
47: e8 3d 23 51 e1          call   0xffffffffe1512389
4c: 41 59                   pop    r9
4e: 41 51                   push   r9
50: e8 34 23 51 e1          call   0xffffffffe1512389
55: 41 59                   pop    r9
57: 31 c0                   xor    eax,eax
59: c9                      leave
5a: c3                      ret

From the above, it is clear for subprog and main prog,
we have some r9 related overhead including retriving the stack
in the jit prelog code:
  movabs r9,0x607e08c1a688
  add    r9,QWORD PTR gs:0x21a00
and 'push r9' and 'pop r9' around subprog calls.

I did some benchmarking on an intel box (Intel(R) Xeon(R) D-2191A CPU @ 1=
.60GHz)
which has 20 cores and 80 cpus. The number of hits are in the unit
of loop iterations.

The following are two benchmark results and a few other tries show
similar results in terms of variation.
  $ ./benchs/run_bench_private_stack.sh
  no-private-stack-1:  2.152 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-1:     2.226 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-8:  89.086 =C2=B1 0.674M/s (drops 0.000 =C2=B1 0.000M/=
s)
  private-stack-8:     90.023 =C2=B1 0.117M/s (drops 0.000 =C2=B1 0.000M/=
s)
  no-private-stack-64:  1545.383 =C2=B1 3.574M/s (drops 0.000 =C2=B1 0.00=
0M/s)
  private-stack-64:    1534.630 =C2=B1 2.063M/s (drops 0.000 =C2=B1 0.000=
M/s)
  no-private-stack-512:  14591.591 =C2=B1 15.202M/s (drops 0.000 =C2=B1 0=
.000M/s)
  private-stack-512:   14323.796 =C2=B1 13.165M/s (drops 0.000 =C2=B1 0.0=
00M/s)
  no-private-stack-2048:  58680.977 =C2=B1 46.116M/s (drops 0.000 =C2=B1 =
0.000M/s)
  private-stack-2048:  58614.699 =C2=B1 22.031M/s (drops 0.000 =C2=B1 0.0=
00M/s)
  no-private-stack-4096:  119974.497 =C2=B1 90.985M/s (drops 0.000 =C2=B1=
 0.000M/s)
  private-stack-4096:  114841.949 =C2=B1 59.514M/s (drops 0.000 =C2=B1 0.=
000M/s)
  $ ./benchs/run_bench_private_stack.sh
  no-private-stack-1:  2.246 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-1:     2.232 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-8:  91.446 =C2=B1 0.055M/s (drops 0.000 =C2=B1 0.000M/=
s)
  private-stack-8:     90.120 =C2=B1 0.069M/s (drops 0.000 =C2=B1 0.000M/=
s)
  no-private-stack-64:  1578.374 =C2=B1 1.508M/s (drops 0.000 =C2=B1 0.00=
0M/s)
  private-stack-64:    1514.909 =C2=B1 3.898M/s (drops 0.000 =C2=B1 0.000=
M/s)
  no-private-stack-512:  14767.811 =C2=B1 22.399M/s (drops 0.000 =C2=B1 0=
.000M/s)
  private-stack-512:   14232.382 =C2=B1 227.217M/s (drops 0.000 =C2=B1 0.=
000M/s)
  no-private-stack-2048:  58342.372 =C2=B1 81.519M/s (drops 0.000 =C2=B1 =
0.000M/s)
  private-stack-2048:  54503.335 =C2=B1 160.199M/s (drops 0.000 =C2=B1 0.=
000M/s)
  no-private-stack-4096:  117262.975 =C2=B1 179.802M/s (drops 0.000 =C2=B1=
 0.000M/s)
  private-stack-4096:  114643.523 =C2=B1 146.956M/s (drops 0.000 =C2=B1 0=
.000M/s)

It is is clear that private-stack is worse than non-private stack up to c=
lose 5 percents.
This can be roughly estimated based on the above jit code with no-private=
-stack vs. private-stack.

Although the benchmark shows up to 5% potential slowdown with private sta=
ck.
In reality, the kernel enables private stack only after stack size 64 whi=
ch means
the bpf prog will do some useful things. If bpf prog uses any helper/kfun=
c, the
push/pop r9 overhead should be minimum compared to the overhead of helper=
/kfunc.
if the prog does not use a lot of helper/kfunc, there is no push/pop r9 a=
nd
the performance should be reasonable too.

With 4096 loop ierations per program run, I got
  $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 no-private=
-stack
  18.47%  bench                                              [k]
  17.29%  bench    bpf_trampoline_6442522961                 [k] bpf_tram=
poline_6442522961
  13.33%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog=
_bcf7977d3b93787c_func1
  11.86%  bench    [kernel.vmlinux]                          [k] migrate_=
enable
  11.60%  bench    [kernel.vmlinux]                          [k] __bpf_pr=
og_enter_recur
  11.42%  bench    [kernel.vmlinux]                          [k] __bpf_pr=
og_exit_recur
   7.87%  bench    [kernel.vmlinux]                          [k] migrate_=
disable
   3.71%  bench    [kernel.vmlinux]                          [k] bpf_get_=
numa_node_id
   3.67%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_prog=
_d9703036495d54b0_trigger_driver
   0.04%  bench    bench                                     [.] btf_vali=
date_type

  $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 private-st=
ack
    18.94%  bench                                              [k]
    16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_pr=
og_bcf7977d3b93787c_func1
    15.77%  bench    bpf_trampoline_6442522961                 [k] bpf_tr=
ampoline_6442522961
    11.70%  bench    [kernel.vmlinux]                          [k] __bpf_=
prog_enter_recur
    11.48%  bench    [kernel.vmlinux]                          [k] migrat=
e_enable
    11.30%  bench    [kernel.vmlinux]                          [k] __bpf_=
prog_exit_recur
     5.85%  bench    [kernel.vmlinux]                          [k] migrat=
e_disable
     3.69%  bench    bpf_prog_d9703036495d54b0_trigger_driver  [k] bpf_pr=
og_d9703036495d54b0_trigger_driver
     3.56%  bench    [kernel.vmlinux]                          [k] bpf_ge=
t_numa_node_id
     0.06%  bench    bench                                     [.] bpf_pr=
og_test_run_opts

NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will i=
nvestigate this further.

I suspect top 18.47%/18.94% perf run probably due to fentry prog bench_tr=
igger_fentry_batch,
considering even subprog func1 takes 13.33%/16.88% time.
Overall bpf prog include trampoline takes more than 50% of the time.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c                   |   5 +-
 include/linux/bpf.h                           |   3 +-
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/syscall.c                          |   4 +-
 kernel/bpf/verifier.c                         |   1 +
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../bpf/benchs/bench_private_stack.c          | 149 ++++++++++++++++++
 .../bpf/benchs/run_bench_private_stack.sh     |  11 ++
 .../selftests/bpf/progs/private_stack.c       |  37 +++++
 12 files changed, 222 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_private_stac=
k.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_private_=
stack.sh
 create mode 100644 tools/testing/selftests/bpf/progs/private_stack.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 60f5d86fb6aa..3f12f7a957ba 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3327,7 +3327,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 skip_init_addrs:
=20
 	if (bpf_enable_private_stack(prog) && !prog->private_stack_ptr) {
-		private_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_depth, 8, GF=
P_KERNEL);
+		if (prog->aux->stack_depth =3D=3D 0)
+			private_stack_ptr =3D __alloc_percpu_gfp(8, 8, GFP_KERNEL);
+		else
+			private_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_depth, 8, G=
FP_KERNEL);
 		if (!private_stack_ptr) {
 			prog =3D orig_prog;
 			goto out_addrs;
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
index f69eb0c5fe03..b5d33cf87695 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2815,14 +2815,13 @@ EXPORT_SYMBOL_GPL(bpf_prog_free);
=20
 bool bpf_enable_private_stack(struct bpf_prog *prog)
 {
-	if (prog->aux->stack_depth <=3D 64)
+	if (prog->disable_private_stack)
 		return false;
=20
 	switch (prog->aux->prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
-	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		return true;
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type !=3D BPF_TRACE_ITER)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..397b2b9eed24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19442,6 +19442,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 			goto out_free;
 		func[i]->is_func =3D 1;
 		func[i]->sleepable =3D prog->sleepable;
+		func[i]->disable_private_stack =3D prog->disable_private_stack;
 		func[i]->aux->func_idx =3D i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf =3D prog->aux->btf;
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
index 000000000000..5ae1e9bfe706
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_private_stack.c
@@ -0,0 +1,149 @@
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
+	long nr_batch_iters;
+} args =3D {
+	.nr_batch_iters =3D 0,
+};
+
+enum {
+	ARG_NR_BATCH_ITERS =3D 3000,
+};
+
+static const struct argp_option opts[] =3D {
+        { "nr-batch-iters", ARG_NR_BATCH_ITERS, "NR_BATCH_ITERS",
+		0, "nr batch iters" },
+        {},
+};
+
+static error_t private_stack_parse_arg(int key, char *arg, struct argp_s=
tate *state)
+{
+	long ret;
+
+        switch (key) {
+        case ARG_NR_BATCH_ITERS:
+                ret =3D strtoul(arg, NULL, 10);
+		if (ret < 1)
+			argp_usage(state);
+		args.nr_batch_iters =3D ret;
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
+		old_flags =3D bpf_program__flags(skel->progs.bench_trigger_fentry_batc=
h);
+		bpf_program__set_flags(skel->progs.bench_trigger_fentry_batch, old_fla=
gs | BPF_F_DISABLE_PRIVATE_STACK);
+	}
+
+	skel->rodata->batch_iters =3D args.nr_batch_iters;
+
+	err =3D private_stack__load(skel);
+	if (err) {
+		fprintf(stderr, "failed to load program\n");
+		exit(1);
+	}
+
+	link =3D bpf_program__attach(skel->progs.bench_trigger_fentry_batch);
+	if (!link) {
+		fprintf(stderr, "failed to attach program bench_trigger_fentry_batch\n=
");
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
+	total_hits =3D skel->bss->hits * skel->rodata->batch_iters;
+	res->hits =3D total_hits - last_hits;
+	res->drops =3D 0;
+	res->false_hits =3D 0;
+	last_hits =3D total_hits;
+}
+
+static void *private_stack_producer(void *unused)
+{
+	struct private_stack *skel =3D ctx.skel;
+	int fd;
+
+	fd  =3D bpf_program__fd(skel->progs.trigger_driver);
+	while (true)
+		bpf_prog_test_run_opts(fd, NULL);
+
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
index 000000000000..692a5f9676a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_private_stack.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for b in 1 8 64 512 2048 4096; do
+    summarize "no-private-stack-${b}: " "$($RUN_BENCH --nr-batch-iters=3D=
${b} no-private-stack)"
+    summarize "private-stack-${b}: " "$($RUN_BENCH --nr-batch-iters=3D${=
b} private-stack)"
+done
diff --git a/tools/testing/selftests/bpf/progs/private_stack.c b/tools/te=
sting/selftests/bpf/progs/private_stack.c
new file mode 100644
index 000000000000..81d2efad5890
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/private_stack.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+unsigned long hits =3D 0;
+const volatile int batch_iters =3D 0;
+
+SEC("raw_tp")
+int trigger_driver(void *ctx)
+{
+	int i;
+
+	for (i =3D 0; i < batch_iters; i++)
+		(void)bpf_get_numa_node_id(); /* attach point for benchmarking */
+
+	return 0;
+}
+
+__attribute__((weak)) int func1(void) {
+	return 0;
+}
+
+SEC("fentry/bpf_get_numa_node_id")
+int bench_trigger_fentry_batch(void *ctx)
+{
+	hits++;
+	(void)func1();
+	(void)func1();
+	(void)func1();
+	return 0;
+}
+
--=20
2.43.0


