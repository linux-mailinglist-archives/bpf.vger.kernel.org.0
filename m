Return-Path: <bpf+bounces-20894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06785845024
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF971C230C0
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC793BB4D;
	Thu,  1 Feb 2024 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPEr8dT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75983BB2C
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761284; cv=none; b=gz8zYoCp79MLKU71bHvntEx9BWnzEJ9CbSpnt8Ki9t2I6HAe3qgmh5UJ0sdTIkUB4TVldVPI5v60446aAxxvjYvL0NLcP2Wf17YeqfWhcEndE2q9yY8dzkIOSdsJT8KQS7PzDK2Q3ujJlKUZCFk9SHDu9LIfbN/B/sjENCamxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761284; c=relaxed/simple;
	bh=1lL77sT2um2zxl/ESTKSHiacgeljWABZA/qmoqPk6JY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjBHDdvlhJL4kyMwJUoeP3L6mBHVBOKAusmuCgPxheWeaUKv2RtW2YKEO+q2syx8BX5yTnOPyUQmN69gfL9U59QG+f0Usyc2U5ZbCgG59+4QG4KM8veoOkq/hanV8zpmPdjipZMSQEIO097/6UIg49Iei43hi8qf2V7M+hHNo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPEr8dT0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51117bfd452so801781e87.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761279; x=1707366079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkfJ/YtdzjljBnGu5bZEpyNJmG60w4t6Elqcq8KaSMs=;
        b=RPEr8dT0W9ihAaKDTTZ0o5H/nOsh8SE9JRb14MvOkaGqSy2QqsSnv/vTikrk+04S5L
         wNcYJ6wFSpi1gfd1t6wkxnznkKaQFoFnnNVnEbBWpDvI+dPdSuqTixfS6YiLEt44v+lA
         l7AeHtHjV9MJpnhM/n9nIZtSsNrmw32Y5WYpO41YtmHTolM3OvCw7VfdV/8z+DfXIqU6
         f53guH86iztqedMLe0bMxLIf8tmTqURD92BUpKuQ9EPOwOYN36pds2I1QNW04P+UZD5b
         1FHJW9OQ9pkOE6piXe2aXdvgRSSV1geIGizN7PjVy+OWHebdqQovzRXtLxQ8BaboBu+M
         luJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761279; x=1707366079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkfJ/YtdzjljBnGu5bZEpyNJmG60w4t6Elqcq8KaSMs=;
        b=X/3ijxYfjHf1Vv6ZhGouYSahO2zThDmHqvSPItEFk473ACnZrr1c/PYUHwu3rneY6a
         nSA2NFZLR0T8T71fMHvPLZXnaMjAVQchEYO9o0vlXb9Gr1kQXSs27Dx4hg6gZoBD6V4O
         EjusrJyl67MNMShPuLlMgIxTrgVBGYhI1KT1fcVizqGcQ9H7ZBF41d+0Xlc7gu6h8NlP
         905W+b1/9uip037/iA+0VX4+g3+CGakZ5o+wf+aYGMkiaS/OLLh0/afRchqw1y4OJR1M
         jikoB3lBDXXHS9RlqHDbifMvdmmn9X/igGIygyJPscKm6/paD6TJrf4KDWAeKkzrnWb5
         1qYQ==
X-Gm-Message-State: AOJu0YxKsj1ABAVUitQ/+8Hs0BYkRec8XoAAbjyEROcMVJSA/rLg5qpr
	EWzN/KoKCO/8noT/jHhM7rC1/tE/Iy1mx79CMCzW953yBHW1JVJLY0OdySJc
X-Google-Smtp-Source: AGHT+IGhWLjh7r68O/gLUqzbfqUsvlsm1S8N5A9SroHk3cDjQVUmZxlD5jNJ0mPIvhjaw0ID7YDs2Q==
X-Received: by 2002:ac2:4147:0:b0:50f:ffc5:5cda with SMTP id c7-20020ac24147000000b0050fffc55cdamr915071lfi.57.1706761278850;
        Wed, 31 Jan 2024 20:21:18 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a369b479982sm668576ejc.218.2024.01.31.20.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame descriptor generation
