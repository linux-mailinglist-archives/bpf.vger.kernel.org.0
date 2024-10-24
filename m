Return-Path: <bpf+bounces-42999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D79ADA0F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31968B22122
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23612158A19;
	Thu, 24 Oct 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OLIsJePz"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FE1494DF;
	Thu, 24 Oct 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737788; cv=none; b=JBuvVa8lD1WQkbuEiNDgwfhdj3Pw3D1ihYSF+VpZ3jT1ZMnMPqC3QIa6wKrghWka5cfSM4wVxip1Zo5t7du88vlyUgct5P1GGpd16SU7QsHrwByIJr/iR1Q/6TWxOlEvavwDiitQZ6hZAmivWeLDMDAYpK5ph8DW/n7tUUqqrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737788; c=relaxed/simple;
	bh=eMWjY1+1kjfCgCVF2umIN3dsg6vwwnNrjtUns2A+YEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j4TnOj3qCNKxF0+OWEuvsX7YDmwPEdVShaAg0W1tDv4w18L17iFlP3YY4IhoMApJJNDf0RkfDYneF6BK86A0A3CUcUYFwQd9yVtt89SFw8fFg9ErwC88IhdA3TO4JZQ7gvQZ7OFWmnU2TflD5jyEeNmnmTtRFVBiD9wexulwxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OLIsJePz; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729737777; h=From:To:Subject:Date:Message-Id;
	bh=flG0UyPoKVke8wGK+I4i8Gy++c7EpmAArJoAHsU7HRI=;
	b=OLIsJePzf/1m4vmncTP86n+JETV8Y87QTTgwYnFavL+JMI8apNSOIAhqnLTviHv8xM/Y7DAdera+7nAEzsw47FJ1AVCUsOeCCWcnt8pJ84kT9tKGbe2Znus2G9osVwTzKuw+OlqRhi9pwoxqk/TjlpdFxOFTeEOKWyppxxFUKi4=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHnU0GO_1729737775 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:42:55 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	dtcccc@linux.alibaba.com
Subject: [PATCH bpf-next 2/4] bpf: allow to access bpf_prog during bpf_struct_access
Date: Thu, 24 Oct 2024 10:42:46 +0800
Message-Id: <1729737768-124596-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

When implements a struct_ops for a subsystem, the fields allowed to
be written within different callbacks for the same structure might
vary, and applying the same restriction logic could lead to unexpected
issues.

Although we can use kfunc to solve it, creating a new kfunc
just for a simple assignment has low value and introduces obvious
maintenance overhead.

This patch allows the subsystem to implement independent validation
logic for different callbacks by passing an additional prog parameter,
then the subsystem can implement independent logic by checking the
prog->expected_attach_type.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/linux/bpf.h                                   | 1 +
 include/linux/filter.h                                | 1 +
 kernel/bpf/verifier.c                                 | 2 +-
 kernel/sched/ext.c                                    | 5 +++--
 net/bpf/bpf_dummy_struct_ops.c                        | 1 +
 net/core/filter.c                                     | 7 +++++--
 net/ipv4/bpf_tcp_ca.c                                 | 1 +
 net/netfilter/nf_conntrack_bpf.c                      | 1 +
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 9 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8..648bafd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -987,6 +987,7 @@ struct bpf_verifier_ops {
 				  struct bpf_prog *prog, u32 *target_size);
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
 				 const struct bpf_reg_state *reg,
+				 const struct bpf_prog *prog,
 				 int off, int size);
 };
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a..2b583e2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -670,6 +670,7 @@ struct sk_filter {
 extern struct mutex nf_conn_btf_access_lock;
 extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
 				     const struct bpf_reg_state *reg,
+					 const struct bpf_prog *prog,
 				     int off, int size);
 
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed52..e5f37cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6638,7 +6638,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
 			return -EFAULT;
 		}
-		ret = env->ops->btf_struct_access(&env->log, reg, off, size);
+		ret = env->ops->btf_struct_access(&env->log, reg, env->prog, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
 		 * program allocated objects (which always have ref_obj_id > 0),
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 410a4df..7b10563 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5344,8 +5344,9 @@ static bool bpf_scx_is_valid_access(int off, int size,
 }
 
 static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
-				     const struct bpf_reg_state *reg, int off,
-				     int size)
+				     const struct bpf_reg_state *reg,
+					 const struct bpf_prog *prog,
+					 int off, int size)
 {
 	const struct btf_type *t;
 
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index f71f67c..5bc7aec 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -234,6 +234,7 @@ static int bpf_dummy_ops_check_member(const struct btf_type *t,
 
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
+					   const struct bpf_prog *prog,
 					   int off, int size)
 {
 	const struct btf_type *state;
diff --git a/net/core/filter.c b/net/core/filter.c
index a88e6924..273393c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9014,18 +9014,20 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 
 int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
 			      const struct bpf_reg_state *reg,
+				  const struct bpf_prog *prog,
 			      int off, int size);
 EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
 
 static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
 					const struct bpf_reg_state *reg,
+					const struct bpf_prog *prog,
 					int off, int size)
 {
 	int ret = -EACCES;
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, reg, off, size);
+		ret = nfct_btf_struct_access(log, reg, prog, off, size);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
@@ -9100,13 +9102,14 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
 
 static int xdp_btf_struct_access(struct bpf_verifier_log *log,
 				 const struct bpf_reg_state *reg,
+				 const struct bpf_prog *prog,
 				 int off, int size)
 {
 	int ret = -EACCES;
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, reg, off, size);
+		ret = nfct_btf_struct_access(log, reg, prog, off, size);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 5548047..c459774 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -60,6 +60,7 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
 
 static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 					const struct bpf_reg_state *reg,
+					const struct bpf_prog *prog,
 					int off, int size)
 {
 	const struct btf_type *t;
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 4a136fc..dad3659 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -235,6 +235,7 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 /* Check writes into `struct nf_conn` */
 static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
+					   const struct bpf_prog *prog,
 					   int off, int size)
 {
 	const struct btf_type *ncit, *nct, *t;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761..b537480 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1243,6 +1243,7 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 
 static int st_ops_btf_struct_access(struct bpf_verifier_log *log,
 				    const struct bpf_reg_state *reg,
+					const struct bpf_prog *prog,
 				    int off, int size)
 {
 	if (off < 0 || off + size > sizeof(struct st_ops_args))
-- 
1.8.3.1


