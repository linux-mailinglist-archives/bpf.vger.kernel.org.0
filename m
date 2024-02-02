Return-Path: <bpf+bounces-21064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE768474DA
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6791C224CE
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453181487E2;
	Fri,  2 Feb 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="QcnXrJc2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221A1487C3
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891660; cv=none; b=OCl0AmGC6qZwzh0OptS/ZA4XOsnfDSu2a1ob0HA00qTqw6GQVMtQohLILv3IJf23f/qIPW53o5WVsgZXO2z7cFeW0n3eXrCz+WT05FGrXZYFvvei8CkhICRlepYKzA8TZnmqi7DtyWdNxeHIxYwJG9W3iMfVYd5jtxUT6NOSFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891660; c=relaxed/simple;
	bh=tmNyr/8TlE8ThVK8BbQOa/pYP0yZvj6lq52/DC4I8Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UR4yF2mLroZma7aGrqFRpmSkQkoYyUR1bdI7utYk/NFcDvA8Pm2WaMXs2Hd2Ur/MUiIR7LsvA3m6eaL9FSdFkjboJwEbL/pKYu03aTFIQbXTzcpcevFUBGXFKospYrxDRejYkD6AkroIhfptSyRnv10DSGGc5Awqr2Z5mciHkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=QcnXrJc2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56010d9aab4so21438a12.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891657; x=1707496457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Av9rZofWvSWATbkpfszZbyRD5PHKzS0dqn78BDygg=;
        b=QcnXrJc2TvF1qMS+JYefKp2MKL3szCo379yS+QQL9ORBRLHr6JTJ/LebkIiTUnAbUC
         XrkYR1QmKjcOCxlyinY6y4pCX+wf8fV96rYt+ronUXZFEr8ZGxygP4zOfJPUDS4cwB5o
         pnWv9RaKE1lKZ6i7+EK+xQa+WcGJ3JivDVmn2suDInndXAN1F8Uxq5mF4QzMHVmA/qy3
         Kyz650moOxNCQGmLp9LSFlriBgpyQmgijDPL8bLaWbyCmy/PS4vMTs+MmMSUYbQwEr3u
         YFWbHkfFDsvl/OO10yjUG6uCPxfdrlIixcfdIvdTVAzFqmXXMzghR+unrC6GGsE0g2DA
         W1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891657; x=1707496457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6Av9rZofWvSWATbkpfszZbyRD5PHKzS0dqn78BDygg=;
        b=qnHHQ6bSeE4E+s9XZGwHCPVvuC4SkcZdZS/CiJ8oYK/EVyk11ueP9CFwJzoCU3mAmd
         JKlKnz6mjWSRJvRt2NNyjY2f7ifDNftIp9Gw8bdRcH1G7pm1WB47/YanR0Z4ycABUxdc
         WTmSU0Ljs360A5fHeOkXfIAuPJRLLsOa+L4z/lI9XlSbQlNera3IH3IpFoyoYC/N/9YG
         UmBgR8VJUlzSi4/cPkc/qiGKDr9DJsfOHqMrDVOEmH1QVdPXBTiWtir41aLGY3i0Km6n
         hLAybffePbKvrBZR6SkH3Y7S1Iz+aGVaStEC6B2Vh4uF4apYyoRn8wDX7qmkL103MWuJ
         uFQg==
X-Gm-Message-State: AOJu0Yy0SekY3OIO3v4Zuj5WP6pjjUT+qTYbI4dveWW5f7lXDDVHjBu9
	0+C+QQXjXnhLtxGXBBJdLHPMVU04jIOLGYZu0tx0HSZR2swfOxxJn515OZkeZ7w=
X-Google-Smtp-Source: AGHT+IFGla2H3cB8qnKRvziL8FkSXI/HTkNNQHMvA+aiOLT4g1AP3JtRZgaHdeXzuH703YTmrtvkrw==
X-Received: by 2002:a05:6402:1647:b0:55f:8103:1943 with SMTP id s7-20020a056402164700b0055f81031943mr125783edx.38.1706891656939;
        Fri, 02 Feb 2024 08:34:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXN+6452jaPC8iqqUt+L7GIjEsEHbsyRgMgd8pXT4StLt2Gg5objvvc0k69L5j8FkQLLe86gD0mnZhwSjq0Q6+WtjYlFXItWV7NHcaortBbD6nF91nGMwdFFEPByF1advd8BMIrFQG0CowlUUww4aPKZB8VZNiwz7I9h6UKo2TKSPjwhVxPyJG7v4lGyjz7TuUR4riK4P/09Sk5g52IJUyhfRw1moXXBi3S49+sDEUqSAHYwYPDxBxdcn0efqoab2Uo9L8zZ7Sy1q2oYs8CLX8Zq+AnhoxiTIidtSHtGRtRhzU+3X2R1tg=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:15 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 2/9] bpf: keep track of and expose xlated insn offsets
Date: Fri,  2 Feb 2024 16:28:06 +0000
Message-Id: <20240202162813.4184616-3-aspsk@isovalent.com>
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

Since commit 9e4c24e7ee7d ("bpf: verifier: record original instruction index")
the verifier saves the original instruction index in env->insn_aux_data.
This information was, however, lost when we patched instructions. Also, the
information about original index was kept in the verifier env only, so was
inaccessible by later stages, like constants blinding during the jit stage.

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
                                        12: r0 = 0
     7:  r6 = r0                        13: r6 = r0
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
 kernel/bpf/core.c              | 29 +++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  6 ++----
 tools/include/uapi/linux/bpf.h |  2 ++
 7 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..4def3dde35f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1522,6 +1522,8 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	/* an array of original indexes for all xlated instructions */
+	u32 *orig_idx;
 };
 
 struct bpf_prog {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0dcde339dc7e..8348de569f11 100644
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
index d96708380e52..b929523444b0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6533,6 +6533,8 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 orig_idx_len;
+	__aligned_u64 orig_idx;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ad8e6f7e0886..f0086925b810 100644
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
@@ -2778,6 +2806,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	} else {
 		bpf_jit_free(aux->prog);
 	}
+	kfree(aux->orig_idx);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2750b79ac80..172bf8d3aef2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2625,6 +2625,18 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static void *bpf_prog_alloc_orig_idx(u32 insn_cnt)
+{
+	u32 *orig_idx;
+	int i;
+
+	orig_idx = kcalloc(insn_cnt, sizeof(*orig_idx), GFP_KERNEL);
+	if (orig_idx)
+		for (i = 0; i < insn_cnt; i++)
+			orig_idx[i] = i;
+	return orig_idx;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
 
@@ -2760,6 +2772,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto put_token;
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
@@ -4541,6 +4559,18 @@ static int bpf_prog_get_info_by_fd(struct file *file,
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
index cd4d780e5400..2dc48f88f43c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18289,7 +18289,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		if (PTR_ERR(new_prog) == -ERANGE)
 			verbose(env,
 				"insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[off].orig_idx);
+				env->prog->aux->orig_idx[off]);
 		vfree(new_data);
 		return NULL;
 	}
@@ -20829,7 +20829,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
-	int i, len, ret = -EINVAL, err;
+	int len, ret = -EINVAL, err;
 	u32 log_true_size;
 	bool is_priv;
 
@@ -20852,8 +20852,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto err_free_env;
-	for (i = 0; i < len; i++)
-		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d96708380e52..b929523444b0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6533,6 +6533,8 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 orig_idx_len;
+	__aligned_u64 orig_idx;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.34.1


