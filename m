Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2B6D4EF5
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjDCR3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjDCR3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 13:29:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2321BE4
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 10:29:10 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333GlRrB000332;
        Mon, 3 Apr 2023 17:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2jdK+vmpcKywKdd3N5R0+BsV+fPX1W+tALrCSnAt4KI=;
 b=fJb1n5kwoxEZIBcINPzmB2CmgZUrAAleve0IttmzPHffl9Yvc5MUSWKe+eqaAlioGTTq
 5nWTjurjbXCpZlipZgxyVV33wnT4FEh4r3VkrSeDTv3wgTRZZ6c9SiuyoBn5aXF2lj0B
 liU/71cwPJ2P++JWQUrzfENwBwFDgy6fbHX7TdTWnc7ij5+UGadPI/c+Rs+R70qdNiZO
 61/KXWpw7+FOOK0P4oQgwKnhNuu4ocSrbqd9HzTrElwnjja8QluWQCP4SjSJF9bnj8tB
 9ted/tRc+VFKZFbv1eaoRXDMSdz/PM/sg8qiGySR90y9VRRNnVyR0G23/kHh/jhI9ea3 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pr2mbrxej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:28:48 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333HSmtG010875;
        Mon, 3 Apr 2023 17:28:48 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pr2mbrxe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:28:48 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 332NALjp005225;
        Mon, 3 Apr 2023 17:28:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc879wfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:28:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 333HSfp219923526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 17:28:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2439120043;
        Mon,  3 Apr 2023 17:28:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61DE020040;
        Mon,  3 Apr 2023 17:28:40 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.72.121])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 17:28:40 +0000 (GMT)
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
Subject: [PATCH bpf-next v4] bpf: Support 64-bit pointers to kfuncs
Date:   Mon,  3 Apr 2023 19:28:33 +0200
Message-Id: <20230403172833.1552354-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n-Qcj5HipmqyZejATuoZcLsG9sPC1xK6
X-Proofpoint-ORIG-GUID: 77H8q6Tfk_IuRfHH9UHMbOe0Xxq85BCT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_14,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030128
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

v3: https://lore.kernel.org/bpf/20230222223714.80671-1-iii@linux.ibm.com/
v3 -> v4: Use Jiri's proposal and make it work on s390x.

 arch/s390/net/bpf_jit_comp.c |   5 ++
 include/linux/bpf.h          |   2 +
 include/linux/filter.h       |   1 +
 kernel/bpf/core.c            |  11 ++++
 kernel/bpf/verifier.c        | 116 +++++++++++++++++++++++++----------
 5 files changed, 101 insertions(+), 34 deletions(-)

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
index 2d8f3f639e68..b60945e135ee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2296,6 +2296,8 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
+		       u8 **func_addr);
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 23c08c31bea9..e2bf9d4e6081 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -921,6 +921,7 @@ void bpf_jit_compile(struct bpf_prog *prog);
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
index 92ae4e8ab87b..873822e3a8f9 100644
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
@@ -2672,7 +2691,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
-	call_imm = BPF_CALL_IMM(addr);
+	call_imm = bpf_jit_supports_far_kfunc_call() ? func_id :
+						       BPF_CALL_IMM(addr);
 	/* Check whether or not the relative offset overflows desc->imm */
 	if ((unsigned long)(s32)call_imm != call_imm) {
 		verbose(env, "address of kernel function %s is out of range\n",
@@ -2690,6 +2710,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	desc->func_id = func_id;
 	desc->imm = call_imm;
 	desc->offset = offset;
+	desc->addr = addr;
 	err = btf_distill_func_proto(&env->log, desc_btf,
 				     func_proto, func_name,
 				     &desc->func_model);
@@ -2699,19 +2720,15 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
-	return 0;
+	return d0->imm - d1->imm ?: d0->offset - d1->offset;
 }
 
-static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
+static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
 {
 	struct bpf_kfunc_desc_tab *tab;
 
@@ -2720,7 +2737,7 @@ static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
 		return;
 
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm, NULL);
+	     kfunc_desc_cmp_by_imm_off, NULL);
 }
 
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
@@ -2734,13 +2751,14 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
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
@@ -17293,11 +17311,59 @@ static int fixup_call_args(struct bpf_verifier_env *env)
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
@@ -17306,16 +17372,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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
 	/* insn->imm has the btf func_id. Replace it with
 	 * an address (relative to __bpf_call_base).
 	 */
@@ -17326,7 +17382,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	insn->imm = desc->imm;
+	if (!bpf_jit_supports_far_kfunc_call())
+		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
 		return 0;
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
@@ -17351,17 +17408,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -17384,6 +17430,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
 
+	fixup_kfunc_desc_tab(env);
+
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
@@ -17891,7 +17939,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm(env->prog);
+	sort_kfunc_descs_by_imm_off(env->prog);
 
 	return 0;
 }
-- 
2.39.2

