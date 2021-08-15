Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78443EC7CA
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhHOHGx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:06:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232098AbhHOHGw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:06:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F6wK1A002718
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:23 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aed56b88y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:23 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:22 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A0A323D405A0; Sun, 15 Aug 2021 00:06:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v5 bpf-next 02/16] bpf: refactor BPF_PROG_RUN_ARRAY family of macros into functions
Date:   Sun, 15 Aug 2021 00:05:55 -0700
Message-ID: <20210815070609.987780-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: hmoIzvBZogb9AZPdI10TxphrTzhP8HkQ
X-Proofpoint-GUID: hmoIzvBZogb9AZPdI10TxphrTzhP8HkQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108150048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to BPF_PROG_RUN, turn BPF_PROG_RUN_ARRAY macros into proper functions
with all the same readability and maintainability benefits. Making them into
functions required shuffling around bpf_set_run_ctx/bpf_reset_run_ctx
functions. Also, explicitly specifying the type of the BPF prog run callback
required adjusting __bpf_prog_run_save_cb() to accept const void *, casted
internally to const struct sk_buff.

Further, split out a cgroup-specific BPF_PROG_RUN_ARRAY_CG and
BPF_PROG_RUN_ARRAY_CG_FLAGS from the more generic BPF_PROG_RUN_ARRAY due to
the differences in bpf_run_ctx used for those two different use cases.

I think BPF_PROG_RUN_ARRAY_CG would benefit from further refactoring to accept
struct cgroup and enum bpf_attach_type instead of bpf_prog_array, fetching
cgrp->bpf.effective[type] and RCU-dereferencing it internally. But that
required including include/linux/cgroup-defs.h, which I wasn't sure is ok with
everyone.

The remaining generic BPF_PROG_RUN_ARRAY function will be extended to
pass-through user-provided context value in the next patch.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h      | 179 +++++++++++++++++++++++----------------
 include/linux/filter.h   |   5 +-
 kernel/bpf/cgroup.c      |  32 +++----
 kernel/trace/bpf_trace.c |   2 +-
 4 files changed, 124 insertions(+), 94 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 968fea98087a..344e0d4d8ef6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1146,67 +1146,116 @@ struct bpf_run_ctx {};
 
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
-	struct bpf_prog_array_item *prog_item;
+	const struct bpf_prog_array_item *prog_item;
 };
 
+static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
+{
+	struct bpf_run_ctx *old_ctx = NULL;
+
+#ifdef CONFIG_BPF_SYSCALL
+	old_ctx = current->bpf_ctx;
+	current->bpf_ctx = new_ctx;
+#endif
+	return old_ctx;
+}
+
+static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	current->bpf_ctx = old_ctx;
+#endif
+}
+
 /* BPF program asks to bypass CAP_NET_BIND_SERVICE in bind. */
 #define BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE			(1 << 0)
 /* BPF program asks to set CN on the packet. */
 #define BPF_RET_SET_CN						(1 << 0)
 
