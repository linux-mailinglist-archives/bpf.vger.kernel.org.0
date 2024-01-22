Return-Path: <bpf+bounces-20020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129AF836DD3
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386651C27BD0
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60E46458;
	Mon, 22 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="jX3tpw9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA241208
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942520; cv=none; b=fuD9W53xFtgDeq5jKnf9/PifeKKb2ajhX1gTVgAYu4rH4WGtQrT4aJSCFaGuBQ1sz6o9JMnwu9z3PVjU42c3ezMNTwN2V9t40h9qY1ibdM2yOtE8HvznX3gnqPen7gMirS4bmJ3Ipp5pE6fjzl8qGz+fUwRSQtBb4Z2juU0o43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942520; c=relaxed/simple;
	bh=cZjpKPxPrqDPtgcejA44TvK/pDVNDFwOdyBVExEbLKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoPrlLNc6EPekrlYJPCaX0h2iav9PEhY3YxwBBj6FpC2Uy+4B16PvUX2ZswB0m6MLzChDK5OiA+gSntg59aN8huiVsqYXeaD60t4TkbPgtoLjQMM+gUwE6typaogYWUrmRcrDZrxVxBXgkgmrWufvLHv3cNKaOwHwsuoEkISIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=jX3tpw9y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so3411564f8f.1
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942516; x=1706547316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h4qmgQCEdQTD1zELscostpe/AIlt+1ZyfYipGBfXhU=;
        b=jX3tpw9y3LrnNVdsfeJTZKvYH5XOR5rjp4jzPGknlK9ToVv1UPzy75bmDHefEa7J7O
         NAAlLufr18dwC2Sp0wuuoFuQGipWSOGCS1BiGVThfRFjTz0s0KVjf/vKCoYwiXSMQtQH
         kraZGOtliHLkdeMa352bsVFP6JCULc9ilZNC/XwP93mhnYU4t6hc4oYtqvBf0YwSLohv
         ZDOZN32BqvGYfMZCQtdHHN2l7V2CqigoTUuq2KRHkyOQIznJ88zDrAykNXZK5Citnw2v
         kmbUmeWBUesiL2XfQyP42LGfFh2lDix+3efILrPm970myz0EnvoLydKDPYpM9G9xBgm1
         WG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942516; x=1706547316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h4qmgQCEdQTD1zELscostpe/AIlt+1ZyfYipGBfXhU=;
        b=qh5s3C6pSkcXMgpFW6XVMP4epINnkHzMGI48dXGJ/htRp8Wm0Y/TVbygGpJc5dE54Z
         polxO8wDFRCAjH5DT3rJdzTstyqUG8d+z1N0jToTG9XxUBAe7Yf5Wc8hc4xIKvxW0kEV
         hedSXVt84cJb/J1GP8gtOmhXDKF05uxM4GNSkCWOGoWhTe84ffAOHTvR/4iqJ39uQI36
         oRiWK0b4+NVYALNSdE6qQW/Zdd4mCVYwZ56xfJKcHGPaSAEtCuYrMSTtKp/wps8eRVwJ
         dUxjI78K6YS3yBZT+RVkg7UmDOyWDTU65dol283DT12fZp2FnpUiamMN0Pt7jRnQj93z
         wxkw==
X-Gm-Message-State: AOJu0YzxkFx2hFvG6RJJUVa5h0NUsCmGBxgBIdD8aCNB4r2SfyyuxHil
	c/WvNqpOCYNzKsYjvNIOtYkc6x80K1F1FImwx1a3mCzhgdho3M6mOGVCjIccZLc=
X-Google-Smtp-Source: AGHT+IGA9YIgf5R5jS+yLv/YWsOW3Sh+HjYy1e9+hVj84rzMNXnKqWu2KyTnK4V4fnmqDbCcRNyaIA==
X-Received: by 2002:adf:e546:0:b0:337:c702:98f7 with SMTP id z6-20020adfe546000000b00337c70298f7mr2605066wrm.95.1705942516497;
        Mon, 22 Jan 2024 08:55:16 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:16 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 5/5] bpf: x86: add BPF_STATIC_BRANCH_UPDATE syscall
Date: Mon, 22 Jan 2024 16:49:36 +0000
Message-Id: <20240122164936.810117-6-aspsk@isovalent.com>
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

Add a new bpf system call, BPF_STATIC_BRANCH_UPDATE, which allows users to
update static branches in BPF. Namely, this system call is executed as

    bpf(BPF_STATIC_BRANCH_UPDATE, attrs={prog_fd, insn_off, on})

where prog_fd points to a BPF program, insn_off is an _xlated_ offset in
this program, on is a boolean value to set this branch on or off.
The instruction at insn_off must be a JA with SRC_REG or'ed with
BPF_STATIC_BRANCH_JA and, optionally, with BPF_STATIC_BRANCH_INVERSE.

To implement this for a particular architecture, re-define the weak
bpf_arch_poke_static_branch() function in the corresponding bpf_jit_comp.c

Example of usage can be found below.  Lets load and compile the
following [dummy] program:

    SEC("kprobe/__x64_sys_getpgid")
    int worker(void *ctx)
    {
            if (bpf_static_branch_unlikely(&key))
                    return 1;
            else
                    return 0;
    }

