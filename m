Return-Path: <bpf+bounces-15794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54287F6B14
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 05:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FD91C20A06
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BE15B7;
	Fri, 24 Nov 2023 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F0D43
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:52 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO3e31w028771
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ujjnygagg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:51 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 19:59:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C713B3C057946; Thu, 23 Nov 2023 19:59:40 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: emit global subprog name in verifier logs
Date: Thu, 23 Nov 2023 19:59:35 -0800
Message-ID: <20231124035937.403208-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124035937.403208-1-andrii@kernel.org>
References: <20231124035937.403208-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NM7zTzOu4DavnlHP0c7ilCD_Zv-6dUOI
X-Proofpoint-ORIG-GUID: NM7zTzOu4DavnlHP0c7ilCD_Zv-6dUOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

We have the name, instead of emitting just func#N to identify global
subprog, augment verifier log messages with actual function name to make
it more user-friendly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 405da1f9e724..a2939ebf2638 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -339,6 +339,11 @@ struct bpf_kfunc_call_arg_meta {
=20
 struct btf *btf_vmlinux;
=20
+static const char *btf_type_name(const struct btf *btf, u32 id)
+{
+	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
+}
+
 static DEFINE_MUTEX(bpf_verifier_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
=20
@@ -418,6 +423,17 @@ static bool subprog_is_global(const struct bpf_verif=
ier_env *env, int subprog)
 	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
 }
=20
+static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
+{
+	struct bpf_func_info *info;
+
+	if (!env->prog->aux->func_info)
+		return "";
+
+	info =3D &env->prog->aux->func_info[subprog];
+	return btf_type_name(env->prog->aux->btf, info->type_id);
+}
+
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
@@ -587,11 +603,6 @@ static int iter_get_spi(struct bpf_verifier_env *env=
, struct bpf_reg_state *reg,
 	return stack_slot_obj_get_spi(env, reg, "iter", nr_slots);
 }
=20
-static const char *btf_type_name(const struct btf *btf, u32 id)
-{
-	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
-}
-
 static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_typ=
e)
 {
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
@@ -9269,13 +9280,16 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 	if (err =3D=3D -EFAULT)
 		return err;
 	if (subprog_is_global(env, subprog)) {
+		const char *sub_name =3D subprog_name(env, subprog);
+
 		if (err) {
-			verbose(env, "Caller passes invalid args into func#%d\n", subprog);
+			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
+				subprog, sub_name);
 			return err;
 		}
=20
-		if (env->log.level & BPF_LOG_LEVEL)
-			verbose(env, "Func#%d is global and valid. Skipping.\n", subprog);
+		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
+			subprog, sub_name);
 		clear_caller_saved_regs(env, caller->regs);
=20
 		/* All global functions return a 64-bit SCALAR_VALUE */
@@ -19893,9 +19907,8 @@ static int do_check_subprogs(struct bpf_verifier_=
env *env)
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
-			verbose(env,
-				"Func#%d is safe for any args that match its prototype\n",
-				i);
+			verbose(env, "Func#%d ('%s') is safe for any args that match its prot=
otype\n",
+				i, subprog_name(env, i));
 		}
 	}
 	return 0;
--=20
2.34.1


