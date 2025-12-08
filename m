Return-Path: <bpf+bounces-76236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E182CABCA2
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F2153012778
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D272475CF;
	Mon,  8 Dec 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcSql/PB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4423D7FF
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159384; cv=none; b=uk0tBefyi+EGJB/o/qsiM0V4I8vR2CS9m2/ipnKeg/wlymEk6woqaeDRo1Rw3VJF8A/zM49UY0aCMatwgqXPX9gG+Y4VI6EwcK3qDe1U/NqK447V/pZZnMizDrHczlYuZtO9h1HN9W7fAGCzo+9qHQv4Y7yJrEMtZtwhRPQlMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159384; c=relaxed/simple;
	bh=RhzExZHoa1slnBSNLTKq2KQGD4lw5jmZ+A1YLavI+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhRbGULOxydNYIALSXpeP3xzQ0QK/06/RPkq19eLjZLemPhLWAJZQODrYeChQhvbKqHAUu+P2pyh6ZJYN8Rm+6FJv+3Hi9PzIk8iKo+GnUIJY21v40Jtc5b+FchHAQ6d6mJrdB5qZZJaogILjMVQ6Qa1vrT+6KauKLUKk/AKt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcSql/PB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ba92341f83so5358740b3a.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159382; x=1765764182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ql1whL2yobc/+v3ZlTbDwW6sbE/ICy7V1SASo7QVIcA=;
        b=HcSql/PBKPzvgexPprVN5dzNZvYoala2xecx2UqDS0NXduUO+0ldHIjCWEVJFPy85x
         ZpiaeRTIjz4Ux6EiC+8Wq9d8p8KGdvI3LiZ/U7M0tydCqBMHTaH7ntJE458279INm3KA
         FVufjXNrbzwEenXQaszPS2Ud3qA2Z1KV5VtOIA+Gg7J+1h9v8OEU1KWXULDVhSfSvlH8
         x2deMmuYNEw7PnlLeZZnmb3bIzndYREpA+TA39nPqaD3H5gSwd01dDK8FX9ORIjYpCwW
         1DxQKA4jIaiHsZB5fvVOpl5Mbwbx5S1XAvMd62fGXRPYStzm3xAHoJV6ph8ysyL/DCOB
         l7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159382; x=1765764182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql1whL2yobc/+v3ZlTbDwW6sbE/ICy7V1SASo7QVIcA=;
        b=PHQ+HfsUAWgMyGhiYLeYOI/iGjVImQus/LWd6+944/9+fHc1b/kixIjjrXNXAcioYP
         9PgVc3hZfGICHHJWrHSO33uhAXQ5kv7M2Z6s83w4bA3au8qREqkNdcmDVTgokbrfXYTR
         FXooUJc9zhpKXW+rtrhHd2BRvsrVHfCqQEUDrqWfU16J1tw7UovcdtoLAqw+9XnWbxCX
         8gBux6VK2gsUn0GpZjIGaf8hLLPnj0aCbpXzBGTt1MqrBouoz4JqDyPmhclkLF0d37Zs
         E9E6S0WzIl6U0PDiemTVmXOkdPQOoM6GGGrm9E2V8vjsl+ZOaC3CrUMb97T4F1jO0t25
         /p4w==
X-Gm-Message-State: AOJu0Yx+ARE3RpTDioFnwKBTnysugMIqUsvzKFWazF+nPayjdDDPOsdJ
	xtnQWhZUHGiMUCNVHRhphGf0MpQ8REsMxDe4hn8WufGSaRohBxfi1jTI6WsyWdr2
X-Gm-Gg: ASbGncs6meSUHr1bvxDRl/klrtwQ0sUmW4blNyvtIljORg2wrtr6GWsZ7qYOvIAbHO1
	5sBYq2zNOERMseus+eykB0GIC0CwaYOBRQ30rAvtLQze6CFV3Er1bp8DzVKfKlcXIHjcvLPM17+
	HzL4vaymbou/lviA8pWV5DRrOfQrUD1GwLamP20nhcajdBwixi2uFgrsun10QTc3hWmUbqrYgBA
	PCeozQrfYdTDSUWXUyubwYcYcj8PPZSVyp+4ojkQg9qiNdfZylc8EeoyEslbB5nduZdOMDe9v/z
	yWLqscwx3VvkpNB/7q/1WbI7jMTHnZS3abAPK5AAj3Wqcs3SZGguNCRG8ZqOMye+dIXfFcbMETZ
	OeCdAndGpZh+CK/PFIYUyWwB2bD+NMjx7K4obHJrGvtroP7v1Juy//dE1/ADXfHa88nn1IRJQW3
	XH48RtyQ==
X-Google-Smtp-Source: AGHT+IGXAEC7h2zBrGHSOG9F2s7QH9CR9i8yE9tW8Hcgj8CD2wYCrn4HyKeKmApPxRxJdIiACdpO9A==
X-Received: by 2002:a05:6a20:7d8b:b0:35d:cad7:cd63 with SMTP id adf61e73a8af0-36617e83b4amr5766745637.30.1765159381675;
        Sun, 07 Dec 2025 18:03:01 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6875cd55dsm10420786a12.15.2025.12.07.18.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:03:00 -0800 (PST)
Date: Mon, 8 Dec 2025 11:02:56 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 2/8] bpf: Patch bytecode with oracle check
 instructions
Message-ID: <7881b155817403469c59f65df5c20dd3982c70ba.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

This commit patches the BPF bytecode with special instructions to tell
the interpreter to check the oracle. These instructions need to be added
whenever we saved information on verifier states, so at each pruning
point.

