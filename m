Return-Path: <bpf+bounces-62872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899ECAFF766
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF3B189EC21
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092DD281509;
	Thu, 10 Jul 2025 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rmxzk4Qo"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9B2AD0F
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117742; cv=none; b=KFTSCrnOJQ2nerELaCQP+zsgH5IF37VzLvPgd/MEvKbK+Nt8IDNthJSGV0uNYmZVXEf4aB2dajvtKqaM699n6UpOnZHT0zkyBu2JAN6MAKoImuwtuVoZDDi2Og6Lh2WrcOGNnhyaOIvdYSjkKJu2jDULMp7wMSsmnXpDIVZ3p/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117742; c=relaxed/simple;
	bh=gcnLjheYyufgjbXpPrzQCuYO+2LjkyEps3sh/9oxbFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMFzr1FUir+GUJrFuuk9V/rMUxXrpe6Ly1dqav8BBEtoN9CgoSWAx9rxh+53s5cPtr2lgXL4G/m9xnIbIktK1PRMNikjj49r5+B83fW8R9nG1xtRJicGgJjQYn1yaqdUYSjfqeW+qj6rxAI4n31pCN8jjkIYtk4W0mJBKztjkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rmxzk4Qo; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWXbz8lENZChjKUhm+nvxaAfAmjus63zz5ZUWv/Z0I8=;
	b=Rmxzk4QoAcYcxVc7bnv+ceOUroxTD9OHeVlVx57F+4kAwWPsJLZQhJHPxCyyz/04BnTRCN
	7gmtf6k8GjCIn/0y0jL1UuXCus3wkOA05YuDfe6FWruFK+2FPzpaxvx/Fsq/atDrdSCfAP
	x5QPevLc21K4MZiWGUmoDF9jGICAQc0=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 1/7] bpf: Add attach_type in bpf_link
Date: Thu, 10 Jul 2025 11:20:32 +0800
Message-ID: <20250710032038.888700-2-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-1-chen.dylane@linux.dev>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Attach_type will be set when link created from user, it is better
to record attach_type in bpf_link directly suggested by Andrii. So
add the attach_type field in bpf_link and move the sleepable field to
the end just to fill the byte hole.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 drivers/net/netkit.c           |  2 +-
 include/linux/bpf.h            | 28 ++++++++++++++++-----------
 kernel/bpf/bpf_iter.c          |  3 ++-
 kernel/bpf/bpf_struct_ops.c    |  5 +++--
 kernel/bpf/cgroup.c            |  4 ++--
 kernel/bpf/net_namespace.c     |  2 +-
 kernel/bpf/syscall.c           | 35 +++++++++++++++++++++-------------
 kernel/bpf/tcx.c               |  3 ++-
 kernel/bpf/trampoline.c        | 10 ++++++----
 kernel/trace/bpf_trace.c       |  4 ++--
 net/bpf/bpf_dummy_struct_ops.c |  3 ++-
 net/core/dev.c                 |  3 ++-
 net/core/sock_map.c            |  3 ++-
 net/netfilter/nf_bpf_link.c    |  3 ++-
 14 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index d072a7968f5..5928c99eac7 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -775,7 +775,7 @@ static int netkit_link_init(struct netkit_link *nkl,
 			    struct bpf_prog *prog)
 {
 	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
-		      &netkit_link_lops, prog);
+		      &netkit_link_lops, prog, attr->link_create.attach_type);
 	nkl->location = attr->link_create.attach_type;
 	nkl->dev = dev;
 	return bpf_link_prime(&nkl->link, link_primer);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 34dd90ec7fa..dd5070039de 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1729,12 +1729,10 @@ struct bpf_link {
 	enum bpf_link_type type;
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
-	/* whether BPF link itself has "sleepable" semantics, which can differ
-	 * from underlying BPF program having a "sleepable" semantics, as BPF
-	 * link's semantics is determined by target attach hook
-	 */
-	bool sleepable;
+
 	u32 flags;
+	enum bpf_attach_type attach_type;
+
 	/* rcu is used before freeing, work can be used to schedule that
 	 * RCU-based freeing before that, so they never overlap
 	 */
@@ -1742,6 +1740,11 @@ struct bpf_link {
 		struct rcu_head rcu;
 		struct work_struct work;
 	};
+	/* whether BPF link itself has "sleepable" semantics, which can differ
+	 * from underlying BPF program having a "sleepable" semantics, as BPF
+	 * link's semantics is determined by target attach hook
+	 */
+	bool sleepable;
 };
 
 struct bpf_link_ops {
@@ -2034,11 +2037,13 @@ int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
-				    int cgroup_atype);
+				    int cgroup_atype,
+				    enum bpf_attach_type attach_type);
 void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
-						  int cgroup_atype)
+						  int cgroup_atype,
+						  enum bpf_attach_type attach_type)
 {
 	return -EOPNOTSUPP;
 }
