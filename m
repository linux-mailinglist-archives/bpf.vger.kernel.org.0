Return-Path: <bpf+bounces-14903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A667E8DD5
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD28E280DB2
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329017EC;
	Sun, 12 Nov 2023 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30517EA
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:58 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1911B30F7
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:53 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABNdSVj019849
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua7m3jq1b-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:52 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 74F1A3B5D5245; Sat, 11 Nov 2023 17:06:39 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 07/13] selftests/bpf: BPF register range bounds tester
Date: Sat, 11 Nov 2023 17:06:03 -0800
Message-ID: <20231112010609.848406-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FzopuR_eMtgtysVdr6rgUSFsFnSM0nqX
X-Proofpoint-ORIG-GUID: FzopuR_eMtgtysVdr6rgUSFsFnSM0nqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Add test to validate BPF verifier's register range bounds tracking logic.

The main bulk is a lot of auto-generated tests based on a small set of
seed values for lower and upper 32 bits of full 64-bit values.
Currently we validate only range vs const comparisons, but the idea is
to start validating range over range comparisons in subsequent patch set.

When setting up initial register ranges we treat registers as one of
u64/s64/u32/s32 numeric types, and then independently perform conditional
comparisons based on a potentially different u64/s64/u32/s32 types. This
tests lots of tricky cases of deriving bounds information across
different numeric domains.

Given there are lots of auto-generated cases, we guard them behind
SLOW_TESTS=3D1 envvar requirement, and skip them altogether otherwise.
With current full set of upper/lower seed value, all supported
comparison operators and all the combinations of u64/s64/u32/s32 number
domains, we get about 7.7 million tests, which run in about 35 minutes
on my local qemu instance without parallelization. But we also split
those tests by init/cond numeric types, which allows to rely on
test_progs's parallelization of tests with `-j` option, getting run time
down to about 5 minutes on 8 cores. It's still something that shouldn't
be run during normal test_progs run.  But we can run it a reasonable
time, and so perhaps a nightly CI test run (once we have it) would be
a good option for this.

We also add a small set of tricky conditions that came up during
development and triggered various bugs or corner cases in either
selftest's reimplementation of range bounds logic or in verifier's logic
itself. These are fast enough to be run as part of normal test_progs
test run and are great for a quick sanity checking.

Let's take a look at test output to understand what's going on:

  $ sudo ./test_progs -t reg_bounds_crafted
  #191/1   reg_bounds_crafted/(u64)[0; 0xffffffff] (u64)< 0:OK
  ...
  #191/115 reg_bounds_crafted/(u64)[0; 0x17fffffff] (s32)< 0:OK
  ...
  #191/137 reg_bounds_crafted/(u64)[0xffffffff; 0x100000000] (u64)=3D=3D =
0:OK

Each test case is uniquely and fully described by this generated string.
E.g.: "(u64)[0; 0x17fffffff] (s32)< 0". This means that we
initialize a register (R6) in such a way that verifier knows that it can
have a value in [(u64)0; (u64)0x17fffffff] range. Another
register (R7) is also set up as u64, but this time a constant (zero in
this case). They then are compared using 32-bit signed < operation.
Resulting TRUE/FALSE branches are evaluated (including cases where it's
known that one of the branches will never be taken, in which case we
validate that verifier also determines this as a dead code). Test
validates that verifier's final register state matches expected state
based on selftest's own reg_state logic, implemented from scratch for
cross-checking purposes.

These test names can be conveniently used for further debugging, and if -=
vv
verboseness is requested we can get a corresponding verifier log (with
mark_precise logs filtered out as irrelevant and distracting). Example be=
low is
slightly redacted for brevity, omitting irrelevant register output in
some places, marked with [...].

  $ sudo ./test_progs -a 'reg_bounds_crafted/(u32)[0; U32_MAX] (s32)< -1'=
 -vv
  ...
  VERIFIER LOG:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  func#0 @0
  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  0: (05) goto pc+2
  3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
  4: (bc) w6 =3D w0                       ; R0_w=3Dscalar() R6_w=3Dscalar=
(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xffffffff))
  5: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
  6: (bc) w7 =3D w0                       ; R0_w=3Dscalar() R7_w=3Dscalar=
(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xffffffff))
  7: (b4) w1 =3D 0                        ; R1_w=3D0
  8: (b4) w2 =3D -1                       ; R2=3D4294967295
  9: (ae) if w6 < w1 goto pc-9
  9: R1=3D0 R6=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;=
 0xffffffff))
  10: (2e) if w6 > w2 goto pc-10
  10: R2=3D4294967295 R6=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_o=
ff=3D(0x0; 0xffffffff))
  11: (b4) w1 =3D -1                      ; R1_w=3D4294967295
  12: (b4) w2 =3D -1                      ; R2_w=3D4294967295
  13: (ae) if w7 < w1 goto pc-13        ; R1_w=3D4294967295 R7=3D42949672=
95
  14: (2e) if w7 > w2 goto pc-14
  14: R2_w=3D4294967295 R7=3D4294967295
  15: (bc) w0 =3D w6                      ; [...] R6=3Dscalar(id=3D1,smin=
=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xffffffff))
  16: (bc) w0 =3D w7                      ; [...] R7=3D4294967295
  17: (ce) if w6 s< w7 goto pc+3        ; R6=3Dscalar(id=3D1,smin=3D0,sma=
x=3Dumax=3D4294967295,smin32=3D-1,var_off=3D(0x0; 0xffffffff)) R7=3D42949=
67295
  18: (bc) w0 =3D w6                      ; [...] R6=3Dscalar(id=3D1,smin=
=3D0,smax=3Dumax=3D4294967295,smin32=3D-1,var_off=3D(0x0; 0xffffffff))
  19: (bc) w0 =3D w7                      ; [...] R7=3D4294967295
  20: (95) exit

  from 17 to 21: [...]
  21: (bc) w0 =3D w6                      ; [...] R6=3Dscalar(id=3D1,smin=
=3Dumin=3Dumin32=3D2147483648,smax=3Dumax=3Dumax32=3D4294967294,smax32=3D=
-2,var_off=3D(0x80000000; 0x7fffffff))
  22: (bc) w0 =3D w7                      ; [...] R7=3D4294967295
  23: (95) exit

  from 13 to 1: [...]
  1: [...]
  1: (b7) r0 =3D 0                        ; R0_w=3D0
  2: (95) exit
  processed 24 insns (limit 1000000) max_states_per_insn 0 total_states 2=
 peak_states 2 mark_read 1
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Verifier log above is for `(u32)[0; U32_MAX] (s32)< -1` use cases, where =
u32
range is used for initialization, followed by signed < operator. Note
how we use w6/w7 in this case for register initialization (it would be
R6/R7 for 64-bit types) and then `if w6 s< w7` for comparison at
instruction #17. It will be `if R6 < R7` for 64-bit unsigned comparison.
Above example gives a good impression of the overall structure of a BPF
programs generated for reg_bounds tests.

In the future, this "framework" can be extended to test not just
conditional jumps, but also arithmetic operations. Adding randomized
testing is another possibility.

Some implementation notes. We basically have our own generics-like
operations on numbers, where all the numbers are stored in u64, but how
they are interpreted is passed as runtime argument enum num_t. Further,
`struct range` represents a bounds range, and those are collected
together into a minimal `struct reg_state`, which collects range bounds
across all four numberical domains: u64, s64, u32, s64.

Based on these primitives and `enum op` representing possible
conditional operation (<, <=3D, >, >=3D, =3D=3D, !=3D), there is a set of=
 generic
helpers to perform "range arithmetics", which is used to maintain struct
reg_state. We simulate what verifier will do for reg bounds of R6 and R7
registers using these range and reg_state primitives. Simulated
information is used to determine branch taken conclusion and expected
exact register state across all four number domains.

Implementation of "range arithmetics" is more generic than what verifier
is currently performing: it allows range over range comparisons and
adjustments. This is the intended end goal of this patch set overall and =
verifier
logic is enhanced in subsequent patches in this series to handle range
vs range operations, at which point selftests are extended to validate
these conditions as well. For now it's range vs const cases only.

Note that tests are split into multiple groups by their numeric types
for initialization of ranges and for comparison operation. This allows
to use test_progs's -j parallelization to speed up tests, as we now have
16 groups of parallel running tests. Overall reduction of running time
that allows is pretty good, we go down from more than 30 minutes to
slightly less than 5 minutes running time.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 1838 +++++++++++++++++
 1 file changed, 1838 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