Here key is some map and bpf_static_branch_unlikely() is defined as
follows:

    static __always_inline int __bpf_static_branch_nop(void *static_key)
    {
            asm goto("1:\n\t"
                    "nop_or_gotol %l[l_yes]\n\t"
                    ".pushsection .jump_table, \"aw\"\n\t"
                    ".balign 8\n\t"
                    ".long 1b - .\n\t"
                    ".long %l[l_yes] - .\n\t"
                    ".quad %c0 - .\n\t"
                    ".popsection\n\t"
                    :: "i" (static_key)
                    :: l_yes);
            return 0;
    l_yes:
            return 1;
    }

    #define bpf_static_branch_unlikely(static_key) \
            unlikely(__bpf_static_branch_nop(static_key))

Here the extra code is needed to automate search for the static
branch location, and the main part is the usage of asm goto + the
nop_or_gotol instruction.

After compilation and load the program will look like this:

    # bpftool prog dump x id 42
    int worker(void * ctx):
       0: (b7) r0 = 1
       1: (06) nop_or_gotol pc+1
       2: (b7) r0 = 0
       3: (95) exit

And the jitted program will have nop_or_gotol (jitted offset 0x10)
translated to a NOP (as the branch is not activated by default):

    # bpftool prog dump j id 42
    int worker(void * ctx):
       0:   nopl    (%rax,%rax)
       5:   nop
       7:   pushq   %rbp
       8:   movq    %rsp, %rbp
       b:   movl    $1, %eax
    ; asm goto("1:\n\t"
      10:   nop
      12:   xorl    %eax, %eax
      14:   leave
      15:   jmp     0xffffffffcbc16ed8

If we issue a

    bpf(BPF_STATIC_BRANCH_UPDATE, {bpf_prog_get_fd_by_id(42), .off=1, .on=1})

syscall (xlated offset = 1, on = 1), then the jitted code will change
to

    # bpftool prog dump j id 42
    int worker(void * ctx):
       0:   nopl    (%rax,%rax)
       5:   nop
       7:   pushq   %rbp
       8:   movq    %rsp, %rbp
       b:   movl    $1, %eax
    ; asm goto("1:\n\t"
      10:   jmp     0x14
      12:   xorl    %eax, %eax
      14:   leave
      15:   jmp     0xffffffffcbc16ed8

as expected.

A "likely" variant can be implemented using the 'gotol_or_nop'
instruction.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 +++++++++++++++++++++++++
 include/linux/bpf.h         |  2 ++
 include/linux/filter.h      |  1 +
 include/uapi/linux/bpf.h    |  7 +++++
 kernel/bpf/core.c           |  5 ++++
 kernel/bpf/syscall.c        | 57 +++++++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 52b9de134ab3..c757e4d997a7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2098,8 +2098,16 @@ st:			if (is_imm8(insn->off))
 				if (bpf_prog->aux->func_idx)
 					off += bpf_prog->aux->func_info[bpf_prog->aux->func_idx].insn_off;
 
+				bpf_prog->aux->xlated_to_jit[off].ip = image + proglen;
 				bpf_prog->aux->xlated_to_jit[off].off = proglen;
 				bpf_prog->aux->xlated_to_jit[off].len = ilen;
+
+				/*
+				 * save the offset so that it can later be accessed
+				 * by the bpf(BPF_STATIC_BRANCH_UPDATE) syscall
+				 */
+				if (insn->code == (BPF_JMP | BPF_JA) || insn->code == (BPF_JMP32 | BPF_JA))
+					bpf_prog->aux->xlated_to_jit[off].jmp_offset = jmp_offset;
 			}
 		}
 		proglen += ilen;
@@ -3275,3 +3283,34 @@ bool bpf_jit_supports_ptr_xchg(void)
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
+	if (is_imm8(jmp_offset) && len != 2)
+		return -EINVAL;
+
+	if (!is_imm8(jmp_offset) && len != 5)
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
index 660df06cb541..ba77e0c6f390 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1524,8 +1524,10 @@ struct bpf_prog_aux {
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
index 35f067fd3840..ff76a60cf247 100644
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
index 43ad332ffbee..e5d226838a3d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -901,6 +901,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_STATIC_BRANCH_UPDATE,
 };
 
 enum bpf_map_type {
@@ -1724,6 +1725,12 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_STATIC_BRANCH_UPDATE command */
+		__u32		prog_fd;
+		__u32		insn_off;
+		__u32		on;
+	} static_branch;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e502485c757a..5272879449d8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3043,6 +3043,11 @@ static int __init bpf_global_ma_init(void)
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
index 97b0ba6ecf65..c3509e59f82d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1504,6 +1504,60 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
+int parse_static_branch_insn(struct bpf_insn *insn, bool *inverse)
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
 
@@ -5578,6 +5632,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_MAP_DELETE_BATCH:
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
+	case BPF_STATIC_BRANCH_UPDATE:
+		err = bpf_static_branch_update(&attr);
+		break;
 	case BPF_LINK_CREATE:
 		err = link_create(&attr, uattr);
 		break;
-- 
2.34.1


