Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC774733E5
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhLMSVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 13:21:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232192AbhLMSVu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 13:21:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDHAF1R017029
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=K9jvl3EUYTTm9T1Y0EoWFI1DOQH+X1eOX8nkFiPQ9NI=;
 b=GkC+TYpNL5n7kJ73AXcWf8ruqD4ItK4Um8d3oKmljIYY3TxHYfOtUto+aQ4XzxHAkWuY
 pNUS+rmvAUMCIEboum2YdMdViF2ffS4V7Z40om+ILPpHGl2XqOuP2244yxMhPuL73xKR
 9+NNfMiV6+dnaVOH4BZIjEc+CUCkpOOMw68= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cx9rp0wqy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:49 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 10:21:44 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 733EF537A35; Mon, 13 Dec 2021 10:21:43 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <christylee@fb.com>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] Right align verifier states in verifier logs
Date:   Mon, 13 Dec 2021 10:21:16 -0800
Message-ID: <20211213182117.682461-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213182117.682461-1-christylee@fb.com>
References: <20211213182117.682461-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: gdmFcdZlGz29Kfauxp_eDJtOZi0AHCDB
X-Proofpoint-GUID: gdmFcdZlGz29Kfauxp_eDJtOZi0AHCDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_08,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the verifier logs more readable, print the verifier states
on the corresponding instruction line. If the previous line was
not a bpf instruction, then print the verifier states on its own
line.

Before:

Validating test_pkt_access_subprog3() func#3...
86: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
86: (bf) r6 =3D r2
87: R2=3Dctx(id=3D0,off=3D0,imm=3D0) R6_w=3Dctx(id=3D0,off=3D0,imm=3D0)
87: (bc) w7 =3D w1
88: R1=3DinvP(id=3D0) R7_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D=
(0x0; 0xffffffff))
; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
88: (bf) r1 =3D r6
89: R1_w=3Dctx(id=3D0,off=3D0,imm=3D0) R6_w=3Dctx(id=3D0,off=3D0,imm=3D0)
89: (85) call pc+9
Func#4 is global and valid. Skipping.
90: R0_w=3DinvP(id=3D0)
90: (bc) w8 =3D w0
91: R0_w=3DinvP(id=3D0) R8_w=3DinvP(id=3D0,umax_value=3D4294967295,var_of=
f=3D(0x0; 0xffffffff))
; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
91: (b7) r1 =3D 123
92: R1_w=3DinvP123
92: (85) call pc+65
Func#5 is global and valid. Skipping.
93: R0=3DinvP(id=3D0)

After:

Validating test_pkt_access_subprog3() func#3...
86: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
86: (bf) r6 =3D r2               ; R2=3Dctx(id=3D0,off=3D0,imm=3D0) R6_w=3D=
ctx(id=3D0,off=3D0,imm=3D0)
87: (bc) w7 =3D w1               ; R1=3DinvP(id=3D0) R7_w=3DinvP(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff))
; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
88: (bf) r1 =3D r6               ; R1_w=3Dctx(id=3D0,off=3D0,imm=3D0) R6_=
w=3Dctx(id=3D0,off=3D0,imm=3D0)
89: (85) call pc+9
Func#4 is global and valid. Skipping.
90: R0_w=3DinvP(id=3D0)
90: (bc) w8 =3D w0               ; R0_w=3DinvP(id=3D0) R8_w=3DinvP(id=3D0=
,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff))
; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
91: (b7) r1 =3D 123              ; R1_w=3DinvP123
92: (85) call pc+65
Func#5 is global and valid. Skipping.
93: R0=3DinvP(id=3D0)

Signed-off-by: Christy Lee <christylee@fb.com>
---
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/verifier.c                         |  26 ++-
 .../testing/selftests/bpf/prog_tests/align.c  | 196 ++++++++++--------
 3 files changed, 131 insertions(+), 93 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c555222c97d6..cd5dd68693d6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -388,6 +388,8 @@ static inline bool bpf_verifier_log_full(const struct=
 bpf_verifier_log *log)
 #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
 #define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS)
 #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
