Return-Path: <bpf+bounces-8116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24577816ED
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D568B1C20DBB
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F21362;
	Sat, 19 Aug 2023 03:01:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917CED6
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:54 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184063C34
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5862a6ae535so16972827b3.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414110; x=1693018910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMESTIaOOhtXyQmaR7/FQPoLIoycmuOBN1bLlwXabHE=;
        b=gWvCUCN70wIkpOuc9KspX7fvvmVJKDRYrTkDr9aa/TXscN8c9D/wNunKrTiFEmNDRC
         qscx+q2UWH58fv839nrRXvfRCaeQStzLLyjIKN9rXSUjZ1gCNUjztNEQQ5C3MgN/MCKH
         jHiHKzzAoIt9zhZ7uZ1ybazJUGXkYXKQa9ybCJz1VwgF0pSqFTE3UhUd+wOiKBm2ZecZ
         +ny84b6NVRSZk/6VBVxbDP+H0L6okJ52N65lNztjO7uz5AMJ3oRfyJfxo6ygrDUDE3ki
         KIZsHlRedqH7QJ34o+SsyySFmozUIi34GxHHIx8Q43pmp0AmBPjodc08YCZT22beonh/
         suqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414110; x=1693018910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMESTIaOOhtXyQmaR7/FQPoLIoycmuOBN1bLlwXabHE=;
        b=cAatNliZqfpzDx15hN9BuWJehXhAiUBajx+QDFHYTPH40Lf0bnPtwL6rxa8m3CsOhB
         nkztNd7uvfJdtyFN+AW4Pslv6Odnm8RHk+0FPyaHE50TrTlQ1NSxAmTAX6OjCCqr91+s
         wBGbmmCQuUh1pc1gbTVWJ1HNTEa6h+y6SY2bKzezkbTtdbIfwSmwEhaOqRKRRJv8xkqi
         xGW6zc9RNfzBh+RwIn5S5FryXIy2fpbe6lUWLz5SJxyipG62oxas3FomIISRHV4x8HSk
         kZErGaDOIe95j1ehF5SeKrjipTHWLf8lG3XFrRDaoE+mv0wTFY9V5w5UlaJFvIof5I1t
         Pf6A==
X-Gm-Message-State: AOJu0Yxxbf2Su9XAZhxYVYUpvQMV9Y3w08EjKhu/gwOMe2kOdZcwqWDG
	VnSDhJf3doGLov+OHblfdI7C7PEvGcpHRQ==
X-Google-Smtp-Source: AGHT+IFUmwNVFDvaHFG5GnHAZM7CyiD8R95FR2PbaJtiXiCh6Hcmum+dcsIpC/YBKmIPjDr6Q+ua5Q==
X-Received: by 2002:a81:7b89:0:b0:586:93d5:bbf9 with SMTP id w131-20020a817b89000000b0058693d5bbf9mr937315ywc.48.1692414109943;
        Fri, 18 Aug 2023 20:01:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:49 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 3/6] Add PTR_TO_AUX
