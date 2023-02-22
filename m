Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2B69FEB8
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjBVWvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjBVWvV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:51:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2052E0EF
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:51:19 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MLj7kg010407;
        Wed, 22 Feb 2023 22:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xpyc/Nfl+1l9f9gYxUxD215Hz0NhydtxOKmHFaVwtXI=;
 b=MKK2BvEml7wpYZp99Facr8yDh2GK7XrI96EUJyzjDG1XCP04oKO2YGcpiu+mj1QmpYRx
 zzw+/jfMDP7+rSfaLRtC3RMeq/XH887KJdeYSuw+QALHAu0RRa3TbWAdaAqK+fMxXYTM
 uINrlG5/xbCTQ8sIfOBdf9UVvGOgBEZBGqYIX6cGeEV7phI3vCXebmxn+5h9ZxYkB8og
 c1iOyuclotu0DZ7tD1Qxa4K2FpwePBEClvQSelXS72Eo7tR50SI4me9qX+chThykYkGz
 URRIwcrdP7yUQrC52OqgJhhwfNOj6esQxrUxbIgQLsudTI5tzptQ6MnUyp4ZaprOYKeR zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwu7x143v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:38 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMajAD016597;
        Wed, 22 Feb 2023 22:37:38 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwu7x142t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31M2if8W022436;
        Wed, 22 Feb 2023 22:37:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6cg5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbWRt48038356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 946732004B;
        Wed, 22 Feb 2023 22:37:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE78C20040;
        Wed, 22 Feb 2023 22:37:31 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:31 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 11/12] bpf: Support 64-bit pointers to kfuncs
Date:   Wed, 22 Feb 2023 23:37:13 +0100
Message-Id: <20230222223714.80671-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z8wx8NGo-gnT9ttgGBIBdlAIIMAmA1vK
X-Proofpoint-GUID: UYKqfJs9gGHYZG6wqJrQDkGO8SsparJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_ksyms_module fails to emit a kfunc call targeting a module on
s390x, because the verifier stores the difference between kfunc
address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
are roughly (1 << 42) bytes away from the kernel on s390x.

Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
and storing the absolute address in bpf_kfunc_desc, which JITs retrieve
as usual by calling bpf_jit_get_func_addr().

Introduce bpf_get_kfunc_addr() instead of exposing both
find_kfunc_desc() and struct bpf_kfunc_desc.

