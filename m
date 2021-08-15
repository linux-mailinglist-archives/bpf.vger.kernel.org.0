Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853323EC7C9
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhHOHGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:06:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230501AbhHOHGp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:06:45 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F6xxnY004015
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aed56b88m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:15 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:14 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9BADC3D405A0; Sun, 15 Aug 2021 00:06:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v5 bpf-next 01/16] bpf: refactor BPF_PROG_RUN into a function
Date:   Sun, 15 Aug 2021 00:05:54 -0700
Message-ID: <20210815070609.987780-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ODJ1mHxr-gqtJBUhL1yJFxapjlZCAa3y
X-Proofpoint-GUID: ODJ1mHxr-gqtJBUhL1yJFxapjlZCAa3y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1034 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108150048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turn BPF_PROG_RUN into a proper always inlined function. No functional and
performance changes are intended, but it makes it much easier to understand
what's going on with how BPF programs are actually get executed. It's more
obvious what types and callbacks are expected. Also extra () around input
parameters can be dropped, as well as `__` variable prefixes intended to avoid
naming collisions, which makes the code simpler to read and write.

This refactoring also highlighted one extra issue. BPF_PROG_RUN is both
a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
BPF_PROG_RUN into a function causes naming conflict compilation error. So
rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. All existing callers of
BPF_PROG_RUN, the macro, are switched to bpf_prog_run() explicitly.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/networking/filter.rst      |  4 +-
 drivers/media/rc/bpf-lirc.c              |  2 +-
 drivers/net/ppp/ppp_generic.c            |  8 ++--
 drivers/net/team/team_mode_loadbalance.c |  2 +-
 include/linux/bpf.h                      |  2 +-
 include/linux/filter.h                   | 61 ++++++++++++++----------
 kernel/bpf/bpf_iter.c                    |  2 +-
 kernel/bpf/cgroup.c                      | 16 +++----
 kernel/bpf/core.c                        |  2 +-
 kernel/bpf/trampoline.c                  |  2 +-
 kernel/bpf/verifier.c                    |  2 +-
 kernel/events/core.c                     |  2 +-
 kernel/trace/bpf_trace.c                 |  4 +-
 lib/test_bpf.c                           |  2 +-
 net/bpf/test_run.c                       |  6 +--
 net/core/filter.c                        |  4 +-
 net/core/ptp_classifier.c                |  2 +-
 net/netfilter/xt_bpf.c                   |  2 +-
 net/sched/act_bpf.c                      |  4 +-
 net/sched/cls_bpf.c                      |  4 +-
 20 files changed, 73 insertions(+), 60 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 5f13905b12e0..ce2b8e8bb9ab 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -638,8 +638,8 @@ extension, PTP dissector/classifier, and much more. They are all internally
 converted by the kernel into the new instruction set representation and run
 in the eBPF interpreter. For in-kernel handlers, this all works transparently
 by using bpf_prog_create() for setting up the filter, resp.
-bpf_prog_destroy() for destroying it. The macro
-BPF_PROG_RUN(filter, ctx) transparently invokes eBPF interpreter or JITed
+bpf_prog_destroy() for destroying it. The function
+bpf_prog_run(filter, ctx) transparently invokes eBPF interpreter or JITed
 code to run the filter. 'filter' is a pointer to struct bpf_prog that we
 got from bpf_prog_create(), and 'ctx' the given context (e.g.
 skb pointer). All constraints and restrictions from bpf_check_classic() apply
diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index afae0afe3f81..bb5a9dc78f1b 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -217,7 +217,7 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
 	raw->bpf_sample = sample;
 
 	if (raw->progs)
-		BPF_PROG_RUN_ARRAY(raw->progs, &raw->bpf_sample, BPF_PROG_RUN);
+		BPF_PROG_RUN_ARRAY(raw->progs, &raw->bpf_sample, bpf_prog_run);
 }
 
 /*
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index e9e81573f21e..fb52cd175b45 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1744,7 +1744,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 		   a four-byte PPP header on each packet */
 		*(u8 *)skb_push(skb, 2) = 1;
 		if (ppp->pass_filter &&
-		    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
+		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
 				netdev_printk(KERN_DEBUG, ppp->dev,
 					      "PPP: outbound frame "
@@ -1754,7 +1754,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 		}
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter &&
-		      BPF_PROG_RUN(ppp->active_filter, skb) == 0))
+		      bpf_prog_run(ppp->active_filter, skb) == 0))
 			ppp->last_xmit = jiffies;
 		skb_pull(skb, 2);
 #else