Date: Thu,  1 Feb 2024 04:21:00 +0000
Message-Id: <20240201042109.1150490-6-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22535; i=memxor@gmail.com; h=from:subject; bh=1lL77sT2um2zxl/ESTKSHiacgeljWABZA/qmoqPk6JY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwNmVCEAFMr5ejxHCYWyMM+nNZPRp9gRidGs RNZ+xb0b+2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDQAKCRBM4MiGSL8R ysa5EAC7NhLKBYiYXalOe+qkOnrr6g3uUnK1zfnQAviKyghWMMjhBfK7LOjoIx0tEkJ0eRMrDFr HLB8t7vlbR6u/ei/OaMkALeX14mBVCUv+7LIWdMU/8kZOvOgK+Swzel5ClYYcbo9lkcxUx1jo7f XBSDnZy7Gz8uhEiWP7upTNwxynOU0lMexPczeY/CHycM+vRAdsPgiPDZSm1HA+Ll+YLCv1FoMu5 +MDuD4mEJGFbIS7QqdP7MHltBZ7gx4GgOXhVchiF5nIzRpx4Ia8D+H52VR3EDTVRp6yder/e0TI t36n4Yk1lJb0L2JPcRqyUlk+vB+Mm4kmtvhSZBlcllyOTBeb0rImDaEWZW+i5cQeQraVm3QGETd k2nZeNWvjH+He8CXWpiOdE9hURrkH7pIPGc/M59Gjy8GOUzaQuHL0n9n9HeJcXuH0xdhSqsPs7L 2b1glmNlmyehLgfExW888/s+A8hOHXsorVO1AK8SNb7ADf8Y7m33iU7nTnvlmgiXLSaC4qDe29A 7o+dD0aFPTIQXavwUQtBWZ7rydYdPv7Y7k2ofM28CuJPXdZ5vtn7DYix3CgAb03H52SmeZrgXZp /XP/WqAX1VILS09I0ZMJRmhj8xHeYOOXM2UE7WTH0ThYsnz+L6x4bB9jKtC5mvowI/Zs2q7/WUP deQbMYTHpBR068A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce support to the verifier to generate a set of descriptors for
each BPF frame to describe the register and stack state, which can be
used to reason about the resources acquired by the program at that
particular program point, and subsequent patches can introduce support
to unwind a given program when it throws an exception while holding
ownership of such resources.

Descriptors generated for each frame are then tied back to the subprog
they belong to, and attached to the bpf_prog instance during the JIT
phase, with the program counter serving as a key to find the descriptor
of interest for a given subprog.

Logically, during the unwinding phase, for each frame, we will use the
program counter and bpf_prog object to figure out how we should release
acquired resources if any in the frame.

Let's study how the frame descriptor generation algorithm works.
Whenever an exception throwing instruction is encountered, thus global
subprog calls which are throw reachable, and bpf_throw kfunc, we call
gen_exception_frame_descs.

This function will start with the current frame, and explore the
registers and other objects on the current stack. We consider 8-byte
granularity as all registers spilled on the stack and objects like
dynptr and iter are 8-byte aligned. For each such stack entry, we
inspect the slot_type and figure out whether it is a spilled register or
a dynptr/iter object.

For any acquired resources on the stack, and insert entries representing
them into a frame descriptor table for the current subprog at the
current instruction index.

The same steps are repeated for registers that are callee saved, as
these would be possibly spilled on stack of one of the frames in the
call chain and would have to be located in order to be freed.

In case of registers (spilled or callee saved), we make a special
provision for register_is_null scalar values, to increase the chances of
merging frame descriptors where the only divergence is NULL in one state
being replaced with a valid pointer in another.

The next important step is the logic to merge the frame descriptors. It
is possible that the verifier reaches the same instruction index in a
program from multiple paths, and has to generate frame descriptors for
them at that program counter. In such a case, we always ensure that
after generating the frame descriptor, we attempt to "merge" it with an
existing one.

The merging rules are fairly simple except for a few caveats. First, if
the layout and type of objects on the stack and in registers is the
same, we have a successful merge. Next, in case of registers (spilled or
callee saved), we have a special where if the old entry has NULL, the
new type (non-NULL) replaces it, and if the new entry has NULL, it
satisfies the merge rules with the old entry (can be of any type).

