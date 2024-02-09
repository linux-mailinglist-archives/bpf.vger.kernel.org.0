Return-Path: <bpf+bounces-21593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B884EF8D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3281F275B3
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251965258;
	Fri,  9 Feb 2024 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNn8BtD+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CF5695
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451613; cv=none; b=ubu/xocvtwndx9bAthW1802rhAIN/CiZcfmBomobzIW5kkTBi+Nre+mF7IinxOuXPbceCAQnMdftjhUIAPhNpQryuhzH3OZ+306oGGd66MWGhyDjZcsJfDzezfDH/uTQnFEs8+xKFt/LKo+8ISdja4STvrmCeG3+nxaESIcxXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451613; c=relaxed/simple;
	bh=RGmnC2qapNe7OSIJKKLlaKFWmQfQSfIt8eXZiTHNiaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MABchtpwe/y3aTlhMwlrR93WlLKAct1Me/03M1P/Le07k506VIBPXBvTPEB9RNFQ0m29cxUEcw+GaEyRTpn127I9brSF11VBqfz1kYfFJvTNE9fVgbvF2mdkTsxfSJJ6BUrCZZiDJJMNWq6acVaDCXh8U4YJ+Sh7J40iKAgqD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNn8BtD+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29041136f73so442993a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451611; x=1708056411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6orzNV0AjOboinNstixj6Czt+5FkF5rLiP2S91rGkng=;
        b=dNn8BtD+gM75vu0VYpdMrQM9sGKqVlyrmL4ZSVorhL5unJwMz7HZul2dJpapz3zkgG
         QobaLO+qZlt5b7FqTXE7iiJZSBAu7DXJflLkecA1IT1PcrP0nnCjdAbqDzMBxwM6XuC5
         gRb4/MEKEa58QYphSe6U8bvZr+fJ7ejMilpCpV40faTb+GG3LusqPhrcOh0Jh00ZZ+fH
         kf5BGubg2QCBzVBE+ddQLxv2BHlNGZtn6esNRkdhg06al9N/LWDoL00K9cPTe0HjyqI3
         53eq2DF9VRgKr/Zol3aGMom7dqwlauIcscg0z56XUqDsX11i0OGXDup9/Vfb7U9e9urF
         uSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451611; x=1708056411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6orzNV0AjOboinNstixj6Czt+5FkF5rLiP2S91rGkng=;
        b=OMS11ScJRQ3aBcueI7ptKIfnq3ROH2BgqQO+clKEkEqHSd+WQaHvenHY7HmD6btCgF
         FwFvPe0rv7hHix/5QMGWgV5URZjLNS6NRQgkC0rwBZkK6XqMe/e3/BjZU9hi7sCCSuj4
         hRWwtL95H1X09UEOCdqFrjdEOdBOj3WNI974Romr2nqiBPrVoOwq0lyaNoKHCwiqksOa
         J7/j4RF3i1wVQvjNm331mARNc2QfUa189O4rg4saDFW/u2Y49IBmufyXEtGMK6tc+T0s
         wZGduSg7duZYmLVuxCGZ5VpEKPy3hSvntzKWoC98qMI4d43RwR6vDC+SRQB+tKa12FTu
         TlWw==
X-Gm-Message-State: AOJu0YwK8PaZuErnPo37OnZMlGMuKVUNI16R94IXq7h+4m2PMmwTJmVT
	sYCUYHi9CVE0oyf6sf2j4L6O42bkWYXR8dLwuvKo+kxu8860uU9tg90POawy
