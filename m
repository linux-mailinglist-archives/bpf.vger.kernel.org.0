Return-Path: <bpf+bounces-34871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB32931E5C
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C3F1F22C2F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7855AD4B;
	Tue, 16 Jul 2024 01:17:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9D7482
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092627; cv=none; b=i/TXuV+SKyNdLd6DaIRjHOMJePaS2BXJIQTxdMXPbPsG81bKPrqFloHhFMbgQozMv878l5pR3eaV/taJUkDsIzOx6ZS/8ibEGG9hmeKPqMBo4N5Mm/dbO4y0NjKi5rr73b3HQfnesqax53L960gRKEEN9xas7XztqEC9pqcuSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092627; c=relaxed/simple;
	bh=chbbErZTGVzwQFP16z8lzuY/VkXiVBs5nI/w5K5nDlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6ot27XE5C8qZzWMVnpZ5ECDTkhlIHikN1AhfFsy4Rblo5MDceb7+z4rvfXPSiLz6gSw6vmk/yGKxKz83u4Z52Jx1UW2HevsyYg/EcnNsRAZquk3tU8ege5KjHFExJ16ndWEz02Zhl8Fotwa29hw7DIbKbJBGMTjrU6c+K6Wk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id F31066A17D6D; Mon, 15 Jul 2024 18:16:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1 2/2] [no_merge] selftests/bpf: Benchmark runtime performance with private stack
Date: Mon, 15 Jul 2024 18:16:52 -0700
Message-ID: <20240716011652.811985-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716011647.811746-1-yonghong.song@linux.dev>
References: <20240716011647.811746-1-yonghong.song@linux.dev>
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

The following is the jited code for bpf prog in progs/private_stack.c
without private stack. The number of batch iterations is 4096.

0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 48 81 ec 60 00 00 00    sub    rsp,0x60
1a: 53                      push   rbx
1b: 41 55                   push   r13
1d: 48 bf 00 50 5d 00 00    movabs rdi,0xffffc900005d5000
24: c9 ff ff
27: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
2b: 48 83 c6 01             add    rsi,0x1
2f: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
33: 31 ff                   xor    edi,edi
35: 48 89 7d f8             mov    QWORD PTR [rbp-0x8],rdi
39: be 05 00 00 00          mov    esi,0x5
3e: 89 75 f8                mov    DWORD PTR [rbp-0x8],esi
41: 48 89 7d f0             mov    QWORD PTR [rbp-0x10],rdi
45: 48 89 7d e8             mov    QWORD PTR [rbp-0x18],rdi
49: 48 89 7d e0             mov    QWORD PTR [rbp-0x20],rdi
4d: 48 89 7d d8             mov    QWORD PTR [rbp-0x28],rdi
51: 48 89 7d d0             mov    QWORD PTR [rbp-0x30],rdi
55: 48 89 7d c0             mov    QWORD PTR [rbp-0x40],rdi
59: 48 89 7d c8             mov    QWORD PTR [rbp-0x38],rdi
5d: 48 89 7d b8             mov    QWORD PTR [rbp-0x48],rdi
61: 48 89 7d b0             mov    QWORD PTR [rbp-0x50],rdi
65: 48 89 7d a8             mov    QWORD PTR [rbp-0x58],rdi
69: 48 89 7d a0             mov    QWORD PTR [rbp-0x60],rdi
6d: bf 0a 00 00 00          mov    edi,0xa
72: 89 7d c0                mov    DWORD PTR [rbp-0x40],edi
75: 48 bb 00 80 5d 00 00    movabs rbx,0xffffc900005d8000
7c: c9 ff ff
7f: 8b 7b 00                mov    edi,DWORD PTR [rbx+0x0]
82: 83 ff 01                cmp    edi,0x1
85: 7c 27                   jl     0xae
87: 45 31 ed                xor    r13d,r13d
8a: eb 29                   jmp    0xb5
8c: 48 89 ee                mov    rsi,rbp
8f: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
93: 48 bf 00 38 f9 09 81    movabs rdi,0xffff888109f93800
9a: 88 ff ff
9d: e8 e2 e1 5e e1          call   0xffffffffe15ee284
a2: 41 83 c5 01             add    r13d,0x1
a6: 8b 7b 00                mov    edi,DWORD PTR [rbx+0x0]
a9: 41 39 fd                cmp    r13d,edi
ac: 7c 07                   jl     0xb5
ae: 31 c0                   xor    eax,eax
b0: 41 5d                   pop    r13
b2: 5b                      pop    rbx
b3: c9                      leave
b4: c3                      ret
b5: 48 89 ee                mov    rsi,rbp
b8: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
bc: 48 bf 00 38 f9 09 81    movabs rdi,0xffff888109f93800
c3: 88 ff ff
c6: e8 49 1f 5f e1          call   0xffffffffe15f2014
cb: 48 85 c0                test   rax,rax
ce: 74 04                   je     0xd4
d0: 48 83 c0 60             add    rax,0x60
d4: 48 85 c0                test   rax,rax
d7: 75 b3                   jne    0x8c
d9: 48 89 ee                mov    rsi,rbp
dc: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
e0: 48 89 ea                mov    rdx,rbp
e3: 48 83 c2 a0             add    rdx,0xffffffffffffffa0
e7: 48 bf 00 38 f9 09 81    movabs rdi,0xffff888109f93800
ee: 88 ff ff
f1: 31 c9                   xor    ecx,ecx
f3: e8 dc d8 5e e1          call   0xffffffffe15ed9d4
f8: eb 92                   jmp    0x8c