Date: Fri, 18 Aug 2023 20:01:40 -0700
Message-Id: <20230819030143.419729-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |   6 +-
 kernel/bpf/verifier.c        | 195 ++++++++++++++++++++++-------------
 3 files changed, 127 insertions(+), 76 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edb35bcfa548..40a3d392b7f1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -865,6 +865,8 @@ enum bpf_reg_type {
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
+	PTR_TO_AUX,		 /* reg points to context aux memory */
+	PTR_TO_AUX_END,		 /* aux + len */
 	__BPF_REG_TYPE_MAX,
 
 	/* Extended reg_types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..eb1f9e18bc8d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -76,7 +76,7 @@ struct bpf_reg_state {
 	/* Fixed part of pointer offset, pointer types only */
 	s32 off;
 	union {
-		/* valid when type == PTR_TO_PACKET */
+		/* valid when type == PTR_TO_PACKET or PTR_TO_AUX */
 		int range;
 
 		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
@@ -154,8 +154,8 @@ struct bpf_reg_state {
 	s32 s32_max_value; /* maximum possible (s32)value */
 	u32 u32_min_value; /* minimum possible (u32)value */
 	u32 u32_max_value; /* maximum possible (u32)value */
-	/* For PTR_TO_PACKET, used to find other pointers with the same variable
-	 * offset, so they can share range knowledge.
+	/* For PTR_TO_PACKET and PTR_TO_AUX, used to find other pointers
+	 * with the same variable offset, so they can share range knowledge.
 	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
 	 * came from, when one is tested for != NULL.
 	 * For PTR_TO_MEM_OR_NULL this is used to identify memory allocation
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61be432b9420..05ab2c7f8798 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -432,6 +432,14 @@ static bool type_is_pkt_pointer(enum bpf_reg_type type)
 	       type == PTR_TO_PACKET_META;
 }
 
+static bool type_is_pkt_aux_pointer(enum bpf_reg_type type)
+{
+	type = base_type(type);
+	return type == PTR_TO_PACKET ||
+	       type == PTR_TO_PACKET_META ||
+	       type == PTR_TO_AUX;
+}
+
 static bool type_is_sk_pointer(enum bpf_reg_type type)
 {
 	return type == PTR_TO_SOCKET ||
@@ -619,6 +627,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
 		[CONST_PTR_TO_DYNPTR]	= "dynptr_ptr",
+		[PTR_TO_AUX]		= "aux",
+		[PTR_TO_AUX_END]	= "aux_end",
 	};
 
 	if (type & PTR_MAYBE_NULL) {
@@ -1389,7 +1399,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 				verbose_a("%s", "non_own_ref");
 			if (t != SCALAR_VALUE)
 				verbose_a("off=%d", reg->off);
-			if (type_is_pkt_pointer(t))
+			if (type_is_pkt_aux_pointer(t))
 				verbose_a("r=%d", reg->range);
 			else if (base_type(t) == CONST_PTR_TO_MAP ||
 				 base_type(t) == PTR_TO_MAP_KEY ||
@@ -1992,21 +2002,23 @@ static void mark_reg_graph_node(struct bpf_reg_state *regs, u32 regno,
 	regs[regno].off = ds_head->node_offset;
 }
 
-static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
+static bool reg_is_pkt_aux_pointer(const struct bpf_reg_state *reg)
 {
-	return type_is_pkt_pointer(reg->type);
+	return type_is_pkt_aux_pointer(reg->type);
 }
 
-static bool reg_is_pkt_pointer_any(const struct bpf_reg_state *reg)
+static bool reg_is_pkt_aux_pointer_any(const struct bpf_reg_state *reg)
 {
-	return reg_is_pkt_pointer(reg) ||
-	       reg->type == PTR_TO_PACKET_END;
+	return reg_is_pkt_aux_pointer(reg) ||
+	       reg->type == PTR_TO_PACKET_END ||
+	       reg->type == PTR_TO_AUX_END;
 }
 
-static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
+static bool reg_is_dynptr_slice_pkt_aux(const struct bpf_reg_state *reg)
 {
 	return base_type(reg->type) == PTR_TO_MEM &&
-		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP);
+		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP ||
+		 reg->type & DYNPTR_TYPE_CGROUP_SOCKOPT);
 }
 
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
@@ -4213,6 +4225,8 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
+	case PTR_TO_AUX:
+	case PTR_TO_AUX_END:
 		return true;
 	default:
 		return false;
@@ -4882,6 +4896,11 @@ static int __check_mem_access(struct bpf_verifier_env *env, int regno,
 		verbose(env, "invalid access to packet, off=%d size=%d, R%d(id=%d,off=%d,r=%d)\n",
 			off, size, regno, reg->id, off, mem_size);
 		break;
+	case PTR_TO_AUX:
+	case PTR_TO_AUX_END:
+		verbose(env, "invalid access to aux memory, off=%d size=%d, R%d(id=%d,off=%d,r=%d)\n",
+			off, size, regno, reg->id, off, mem_size);
+		break;
 	case PTR_TO_MEM:
 	default:
 		verbose(env, "invalid access to memory, mem_size=%u off=%d size=%d\n",
@@ -5208,9 +5227,9 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 
 #define MAX_PACKET_OFF 0xffff
 
-static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
-				       const struct bpf_call_arg_meta *meta,
-				       enum bpf_access_type t)
+static bool may_access_direct_pkt_aux_data(struct bpf_verifier_env *env,
+					   const struct bpf_call_arg_meta *meta,
+					   enum bpf_access_type t)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 
@@ -5240,6 +5259,8 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 		return true;
 
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		if (env->prog->aux->sleepable)
+			return false;
 		if (t == BPF_WRITE)
 			env->seen_direct_write = true;
 
@@ -5250,8 +5271,8 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	}
 }
 
-static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
-			       int size, bool zero_size_allowed)
+static int check_packet_aux_access(struct bpf_verifier_env *env, u32 regno, int off,
+				   int size, bool zero_size_allowed)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = &regs[regno];
@@ -5281,7 +5302,7 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 
 	/* __check_mem_access has made sure "off + size - 1" is within u16.
 	 * reg->umax_value can't be bigger than MAX_PACKET_OFF which is 0xffff,
-	 * otherwise find_good_pkt_pointers would have refused to set range info
+	 * otherwise find_good_pkt_aux_pointers would have refused to set range info
 	 * that __check_mem_access would have rejected this pkt access.
 	 * Therefore, "off + reg->umax_value + size - 1" won't overflow u32.
 	 */
@@ -5567,6 +5588,9 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 	case PTR_TO_XDP_SOCK:
 		pointer_desc = "xdp_sock ";
 		break;
+	case PTR_TO_AUX:
+		pointer_desc = "aux ";
+		break;
 	default:
 		break;
 	}
@@ -6550,9 +6574,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
-			/* ctx access returns either a scalar, or a
-			 * PTR_TO_PACKET[_META,_END]. In the latter
-			 * case, we know the offset is zero.
+			/* ctx access returns either a scalar, a
+			 * PTR_TO_PACKET[_META,_END], or a
+			 * PTR_TO_AUX[_END]. In the latter case, we know
+			 * the offset is zero.
 			 */
 			if (reg_type == SCALAR_VALUE) {
 				mark_reg_unknown(env, regs, value_regno);
@@ -6592,8 +6617,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		else
 			err = check_stack_write(env, regno, off, size,
 						value_regno, insn_idx);
-	} else if (reg_is_pkt_pointer(reg)) {
-		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
+	} else if (reg_is_pkt_aux_pointer(reg)) {
+		if (t == BPF_WRITE && !may_access_direct_pkt_aux_data(env, NULL, t)) {
 			verbose(env, "cannot write into packet\n");
 			return -EACCES;
 		}
@@ -6603,7 +6628,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				value_regno);
 			return -EACCES;
 		}
-		err = check_packet_access(env, regno, off, size, false);
+		err = check_packet_aux_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_FLOW_KEYS) {
@@ -6951,8 +6976,9 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-		return check_packet_access(env, regno, reg->off, access_size,
-					   zero_size_allowed);
+	case PTR_TO_AUX:
+		return check_packet_aux_access(env, regno, reg->off, access_size,
+					       zero_size_allowed);
 	case PTR_TO_MAP_KEY:
 		if (meta && meta->raw_mode) {
 			verbose(env, "R%d cannot write into %s\n", regno,
@@ -7714,6 +7740,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MEM | MEM_RINGBUF,
 		PTR_TO_BUF,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_AUX,
 	},
 };
 
@@ -7724,6 +7751,7 @@ static const struct bpf_reg_types int_ptr_types = {
 		PTR_TO_PACKET_META,
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
+		PTR_TO_AUX,
 	},
 };
 
