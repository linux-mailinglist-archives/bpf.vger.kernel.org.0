Return-Path: <bpf+bounces-14780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13427E7DA3
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8907BB210C2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CEC1D549;
	Fri, 10 Nov 2023 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C611DFDC
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:11:27 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699113BF3C
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:25 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAwvkk021941
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:24 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u9k82sx6n-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:24 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 08:11:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id F37663B499868; Fri, 10 Nov 2023 08:11:11 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 6/8] bpf: omit default off=0 and imm=0 in register state log
Date: Fri, 10 Nov 2023 08:10:55 -0800
Message-ID: <20231110161057.1943534-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110161057.1943534-1-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z2kyx313eDxAaNa7Ru7UAWnh788jYe9a
X-Proofpoint-ORIG-GUID: Z2kyx313eDxAaNa7Ru7UAWnh788jYe9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_13,2023-11-09_01,2023-05-22_02

Simplify BPF verifierl log furthre by omitting default (and frequently
irrelevant) off=3D0 and imm=3D0 parts for non-SCALAR_VALUE registers. As =
can
be seen from fixed tests, this is often a visual noise for PTR_TO_CTX
register and even for PTR_TO_PACKET registers.

Omitting default values follows the rest of register state logic: we
omit default values to keep verifier log succinct and to highlight
interesting state that deviates from default one. E.g., we do the same
for var_off, when it's unknown, which gives no additional information.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                              | 10 ++---
 .../testing/selftests/bpf/prog_tests/align.c  | 42 +++++++++----------
 .../selftests/bpf/prog_tests/log_buf.c        |  4 +-
 .../selftests/bpf/prog_tests/spin_lock.c      | 14 +++----
 .../selftests/bpf/progs/exceptions_assert.c   | 10 ++---
 5 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index c209ab1ec2b5..20b4f81087da 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -602,16 +602,14 @@ static void print_reg_state(struct bpf_verifier_env=
 *env, const struct bpf_reg_s
 			  reg->map_ptr->key_size,
 			  reg->map_ptr->value_size);
 	}