new file mode 100644
index 000000000000..7a524b381ed3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -0,0 +1,1838 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <limits.h>
+#include <test_progs.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * SHORT AND CONSISTENT NUMBER TYPES
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+#define U64_MAX ((u64)UINT64_MAX)
+#define U32_MAX ((u32)UINT_MAX)
+#define S64_MIN ((s64)INT64_MIN)
+#define S64_MAX ((s64)INT64_MAX)
+#define S32_MIN ((s32)INT_MIN)
+#define S32_MAX ((s32)INT_MAX)
+
+typedef unsigned long long ___u64;
+typedef unsigned int ___u32;
+typedef long long ___s64;
+typedef int ___s32;
+
+/* avoid conflicts with already defined types in kernel headers */
+#define u64 ___u64
+#define u32 ___u32
+#define s64 ___s64
+#define s32 ___s32
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * STRING BUF ABSTRACTION AND HELPERS
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+struct strbuf {
+	size_t buf_sz;
+	int pos;
+	char buf[0];
+};
+
+#define DEFINE_STRBUF(name, N)						\
+	struct { struct strbuf buf; char data[(N)]; } ___##name;	\
+	struct strbuf *name =3D (___##name.buf.buf_sz =3D (N), ___##name.buf.po=
s =3D 0, &___##name.buf)
+
+__printf(2, 3)
+static inline void snappendf(struct strbuf *s, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	s->pos +=3D vsnprintf(s->buf + s->pos,
+			    s->pos < s->buf_sz ? s->buf_sz - s->pos : 0,
+			    fmt, args);
+	va_end(args);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * GENERIC NUMBER TYPE AND OPERATIONS
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+enum num_t { U64, first_t =3D U64, U32, S64, S32, last_t =3D S32 };
+
+static __always_inline u64 min_t(enum num_t t, u64 x, u64 y)
+{
+	switch (t) {
+	case U64: return (u64)x < (u64)y ? (u64)x : (u64)y;
+	case U32: return (u32)x < (u32)y ? (u32)x : (u32)y;
+	case S64: return (s64)x < (s64)y ? (s64)x : (s64)y;
+	case S32: return (s32)x < (s32)y ? (s32)x : (s32)y;
+	default: printf("min_t!\n"); exit(1);
+	}
+}
+
+static __always_inline u64 max_t(enum num_t t, u64 x, u64 y)
+{
+	switch (t) {
+	case U64: return (u64)x > (u64)y ? (u64)x : (u64)y;
+	case U32: return (u32)x > (u32)y ? (u32)x : (u32)y;
+	case S64: return (s64)x > (s64)y ? (s64)x : (s64)y;
+	case S32: return (s32)x > (s32)y ? (u32)(s32)x : (u32)(s32)y;
+	default: printf("max_t!\n"); exit(1);
+	}
+}
+
+static const char *t_str(enum num_t t)
+{
+	switch (t) {
+	case U64: return "u64";
+	case U32: return "u32";
+	case S64: return "s64";
+	case S32: return "s32";
+	default: printf("t_str!\n"); exit(1);
+	}
+}
+
+static enum num_t t_is_32(enum num_t t)
+{
+	switch (t) {
+	case U64: return false;
+	case U32: return true;
+	case S64: return false;
+	case S32: return true;
+	default: printf("t_is_32!\n"); exit(1);
+	}
+}
+
+static enum num_t t_signed(enum num_t t)
+{
+	switch (t) {
+	case U64: return S64;
+	case U32: return S32;
+	case S64: return S64;
+	case S32: return S32;
+	default: printf("t_signed!\n"); exit(1);
+	}
+}
+
+static enum num_t t_unsigned(enum num_t t)
+{
+	switch (t) {
+	case U64: return U64;
+	case U32: return U32;
+	case S64: return U64;
+	case S32: return U32;
+	default: printf("t_unsigned!\n"); exit(1);
+	}
+}
+
+static bool num_is_small(enum num_t t, u64 x)
+{
+	switch (t) {
+	case U64: return (u64)x <=3D 256;
+	case U32: return (u32)x <=3D 256;
+	case S64: return (s64)x >=3D -256 && (s64)x <=3D 256;
+	case S32: return (s32)x >=3D -256 && (s32)x <=3D 256;
+	default: printf("num_is_small!\n"); exit(1);
+	}
+}
+
+static void snprintf_num(enum num_t t, struct strbuf *sb, u64 x)
+{
+	bool is_small =3D num_is_small(t, x);
+
+	if (is_small) {
+		switch (t) {
+		case U64: return snappendf(sb, "%llu", (u64)x);
+		case U32: return snappendf(sb, "%u", (u32)x);
+		case S64: return snappendf(sb, "%lld", (s64)x);
+		case S32: return snappendf(sb, "%d", (s32)x);
+		default: printf("snprintf_num!\n"); exit(1);
+		}
+	} else {
+		switch (t) {
+		case U64:
+			if (x =3D=3D U64_MAX)
+				return snappendf(sb, "U64_MAX");
+			else if (x >=3D U64_MAX - 256)
+				return snappendf(sb, "U64_MAX-%llu", U64_MAX - x);
+			else
+				return snappendf(sb, "%#llx", (u64)x);
+		case U32:
+			if ((u32)x =3D=3D U32_MAX)
+				return snappendf(sb, "U32_MAX");
+			else if ((u32)x >=3D U32_MAX - 256)
+				return snappendf(sb, "U32_MAX-%u", U32_MAX - (u32)x);
+			else
+				return snappendf(sb, "%#x", (u32)x);
+		case S64:
+			if ((s64)x =3D=3D S64_MAX)
+				return snappendf(sb, "S64_MAX");
+			else if ((s64)x >=3D S64_MAX - 256)
+				return snappendf(sb, "S64_MAX-%lld", S64_MAX - (s64)x);
+			else if ((s64)x =3D=3D S64_MIN)
+				return snappendf(sb, "S64_MIN");
+			else if ((s64)x <=3D S64_MIN + 256)
+				return snappendf(sb, "S64_MIN+%lld", (s64)x - S64_MIN);
+			else
+				return snappendf(sb, "%#llx", (s64)x);
+		case S32:
+			if ((s32)x =3D=3D S32_MAX)
+				return snappendf(sb, "S32_MAX");
+			else if ((s32)x >=3D S32_MAX - 256)
+				return snappendf(sb, "S32_MAX-%d", S32_MAX - (s32)x);
+			else if ((s32)x =3D=3D S32_MIN)
+				return snappendf(sb, "S32_MIN");
+			else if ((s32)x <=3D S32_MIN + 256)
+				return snappendf(sb, "S32_MIN+%d", (s32)x - S32_MIN);
+			else
+				return snappendf(sb, "%#x", (s32)x);
+		default: printf("snprintf_num!\n"); exit(1);
+		}
+	}
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * GENERIC RANGE STRUCT AND OPERATIONS
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+struct range {
+	u64 a, b;
+};
+
+static void snprintf_range(enum num_t t, struct strbuf *sb, struct range=
 x)
+{
+	if (x.a =3D=3D x.b)
+		return snprintf_num(t, sb, x.a);
+
+	snappendf(sb, "[");
+	snprintf_num(t, sb, x.a);
+	snappendf(sb, "; ");
+	snprintf_num(t, sb, x.b);
+	snappendf(sb, "]");
+}
+
+static void print_range(enum num_t t, struct range x, const char *sfx)
+{
+	DEFINE_STRBUF(sb, 128);
+
+	snprintf_range(t, sb, x);
+	printf("%s%s", sb->buf, sfx);
+}
+
+static const struct range unkn[] =3D {
+	[U64] =3D { 0, U64_MAX },
+	[U32] =3D { 0, U32_MAX },
+	[S64] =3D { (u64)S64_MIN, (u64)S64_MAX },
+	[S32] =3D { (u64)(u32)S32_MIN, (u64)(u32)S32_MAX },
+};
+
+static struct range unkn_subreg(enum num_t t)
+{
+	switch (t) {
+	case U64: return unkn[U32];
+	case U32: return unkn[U32];
+	case S64: return unkn[U32];
+	case S32: return unkn[S32];
+	default: printf("unkn_subreg!\n"); exit(1);
+	}
+}
+
+static struct range range(enum num_t t, u64 a, u64 b)
+{
+	switch (t) {
+	case U64: return (struct range){ (u64)a, (u64)b };
+	case U32: return (struct range){ (u32)a, (u32)b };
+	case S64: return (struct range){ (s64)a, (s64)b };
+	case S32: return (struct range){ (u32)(s32)a, (u32)(s32)b };
+	default: printf("range!\n"); exit(1);
+	}
+}
+
+static __always_inline u32 sign64(u64 x) { return (x >> 63) & 1; }
+static __always_inline u32 sign32(u64 x) { return ((u32)x >> 31) & 1; }
+static __always_inline u32 upper32(u64 x) { return (u32)(x >> 32); }
+static __always_inline u64 swap_low32(u64 x, u32 y) { return (x & 0xffff=
ffff00000000ULL) | y; }
+
+static bool range_eq(struct range x, struct range y)
+{
+	return x.a =3D=3D y.a && x.b =3D=3D y.b;
+}
+
+static struct range range_cast_to_s32(struct range x)
+{
+	u64 a =3D x.a, b =3D x.b;
+
+	/* if upper 32 bits are constant, lower 32 bits should form a proper
+	 * s32 range to be correct
+	 */
+	if (upper32(a) =3D=3D upper32(b) && (s32)a <=3D (s32)b)
+		return range(S32, a, b);
+
+	/* Special case where upper bits form a small sequence of two
+	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
+	 * 0x00000000 is also valid), while lower bits form a proper s32 range
+	 * going from negative numbers to positive numbers.
+	 *
+	 * E.g.: [0xfffffff0ffffff00; 0xfffffff100000010]. Iterating
+	 * over full 64-bit numbers range will form a proper [-16, 16]
+	 * ([0xffffff00; 0x00000010]) range in its lower 32 bits.
+	 */
+	if (upper32(a) + 1 =3D=3D upper32(b) && (s32)a < 0 && (s32)b >=3D 0)
+		return range(S32, a, b);
+
+	/* otherwise we can't derive much meaningful information */
+	return unkn[S32];
+}
+
+static struct range range_cast_u64(enum num_t to_t, struct range x)
+{
+	u64 a =3D (u64)x.a, b =3D (u64)x.b;
+
+	switch (to_t) {
+	case U64:
+		return x;
+	case U32:
+		if (upper32(a) !=3D upper32(b))
+			return unkn[U32];
+		return range(U32, a, b);
+	case S64:
+		if (sign64(a) !=3D sign64(b))
+			return unkn[S64];
+		return range(S64, a, b);
+	case S32:
+		return range_cast_to_s32(x);
+	default: printf("range_cast_u64!\n"); exit(1);
+	}
+}
+
+static struct range range_cast_s64(enum num_t to_t, struct range x)
+{
+	s64 a =3D (s64)x.a, b =3D (s64)x.b;
+
+	switch (to_t) {
+	case U64:
+		/* equivalent to (s64)a <=3D (s64)b check */
+		if (sign64(a) !=3D sign64(b))
+			return unkn[U64];
+		return range(U64, a, b);
+	case U32:
+		if (upper32(a) !=3D upper32(b) || sign32(a) !=3D sign32(b))
+			return unkn[U32];
+		return range(U32, a, b);
+	case S64:
+		return x;
+	case S32:
+		return range_cast_to_s32(x);
+	default: printf("range_cast_s64!\n"); exit(1);
+	}
+}
+
+static struct range range_cast_u32(enum num_t to_t, struct range x)
+{
+	u32 a =3D (u32)x.a, b =3D (u32)x.b;
+
+	switch (to_t) {
+	case U64:
+	case S64:
+		/* u32 is always a valid zero-extended u64/s64 */
+		return range(to_t, a, b);
+	case U32:
+		return x;
+	case S32:
+		return range_cast_to_s32(range(U32, a, b));
+	default: printf("range_cast_u32!\n"); exit(1);
+	}
+}
+
+static struct range range_cast_s32(enum num_t to_t, struct range x)
+{
+	s32 a =3D (s32)x.a, b =3D (s32)x.b;
+
+	switch (to_t) {
+	case U64:
+	case U32:
+	case S64:
+		if (sign32(a) !=3D sign32(b))
+			return unkn[to_t];
+		return range(to_t, a, b);
+	case S32:
+		return x;
+	default: printf("range_cast_s32!\n"); exit(1);
+	}
+}
+
+/* Reinterpret range in *from_t* domain as a range in *to_t* domain pres=
erving
+ * all possible information. Worst case, it will be unknown range within
+ * *to_t* domain, if nothing more specific can be guaranteed during the
+ * conversion
+ */
+static struct range range_cast(enum num_t from_t, enum num_t to_t, struc=
t range from)
+{
+	switch (from_t) {
+	case U64: return range_cast_u64(to_t, from);
+	case U32: return range_cast_u32(to_t, from);
+	case S64: return range_cast_s64(to_t, from);
+	case S32: return range_cast_s32(to_t, from);
+	default: printf("range_cast!\n"); exit(1);
+	}
+}
+
+static bool is_valid_num(enum num_t t, u64 x)
+{
+	switch (t) {
+	case U64: return true;
+	case U32: return upper32(x) =3D=3D 0;
+	case S64: return true;
+	case S32: return upper32(x) =3D=3D 0;
+	default: printf("is_valid_num!\n"); exit(1);
+	}
+}
+
+static bool is_valid_range(enum num_t t, struct range x)
+{
+	if (!is_valid_num(t, x.a) || !is_valid_num(t, x.b))
+		return false;
+
+	switch (t) {
+	case U64: return (u64)x.a <=3D (u64)x.b;
+	case U32: return (u32)x.a <=3D (u32)x.b;
+	case S64: return (s64)x.a <=3D (s64)x.b;
+	case S32: return (s32)x.a <=3D (s32)x.b;
+	default: printf("is_valid_range!\n"); exit(1);
+	}
+}
+
+static struct range range_improve(enum num_t t, struct range old, struct=
 range new)
+{
+	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
+}
+
+static struct range range_refine(enum num_t x_t, struct range x, enum nu=
m_t y_t, struct range y)
+{
+	struct range y_cast;
+
+	y_cast =3D range_cast(y_t, x_t, y);
+
+	/* the case when new range knowledge, *y*, is a 32-bit subregister
+	 * range, while previous range knowledge, *x*, is a full register
+	 * 64-bit range, needs special treatment to take into account upper 32
+	 * bits of full register range
+	 */
+	if (t_is_32(y_t) && !t_is_32(x_t)) {
+		struct range x_swap;
+
+		/* some combinations of upper 32 bits and sign bit can lead to
+		 * invalid ranges, in such cases it's easier to detect them
+		 * after cast/swap than try to enumerate all the conditions
+		 * under which transformation and knowledge transfer is valid
+		 */
+		x_swap =3D range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cas=
t.b));
+		if (!is_valid_range(x_t, x_swap))
+			return x;
+		return range_improve(x_t, x, x_swap);
+	}
+
+	/* otherwise, plain range cast and intersection works */
+	return range_improve(x_t, x, y_cast);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * GENERIC CONDITIONAL OPS
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+enum op { OP_LT, OP_LE, OP_GT, OP_GE, OP_EQ, OP_NE, first_op =3D OP_LT, =
last_op =3D OP_NE };
+
+static enum op complement_op(enum op op)
+{
+	switch (op) {
+	case OP_LT: return OP_GE;
+	case OP_LE: return OP_GT;
+	case OP_GT: return OP_LE;
+	case OP_GE: return OP_LT;
+	case OP_EQ: return OP_NE;
+	case OP_NE: return OP_EQ;
+	default: printf("complement_op!\n"); exit(1);
+	}
+}
+
+static const char *op_str(enum op op)
+{
+	switch (op) {
+	case OP_LT: return "<";
+	case OP_LE: return "<=3D";
+	case OP_GT: return ">";
+	case OP_GE: return ">=3D";
+	case OP_EQ: return "=3D=3D";
+	case OP_NE: return "!=3D";
+	default: printf("op_str!\n"); exit(1);
+	}
+}
+
+/* Can register with range [x.a, x.b] *EVER* satisfy
+ * OP (<, <=3D, >, >=3D, =3D=3D, !=3D) relation to
+ * a regsiter with range [y.a, y.b]
+ * _in *num_t* domain_
+ */
+static bool range_canbe_op(enum num_t t, struct range x, struct range y,=
 enum op op)
+{
+#define range_canbe(T) do {									\
+	switch (op) {										\
+	case OP_LT: return (T)x.a < (T)y.b;							\
+	case OP_LE: return (T)x.a <=3D (T)y.b;							\
+	case OP_GT: return (T)x.b > (T)y.a;							\
+	case OP_GE: return (T)x.b >=3D (T)y.a;							\
+	case OP_EQ: return (T)max_t(t, x.a, y.a) <=3D (T)min_t(t, x.b, y.b);			=
\
+	case OP_NE: return !((T)x.a =3D=3D (T)x.b && (T)y.a =3D=3D (T)y.b && (T=
)x.a =3D=3D (T)y.a);		\
+	default: printf("range_canbe op %d\n", op); exit(1);					\
+	}											\
+} while (0)
+
+	switch (t) {
+	case U64: { range_canbe(u64); }
+	case U32: { range_canbe(u32); }
+	case S64: { range_canbe(s64); }
+	case S32: { range_canbe(s32); }
+	default: printf("range_canbe!\n"); exit(1);
+	}
+#undef range_canbe
+}
+
+/* Does register with range [x.a, x.b] *ALWAYS* satisfy
+ * OP (<, <=3D, >, >=3D, =3D=3D, !=3D) relation to
+ * a regsiter with range [y.a, y.b]
+ * _in *num_t* domain_
+ */
+static bool range_always_op(enum num_t t, struct range x, struct range y=
, enum op op)
+{
+	/* always op <=3D> ! canbe complement(op) */
+	return !range_canbe_op(t, x, y, complement_op(op));
+}
+
+/* Does register with range [x.a, x.b] *NEVER* satisfy
+ * OP (<, <=3D, >, >=3D, =3D=3D, !=3D) relation to
+ * a regsiter with range [y.a, y.b]
+ * _in *num_t* domain_
+ */
+static bool range_never_op(enum num_t t, struct range x, struct range y,=
 enum op op)
+{
+	return !range_canbe_op(t, x, y, op);
+}
+
+/* similar to verifier's is_branch_taken():
+ *    1 - always taken;
+ *    0 - never taken,
+ *   -1 - unsure.
+ */
+static int range_branch_taken_op(enum num_t t, struct range x, struct ra=
nge y, enum op op)
+{
+	if (range_always_op(t, x, y, op))
+		return 1;
+	if (range_never_op(t, x, y, op))
+		return 0;
+	return -1;
+}
+
+/* What would be the new estimates for register x and y ranges assuming =
truthful
+ * OP comparison between them. I.e., (x OP y =3D=3D true) =3D> x <- newx=
, y <- newy.
+ *
+ * We assume "interesting" cases where ranges overlap. Cases where it's
+ * obvious that (x OP y) is either always true or false should be filter=
ed with
+ * range_never and range_always checks.
+ */
+static void range_cond(enum num_t t, struct range x, struct range y,
+		       enum op op, struct range *newx, struct range *newy)
+{
+	if (!range_canbe_op(t, x, y, op)) {
+		/* nothing to adjust, can't happen, return original values */
+		*newx =3D x;
+		*newy =3D y;
+		return;
+	}
+	switch (op) {
+	case OP_LT:
+		*newx =3D range(t, x.a, min_t(t, x.b, y.b - 1));
+		*newy =3D range(t, max_t(t, x.a + 1, y.a), y.b);
+		break;
+	case OP_LE:
+		*newx =3D range(t, x.a, min_t(t, x.b, y.b));
+		*newy =3D range(t, max_t(t, x.a, y.a), y.b);
+		break;
+	case OP_GT:
+		*newx =3D range(t, max_t(t, x.a, y.a + 1), x.b);
+		*newy =3D range(t, y.a, min_t(t, x.b - 1, y.b));
+		break;
+	case OP_GE:
+		*newx =3D range(t, max_t(t, x.a, y.a), x.b);
+		*newy =3D range(t, y.a, min_t(t, x.b, y.b));
+		break;
+	case OP_EQ:
+		*newx =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
+		*newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
+		break;
+	case OP_NE:
+		/* generic case, can't derive more information */
+		*newx =3D range(t, x.a, x.b);
+		*newy =3D range(t, y.a, y.b);
+		break;
+
+		/* below extended logic is not supported by verifier just yet */
+		if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
+			/* X is a constant matching left side of Y */
+			*newx =3D range(t, x.a, x.b);
+			*newy =3D range(t, y.a + 1, y.b);
+		} else if (x.a =3D=3D x.b && x.b =3D=3D y.b) {
+			/* X is a constant matching rigth side of Y */
+			*newx =3D range(t, x.a, x.b);
+			*newy =3D range(t, y.a, y.b - 1);
+		} else if (y.a =3D=3D y.b && x.a =3D=3D y.a) {
+			/* Y is a constant matching left side of X */
+			*newx =3D range(t, x.a + 1, x.b);
+			*newy =3D range(t, y.a, y.b);
+		} else if (y.a =3D=3D y.b && x.b =3D=3D y.b) {
+			/* Y is a constant matching rigth side of X */
+			*newx =3D range(t, x.a, x.b - 1);
+			*newy =3D range(t, y.a, y.b);
+		} else {
+			/* generic case, can't derive more information */
+			*newx =3D range(t, x.a, x.b);
+			*newy =3D range(t, y.a, y.b);
+		}
+
+		break;
+	default:
+		break;
+	}
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * REGISTER STATE HANDLING
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+struct reg_state {
+	struct range r[4]; /* indexed by enum num_t: U64, U32, S64, S32 */
+	bool valid;
+};
+
+static void print_reg_state(struct reg_state *r, const char *sfx)
+{
+	DEFINE_STRBUF(sb, 512);
+	enum num_t t;
+	int cnt =3D 0;
+
+	if (!r->valid) {
+		printf("<not found>%s", sfx);
+		return;
+	}
+
+	snappendf(sb, "scalar(");
+	for (t =3D first_t; t <=3D last_t; t++) {
+		snappendf(sb, "%s%s=3D", cnt++ ? "," : "", t_str(t));
+		snprintf_range(t, sb, r->r[t]);
+	}
+	snappendf(sb, ")");
+
+	printf("%s%s", sb->buf, sfx);
+}
+
+static void print_refinement(enum num_t s_t, struct range src,
+			     enum num_t d_t, struct range old, struct range new,
+			     const char *ctx)
+{
+	printf("REFINING (%s) (%s)SRC=3D", ctx, t_str(s_t));
+	print_range(s_t, src, "");
+	printf(" (%s)DST_OLD=3D", t_str(d_t));
+	print_range(d_t, old, "");
+	printf(" (%s)DST_NEW=3D", t_str(d_t));
+	print_range(d_t, new, "\n");
+}
+
+static void reg_state_refine(struct reg_state *r, enum num_t t, struct r=
ange x, const char *ctx)
+{
+	enum num_t d_t, s_t;
+	struct range old;
+	bool keep_going =3D false;
+
+again:
+	/* try to derive new knowledge from just learned range x of type t */
+	for (d_t =3D first_t; d_t <=3D last_t; d_t++) {
+		old =3D r->r[d_t];
+		r->r[d_t] =3D range_refine(d_t, r->r[d_t], t, x);
+		if (!range_eq(r->r[d_t], old)) {
+			keep_going =3D true;
+			if (env.verbosity >=3D VERBOSE_VERY)
+				print_refinement(t, x, d_t, old, r->r[d_t], ctx);
+		}
+	}
+
+	/* now see if we can derive anything new from updated reg_state's range=
s */
+	for (s_t =3D first_t; s_t <=3D last_t; s_t++) {
+		for (d_t =3D first_t; d_t <=3D last_t; d_t++) {
+			old =3D r->r[d_t];
+			r->r[d_t] =3D range_refine(d_t, r->r[d_t], s_t, r->r[s_t]);
+			if (!range_eq(r->r[d_t], old)) {
+				keep_going =3D true;
+				if (env.verbosity >=3D VERBOSE_VERY)
+					print_refinement(s_t, r->r[s_t], d_t, old, r->r[d_t], ctx);
+			}
+		}
+	}
+
+	/* keep refining until we converge */
+	if (keep_going) {
+		keep_going =3D false;
+		goto again;
+	}
+}
+
+static void reg_state_set_const(struct reg_state *rs, enum num_t t, u64 =
val)
+{
+	enum num_t tt;
+
+	rs->valid =3D true;
+	for (tt =3D first_t; tt <=3D last_t; tt++)
+		rs->r[tt] =3D tt =3D=3D t ? range(t, val, val) : unkn[tt];
+
+	reg_state_refine(rs, t, rs->r[t], "CONST");
+}
+
+static void reg_state_cond(enum num_t t, struct reg_state *x, struct reg=
_state *y, enum op op,
+			   struct reg_state *newx, struct reg_state *newy, const char *ctx)
+{
+	char buf[32];
+	enum num_t ts[2];
+	struct reg_state xx =3D *x, yy =3D *y;
+	int i, t_cnt;
+	struct range z1, z2;
+
+	if (op =3D=3D OP_EQ || op =3D=3D OP_NE) {
+		/* OP_EQ and OP_NE are sign-agnostic, so we need to process
+		 * both signed and unsigned domains at the same time
+		 */
+		ts[0] =3D t_unsigned(t);
+		ts[1] =3D t_signed(t);
+		t_cnt =3D 2;
+	} else {
+		ts[0] =3D t;
+		t_cnt =3D 1;
+	}
+
+	for (i =3D 0; i < t_cnt; i++) {
+		t =3D ts[i];
+		z1 =3D x->r[t];
+		z2 =3D y->r[t];
+
+		range_cond(t, z1, z2, op, &z1, &z2);
+
+		if (newx) {
+			snprintf(buf, sizeof(buf), "%s R1", ctx);
+			reg_state_refine(&xx, t, z1, buf);
+		}
+		if (newy) {
+			snprintf(buf, sizeof(buf), "%s R2", ctx);
+			reg_state_refine(&yy, t, z2, buf);
+		}
+	}
+
+	if (newx)
+		*newx =3D xx;
+	if (newy)
+		*newy =3D yy;
+}
+
+static int reg_state_branch_taken_op(enum num_t t, struct reg_state *x, =
struct reg_state *y,
+				     enum op op)
+{
+	if (op =3D=3D OP_EQ || op =3D=3D OP_NE) {
+		/* OP_EQ and OP_NE are sign-agnostic */
+		enum num_t tu =3D t_unsigned(t);
+		enum num_t ts =3D t_signed(t);
+		int br_u, br_s;
+
+		br_u =3D range_branch_taken_op(tu, x->r[tu], y->r[tu], op);
+		br_s =3D range_branch_taken_op(ts, x->r[ts], y->r[ts], op);
+
+		if (br_u >=3D 0 && br_s >=3D 0 && br_u !=3D br_s)
+			ASSERT_FALSE(true, "branch taken inconsistency!\n");
+		if (br_u >=3D 0)
+			return br_u;
+		return br_s;
+	}
+	return range_branch_taken_op(t, x->r[t], y->r[t], op);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * BPF PROGS GENERATION AND VERIFICATION
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+struct case_spec {
+	/* whether to init full register (r1) or sub-register (w1) */
+	bool init_subregs;
+	/* whether to establish initial value range on full register (r1) or
+	 * sub-register (w1)
+	 */
+	bool setup_subregs;
+	/* whether to establish initial value range using signed or unsigned
+	 * comparisons (i.e., initialize umin/umax or smin/smax directly)
+	 */
+	bool setup_signed;
+	/* whether to perform comparison on full registers or sub-registers */
+	bool compare_subregs;
+	/* whether to perform comparison using signed or unsigned operations */
+	bool compare_signed;
+};
+
+/* Generate test BPF program based on provided test ranges, operation, a=
nd
+ * specifications about register bitness and signedness.
+ */
+static int load_range_cmp_prog(struct range x, struct range y, enum op o=
p,
+			       int branch_taken, struct case_spec spec,
+			       char *log_buf, size_t log_sz,
+			       int *false_pos, int *true_pos)
+{
+#define emit(insn) ({							\
+	struct bpf_insn __insns[] =3D { insn };				\
+	int __i;							\
+	for (__i =3D 0; __i < ARRAY_SIZE(__insns); __i++)			\
+		insns[cur_pos + __i] =3D __insns[__i];			\
+	cur_pos +=3D __i;							\
+})
+#define JMP_TO(target) (target - cur_pos - 1)
+	int cur_pos =3D 0, exit_pos, fd, op_code;
+	struct bpf_insn insns[64];
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_level =3D 2,
+		.log_buf =3D log_buf,
+		.log_size =3D log_sz,
+	);
+
+	/* ; skip exit block below
+	 * goto +2;
+	 */
+	emit(BPF_JMP_A(2));
+	exit_pos =3D cur_pos;
+	/* ; exit block for all the preparatory conditionals
+	 * out:
+	 * r0 =3D 0;
+	 * exit;
+	 */
+	emit(BPF_MOV64_IMM(BPF_REG_0, 0));
+	emit(BPF_EXIT_INSN());
+	/*
+	 * ; assign r6/w6 and r7/w7 unpredictable u64/u32 value
+	 * call bpf_get_current_pid_tgid;
+	 * r6 =3D r0;               | w6 =3D w0;
+	 * call bpf_get_current_pid_tgid;
+	 * r7 =3D r0;               | w7 =3D w0;
+	 */
+	emit(BPF_EMIT_CALL(BPF_FUNC_get_current_pid_tgid));
+	if (spec.init_subregs)
+		emit(BPF_MOV32_REG(BPF_REG_6, BPF_REG_0));
+	else
+		emit(BPF_MOV64_REG(BPF_REG_6, BPF_REG_0));
+	emit(BPF_EMIT_CALL(BPF_FUNC_get_current_pid_tgid));
+	if (spec.init_subregs)
+		emit(BPF_MOV32_REG(BPF_REG_7, BPF_REG_0));
+	else
+		emit(BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	/* ; setup initial r6/w6 possible value range ([x.a, x.b])
+	 * r1 =3D %[x.a] ll;        | w1 =3D %[x.a];
+	 * r2 =3D %[x.b] ll;        | w2 =3D %[x.b];
+	 * if r6 < r1 goto out;   | if w6 < w1 goto out;
+	 * if r6 > r2 goto out;   | if w6 > w2 goto out;
+	 */
+	if (spec.setup_subregs) {
+		emit(BPF_MOV32_IMM(BPF_REG_1, (s32)x.a));
+		emit(BPF_MOV32_IMM(BPF_REG_2, (s32)x.b));
+		emit(BPF_JMP32_REG(spec.setup_signed ? BPF_JSLT : BPF_JLT,
+				   BPF_REG_6, BPF_REG_1, JMP_TO(exit_pos)));
+		emit(BPF_JMP32_REG(spec.setup_signed ? BPF_JSGT : BPF_JGT,
+				   BPF_REG_6, BPF_REG_2, JMP_TO(exit_pos)));
+	} else {
+		emit(BPF_LD_IMM64(BPF_REG_1, x.a));
+		emit(BPF_LD_IMM64(BPF_REG_2, x.b));
+		emit(BPF_JMP_REG(spec.setup_signed ? BPF_JSLT : BPF_JLT,
+				 BPF_REG_6, BPF_REG_1, JMP_TO(exit_pos)));
+		emit(BPF_JMP_REG(spec.setup_signed ? BPF_JSGT : BPF_JGT,
+				 BPF_REG_6, BPF_REG_2, JMP_TO(exit_pos)));
+	}
+	/* ; setup initial r7/w7 possible value range ([y.a, y.b])
+	 * r1 =3D %[y.a] ll;        | w1 =3D %[y.a];
+	 * r2 =3D %[y.b] ll;        | w2 =3D %[y.b];
+	 * if r7 < r1 goto out;   | if w7 < w1 goto out;
+	 * if r7 > r2 goto out;   | if w7 > w2 goto out;
+	 */
+	if (spec.setup_subregs) {
+		emit(BPF_MOV32_IMM(BPF_REG_1, (s32)y.a));
+		emit(BPF_MOV32_IMM(BPF_REG_2, (s32)y.b));
+		emit(BPF_JMP32_REG(spec.setup_signed ? BPF_JSLT : BPF_JLT,
+				   BPF_REG_7, BPF_REG_1, JMP_TO(exit_pos)));
+		emit(BPF_JMP32_REG(spec.setup_signed ? BPF_JSGT : BPF_JGT,
+				   BPF_REG_7, BPF_REG_2, JMP_TO(exit_pos)));
+	} else {
+		emit(BPF_LD_IMM64(BPF_REG_1, y.a));
+		emit(BPF_LD_IMM64(BPF_REG_2, y.b));
+		emit(BPF_JMP_REG(spec.setup_signed ? BPF_JSLT : BPF_JLT,
+				 BPF_REG_7, BPF_REG_1, JMP_TO(exit_pos)));
+		emit(BPF_JMP_REG(spec.setup_signed ? BPF_JSGT : BPF_JGT,
+				 BPF_REG_7, BPF_REG_2, JMP_TO(exit_pos)));
+	}
+	/* ; range test instruction
+	 * if r6 <op> r7 goto +3; | if w6 <op> w7 goto +3;
+	 */
+	switch (op) {
+	case OP_LT: op_code =3D spec.compare_signed ? BPF_JSLT : BPF_JLT; break=
;
+	case OP_LE: op_code =3D spec.compare_signed ? BPF_JSLE : BPF_JLE; break=
;
+	case OP_GT: op_code =3D spec.compare_signed ? BPF_JSGT : BPF_JGT; break=
;
+	case OP_GE: op_code =3D spec.compare_signed ? BPF_JSGE : BPF_JGE; break=
;
+	case OP_EQ: op_code =3D BPF_JEQ; break;
+	case OP_NE: op_code =3D BPF_JNE; break;
+	default:
+		printf("unrecognized op %d\n", op);
+		return -ENOTSUP;
+	}
+	/* ; BEFORE conditional, r0/w0 =3D {r6/w6,r7/w7} is to extract verifier=
 state reliably
+	 * ; this is used for debugging, as verifier doesn't always print
+	 * ; registers states as of condition jump instruction (e.g., when
+	 * ; precision marking happens)
+	 * r0 =3D r6;               | w0 =3D w6;
+	 * r0 =3D r7;               | w0 =3D w7;
+	 */
+	if (spec.compare_subregs) {
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_7));
+	} else {
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	}
+	if (spec.compare_subregs)
+		emit(BPF_JMP32_REG(op_code, BPF_REG_6, BPF_REG_7, 3));
+	else
+		emit(BPF_JMP_REG(op_code, BPF_REG_6, BPF_REG_7, 3));
+	/* ; FALSE branch, r0/w0 =3D {r6/w6,r7/w7} is to extract verifier state=
 reliably
+	 * r0 =3D r6;               | w0 =3D w6;
+	 * r0 =3D r7;               | w0 =3D w7;
+	 * exit;
+	 */
+	*false_pos =3D cur_pos;
+	if (spec.compare_subregs) {
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_7));
+	} else {
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	}
+	if (branch_taken =3D=3D 1) /* false branch is never taken */
+		emit(BPF_EMIT_CALL(0xDEAD)); /* poison this branch */
+	else
+		emit(BPF_EXIT_INSN());
+	/* ; TRUE branch, r0/w0 =3D {r6/w6,r7/w7} is to extract verifier state =
reliably
+	 * r0 =3D r6;               | w0 =3D w6;
+	 * r0 =3D r7;               | w0 =3D w7;
+	 * exit;
+	 */
+	*true_pos =3D cur_pos;
+	if (spec.compare_subregs) {
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV32_REG(BPF_REG_0, BPF_REG_7));
+	} else {
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_6));
+		emit(BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	}
+	if (branch_taken =3D=3D 0) /* true branch is never taken */
+		emit(BPF_EMIT_CALL(0xDEAD)); /* poison this branch */
+	emit(BPF_EXIT_INSN()); /* last instruction has to be exit */
+
+	fd =3D bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "reg_bounds_test",
+			   "GPL", insns, cur_pos, &opts);
+	if (fd < 0)
+		return fd;
+
+	close(fd);
+	return 0;
+#undef emit
+#undef JMP_TO
+}
+
+#define str_has_pfx(str, pfx) (strncmp(str, pfx, strlen(pfx)) =3D=3D 0)
+
+/* Parse register state from verifier log.
+ * `s` should point to the start of "Rx =3D ..." substring in the verifi=
er log.
+ */
+static int parse_reg_state(const char *s, struct reg_state *reg)
+{
+	/* There are two generic forms for SCALAR register:
+	 * - known constant: R6_rwD=3DP%lld
+	 * - range: R6_rwD=3Dscalar(id=3D1,...), where "..." is a comma-separat=
ed
+	 *   list of optional range specifiers:
+	 *     - umin=3D%llu, if missing, assumed 0;
+	 *     - umax=3D%llu, if missing, assumed U64_MAX;
+	 *     - smin=3D%lld, if missing, assumed S64_MIN;
+	 *     - smax=3D%lld, if missing, assummed S64_MAX;
+	 *     - umin32=3D%d, if missing, assumed 0;
+	 *     - umax32=3D%d, if missing, assumed U32_MAX;
+	 *     - smin32=3D%d, if missing, assumed S32_MIN;
+	 *     - smax32=3D%d, if missing, assummed S32_MAX;
+	 *     - var_off=3D(%#llx; %#llx), tnum part, we don't care about it.
+	 *
+	 * If some of the values are equal, they will be grouped (but min/max
+	 * are not mixed together, and similarly negative values are not
+	 * grouped with non-negative ones). E.g.:
+	 *
+	 *   R6_w=3DPscalar(smin=3Dsmin32=3D0, smax=3Dumax=3Dumax32=3D1000)
+	 *
+	 * _rwD part is optional (and any of the letters can be missing).
+	 * P (precision mark) is optional as well.
+	 *
+	 * Anything inside scalar() is optional, including id, of course.
+	 */
+	struct {
+		const char *pfx;
+		const char *fmt;
+		u64 *dst, def;
+		bool is_32, is_set;
+	} *f, fields[8] =3D {
+		{"smin=3D", "%lld", &reg->r[S64].a, S64_MIN},
+		{"smax=3D", "%lld", &reg->r[S64].b, S64_MAX},
+		{"umin=3D", "%llu", &reg->r[U64].a, 0},
+		{"umax=3D", "%llu", &reg->r[U64].b, U64_MAX},
+		{"smin32=3D", "%lld", &reg->r[S32].a, (u32)S32_MIN, true},
+		{"smax32=3D", "%lld", &reg->r[S32].b, (u32)S32_MAX, true},
+		{"umin32=3D", "%llu", &reg->r[U32].a, 0,            true},
+		{"umax32=3D", "%llu", &reg->r[U32].b, U32_MAX,      true},
+	};
+	const char *p, *fmt;
+	int i;
+
+	p =3D strchr(s, '=3D');
+	if (!p)
+		return -EINVAL;
+	p++;
+	if (*p =3D=3D 'P')
+		p++;
+
+	if (!str_has_pfx(p, "scalar(")) {
+		long long sval;
+		enum num_t t;
+
+		if (sscanf(p, "%lld", &sval) !=3D 1)
+			return -EINVAL;
+
+		reg->valid =3D true;
+		for (t =3D first_t; t <=3D last_t; t++) {
+			reg->r[t] =3D range(t, sval, sval);
+		}
+		return 0;
+	}
+
+	p +=3D sizeof("scalar");
+	while (p) {
+		int midxs[ARRAY_SIZE(fields)], mcnt =3D 0;
+		u64 val;
+
+		for (i =3D 0; i < ARRAY_SIZE(fields); i++) {
+			f =3D &fields[i];
+			if (!str_has_pfx(p, f->pfx))
+				continue;
+			midxs[mcnt++] =3D i;
+			p +=3D strlen(f->pfx);
+		}
+
+		if (mcnt) {
+			/* populate all matched fields */
+			fmt =3D fields[midxs[0]].fmt;
+			if (sscanf(p, fmt, &val) !=3D 1)
+				return -EINVAL;
+
+			for (i =3D 0; i < mcnt; i++) {
+				f =3D &fields[midxs[i]];
+				f->is_set =3D true;
+				*f->dst =3D f->is_32 ? (u64)(u32)val : val;
+			}
+		} else if (str_has_pfx(p, "var_off")) {
+			/* skip "var_off=3D(0x0; 0x3f)" part completely */
+			p =3D strchr(p, ')');
+			if (!p)
+				return -EINVAL;
+			p++;
+		}
+
+		p =3D strpbrk(p, ",)");
+		if (*p =3D=3D ')')
+			break;
+		if (p)
+			p++;
+	}
+
+	reg->valid =3D true;
+
+	for (i =3D 0; i < ARRAY_SIZE(fields); i++) {
+		f =3D &fields[i];
+		if (!f->is_set)
+			*f->dst =3D f->def;
+	}
+
+	return 0;
+}
+
+
+/* Parse all register states (TRUE/FALSE branches and DST/SRC registers)
+ * out of the verifier log for a corresponding test case BPF program.
+ */
+static int parse_range_cmp_log(const char *log_buf, struct case_spec spe=
c,
+			       int false_pos, int true_pos,
+			       struct reg_state *false1_reg, struct reg_state *false2_reg,
+			       struct reg_state *true1_reg, struct reg_state *true2_reg)
+{
+	struct {
+		int insn_idx;
+		int reg_idx;
+		const char *reg_upper;
+		struct reg_state *state;
+	} specs[] =3D {
+		{false_pos,     6, "R6=3D", false1_reg},
+		{false_pos + 1, 7, "R7=3D", false2_reg},
+		{true_pos,      6, "R6=3D", true1_reg},
+		{true_pos + 1,  7, "R7=3D", true2_reg},
+	};
+	char buf[32];
+	const char *p =3D log_buf, *q;
+	int i, err;
+
+	for (i =3D 0; i < 4; i++) {
+		sprintf(buf, "%d: (%s) %s =3D %s%d", specs[i].insn_idx,
+			spec.compare_subregs ? "bc" : "bf",
+			spec.compare_subregs ? "w0" : "r0",
+			spec.compare_subregs ? "w" : "r", specs[i].reg_idx);
+
+		q =3D strstr(p, buf);
+		if (!q) {
+			*specs[i].state =3D (struct reg_state){.valid =3D false};
+			continue;
+		}
+		p =3D strstr(q, specs[i].reg_upper);
+		if (!p)
+			return -EINVAL;
+		err =3D parse_reg_state(p, specs[i].state);
+		if (err)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/* Validate ranges match, and print details if they don't */
+static bool assert_range_eq(enum num_t t, struct range x, struct range y=
,
+			    const char *ctx1, const char *ctx2)
+{
+	DEFINE_STRBUF(sb, 512);
+
+	if (range_eq(x, y))
+		return true;
+
+	snappendf(sb, "MISMATCH %s.%s: ", ctx1, ctx2);
+	snprintf_range(t, sb, x);
+	snappendf(sb, " !=3D ");
+	snprintf_range(t, sb, y);
+
+	printf("%s\n", sb->buf);
+
+	return false;
+}
+
+/* Validate that register states match, and print details if they don't =
*/
+static bool assert_reg_state_eq(struct reg_state *r, struct reg_state *e=
, const char *ctx)
+{
+	bool ok =3D true;
+	enum num_t t;
+
+	if (r->valid !=3D e->valid) {
+		printf("MISMATCH %s: actual %s !=3D expected %s\n", ctx,
+		       r->valid ? "<valid>" : "<invalid>",
+		       e->valid ? "<valid>" : "<invalid>");
+		return false;
+	}
+
+	if (!r->valid)
+		return true;
+
+	for (t =3D first_t; t <=3D last_t; t++) {
+		if (!assert_range_eq(t, r->r[t], e->r[t], ctx, t_str(t)))
+			ok =3D false;
+	}
+
+	return ok;
+}
+
+/* Printf verifier log, filtering out irrelevant noise */
+static void print_verifier_log(const char *buf)
+{
+	const char *p;
+
+	while (buf[0]) {
+		p =3D strchrnul(buf, '\n');
+
+		/* filter out irrelevant precision backtracking logs */
+		if (str_has_pfx(buf, "mark_precise: "))
+			goto skip_line;
+
+		printf("%.*s\n", (int)(p - buf), buf);
+
+skip_line:
+		buf =3D *p =3D=3D '\0' ? p : p + 1;
+	}
+}
+
+/* Simulate provided test case purely with our own range-based logic.
+ * This is done to set up expectations for verifier's branch_taken logic=
 and
+ * verifier's register states in the verifier log.
+ */
+static void sim_case(enum num_t init_t, enum num_t cond_t,
+		     struct range x, struct range y, enum op op,
+		     struct reg_state *fr1, struct reg_state *fr2,
+		     struct reg_state *tr1, struct reg_state *tr2,
+		     int *branch_taken)
+{
+	const u64 A =3D x.a;
+	const u64 B =3D x.b;
+	const u64 C =3D y.a;
+	const u64 D =3D y.b;
+	struct reg_state rc;
+	enum op rev_op =3D complement_op(op);
+	enum num_t t;
+
+	fr1->valid =3D fr2->valid =3D true;
+	tr1->valid =3D tr2->valid =3D true;
+	for (t =3D first_t; t <=3D last_t; t++) {
+		/* if we are initializing using 32-bit subregisters,
+		 * full registers get upper 32 bits zeroed automatically
+		 */
+		struct range z =3D t_is_32(init_t) ? unkn_subreg(t) : unkn[t];
+
+		fr1->r[t] =3D fr2->r[t] =3D tr1->r[t] =3D tr2->r[t] =3D z;
+	}
+
+	/* step 1: r1 >=3D A, r2 >=3D C */
+	reg_state_set_const(&rc, init_t, A);
+	reg_state_cond(init_t, fr1, &rc, OP_GE, fr1, NULL, "r1>=3DA");
+	reg_state_set_const(&rc, init_t, C);
+	reg_state_cond(init_t, fr2, &rc, OP_GE, fr2, NULL, "r2>=3DC");
+	*tr1 =3D *fr1;
+	*tr2 =3D *fr2;
+	if (env.verbosity >=3D VERBOSE_VERY) {
+		printf("STEP1 (%s) R1: ", t_str(init_t)); print_reg_state(fr1, "\n");
+		printf("STEP1 (%s) R2: ", t_str(init_t)); print_reg_state(fr2, "\n");
+	}
+
+	/* step 2: r1 <=3D B, r2 <=3D D */
+	reg_state_set_const(&rc, init_t, B);
+	reg_state_cond(init_t, fr1, &rc, OP_LE, fr1, NULL, "r1<=3DB");
+	reg_state_set_const(&rc, init_t, D);
+	reg_state_cond(init_t, fr2, &rc, OP_LE, fr2, NULL, "r2<=3DD");
+	*tr1 =3D *fr1;
+	*tr2 =3D *fr2;
+	if (env.verbosity >=3D VERBOSE_VERY) {
+		printf("STEP2 (%s) R1: ", t_str(init_t)); print_reg_state(fr1, "\n");
+		printf("STEP2 (%s) R2: ", t_str(init_t)); print_reg_state(fr2, "\n");
+	}
+
+	/* step 3: r1 <op> r2 */
+	*branch_taken =3D reg_state_branch_taken_op(cond_t, fr1, fr2, op);
+	fr1->valid =3D fr2->valid =3D false;
+	tr1->valid =3D tr2->valid =3D false;
+	if (*branch_taken !=3D 1) { /* FALSE is possible */
+		fr1->valid =3D fr2->valid =3D true;
+		reg_state_cond(cond_t, fr1, fr2, rev_op, fr1, fr2, "FALSE");
+	}
+	if (*branch_taken !=3D 0) { /* TRUE is possible */
+		tr1->valid =3D tr2->valid =3D true;
+		reg_state_cond(cond_t, tr1, tr2, op, tr1, tr2, "TRUE");
+	}
+	if (env.verbosity >=3D VERBOSE_VERY) {
+		printf("STEP3 (%s) FALSE R1:", t_str(cond_t)); print_reg_state(fr1, "\=
n");
+		printf("STEP3 (%s) FALSE R2:", t_str(cond_t)); print_reg_state(fr2, "\=
n");
+		printf("STEP3 (%s) TRUE  R1:", t_str(cond_t)); print_reg_state(tr1, "\=
n");
+		printf("STEP3 (%s) TRUE  R2:", t_str(cond_t)); print_reg_state(tr2, "\=
n");
+	}
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+ * HIGH-LEVEL TEST CASE VALIDATION
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+static u32 upper_seeds[] =3D {
+	0,
+	1,
+	U32_MAX,
+	U32_MAX - 1,
+	S32_MAX,
+	(u32)S32_MIN,
+};
+
+static u32 lower_seeds[] =3D {
+	0,
+	1,
+	2, (u32)-2,
+	255, (u32)-255,
+	UINT_MAX,
+	UINT_MAX - 1,
+	INT_MAX,
+	(u32)INT_MIN,
+};
+
+struct ctx {
+	int val_cnt, subval_cnt, range_cnt, subrange_cnt;
+	u64 uvals[ARRAY_SIZE(upper_seeds) * ARRAY_SIZE(lower_seeds)];
+	s64 svals[ARRAY_SIZE(upper_seeds) * ARRAY_SIZE(lower_seeds)];
+	u32 usubvals[ARRAY_SIZE(lower_seeds)];
+	s32 ssubvals[ARRAY_SIZE(lower_seeds)];
+	struct range *uranges, *sranges;
+	struct range *usubranges, *ssubranges;
+	int max_failure_cnt, cur_failure_cnt;
+	int total_case_cnt, case_cnt;
+	__u64 start_ns;
+	char progress_ctx[32];
+};
+
+static void cleanup_ctx(struct ctx *ctx)
+{
+	free(ctx->uranges);
+	free(ctx->sranges);
+	free(ctx->usubranges);
+	free(ctx->ssubranges);
+}
+
+struct subtest_case {
+	enum num_t init_t;
+	enum num_t cond_t;
+	struct range x;
+	struct range y;
+	enum op op;
+};
+
+static void subtest_case_str(struct strbuf *sb, struct subtest_case *t)
+{
+	snappendf(sb, "(%s)", t_str(t->init_t));
+	snprintf_range(t->init_t, sb, t->x);
+	snappendf(sb, " (%s)%s ", t_str(t->cond_t), op_str(t->op));
+	snprintf_range(t->init_t, sb, t->y);
+}
+
+/* Generate and validate test case based on specific combination of setu=
p
+ * register ranges (including their expected num_t domain), and conditio=
nal
+ * operation to perform (including num_t domain in which it has to be
+ * performed)
+ */
+static int verify_case_op(enum num_t init_t, enum num_t cond_t,
+			  struct range x, struct range y, enum op op)
+{
+	char log_buf[256 * 1024];
+	size_t log_sz =3D sizeof(log_buf);
+	int err, false_pos =3D 0, true_pos =3D 0, branch_taken;
+	struct reg_state fr1, fr2, tr1, tr2;
+	struct reg_state fe1, fe2, te1, te2;
+	bool failed =3D false;
+	struct case_spec spec =3D {
+		.init_subregs =3D (init_t =3D=3D U32 || init_t =3D=3D S32),
+		.setup_subregs =3D (init_t =3D=3D U32 || init_t =3D=3D S32),
+		.setup_signed =3D (init_t =3D=3D S64 || init_t =3D=3D S32),
+		.compare_subregs =3D (cond_t =3D=3D U32 || cond_t =3D=3D S32),
+		.compare_signed =3D (cond_t =3D=3D S64 || cond_t =3D=3D S32),
+	};
+
+	log_buf[0] =3D '\0';
+
+	sim_case(init_t, cond_t, x, y, op, &fe1, &fe2, &te1, &te2, &branch_take=
n);
+
+	err =3D load_range_cmp_prog(x, y, op, branch_taken, spec,
+				  log_buf, log_sz, &false_pos, &true_pos);
+	if (err) {
+		ASSERT_OK(err, "load_range_cmp_prog");
+		failed =3D true;
+	}
+
+	err =3D parse_range_cmp_log(log_buf, spec, false_pos, true_pos,
+				  &fr1, &fr2, &tr1, &tr2);
+	if (err) {
+		ASSERT_OK(err, "parse_range_cmp_log");
+		failed =3D true;
+	}
+
+	if (!assert_reg_state_eq(&fr1, &fe1, "false_reg1") ||
+	    !assert_reg_state_eq(&fr2, &fe2, "false_reg2") ||
+	    !assert_reg_state_eq(&tr1, &te1, "true_reg1") ||
+	    !assert_reg_state_eq(&tr2, &te2, "true_reg2")) {
+		failed =3D true;
+	}
+
+	if (failed || env.verbosity >=3D VERBOSE_NORMAL) {
+		if (failed || env.verbosity >=3D VERBOSE_VERY) {
+			printf("VERIFIER LOG:\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");
+			print_verifier_log(log_buf);
+			printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
+		}
+		printf("ACTUAL   FALSE1: "); print_reg_state(&fr1, "\n");
+		printf("EXPECTED FALSE1: "); print_reg_state(&fe1, "\n");
+		printf("ACTUAL   FALSE2: "); print_reg_state(&fr2, "\n");
+		printf("EXPECTED FALSE2: "); print_reg_state(&fe2, "\n");
+		printf("ACTUAL   TRUE1:  "); print_reg_state(&tr1, "\n");
+		printf("EXPECTED TRUE1:  "); print_reg_state(&te1, "\n");
+		printf("ACTUAL   TRUE2:  "); print_reg_state(&tr2, "\n");
+		printf("EXPECTED TRUE2:  "); print_reg_state(&te2, "\n");
+
+		return failed ? -EINVAL : 0;
+	}
+
+	return 0;
+}
+
+/* Given setup ranges and number types, go over all supported operations=
,
+ * generating individual subtest for each allowed combination
+ */
+static int verify_case(struct ctx *ctx, enum num_t init_t, enum num_t co=
nd_t,
+		       struct range x, struct range y)
+{
+	DEFINE_STRBUF(sb, 256);
+	int err;
+	struct subtest_case sub =3D {
+		.init_t =3D init_t,
+		.cond_t =3D cond_t,
+		.x =3D x,
+		.y =3D y,
+	};
+
+	for (sub.op =3D first_op; sub.op <=3D last_op; sub.op++) {
+		sb->pos =3D 0; /* reset position in strbuf */
+		subtest_case_str(sb, &sub);
+		if (!test__start_subtest(sb->buf))
+			continue;
+
+		if (env.verbosity >=3D VERBOSE_NORMAL) /* this speeds up debugging */
+			printf("TEST CASE: %s\n", sb->buf);
+
+		err =3D verify_case_op(init_t, cond_t, x, y, sub.op);
+		if (err || env.verbosity >=3D VERBOSE_NORMAL)
+			ASSERT_OK(err, sb->buf);
+		if (err) {
+			ctx->cur_failure_cnt++;
+			if (ctx->cur_failure_cnt > ctx->max_failure_cnt)
+				return err;
+			return 0; /* keep testing other cases */
+		}
+		ctx->case_cnt++;
+		if ((ctx->case_cnt % 10000) =3D=3D 0) {
+			double progress =3D (ctx->case_cnt + 0.0) / ctx->total_case_cnt;
+			u64 elapsed_ns =3D get_time_ns() - ctx->start_ns;
+			double remain_ns =3D elapsed_ns / progress * (1 - progress);
+
+			fprintf(env.stderr, "PROGRESS (%s): %d/%d (%.2lf%%), "
+					    "elapsed %llu mins (%.2lf hrs), "
+					    "ETA %.0lf mins (%.2lf hrs)\n",
+				ctx->progress_ctx,
+				ctx->case_cnt, ctx->total_case_cnt, 100.0 * progress,
+				elapsed_ns / 1000000000 / 60,
+				elapsed_ns / 1000000000.0 / 3600,
+				remain_ns / 1000000000.0 / 60,
+				remain_ns / 1000000000.0 / 3600);
+		}
+	}
+
+	return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * GENERATED CASES FROM SEED VALUES
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+static int u64_cmp(const void *p1, const void *p2)
+{
+	u64 x1 =3D *(const u64 *)p1, x2 =3D *(const u64 *)p2;
+
+	return x1 !=3D x2 ? (x1 < x2 ? -1 : 1) : 0;
+}
+
+static int u32_cmp(const void *p1, const void *p2)
+{
+	u32 x1 =3D *(const u32 *)p1, x2 =3D *(const u32 *)p2;
+
+	return x1 !=3D x2 ? (x1 < x2 ? -1 : 1) : 0;
+}
+
+static int s64_cmp(const void *p1, const void *p2)
+{
+	s64 x1 =3D *(const s64 *)p1, x2 =3D *(const s64 *)p2;
+
+	return x1 !=3D x2 ? (x1 < x2 ? -1 : 1) : 0;
+}
+
+static int s32_cmp(const void *p1, const void *p2)
+{
+	s32 x1 =3D *(const s32 *)p1, x2 =3D *(const s32 *)p2;
+
+	return x1 !=3D x2 ? (x1 < x2 ? -1 : 1) : 0;
+}
+
+/* Generate valid unique constants from seeds, both signed and unsigned =
*/
+static void gen_vals(struct ctx *ctx)
+{
+	int i, j, cnt =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(upper_seeds); i++) {
+		for (j =3D 0; j < ARRAY_SIZE(lower_seeds); j++) {
+			ctx->uvals[cnt++] =3D (((u64)upper_seeds[i]) << 32) | lower_seeds[j];
+		}
+	}
+
+	/* sort and compact uvals (i.e., it's `sort | uniq`) */
+	qsort(ctx->uvals, cnt, sizeof(*ctx->uvals), u64_cmp);
+	for (i =3D 1, j =3D 0; i < cnt; i++) {
+		if (ctx->uvals[j] =3D=3D ctx->uvals[i])
+			continue;
+		j++;
+		ctx->uvals[j] =3D ctx->uvals[i];
+	}
+	ctx->val_cnt =3D j + 1;
+
+	/* we have exactly the same number of s64 values, they are just in
+	 * a different order than u64s, so just sort them differently
+	 */
+	for (i =3D 0; i < ctx->val_cnt; i++)
+		ctx->svals[i] =3D ctx->uvals[i];
+	qsort(ctx->svals, ctx->val_cnt, sizeof(*ctx->svals), s64_cmp);
+
+	if (env.verbosity >=3D VERBOSE_SUPER) {
+		DEFINE_STRBUF(sb1, 256);
+		DEFINE_STRBUF(sb2, 256);
+
+		for (i =3D 0; i < ctx->val_cnt; i++) {
+			sb1->pos =3D sb2->pos =3D 0;
+			snprintf_num(U64, sb1, ctx->uvals[i]);
+			snprintf_num(S64, sb2, ctx->svals[i]);
+			printf("SEED #%d: u64=3D%-20s s64=3D%-20s\n", i, sb1->buf, sb2->buf);
+		}
+	}
+
+	/* 32-bit values are generated separately */
+	cnt =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(lower_seeds); i++) {
+		ctx->usubvals[cnt++] =3D lower_seeds[i];
+	}
+
+	/* sort and compact usubvals (i.e., it's `sort | uniq`) */
+	qsort(ctx->usubvals, cnt, sizeof(*ctx->usubvals), u32_cmp);
+	for (i =3D 1, j =3D 0; i < cnt; i++) {
+		if (ctx->usubvals[j] =3D=3D ctx->usubvals[i])
+			continue;
+		j++;
+		ctx->usubvals[j] =3D ctx->usubvals[i];
+	}
+	ctx->subval_cnt =3D j + 1;
+
+	for (i =3D 0; i < ctx->subval_cnt; i++)
+		ctx->ssubvals[i] =3D ctx->usubvals[i];
+	qsort(ctx->ssubvals, ctx->subval_cnt, sizeof(*ctx->ssubvals), s32_cmp);
+
+	if (env.verbosity >=3D VERBOSE_SUPER) {
+		DEFINE_STRBUF(sb1, 256);
+		DEFINE_STRBUF(sb2, 256);
+
+		for (i =3D 0; i < ctx->subval_cnt; i++) {
+			sb1->pos =3D sb2->pos =3D 0;
+			snprintf_num(U32, sb1, ctx->usubvals[i]);
+			snprintf_num(S32, sb2, ctx->ssubvals[i]);
+			printf("SUBSEED #%d: u32=3D%-10s s32=3D%-10s\n", i, sb1->buf, sb2->bu=
f);
+		}
+	}
+}
+
+/* Generate valid ranges from upper/lower seeds */
+static int gen_ranges(struct ctx *ctx)
+{
+	int i, j, cnt =3D 0;
+
+	for (i =3D 0; i < ctx->val_cnt; i++) {
+		for (j =3D i; j < ctx->val_cnt; j++) {
+			if (env.verbosity >=3D VERBOSE_SUPER) {
+				DEFINE_STRBUF(sb1, 256);
+				DEFINE_STRBUF(sb2, 256);
+
+				sb1->pos =3D sb2->pos =3D 0;
+				snprintf_range(U64, sb1, range(U64, ctx->uvals[i], ctx->uvals[j]));
+				snprintf_range(S64, sb2, range(S64, ctx->svals[i], ctx->svals[j]));
+				printf("RANGE #%d: u64=3D%-40s s64=3D%-40s\n", cnt, sb1->buf, sb2->b=
uf);
+			}
+			cnt++;
+		}
+	}
+	ctx->range_cnt =3D cnt;
+
+	ctx->uranges =3D calloc(ctx->range_cnt, sizeof(*ctx->uranges));
+	if (!ASSERT_OK_PTR(ctx->uranges, "uranges_calloc"))
+		return -EINVAL;
+	ctx->sranges =3D calloc(ctx->range_cnt, sizeof(*ctx->sranges));
+	if (!ASSERT_OK_PTR(ctx->sranges, "sranges_calloc"))
+		return -EINVAL;
+
+	cnt =3D 0;
+	for (i =3D 0; i < ctx->val_cnt; i++) {
+		for (j =3D i; j < ctx->val_cnt; j++) {
+			ctx->uranges[cnt] =3D range(U64, ctx->uvals[i], ctx->uvals[j]);
+			ctx->sranges[cnt] =3D range(S64, ctx->svals[i], ctx->svals[j]);
+			cnt++;
+		}
+	}
+
+	cnt =3D 0;
+	for (i =3D 0; i < ctx->subval_cnt; i++) {
+		for (j =3D i; j < ctx->subval_cnt; j++) {
+			if (env.verbosity >=3D VERBOSE_SUPER) {
+				DEFINE_STRBUF(sb1, 256);
+				DEFINE_STRBUF(sb2, 256);
+
+				sb1->pos =3D sb2->pos =3D 0;
+				snprintf_range(U32, sb1, range(U32, ctx->usubvals[i], ctx->usubvals[=
j]));
+				snprintf_range(S32, sb2, range(S32, ctx->ssubvals[i], ctx->ssubvals[=
j]));
+				printf("SUBRANGE #%d: u32=3D%-20s s32=3D%-20s\n", cnt, sb1->buf, sb2=
->buf);
+			}
+			cnt++;
+		}
+	}
+	ctx->subrange_cnt =3D cnt;
+
+	ctx->usubranges =3D calloc(ctx->subrange_cnt, sizeof(*ctx->usubranges))=
;
+	if (!ASSERT_OK_PTR(ctx->usubranges, "usubranges_calloc"))
+		return -EINVAL;
+	ctx->ssubranges =3D calloc(ctx->subrange_cnt, sizeof(*ctx->ssubranges))=
;
+	if (!ASSERT_OK_PTR(ctx->ssubranges, "ssubranges_calloc"))
+		return -EINVAL;
+
+	cnt =3D 0;
+	for (i =3D 0; i < ctx->subval_cnt; i++) {
+		for (j =3D i; j < ctx->subval_cnt; j++) {
+			ctx->usubranges[cnt] =3D range(U32, ctx->usubvals[i], ctx->usubvals[j=
]);
+			ctx->ssubranges[cnt] =3D range(S32, ctx->ssubvals[i], ctx->ssubvals[j=
]);
+			cnt++;
+		}
+	}
+
+	return 0;
+}
+
+static int parse_env_vars(struct ctx *ctx)
+{
+	const char *s;
+
+	if (!(s =3D getenv("SLOW_TESTS")) || strcmp(s, "1") !=3D 0) {
+		test__skip();
+		return -ENOTSUP;
+	}
+
+	if ((s =3D getenv("REG_BOUNDS_MAX_FAILURE_CNT"))) {
+		errno =3D 0;
+		ctx->max_failure_cnt =3D strtol(s, NULL, 10);
+		if (errno || ctx->max_failure_cnt < 0) {
+			ASSERT_OK(-errno, "REG_BOUNDS_MAX_FAILURE_CNT");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int prepare_gen_tests(struct ctx *ctx)
+{
+	int err;
+
+	err =3D parse_env_vars(ctx);
+	if (err)
+		return err;
+
+	gen_vals(ctx);
+	err =3D gen_ranges(ctx);
+	if (err) {
+		ASSERT_OK(err, "gen_ranges");
+		return err;
+	}
+
+	return 0;
+}
+
+/* Go over generated constants and ranges and validate various supported
+ * combinations of them
+ */
+static void validate_gen_range_vs_const_64(enum num_t init_t, enum num_t=
 cond_t)
+{
+	struct ctx ctx;
+	struct range rconst;
+	const struct range *ranges;
+	const u64 *vals;
+	int i, j;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	if (prepare_gen_tests(&ctx))
+		goto cleanup;
+
+	ranges =3D init_t =3D=3D U64 ? ctx.uranges : ctx.sranges;
+	vals =3D init_t =3D=3D U64 ? ctx.uvals : (const u64 *)ctx.svals;
+
+	ctx.total_case_cnt =3D (last_op - first_op + 1) * (2 * ctx.range_cnt * =
ctx.val_cnt);
+	ctx.start_ns =3D get_time_ns();
+	snprintf(ctx.progress_ctx, sizeof(ctx.progress_ctx),
+		 "RANGE x CONST, %s -> %s",
+		 t_str(init_t), t_str(cond_t));
+
+	for (i =3D 0; i < ctx.val_cnt; i++) {
+		for (j =3D 0; j < ctx.range_cnt; j++) {
+			rconst =3D range(init_t, vals[i], vals[i]);
+
+			/* (u64|s64)(<range> x <const>) */
+			if (verify_case(&ctx, init_t, cond_t, ranges[j], rconst))
+				goto cleanup;
+			/* (u64|s64)(<const> x <range>) */
+			if (verify_case(&ctx, init_t, cond_t, rconst, ranges[j]))
+				goto cleanup;
+		}
+	}
+
+cleanup:
+	cleanup_ctx(&ctx);
+}
+
+static void validate_gen_range_vs_const_32(enum num_t init_t, enum num_t=
 cond_t)
+{
+	struct ctx ctx;
+	struct range rconst;
+	const struct range *ranges;
+	const u32 *vals;
+	int i, j;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	if (prepare_gen_tests(&ctx))
+		goto cleanup;
+
+	ranges =3D init_t =3D=3D U32 ? ctx.usubranges : ctx.ssubranges;
+	vals =3D init_t =3D=3D U32 ? ctx.usubvals : (const u32 *)ctx.ssubvals;
+
+	ctx.total_case_cnt =3D (last_op - first_op + 1) * (2 * ctx.subrange_cnt=
 * ctx.subval_cnt);
+	ctx.start_ns =3D get_time_ns();
+	snprintf(ctx.progress_ctx, sizeof(ctx.progress_ctx),
+		 "RANGE x CONST, %s -> %s",
+		 t_str(init_t), t_str(cond_t));
+
+	for (i =3D 0; i < ctx.subval_cnt; i++) {
+		for (j =3D 0; j < ctx.subrange_cnt; j++) {
+			rconst =3D range(init_t, vals[i], vals[i]);
+
+			/* (u32|s32)(<range> x <const>) */
+			if (verify_case(&ctx, init_t, cond_t, ranges[j], rconst))
+				goto cleanup;
+			/* (u32|s32)(<const> x <range>) */
+			if (verify_case(&ctx, init_t, cond_t, rconst, ranges[j]))
+				goto cleanup;
+		}
+	}
+
+cleanup:
+	cleanup_ctx(&ctx);
+}
+
+/* Go over thousands of test cases generated from initial seed values.
+ * Given this take a long time, guard this begind SLOW_TESTS=3D1 envvar.=
 If
+ * envvar is not set, this test is skipped during test_progs testing.
+ *
+ * We split this up into smaller subsets based on initialization and
+ * conditiona numeric domains to get an easy parallelization with test_p=
rogs'
+ * -j argument.
+ */
+
+/* RANGE x CONST, U64 initial range */
+void test_reg_bounds_gen_consts_u64_u64(void) { validate_gen_range_vs_co=
nst_64(U64, U64); }
+void test_reg_bounds_gen_consts_u64_s64(void) { validate_gen_range_vs_co=
nst_64(U64, S64); }
+void test_reg_bounds_gen_consts_u64_u32(void) { validate_gen_range_vs_co=
nst_64(U64, U32); }
+void test_reg_bounds_gen_consts_u64_s32(void) { validate_gen_range_vs_co=
nst_64(U64, S32); }
+/* RANGE x CONST, S64 initial range */
+void test_reg_bounds_gen_consts_s64_u64(void) { validate_gen_range_vs_co=
nst_64(S64, U64); }
+void test_reg_bounds_gen_consts_s64_s64(void) { validate_gen_range_vs_co=
nst_64(S64, S64); }
+void test_reg_bounds_gen_consts_s64_u32(void) { validate_gen_range_vs_co=
nst_64(S64, U32); }
+void test_reg_bounds_gen_consts_s64_s32(void) { validate_gen_range_vs_co=
nst_64(S64, S32); }
+/* RANGE x CONST, U32 initial range */
+void test_reg_bounds_gen_consts_u32_u64(void) { validate_gen_range_vs_co=
nst_32(U32, U64); }
+void test_reg_bounds_gen_consts_u32_s64(void) { validate_gen_range_vs_co=
nst_32(U32, S64); }
+void test_reg_bounds_gen_consts_u32_u32(void) { validate_gen_range_vs_co=
nst_32(U32, U32); }
+void test_reg_bounds_gen_consts_u32_s32(void) { validate_gen_range_vs_co=
nst_32(U32, S32); }
+/* RANGE x CONST, S32 initial range */
+void test_reg_bounds_gen_consts_s32_u64(void) { validate_gen_range_vs_co=
nst_32(S32, U64); }
+void test_reg_bounds_gen_consts_s32_s64(void) { validate_gen_range_vs_co=
nst_32(S32, S64); }
+void test_reg_bounds_gen_consts_s32_u32(void) { validate_gen_range_vs_co=
nst_32(S32, U32); }
+void test_reg_bounds_gen_consts_s32_s32(void) { validate_gen_range_vs_co=
nst_32(S32, S32); }
+
+/* A set of hard-coded "interesting" cases to validate as part of normal
+ * test_progs test runs
+ */
+static struct subtest_case crafted_cases[] =3D {
+	{U64, U64, {0, 0xffffffff}, {0, 0}},
+	{U64, U64, {0, 0x80000000}, {0, 0}},
+	{U64, U64, {0x100000000ULL, 0x100000100ULL}, {0, 0}},
+	{U64, U64, {0x100000000ULL, 0x180000000ULL}, {0, 0}},
+	{U64, U64, {0x100000000ULL, 0x1ffffff00ULL}, {0, 0}},
+	{U64, U64, {0x100000000ULL, 0x1ffffff01ULL}, {0, 0}},
+	{U64, U64, {0x100000000ULL, 0x1fffffffeULL}, {0, 0}},
+	{U64, U64, {0x100000001ULL, 0x1000000ffULL}, {0, 0}},
+
+	{U64, S64, {0, 0xffffffff00000000ULL}, {0, 0}},
+	{U64, S64, {0x7fffffffffffffffULL, 0xffffffff00000000ULL}, {0, 0}},
+	{U64, S64, {0x7fffffff00000001ULL, 0xffffffff00000000ULL}, {0, 0}},
+	{U64, S64, {0, 0xffffffffULL}, {1, 1}},
+	{U64, S64, {0, 0xffffffffULL}, {0x7fffffff, 0x7fffffff}},
+
+	{U64, U32, {0, 0x100000000}, {0, 0}},
+	{U64, U32, {0xfffffffe, 0x100000000}, {0x80000000, 0x80000000}},
+
+	{U64, S32, {0, 0xffffffff00000000ULL}, {0, 0}},
+	/* these are tricky cases where lower 32 bits allow to tighten 64
+	 * bit boundaries based on tightened lower 32 bit boundaries
+	 */
+	{U64, S32, {0, 0x0ffffffffULL}, {0, 0}},
+	{U64, S32, {0, 0x100000000ULL}, {0, 0}},
+	{U64, S32, {0, 0x100000001ULL}, {0, 0}},
+	{U64, S32, {0, 0x180000000ULL}, {0, 0}},
+	{U64, S32, {0, 0x17fffffffULL}, {0, 0}},
+	{U64, S32, {0, 0x180000001ULL}, {0, 0}},
+
+	/* verifier knows about [-1, 0] range for s32 for this case already */
+	{S64, S64, {0xffffffffffffffffULL, 0}, {0xffffffff00000000ULL, 0xffffff=
ff00000000ULL}},
+	/* but didn't know about these cases initially */
+	{U64, U64, {0xffffffff, 0x100000000ULL}, {0, 0}}, /* s32: [-1, 0] */
+	{U64, U64, {0xffffffff, 0x100000001ULL}, {0, 0}}, /* s32: [-1, 1] */
+
+	/* longer convergence case: learning from u64 -> s64 -> u64 -> u32,
+	 * arriving at u32: [1, U32_MAX] (instead of more pessimistic [0, U32_M=
AX])
+	 */
+	{S64, U64, {0xffffffff00000001ULL, 0}, {0xffffffff00000000ULL, 0xffffff=
ff00000000ULL}},
+
+	{U32, U32, {1, U32_MAX}, {0, 0}},
+
+	{U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
+};
+
+/* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
+ * normal test_progs run.
+ */
+void test_reg_bounds_crafted(void)
+{
+	struct ctx ctx;
+	int i;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	for (i =3D 0; i < ARRAY_SIZE(crafted_cases); i++) {
+		struct subtest_case *c =3D &crafted_cases[i];
+
+		verify_case(&ctx, c->init_t, c->cond_t, c->x, c->y);
+		verify_case(&ctx, c->init_t, c->cond_t, c->y, c->x);
+	}
+
+	cleanup_ctx(&ctx);
+}
--=20
2.34.1


