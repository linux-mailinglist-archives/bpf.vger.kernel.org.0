Return-Path: <bpf+bounces-21066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551A8474DD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C876B24FCD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED491487F7;
	Fri,  2 Feb 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JzGviSB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B814831F
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891662; cv=none; b=nzvbP3G4J9hA/LErAyLPZc9IWHYaFigMxa2lmjajlSQIc28M7WHfd8cz7YpMOeurHuc2XZpjDEXpyYd8jTzPg0bq/BIEA+XeTRGOl88uhBSxNFlETwsIMIqmutJpcNQ2J0tD/i2sREyKSZiGA6rnRKYWuZEVCrxQBT4lxysEOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891662; c=relaxed/simple;
	bh=eQRCvv/nvao4Ag3993uceu9j2Izh1r0MC4HF8KLpIAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bO1MAhCTIpEJR/4Nm2hCrx0hgBPbymwH6qbeB61saa6gYnZ6yfxVL+e2oO1HxefbatEayOS44L3IwpskqUEeXON7vnY4AjpAuJ+Ggjl+1zI/va8dIsUFrbZ1gA8qo8iaId7X5DUzEjxhBqAHWToLhBrylCfKO5VAYIhNdLt59VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JzGviSB0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf45305403so28254361fa.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891658; x=1707496458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDxa/0DzWT7yXuuXKohUyBoMTDCBisl0p5q7nAF3Gaw=;
        b=JzGviSB0scQWzusZ8wjZI0iBVEAUsEfTI6Osx7C4lUS0iXerV99oV86dXEAkL0HADG
         QV8Zly9JEp4mCtMs1x3dhUSnFXHv8IgwXwJ2N9fK9GLxc5FD7gNFpkB6LvE/Hnzjy11N
         H7/QzUav6ybyqCxABPuB6hEQ/ob4nnb3McCbzW2K8U4FJPsUkzcHpQrIXv2sRhAuNIFN
         7yoWR7RhOEQgN4/cUkZRJ6wk+4Kl6bJDxsw9UVYojVhmK0Kn4fQPI4RKWKl9NJtI+jrE
         JPRbtdrRJwlvmBIvEglwelKMVnRbO+AIw+c3KVtF0Zyy5hSc18P9aLRztYslfnopF+zn
         8Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891658; x=1707496458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDxa/0DzWT7yXuuXKohUyBoMTDCBisl0p5q7nAF3Gaw=;
        b=mcRpcJZakcRcgg1c2XRWf4miSIZoa4zExtxEEjrTOt8QP9ZPDMPNYuQWuHsxF6B/19
         RytAtSZzSuI2mx5k0gY66y/+ITlvymr722KNhmyjZ+lM3LmSlW+JtRepXITWhnnDfJV8
         XAwMKg2UQMJu/qR6gSXC4hVpz8BCXaSSgKwVHuxWnr8sK61S6/5fyA6oc21E0l23SgDr
         ReWTOSZXTxZ2P+AloiKeWBXEMHPPtXpheC2tdzX1xUI1kTjazjLgowcHtOSYVJoOiyHP
         ZAn4TmQ1KTVm0Z29V2j+dXukJqB500pk7/waN86BVNstaSyYjsEo14PMRUIw8l4dkLVX
         NkSA==
X-Gm-Message-State: AOJu0YyoDxqAAonKyRUommdQo/Kgsp+5RbKZ3cQeb/eN2eH86lZGLIso
	9pTsx1c0hEE8xoxk9M07lQauASiYTEjR0NbpvHO141Ttv7OMQV5I8M1UjpEGP/g=