The following is the corresponding jited code with private stack:

0:  f3 0f 1e fa             endbr64
4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
9:  66 90                   xchg   ax,ax
b:  55                      push   rbp
c:  48 89 e5                mov    rbp,rsp
f:  f3 0f 1e fa             endbr64
13: 53                      push   rbx
14: 41 55                   push   r13
16: 49 b9 c0 a8 c1 08 7e    movabs r9,0x607e08c1a8c0
1d: 60 00 00
20: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
27: 02 00
29: 48 bf 00 80 61 00 00    movabs rdi,0xffffc90000618000
30: c9 ff ff
33: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
37: 48 83 c6 01             add    rsi,0x1
3b: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
3f: 31 ff                   xor    edi,edi
41: 49 89 79 f8             mov    QWORD PTR [r9-0x8],rdi
45: be 05 00 00 00          mov    esi,0x5
4a: 41 89 71 f8             mov    DWORD PTR [r9-0x8],esi
4e: 49 89 79 f0             mov    QWORD PTR [r9-0x10],rdi
52: 49 89 79 e8             mov    QWORD PTR [r9-0x18],rdi
56: 49 89 79 e0             mov    QWORD PTR [r9-0x20],rdi
5a: 49 89 79 d8             mov    QWORD PTR [r9-0x28],rdi
5e: 49 89 79 d0             mov    QWORD PTR [r9-0x30],rdi
62: 49 89 79 c0             mov    QWORD PTR [r9-0x40],rdi
66: 49 89 79 c8             mov    QWORD PTR [r9-0x38],rdi
6a: 49 89 79 b8             mov    QWORD PTR [r9-0x48],rdi
6e: 49 89 79 b0             mov    QWORD PTR [r9-0x50],rdi
72: 49 89 79 a8             mov    QWORD PTR [r9-0x58],rdi
76: 49 89 79 a0             mov    QWORD PTR [r9-0x60],rdi
7a: bf 0a 00 00 00          mov    edi,0xa
7f: 41 89 79 c0             mov    DWORD PTR [r9-0x40],edi
83: 48 bb 00 b0 61 00 00    movabs rbx,0xffffc9000061b000
8a: c9 ff ff
8d: 8b 7b 00                mov    edi,DWORD PTR [rbx+0x0]
90: 83 ff 01                cmp    edi,0x1
93: 7c 2b                   jl     0xc0
95: 45 31 ed                xor    r13d,r13d
98: eb 2d                   jmp    0xc7
9a: 4c 89 ce                mov    rsi,r9
9d: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
a1: 48 bf 00 40 f9 09 81    movabs rdi,0xffff888109f94000
a8: 88 ff ff
ab: 41 51                   push   r9
ad: e8 fa e1 5e e1          call   0xffffffffe15ee2ac
b2: 41 59                   pop    r9
b4: 41 83 c5 01             add    r13d,0x1
b8: 8b 7b 00                mov    edi,DWORD PTR [rbx+0x0]
bb: 41 39 fd                cmp    r13d,edi
be: 7c 07                   jl     0xc7
c0: 31 c0                   xor    eax,eax
c2: 41 5d                   pop    r13
c4: 5b                      pop    rbx
c5: c9                      leave
c6: c3                      ret
c7: 4c 89 ce                mov    rsi,r9
ca: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
ce: 48 bf 00 40 f9 09 81    movabs rdi,0xffff888109f94000
d5: 88 ff ff
d8: 41 51                   push   r9
da: e8 5d 1f 5f e1          call   0xffffffffe15f203c
df: 41 59                   pop    r9
e1: 48 85 c0                test   rax,rax
e4: 74 04                   je     0xea
e6: 48 83 c0 60             add    rax,0x60
ea: 48 85 c0                test   rax,rax
ed: 75 ab                   jne    0x9a
ef: 4c 89 ce                mov    rsi,r9
f2: 48 83 c6 d0             add    rsi,0xffffffffffffffd0
f6: 4c 89 ca                mov    rdx,r9
f9: 48 83 c2 a0             add    rdx,0xffffffffffffffa0
fd: 48 bf 00 40 f9 09 81    movabs rdi,0xffff888109f94000
104:    88 ff ff
107:    31 c9                   xor    ecx,ecx
109:    41 51                   push   r9
10b:    e8 ec d8 5e e1          call   0xffffffffe15ed9fc
110:    41 59                   pop    r9
112:    eb 86                   jmp    0x9a