@@ -2528,10 +2533,11 @@ int bpf_map_new_fd(struct bpf_map *map, int flags);
 int bpf_prog_new_fd(struct bpf_prog *prog);
 
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
-		   const struct bpf_link_ops *ops, struct bpf_prog *prog);
+		   const struct bpf_link_ops *ops, struct bpf_prog *prog,
+		   enum bpf_attach_type attach_type);
 void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
 			     const struct bpf_link_ops *ops, struct bpf_prog *prog,
-			     bool sleepable);
+			     bool sleepable, enum bpf_attach_type attach_type);
 int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
@@ -2883,13 +2889,13 @@ bpf_prog_inc_not_zero(struct bpf_prog *prog)
 
 static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 				 const struct bpf_link_ops *ops,
-				 struct bpf_prog *prog)
+				 struct bpf_prog *prog, enum bpf_attach_type attach_type)
 {
 }
 
 static inline void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
 					   const struct bpf_link_ops *ops, struct bpf_prog *prog,
-					   bool sleepable)
+					   bool sleepable, enum bpf_attach_type attach_type)
 {
 }
 
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 303ab1f42d3..0cbcae72707 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -552,7 +552,8 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	if (!link)
 		return -ENOMEM;
 
-	bpf_link_init(&link->link, BPF_LINK_TYPE_ITER, &bpf_iter_link_lops, prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_ITER, &bpf_iter_link_lops, prog,
+		      attr->link_create.attach_type);
 	link->tinfo = tinfo;
 
 	err = bpf_link_prime(&link->link, &link_primer);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 96113633e39..687a3e9c76f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -808,7 +808,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
-			      &bpf_struct_ops_link_lops, prog);
+			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
 		*plink++ = &link->link;
 
 		ksym = kzalloc(sizeof(*ksym), GFP_USER);
@@ -1351,7 +1351,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		err = -ENOMEM;
 		goto err_out;
 	}
-	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
+		      attr->link_create.attach_type);
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index cd220e861d6..bacdd0ca741 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -867,7 +867,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
-		err = bpf_trampoline_link_cgroup_shim(new_prog, atype);
+		err = bpf_trampoline_link_cgroup_shim(new_prog, atype, type);
 		if (err)
 			goto cleanup;
 	}
@@ -1495,7 +1495,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto out_put_cgroup;
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_CGROUP, &bpf_cgroup_link_lops,
-		      prog);
+		      prog, attr->link_create.attach_type);
 	link->cgroup = cgrp;
 	link->type = attr->link_create.attach_type;
 
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 868cc2c4389..63702c86275 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -501,7 +501,7 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto out_put_net;
 	}
 	bpf_link_init(&net_link->link, BPF_LINK_TYPE_NETNS,
-		      &bpf_netns_link_ops, prog);
+		      &bpf_netns_link_ops, prog, type);
 	net_link->net = net;
 	net_link->type = type;
 	net_link->netns_type = netns_type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7db7182a305..14883b3040a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3069,7 +3069,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
  */
 void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
 			     const struct bpf_link_ops *ops, struct bpf_prog *prog,
-			     bool sleepable)
+			     bool sleepable, enum bpf_attach_type attach_type)
 {
 	WARN_ON(ops->dealloc && ops->dealloc_deferred);
 	atomic64_set(&link->refcnt, 1);
@@ -3078,12 +3078,14 @@ void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
 	link->id = 0;
 	link->ops = ops;
 	link->prog = prog;
+	link->attach_type = attach_type;
 }
 
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
-		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
+		   const struct bpf_link_ops *ops, struct bpf_prog *prog,
+		   enum bpf_attach_type attach_type)
 {
-	bpf_link_init_sleepable(link, type, ops, prog, false);
+	bpf_link_init_sleepable(link, type, ops, prog, false, attach_type);
 }
 
 static void bpf_link_free_id(int id)
@@ -3443,7 +3445,8 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
-				   u64 bpf_cookie)
+				   u64 bpf_cookie,
+				   enum bpf_attach_type attach_type)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3511,7 +3514,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_put_prog;
 	}
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
-		      &bpf_tracing_link_lops, prog);
+		      &bpf_tracing_link_lops, prog, attach_type);
+
 	link->attach_type = prog->expected_attach_type;
 	link->link.cookie = bpf_cookie;
 
@@ -4049,7 +4053,8 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 		err = -ENOMEM;
 		goto out_put_file;
 	}
-	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog,
+		      attr->link_create.attach_type);
 	link->perf_file = perf_file;
 
 	err = bpf_link_prime(&link->link, &link_primer);
@@ -4081,7 +4086,8 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 #endif /* CONFIG_PERF_EVENTS */
 
 static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
-				  const char __user *user_tp_name, u64 cookie)
+				  const char __user *user_tp_name, u64 cookie,
+				  enum bpf_attach_type attach_type)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_raw_tp_link *link;
@@ -4104,7 +4110,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -4127,7 +4133,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	}
 	bpf_link_init_sleepable(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
 				&bpf_raw_tp_link_lops, prog,
-				tracepoint_is_faultable(btp->tp));
+				tracepoint_is_faultable(btp->tp), attach_type);
 	link->btp = btp;
 	link->cookie = cookie;
 
