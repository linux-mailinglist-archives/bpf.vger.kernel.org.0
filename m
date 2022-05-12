Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D98524737
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbiELHno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351137AbiELHnl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E261A15E7
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:40 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwgpq003879
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GAWHF80PzUf5Vy5JJlMs/tfXeR0+CBf77VMkcjKXBXI=;
 b=J5drIK5CX5+arikxBGDc/pdK7aSbIZivXnRml40SeSJQqMBoY0NXRGNms1CQvxPginOz
 spnp3wWbtDqF6kmB1KMUxtp1fQK+FBXfOAXzJTo7A1bc23Jie5N90fSNGAvNYX08KyKs
 B5RybbvPAnSEQrFG/MXSEUMsqzQKwm0M4TY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04pmrt6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:39 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:39 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3497D78F7CCC; Thu, 12 May 2022 00:43:29 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 3/5] libbpf: usdt lib wiring of xmm reads
Date:   Thu, 12 May 2022 00:43:19 -0700
Message-ID: <20220512074321.2090073-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512074321.2090073-1-davemarchevsky@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A9hHejmrZESVU9Fw_9DsHBNVWrGkedLZ
X-Proofpoint-GUID: A9hHejmrZESVU9Fw_9DsHBNVWrGkedLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Handle xmm0,...,xmm15 registers when parsing USDT arguments. Currently
only the first 64 bits of the fetched value are returned as I haven't
seen the rest of the register used in practice.

This patch also handles floats in USDT arg spec by ignoring the fact
that they're floats and considering them scalar. Currently we can't do
float math in BPF programs anyways, so might as well support passing to
userspace and converting there.

We can use existing ARG_REG sscanf + logic, adding XMM-specific logic
when calc_pt_regs_off fails. If the reg is xmm, arg_spec's reg_off is
repurposed to hold reg_no, which is passed to bpf_get_reg_val. Since the
helper does the digging around in fxregs_state it's not necessary to
calculate offset in bpf code for these regs.

NOTE: Changes here cause verification failure for existing USDT tests.
Specifically, BPF_USDT prog 'usdt12' fails to verify due to too many
insns despite not having its insn count significantly changed.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/usdt.bpf.h | 36 ++++++++++++++++++++--------
 tools/lib/bpf/usdt.c     | 51 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 4181fddb3687..7b5ed4cbaa2f 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -43,6 +43,7 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_XMM_REG,
 };
=20
 struct __bpf_usdt_arg_spec {
@@ -129,7 +130,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	struct pt_regs *btf_regs;
+	struct task_struct *btf_task;
+	struct { __u64 a; __u64 unused; } val =3D {};
 	int err, spec_id;
=20
 	*res =3D 0;
@@ -151,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
 		/* Arg is just a constant ("-4@$-9" in USDT arg spec).
 		 * value is recorded in arg_spec->val_off directly.
 		 */
-		val =3D arg_spec->val_off;
+		val.a =3D arg_spec->val_off;
 		break;
 	case BPF_USDT_ARG_REG:
 		/* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
@@ -159,7 +162,20 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
 long *res)
 		 * struct pt_regs. To keep things simple user-space parts
 		 * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
 		 */
-		err =3D bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spe=
c->reg_off);
+		err =3D bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg=
_spec->reg_off);
+		if (err)
+			return err;
+		break;
+	case BPF_USDT_ARG_XMM_REG:
+		/* Same as above, but arg is an xmm reg, so can't look
+		 * in pt_regs, need to use special helper.
+		 * reg_off is the regno ("xmm0" -> regno 0, etc)
+		 */
+		btf_task =3D bpf_get_current_task_btf();
+		btf_regs =3D (struct pt_regs *)bpf_task_pt_regs(btf_task);
+		err =3D bpf_get_reg_val(&val, sizeof(val),
+				     ((u64)arg_spec->reg_off + BPF_GETREG_X86_XMM0) << 32,
+				     btf_regs, btf_task);
 		if (err)
 			return err;
 		break;
@@ -171,14 +187,14 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num=
, long *res)
 		 * from pt_regs, then do another user-space probe read to
 		 * fetch argument value itself.
 		 */