@@ -8004,6 +8032,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case SCALAR_VALUE:
+	case PTR_TO_AUX:
 		return 0;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
 	 * fixed offset.
@@ -8120,8 +8149,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return 0;
 	}
 
-	if (type_is_pkt_pointer(type) &&
-	    !may_access_direct_pkt_data(env, meta, BPF_READ)) {
+	if (type_is_pkt_aux_pointer(type) &&
+	    !may_access_direct_pkt_aux_data(env, meta, BPF_READ)) {
 		verbose(env, "helper access to the packet is not allowed\n");
 		return -EACCES;
 	}
@@ -8764,13 +8793,13 @@ static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
  * This also applies to dynptr slices belonging to skb and xdp dynptrs,
  * since these slices point to packet data.
  */
-static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
+static void clear_all_pkt_aux_pointers(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
+		if (reg_is_pkt_aux_pointer_any(reg) || reg_is_dynptr_slice_pkt_aux(reg))
 			mark_reg_invalid(env, reg);
 	}));
 }
@@ -8780,12 +8809,12 @@ enum {
 	BEYOND_PKT_END = -2,
 };
 
-static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range_open)
+static void mark_pkt_aux_end(struct bpf_verifier_state *vstate, int regn, bool range_open)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *reg = &state->regs[regn];
 
-	if (reg->type != PTR_TO_PACKET)
+	if (reg->type != PTR_TO_PACKET && reg->type != PTR_TO_AUX)
 		/* PTR_TO_PACKET_META is not supported yet */
 		return;
 
@@ -9766,7 +9795,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EFAULT;
 
 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB)