-	if (t !=3D SCALAR_VALUE)
+	if (t !=3D SCALAR_VALUE && reg->off)
 		verbose_a("off=3D%d", reg->off);
 	if (type_is_pkt_pointer(t))
 		verbose_a("r=3D%d", reg->range);
 	if (tnum_is_const(reg->var_off)) {
-		/* Typically an immediate SCALAR_VALUE, but
-		 * could be a pointer whose offset is too big
-		 * for reg->off
-		 */
-		verbose_a("imm=3D%llx", reg->var_off.value);
+		/* a pointer register with fixed offset */
+		if (reg->var_off.value)
+			verbose_a("imm=3D%llx", reg->var_off.value);
 	} else {
 		print_scalar_ranges(env, reg, &sep);
 		if (!tnum_is_unknown(reg->var_off)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
index 465c1c3a3d3c..4ebd0da898f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -40,7 +40,7 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
 			{0, "R3_w", "2"},
 			{1, "R3_w", "4"},
@@ -68,7 +68,7 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
 			{0, "R3_w", "1"},
 			{1, "R3_w", "2"},
@@ -97,7 +97,7 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
 			{0, "R3_w", "4"},
 			{1, "R3_w", "8"},
@@ -119,7 +119,7 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R1", "ctx()"},
 			{0, "R10", "fp0"},
 			{0, "R3_w", "7"},
 			{1, "R3_w", "7"},
@@ -162,13 +162,13 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R0_w", "pkt(off=3D8,r=3D8,imm=3D0)"},
+			{6, "R0_w", "pkt(off=3D8,r=3D8)"},
 			{6, "R3_w", "var_off=3D(0x0; 0xff)"},
 			{7, "R3_w", "var_off=3D(0x0; 0x1fe)"},
 			{8, "R3_w", "var_off=3D(0x0; 0x3fc)"},
 			{9, "R3_w", "var_off=3D(0x0; 0x7f8)"},
 			{10, "R3_w", "var_off=3D(0x0; 0xff0)"},
-			{12, "R3_w", "pkt_end(off=3D0,imm=3D0)"},
+			{12, "R3_w", "pkt_end()"},
 			{17, "R4_w", "var_off=3D(0x0; 0xff)"},
 			{18, "R4_w", "var_off=3D(0x0; 0x1fe0)"},
 			{19, "R4_w", "var_off=3D(0x0; 0xff0)"},
@@ -235,11 +235,11 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{2, "R5_w", "pkt(off=3D0,r=3D0,imm=3D0)"},
-			{4, "R5_w", "pkt(off=3D14,r=3D0,imm=3D0)"},
-			{5, "R4_w", "pkt(off=3D14,r=3D0,imm=3D0)"},
-			{9, "R2", "pkt(off=3D0,r=3D18,imm=3D0)"},
-			{10, "R5", "pkt(off=3D14,r=3D18,imm=3D0)"},
+			{2, "R5_w", "pkt(r=3D0)"},
+			{4, "R5_w", "pkt(off=3D14,r=3D0)"},
+			{5, "R4_w", "pkt(off=3D14,r=3D0)"},
+			{9, "R2", "pkt(r=3D18)"},
+			{10, "R5", "pkt(off=3D14,r=3D18)"},
 			{10, "R4_w", "var_off=3D(0x0; 0xff)"},
 			{13, "R4_w", "var_off=3D(0x0; 0xffff)"},
 			{14, "R4_w", "var_off=3D(0x0; 0xffff)"},
@@ -299,7 +299,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w", "pkt(r=3D8)"},
 			{7, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
@@ -337,7 +337,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w", "pkt(off=3D14,r=3D8,"},
+			{26, "R5_w", "pkt(off=3D14,r=3D8)"},
 			/* Variable offset is added to R5, resulting in a
 			 * variable offset of (4n). See comment for insn #18
 			 * for R4 =3D R5 trick.
@@ -397,7 +397,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w", "pkt(r=3D8)"},
 			{7, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{8, "R6_w", "var_off=3D(0x2; 0x7fc)"},
@@ -459,7 +459,7 @@ static struct bpf_align_test tests[] =3D {
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.result =3D REJECT,
 		.matches =3D {
-			{3, "R5_w", "pkt_end(off=3D0,imm=3D0)"},
+			{3, "R5_w", "pkt_end()"},
 			/* (ptr - ptr) << 2 =3D=3D unknown, (4n) */
 			{5, "R5_w", "var_off=3D(0x0; 0xfffffffffffffffc)"},
 			/* (4n) + 14 =3D=3D (4n+2).  We blow our bounds, because
@@ -513,7 +513,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w", "pkt(r=3D8)"},
 			{8, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{9, "R6_w", "var_off=3D(0x2; 0x7fc)"},
@@ -566,7 +566,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w", "pkt(r=3D8)"},
 			{9, "R6_w", "var_off=3D(0x0; 0x3c)"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{10, "R6_w", "var_off=3D(0x2; 0x7c)"},
@@ -659,14 +659,14 @@ static int do_test_single(struct bpf_align_test *te=
st)
 			/* Check the next line as well in case the previous line
 			 * did not have a corresponding bpf insn. Example:
 			 * func#0 @0
-			 * 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
+			 * 0: R1=3Dctx() R10=3Dfp0
 			 * 0: (b7) r3 =3D 2                 ; R3_w=3D2
 			 *
 			 * Sometimes it's actually two lines below, e.g. when
 			 * searching for "6: R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"=
:
-			 *   from 4 to 6: R0_w=3Dpkt(off=3D8,r=3D8,imm=3D0) R1=3Dctx(off=3D0,=
imm=3D0) R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0) R3_w=3Dpkt_end(off=3D0,imm=3D0=
) R10=3Dfp0
-			 *   6: R0_w=3Dpkt(off=3D8,r=3D8,imm=3D0) R1=3Dctx(off=3D0,imm=3D0) R=
2_w=3Dpkt(off=3D0,r=3D8,imm=3D0) R3_w=3Dpkt_end(off=3D0,imm=3D0) R10=3Dfp=
0
-			 *   6: (71) r3 =3D *(u8 *)(r2 +0)           ; R2_w=3Dpkt(off=3D0,r=3D=
8,imm=3D0) R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))
+			 *   from 4 to 6: R0_w=3Dpkt(off=3D8,r=3D8) R1=3Dctx() R2_w=3Dpkt(r=3D=
8) R3_w=3Dpkt_end() R10=3Dfp0
+			 *   6: R0_w=3Dpkt(off=3D8,r=3D8) R1=3Dctx() R2_w=3Dpkt(r=3D8) R3_w=3D=
pkt_end() R10=3Dfp0
+			 *   6: (71) r3 =3D *(u8 *)(r2 +0)           ; R2_w=3Dpkt(r=3D8) R3_w=
=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))
 			 */
 			while (!(p =3D strstr(line_ptr, m.reg)) || !strstr(p, m.match)) {
 				cur_line =3D -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/tes=
ting/selftests/bpf/prog_tests/log_buf.c
index fe9a23e65ef4..0f7ea4d7d9f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -78,7 +78,7 @@ static void obj_load_log_buf(void)
 	ASSERT_OK_PTR(strstr(libbpf_log_buf, "prog 'bad_prog': BPF program load=
 failed"),
 		      "libbpf_log_not_empty");
 	ASSERT_OK_PTR(strstr(obj_log_buf, "DATASEC license"), "obj_log_not_empt=
y");
-	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=3Dctx(off=3D0,imm=3D0) R10=3D=
fp0"),
+	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=3Dctx() R10=3Dfp0"),
 		      "good_log_verbose");
 	ASSERT_OK_PTR(strstr(bad_log_buf, "invalid access to map value, value_s=
ize=3D16 off=3D16000 size=3D4"),
 		      "bad_log_not_empty");
@@ -175,7 +175,7 @@ static void bpf_prog_load_log_buf(void)
 	opts.log_level =3D 2;
 	fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
 			   good_prog_insns, good_prog_insn_cnt, &opts);
-	ASSERT_OK_PTR(strstr(log_buf, "0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0")=
, "good_log_2");
+	ASSERT_OK_PTR(strstr(log_buf, "0: R1=3Dctx() R10=3Dfp0"), "good_log_2")=
;
 	ASSERT_GE(fd, 0, "good_fd2");
 	if (fd >=3D 0)
 		close(fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/t=
esting/selftests/bpf/prog_tests/spin_lock.c
index ace65224286f..18d451be57c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -13,22 +13,22 @@ static struct {
 	const char *err_msg;
 } spin_lock_fail_tests[] =3D {
 	{ "lock_id_kptr_preserve",
-	  "5: (bf) r1 =3D r0                       ; R0_w=3Dptr_foo(id=3D2,ref_=
obj_id=3D2,off=3D0,imm=3D0) "
-	  "R1_w=3Dptr_foo(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2\n6: (=
85) call bpf_this_cpu_ptr#154\n"
+	  "5: (bf) r1 =3D r0                       ; R0_w=3Dptr_foo(id=3D2,ref_=
obj_id=3D2) "
+	  "R1_w=3Dptr_foo(id=3D2,ref_obj_id=3D2) refs=3D2\n6: (85) call bpf_thi=
s_cpu_ptr#154\n"
 	  "R1 type=3Dptr_ expected=3Dpercpu_ptr_" },
 	{ "lock_id_global_zero",
-	  "; R1_w=3Dmap_value(map=3D.data.A,ks=3D4,vs=3D4,off=3D0,imm=3D0)\n2: =
(85) call bpf_this_cpu_ptr#154\n"
+	  "; R1_w=3Dmap_value(map=3D.data.A,ks=3D4,vs=3D4)\n2: (85) call bpf_th=
is_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_mapval_preserve",
 	  "[0-9]\\+: (bf) r1 =3D r0                       ;"
-	  " R0_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8,off=3D0,imm=3D=
0)"
-	  " R1_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8,off=3D0,imm=3D=
0)\n"
+	  " R0_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8)"
+	  " R1_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_innermapval_preserve",
 	  "[0-9]\\+: (bf) r1 =3D r0                      ;"
-	  " R0=3Dmap_value(id=3D2,ks=3D4,vs=3D8,off=3D0,imm=3D0)"
-	  " R1_w=3Dmap_value(id=3D2,ks=3D4,vs=3D8,off=3D0,imm=3D0)\n"
+	  " R0=3Dmap_value(id=3D2,ks=3D4,vs=3D8)"
+	  " R1_w=3Dmap_value(id=3D2,ks=3D4,vs=3D8)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
index e1e5c54a6a11..26f7d67432cc 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -59,7 +59,7 @@ check_assert(s64, ge, neg, INT_MIN);
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=3D0 R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(smin=3Dsmin32=3D-2=
147483646,smax=3Dsmax32=3D2147483645) R10=3Dfp0")
+__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3Dsmin32=3D-2147483646,smax=3D=
smax32=3D2147483645) R10=3Dfp0")
 int check_assert_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk =3D ctx->sk;
@@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dum=
in32=3D4096,smax=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))=
")
+__msg(": R1=3Dctx() R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
 int check_assert_range_u64(struct __sk_buff *ctx)
 {
 	u64 num =3D ctx->len;
@@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=3D0 R1=3Dctx(off=3D0,imm=3D0) R2=3D4096 R10=3Dfp0")
+__msg(": R0=3D0 R1=3Dctx() R2=3D4096 R10=3Dfp0")
 int check_assert_single_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk =3D ctx->sk;
@@ -103,7 +103,7 @@ int check_assert_single_range_s64(struct __sk_buff *c=
tx)
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=3Dctx(off=3D0,imm=3D0) R2=3D4096 R10=3Dfp0")
+__msg(": R1=3Dctx() R2=3D4096 R10=3Dfp0")
 int check_assert_single_range_u64(struct __sk_buff *ctx)
 {
 	u64 num =3D ctx->len;
@@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *c=
tx)
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=3Dpkt(off=3D64,r=3D64,imm=3D0) R2=3Dpkt_end(off=3D0,imm=3D0)=
 R6=3Dpkt(off=3D0,r=3D64,imm=3D0) R10=3Dfp0")
+__msg(": R1=3Dpkt(off=3D64,r=3D64) R2=3Dpkt_end() R6=3Dpkt(r=3D64) R10=3D=
fp0")
 int check_assert_generic(struct __sk_buff *ctx)
 {
 	u8 *data_end =3D (void *)(long)ctx->data_end;
--=20
2.34.1


