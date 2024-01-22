Return-Path: <bpf+bounces-20017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8E836DCF
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852F5285659
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A104643E;
	Mon, 22 Jan 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HhvDAnBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E341208
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942516; cv=none; b=UhPWtlUX6hmURIdzH9oh5A9FQTDaIprI1JsPrUQXCTFgE8qsQ+4W4x73jt4g2usNfnjjUsZp/VtIjfaok9kt4+i+QqUlQ4LoG8aMheOG5s5WcY5pENI6wPxovud02ItzYI2OMhYLjGy7mz3dWfX9Gvp3V1DX0fuiaEWbH2RKdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942516; c=relaxed/simple;
	bh=UcGDzvkDjL9SLgH/9FDb4ZbK1f+w54MkTyUNXnEhSmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6rUtCqMzUIixvQPo2rBiqKhwBL8BrHMtyCWTqvulBsjiB+v5JF6hGfTiUiKJwfxKtUg8yF+kKqcNMFq/kCvR8Ip4YBB7fqiRfNAK4li7Df/QxfeGQrE0UK/6sKkUGFs5O9vtq+3/ySESBJllhWD2y9+AP7H0Gw1eSK+kY0zmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HhvDAnBz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40eb033c192so5131205e9.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942513; x=1706547313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do7mSYLj9Lrqxye6Pg2WIdmtAc/NtD9Jzg3+d+DqMyE=;
        b=HhvDAnBzODbAcCcm27v0aq0zd6Q3LayU9amgoMQVT2Wuy9wzHTcoB6qX3TcOdZt7Dx
         Ge4mvbIOEd132Fu22BwYoIfdVEuCIIn6v+4hq+qw73fn4SuuZN5rVpy2lQ7L9GsWriFj
         6ia+GEhPpnIsNJ1Pvhit1W2ZvBJpZJ7+k44s4unqOsdK9pCPfs9bjk/W1K24cOB7jLf8
         mITfZuFcxEp9nq6SNgYCftYuwOKy8PKI5ZLPub87aFkQniLZgjKbdBBklNZLy3h+5szb
         /sgDXHKlCDKndi0oBxRHDE+pPhpDDTRq/8KpMyBz5ogCjzOe/cdcgVVZPdoosJW8XYaj
         krig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942513; x=1706547313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do7mSYLj9Lrqxye6Pg2WIdmtAc/NtD9Jzg3+d+DqMyE=;
        b=siPJGE/LpJKfGcuZYkdM3Ro25TjaS5/EJGTCpJoF5Nn5enX5oNUbH88ok9/4CNd9z3
         eFKYubjcsR3Q38P0CgC4HQ7EbPoc6fRaPL1B1oO2NTgMz48evVJoTrXInnEfMeGZqddy
         Mo2zbCTl2DDr8bUz62sEIqvBCzlEguq8xxmUZEQkQQgBfoorswBSkwWUiSc9/ErHRI1D
         NeXtJw2h3zSBPuRXGyHXGXsrJ8+egRHdAiIOPnVJZKzIrZOzMLK8YqIlarhPdaPocSCr
         ta8roCdcMVQ05zPxUt94+5Pdhh6A4zs40bRyEdd1USrqh4g0oO+TtmcUloiLGK1DFiIm
         tTxg==
X-Gm-Message-State: AOJu0YwmjpR15U9G0BYp19AcnR13xCI2D3BKgkHrcKq3oVIrs8aoLTlc
	tOlv2hj+1h53cvE5qa2UDtEMUBdtBjKLj/P3tQF4+kMmTd+l66CWX3NKrRKI0tk=
X-Google-Smtp-Source: AGHT+IF7B1y9wwvU0xEGDpi1BVG8BWRdzeK/ab/QscrBsWg8k03LhSDO7nvfPkDOYMcQl4cNBxm6lQ==
X-Received: by 2002:a05:600c:6a8e:b0:40e:4ad9:90df with SMTP id jl14-20020a05600c6a8e00b0040e4ad990dfmr2209724wmb.158.1705942513135;
        Mon, 22 Jan 2024 08:55:13 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:12 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 2/5] bpf: keep track of and expose xlated insn offsets
