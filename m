Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B66A7ACB
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCBFch convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 00:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBFcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:32:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694194AFE6
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:32:31 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3220uPf0015832
        for <bpf@vger.kernel.org>; Wed, 1 Mar 2023 21:32:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p1junw6qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 21:32:31 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Mar 2023 21:32:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BC187290D0E98; Wed,  1 Mar 2023 21:32:21 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/8] bpf: improve stack slot state printing
Date:   Wed, 1 Mar 2023 21:32:09 -0800
Message-ID: <20230302053216.1426015-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302053216.1426015-1-andrii@kernel.org>
References: <20230302053216.1426015-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J7j6wiFJRWBNItjbLaCwlva8VNukfP7O
X-Proofpoint-ORIG-GUID: J7j6wiFJRWBNItjbLaCwlva8VNukfP7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Improve stack slot state printing to provide more useful and relevant
information, especially for dynptrs. While previously we'd see something
like:

  8: (85) call bpf_ringbuf_reserve_dynptr#198   ; R0_w=scalar() fp-8_w=dddddddd fp-16_w=dddddddd refs=2

Now we'll see way more useful:

  8: (85) call bpf_ringbuf_reserve_dynptr#198   ; R0_w=scalar() fp-16_w=dynptr_ringbuf(ref_id=2) refs=2

I experimented with printing the range of slots taken by dynptr,
something like:

  fp-16..8_w=dynptr_ringbuf(ref_id=2)

But it felt very awkward and pretty useless. So we print the lowest
address (most negative offset) only.

The general structure of this code is now also set up for easier
extension and will accommodate ITER slots naturally.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 75 ++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf580f246a01..60cc8473faa8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -705,6 +705,25 @@ static const char *kernel_type_name(const struct btf* btf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
 
+static const char *dynptr_type_str(enum bpf_dynptr_type type)
+{
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+		return "local";
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return "ringbuf";
+	case BPF_DYNPTR_TYPE_SKB:
+		return "skb";
+	case BPF_DYNPTR_TYPE_XDP:
+		return "xdp";
+	case BPF_DYNPTR_TYPE_INVALID:
+		return "<invalid>";
+	default:
+		WARN_ONCE(1, "unknown dynptr type %d\n", type);
+		return "<unknown>";
+	}
+}
+
 static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 {
 	env->scratched_regs |= 1U << regno;
@@ -1176,26 +1195,49 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++) {
 			if (state->stack[i].slot_type[j] != STACK_INVALID)
 				valid = true;
-			types_buf[j] = slot_type_char[
-					state->stack[i].slot_type[j]];
+			types_buf[j] = slot_type_char[state->stack[i].slot_type[j]];
 		}
 		types_buf[BPF_REG_SIZE] = 0;
 		if (!valid)
 			continue;
 		if (!print_all && !stack_slot_scratched(env, i))
 			continue;
-		verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-		print_liveness(env, state->stack[i].spilled_ptr.live);
-		if (is_spilled_reg(&state->stack[i])) {
+		switch (state->stack[i].slot_type[BPF_REG_SIZE - 1]) {
+		case STACK_SPILL:
 			reg = &state->stack[i].spilled_ptr;
 			t = reg->type;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
 			verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
 			if (t == SCALAR_VALUE && reg->precise)
 				verbose(env, "P");
 			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
 				verbose(env, "%lld", reg->var_off.value + reg->off);
-		} else {
+			break;
+		case STACK_DYNPTR:
+			i += BPF_DYNPTR_NR_SLOTS - 1;
+			reg = &state->stack[i].spilled_ptr;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=dynptr_%s", dynptr_type_str(reg->dynptr.type));
+			if (reg->ref_obj_id)
+				verbose(env, "(ref_id=%d)", reg->ref_obj_id);
+			break;
+		case STACK_MISC:
+		case STACK_ZERO:
+		default:
+			reg = &state->stack[i].spilled_ptr;
+
+			for (j = 0; j < BPF_REG_SIZE; j++)
+				types_buf[j] = slot_type_char[state->stack[i].slot_type[j]];
+			types_buf[BPF_REG_SIZE] = 0;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
 			verbose(env, "=%s", types_buf);
+			break;
 		}
 	}
 	if (state->acquired_refs && state->refs[0].id) {
@@ -6312,28 +6354,9 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 
 		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected type */
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
-			const char *err_extra = "";
-
-			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
-			case DYNPTR_TYPE_LOCAL:
-				err_extra = "local";
-				break;
-			case DYNPTR_TYPE_RINGBUF:
-				err_extra = "ringbuf";
-				break;
-			case DYNPTR_TYPE_SKB:
-				err_extra = "skb ";
-				break;
-			case DYNPTR_TYPE_XDP:
-				err_extra = "xdp ";
-				break;
-			default:
-				err_extra = "<unknown>";
-				break;
-			}
 			verbose(env,
 				"Expected a dynptr of type %s as arg #%d\n",
-				err_extra, regno);
+				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno);
 			return -EINVAL;
 		}
 
-- 
2.30.2