-#define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)		\
-	({								\
-		struct bpf_prog_array_item *_item;			\
-		struct bpf_prog *_prog;					\
-		struct bpf_prog_array *_array;				\
-		struct bpf_run_ctx *old_run_ctx;			\
-		struct bpf_cg_run_ctx run_ctx;				\
-		u32 _ret = 1;						\
-		u32 func_ret;						\
-		migrate_disable();					\
-		rcu_read_lock();					\
-		_array = rcu_dereference(array);			\
-		_item = &_array->items[0];				\
-		old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);	\
-		while ((_prog = READ_ONCE(_item->prog))) {		\
-			run_ctx.prog_item = _item;			\
-			func_ret = func(_prog, ctx);			\
-			_ret &= (func_ret & 1);				\
-			*(ret_flags) |= (func_ret >> 1);		\
-			_item++;					\
-		}							\
-		bpf_reset_run_ctx(old_run_ctx);				\
-		rcu_read_unlock();					\
-		migrate_enable();					\
-		_ret;							\
-	 })
-
-#define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null, set_cg_storage)	\
-	({						\
-		struct bpf_prog_array_item *_item;	\
-		struct bpf_prog *_prog;			\
-		struct bpf_prog_array *_array;		\
-		struct bpf_run_ctx *old_run_ctx;	\
-		struct bpf_cg_run_ctx run_ctx;		\
-		u32 _ret = 1;				\
-		migrate_disable();			\
-		rcu_read_lock();			\
-		_array = rcu_dereference(array);	\
-		if (unlikely(check_non_null && !_array))\
-			goto _out;			\
-		_item = &_array->items[0];		\
-		old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);\
-		while ((_prog = READ_ONCE(_item->prog))) {	\
-			run_ctx.prog_item = _item;	\
-			_ret &= func(_prog, ctx);	\
-			_item++;			\
-		}					\
-		bpf_reset_run_ctx(old_run_ctx);		\
-_out:							\
-		rcu_read_unlock();			\
-		migrate_enable();			\
-		_ret;					\
-	 })
+typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
+
+static __always_inline u32
+BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
+			    const void *ctx, bpf_prog_run_fn run_prog,
+			    u32 *ret_flags)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_cg_run_ctx run_ctx;
+	u32 ret = 1;
+	u32 func_ret;
+
+	migrate_disable();
+	rcu_read_lock();
+	array = rcu_dereference(array_rcu);
+	item = &array->items[0];
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	while ((prog = READ_ONCE(item->prog))) {
+		run_ctx.prog_item = item;
+		func_ret = run_prog(prog, ctx);
+		ret &= (func_ret & 1);
+		*(ret_flags) |= (func_ret >> 1);
+		item++;
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	rcu_read_unlock();
+	migrate_enable();
+	return ret;
+}
+
+static __always_inline u32
+BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
+		      const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_cg_run_ctx run_ctx;
+	u32 ret = 1;
+
+	migrate_disable();
+	rcu_read_lock();
+	array = rcu_dereference(array_rcu);
+	item = &array->items[0];
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	while ((prog = READ_ONCE(item->prog))) {
+		run_ctx.prog_item = item;
+		ret &= run_prog(prog, ctx);
+		item++;
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	rcu_read_unlock();
+	migrate_enable();
+	return ret;
+}
+
+static __always_inline u32
+BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
+		   const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	u32 ret = 1;
+
+	migrate_disable();
+	rcu_read_lock();
+	array = rcu_dereference(array_rcu);
+	if (unlikely(!array))
+		goto out;
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		ret &= run_prog(prog, ctx);
+		item++;
+	}
+out:
+	rcu_read_unlock();
+	migrate_enable();
+	return ret;
+}
 
 /* To be used by __cgroup_bpf_run_filter_skb for EGRESS BPF progs
  * so BPF programs can request cwr for TCP packets.
@@ -1235,7 +1284,7 @@ _out:							\
 		u32 _flags = 0;				\
 		bool _cn;				\
 		u32 _ret;				\
-		_ret = BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, &_flags); \
+		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
 		if (_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
@@ -1244,12 +1293,6 @@ _out:							\
 		_ret;					\
 	})
 
-#define BPF_PROG_RUN_ARRAY(array, ctx, func)		\
-	__BPF_PROG_RUN_ARRAY(array, ctx, func, false, true)
-
-#define BPF_PROG_RUN_ARRAY_CHECK(array, ctx, func)	\
-	__BPF_PROG_RUN_ARRAY(array, ctx, func, true, false)
-
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -1284,20 +1327,6 @@ static inline void bpf_enable_instrumentation(void)
 	migrate_enable();
 }
 
-static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
-{
-	struct bpf_run_ctx *old_ctx;
-
-	old_ctx = current->bpf_ctx;
-	current->bpf_ctx = new_ctx;
-	return old_ctx;
-}
-
-static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
-{
-	current->bpf_ctx = old_ctx;
-}
-
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 954373db20e7..7d248941ecea 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -723,7 +723,7 @@ static inline void bpf_restore_data_end(
 	cb->data_end = saved_data_end;
 }
 
-static inline u8 *bpf_skb_cb(struct sk_buff *skb)
+static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 {
 	/* eBPF programs may read/write skb->cb[] area to transfer meta
 	 * data between tail calls. Since this also needs to work with
@@ -744,8 +744,9 @@ static inline u8 *bpf_skb_cb(struct sk_buff *skb)
 
 /* Must be invoked with migration disabled */
 static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
-					 struct sk_buff *skb)
+					 const void *ctx)
 {
+	const struct sk_buff *skb = ctx;
 	u8 *cb_data = bpf_skb_cb(skb);
 	u8 cb_saved[BPF_SKB_CB_LEN];
 	u32 res;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 16dc467adfa0..a1dedba4c174 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1012,8 +1012,8 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 		ret = BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(
 			cgrp->bpf.effective[type], skb, __bpf_prog_run_save_cb);
 	} else {
-		ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], skb,
-					  __bpf_prog_run_save_cb);
+		ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[type], skb,
+					    __bpf_prog_run_save_cb);
 		ret = (ret == 1 ? 0 : -EPERM);
 	}
 	bpf_restore_data_end(skb, saved_data_end);
@@ -1043,7 +1043,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	int ret;
 
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sk, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[type], sk, bpf_prog_run);
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
@@ -1090,8 +1090,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	}
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	ret = BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[type], &ctx,
-				       bpf_prog_run, flags);
+	ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(cgrp->bpf.effective[type], &ctx,
+				          bpf_prog_run, flags);
 
 	return ret == 1 ? 0 : -EPERM;
 }
@@ -1120,8 +1120,8 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	int ret;
 
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sock_ops,
-				 bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[type], sock_ops,
+				    bpf_prog_run);
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_ops);
@@ -1139,8 +1139,8 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
-	allow = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx,
-				   bpf_prog_run);
+	allow = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[type], &ctx,
+				      bpf_prog_run);
 	rcu_read_unlock();
 
 	return !allow;
@@ -1271,7 +1271,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[type], &ctx, bpf_prog_run);
 	rcu_read_unlock();
 
 	kfree(ctx.cur_val);
@@ -1385,8 +1385,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	}
 
 	lock_sock(sk);
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
-				 &ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
+				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
 	if (!ret) {
@@ -1495,8 +1495,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	lock_sock(sk);
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
-				 &ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
 	if (!ret) {
@@ -1556,8 +1556,8 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 	 * be called if that data shouldn't be "exported".
 	 */
 
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
-				 &ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+				    &ctx, bpf_prog_run);
 	if (!ret)
 		return -EPERM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 05a5a556671d..91867b14b222 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -124,7 +124,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	 * out of events when it was updated in between this and the
 	 * rcu_dereference() which is accepted risk.
 	 */
-	ret = BPF_PROG_RUN_ARRAY_CHECK(call->prog_array, ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY(call->prog_array, ctx, bpf_prog_run);
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-- 
2.30.2