X-Google-Smtp-Source: AGHT+IHJ91LEBI8SkIeU4NotnRCW9xrmQ5th/m8NP24jJ3MaropCq2+k6AGTuYrg+1lzNolQjujgYg==
X-Received: by 2002:a2e:9c0c:0:b0:2cf:35d8:31ee with SMTP id s12-20020a2e9c0c000000b002cf35d831eemr3293122lji.16.1706891657899;
        Fri, 02 Feb 2024 08:34:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsoMwV0Pvr3lU0X5HSYWR4JVlTpiNTKS0JcNVSm3ysOkuenUbEGhHY1/cb0ACGp496szm/q/+mentJx0fluvKvO+NrJn/W5GTupkAcVGw5UEsxasT66vfJPSAY+T7+ehrj5w3f8hSiAqJNLQIOUtVMR4KuPlBurU5aOaj9VxLPxhyo2RYCKm16bYbX5ba1uoxDwLujapr90sjFocMGxdsMwZS1JcEueMa1iz2CiDrCoWWc+VuFsCJhQZBI60eBKa7ETw5nxC8bK/SU7qX3ruA98okV1JicMUqHvf5Yg6aLbo1Q2KolRU8=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:17 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to jitted insns
Date: Fri,  2 Feb 2024 16:28:07 +0000
Message-Id: <20240202162813.4184616-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202162813.4184616-1-aspsk@isovalent.com>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
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

    struct bpf_xlated_to_jit {
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
 arch/x86/net/bpf_jit_comp.c    | 14 ++++++++++++++
 include/linux/bpf.h            |  7 +++++++
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/core.c              | 24 ++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 25 +++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  9 +++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 7 files changed, 93 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..a80b8c1e7afe 100644
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
@@ -2073,6 +2075,18 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			memcpy(rw_image + proglen, temp, ilen);
+
+			if (bpf_prog->aux->xlated_to_jit) {
+				u32 func_idx = bpf_prog->aux->func_idx;
+				int off;
+
+				off = i - 1 - adjust_off;
+				if (func_idx)
+					off += bpf_prog->aux->func_info[func_idx].insn_off;
+
+				bpf_prog->aux->xlated_to_jit[off].off = proglen;
+				bpf_prog->aux->xlated_to_jit[off].len = ilen;
+			}
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4def3dde35f6..bdd6be718e82 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
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
index b929523444b0..c874f354c290 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6493,6 +6493,11 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+struct bpf_xlated_to_jit {
+	__u32 off;
+	__u32 len;
+};
+
 struct bpf_prog_info {
 	__u32 type;
 	__u32 id;
@@ -6535,6 +6540,8 @@ struct bpf_prog_info {
 	__u32 attach_btf_id;
 	__u32 orig_idx_len;
 	__aligned_u64 orig_idx;
+	__u32 xlated_to_jit_len;
+	__aligned_u64 xlated_to_jit;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f0086925b810..8e99c1563a7f 100644
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
 
@@ -2807,6 +2830,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 		bpf_jit_free(aux->prog);
 	}
 	kfree(aux->orig_idx);
+	kfree(aux->xlated_to_jit);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 172bf8d3aef2..36b8fdcfba75 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4571,6 +4571,31 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			return -EFAULT;
 	}
 
+	ulen = info.xlated_to_jit_len;
+	if (prog->aux->xlated_to_jit)
+		info.xlated_to_jit_len = prog->len * sizeof(struct bpf_xlated_to_jit);
+	else
+		info.xlated_to_jit_len = 0;
+	if (info.xlated_to_jit_len && ulen) {
+		struct bpf_xlated_to_jit *xlated_to_jit;
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
index 2dc48f88f43c..270dc0a26d03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18974,6 +18974,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
+		func[i]->aux->xlated_to_jit = prog->aux->xlated_to_jit;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -20832,6 +20833,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	int len, ret = -EINVAL, err;
 	u32 log_true_size;
 	bool is_priv;
+	u32 size;
 
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
@@ -20981,6 +20983,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
index b929523444b0..c874f354c290 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6493,6 +6493,11 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+struct bpf_xlated_to_jit {
+	__u32 off;
+	__u32 len;
+};
+
 struct bpf_prog_info {
 	__u32 type;
 	__u32 id;
@@ -6535,6 +6540,8 @@ struct bpf_prog_info {
 	__u32 attach_btf_id;
 	__u32 orig_idx_len;
 	__aligned_u64 orig_idx;
+	__u32 xlated_to_jit_len;
+	__aligned_u64 xlated_to_jit;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.34.1


