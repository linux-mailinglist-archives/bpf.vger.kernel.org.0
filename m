Return-Path: <bpf+bounces-69058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1647B8BBFF
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA2189F7A7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362E217705;
	Sat, 20 Sep 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9xMLjGR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEA2D46B7;
	Sat, 20 Sep 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329999; cv=none; b=rB3NptmjCF9geTqkhi9U4dxwlMDK/7CVZT0DtkPzh302BukaSyZMs/pLkwf2haD2MTuM3237UVQglJegwPPaeN8NCTK8xIwHyLwUrxwL8LkjJ7Xv4yNACXBVAaJTw2ar7mdmUAk3O1gqeLbANFJwXHP4i0weShWkFuO0fkZKQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329999; c=relaxed/simple;
	bh=zZehI3C9tn79dMRGTUXlxBHx3ifx3bTMDqVPOg+REgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCz1dCgF8w+/8HQFxql7zT1rGtDkpgkqrUeS6/0OpPaR3Wzg6bxp4AKjTs+gXUscffBwbyA+1/hXk18xZwm27f7td1HRO5H1gfbO7DhHmQor9Ys9BSFJIeJM2y9qLcq9OqdZyv06Q+XpXi49KjHRfe93lwGlNvhe9F0ptqMYTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9xMLjGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6733C4CEF5;
	Sat, 20 Sep 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329998;
	bh=zZehI3C9tn79dMRGTUXlxBHx3ifx3bTMDqVPOg+REgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9xMLjGRXtqjjdZYLQJl/+HrEqBa1hK79xbg5SkQJFJbzEpKoAoKw5ZpJ6S98AycS
	 X9HG4YJDOJnmVVeK52sUxaJ1iOc3D6zVPjbsmAWOn7W5MIJD5wqpJHdLpcE4+P3cok
	 ytFcb5ltvM1lkgEfHFHUsi0UoG+3fW7V4poiKd/PYO9z3t0P+LV6ktw7IcjoGH6z/f
	 F8WIW1/dHm+JWu3xP6F9xjWpSSkICcB3qrkMI7EkFE7EOh5ntt2P5Yz9uPY1cmGkAc
	 v1AnGSV0hrIm4EDmBReSEmzV+ic0Dowfa8SSO5H+IeKNVVqbPEwhPjTq8OAcKabfpE
	 iAdxSpOLrNIlA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/46] HACK_NOT_FOR_UPSTREAM: BPF: Implement prog grouping hack
Date: Fri, 19 Sep 2025 14:58:47 -1000
Message-ID: <20250920005931.2753828-25-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hopefully, we can have something better instead.

