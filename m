Return-Path: <bpf+bounces-16438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADD88012E2
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A85B1C2102F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8505102A;
	Fri,  1 Dec 2023 18:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6010131
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:34:38 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1IA5je029038
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 10:34:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uqf8sjewc-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:34:37 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:34:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6501B3C6DB501; Fri,  1 Dec 2023 10:34:23 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Shung-Hsi Yu
	<shung-hsi.yu@suse.com>
Subject: [PATCH v4 bpf-next 11/11] bpf: simplify tnum output if a fully known constant
Date: Fri, 1 Dec 2023 10:33:59 -0800
Message-ID: <20231201183359.1769668-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201183359.1769668-1-andrii@kernel.org>
References: <20231201183359.1769668-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Hp4eGYQlUHjQXXZdUlJs23jKWV92OFRl
X-Proofpoint-ORIG-GUID: Hp4eGYQlUHjQXXZdUlJs23jKWV92OFRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_16,2023-11-30_01,2023-05-22_02

Emit tnum representation as just a constant if all bits are known.
Use decimal-vs-hex logic to determine exact format of emitted
constant value, just like it's done for register range values.
For that move tnum_strn() to kernel/bpf/log.c to reuse decimal-vs-hex
determination logic and constants.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                                    | 13 +++++++++++++
 kernel/bpf/tnum.c                                   |  6 ------
 .../bpf/progs/verifier_direct_packet_access.c       |  2 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c  |  2 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c        |  4 ++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 3505f3e5ae96..55d019f30e91 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -539,6 +539,19 @@ static void verbose_snum(struct bpf_verifier_env *en=
v, s64 num)
 		verbose(env, "%#llx", num);
 }
=20
+int tnum_strn(char *str, size_t size, struct tnum a)
+{
+	/* print as a constant, if tnum is fully known */
+	if (a.mask =3D=3D 0) {
+		if (is_unum_decimal(a.value))
+			return snprintf(str, size, "%llu", a.value);
+		else
+			return snprintf(str, size, "%#llx", a.value);
+	}
+	return snprintf(str, size, "(%#llx; %#llx)", a.value, a.mask);
+}
+EXPORT_SYMBOL_GPL(tnum_strn);
+
 static void print_scalar_ranges(struct bpf_verifier_env *env,
 				const struct bpf_reg_state *reg,
 				const char **sep)
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f4c91c9b27d7..9dbc31b25e3d 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -172,12 +172,6 @@ bool tnum_in(struct tnum a, struct tnum b)
 	return a.value =3D=3D b.value;
 }
=20
-int tnum_strn(char *str, size_t size, struct tnum a)
-{
-	return snprintf(str, size, "(%#llx; %#llx)", a.value, a.mask);
-}
-EXPORT_SYMBOL_GPL(tnum_strn);
-
 int tnum_sbin(char *str, size_t size, struct tnum a)
 {
 	size_t n;
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_acc=
ess.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 99a23dea8233..be95570ab382 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -411,7 +411,7 @@ l0_%=3D:	r0 =3D 0;						\
=20
 SEC("tc")
 __description("direct packet access: test17 (pruning, alignment)")
-__failure __msg("misaligned packet access off 2+(0x0; 0x0)+15+-4 size 4"=
)
+__failure __msg("misaligned packet access off 2+0+15+-4 size 4")
 __flag(BPF_F_STRICT_ALIGNMENT)
 __naked void packet_access_test17_pruning_alignment(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_int_ptr.c
index b054f9c48143..74d9cad469d9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -67,7 +67,7 @@ __naked void ptr_to_long_half_uninitialized(void)
=20
 SEC("cgroup/sysctl")
 __description("ARG_PTR_TO_LONG misaligned")
-__failure __msg("misaligned stack access off (0x0; 0x0)+-20+0 size 8")
+__failure __msg("misaligned stack access off 0+-20+0 size 8")
 __naked void arg_ptr_to_long_misaligned(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_ptr.c
index e0f77e3e7869..417c61cd4b19 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -37,7 +37,7 @@ __naked void ptr_to_stack_store_load(void)
=20
 SEC("socket")
 __description("PTR_TO_STACK store/load - bad alignment on off")
-__failure __msg("misaligned stack access off (0x0; 0x0)+-8+2 size 8")
+__failure __msg("misaligned stack access off 0+-8+2 size 8")
 __failure_unpriv
 __naked void load_bad_alignment_on_off(void)
 {
@@ -53,7 +53,7 @@ __naked void load_bad_alignment_on_off(void)
=20
 SEC("socket")
 __description("PTR_TO_STACK store/load - bad alignment on reg")
-__failure __msg("misaligned stack access off (0x0; 0x0)+-10+8 size 8")
+__failure __msg("misaligned stack access off 0+-10+8 size 8")
 __failure_unpriv
 __naked void load_bad_alignment_on_reg(void)
 {
--=20
2.34.1