X-Google-Smtp-Source: AGHT+IELh8rBH0G9Lv9cd6+SlCU2HHOEdFHvhzYPN8nxJUwbCo29hXvQdLAj23YQAxaPQ6BGyTN6CQ==
X-Received: by 2002:a17:90a:ec0a:b0:297:604:1ff7 with SMTP id l10-20020a17090aec0a00b0029706041ff7mr369707pjy.17.1707451610983;
        Thu, 08 Feb 2024 20:06:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbmgFXdBFBjoBt3ptKvyA1cp6LgeIz61rrJcLFv5JUSuH38/oThZV2vN01bpNPpzSAQQzUFFLy5t84VFxFzRvu6fnUge0QkzDc5TzAwavQYHF/tskPhpRwU9tHxSE9TlxkDOuMxPxVDmYlVq+ESWxWRJAkVDkalPzwjCAUzmE8TAZSi0v2qvrRKnnIQ4mIciNs6exu3NF5zyf5m09UcymKjg5roaQ1+4O9u3IaSB1OjQcxE34V8P4E4nnCwSMCt8W3ZXoaNOZ/HHM2MBZ9HBuzyVwifcAlMUuCLYuZbK7iGpu3QO/o8FG5FX0lHxI0Y69dTchHVCLiMculML1U95RXRRI+BFCuced/EbT6d+8/wKzNVMVjsQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a8a8f00b00296e2434e7esm608017pjn.53.2024.02.08.20.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 09/20] bpf: Recognize cast_kern/user instructions in the verifier.
Date: Thu,  8 Feb 2024 20:05:57 -0800
Message-Id: <20240209040608.98927-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

rX = bpf_cast_kern(rY, addr_space) tells the verifier that rX->type = PTR_TO_ARENA.
Any further operations on PTR_TO_ARENA register have to be in 32-bit domain.

The verifier will mark load/store through PTR_TO_ARENA with PROBE_MEM32.
JIT will generate them as kern_vm_start + 32bit_addr memory accesses.