Date: Mon, 22 Jan 2024 16:49:33 +0000
Message-Id: <20240122164936.810117-3-aspsk@isovalent.com>
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

On bpf(BPF_PROG_LOAD) syscall a user-supplied program is translated by
the verifier into an "xlated" program. During this process the original
instruction offsets might be adjusted and/or individual instructions
might be replaced by a new set of instructions:

  User-supplied prog:   --->   Xlated prog:

         -- func 0 --          -- func 0 --
             insn                  insn'
             ...                   ...
             insn                  insn'
         -- func 1 --          -- func 1 --
             insn                  insn'
             ...                   ...
             insn                  insn'
         -- func N --          -- func N --
             insn                  insn'
             ...                   ...
             insn                  insn'

We want to provide users (and ourselves) with the off(insn') -> off(insn)
mapping so that when an xlated program is returned to the userspace by the
bpf_prog_get_info_by_fd() function, users can determine the real offsets
of instructions of interest.

Since the 9e4c24e7ee7d ("bpf: verifier: record original instruction
index") commit the verifier saves the original instruction index in
env->insn_aux_data. This information was, however, lost when we patched
instructions. Also, the information about original index was kept in the
verifier env only, so was inaccessible by later stages, like constants
blinding during the jit stage.

To address the above issues save the information about the original
indexes in a separate array inside the prog->aux so that it doesn't
depend on the verifier environment and can be adjusted, and accessed,
during later stages.

To let users access the information after the program was loaded, add new
fields, orig_idx_len and orig_idx to struct bpf_prog_info and patch the
bpf_prog_get_info_by_fd function correspondingly.

Example mapping would be something like this:

    Original prog:                      Xlated prog:

     0:  r1 = 0x0                        0: r1 = 0
     1:  *(u32 *)(r10 - 0x4) = r1        1: *(u32 *)(r10 -4) = r1
     2:  r2 = r10                        2: r2 = r10
     3:  r2 += -0x4                      3: r2 += -4
     4:  r1 = 0x0 ll                     4: r1 = map[id:88]
     6:  call 0x1                        6: r1 += 272
                                         7: r0 = *(u32 *)(r2 +0)
                                         8: if r0 >= 0x1 goto pc+3
                                         9: r0 <<= 3
                                        10: r0 += r1
                                        11: goto pc+1
                                        12 r0 = 0
     7:  r6 = r0                        13 r6 = r0
     8:  if r6 == 0x0 goto +0x2         14: if r6 == 0x0 goto pc+4
     9:  call 0x76                      15: r0 = 0xffffffff8d2079c0
                                        17: r0 = *(u64 *)(r0 +0)
    10:  *(u64 *)(r6 + 0x0) = r0        18: *(u64 *)(r6 +0) = r0
    11:  r0 = 0x0                       19: r0 = 0x0
    12:  exit                           20: exit

Here the orig_idx array has length 21 and is equal to

    (0, 1, 2, 3, 4, 0/*undefined*/, 6, 6, 6, 6, 6, 6, 6, 7, 8, 9, 9, 10, 11, 12)

The item 6 is undefined because the r1=0ll occupies 16 bytes.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h            |  2 ++
 include/linux/bpf_verifier.h   |  1 -
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/core.c              | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  6 ++----
 tools/include/uapi/linux/bpf.h |  2 ++
 7 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 377857b232c6..dff4c697b674 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1518,6 +1518,8 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	/* an array of original indexes for all xlated instructions */
+	u32 *orig_idx;
 };
 
 struct bpf_prog {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e11baecbde68..2728c83ea46d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -553,7 +553,6 @@ struct bpf_insn_aux_data {
 	u8 alu_state; /* used in combination with alu_limit */
 
 	/* below fields are initialized once */
-	unsigned int orig_idx; /* original instruction index */
 	bool jmp_point;
 	bool prune_point;
 	/* ensure we check state equivalence and save state checkpoint and
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a00f8a5623e1..b15e167941fd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6470,6 +6470,8 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 orig_idx_len;
+	__aligned_u64 orig_idx;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9ba9e0ea9c45..11eccc477b83 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -469,6 +469,30 @@ static void bpf_adj_linfo(struct bpf_prog *prog, u32 off, u32 delta)
 		linfo[i].insn_off += delta;
 }
 
+static int bpf_prog_realloc_orig_idx(struct bpf_prog *prog, u32 off, u32 patch_len)
+{
+	u32 *old_idx = prog->aux->orig_idx, *new_idx;
+	u32 new_prog_len = prog->len + patch_len - 1;
+	int i;
+
+	if (patch_len <= 1)
+		return 0;
+
+	new_idx = kzalloc(array_size(new_prog_len, sizeof(u32)), GFP_KERNEL);
+	if (!new_idx)
+		return -ENOMEM;
+
+	memcpy(new_idx, old_idx, sizeof(*old_idx) * off);
+	for (i = off; i < off + patch_len; i++)
+		new_idx[i] = old_idx[off];
+	memcpy(new_idx + off + patch_len, old_idx + off + 1,
+			sizeof(*old_idx) * (prog->len - off));
+
+	prog->aux->orig_idx = new_idx;
+	kfree(old_idx);
+	return 0;
+}
+
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len)
 {
@@ -494,6 +518,10 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	    (err = bpf_adj_branches(prog, off, off + 1, off + len, true)))
 		return ERR_PTR(err);
 
+	err = bpf_prog_realloc_orig_idx(prog, off, len);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Several new instructions need to be inserted. Make room
 	 * for them. Likely, there's no need for a new allocation as
 	 * last page could have large enough tailroom.
@@ -2778,6 +2806,8 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	} else {
 		bpf_jit_free(aux->prog);
 	}
+	if (aux->orig_idx)
+		kfree(aux->orig_idx);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1f18681721c..e264dbe285b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2589,6 +2589,18 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static void *bpf_prog_alloc_orig_idx(u32 insn_cnt)
+{
+	u32 *orig_idx;
+	int i;
+
+	orig_idx = kzalloc(sizeof(*orig_idx) * insn_cnt, GFP_KERNEL);
+	if (orig_idx)
+		for (i = 0; i < insn_cnt; i++)
+			orig_idx[i] = i;
+	return orig_idx;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD log_true_size
 
@@ -2690,6 +2702,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		return -ENOMEM;
 	}
 
+	prog->aux->orig_idx = bpf_prog_alloc_orig_idx(attr->insn_cnt);
+	if (!prog->aux->orig_idx) {
+		err = -ENOMEM;
+		goto free_prog;
+	}
+
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
@@ -4460,6 +4478,18 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			return -EFAULT;
 	}
 
+	ulen = info.orig_idx_len;
+	if (prog->aux->orig_idx)
+		info.orig_idx_len = prog->len * sizeof(*prog->aux->orig_idx);
+	else
+		info.orig_idx_len = 0;
+	if (info.orig_idx_len && ulen) {
+		if (copy_to_user(u64_to_user_ptr(info.orig_idx),
+				 prog->aux->orig_idx,
+				 min_t(u32, info.orig_idx_len, ulen)))
+			return -EFAULT;
+	}
+
 	if (bpf_prog_is_offloaded(prog->aux)) {
 		err = bpf_prog_offload_info_fill(&info, prog);
 		if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9507800026cf..64c7036b8b56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18266,7 +18266,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		if (PTR_ERR(new_prog) == -ERANGE)
 			verbose(env,
 				"insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[off].orig_idx);
+				env->prog->aux->orig_idx[off]);
 		vfree(new_data);
 		return NULL;
 	}
@@ -20777,7 +20777,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
-	int i, len, ret = -EINVAL, err;
+	int len, ret = -EINVAL, err;
 	u32 log_true_size;
 	bool is_priv;
 
@@ -20800,8 +20800,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto err_free_env;
-	for (i = 0; i < len; i++)
-		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a00f8a5623e1..b15e167941fd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6470,6 +6470,8 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 orig_idx_len;
+	__aligned_u64 orig_idx;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.34.1