At the moment, it relies on a special LD_IMM64 instruction with the
address to the array map holding the information from the verifier
states. This needs to be changed to not expose a new BPF_PSEUDO_MAP_*
constant. One option would be to choose something closer to the existing
BPF_ST_NOSPEC instruction, which serves a similar internal-only purpose.

This patch defines a zero immediate for our LD_IMM64 instruction. The
next patch sets the immediate to our map address.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h      |  4 ++++
 include/uapi/linux/bpf.h          | 10 +++++++++
 kernel/bpf/disasm.c               |  3 ++-
 kernel/bpf/oracle.c               | 36 +++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c              |  4 +++-
 kernel/bpf/verifier.c             | 16 +++++++++++---
 tools/bpf/bpftool/xlated_dumper.c |  3 +++
 7 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index adaeff35aaa6..e4c8457e02c1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1107,6 +1107,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
@@ -1120,5 +1122,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env);
 
 int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx);
+struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
+					 int i, int *cnt);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 84ced3ed2d21..ca4827933d26 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1345,6 +1345,16 @@ enum {
 #define BPF_PSEUDO_MAP_VALUE		2
 #define BPF_PSEUDO_MAP_IDX_VALUE	6
 
+/* Internal only.
+ * insn[0].dst_reg:  0
+ * insn[0].src_reg:  BPF_PSEUDO_MAP_ORACLE
+ * insn[0].imm:      address of oracle state list
+ * insn[1].imm:      address of oracle state list
+ * insn[0].off:      0
+ * insn[1].off:      0
+ */
+#define BPF_PSEUDO_MAP_ORACLE	7
+
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
  * insn[1].imm:      0
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index f8a3c7eb451e..a591a0bd0284 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -323,7 +323,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			 */
 			u64 imm = ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
 			bool is_ptr = insn->src_reg == BPF_PSEUDO_MAP_FD ||
-				      insn->src_reg == BPF_PSEUDO_MAP_VALUE;
+				      insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+				      insn->src_reg == BPF_PSEUDO_MAP_ORACLE;
 			char tmp[64];
 
 			if (is_ptr && !allow_ptr_leaks)
diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
index adbb153aadee..924a86c90b4e 100644
--- a/kernel/bpf/oracle.c
+++ b/kernel/bpf/oracle.c
@@ -61,3 +61,39 @@ int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx)
 
 	return 0;
 }
+
+struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
+					 int i, int *cnt)
+{
+	struct bpf_insn ld_addrs[2] = {
+		BPF_LD_IMM64_RAW(0, BPF_PSEUDO_MAP_ORACLE, 0),
+	};
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];
+	struct list_head *head = aux->oracle_states;
+	struct bpf_insn *insn_buf = env->insn_buf;
+	struct bpf_prog *new_prog = env->prog;
+	int num_oracle_states;
+
+	if (env->subprog_cnt > 1)
+		/* Skip the oracle if subprogs are used. */
+		goto noop;
+
+	num_oracle_states = list_count_nodes(head);
+	if (!num_oracle_states)
+		goto noop;
+
+	insn_buf[0] = ld_addrs[0];
+	insn_buf[1] = ld_addrs[1];
+	insn_buf[2] = *insn;
+	*cnt = 3;
+
+	new_prog = bpf_patch_insn_data(env, i, insn_buf, *cnt);
+	if (!new_prog)
+		return ERR_PTR(-ENOMEM);
+
+	return new_prog;
+
+noop:
+	*cnt = 1;
+	return new_prog;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3080cc48bfc3..211912c91652 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4863,7 +4863,8 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
 	for (i = 0, *off = 0; i < prog->aux->used_map_cnt; i++) {
 		map = prog->aux->used_maps[i];
 		if (map == (void *)addr) {
-			*type = BPF_PSEUDO_MAP_FD;
+			if (*type != BPF_PSEUDO_MAP_ORACLE)
+				*type = BPF_PSEUDO_MAP_FD;
 			goto out;
 		}
 		if (!map->ops->map_direct_value_meta)
@@ -4925,6 +4926,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 		if (code != (BPF_LD | BPF_IMM | BPF_DW))
 			continue;
 
+		type = insns[i].src_reg;
 		imm = ((u64)insns[i + 1].imm << 32) | (u32)insns[i].imm;
 		map = bpf_map_from_imm(prog, imm, &off, &type);
 		if (map) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e48e5c9abae..4ca52c6aaa3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21202,7 +21202,7 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (insn->code != (BPF_LD | BPF_IMM | BPF_DW))
 			continue;
-		if (insn->src_reg == BPF_PSEUDO_FUNC)
+		if (insn->src_reg == BPF_PSEUDO_FUNC || insn->src_reg == BPF_PSEUDO_MAP_ORACLE)
 			continue;
 		insn->src_reg = 0;
 	}
@@ -21296,8 +21296,8 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
-static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-					    const struct bpf_insn *patch, u32 len)
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
@@ -22639,6 +22639,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt;) {
+		if (is_prune_point(env, i + delta)) {
+			new_prog = patch_oracle_check_insn(env, insn, i + delta, &cnt);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+		}
+
 		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
 			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
 			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5e7cb8b36fef..08bcd0c7d72d 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -206,6 +206,9 @@ static const char *print_imm(void *private_data,
 	else if (insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "map[idx:%d]+%d", insn->imm, (insn + 1)->imm);
+	else if (insn->src_reg == BPF_PSEUDO_MAP_ORACLE)
+		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+			 "oracle_map[id:%d]", insn->imm);
 	else if (insn->src_reg == BPF_PSEUDO_FUNC)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "subprog[%+d]", insn->imm);
-- 
2.43.0