-			/* this will trigger clear_all_pkt_pointers(), which will
+			/* this will trigger clear_all_pkt_aux_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
 			changes_data = true;
@@ -9975,7 +10004,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (changes_data)
-		clear_all_pkt_pointers(env);
+		clear_all_pkt_aux_pointers(env);
 	return 0;
 }
 
@@ -11514,7 +11543,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					regs[BPF_REG_0].type |= MEM_RDONLY;
 				} else {
 					/* this will set env->seen_direct_write to true */
-					if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
+					if (!may_access_direct_pkt_aux_data(env, NULL, BPF_WRITE)) {
 						verbose(env, "the prog does not allow writes to packet data\n");
 						return -EINVAL;
 					}
@@ -12081,6 +12110,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_XDP_SOCK:
+	case PTR_TO_AUX_END:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
 		return -EACCES;
@@ -12129,7 +12159,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		 * == 0, since it's a scalar.
 		 * dst_reg gets the pointer type and since some positive
 		 * integer value was added to the pointer, give it a new 'id'
-		 * if it's a PTR_TO_PACKET.
+		 * if it's a PTR_TO_PACKET or PTR_TO_AUX.
 		 * this creates a new 'base' pointer, off_reg (variable) gets
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
@@ -12153,7 +12183,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
 		dst_reg->raw = ptr_reg->raw;
-		if (reg_is_pkt_pointer(ptr_reg)) {
+		if (reg_is_pkt_aux_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
 			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
@@ -12212,7 +12242,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
 		dst_reg->raw = ptr_reg->raw;
-		if (reg_is_pkt_pointer(ptr_reg)) {
+		if (reg_is_pkt_aux_pointer(ptr_reg)) {
 			dst_reg->id = ++env->id_gen;
 			/* something was added to pkt_ptr, set range to zero */
 			if (smin_val < 0)
@@ -13300,10 +13330,10 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
-				   struct bpf_reg_state *dst_reg,
-				   enum bpf_reg_type type,
-				   bool range_right_open)
+static void find_good_pkt_aux_pointers(struct bpf_verifier_state *vstate,
+				       struct bpf_reg_state *dst_reg,
+				       enum bpf_reg_type type,
+				       bool range_right_open)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
@@ -13589,15 +13619,17 @@ static int flip_opcode(u32 opcode)
 	return opcode_flip[opcode >> 4];
 }
 
-static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
-				   struct bpf_reg_state *src_reg,
-				   u8 opcode)
+static int is_pkt_aux_ptr_branch_taken(struct bpf_reg_state *dst_reg,
+				       struct bpf_reg_state *src_reg,
+				       u8 opcode)
 {
 	struct bpf_reg_state *pkt;
 
-	if (src_reg->type == PTR_TO_PACKET_END) {
+	if (src_reg->type == PTR_TO_PACKET_END ||
+	    src_reg->type == PTR_TO_AUX_END) {
 		pkt = dst_reg;
-	} else if (dst_reg->type == PTR_TO_PACKET_END) {
+	} else if (dst_reg->type == PTR_TO_PACKET_END ||
+		   dst_reg->type == PTR_TO_AUX_END) {
 		pkt = src_reg;
 		opcode = flip_opcode(opcode);
 	} else {
@@ -13888,7 +13920,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 	}
 }
 
-/* The logic is similar to find_good_pkt_pointers(), both could eventually
+/* The logic is similar to find_good_pkt_aux_pointers(), both could eventually
  * be folded together at some point.
  */
 static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
@@ -13928,20 +13960,24 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	case BPF_JGT:
 		if ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
+		    (dst_reg->type == PTR_TO_AUX &&
+		     src_reg->type == PTR_TO_AUX_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' > pkt_end, pkt_meta' > pkt_data */
-			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, false);
-			mark_pkt_end(other_branch, insn->dst_reg, true);
+			find_good_pkt_aux_pointers(this_branch, dst_reg,
+						   dst_reg->type, false);
+			mark_pkt_aux_end(other_branch, insn->dst_reg, true);
 		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
+			   (dst_reg->type == PTR_TO_AUX_END &&
+			    src_reg->type == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
 			    src_reg->type == PTR_TO_PACKET_META)) {
 			/* pkt_end > pkt_data', pkt_data > pkt_meta' */
-			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, true);
-			mark_pkt_end(this_branch, insn->src_reg, false);
+			find_good_pkt_aux_pointers(other_branch, src_reg,
+						   src_reg->type, true);
+			mark_pkt_aux_end(this_branch, insn->src_reg, false);
 		} else {
 			return false;
 		}