@@ -2468,7 +2468,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 
 			*(u8 *)skb_push(skb, 2) = 0;
 			if (ppp->pass_filter &&
-			    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
+			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
 					netdev_printk(KERN_DEBUG, ppp->dev,
 						      "PPP: inbound frame "
@@ -2477,7 +2477,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 				return;
 			}
 			if (!(ppp->active_filter &&
-			      BPF_PROG_RUN(ppp->active_filter, skb) == 0))
+			      bpf_prog_run(ppp->active_filter, skb) == 0))
 				ppp->last_recv = jiffies;
 			__skb_pull(skb, 2);
 		} else
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 32aef8ac4a14..b095a4b4957b 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -197,7 +197,7 @@ static unsigned int lb_get_skb_hash(struct lb_priv *lb_priv,
 	fp = rcu_dereference_bh(lb_priv->fp);
 	if (unlikely(!fp))
 		return 0;
-	lhash = BPF_PROG_RUN(fp, skb);
+	lhash = bpf_prog_run(fp, skb);
 	c = (char *) &lhash;
 	return c[0] ^ c[1] ^ c[2] ^ c[3];
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c8cc09013210..968fea98087a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1103,7 +1103,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 /* an array of programs to be executed under rcu_lock.
  *
  * Typical usage:
- * ret = BPF_PROG_RUN_ARRAY(&bpf_prog_array, ctx, BPF_PROG_RUN);
+ * ret = BPF_PROG_RUN_ARRAY(&bpf_prog_array, ctx, bpf_prog_run);
  *
  * the structure returned by bpf_prog_array_alloc() should be populated
  * with program pointers and the last pointer must be NULL.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1797e8506929..954373db20e7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -600,25 +600,38 @@ struct sk_filter {
 
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
-#define __BPF_PROG_RUN(prog, ctx, dfunc)	({			\
-	u32 __ret;							\
-	cant_migrate();							\
-	if (static_branch_unlikely(&bpf_stats_enabled_key)) {		\
-		struct bpf_prog_stats *__stats;				\
-		u64 __start = sched_clock();				\
-		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
-		__stats = this_cpu_ptr(prog->stats);			\
-		u64_stats_update_begin(&__stats->syncp);		\
-		__stats->cnt++;						\
-		__stats->nsecs += sched_clock() - __start;		\
-		u64_stats_update_end(&__stats->syncp);			\
-	} else {							\
-		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
-	}								\
-	__ret; })
-
-#define BPF_PROG_RUN(prog, ctx)						\
-	__BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func)
+typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
+					  const struct bpf_insn *insnsi,
+					  unsigned int (*bpf_func)(const void *,
+								   const struct bpf_insn *));
+
+static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
+					  const void *ctx,
+					  bpf_dispatcher_fn dfunc)
+{
+	u32 ret;
+
+	cant_migrate();
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
+		struct bpf_prog_stats *stats;
+		u64 start = sched_clock();
+
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		stats = this_cpu_ptr(prog->stats);
+		u64_stats_update_begin(&stats->syncp);
+		stats->cnt++;
+		stats->nsecs += sched_clock() - start;
+		u64_stats_update_end(&stats->syncp);
+	} else {
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+	}
+	return ret;
+}
+
+static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void *ctx)
+{
+	return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
+}
 
 /*
  * Use in preemptible and therefore migratable context to make sure that
@@ -637,7 +650,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 	u32 ret;
 
 	migrate_disable();
-	ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
+	ret = bpf_prog_run(prog, ctx);
 	migrate_enable();
 	return ret;
 }
@@ -742,7 +755,7 @@ static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
 		memset(cb_data, 0, sizeof(cb_saved));
 	}
 
-	res = BPF_PROG_RUN(prog, skb);
+	res = bpf_prog_run(prog, skb);
 
 	if (unlikely(prog->cb_access))
 		memcpy(cb_data, cb_saved, sizeof(cb_saved));
@@ -787,7 +800,7 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act = __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
@@ -1440,7 +1453,7 @@ static inline bool bpf_sk_lookup_run_v4(struct net *net, int protocol,
 		};
 		u32 act;
 
-		act = BPF_PROG_SK_LOOKUP_RUN_ARRAY(run_array, ctx, BPF_PROG_RUN);
+		act = BPF_PROG_SK_LOOKUP_RUN_ARRAY(run_array, ctx, bpf_prog_run);
 		if (act == SK_PASS) {
 			selected_sk = ctx.selected_sk;
 			no_reuseport = ctx.no_reuseport;
@@ -1478,7 +1491,7 @@ static inline bool bpf_sk_lookup_run_v6(struct net *net, int protocol,
 		};
 		u32 act;
 
-		act = BPF_PROG_SK_LOOKUP_RUN_ARRAY(run_array, ctx, BPF_PROG_RUN);
+		act = BPF_PROG_SK_LOOKUP_RUN_ARRAY(run_array, ctx, bpf_prog_run);
 		if (act == SK_PASS) {
 			selected_sk = ctx.selected_sk;
 			no_reuseport = ctx.no_reuseport;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 2e9d47bb40ff..b2ee45064e06 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -686,7 +686,7 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 
 	rcu_read_lock();
 	migrate_disable();
-	ret = BPF_PROG_RUN(prog, ctx);
+	ret = bpf_prog_run(prog, ctx);
 	migrate_enable();
 	rcu_read_unlock();
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9f6070369caa..16dc467adfa0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1043,7 +1043,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	int ret;
 
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sk, BPF_PROG_RUN);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sk, bpf_prog_run);
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
@@ -1091,7 +1091,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	ret = BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[type], &ctx,
-				       BPF_PROG_RUN, flags);
+				       bpf_prog_run, flags);
 
 	return ret == 1 ? 0 : -EPERM;
 }
@@ -1121,7 +1121,7 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 	int ret;
 
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sock_ops,
-				 BPF_PROG_RUN);
+				 bpf_prog_run);
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_ops);
@@ -1140,7 +1140,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
 	allow = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx,
-				   BPF_PROG_RUN);
+				   bpf_prog_run);
 	rcu_read_unlock();
 
 	return !allow;
@@ -1271,7 +1271,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, bpf_prog_run);
 	rcu_read_unlock();
 
 	kfree(ctx.cur_val);
@@ -1386,7 +1386,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 
 	lock_sock(sk);
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
-				 &ctx, BPF_PROG_RUN);
+				 &ctx, bpf_prog_run);
 	release_sock(sk);
 
 	if (!ret) {
@@ -1496,7 +1496,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 
 	lock_sock(sk);
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
-				 &ctx, BPF_PROG_RUN);
+				 &ctx, bpf_prog_run);
 	release_sock(sk);
 
 	if (!ret) {
@@ -1557,7 +1557,7 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 	 */
 
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
-				 &ctx, BPF_PROG_RUN);
+				 &ctx, bpf_prog_run);
 	if (!ret)
 		return -EPERM;
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 82af6279992d..5ee2ec27c3d4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1879,7 +1879,7 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
  *	@err: pointer to error variable
  *
  * Try to JIT eBPF program, if JIT is not available, use interpreter.
