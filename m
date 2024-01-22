Return-Path: <bpf+bounces-20018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB34836DD0
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31E0282586
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23746446;
	Mon, 22 Jan 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="B6n+J6CL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00646425
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942518; cv=none; b=kr02vSGtUjaVKfxWTIGb8kcXtDzAU/kpMoSgX5M6dnYP6b3LEXPHCKa3yxXJv+mcJ+SHAgeAJJ79njL1lTwPGhm555tKX9qnaKZBDQZt4LHMBc839sM7DvNBZR6juCnEzazt1SEh55fIC3FlYSbiNlw1jzmXUOB94/10woMHnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942518; c=relaxed/simple;
	bh=9FDi3dQJb/mAeJwUnMY9MjdDs6PzWqtGrkamTOZqJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNaVPyuTesAu52CX108vMM7W4KNCQ+auQlDdmmQswq4fA+A7eiXer1KiefyL9JRVf+KPJ2dbxnbsaXVjPiH09rFXv/khLZ+66hlLtd9Qn+LH4fE8BHWgf9rF6edAREuzLKYYfL7iHRWmnIYI/Q8HBfyOyrESRgiobAnzV4mk/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=B6n+J6CL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1970802f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942515; x=1706547315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJWxy2lcm5N9cim72GNM3jkEUM9Gn9qLke7wIFyNsVY=;
        b=B6n+J6CLGGRw2lZnaUpewJMt7wwYyOQcBm2/bXO5qwgSFv4nM+Mod7zST+4lwXHSD6
         +rlEBfXxerpuICBwz8MglhHsO8A4jO+0CVEgINI1qNRcqXQPcRqvSVQU7A3qd01y8HmY
         YziHjhFoFDmaL18e1tTxvVq1JeD+wA4+F3ffGw5mK1sazaUtRoLrI/XJnBERBYD8JrB4
         BnkJpaubifhT6q00w/Qs9QN/OIV5Wlj5NwCMqKxKOQpA7/9vrmfqdsmKNieF14+a4rAI
         bsELOxK9jxHM4Z/GMbz2xtz9EfvKv5bWgxdTkoSpxk4EuEaklKz5pd4ILf9/gI39n0s/
         p7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942515; x=1706547315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJWxy2lcm5N9cim72GNM3jkEUM9Gn9qLke7wIFyNsVY=;
        b=Pk8qUgiHGko1dSAjds09x8U9DF3Yq2gukPmd7xIiZ9+RhfzkadUnWeUZS5tRk4b4P9
         nGMy8cPPKBmZ1lNK4IPNld4rAZWjrgN7OTQ7IUWudKnU5O2G1OtXOcfvDd8XKi1dy7Cs
         owSJe+qlPplfm1jqiXA01j/fFVDJZ/lM5w4rNV4DydaAtY1DpKIr4k5OZCpLNBhSdeQC
         7SYLdvplPUMh7OdJJJgGF+EgaTovZXgs+89oD7KkxPSAxCheeIgx+EoQ/yhUHCSx92zD
         9jWYZ6Z9U/jwd2u9P1VvA/XBbZv45M4TKmnLRghgUzKUKGxZ/3aTe6yGJYkK5WjhpIVE
         CrIg==
X-Gm-Message-State: AOJu0YxJkysfT0vhRIe74eBoRJ+nUqfcFrtx7rUS/F7izGwQunp4bfDr
	Iswi4sQ2Q3GvL0oeEWrdlJMsfHCsDnPbiEXMjY2JgDelPKeuVqWKsIb3GCqlEbw=
X-Google-Smtp-Source: AGHT+IGRtKOX0b3dThtvDBxL2vxnuwIIVQF0pjrycLDURBhaUcxe7XSwKannCCQNMqbjmqDOuF+yJg==
X-Received: by 2002:a5d:4bc2:0:b0:336:6db3:1d7a with SMTP id l2-20020a5d4bc2000000b003366db31d7amr2546110wrt.103.1705942514644;
        Mon, 22 Jan 2024 08:55:14 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:13 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC PATCH bpf-next 3/5] bpf: x86: expose how xlated insns map to jitted insns
Date: Mon, 22 Jan 2024 16:49:34 +0000
Message-Id: <20240122164936.810117-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122164936.810117-1-aspsk@isovalent.com>
References: <20240122164936.810117-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users to get the exact xlated -> jitted instructions mapping.
This is done by using a new field xlated_to_jit in bpf_prog_info
which can return up to prog->len

    struct xlated_to_jit {
            u32 off;
            u32 len;
    };