It is clear that the main overhead is the push/pop r9 for
three calls since those calls are in a loop. The initial r9
assignment
  16: 49 b9 c0 a8 c1 08 7e    movabs r9,0x607e08c1a8c0
  1d: 60 00 00
  20: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
  27: 02 00
is the overhead per prog run.

I did some benchmarking on an intel box (Intel(R) Xeon(R) Gold 6138 CPU @=
 2.00GHz)
which has 20 cores and 80 cpus. Note that the number of hits are in the u=
nit
of loop iterations. More loop iterations per prog means more time will be
spent with bpf programs.

I did four runs of tests. [no-]private-stack-[num-of-loop-iterations-per-=
prog]
shows whether the run is with/without private stack and the number of loo=
p
iterations per program run. The number of hits equals to the total number=
 of
loop iterations in bpf prog.

The following are two of benchmark results:
  $ ./benchs/run_bench_private_stack.sh
  no-private-stack-1:  2.771 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-1:     2.734 =C2=B1 0.031M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-8:  4.613 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-8:     4.611 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-64:  5.062 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/=
s)
  private-stack-64:    5.024 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-512:  5.127 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M=
/s)
  private-stack-512:   5.120 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-2048:  5.132 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000=
M/s)
  private-stack-2048:  5.131 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-4096:  5.116 =C2=B1 0.023M/s (drops 0.000 =C2=B1 0.000=
M/s)
  private-stack-4096:  5.123 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
  $ ./benchs/run_bench_private_stack.sh
  no-private-stack-1:  2.769 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-1:     2.740 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-8:  4.617 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s=
)
  private-stack-8:     4.578 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-64:  5.059 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/=
s)
  private-stack-64:    5.051 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-512:  5.125 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M=
/s)
  private-stack-512:   5.116 =C2=B1 0.016M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-2048:  5.132 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000=
M/s)
  private-stack-2048:  5.135 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000M/s=
)
  no-private-stack-4096:  5.142 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000=
M/s)
  private-stack-4096:  5.109 =C2=B1 0.023M/s (drops 0.000 =C2=B1 0.000M/s=
)

The other two are simialr such that for batch size 2048/4096,
private-stack might show better results than non-private-stack due to noi=
sek
But in general, the no-private-stack is slighter better than private-stac=
k,
esp. the number of loop iterations in the bpf prog is large.

I also collected some perf results. With one loop iteration
per program run, I got
  $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D1 no-private-st=
ack
    18.48%  bench    [kernel.vmlinux]                               [k] h=
tab_map_hash
    13.04%  bench    [kernel.vmlinux]                               [k] _=