+#define BPF_LOG_MIN_ALIGNMENT 8
+#define BPF_LOG_ALIGNMENT_POS 32
=20
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log=
 *log)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 73d0b4e6ff6b..6d6934fd91e6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -660,6 +660,25 @@ static void scrub_spilled_slot(u8 *stype)
 		*stype =3D STACK_MISC;
 }
=20
+static u32 vlog_alignment(u32 prev_insn_print_len)
+{
+	if (prev_insn_print_len < BPF_LOG_ALIGNMENT_POS)
+		return BPF_LOG_ALIGNMENT_POS - prev_insn_print_len;
+	return round_up(prev_insn_print_len, BPF_LOG_MIN_ALIGNMENT) -
+	       prev_insn_print_len;
+}
+
+static void print_insn_state(struct bpf_verifier_env *env, u32 prev_log_=
len,
+			     u32 prev_insn_print_len)
+{
+	if ((prev_log_len =3D=3D env->log.len_used) &&
+	    (env->prev_insn_idx =3D=3D env->insn_idx - 1)) {
+		bpf_vlog_reset(&env->log, prev_log_len - 1);
+		verbose(env, "%*c;", vlog_alignment(prev_insn_print_len), ' ');
+	} else
+		verbose(env, "%d:", env->insn_idx);
+}
+
 static void print_verifier_state(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state)
 {
@@ -11259,6 +11278,7 @@ static bool reg_type_mismatch(enum bpf_reg_type s=
rc, enum bpf_reg_type prev)
=20
 static int do_check(struct bpf_verifier_env *env)
 {
+	u32 prev_log_len, prev_insn_print_len;
 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_insn *insns =3D env->prog->insnsi;
@@ -11316,7 +11336,8 @@ static int do_check(struct bpf_verifier_env *env)
 		    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
 			if (verifier_state_scratched(env) &&
 			    (env->log.level & BPF_LOG_LEVEL2))
-				verbose(env, "%d:", env->insn_idx);
+				print_insn_state(env, prev_log_len,
+						 prev_insn_print_len);
 			else
 				verbose(env, "\nfrom %d to %d%s:",
 					env->prev_insn_idx, env->insn_idx,
@@ -11334,8 +11355,11 @@ static int do_check(struct bpf_verifier_env *env=
)
 			};
=20
 			verbose_linfo(env, env->insn_idx, "; ");
+			prev_log_len =3D env->log.len_used;
 			verbose(env, "%d: ", env->insn_idx);
 			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+			prev_insn_print_len =3D env->log.len_used - prev_log_len;
+			prev_log_len =3D env->log.len_used;
 		}
=20
 		if (bpf_prog_is_dev_bound(env->prog->aux)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
index aeb2080a67f7..954f31380a9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -41,11 +41,11 @@ static struct bpf_align_test tests[] =3D {
 		.matches =3D {
 			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{1, "R3_w=3Dinv2"},
-			{2, "R3_w=3Dinv4"},
-			{3, "R3_w=3Dinv8"},
-			{4, "R3_w=3Dinv16"},
-			{5, "R3_w=3Dinv32"},
+			{0, "R3_w=3Dinv2"},
+			{1, "R3_w=3Dinv4"},
+			{2, "R3_w=3Dinv8"},
+			{3, "R3_w=3Dinv16"},
+			{4, "R3_w=3Dinv32"},
 		},
 	},
 	{
@@ -69,17 +69,17 @@ static struct bpf_align_test tests[] =3D {
 		.matches =3D {
 			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{1, "R3_w=3Dinv1"},
-			{2, "R3_w=3Dinv2"},
-			{3, "R3_w=3Dinv4"},
-			{4, "R3_w=3Dinv8"},
-			{5, "R3_w=3Dinv16"},
-			{6, "R3_w=3Dinv1"},
-			{7, "R4_w=3Dinv32"},
-			{8, "R4_w=3Dinv16"},
-			{9, "R4_w=3Dinv8"},
-			{10, "R4_w=3Dinv4"},
-			{11, "R4_w=3Dinv2"},
+			{0, "R3_w=3Dinv1"},
+			{1, "R3_w=3Dinv2"},
+			{2, "R3_w=3Dinv4"},
+			{3, "R3_w=3Dinv8"},
+			{4, "R3_w=3Dinv16"},
+			{5, "R3_w=3Dinv1"},
+			{6, "R4_w=3Dinv32"},
+			{7, "R4_w=3Dinv16"},
+			{8, "R4_w=3Dinv8"},
+			{9, "R4_w=3Dinv4"},
+			{10, "R4_w=3Dinv2"},
 		},
 	},
 	{
@@ -98,12 +98,12 @@ static struct bpf_align_test tests[] =3D {
 		.matches =3D {
 			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{1, "R3_w=3Dinv4"},
-			{2, "R3_w=3Dinv8"},
-			{3, "R3_w=3Dinv10"},
-			{4, "R4_w=3Dinv8"},
-			{5, "R4_w=3Dinv12"},
-			{6, "R4_w=3Dinv14"},
+			{0, "R3_w=3Dinv4"},
+			{1, "R3_w=3Dinv8"},
+			{2, "R3_w=3Dinv10"},
+			{3, "R4_w=3Dinv8"},
+			{4, "R4_w=3Dinv12"},
+			{5, "R4_w=3Dinv14"},
 		},
 	},
 	{
@@ -120,10 +120,10 @@ static struct bpf_align_test tests[] =3D {
 		.matches =3D {
 			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
+			{0, "R3_w=3Dinv7"},
 			{1, "R3_w=3Dinv7"},
-			{2, "R3_w=3Dinv7"},
-			{3, "R3_w=3Dinv14"},
-			{4, "R3_w=3Dinv56"},
+			{2, "R3_w=3Dinv14"},
+			{3, "R3_w=3Dinv56"},
 		},
 	},
=20
@@ -161,19 +161,19 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R0_w=3Dpkt(id=3D0,off=3D8,r=3D8,imm=3D0)"},
-			{7, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{8, "R3_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
-			{9, "R3_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{10, "R3_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{11, "R3_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
-			{13, "R3_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
-			{18, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{19, "R4_w=3Dinv(id=3D0,umax_value=3D8160,var_off=3D(0x0; 0x1fe0))"},
-			{20, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
-			{21, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{22, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{23, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
+			{5, "R0_w=3Dpkt(id=3D0,off=3D8,r=3D8,imm=3D0)"},
+			{6, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{7, "R3_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
+			{8, "R3_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{9, "R3_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{10, "R3_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
+			{12, "R3_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
+			{17, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{18, "R4_w=3Dinv(id=3D0,umax_value=3D8160,var_off=3D(0x0; 0x1fe0))"},
+			{19, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
+			{20, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{21, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{22, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
 		},
 	},
 	{
@@ -194,16 +194,16 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{7, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{8, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{9, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{10, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{11, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
-			{12, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{13, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{14, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{15, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{16, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
+			{6, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{7, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{8, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{9, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{10, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
+			{11, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{12, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{13, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{14, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{15, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
 		},
 	},
 	{
@@ -234,14 +234,14 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{3, "R5_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0)"},
-			{5, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
-			{6, "R4_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
-			{9, "R2=3Dpkt(id=3D0,off=3D0,r=3D18,imm=3D0)"},
+			{2, "R5_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0)"},
+			{4, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
+			{5, "R4_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
+			{8, "R2=3Dpkt(id=3D0,off=3D0,r=3D18,imm=3D0)"},
 			{10, "R5=3Dpkt(id=3D0,off=3D14,r=3D18,imm=3D0)"},
 			{10, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
+			{13, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
 			{14, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
-			{15, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
 		},
 	},
 	{
@@ -297,7 +297,7 @@ static struct bpf_align_test tests[] =3D {
 			 * alignment of 4.
 			 */
 			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{7, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
 			 */
@@ -308,47 +308,47 @@ static struct bpf_align_test tests[] =3D {
 			 * offset is considered using reg->aux_off_align which
 			 * is 4 and meets the load's requirements.
 			 */
-			{15, "R4=3Dpkt(id=3D1,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
-			{15, "R5=3Dpkt(id=3D1,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{14, "R4=3Dpkt(id=3D1,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{14, "R5=3Dpkt(id=3D1,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
 			 * resulting in auxiliary alignment of 4.
 			 */
-			{18, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{17, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{19, "R5_w=3Dpkt(id=3D2,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{18, "R5_w=3Dpkt(id=3D2,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=3Dpkt(id=3D2,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
-			{23, "R5=3Dpkt(id=3D2,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{22, "R4=3Dpkt(id=3D2,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{22, "R5=3Dpkt(id=3D2,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D8"},
+			{25, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D8"},
 			/* Variable offset is added to R5, resulting in a
 			 * variable offset of (4n).
 			 */
-			{27, "R5_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{26, "R5_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{28, "R5_w=3Dpkt(id=3D3,off=3D18,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{27, "R5_w=3Dpkt(id=3D3,off=3D18,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{29, "R5_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax_value=3D2040,var_off=3D(0=
x0; 0x7fc)"},
+			{28, "R5_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax_value=3D2040,var_off=3D(0=
x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=3Dpkt(id=3D4,off=3D22,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
-			{33, "R5=3Dpkt(id=3D4,off=3D18,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
+			{32, "R4=3Dpkt(id=3D4,off=3D22,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
+			{32, "R5=3Dpkt(id=3D4,off=3D18,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
 		},
 	},
 	{
@@ -387,35 +387,35 @@ static struct bpf_align_test tests[] =3D {
 			 * alignment of 4.
 			 */
 			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{7, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{9, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
+			{8, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
 			/* Packet pointer has (4n+2) offset */
 			{11, "R5_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D14,umax_value=3D10=
34,var_off=3D(0x2; 0x7fc)"},
-			{13, "R4=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
+			{12, "R4=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{15, "R5=3Dpkt(id=3D1,off=3D0,r=3D4,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
+			{14, "R5=3Dpkt(id=3D1,off=3D0,r=3D4,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
 			/* Newly read value in R6 was shifted left by 2, so has
 			 * known alignment of 4.
 			 */
-			{18, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{17, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Added (4n) to packet pointer's (4n+2) var_off, giving
 			 * another (4n+2).
 			 */
 			{19, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umin_value=3D14,umax_value=3D20=
54,var_off=3D(0x2; 0xffc)"},
-			{21, "R4=3Dpkt(id=3D2,off=3D4,r=3D0,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
+			{20, "R4=3Dpkt(id=3D2,off=3D4,r=3D0,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{23, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
+			{22, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
 		},
 	},
 	{
@@ -448,18 +448,18 @@ static struct bpf_align_test tests[] =3D {
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.result =3D REJECT,
 		.matches =3D {
-			{4, "R5_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
+			{3, "R5_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
 			/* (ptr - ptr) << 2 =3D=3D unknown, (4n) */
-			{6, "R5_w=3Dinv(id=3D0,smax_value=3D9223372036854775804,umax_value=3D=
18446744073709551612,var_off=3D(0x0; 0xfffffffffffffffc)"},
+			{5, "R5_w=3Dinv(id=3D0,smax_value=3D9223372036854775804,umax_value=3D=
18446744073709551612,var_off=3D(0x0; 0xfffffffffffffffc)"},
 			/* (4n) + 14 =3D=3D (4n+2).  We blow our bounds, because
 			 * the add could overflow.
 			 */
-			{7, "R5_w=3Dinv(id=3D0,smin_value=3D-9223372036854775806,smax_value=3D=
9223372036854775806,umin_value=3D2,umax_value=3D18446744073709551614,var_=
off=3D(0x2; 0xfffffffffffffffc)"},
+			{6, "R5_w=3Dinv(id=3D0,smin_value=3D-9223372036854775806,smax_value=3D=
9223372036854775806,umin_value=3D2,umax_value=3D18446744073709551614,var_=
off=3D(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>=3D0 */
-			{9, "R5=3Dinv(id=3D0,umin_value=3D2,umax_value=3D9223372036854775806,=
var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{8, "R5=3Dinv(id=3D0,umin_value=3D2,umax_value=3D9223372036854775806,=
var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* packet pointer + nonnegative (4n+2) */
-			{12, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
-			{13, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{11, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{12, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* NET_IP_ALIGN + (4n+2) =3D=3D (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
 			 * to overflow if the packet pointer started in the
@@ -467,7 +467,7 @@ static struct bpf_align_test tests[] =3D {
 			 * So we did not get a 'range' on R6, and the access
 			 * attempt will fail.
 			 */
-			{15, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{14, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 		}
 	},
 	{
@@ -502,23 +502,23 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{7, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{9, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
+			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{10, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(=
0x2; 0x7fc))"},
+			{9, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
 			/* New unknown value in R7 is (4n) */
-			{11, "R7_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{10, "R7_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Subtracting it from R6 blows our unsigned bounds */
-			{12, "R6=3Dinv(id=3D0,smin_value=3D-1006,smax_value=3D1034,umin_value=
=3D2,umax_value=3D18446744073709551614,var_off=3D(0x2; 0xfffffffffffffffc=
)"},
+			{11, "R6=3Dinv(id=3D0,smin_value=3D-1006,smax_value=3D1034,umin_value=
=3D2,umax_value=3D18446744073709551614,var_off=3D(0x2; 0xfffffffffffffffc=
)"},
 			/* Checked s>=3D 0 */
-			{14, "R6=3Dinv(id=3D0,umin_value=3D2,umax_value=3D1034,var_off=3D(0x2=
; 0x7fc))"},
+			{13, "R6=3Dinv(id=3D0,umin_value=3D2,umax_value=3D1034,var_off=3D(0x2=
; 0x7fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1034,=
var_off=3D(0x2; 0x7fc)"},
+			{19, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1034,=
var_off=3D(0x2; 0x7fc)"},
=20
 		},
 	},
@@ -556,14 +556,14 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{7, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{10, "R6_w=3Dinv(id=3D0,umax_value=3D60,var_off=3D(0x0; 0x3c))"},
+			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
+			{9, "R6_w=3Dinv(id=3D0,umax_value=3D60,var_off=3D(0x0; 0x3c))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{11, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D74,var_off=3D(0x=
2; 0x7c))"},
+			{10, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D74,var_off=3D(0x=
2; 0x7c))"},
 			/* Subtracting from packet pointer overflows ubounds */
 			{13, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D8,umin_value=3D184467440737095515=
42,umax_value=3D18446744073709551602,var_off=3D(0xffffffffffffff82; 0x7c)=
"},
 			/* New unknown value in R7 is (4n), >=3D 76 */
-			{15, "R7_w=3Dinv(id=3D0,umin_value=3D76,umax_value=3D1096,var_off=3D(=
0x0; 0x7fc))"},
+			{14, "R7_w=3Dinv(id=3D0,umin_value=3D76,umax_value=3D1096,var_off=3D(=
0x0; 0x7fc))"},
 			/* Adding it to packet pointer gives nice bounds again */
 			{16, "R5_w=3Dpkt(id=3D3,off=3D0,r=3D0,umin_value=3D2,umax_value=3D108=
2,var_off=3D(0x2; 0xfffffffc)"},
 			/* At the time the word size load is performed from R5,
@@ -572,7 +572,7 @@ static struct bpf_align_test tests[] =3D {
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D3,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1082,=
var_off=3D(0x2; 0xfffffffc)"},
+			{19, "R5=3Dpkt(id=3D3,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1082,=
var_off=3D(0x2; 0xfffffffc)"},
 		},
 	},
 };
@@ -642,7 +642,19 @@ static int do_test_single(struct bpf_align_test *tes=
t)
 				printf("%s", bpf_vlog);
 				break;
 			}
+			/* Check the next line as well in case the previous line
+			 * did not have a corresponding bpf insn. Example:
+			 * func#0 @0
+			 * 0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
+			 * 0: (b7) r3 =3D 2                 ; R3_w=3Dinv2
+			 */
 			if (!strstr(line_ptr, m.match)) {
+				cur_line =3D -1;
+				line_ptr =3D strtok(NULL, "\n");
+				sscanf(line_ptr, "%u: ", &cur_line);
+			}
+			if (cur_line !=3D m.line || !line_ptr ||
+				!strstr(line_ptr, m.match)) {
 				printf("Failed to find match %u: %s\n",
 				       m.line, m.match);
 				ret =3D 1;
--=20
2.30.2