elements. The xlated_to_jit[insn_off] contains jitted offset within
a function and the length of the resulting jitted instruction.

Example:

       Original:            Xlated:                              Jitted:

                                                                 0:   nopl    (%rax,%rax)
                                                                 5:   nop
                                                                 7:   pushq   %rbp
                                                                 8:   movq    %rsp, %rbp
       0:  call 0x76        0:  r0 = 0xfffffbeef                 b:   movabsq $-1923847220, %rax
                            2:  r0 = *(u64 *)(r0 +0)            15:   movq    (%rax), %rax
       1:  r1 = 0x9 ll      3:  r1 = map[id:666][0]+9           19:   movabsq $-102223334445559, %rdi
       3:  r2 = 0x6         5:  r2 = 6                          23:   movl    $6, %esi
       4:  r3 = r0          6:  r3 = r0                         28:   movq    %rax, %rdx
       5:  call 0x6         7:  call bpf_trace_printk           2b:   callq   0xffffffffcdead4dc
       6:  call pc+2        8:  call pc+2                       30:   callq   0x7c
       7:  r0 = 0x0         9:  r0 = 0                          35:   xorl    %eax, %eax
       8:  exit            10:  exit                            37:   leave
                                                                38:   jmp     0xffffffffcbeeffbc
       ---                 ---                                  ---
                                                                 0:   nopl    (%rax,%rax)
                                                                 5:   nop
                                                                 7:   pushq   %rbp
                                                                 8:   movq    %rsp, %rbp
       9:  goto +0x1       11:  goto pc+1                        b:   jmp     0xf
      10:  goto +0x1       12:  goto pc+1                        d:   jmp     0x11
      11:  goto -0x2       13:  goto pc-2                        f:   jmp     0xd
      12:  r0 = 0x0        14:  r0 = 0                          11:   xorl    %eax, %eax
      13:  exit            15:  exit                            13:   leave
                                                                14:   jmp     0xffffffffcbffbeef

Here the xlated_to_jit array will be of length 16 (11 + 6) and equal to

     0: (0xb, 10)
     1: (0,0) /* undefined, as the previous instruction is 16 bytes */
     2: (0x15, 4)
     3: (0x19, 10)
     4: (0,0) /* undefined, as the previous instruction is 16 bytes */
     5: (0x23, 5)
     6: (0x28, 3)
     7: (0x2b, 5)
     8: (0x30, 5)
     9: (0x35, 2)
    10: (0x37, 6)
    11: (0xb, 2)
    12: (0xd, 2)
    13: (0xf, 2)
    14: (0x11, 2)
    15: (0x13, 6)

The prologues are "unmapped": no mapping exists for xlated -> [0,b)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c    | 13 +++++++++++++
 include/linux/bpf.h            |  7 +++++++
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/core.c              | 25 +++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 25 +++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  9 +++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 7 files changed, 93 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..736aec2565b8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1186,6 +1186,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		int adjust_off = 0;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
@@ -1290,6 +1291,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
 			insn++;
 			i++;
+			adjust_off = 1;
 			break;
 
 			/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
@@ -2073,6 +2075,17 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			memcpy(rw_image + proglen, temp, ilen);
+
+			if (bpf_prog->aux->xlated_to_jit) {
+				int off;
+
+				off = i - 1 - adjust_off;
+				if (bpf_prog->aux->func_idx)
+					off += bpf_prog->aux->func_info[bpf_prog->aux->func_idx].insn_off;
+
+				bpf_prog->aux->xlated_to_jit[off].off = proglen;
+				bpf_prog->aux->xlated_to_jit[off].len = ilen;
+			}
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dff4c697b674..660df06cb541 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1520,6 +1520,13 @@ struct bpf_prog_aux {
 	};
 	/* an array of original indexes for all xlated instructions */
 	u32 *orig_idx;