@@ -4168,7 +4174,7 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 	tp_name = u64_to_user_ptr(attr->raw_tracepoint.name);
 	cookie = attr->raw_tracepoint.cookie;
-	fd = bpf_raw_tp_link_attach(prog, tp_name, cookie);
+	fd = bpf_raw_tp_link_attach(prog, tp_name, cookie, prog->expected_attach_type);
 	if (fd < 0)
 		bpf_prog_put(prog);
 	return fd;
@@ -5536,7 +5542,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_tracing_prog_attach(prog,
 					      attr->link_create.target_fd,
 					      attr->link_create.target_btf_id,
-					      attr->link_create.tracing.cookie);
+					      attr->link_create.tracing.cookie,
+					      attr->link_create.attach_type);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
@@ -5545,7 +5552,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto out;
 		}
 		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
-			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie);
+			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie,
+						     attr->link_create.attach_type);
 		else if (prog->expected_attach_type == BPF_TRACE_ITER)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -5554,7 +5562,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
-						      attr->link_create.tracing.cookie);
+						      attr->link_create.tracing.cookie,
+						      attr->link_create.attach_type);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 2e4885e7781..e6a14f408d9 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -301,7 +301,8 @@ static int tcx_link_init(struct tcx_link *tcx,
 			 struct net_device *dev,
 			 struct bpf_prog *prog)
 {
-	bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog);
+	bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog,
+		      attr->link_create.attach_type);
 	tcx->location = attr->link_create.attach_type;
 	tcx->dev = dev;
 	return bpf_link_prime(&tcx->link, link_primer);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b1e358c16ee..0e364614c3a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -674,7 +674,8 @@ static const struct bpf_link_ops bpf_shim_tramp_link_lops = {
 
 static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog,
 						     bpf_func_t bpf_func,
-						     int cgroup_atype)
+						     int cgroup_atype,
+						     enum bpf_attach_type attach_type)
 {
 	struct bpf_shim_tramp_link *shim_link = NULL;
 	struct bpf_prog *p;
@@ -701,7 +702,7 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	p->expected_attach_type = BPF_LSM_MAC;
 	bpf_prog_inc(p);
 	bpf_link_init(&shim_link->link.link, BPF_LINK_TYPE_UNSPEC,
-		      &bpf_shim_tramp_link_lops, p);
+		      &bpf_shim_tramp_link_lops, p, attach_type);
 	bpf_cgroup_atype_get(p->aux->attach_btf_id, cgroup_atype);
 
 	return shim_link;
@@ -726,7 +727,8 @@ static struct bpf_shim_tramp_link *cgroup_shim_find(struct bpf_trampoline *tr,
 }
 
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
-				    int cgroup_atype)
+				    int cgroup_atype,
+				    enum bpf_attach_type attach_type)
 {
 	struct bpf_shim_tramp_link *shim_link = NULL;
 	struct bpf_attach_target_info tgt_info = {};
@@ -763,7 +765,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 
 	/* Allocate and install new shim. */
 
-	shim_link = cgroup_shim_alloc(prog, bpf_func, cgroup_atype);
+	shim_link = cgroup_shim_alloc(prog, bpf_func, cgroup_atype, attach_type);
 	if (!shim_link) {
 		err = -ENOMEM;
 		goto err;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7f97a9a8bb..ffdde840abb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2986,7 +2986,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_KPROBE_MULTI,
-		      &bpf_kprobe_multi_link_lops, prog);
+		      &bpf_kprobe_multi_link_lops, prog, attr->link_create.attach_type);
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
@@ -3441,7 +3441,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->link.flags = flags;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
-		      &bpf_uprobe_multi_link_lops, prog);
+		      &bpf_uprobe_multi_link_lops, prog, attr->link_create.attach_type);
 
 	for (i = 0; i < cnt; i++) {
 		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index f71f67c6896..812457819b5 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -171,7 +171,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	/* prog doesn't take the ownership of the reference from caller */
 	bpf_prog_inc(prog);
-	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog,
+		      prog->expected_attach_type);
 
 	op_idx = prog->expected_attach_type;
 	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd..7969fddc94e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10364,7 +10364,8 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog,
+		      attr->link_create.attach_type);
 	link->dev = dev;
 	link->flags = attr->link_create.flags;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82a14f131d0..fbe9a33ddf1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1866,7 +1866,8 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	}
 
 	attach_type = attr->link_create.attach_type;
-	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog);
+	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog,
+		      attach_type);
 	sockmap_link->map = map;
 	sockmap_link->attach_type = attach_type;
 
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b08484470..a054d3b216d 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -225,7 +225,8 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!link)
 		return -ENOMEM;
 
-	bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_lops, prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_lops, prog,
+		      attr->link_create.attach_type);
 
 	link->hook_ops.hook = nf_hook_run_bpf;
 	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
-- 
2.48.1