- * The BPF program will be executed via BPF_PROG_RUN() macro.
+ * The BPF program will be executed via bpf_prog_run() function.
  *
  * Return: the &fp argument along with &err set to 0 for success or
  * a negative errno code on failure
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b2535acfe9db..fe1e857324e6 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -548,7 +548,7 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
 	u64_stats_update_end(&stats->syncp);
 }
 
-/* The logic is similar to BPF_PROG_RUN, but with an explicit
+/* The logic is similar to bpf_prog_run(), but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
  * call __bpf_prog_enter
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5ea2238a6656..f5a0077c9981 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12383,7 +12383,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		subprog_end = env->subprog_info[i + 1].start;
 
 		len = subprog_end - subprog_start;
-		/* BPF_PROG_RUN doesn't call subprogs directly,
+		/* bpf_prog_run() doesn't call subprogs directly,
 		 * hence main prog stats include the runtime of subprogs.
 		 * subprogs don't have IDs and not reachable via prog_get_next_id
 		 * func[i]->stats will never be accessed and stays NULL
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..7d20743b48e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9913,7 +9913,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
 	rcu_read_lock();
-	ret = BPF_PROG_RUN(event->prog, &ctx);
+	ret = bpf_prog_run(event->prog, &ctx);
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0da94e1d6af9..05a5a556671d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -124,7 +124,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	 * out of events when it was updated in between this and the
 	 * rcu_dereference() which is accepted risk.
 	 */
-	ret = BPF_PROG_RUN_ARRAY_CHECK(call->prog_array, ctx, BPF_PROG_RUN);
+	ret = BPF_PROG_RUN_ARRAY_CHECK(call->prog_array, ctx, bpf_prog_run);
 
  out:
 	__this_cpu_dec(bpf_prog_active);
@@ -1816,7 +1816,7 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
 	cant_sleep();
 	rcu_read_lock();
-	(void) BPF_PROG_RUN(prog, args);
+	(void) bpf_prog_run(prog, args);
 	rcu_read_unlock();
 }
 
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 44d8197bbffb..14716a4aadaf 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -8616,7 +8616,7 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
 	start = ktime_get_ns();
 
 	for (i = 0; i < runs; i++)
