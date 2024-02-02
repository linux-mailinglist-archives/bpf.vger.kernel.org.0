Return-Path: <bpf+bounces-21071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF4C8474E2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628F41C22660
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60848148FF2;
	Fri,  2 Feb 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="LWRjhOey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C441487F4
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891666; cv=none; b=uo3/UGMCXEFLC9ybwkFyO4hhQD3DgEF+1kDCbHevQc2jyMIOm0dX5NURviHeJgrX9/Pj3zZUFkICBdNj5vt9IL3uH8BNhFbH47Ro22lEYW4XXqtNFvDnwPGWxuy9lc/mje6lbi5yT+upFsjGHf2DhLPcNueB/FoaYezhi+jwzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891666; c=relaxed/simple;
	bh=bNowxqK6s8C3syKDPvlOUzdu7D3tdyI0c6VNHRN4uwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5kxuxNii/x4IfWevt7rRc4jZ+o5cK9miS8cFROu0b+G+eLTY+BXClAzo1O2SZGxJh6AdHzEeQihXNVDSlZ0cTpCQ2HepvqDgfX79k3qWPXnlo3Ta4HsIk+2VyyB9EmJ9N1MvNL1AYCrNY/RCib3Ku0MNTnP0re/MGwNdZN8E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=LWRjhOey; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1831312a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891663; x=1707496463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQnEiZYPethPwLa16b0xJfRGCxsPiWgVF9283FCozko=;
        b=LWRjhOeyEQdSf8t/h3OGcM3yxWeBFwVL61j9oDF2Eo4dCrg9MugfIs5AAX9SZdqVgZ
         EqFcwWbPUW6deFvxER2ixYcbgNFgNreYwfScqgXcsJthJhZ0t2gkXYxCltPtGhlfgRNT
         /oTO0YHyRBpKKRh414U2jtdAPMq5DyJ4OF3GB1MKFnKPdz450fYOVnm+3sOYhPuYlK9w
         dISIjFzMe/FDiUiOTHWEJQ1oVVWZZELpfPPa4SorxTl+QR3qrU89xCrVttGlxaVM8ma+
         x2wD3xeZ4UCTH28DymtbyN5jCWUkmqxg6y5KotoylWFoHn2fSbwIloSD9zHZmDN34HMB
         vBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891663; x=1707496463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQnEiZYPethPwLa16b0xJfRGCxsPiWgVF9283FCozko=;
        b=XT0tv+JomHbCj8aO0PfNvACw6qr5BV+UmQJUNWAKbDnuv1USzfZbR4+mOjqvT1YXv0
         OMsloXHQwgpwitKxl+krgAbJbq9NzsRlZ7R5GNGDyWnZYANhAP/4SAKmdzknJQu1HKHa
         eduPzJCtpfXzEkjPDfmEQfB+UjeTadsg/Oht54cf2y+yhK0bR0EToUFXKyEPmXOuQkCS
         ckKSGhMT1Qy6A978ScptBGjzrl/3l7rd+WcoZoWMcOrxtMOre1yDfAiLUgv+UoB83sR/
         2/Ae7Wy9pd0NLx4GU0KFxB1dphiSqC0BI8r7ALczCk3+FYFfxmFV3mfeLIvw2aT9RI3n
         ARgw==
X-Gm-Message-State: AOJu0YwRxo/rBf5/jiSiMMCmneK32p8Mgt0irb0P1gRrOsTKmpxvEvnG
	XwuV8I/rabWmLnJJZ0Gj2LkfnQz1mC6Oa+rq1KeOxV9C2LExuVjK/muQhL0xchM=
X-Google-Smtp-Source: AGHT+IEWc8r51wN7yXndGPjJxj2ElaKXc38dnVl8NQKn+hA36hSb+ukixAFEGb048dwsw1tZlUTI2g==
X-Received: by 2002:a05:6402:1659:b0:55f:e543:b006 with SMTP id s25-20020a056402165900b0055fe543b006mr92975edx.13.1706891663273;
        Fri, 02 Feb 2024 08:34:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOFbEzg+JPWuzlKADSq9mckHaiFJ1NRxvt2YiIbYuOFK5MNskQWzswDO4xuFnEln4PVCYBc14GyyS8qglyOMCaXPhmJKuqRe56fn22q8rg6KFzKG92M9uJBQoXX6tzly36Iy+Ab1mOLHstMzhIB+l6n9DaLU4fRtS4Uw3Bh0IUsHcjAXTRkLi8gCA9AGULZikwk3Yp8lwguqxDlbMPwWPSjfEVf0B6PiUJseM8niedsLFfutlVmoVzT7sp6hx1sVylp4c7WZKeosWadIi334E6mAvLMGXApaoHNtvAFX2PIux57Zd54n4=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:22 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 8/9] bpf: add BPF_STATIC_BRANCH_UPDATE syscall
Date: Fri,  2 Feb 2024 16:28:12 +0000
Message-Id: <20240202162813.4184616-9-aspsk@isovalent.com>
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

Add a new bpf system call, BPF_STATIC_BRANCH_UPDATE, which allows users to
update static branches in BPF. Namely, this system call is executed as

    bpf(BPF_STATIC_BRANCH_UPDATE, attrs={prog_fd, insn_off, on})

where prog_fd points to a BPF program, insn_off is an _xlated_ offset in
this program, on is a boolean value to set this branch on or off.
The instruction at insn_off must be a JA with SRC_REG or'ed with
BPF_STATIC_BRANCH_JA and, optionally, with BPF_STATIC_BRANCH_INVERSE.