This also fixes the problem with XDP metadata functions outlined in
the description of commit 63d7b53ab59f ("s390/bpf: Implement
bpf_jit_supports_kfunc_call()") by replacing address lookups with BTF
id lookups. This eliminates the inconsistency between "abstract" XDP
metadata functions' BTF ids and their concrete addresses.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/core.c     | 21 ++++++++++--
 kernel/bpf/verifier.c | 79 +++++++++++++------------------------------
 3 files changed, 44 insertions(+), 58 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520b238abd5a..e521eae334ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2234,6 +2234,8 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
+		       u8 **func_addr);
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 933869983e2a..4d51782f17ab 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1185,10 +1185,12 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 {
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool fixed;
 	u8 *addr;
+	int err;
 
-	*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
-	if (!*func_addr_fixed) {
+	switch (insn->src_reg) {
+	case BPF_PSEUDO_CALL:
 		/* Place-holder address till the last pass has collected
 		 * all addresses for JITed subprograms in which case we
 		 * can pick them up from prog->aux.
@@ -1200,15 +1202,28 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			addr = (u8 *)prog->aux->func[off]->bpf_func;
 		else
 			return -EINVAL;
-	} else {
+		fixed = false;
+		break;
+	case 0:
 		/* Address of a BPF helper call. Since part of the core
 		 * kernel, it's always at a fixed location. __bpf_call_base
 		 * and the helper with imm relative to it are both in core
 		 * kernel.
 		 */
 		addr = (u8 *)__bpf_call_base + imm;
+		fixed = true;
+		break;
+	case BPF_PSEUDO_KFUNC_CALL:
+		err = bpf_get_kfunc_addr(prog, imm, off, &addr);
+		if (err)
+			return err;
+		fixed = true;
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	*func_addr_fixed = fixed;
 	*func_addr = (unsigned long)addr;
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 574d2dfc6ada..6d4632476c9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2115,8 +2115,8 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
 	u32 func_id;
-	s32 imm;
 	u16 offset;
+	unsigned long addr;
 };
 
 struct bpf_kfunc_btf {
@@ -2166,6 +2166,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
+		       u8 **func_addr)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc = find_kfunc_desc(prog, func_id, offset);
+	if (!desc)
+		return -EFAULT;
+
+	*func_addr = (u8 *)desc->addr;
+	return 0;
+}
+
 static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 					 s16 offset)
 {
@@ -2261,8 +2274,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	struct bpf_kfunc_desc *desc;
 	const char *func_name;
 	struct btf *desc_btf;
-	unsigned long call_imm;
 	unsigned long addr;
+	void *xdp_kfunc;
 	int err;
 
 	prog_aux = env->prog->aux;
@@ -2346,24 +2359,21 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
-	call_imm = BPF_CALL_IMM(addr);
-	/* Check whether or not the relative offset overflows desc->imm */
-	if ((unsigned long)(s32)call_imm != call_imm) {
-		verbose(env, "address of kernel function %s is out of range\n",
-			func_name);
-		return -EINVAL;
-	}
-
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
 		if (err)
 			return err;
+
+		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, func_id);
+		if (xdp_kfunc)
+			addr = (unsigned long)xdp_kfunc;
+		/* fallback to default kfunc when not supported by netdev */
 	}
 
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
-	desc->imm = call_imm;
 	desc->offset = offset;
+	desc->addr = addr;
 	err = btf_distill_func_proto(&env->log, desc_btf,
 				     func_proto, func_name,
 				     &desc->func_model);
@@ -2373,30 +2383,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	return err;
 }
 
-static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
-{
-	const struct bpf_kfunc_desc *d0 = a;
-	const struct bpf_kfunc_desc *d1 = b;
-
-	if (d0->imm > d1->imm)
-		return 1;
-	else if (d0->imm < d1->imm)
-		return -1;
-	return 0;
-}
-
-static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
-{
-	struct bpf_kfunc_desc_tab *tab;
-
-	tab = prog->aux->kfunc_tab;
-	if (!tab)
-		return;
-
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm, NULL);
-}
-
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
 {
 	return !!prog->aux->kfunc_tab;
@@ -2407,14 +2393,15 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn)
 {
 	const struct bpf_kfunc_desc desc = {
-		.imm = insn->imm,
+		.func_id = insn->imm,
+		.offset = insn->off,
 	};
 	const struct bpf_kfunc_desc *res;
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
 	res = bsearch(&desc, tab->descs, tab->nr_descs,
-		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
+		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 
 	return res ? &res->func_model : NULL;
 }
@@ -16267,7 +16254,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
-	void *xdp_kfunc;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -16275,20 +16261,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	*cnt = 0;
-
-	if (bpf_dev_bound_kfunc_id(insn->imm)) {
-		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, insn->imm);
-		if (xdp_kfunc) {
-			insn->imm = BPF_CALL_IMM(xdp_kfunc);
-			return 0;
-		}
-
-		/* fallback to default kfunc when not supported by netdev */
-	}
-
-	/* insn->imm has the btf func_id. Replace it with
-	 * an address (relative to __bpf_call_base).
-	 */
 	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
 	if (!desc) {
 		verbose(env, "verifier internal error: kernel function descriptor not found for func_id %u\n",
@@ -16296,7 +16268,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	insn->imm = desc->imm;
 	if (insn->off)
 		return 0;
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
@@ -16850,8 +16821,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm(env->prog);
-
 	return 0;
 }
 
-- 
2.39.1

