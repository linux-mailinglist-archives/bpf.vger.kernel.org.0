Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4484A9F9A
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiBDTBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 14:01:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229903AbiBDTBH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 14:01:07 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 214IisjB008506
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 11:01:07 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e0utmmh5m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:01:07 -0800
Received: from twshared7500.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 11:01:06 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B6C40296C57C8; Fri,  4 Feb 2022 10:58:14 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v9 bpf-next 9/9] bpf, x86_64: use bpf_jit_binary_pack_alloc
Date:   Fri, 4 Feb 2022 10:57:42 -0800
Message-ID: <20220204185742.271030-10-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204185742.271030-1-song@kernel.org>
References: <20220204185742.271030-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: reu4AWDfngrHjiTM48s8yasryxqWWCVE
X-Proofpoint-GUID: reu4AWDfngrHjiTM48s8yasryxqWWCVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=944 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Use bpf_jit_binary_pack_alloc in x86_64 jit. The jit engine first writes
the program to the rw buffer. When the jit is done, the program is copied
to the final location with bpf_jit_binary_pack_finalize.

Note that we need to do bpf_tail_call_direct_fixup after finalize.
Therefore, the text_live = false logic in __bpf_arch_text_poke is no
longer needed.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 58 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c13d148f7396..643f38b91e30 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -330,8 +330,7 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 }
 
 static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-				void *old_addr, void *new_addr,
-				const bool text_live)
+				void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
@@ -365,10 +364,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		goto out;
 	ret = 1;
 	if (memcmp(ip, new_insn, X86_PATCH_SIZE)) {
-		if (text_live)
-			text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL);
-		else
-			memcpy(ip, new_insn, X86_PATCH_SIZE);
+		text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL);
 		ret = 0;
 	}
 out:
@@ -384,7 +380,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
 
-	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
+	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
 }
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
@@ -558,24 +554,15 @@ static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
 		mutex_lock(&array->aux->poke_mutex);
 		target = array->ptrs[poke->tail_call.key];
 		if (target) {
-			/* Plain memcpy is used when image is not live yet
-			 * and still not locked as read-only. Once poke
-			 * location is active (poke->tailcall_target_stable),
-			 * any parallel bpf_arch_text_poke() might occur
-			 * still on the read-write image until we finally
-			 * locked it as read-only. Both modifications on
-			 * the given image are under text_mutex to avoid
-			 * interference.
-			 */
 			ret = __bpf_arch_text_poke(poke->tailcall_target,
 						   BPF_MOD_JUMP, NULL,
 						   (u8 *)target->bpf_func +
-						   poke->adj_off, false);
+						   poke->adj_off);
 			BUG_ON(ret < 0);
 			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
 						   BPF_MOD_JUMP,
 						   (u8 *)poke->tailcall_target +
-						   X86_PATCH_SIZE, NULL, false);
+						   X86_PATCH_SIZE, NULL);
 			BUG_ON(ret < 0);
 		}
 		WRITE_ONCE(poke->tailcall_target_stable, true);
@@ -866,7 +853,7 @@ static void emit_nops(u8 **pprog, int len)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
-static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
+static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
@@ -893,8 +880,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 	push_callee_regs(&prog, callee_regs_used);
 
 	ilen = prog - temp;
-	if (image)
-		memcpy(image + proglen, temp, ilen);
+	if (rw_image)
+		memcpy(rw_image + proglen, temp, ilen);
 	proglen += ilen;
 	addrs[0] = proglen;
 	prog = temp;
@@ -1323,6 +1310,9 @@ st:			if (is_imm8(insn->off))
 					pr_err("extable->insn doesn't fit into 32-bit\n");
 					return -EFAULT;
 				}
+				/* switch ex to rw buffer for writes */
+				ex = (void *)rw_image + ((void *)ex - (void *)image);
+
 				ex->insn = delta;
 
 				ex->data = EX_TYPE_BPF;
@@ -1705,7 +1695,7 @@ st:			if (is_imm8(insn->off))
 				pr_err("bpf_jit: fatal error\n");
 				return -EFAULT;
 			}
-			memcpy(image + proglen, temp, ilen);
+			memcpy(rw_image + proglen, temp, ilen);
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
@@ -2246,6 +2236,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
 }
 
 struct x64_jit_data {
+	struct bpf_binary_header *rw_header;
 	struct bpf_binary_header *header;
 	int *addrs;
 	u8 *image;
@@ -2258,6 +2249,7 @@ struct x64_jit_data {
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
+	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct x64_jit_data *jit_data;
@@ -2266,6 +2258,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	bool padding = false;
+	u8 *rw_image = NULL;
 	u8 *image = NULL;
 	int *addrs;
 	int pass;
@@ -2301,6 +2294,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		oldproglen = jit_data->proglen;
 		image = jit_data->image;
 		header = jit_data->header;
+		rw_header = jit_data->rw_header;
+		rw_image = (void *)rw_header + ((void *)image - (void *)header);
 		extra_pass = true;
 		padding = true;
 		goto skip_init_addrs;
@@ -2331,12 +2326,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
 		if (!padding && pass >= PADDING_PASSES)
 			padding = true;
-		proglen = do_jit(prog, addrs, image, oldproglen, &ctx, padding);
+		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
 			if (header)
-				bpf_jit_binary_free(header);
+				bpf_jit_binary_pack_free(header, rw_header);
 			prog = orig_prog;
 			goto out_addrs;
 		}
@@ -2360,8 +2355,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				sizeof(struct exception_table_entry);
 
 			/* allocate module memory for x86 insns and extable */
-			header = bpf_jit_binary_alloc(roundup(proglen, align) + extable_size,
-						      &image, align, jit_fill_hole);
+			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
+							   &image, align, &rw_header, &rw_image,
+							   jit_fill_hole);
 			if (!header) {
 				prog = orig_prog;
 				goto out_addrs;
@@ -2377,14 +2373,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (image) {
 		if (!prog->is_func || extra_pass) {
+			/*
+			 * bpf_jit_binary_pack_finalize fails in two scenarios:
+			 *   1) header is not pointing to proper module memory;
+			 *   2) the arch doesn't support bpf_arch_text_copy().
+			 *
+			 * Both cases are serious bugs that we should not continue.
+			 */
+			BUG_ON(bpf_jit_binary_pack_finalize(prog, header, rw_header));
 			bpf_tail_call_direct_fixup(prog);
-			bpf_jit_binary_lock_ro(header);
 		} else {
 			jit_data->addrs = addrs;
 			jit_data->ctx = ctx;
 			jit_data->proglen = proglen;
 			jit_data->image = image;
 			jit_data->header = header;
+			jit_data->rw_header = rw_header;
 		}
 		prog->bpf_func = (void *)image;
 		prog->jited = 1;
-- 
2.30.2

