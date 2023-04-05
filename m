Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373836D899E
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDEVfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjDEVfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 17:35:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5257ABA
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 14:35:18 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Kp9KK013192;
        Wed, 5 Apr 2023 21:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=+OgwwgTEiYQOn+W8dfdcUQsVkF8w/9NARbXyWq4FNfk=;
 b=eX4pomAJC6qBO3GxM1Jb4c5nwpEx7mK/bBU5SdWP1XD/TSm8wCSwvImantkUlYe9Qjs+
 1KjEBGGSAmJYeh4SDTQRb+mr9CKZhnCZJDNQ3TpTIcLqXO8xBgcf2GTOUcxQMIzqSfnS
 xeGJKi2y5h6a5anpdlwrMxD/xoehfw7JXWzT96pnr51XiFNIk+GfBwAPKp6f0TNuHRap
 7rU7jvOow7DZX+qIjfMQiYl8yn43TpkXv2LFBY9Q4KlLqHsU2+goWX+2Pvc006CR+diX
 0EPnLZ9PoYpoCA2HMCyONqUlKUzHw4HRiy6sbPVqFhawnAOM6+cbkuKGqsIgKvuyh8Ed vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8w85752-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 21:35:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 335LUjlr009898;
        Wed, 5 Apr 2023 21:35:01 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8w8574h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 21:35:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3351M4DC007900;
        Wed, 5 Apr 2023 21:34:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ppc872rj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 21:34:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335LYtXb29426404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 21:34:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5C3320043;
        Wed,  5 Apr 2023 21:34:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37C3820040;
        Wed,  5 Apr 2023 21:34:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.11.155])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 21:34:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v6] bpf: Support 64-bit pointers to kfuncs
Date:   Wed,  5 Apr 2023 23:34:53 +0200
Message-Id: <20230405213453.49756-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hlq4IEgJ_vYsGL0vrqB25lUqSua483AJ
X-Proofpoint-ORIG-GUID: QTTLybKJbTYjYtuEWEOVCTZzuyhnFe0X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050192
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
and storing the absolute address in bpf_kfunc_desc.

Introduce bpf_jit_supports_far_kfunc_call() in order to limit this new
behavior to the s390x JIT. Otherwise other JITs need to be modified,
which is not desired.

Introduce bpf_get_kfunc_addr() instead of exposing both
find_kfunc_desc() and struct bpf_kfunc_desc.

In addition to sorting kfuncs by imm, also sort them by offset, in
order to handle conflicting imms from different modules. Do this on
all architectures in order to simplify code.

Factor out resolving specialized kfuncs (XPD and dynptr) from
fixup_kfunc_call(). This was required in the first place, because
fixup_kfunc_call() uses find_kfunc_desc(), which returns a const
pointer, so it's not possible to modify kfunc addr without stripping
const, which is not nice. It also removes repetition of code like:

	if (bpf_jit_supports_far_kfunc_call())
		desc->addr = func;
	else
		insn->imm = BPF_CALL_IMM(func);

and separates kfunc_desc_tab fixups from kfunc_call fixups.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v5: https://lore.kernel.org/bpf/20230405141407.172357-1-iii@linux.ibm.com/
v5 -> v6: Fix build with !CONFIG_BPF_SYSCALL by moving bpf_get_kfunc_addr()
          declaration outside of the respective ifdef.
          Reported-by: kernel test robot <lkp@intel.com>
          Link: https://lore.kernel.org/oe-kbuild-all/202304060240.OeUgnjzZ-lkp@intel.com/

v4: https://lore.kernel.org/bpf/20230403172833.1552354-1-iii@linux.ibm.com/
v4 -> v5: Fix issues identified by Andrii:
          - Improve bpf_get_kfunc_addr() argument naming.
          - Do overflow check only in !bpf_jit_supports_far_kfunc_call() case.
          - Fix kfunc_desc_cmp_by_imm_off() bug when passing huge values.
          - Update fixup_kfunc_call() comment to reflect the new logic.

v3: https://lore.kernel.org/bpf/20230222223714.80671-1-iii@linux.ibm.com/
v3 -> v4: Use Jiri's proposal and make it work on s390x.

 arch/s390/net/bpf_jit_comp.c |   5 ++
 include/linux/bpf.h          |   3 +
 include/linux/filter.h       |   1 +
 kernel/bpf/core.c            |  11 +++
 kernel/bpf/verifier.c        | 137 +++++++++++++++++++++++++----------
 5 files changed, 117 insertions(+), 40 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d0846ba818ee..7102e4b674a0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2001,6 +2001,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_far_kfunc_call(void)
+{
+	return true;
+}
+
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 002a811b6b90..37115c729a0e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3035,4 +3035,7 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
+		       u16 btf_fd_idx, u8 **func_addr);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5364b0c52c1d..bbce89937fde 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -920,6 +920,7 @@ void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b297e9f60ca1..7a75fdfd707e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1187,6 +1187,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 	s16 off = insn->off;
 	s32 imm = insn->imm;
 	u8 *addr;