raw_spin_lock
     7.00%  bench    libc.so.6                                      [.] s=
yscall
     5.91%  bench    [kernel.vmlinux]                               [k] h=
tab_map_update_elem
     5.68%  bench    [kernel.vmlinux]                               [k] e=
ntry_SYSRETQ_unsafe_stack
     4.55%  bench    [kernel.vmlinux]                               [k] p=
erf_syscall_enter
     4.37%  bench    [kernel.vmlinux]                               [k] h=
tab_map_delete_elem
     2.89%  bench    bpf_prog_a8e2493fe867b453_stack0               [k] b=
pf_prog_a8e2493fe867b453_stack0
     2.83%  bench    [kernel.vmlinux]                               [k] m=
emcpy_orig
     2.60%  bench    [kernel.vmlinux]                               [k] _=
_htab_map_lookup_elem
     2.53%  bench    [kernel.vmlinux]                               [k] a=
lloc_htab_elem
     2.52%  bench    [kernel.vmlinux]                               [k] t=
race_call_bpf
     2.37%  bench    [kernel.vmlinux]                               [k] e=
ntry_SYSCALL_64_after_hwframe
     2.29%  bench    [kernel.vmlinux]                               [k] d=
o_syscall_64

I only showed functions with cpu consumption >=3D 2%. You can see 'syscal=
l'
overhead itself is 7% and bpf progrm run didn't take majority of time.
The stack trace for private stack is very similar to the above.

With 4096 loop ierations per program run, I got
  $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 no-private=
-stack
    27.89%  bench    [kernel.vmlinux]                  [k] htab_map_hash
    21.55%  bench    [kernel.vmlinux]                  [k] _raw_spin_lock
    11.51%  bench    [kernel.vmlinux]                  [k] htab_map_delet=
e_elem
    10.26%  bench    [kernel.vmlinux]                  [k] htab_map_updat=
e_elem
     4.85%  bench    [kernel.vmlinux]                  [k] __pcpu_freelis=
t_push
     4.34%  bench    [kernel.vmlinux]                  [k] alloc_htab_ele=
m
     3.50%  bench    [kernel.vmlinux]                  [k] memcpy_orig
     3.22%  bench    [kernel.vmlinux]                  [k] __pcpu_freelis=
t_pop
     2.68%  bench    [kernel.vmlinux]                  [k] bcmp
     2.52%  bench    [kernel.vmlinux]                  [k] __htab_map_loo=
kup_elem
     ...
     0.01%  bench    libc.so.6                         [.] syscall

The 'syscall' overhead is 0.01% now and majority cpu time is on bpf progr=
ams.
Again, the stack trace for private stack is very similar to the above.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h                           |   3 +-
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/syscall.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../bpf/benchs/bench_private_stack.c          | 144 ++++++++++++++++++
 .../bpf/benchs/run_bench_private_stack.sh     |  11 ++
 .../selftests/bpf/progs/private_stack.c       |  44 ++++++
 10 files changed, 219 insertions(+), 3 deletions(-)
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
index 000000000000..9a1fec9d1096
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_private_stack.c
@@ -0,0 +1,144 @@
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
+		old_flags =3D bpf_program__flags(skel->progs.stack0);
+		bpf_program__set_flags(skel->progs.stack0, old_flags | BPF_F_DISABLE_P=
RIVATE_STACK);
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
+	total_hits =3D skel->bss->hits * skel->rodata->batch_iters;
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
index 000000000000..ba2fa67306c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/private_stack.c
@@ -0,0 +1,44 @@
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
+const volatile int batch_iters =3D 0;
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int stack0(void *ctx)
+{
+	struct data_t key =3D {}, value =3D {};
+	struct data_t *pvalue;
+	int i;
+
+	hits++;
+	key.d[10] =3D 5;
+	value.d[8] =3D 10;
+
+	for (i =3D 0; i < batch_iters; i++) {
+		pvalue =3D bpf_map_lookup_elem(&htab, &key);
+		if (!pvalue)
+			bpf_map_update_elem(&htab, &key, &value, 0);
+		bpf_map_delete_elem(&htab, &key);
+	}
+
+	return 0;
+}
+
--=20
2.43.0