@@ -13949,20 +13985,24 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	case BPF_JLT:
 		if ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
+		    (dst_reg->type == PTR_TO_AUX &&
+		     src_reg->type == PTR_TO_AUX_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' < pkt_end, pkt_meta' < pkt_data */
-			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, true);
-			mark_pkt_end(this_branch, insn->dst_reg, false);
+			find_good_pkt_aux_pointers(other_branch, dst_reg,
+						   dst_reg->type, true);
+			mark_pkt_aux_end(this_branch, insn->dst_reg, false);
 		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
+			   (dst_reg->type == PTR_TO_AUX_END &&
+			    src_reg->type == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
 			    src_reg->type == PTR_TO_PACKET_META)) {
 			/* pkt_end < pkt_data', pkt_data > pkt_meta' */
-			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, false);
-			mark_pkt_end(other_branch, insn->src_reg, true);
+			find_good_pkt_aux_pointers(this_branch, src_reg,
+						   src_reg->type, false);
+			mark_pkt_aux_end(other_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
@@ -13970,20 +14010,24 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	case BPF_JGE:
 		if ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
+		    (dst_reg->type == PTR_TO_AUX &&
+		     src_reg->type == PTR_TO_AUX_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' >= pkt_end, pkt_meta' >= pkt_data */
-			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, true);
-			mark_pkt_end(other_branch, insn->dst_reg, false);
+			find_good_pkt_aux_pointers(this_branch, dst_reg,
+						   dst_reg->type, true);
+			mark_pkt_aux_end(other_branch, insn->dst_reg, false);
 		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
+			   (dst_reg->type == PTR_TO_AUX_END &&
+			    src_reg->type == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
 			    src_reg->type == PTR_TO_PACKET_META)) {
 			/* pkt_end >= pkt_data', pkt_data >= pkt_meta' */
-			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, false);
-			mark_pkt_end(this_branch, insn->src_reg, true);
+			find_good_pkt_aux_pointers(other_branch, src_reg,
+						   src_reg->type, false);
+			mark_pkt_aux_end(this_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
@@ -13991,20 +14035,24 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	case BPF_JLE:
 		if ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
+		    (dst_reg->type == PTR_TO_AUX &&
+		     src_reg->type == PTR_TO_AUX_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' <= pkt_end, pkt_meta' <= pkt_data */
-			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, false);
-			mark_pkt_end(this_branch, insn->dst_reg, true);
+			find_good_pkt_aux_pointers(other_branch, dst_reg,
+						   dst_reg->type, false);
+			mark_pkt_aux_end(this_branch, insn->dst_reg, true);
 		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
+			   (dst_reg->type == PTR_TO_AUX_END &&
+			    src_reg->type == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
 			    src_reg->type == PTR_TO_PACKET_META)) {
 			/* pkt_end <= pkt_data', pkt_data <= pkt_meta' */
-			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, true);
-			mark_pkt_end(other_branch, insn->src_reg, false);
+			find_good_pkt_aux_pointers(this_branch, src_reg,
+						   src_reg->type, true);
+			mark_pkt_aux_end(other_branch, insn->src_reg, false);
 		} else {
 			return false;
 		}
@@ -14105,10 +14153,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				       dst_reg->var_off.value,
 				       flip_opcode(opcode),
 				       is_jmp32);
-	} else if (reg_is_pkt_pointer_any(dst_reg) &&
-		   reg_is_pkt_pointer_any(src_reg) &&
+	} else if (reg_is_pkt_aux_pointer_any(dst_reg) &&
+		   reg_is_pkt_aux_pointer_any(src_reg) &&
 		   !is_jmp32) {
-		pred = is_pkt_ptr_branch_taken(dst_reg, src_reg, opcode);
+		pred = is_pkt_aux_ptr_branch_taken(dst_reg, src_reg, opcode);
 	}
 
 	if (pred >= 0) {
@@ -15609,6 +15657,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
+	case PTR_TO_AUX:
 		/* We must have at least as much range as the old ptr
 		 * did, so that any accesses which were safe before are
 		 * still safe.  This is true even if old range < old off,
@@ -18210,13 +18259,13 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 
 	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 		seen_direct_write = env->seen_direct_write;
-		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+		is_rdonly = !may_access_direct_pkt_aux_data(env, NULL, BPF_WRITE);
 
 		if (is_rdonly)
 			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
 
 		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
+		 * may_access_direct_pkt_aux_data mutates it
 		 */
 		env->seen_direct_write = seen_direct_write;
 	}
-- 
2.34.1