+	int err;
 
 	*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
 	if (!*func_addr_fixed) {
@@ -1201,6 +1202,11 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			addr = (u8 *)prog->aux->func[off]->bpf_func;
 		else
 			return -EINVAL;
+	} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+		   bpf_jit_supports_far_kfunc_call()) {
+		err = bpf_get_kfunc_addr(prog, insn->imm, insn->off, &addr);
+		if (err)
+			return err;
 	} else {
 		/* Address of a BPF helper call. Since part of the core
 		 * kernel, it's always at a fixed location. __bpf_call_base
@@ -2732,6 +2738,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_far_kfunc_call(void)
+{
+	return false;
+}
+
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f569811f70..55dd33274c40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2443,6 +2443,7 @@ struct bpf_kfunc_desc {
 	u32 func_id;
 	s32 imm;
 	u16 offset;
+	unsigned long addr;
 };
 
 struct bpf_kfunc_btf {
@@ -2452,6 +2453,11 @@ struct bpf_kfunc_btf {
 };
 
 struct bpf_kfunc_desc_tab {
+	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
+	 * verification. JITs do lookups by bpf_insn, where func_id may not be
+	 * available, therefore at the end of verification do_misc_fixups()
+	 * sorts this by imm and offset.
+	 */
 	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
 	u32 nr_descs;
 };
@@ -2492,6 +2498,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
+		       u16 btf_fd_idx, u8 **func_addr)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
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
@@ -2672,14 +2691,19 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
-	call_imm = BPF_CALL_IMM(addr);
-	/* Check whether or not the relative offset overflows desc->imm */
-	if ((unsigned long)(s32)call_imm != call_imm) {
-		verbose(env, "address of kernel function %s is out of range\n",
-			func_name);
-		return -EINVAL;
+	if (bpf_jit_supports_far_kfunc_call()) {
+		call_imm = func_id;
+	} else {
+		call_imm = BPF_CALL_IMM(addr);
+		/* Check whether the relative offset overflows desc->imm */
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel function %s is out of range\n",
+				func_name);
+			return -EINVAL;
+		}
 	}
 
+
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
 		if (err)
@@ -2690,6 +2714,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	desc->func_id = func_id;
 	desc->imm = call_imm;
 	desc->offset = offset;
+	desc->addr = addr;
 	err = btf_distill_func_proto(&env->log, desc_btf,
 				     func_proto, func_name,
 				     &desc->func_model);
@@ -2699,19 +2724,19 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	return err;
 }
 
-static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
+static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
 	const struct bpf_kfunc_desc *d1 = b;
 
-	if (d0->imm > d1->imm)
-		return 1;
-	else if (d0->imm < d1->imm)
-		return -1;
+	if (d0->imm != d1->imm)
+		return d0->imm < d1->imm ? -1 : 1;
+	if (d0->offset != d1->offset)
+		return d0->offset < d1->offset ? -1 : 1;
 	return 0;
 }
 
-static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
+static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
 {
 	struct bpf_kfunc_desc_tab *tab;
 
@@ -2720,7 +2745,7 @@ static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
 		return;
 
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm, NULL);
+	     kfunc_desc_cmp_by_imm_off, NULL);
 }
 
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
@@ -2734,13 +2759,14 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 {
 	const struct bpf_kfunc_desc desc = {
 		.imm = insn->imm,
+		.offset = insn->off,
 	};
 	const struct bpf_kfunc_desc *res;
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
 	res = bsearch(&desc, tab->descs, tab->nr_descs,
-		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
+		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
 
 	return res ? &res->func_model : NULL;
 }
@@ -17342,11 +17368,59 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
+/* replace a generic kfunc with a specialized version if necessary */
+static void fixup_kfunc_desc(struct bpf_verifier_env *env,
+			     struct bpf_kfunc_desc *desc)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 func_id = desc->func_id;
+	u16 offset = desc->offset;
+	bool seen_direct_write;
+	void *xdp_kfunc;
+	bool is_rdonly;
+
+	if (bpf_dev_bound_kfunc_id(func_id)) {
+		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
+		if (xdp_kfunc) {
+			desc->addr = (unsigned long)xdp_kfunc;
+			return;
+		}
+		/* fallback to default kfunc when not supported by netdev */
+	}
+
+	if (offset)
+		return;
+
+	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+		seen_direct_write = env->seen_direct_write;
+		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+
+		if (is_rdonly)
+			desc->addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+
+		/* restore env->seen_direct_write to its original value, since
+		 * may_access_direct_pkt_data mutates it
+		 */
+		env->seen_direct_write = seen_direct_write;
+	}
+}
+
+static void fixup_kfunc_desc_tab(struct bpf_verifier_env *env)
+{
+	struct bpf_kfunc_desc_tab *tab = env->prog->aux->kfunc_tab;
+	u32 i;
+
+	if (!tab)
+		return;
+
+	for (i = 0; i < tab->nr_descs; i++)
+		fixup_kfunc_desc(env, &tab->descs[i]);
+}
+
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
-	void *xdp_kfunc;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -17355,18 +17429,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	*cnt = 0;
 
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
+	/* insn->imm has the btf func_id. Replace it with an offset relative to
+	 * __bpf_call_base, unless the JIT needs to call functions that are
+	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
 	 */
 	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
 	if (!desc) {
@@ -17375,7 +17440,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	insn->imm = desc->imm;
+	if (!bpf_jit_supports_far_kfunc_call())
+		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
 		return 0;
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
@@ -17400,17 +17466,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		bool seen_direct_write = env->seen_direct_write;
-		bool is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
-
-		if (is_rdonly)
-			insn->imm = BPF_CALL_IMM(bpf_dynptr_from_skb_rdonly);
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
 	}
 	return 0;
 }
@@ -17433,6 +17488,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
 
+	fixup_kfunc_desc_tab(env);
+
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
@@ -17940,7 +17997,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm(env->prog);
+	sort_kfunc_descs_by_imm_off(env->prog);
 
 	return 0;
 }
-- 
2.39.2