NOT_SIGNED_OFF
---
 include/linux/bpf.h        |  5 +++++
 include/linux/sched.h      |  2 ++
 kernel/bpf/syscall.c       | 23 +++++++++++++++++++++++
 kernel/sched/ext.c         | 36 ++++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c | 13 +++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc700925b802..5101ae3ba2b6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1581,6 +1581,11 @@ struct bpf_stream_stage {
 
 struct bpf_prog_aux {
 	atomic64_t refcnt;
+
+	/* XXX - See kernel/sched/ext.c::scx_sub_enable() */
+	u64 priv_user;
+	void *priv;
+
 	u32 used_map_cnt;
 	u32 used_btf_cnt;
 	u32 max_ctx_offset;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d..576aed48beb2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1596,6 +1596,8 @@ struct task_struct {
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
+	/* XXX - See kernel/sched/ext.c::scx_sub_enable() */
+	u64				bpf_prog_aux_priv;
 #endif
 	/* Used by BPF for per-TASK xdp storage */
 	struct bpf_net_context		*bpf_net_context;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..e85dbe7fe5ce 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2761,6 +2761,27 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static int prog_aux_priv_param_set(const char *input, const struct kernel_param *kp)
+{
+	return kstrtoull(input, 0, &current->bpf_prog_aux_priv);
+}
+
+static int prog_aux_priv_param_get(char *buf, const struct kernel_param *kp)
+{
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", current->bpf_prog_aux_priv);
+}
+
+static const struct kernel_param_ops prog_aux_priv_param_ops = {
+	.set    = prog_aux_priv_param_set,
+	.get    = prog_aux_priv_param_get,
+};
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "bpf."
+module_param_cb(prog_aux_priv, &prog_aux_priv_param_ops, NULL, 0664);
+MODULE_PARM_DESC("prog_aux_priv",
+		 "Set prog->aux->priv to this value for all BPF programs loaded by %current");
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
@@ -2898,6 +2919,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
+	/* XXX - See kernel/sched/ext.c::scx_sub_enable() */
+	prog->aux->priv_user = current->bpf_prog_aux_priv;
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5eb1d6919595..a0251442b8ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4116,6 +4116,24 @@ static void scx_sub_disable(struct scx_sched *sch)
 
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, sch->exit_info);
+
+	/*
+	 * XXX - NULL prog->aux->priv is interpreted as scx_root, so use an
+	 * ERR_PTR value to mark the associated progs dead. Note that this is
+	 * racy as e.g. a tracepoint program associated with a scheduler which
+	 * hasn't finished scx_sub_enable() yet may end up affecting scx_root
+	 * inadvertently. Plug the hole when this hack is replaced with a proper
+	 * BPF construct.
+	 */
+	u32 prog_id = 0;
+	struct bpf_prog *prog;
+	while ((prog = bpf_prog_get_curr_or_next(&prog_id))) {
+		if (prog->aux->priv == sch)
+			RCU_INIT_POINTER(prog->aux->priv, ERR_PTR(-ENODEV));
+		bpf_prog_put(prog);
+		prog_id++;
+	}
+
 	kobject_del(&sch->kobj);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
@@ -5148,6 +5166,24 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto err_disable;
 	}
 
+	/*
+	 * XXX - We want all BPF programs loaded together with this scheduler
+	 * instance to point to this scheduler instance. BPF currently doesn't
+	 * have such feature so work around with a hack. The loading userspace
+	 * thread sets %current->bpf_prog_aux_priv to the associated cgroup ID
+	 * which gets transferred to bpf->aux->priv_user in bpf_prog_load().
+	 * Here, we can find all progs that have the matching cgroup ID and set
+	 * their prog->aux->priv to $sch.
+	 */
+	u32 prog_id = 0;
+	struct bpf_prog *prog;
+	while ((prog = bpf_prog_get_curr_or_next(&prog_id))) {
+		if (prog->aux->priv_user == cgroup_id(cgrp))
+			rcu_assign_pointer(prog->aux->priv, sch);
+		bpf_prog_put(prog);
+		prog_id++;
+	}
+
 	if (sch->ops.init) {
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, init, NULL);
 		if (ret) {
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5d762d10f4db..cefc439c9e4a 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -99,12 +99,25 @@ int main(int argc, char **argv)
 			break;
 		case 'c': {
 			struct stat st;
+			int fd, len;
+			char buf[19];
 			if (stat(optarg, &st) < 0) {
 				perror("stat");
 				return 1;
 			}
 			skel->struct_ops.qmap_ops->sub_cgroup_id = st.st_ino;
 			skel->rodata->sub_cgroup_id = st.st_ino;
+			fd = open("/sys/module/bpf/parameters/prog_aux_priv", O_RDWR);
+			if (fd < 0) {
+				perror("open(\"/sys/module/bpf/parameters/prog_aux_priv\")");
+				return 1;
+			}
+			len = snprintf(buf, sizeof(buf), "0x%lx", st.st_ino);
+			if (write(fd, buf, len) != len) {
+				perror("write(\"/sys/module/bpf/parameters/prog_aux_priv\")");
+				return 1;
+			}
+			close(fd);
 			break;
 		}
 		case 'd':
-- 
2.51.0