+	/* for every xlated instruction point to all generated jited
+	 * instructions, if allocated
+	 */
+	struct {
+		u32 off;	/* local offset in the jitted code */
+		u32 len;	/* the total len of generated jit code */
+	} *xlated_to_jit;
 };
 
 struct bpf_prog {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b15e167941fd..83dad9ea7a3b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6430,6 +6430,11 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+struct xlated_to_jit {
+	__u32 off;
+	__u32 len;
+};
+
 struct bpf_prog_info {
 	__u32 type;
 	__u32 id;
@@ -6472,6 +6477,8 @@ struct bpf_prog_info {
 	__u32 attach_btf_id;
 	__u32 orig_idx_len;
 	__aligned_u64 orig_idx;
+	__u32 xlated_to_jit_len;
+	__aligned_u64 xlated_to_jit;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 11eccc477b83..e502485c757a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -493,6 +493,26 @@ static int bpf_prog_realloc_orig_idx(struct bpf_prog *prog, u32 off, u32 patch_l
 	return 0;
 }
 
+static void adjust_func_info(struct bpf_prog *prog, u32 off, u32 insn_delta)
+{
+	int i;
+
+	if (insn_delta == 0)
+		return;
+
+	for (i = 0; i < prog->aux->func_info_cnt; i++) {
+		if (prog->aux->func_info[i].insn_off <= off)
+			continue;
+		prog->aux->func_info[i].insn_off += insn_delta;
+	}
+}
+
+static void bpf_prog_adj_orig_idx_after_remove(struct bpf_prog *prog, u32 off, u32 len)
+{
+	memmove(prog->aux->orig_idx + off, prog->aux->orig_idx + off + len,
+		sizeof(*prog->aux->orig_idx) * (prog->len - off));
+}
+
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len)
 {
@@ -554,6 +574,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	BUG_ON(bpf_adj_branches(prog_adj, off, off + 1, off + len, false));
 
 	bpf_adj_linfo(prog_adj, off, insn_delta);
+	adjust_func_info(prog_adj, off, insn_delta);
 
 	return prog_adj;
 }
@@ -574,6 +595,8 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	bpf_prog_adj_orig_idx_after_remove(prog, off, cnt);
+
 	return 0;
 }
 
@@ -2808,6 +2831,8 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	}
 	if (aux->orig_idx)
 		kfree(aux->orig_idx);
+	if (aux->xlated_to_jit)
+		kfree(aux->xlated_to_jit);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e264dbe285b2..97b0ba6ecf65 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4490,6 +4490,31 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			return -EFAULT;
 	}
 
+	ulen = info.xlated_to_jit_len;
+	if (prog->aux->xlated_to_jit)
+		info.xlated_to_jit_len = prog->len * sizeof(struct xlated_to_jit);
+	else
+		info.xlated_to_jit_len = 0;
+	if (info.xlated_to_jit_len && ulen) {
+		struct xlated_to_jit *xlated_to_jit;
+		int i;
+
+		xlated_to_jit = kzalloc(info.xlated_to_jit_len, GFP_KERNEL);
+		if (!xlated_to_jit)
+			return -ENOMEM;
+		for (i = 0; i < prog->len; i++) {
+			xlated_to_jit[i].off = prog->aux->xlated_to_jit[i].off;
+			xlated_to_jit[i].len = prog->aux->xlated_to_jit[i].len;
+		}
+		if (copy_to_user(u64_to_user_ptr(info.xlated_to_jit),
+				 xlated_to_jit,
+				 min_t(u32, info.xlated_to_jit_len, ulen))) {
+			kfree(xlated_to_jit);
+			return -EFAULT;
+		}
+		kfree(xlated_to_jit);
+	}
+
 	if (bpf_prog_is_offloaded(prog->aux)) {
 		err = bpf_prog_offload_info_fill(&info, prog);
 		if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64c7036b8b56..fad47044ccce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18951,6 +18951,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
+		func[i]->aux->xlated_to_jit = prog->aux->xlated_to_jit;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -20780,6 +20781,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	int len, ret = -EINVAL, err;
 	u32 log_true_size;
 	bool is_priv;
+	u32 size;
 
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
@@ -20930,6 +20932,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 								     : false;
 	}
 
+	if (ret == 0) {
+		size = array_size(sizeof(*env->prog->aux->xlated_to_jit), env->prog->len);
+		env->prog->aux->xlated_to_jit = kzalloc(size, GFP_KERNEL);
+		if (!env->prog->aux->xlated_to_jit)
+			ret = -ENOMEM;
+	}
+
 	if (ret == 0)
 		ret = fixup_call_args(env);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b15e167941fd..83dad9ea7a3b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6430,6 +6430,11 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+struct xlated_to_jit {
+	__u32 off;
+	__u32 len;
+};
+
 struct bpf_prog_info {
 	__u32 type;
 	__u32 id;
@@ -6472,6 +6477,8 @@ struct bpf_prog_info {
 	__u32 attach_btf_id;
 	__u32 orig_idx_len;
 	__aligned_u64 orig_idx;
+	__u32 xlated_to_jit_len;
+	__aligned_u64 xlated_to_jit;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.34.1