-		ret = BPF_PROG_RUN(fp, data);
+		ret = bpf_prog_run(fp, data);
 
 	finish = ktime_get_ns();
 	migrate_enable();
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4b855af267b1..2eb0e55ef54d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -116,7 +116,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 		if (xdp)
 			*retval = bpf_prog_run_xdp(prog, ctx);
 		else
-			*retval = BPF_PROG_RUN(prog, ctx);
+			*retval = bpf_prog_run(prog, ctx);
 	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
 	bpf_test_timer_leave(&t);
@@ -327,7 +327,7 @@ __bpf_prog_test_run_raw_tp(void *data)
 	struct bpf_raw_tp_test_run_info *info = data;
 
 	rcu_read_lock();
-	info->retval = BPF_PROG_RUN(info->prog, info->ctx);
+	info->retval = bpf_prog_run(info->prog, info->ctx);
 	rcu_read_unlock();
 }
 
@@ -989,7 +989,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	bpf_test_timer_enter(&t);
 	do {
 		ctx.selected_sk = NULL;
-		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, BPF_PROG_RUN);
+		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_prog_run);
 	} while (bpf_test_timer_continue(&t, repeat, &ret, &duration));
 	bpf_test_timer_leave(&t);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 3aca07c44fad..5cf38e8886f1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(copy_bpf_fprog_from_user);
  * Run the eBPF program and then cut skb->data to correct size returned by
  * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
  * than pkt_len we keep whole skb->data. This is the socket level
- * wrapper to BPF_PROG_RUN. It returns 0 if the packet should
+ * wrapper to bpf_prog_run. It returns 0 if the packet should
  * be accepted or -EPERM if the packet should be tossed.
  *
  */
@@ -10115,7 +10115,7 @@ struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 	enum sk_action action;
 
 	bpf_init_reuseport_kern(&reuse_kern, reuse, sk, skb, migrating_sk, hash);
-	action = BPF_PROG_RUN(prog, &reuse_kern);
+	action = bpf_prog_run(prog, &reuse_kern);
 
 	if (action == SK_PASS)
 		return reuse_kern.selected_sk;
diff --git a/net/core/ptp_classifier.c b/net/core/ptp_classifier.c
index e33fde06d528..dd4cf01d1e0a 100644
--- a/net/core/ptp_classifier.c
+++ b/net/core/ptp_classifier.c
@@ -103,7 +103,7 @@ static struct bpf_prog *ptp_insns __read_mostly;
 
 unsigned int ptp_classify_raw(const struct sk_buff *skb)
 {
-	return BPF_PROG_RUN(ptp_insns, skb);
+	return bpf_prog_run(ptp_insns, skb);
 }
 EXPORT_SYMBOL_GPL(ptp_classify_raw);
 
diff --git a/net/netfilter/xt_bpf.c b/net/netfilter/xt_bpf.c
index 13cf3f9b5938..849ac552a154 100644
--- a/net/netfilter/xt_bpf.c
+++ b/net/netfilter/xt_bpf.c
@@ -90,7 +90,7 @@ static bool bpf_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_bpf_info *info = par->matchinfo;
 
-	return BPF_PROG_RUN(info->filter, skb);
+	return bpf_prog_run(info->filter, skb);
 }
 
 static bool bpf_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 040807aa15b9..5c36013339e1 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -47,11 +47,11 @@ static int tcf_bpf_act(struct sk_buff *skb, const struct tc_action *act,
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
 		bpf_compute_data_pointers(skb);
-		filter_res = BPF_PROG_RUN(filter, skb);
+		filter_res = bpf_prog_run(filter, skb);
 		__skb_pull(skb, skb->mac_len);
 	} else {
 		bpf_compute_data_pointers(skb);
-		filter_res = BPF_PROG_RUN(filter, skb);
+		filter_res = bpf_prog_run(filter, skb);
 	}
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 3b472bafdc9d..df19a847829e 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -96,11 +96,11 @@ static int cls_bpf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			/* It is safe to push/pull even if skb_shared() */
 			__skb_push(skb, skb->mac_len);
 			bpf_compute_data_pointers(skb);
-			filter_res = BPF_PROG_RUN(prog->filter, skb);
+			filter_res = bpf_prog_run(prog->filter, skb);
 			__skb_pull(skb, skb->mac_len);
 		} else {
 			bpf_compute_data_pointers(skb);
-			filter_res = BPF_PROG_RUN(prog->filter, skb);
+			filter_res = bpf_prog_run(prog->filter, skb);
 		}
 
 		if (prog->exts_integrated) {
-- 
2.30.2