To implement this for a particular architecture, re-define the weak
bpf_arch_poke_static_branch() function in the corresponding bpf_jit_comp.c
This patch adds x86 implementation.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c    | 40 +++++++++++++++++++++++
 include/linux/bpf.h            |  2 ++
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/core.c              |  5 +++
 kernel/bpf/syscall.c           | 60 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 ++++
 7 files changed, 122 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b291b5c79d26..2090713e4126 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2099,8 +2099,17 @@ st:			if (is_imm8(insn->off))
 				if (func_idx)
 					off += bpf_prog->aux->func_info[func_idx].insn_off;
 
+				bpf_prog->aux->xlated_to_jit[off].ip = image + proglen;
 				bpf_prog->aux->xlated_to_jit[off].off = proglen;
 				bpf_prog->aux->xlated_to_jit[off].len = ilen;
+
+				/*
+				 * Save the offset so that it can later be accessed
+				 * by the bpf(BPF_STATIC_BRANCH_UPDATE) syscall
+				 */
+				if (insn->code == (BPF_JMP | BPF_JA) ||
+				    insn->code == (BPF_JMP32 | BPF_JA))
+					bpf_prog->aux->xlated_to_jit[off].jmp_offset = jmp_offset;
 			}
 		}
 		proglen += ilen;
@@ -3276,3 +3285,34 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+int bpf_arch_poke_static_branch(struct bpf_prog *prog,
+				u32 insn_off,
+				bool on)
+{
+	int jmp_offset = prog->aux->xlated_to_jit[insn_off].jmp_offset;
+	u32 len = prog->aux->xlated_to_jit[insn_off].len;
+	u8 op[5];
+
+	if (WARN_ON_ONCE(is_imm8(jmp_offset) && len != 2))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(!is_imm8(jmp_offset) && len != 5))
+		return -EINVAL;
+
+	if (on) {
+		if (len == 2) {
+			op[0] = 0xEB;
+			op[1] = jmp_offset;
+		} else {
+			op[0] = 0xE9;
+			memcpy(&op[1], &jmp_offset, 4);
+		}
+	} else {
+		memcpy(op, x86_nops[len], len);
+	}
+
+	text_poke_bp(prog->aux->xlated_to_jit[insn_off].ip, op, len, NULL);
+
+	return 0;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdd6be718e82..1363b1fc8c09 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1528,8 +1528,10 @@ struct bpf_prog_aux {
 	 * instructions, if allocated
 	 */
 	struct {
+		void *ip;	/* the address of the jitted insn */
 		u32 off;	/* local offset in the jitted code */
 		u32 len;	/* the total len of generated jit code */
+		u32 jmp_offset;	/* jitted jump offset for BPF_JA insns */
 	} *xlated_to_jit;
 };
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..0dad44fa3af2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -957,6 +957,7 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
+int bpf_arch_poke_static_branch(struct bpf_prog *prog, u32 off, bool on);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aca5ed065731..8aafb0eddd1c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -932,6 +932,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_STATIC_BRANCH_UPDATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1787,6 +1788,12 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_STATIC_BRANCH_UPDATE command */
+		__u32		prog_fd;
+		__u32		insn_off;
+		__u32		on;
+	} static_branch;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8e99c1563a7f..fec185354ea3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3042,6 +3042,11 @@ static int __init bpf_global_ma_init(void)
 late_initcall(bpf_global_ma_init);
 #endif
 
+int __weak bpf_arch_poke_static_branch(struct bpf_prog *prog, u32 off, bool on)
+{
+	return -EOPNOTSUPP;
+}
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 36b8fdcfba75..9e2e12a0bdfe 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1540,6 +1540,63 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
+static int parse_static_branch_insn(struct bpf_insn *insn, bool *inverse)
+{
+	__u8 code = insn->code;
+
+	if (code != (BPF_JMP | BPF_JA) && code != (BPF_JMP32 | BPF_JA))
+		return -EINVAL;
+
+	if (insn->src_reg & ~BPF_STATIC_BRANCH_MASK)
+		return -EINVAL;
+
+	if (!(insn->src_reg & BPF_STATIC_BRANCH_JA))
+		return -EINVAL;
+
+	if (insn->dst_reg)
+		return -EINVAL;
+
+	*inverse = !(insn->src_reg & BPF_STATIC_BRANCH_NOP);
+
+	return 0;
+}
+
+#define BPF_STATIC_BRANCH_UPDATE_LAST_FIELD static_branch.on
+
+static int bpf_static_branch_update(union bpf_attr *attr)
+{
+	bool on = attr->static_branch.on & 1;
+	struct bpf_prog *prog;
+	u32 insn_off;
+	bool inverse;
+	int ret;
+
+	if (CHECK_ATTR(BPF_STATIC_BRANCH_UPDATE))
+		return -EINVAL;
+
+	if (attr->static_branch.on & ~1)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->static_branch.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	insn_off = attr->static_branch.insn_off;
+	if (insn_off >= prog->len) {
+		ret = -ERANGE;
+		goto put_prog;
+	}
+
+	ret = parse_static_branch_insn(&prog->insnsi[insn_off], &inverse);
+	if (ret)
+		goto put_prog;
+
+	ret = bpf_arch_poke_static_branch(prog, insn_off, on ^ inverse);
+
+put_prog:
+	bpf_prog_put(prog);
+	return ret;
+}
 
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
@@ -5694,6 +5751,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_MAP_DELETE_BATCH:
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
+	case BPF_STATIC_BRANCH_UPDATE:
+		err = bpf_static_branch_update(&attr);
+		break;
 	case BPF_LINK_CREATE:
 		err = link_create(&attr, uattr);
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index aca5ed065731..8aafb0eddd1c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -932,6 +932,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_STATIC_BRANCH_UPDATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1787,6 +1788,12 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_STATIC_BRANCH_UPDATE command */
+		__u32		prog_fd;
+		__u32		insn_off;
+		__u32		on;
+	} static_branch;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.34.1