rX = bpf_cast_user(rY, addr_space) tells the verifier that rX->type = unknown scalar.
If arena->map_flags has BPF_F_NO_USER_CONV set then convert cast_user to mov32 as well.
Otherwise JIT will convert it to:
  rX = (u32)rY;
  if (rX)
     rX |= arena->user_vm_start & ~(u64)~0U;

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/log.c             |   3 ++
 kernel/bpf/verifier.c        | 102 ++++++++++++++++++++++++++++++++---
 4 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 26419a57bf9f..70d5351427e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -889,6 +889,7 @@ enum bpf_reg_type {
 	 * an explicit null check is required for this struct.
 	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
+	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..43c95e3e2a3c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -547,6 +547,7 @@ struct bpf_insn_aux_data {
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
+	bool needs_zext; /* alu op needs to clear upper bits */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 594a234f122b..677076c760ff 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -416,6 +416,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		[PTR_TO_XDP_SOCK]	= "xdp_sock",
 		[PTR_TO_BTF_ID]		= "ptr_",
 		[PTR_TO_MEM]		= "mem",
+		[PTR_TO_ARENA]		= "arena",
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
@@ -651,6 +652,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	}
 
 	verbose(env, "%s", reg_type_str(env, t));
+	if (t == PTR_TO_ARENA)
+		return;
 	if (t == PTR_TO_STACK) {
 		if (state->frameno != reg->frameno)
 			verbose(env, "[%d]", reg->frameno);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c77a3ab1192..5eeb9bf7e324 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4370,6 +4370,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
+	case PTR_TO_ARENA:
 		return true;
 	default:
 		return false;
@@ -5805,6 +5806,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 	case PTR_TO_XDP_SOCK:
 		pointer_desc = "xdp_sock ";
 		break;
+	case PTR_TO_ARENA:
+		return 0;
 	default:
 		break;
 	}
@@ -6906,6 +6909,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type == PTR_TO_ARENA) {
+		if (t == BPF_READ && value_regno >= 0)
+			mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
@@ -8377,6 +8383,7 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_MEM | MEM_RINGBUF:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_ARENA:
 	case SCALAR_VALUE:
 		return 0;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
@@ -13837,6 +13844,21 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	dst_reg = &regs[insn->dst_reg];
 	src_reg = NULL;
+
+	if (dst_reg->type == PTR_TO_ARENA) {
+		struct bpf_insn_aux_data *aux = cur_aux(env);
+
+		if (BPF_CLASS(insn->code) == BPF_ALU64)
+			/*
+			 * 32-bit operations zero upper bits automatically.
+			 * 64-bit operations need to be converted to 32.
+			 */
+			aux->needs_zext = true;
+
+		/* Any arithmetic operations are allowed on arena pointers */
+		return 0;
+	}
+
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
 	else
@@ -13954,16 +13976,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else if (opcode == BPF_MOV) {
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0) {
-				verbose(env, "BPF_MOV uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_CLASS(insn->code) == BPF_ALU) {
-				if (insn->off != 0 && insn->off != 8 && insn->off != 16) {
+				if ((insn->off != 0 && insn->off != 8 && insn->off != 16) ||
+				    insn->imm) {
 					verbose(env, "BPF_MOV uses reserved fields\n");
 					return -EINVAL;
 				}
+			} else if (insn->off == BPF_ARENA_CAST_KERN || insn->off == BPF_ARENA_CAST_USER) {
+				if (!insn->imm) {
+					verbose(env, "cast_kern/user insn must have non zero imm32\n");
+					return -EINVAL;
+				}
 			} else {
 				if (insn->off != 0 && insn->off != 8 && insn->off != 16 &&
 				    insn->off != 32) {
@@ -13993,7 +14016,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
-				if (insn->off == 0) {
+				if (insn->imm) {
+					/* off == BPF_ARENA_CAST_KERN || off == BPF_ARENA_CAST_USER */
+					mark_reg_unknown(env, regs, insn->dst_reg);
+					if (insn->off == BPF_ARENA_CAST_KERN)
+						dst_reg->type = PTR_TO_ARENA;
+				} else if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
 					 */
@@ -14059,6 +14087,9 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
+				} else if (src_reg->type == PTR_TO_ARENA) {
+					mark_reg_unknown(env, regs, insn->dst_reg);
+					dst_reg->type = PTR_TO_ARENA;
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -15142,6 +15173,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
+		if (map->map_type == BPF_MAP_TYPE_ARENA) {
+			__mark_reg_unknown(env, dst_reg);
+			return 0;
+		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
 		WARN_ON_ONCE(map->max_entries != 1);
@@ -16519,6 +16554,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * the same stack frame, since fp-8 in foo != fp-8 in bar
 		 */
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+	case PTR_TO_ARENA:
+		return true;
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -18235,6 +18272,31 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				fdput(f);
 				return -EBUSY;
 			}
+			if (map->map_type == BPF_MAP_TYPE_ARENA) {
+				if (env->prog->aux->arena) {
+					verbose(env, "Only one arena per program\n");
+					fdput(f);
+					return -EBUSY;
+				}
+				if (!env->allow_ptr_leaks || !env->bpf_capable) {
+					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
+					fdput(f);
+					return -EPERM;
+				}
+				if (!env->prog->jit_requested) {
+					verbose(env, "JIT is required to use arena\n");
+					return -EOPNOTSUPP;
+				}
+				if (!bpf_jit_supports_arena()) {
+					verbose(env, "JIT doesn't support arena\n");
+					return -EOPNOTSUPP;
+				}
+				env->prog->aux->arena = (void *)map;
+				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+					return -EINVAL;
+				}
+			}
 
 			fdput(f);
 next_insn:
@@ -18799,6 +18861,18 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
+		} else if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
+			if (insn->off == BPF_ARENA_CAST_KERN ||
+			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
+				/* convert to 32-bit mov that clears upper 32-bit */
+				insn->code = BPF_ALU | BPF_MOV | BPF_X;
+				/* clear off, so it's a normal 'wX = wY' from JIT pov */
+				insn->off = 0;
+			} /* else insn->off == BPF_ARENA_CAST_USER should be handled by JIT */
+			continue;
+		} else if (env->insn_aux_data[i + delta].needs_zext) {
+			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
+			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 		} else {
 			continue;
 		}
@@ -18856,6 +18930,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				env->prog->aux->num_exentries++;
 			}
 			continue;
+		case PTR_TO_ARENA:
+			if (BPF_MODE(insn->code) == BPF_MEMSX) {
+				verbose(env, "sign extending loads from arena are not supported yet\n");
+				return -EOPNOTSUPP;
+			}
+			insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
+			env->prog->aux->num_exentries++;
+			continue;
 		default:
 			continue;
 		}
@@ -19041,13 +19123,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		func[i]->aux->arena = prog->aux->arena;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
 			if (BPF_CLASS(insn->code) == BPF_LDX &&
 			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
 			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 				num_exentries++;
+			if ((BPF_CLASS(insn->code) == BPF_STX ||
+			     BPF_CLASS(insn->code) == BPF_ST) &&
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+				num_exentries++;
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
-- 
2.34.1