This helps in cases where we have an optional value held in a register
or stack slot in one program path, which is replaced by the actual value
in the other program path. This can also be the case in case of
conditionals, where the verifier may see acquired references in verifier
state depending on if a condition is true (therefore, not in all of the
program paths traversing the same instruction).

To illustrate with an example, in the following program:

struct foo *p = NULL;
if (x)
	p = bpf_obj_new(typeof(*p));
if (y)
	bpf_throw(0);
if (p)
	bpf_obj_drop(p);

In such a case, bpf_throw may be reached for x == 0, y == 1 and x == 1,
y == 1, with two possible values of p. As long as both can be passed
into the release function (i.e. NULL or a valid pointer value), we can
satisfy the merge.

TODO: We need to reserve a slot for STACK_ZERO as well.
TODO: Improve the error message in case we have pointer and misc instead of zero.

Currently, we only consider resources which are modelled as acquired
references in verifier state. In particular, this excludes resources
like held spinlocks and RCU read sections. For now, both of these will
not be handled, and the verifier will continue to complain when
exceptions are thrown in their presence.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  27 ++
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/core.c                             |  13 +
 kernel/bpf/verifier.c                         | 368 ++++++++++++++++++
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 5 files changed, 412 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..463c8d22ad72 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1424,6 +1424,7 @@ struct btf_mod_pair {
 };
 
 struct bpf_kfunc_desc_tab;
