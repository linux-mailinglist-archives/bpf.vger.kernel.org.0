Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197458BC1E
	for <lists+bpf@lfdr.de>; Sun,  7 Aug 2022 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiHGRvg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:51:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BA5FC7
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:51:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277DFj9K023624
        for <bpf@vger.kernel.org>; Sun, 7 Aug 2022 10:51:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AEFWEz2gb7k07AEp2VCM2So/EzbcasoLsLHcb+6r+wY=;
 b=qW+zM+l7AonIeLThKx0WYzkPAQ9XAgBLGG892HwdUxkqItYFsw6UIqwf91uIi6QLBolf
 d6MD9KtuJU7HuI06O/DewDV8mucaFs5jYZvTtnoW8cvzMxL9OvRpRnLbQyO97JSroEqU
 Q1aDzBEYYfSi9BZCkxp7DGr5cAO4jdTH/YI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsndtdkj1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Aug 2022 10:51:35 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 10:51:33 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BA03ADC759B6; Sun,  7 Aug 2022 10:51:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: Perform necessary sign/zero extension for kfunc return values
Date:   Sun, 7 Aug 2022 10:51:21 -0700
Message-ID: <20220807175121.4179410-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220807175111.4178812-1-yhs@fb.com>
References: <20220807175111.4178812-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EdsNtMlxSCaTUHZRksPRWEBWpR7slfis
X-Proofpoint-ORIG-GUID: EdsNtMlxSCaTUHZRksPRWEBWpR7slfis
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_11,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tejun reported a bpf program kfunc return value mis-handling which
may cause incorrect result. The following is an example to show
the problem.
  $ cat t.c
  unsigned char bar();
  int foo() {
        if (bar() !=3D 10) return 0; else return 1;
  }
  $ clang -target bpf -O2 -c t.c
  $ llvm-objdump -d t.o
  ...
  0000000000000000 <foo>:
       0:       85 10 00 00 ff ff ff ff call -1
       1:       bf 01 00 00 00 00 00 00 r1 =3D r0
       2:       b7 00 00 00 01 00 00 00 r0 =3D 1
       3:       15 01 01 00 0a 00 00 00 if r1 =3D=3D 10 goto +1 <LBB0_2>
       4:       b7 00 00 00 00 00 00 00 r0 =3D 0

  0000000000000028 <LBB0_2>:
       5:       95 00 00 00 00 00 00 00 exit
  $

In the above example, the return type for bar() is 'unsigned char'.
But in the disassembly code, the whole register 'r1' is used to
compare to 10 without truncating upper 56 bits.

If function bar() is implemented as a bpf function, everything
should be okay since bpf ABI will make sure the caller do
proper truncation of upper 56 bits.

But if function bar() is implemented as a non-bpf kfunc,
there could a mismatch between bar() implementation and bpf program.
For example, if the host arch is x86_64, the bar() function
may just put the return value in lower 8-bit subregister and all
upper 56 bits could contain garbage. This is not a problem
if bar() is called in x86_64 context as the caller will use
%al to get the value.

But this could be a problem if bar() is called in bpf context
and there is a mismatch expectation between bpf and native architecture.
Currently, bpf programs use the default llvm ABI ([1], function
isPromotableIntegerTypeForABI()) such that if an integer type size
is less than int type size, it is assumed proper sign or zero
extension has been done to the return value. There will be a problem
if the kfunc return value type is u8/s8/u16/s16.

This patch intends to address this issue by doing proper sign or zero
extension for the kfunc return value before it is used later.

 [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/Targe=
tInfo.cpp

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/btf.c      |  9 +++++++++
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..b6f6bb1b707d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -727,6 +727,8 @@ enum bpf_cgroup_storage_type {
 #define MAX_BPF_FUNC_REG_ARGS 5
=20
 struct btf_func_model {
+	u8 ret_integer:1;
+	u8 ret_integer_signed:1;
 	u8 ret_size;
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8119dc3994db..f30a02018701 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5897,6 +5897,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *l=
og,
 	u32 i, nargs;
 	int ret;
=20
+	m->ret_integer =3D false;
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
 		 * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
@@ -5923,6 +5924,14 @@ int btf_distill_func_proto(struct bpf_verifier_log *=
log,
 		return -EINVAL;
 	}
 	m->ret_size =3D ret;
+	if (btf_type_is_int(t)) {
+		m->ret_integer =3D true;
+		/* BTF_INT_BOOL is considered as unsigned */
+		if (BTF_INT_ENCODING(btf_type_int(t)) =3D=3D BTF_INT_SIGNED)
+			m->ret_integer_signed =3D true;
+		else
+			m->ret_integer_signed =3D false;
+	}
=20
 	for (i =3D 0; i < nargs; i++) {
 		if (i =3D=3D nargs - 1 && args[i].type =3D=3D 0) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..684f8606f341 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13834,8 +13834,9 @@ static int fixup_call_args(struct bpf_verifier_env =
*env)
 }
=20
 static int fixup_kfunc_call(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn)
+			    struct bpf_insn *insn, struct bpf_insn *insn_buf, int *cnt)
 {
+	u8 ret_size, shift_cnt, rshift_opcode;
 	const struct bpf_kfunc_desc *desc;
=20
 	if (!insn->imm) {
@@ -13855,6 +13856,26 @@ static int fixup_kfunc_call(struct bpf_verifier_en=
v *env,
=20
 	insn->imm =3D desc->imm;
=20
+	*cnt =3D 0;
+	ret_size =3D desc->func_model.ret_size;
+
+	/* If the kfunc return type is an integer and the type size is one byte o=
r two
+	 * bytes, currently llvm/bpf assumes proper sign/zero extension has been =
done
+	 * in the caller. But such an asumption may not hold for non-bpf architec=
tures.
+	 * For example, for x86_64, if the return type is 'u8', it is possible th=
at only
+	 * %al register is set properly and upper 56 bits of %rax register may co=
ntain
+	 * garbage. To resolve this case, Let us do a necessary truncation to zer=
o-out
+	 * or properly sign-extend upper 56 bits.
+	 */
+	if (desc->func_model.ret_integer && ret_size < sizeof(int)) {
+		shift_cnt =3D (sizeof(u64) - ret_size) * 8;
+		rshift_opcode =3D desc->func_model.ret_integer_signed ? BPF_ARSH : BPF_R=
SH;
+		insn_buf[0] =3D *insn;
+		insn_buf[1] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, shift_cnt);
+		insn_buf[2] =3D BPF_ALU64_IMM(rshift_opcode, BPF_REG_0, shift_cnt);
+		*cnt =3D 3;
+	}
+
 	return 0;
 }
=20
@@ -13996,9 +14017,19 @@ static int do_misc_fixups(struct bpf_verifier_env =
*env)
 		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 			continue;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
-			ret =3D fixup_kfunc_call(env, insn);
+			ret =3D fixup_kfunc_call(env, insn, insn_buf, &cnt);
 			if (ret)
 				return ret;
+			if (cnt =3D=3D 0)
+				continue;
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn      =3D new_prog->insnsi + i + delta;
 			continue;
 		}
=20
--=20
2.30.2