-		err =3D bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spe=
c->reg_off);
+		err =3D bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg=
_spec->reg_off);
 		if (err)
 			return err;
-		err =3D bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec-=
>val_off);
+		err =3D bpf_probe_read_user(&val.a, sizeof(val.a), (void *)val.a + arg=
_spec->val_off);
 		if (err)
 			return err;
 #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
-		val >>=3D arg_spec->arg_bitshift;
+		val.a >>=3D arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
@@ -189,12 +205,12 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num=
, long *res)
 	 * necessary upper arg_bitshift bits, with sign extension if argument
 	 * is signed
 	 */
-	val <<=3D arg_spec->arg_bitshift;
+	val.a <<=3D arg_spec->arg_bitshift;
 	if (arg_spec->arg_signed)
-		val =3D ((long)val) >> arg_spec->arg_bitshift;
+		val.a =3D ((long)val.a) >> arg_spec->arg_bitshift;
 	else
-		val =3D val >> arg_spec->arg_bitshift;
-	*res =3D val;
+		val.a =3D val.a >> arg_spec->arg_bitshift;
+	*res =3D val.a;
 	return 0;
 }
=20
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index f1c9339cfbbc..3cac48959ff9 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -199,6 +199,7 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_XMM_REG,
 };
=20
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
@@ -1218,7 +1219,41 @@ static int calc_pt_regs_off(const char *reg_name)
 		}
 	}
=20
-	pr_warn("usdt: unrecognized register '%s'\n", reg_name);
+	return -ENOENT;
+}
+
+static int calc_xmm_regno(const char *reg_name)
+{
+	static struct {
+		const char *name;
+		__u16 regno;
+	} xmm_reg_map[] =3D {
+		{ "xmm0",  0 },
+		{ "xmm1",  1 },
+		{ "xmm2",  2 },
+		{ "xmm3",  3 },
+		{ "xmm4",  4 },
+		{ "xmm5",  5 },
+		{ "xmm6",  6 },
+		{ "xmm7",  7 },
+#ifdef __x86_64__
+		{ "xmm8",  8 },
+		{ "xmm9",  9 },
+		{ "xmm10",  10 },
+		{ "xmm11",  11 },
+		{ "xmm12",  12 },
+		{ "xmm13",  13 },
+		{ "xmm14",  14 },
+		{ "xmm15",  15 },
+#endif
+	};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(xmm_reg_map); i++) {
+		if (strcmp(reg_name, xmm_reg_map[i].name) =3D=3D 0)
+			return xmm_reg_map[i].regno;
+	}
+
 	return -ENOENT;
 }
=20
@@ -1234,18 +1269,26 @@ static int parse_usdt_arg(const char *arg_str, in=
t arg_num, struct usdt_arg_spec
 		arg->val_off =3D off;
 		reg_off =3D calc_pt_regs_off(reg_name);
 		free(reg_name);
-		if (reg_off < 0)
+		if (reg_off < 0) {
+			pr_warn("usdt: unrecognized register '%s'\n", reg_name);
 			return reg_off;
+		}
 		arg->reg_off =3D reg_off;
-	} else if (sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len) =
=3D=3D 2) {
+	} else if (sscanf(arg_str, " %d %*[f@] %%%ms %n", &arg_sz, &reg_name, &=
len) =3D=3D 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type =3D USDT_ARG_REG;
 		arg->val_off =3D 0;
=20
 		reg_off =3D calc_pt_regs_off(reg_name);
+		if (reg_off < 0) {
+			reg_off =3D calc_xmm_regno(reg_name);
+			arg->arg_type =3D USDT_ARG_XMM_REG;
+		}
 		free(reg_name);
-		if (reg_off < 0)
+		if (reg_off < 0) {
+			pr_warn("usdt: unrecognized register '%s'\n", reg_name);
 			return reg_off;
+		}
 		arg->reg_off =3D reg_off;
 	} else if (sscanf(arg_str, " %d @ $%ld %n", &arg_sz, &off, &len) =3D=3D=
 2) {
 		/* Constant value case, e.g., 4@$71 */
--=20
2.30.2