+struct bpf_exception_frame_desc_tab;
 
 struct bpf_prog_aux {
 	atomic64_t refcnt;
@@ -1518,6 +1519,7 @@ struct bpf_prog_aux {
 	struct module *mod;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
+	struct bpf_exception_frame_desc_tab *fdtab;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -3367,4 +3369,29 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+struct bpf_frame_desc_reg_entry {
+	u32 type;
+	s16 spill_type;
+	union {
+		s16 off;
+		u16 regno;
+	};
+	struct btf *btf;
+	u32 btf_id;
+};
+
+struct bpf_exception_frame_desc {
+	u64 pc;
+	u32 stack_cnt;
+	struct bpf_frame_desc_reg_entry regs[4];
+	struct bpf_frame_desc_reg_entry stack[];
+};
+
+struct bpf_exception_frame_desc_tab {
+	u32 cnt;
+	struct bpf_exception_frame_desc **desc;
+};
+
+void bpf_exception_frame_desc_tab_free(struct bpf_exception_frame_desc_tab *fdtab);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5482701e6ad9..0113a3a940e2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -631,6 +631,8 @@ struct bpf_subprog_info {
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
+
+	struct bpf_exception_frame_desc_tab *fdtab;
 };
 
 struct bpf_verifier_env;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..995a4dcfa970 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2734,6 +2734,14 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
+void bpf_exception_frame_desc_tab_free(struct bpf_exception_frame_desc_tab *fdtab)
+{
+	if (!fdtab)
+		return;
+	for (int i = 0; i < fdtab->cnt; i++)
+		kfree(fdtab->desc[i]);
+}
+
 static void bpf_prog_free_deferred(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
@@ -2747,6 +2755,11 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
 		bpf_cgroup_atype_put(aux->cgroup_atype);
 #endif
+	/* Free all exception frame descriptors */
+	for (int i = 0; i < aux->func_cnt; i++) {
+		bpf_exception_frame_desc_tab_free(aux->func[i]->aux->fdtab);
+		aux->func[i]->aux->fdtab = NULL;
+	}
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
 	if (bpf_prog_is_dev_bound(aux))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03ad9a9d47c9..27233c308d83 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10004,6 +10004,366 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return 0;
 }
 
+static void print_frame_desc_reg_entry(struct bpf_verifier_env *env, struct bpf_frame_desc_reg_entry *fd, const char *pfx)
+{
+	const char *type = fd->off < 0 ? "stack" : "reg";
+	const char *key = fd->off < 0 ? "off" : "regno";
+	const char *spill_type;
+
+	switch (fd->spill_type) {
+	case STACK_INVALID:
+		spill_type = "<unknown>";
+		break;
+	case STACK_SPILL:
+		spill_type = "reg";
+		break;
+	case STACK_DYNPTR:
+		spill_type = "dynptr";
+		break;
+	case STACK_ITER:
+		spill_type = "iter";
+		break;
+	default:
+		spill_type = "???";
+		break;
+	}
+	verbose(env, "frame_desc: %s%s fde: %s=%d spill_type=%s ", pfx, type, key, fd->off, spill_type);
+	if (fd->btf) {
+		const struct btf_type *t = btf_type_by_id(fd->btf, fd->btf_id);
+
+		verbose(env, "type=%s%s btf=%s btf_id=%d\n", fd->off < 0 ? "" : "ptr_",
+			btf_name_by_offset(fd->btf, t->name_off), btf_get_name(fd->btf), fd->btf_id);
+	} else {
+		verbose(env, "type=%s\n", fd->spill_type == STACK_DYNPTR ? "ringbuf" : reg_type_str(env, fd->type));
+	}
+}
+
+static int merge_frame_desc(struct bpf_verifier_env *env, struct bpf_frame_desc_reg_entry *ofd, struct bpf_frame_desc_reg_entry *fd)
+{
+	int ofd_type, fd_type;
+
+	/* If ofd->off/regno is 0, this is uninitialized reg entry, just merge new entry. */
+	if (!ofd->off)
+		goto merge_new;
+	/* Exact merge for dynptr, iter, reg, stack. */
+	if (!memcmp(ofd, fd, sizeof(*ofd)))
+		goto none;
+	/* First, for a successful merge, both spill_type should be same.*/
+	if (ofd->spill_type != fd->spill_type)
+		goto fail;
+	/* Then, both should correspond to a reg or stack entry for non-exact merge. */
+	if (ofd->spill_type != STACK_SPILL && ofd->spill_type != STACK_INVALID)
+		goto fail;
+	ofd_type = ofd->type;
+	fd_type = fd->type;
+	/* One of the old or new entry must be NULL, if both are not same. */
+	if (ofd_type == fd_type)
+		goto none;
+	if (ofd_type != SCALAR_VALUE && fd_type != SCALAR_VALUE)
+		goto fail;
+	if (fd_type == SCALAR_VALUE)
+		goto none;
+	verbose(env, "frame_desc: merge: merging new frame desc entry into old\n");
+	print_frame_desc_reg_entry(env, ofd, "old ");
+merge_new:
+	if (!ofd->off)
+		verbose(env, "frame_desc: merge: creating new frame desc entry\n");
+	print_frame_desc_reg_entry(env, fd, "new ");
+	*ofd = *fd;
+	return 0;
+none:
+	verbose(env, "frame_desc: merge: no merging needed of new frame desc entry into old\n");
+	print_frame_desc_reg_entry(env, ofd, "old ");
+	print_frame_desc_reg_entry(env, fd, "new ");
+	return 0;
+fail:
+	verbose(env, "frame_desc: merge: failed to merge old and new frame desc entry\n");
+	print_frame_desc_reg_entry(env, ofd, "old ");
+	print_frame_desc_reg_entry(env, fd, "new ");
+	return -EINVAL;
+}
+
+static int find_and_merge_frame_desc(struct bpf_verifier_env *env, struct bpf_exception_frame_desc_tab *fdtab, u64 pc, struct bpf_frame_desc_reg_entry *fd)
+{
+	struct bpf_exception_frame_desc **descs = NULL, *desc = NULL, *p;
+	int ret = 0;
+
+	for (int i = 0; i < fdtab->cnt; i++) {
+		if (pc != fdtab->desc[i]->pc)
+			continue;
+		descs = &fdtab->desc[i];
+		desc = fdtab->desc[i];
+		break;
+	}
+
+	if (!desc) {
+		verbose(env, "frame_desc: find_and_merge: cannot find frame descriptor for pc=%llu, creating new entry\n", pc);
+		return -ENOENT;
+	}
+
+	if (fd->off < 0)
+		goto stack;
+	/* We didn't find a match for regno or offset, fill it into the frame descriptor. */
+	return merge_frame_desc(env, &desc->regs[fd->regno - BPF_REG_6], fd);
+
+stack:
+	for (int i = 0; i < desc->stack_cnt; i++) {
+		struct bpf_frame_desc_reg_entry *ofd = desc->stack + i;
+
+		if (ofd->off != fd->off)
+			continue;
+		ret = merge_frame_desc(env, ofd, fd);
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
+	p = krealloc(desc, offsetof(typeof(*desc), stack[desc->stack_cnt + 1]), GFP_USER | __GFP_ZERO);
+	if (!p) {
+		return -ENOMEM;
+	}
+	verbose(env, "frame_desc: merge: creating new frame desc entry\n");
+	print_frame_desc_reg_entry(env, fd, "new ");
+	desc = p;
+	desc->stack[desc->stack_cnt] = *fd;
+	desc->stack_cnt++;
+	*descs = desc;
+	return 0;
+}
+
+/* Implementation details:
+ * This function is responsible for pushing a prepared bpf_frame_desc_reg_entry
+ * into the frame descriptor array tied to each subprog. The first step is
+ * ensuring the array is allocated and has enough capacity. Second, we must find
+ * if there is an existing descriptor already for the program counter under
+ * consideration, and try to report an error if we see conflicting frame
+ * descriptor generation requests for the same instruction in the program.
+ * Note that by default, we let NULL registers and stack slots occupy an entry.
+ * This is done so that any future non-NULL registers or stack slots at the same
+ * regno or offset can be satisfied by changing the type of entry to a "stronger"
+ * pointer type. The release handler can deal with NULL or valid values,
+ * therefore such a logic allows handling cases where the program may only have
+ * a pointer in some of the program paths and NULL in others while reaching the
+ * same instruction that causes an exception to be thrown.
+ * Likewise, a NULL entry merges into the stronger pointer type entry when a
+ * frame descriptor already exists before pushing a new one.
+ */
+static int push_exception_frame_desc(struct bpf_verifier_env *env, int frameno, struct bpf_frame_desc_reg_entry *fd)
+{
+	struct bpf_func_state *frame = env->cur_state->frame[frameno], *curframe = cur_func(env);
+	struct bpf_subprog_info *si = subprog_info(env, frame->subprogno);
+	struct bpf_exception_frame_desc_tab *fdtab = si->fdtab;
+	struct bpf_exception_frame_desc **desc;
+	u64 pc = env->insn_idx;
+	int ret;
+
+	/* If this is not the current frame, then we need to figure out the callsite
+	 * for its callee to identify the pc.
+	 */
+	if (frameno != curframe->frameno)
+		pc = env->cur_state->frame[frameno + 1]->callsite;
+
+	if (!fdtab) {
+		fdtab = kzalloc(sizeof(*si->fdtab), GFP_USER);
+		if (!fdtab)
+			return -ENOMEM;
+		fdtab->desc = kzalloc(sizeof(*fdtab->desc), GFP_USER);
+		if (!fdtab->desc) {
+			kfree(fdtab);
+			return -ENOMEM;
+		}
+		si->fdtab = fdtab;
+	}
+
+	ret = find_and_merge_frame_desc(env, fdtab, pc, fd);
+	if (!ret)
+		return 0;
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+	/* We didn't find a frame descriptor for pc, grow the array and insert it. */
+	desc = realloc_array(fdtab->desc, fdtab->cnt ?: 1, fdtab->cnt + 1, sizeof(*fdtab->desc));
+	if (!desc) {
+		return -ENOMEM;
+	}
+	fdtab->desc = desc;
+	fdtab->desc[fdtab->cnt] = kzalloc(sizeof(*fdtab->desc[0]), GFP_USER);
+	if (!fdtab->desc[fdtab->cnt])
+		return -ENOMEM;
+	fdtab->desc[fdtab->cnt]->pc = pc;
+	fdtab->cnt++;
+	return find_and_merge_frame_desc(env, fdtab, pc, fd);
+}
+
+static int gen_exception_frame_desc_reg_entry(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off, int frameno)
+{
+	struct bpf_frame_desc_reg_entry fd = {};
+
+	if ((!reg->ref_obj_id && reg->type != NOT_INIT) || reg->type == SCALAR_VALUE)
+		return 0;
+	if (base_type(reg->type) == PTR_TO_BTF_ID)
+		fd.btf = reg->btf;
+	fd.type = reg->type & ~PTR_MAYBE_NULL;
+	fd.btf_id = fd.btf ? reg->btf_id : 0;
+	fd.spill_type = off < 0 ? STACK_SPILL : STACK_INVALID;
+	fd.off = off;
+	verbose(env, "frame_desc: frame%d: insn_idx=%d %s=%d size=%d ref_obj_id=%d type=%s\n",
+		frameno, env->insn_idx, off < 0 ? "off" : "regno", off, BPF_REG_SIZE, reg->ref_obj_id, reg_type_str(env, reg->type));
+	return push_exception_frame_desc(env, frameno, &fd);
+}
+
+static int gen_exception_frame_desc_dynptr_entry(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off, int frameno)
+{
+	struct bpf_frame_desc_reg_entry fd = {};
+	int type = reg->dynptr.type;
+
+	/* We only need to generate an entry when the dynptr is refcounted,
+	 * otherwise it encapsulates no resource that needs to be released.
+	 */
+	if (!dynptr_type_refcounted(type))
+		return 0;
+	switch (type) {
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		fd.type = BPF_DYNPTR_TYPE_RINGBUF;
+		fd.spill_type = STACK_DYNPTR;
+		fd.off = off;
+		verbose(env, "frame_desc: frame%d: insn_idx=%d off=%d size=%lu dynptr_ringbuf\n", frameno, env->insn_idx, off,
+			BPF_DYNPTR_NR_SLOTS * BPF_REG_SIZE);
+		break;
+	default:
+		verbose(env, "verifier internal error: refcounted dynptr type unhandled for exception frame descriptor entry\n");
+		return -EFAULT;
+	}
+	return push_exception_frame_desc(env, frameno, &fd);
+}
+
+static int add_used_btf(struct bpf_verifier_env *env, struct btf *btf);
+
+static int gen_exception_frame_desc_iter_entry(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off, int frameno)
+{
+	struct bpf_frame_desc_reg_entry fd = {};
+	struct btf *btf = reg->iter.btf;
+	u32 btf_id = reg->iter.btf_id;
+	const struct btf_type *t;
+	int ret;
+
+	fd.btf = btf;
+	fd.type = reg->type;
+	fd.btf_id = btf_id;
+	fd.spill_type = STACK_ITER;
+	fd.off = off;
+	t = btf_type_by_id(btf, btf_id);
+	verbose(env, "frame_desc: frame%d: insn_idx=%d off=%d size=%u ref_obj_id=%d iter_%s\n",
+		frameno, env->insn_idx, off, t->size, reg->ref_obj_id, btf_name_by_offset(btf, t->name_off));
+	btf_get(btf);
+	ret = add_used_btf(env, btf);
+	if (ret < 0) {
+		btf_put(btf);
+		return ret;
+	}
+	return push_exception_frame_desc(env, frameno, &fd);
+}
+
+static int gen_exception_frame_desc_stack_entry(struct bpf_verifier_env *env, struct bpf_func_state *frame, int stack_off)
+{
+	int spi = stack_off / BPF_REG_SIZE, off = -stack_off - 1;
+	struct bpf_reg_state *reg, not_init_reg, null_reg;
+	int slot_type, ret;
+
+	__mark_reg_not_init(env, &not_init_reg);
+	__mark_reg_known_zero(&null_reg);
+
+	slot_type = frame->stack[spi].slot_type[BPF_REG_SIZE - 1];
+	reg = &frame->stack[spi].spilled_ptr;
+
+	switch (slot_type) {
+	case STACK_SPILL:
+		/* We skip all kinds of scalar registers, except NULL values, which consume a slot. */
+		if (is_spilled_scalar_reg(&frame->stack[spi]) && !register_is_null(&frame->stack[spi].spilled_ptr))
+			break;
+		ret = gen_exception_frame_desc_reg_entry(env, reg, off, frame->frameno);
+		if (ret < 0)
+			return ret;
+		break;
+	case STACK_DYNPTR:
+		/* Keep iterating until we find the first slot. */
+		if (!reg->dynptr.first_slot)
+			break;
+		ret = gen_exception_frame_desc_dynptr_entry(env, reg, off, frame->frameno);
+		if (ret < 0)
+			return ret;
+		break;
+	case STACK_ITER:
+		/* Keep iterating until we find the first slot. */
+		if (!reg->ref_obj_id)
+			break;
+		ret = gen_exception_frame_desc_iter_entry(env, reg, off, frame->frameno);
+		if (ret < 0)
+			return ret;
+		break;
+	case STACK_MISC:
+	case STACK_INVALID:
+		/* Create an invalid entry for MISC and INVALID */
+		ret = gen_exception_frame_desc_reg_entry(env, &not_init_reg, off, frame->frameno);
+		if (ret < 0)
+			return 0;
+		break;
+	case STACK_ZERO:
+		reg = &null_reg;
+		for (int i = BPF_REG_SIZE - 1; i >= 0; i--) {
+			if (frame->stack[spi].slot_type[i] != STACK_ZERO)
+				reg = &not_init_reg;
+		}
+		ret = gen_exception_frame_desc_reg_entry(env, &null_reg, off, frame->frameno);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		verbose(env, "verifier internal error: frame%d stack off=%d slot_type=%d missing handling for exception frame generation\n",
+			frame->frameno, off, slot_type);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+/* We generate exception descriptors for all frames at the current program
+ * counter.  For caller frames, we use their callsite as their program counter,
+ * and we go on generating it until the main frame.
+ *
+ * It's necessary to detect whether the stack layout is different, in that case
+ * frame descriptor generation should fail and we cannot really support runtime
+ * unwinding in that case.
+ */
+static int gen_exception_frame_descs(struct bpf_verifier_env *env)
+{
+	struct bpf_reg_state not_init_reg;
+	int ret;
+
+	__mark_reg_not_init(env, &not_init_reg);
+
+	for (int frameno = env->cur_state->curframe; frameno >= 0; frameno--) {
+		struct bpf_func_state *frame = env->cur_state->frame[frameno];
+
+		verbose(env, "frame_desc: frame%d: Stack:\n", frameno);
+		for (int i = BPF_REG_SIZE - 1; i < frame->allocated_stack; i += BPF_REG_SIZE) {
+			ret = gen_exception_frame_desc_stack_entry(env, frame, i);
+			if (ret < 0)
+				return ret;
+		}
+
+		verbose(env, "frame_desc: frame%d: Registers:\n", frameno);
+		for (int i = BPF_REG_6; i < BPF_REG_FP; i++) {
+			struct bpf_reg_state *reg = &frame->regs[i];
+
+			/* Treat havoc scalars as incompatible type. */
+			if (reg->type == SCALAR_VALUE && !register_is_null(reg))
+				reg = &not_init_reg;
+			ret = gen_exception_frame_desc_reg_entry(env, reg, i, frame->frameno);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_func_state *state = cur_func(env);
@@ -17694,12 +18054,18 @@ static int do_check(struct bpf_verifier_env *env)
 					err = check_func_call(env, insn, &env->insn_idx);
 					if (!err && env->cur_state->global_subprog_call_exception) {
 						env->cur_state->global_subprog_call_exception = false;
+						err = gen_exception_frame_descs(env);
+						if (err < 0)
+							return err;
 						exception_exit = true;
 						goto process_bpf_exit_full;
 					}
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
 					if (!err && is_bpf_throw_kfunc(insn)) {
+						err = gen_exception_frame_descs(env);
+						if (err < 0)
+							return err;
 						exception_exit = true;
 						goto process_bpf_exit_full;
 					}
@@ -21184,6 +21550,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
+	for (int i = 0; i < env->subprog_cnt; i++)
+		bpf_exception_frame_desc_tab_free(env->subprog_info[i].fdtab);
 	kfree(env);
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 28602f905d7d..5a517065b4e6 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -213,7 +213,7 @@ __noinline static int subprog_cb_ref(u32 i, void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference")
+__failure __msg("cannot be called from callback subprog 1")
 int reject_with_cb_reference(void *ctx)
 {
 	struct foo *f;
@@ -235,7 +235,7 @@ int reject_with_cb(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference")
+__success
 int reject_with_subprog_reference(void *ctx)
 {
 	return subprog_ref(ctx) + 1;
-- 
2.40.1


