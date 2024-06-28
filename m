Return-Path: <bpf+bounces-33300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3491B354
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F8A1F22011
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF874405;
	Fri, 28 Jun 2024 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04oA0xN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381817F7;
	Fri, 28 Jun 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534279; cv=none; b=RUKfeJ2ZTCPI4KhYaB/hGEYhWctrJu48XM19xVaN/LVc0nPzqummj5w82wlqSApzx8gK5Pmvq405AAgviaSt6TjDBLjDQXaqRpPnoYuBGHZBhmN5UsAlGB1Ly+1c9ANtbvfBU/t0dIBQJvF2fjSZhzbQ5vy+O1YJVXwIOoIigN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534279; c=relaxed/simple;
	bh=POYzcsbSgEeSCcbnNG2y2ERftVyt9Z8pr8/ToYhaiBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcNYAHdVvCopytznCY5Qz8E01Rr4t/aOF5jZa7ZGJh3XvSHu04/qNN+CJZ33mca+ZVJr6ClOH/vMsNJ/4i9KA9GjdcEvkW/0gScDpE8FiPPCS6X7hY82TA3pxoqF2He+tBQPsVOWt0G6uhcdjlQdqrWNrocDylpqftI6JMqh21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B04oA0xN; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f9398390fcso18978a34.3;
        Thu, 27 Jun 2024 17:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719534277; x=1720139077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3tMwC2VN/Pk75H5RCFtK6XT8OGia8uKjIy8VucRnCk=;
        b=B04oA0xNJQomJCMDIAZ851P5j8trMdRp41K9/TtRR91OW2XMpO2N2pvRSpBp7pN8iN
         MM0g3tBCaFxQZuyaPdoscdtKQnB3hjtUUTPaEQY2SA3XJOnu1jn0VM4Qt/fgfERDmeFZ
         tnpwK8V/Uz27qWdEJDCHkXiR8k0KaBYuPSNBhPb2FGwIzQoWj0YqQ6cil8HlwF7gna3w
         Jgb3MGAJdlS3vOORvjeQHax9NxVDDmY45Aqky9GdugStICeCqxxMah88L1h5ooPBiMlB
         awM5BQ9zxgTDY6hpS8s+OYyS79GdXqhJMRV9YY8FlHD5B/mLPrnrx+NgTgpEhjBCbKpX
         TZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534277; x=1720139077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3tMwC2VN/Pk75H5RCFtK6XT8OGia8uKjIy8VucRnCk=;
        b=clcyHz2dFIw1EtdflG+fAKt6PpNRMPWRSnNHBWL7uGjcZRhoBA/xLXtv8VSsOY0eRU
         8TBdAUh4tL+ARQsYWTPJv4ZcQCkHL6uu9g1U6b1TU8Q7PMjB5SQwV8rY4VytAHtg3oG3
         URBH/JD8f6PSfp/WffJq08MHeVy6DQ8Ct0aJTx8wh6MUqiHFugJPeKESexnO7+E2ocFm
         CinJwexqlfpcugZ9JXecsu02gkQUSP8AoeWJ25xnPf+HK+Lnuk5jiQM1WDF74h2M8eIl
         HRuec910VBzs567d0JVLDsbRRxE4xiXxBape8lF5pKJn8Kj9Rmk4qvFMvfzoEYxMN4DT
         k2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDbkY21Q/AEODn74jYyxskL+0SJKm92PNzamWACjRZPDR7W24fnjsQAnzuEPfA8FXuolusZNwoLE6Xd9AZY3K04UM0
X-Gm-Message-State: AOJu0Yy/ykOKHTDpRTy7hfpDUzsIijDokeXUXZsN5L3vnIknz7uE1rLb
	Z8OdVUKwAaUxFcBtwQ8QQ55fomErPhv44b/3T+sy+cE2HUQjbOQWT50weg==
X-Google-Smtp-Source: AGHT+IEqhQ5Z+ELjMw6pA3Lev06FpsPKP9Oe92iyl4EfUYIKiAK8zsaEyeisjojIzRC+cDc2PDEyRg==
X-Received: by 2002:a05:6808:bca:b0:3d5:6174:a829 with SMTP id 5614622812f47-3d564698166mr7163548b6e.2.1719534276951;
        Thu, 27 Jun 2024 17:24:36 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b7100sm321229b3a.142.2024.06.27.17.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 17:24:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 14:24:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	David Vernet <void@manifault.com>
Subject: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement
 scx_bpf_consume_task()
Message-ID: <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn4BupVa65CVayqQ@slm.duckdns.org>

Implement scx_bpf_consume_task() which allows consuming arbitrary tasks on
the DSQ in any order while iterating in the dispatch path.

scx_qmap is updated to implement periodic dumping of the shared DSQ and a
rather silly prioritization mechanism to demonstrate the use of DSQ
iteration and selective consumption.

Note that it does a bit of nastry dance to pass in the pointer to the
iterator to __scx_bpf_consume_task(). This is to work around the current
limitation in the BPF verifier where it doesn't allow the memory area used
for an iterator to be passed into kfuncs. This may be too nasty and might
require a different approach.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
---
Hello, again.

(continuing from the previous patch) so, the problem is that I need to
distinguish the tasks which have left a queue and then get requeued while an
iteration is in progress. The iterator itself already does this - it
remembers a sequence number when iteration starts and ignores tasks which
are queued afterwards.

As a task can get removed and requeued anytime, I need
scx_bpf_consume_task() to do the same testing, so I want to pass in the
iterator pointer into scx_bpf_consume_task() so that it can read the
sequence number stored in the iterator. However, BPF doesn't allow this, so
I'm doing the weird self pointer probe read thing, to obtain it, which is
quite nasty.

What do you think?

Thanks.

 kernel/sched/ext.c                       |   89 +++++++++++++++++++++++++++++--
 tools/sched_ext/include/scx/common.bpf.h |   16 +++++
 tools/sched_ext/scx_qmap.bpf.c           |   34 ++++++++++-
 tools/sched_ext/scx_qmap.c               |   14 +++-
 4 files changed, 142 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1122,6 +1122,12 @@ enum scx_dsq_iter_flags {
 };
 
 struct bpf_iter_scx_dsq_kern {
+	/*
+	 * Must be the first field. Used to work around BPF restriction and pass
+	 * in the iterator pointer to scx_bpf_consume_task().
+	 */
+	struct bpf_iter_scx_dsq_kern	*self;
+
 	struct scx_dsq_node		cursor;
 	struct scx_dispatch_q		*dsq;
 	u32				dsq_seq;
@@ -1518,7 +1524,7 @@ static void dispatch_enqueue(struct scx_
 	p->scx.dsq_seq = dsq->seq;
 
 	dsq_mod_nr(dsq, 1);
-	p->scx.dsq = dsq;
+	WRITE_ONCE(p->scx.dsq, dsq);
 
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
@@ -1611,7 +1617,7 @@ static void dispatch_dequeue(struct rq *
 		WARN_ON_ONCE(task_linked_on_dsq(p));
 		p->scx.holding_cpu = -1;
 	}
-	p->scx.dsq = NULL;
+	WRITE_ONCE(p->scx.dsq, NULL);
 
 	if (!is_local)
 		raw_spin_unlock(&dsq->lock);
@@ -2107,7 +2113,7 @@ static void consume_local_task(struct rq
 	list_add_tail(&p->scx.dsq_node.list, &rq->scx.local_dsq.list);
 	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
-	p->scx.dsq = &rq->scx.local_dsq;
+	WRITE_ONCE(p->scx.dsq, &rq->scx.local_dsq);
 	raw_spin_unlock(&dsq->lock);
 }
 
@@ -5585,12 +5591,88 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq
 	}
 }
 
+/**
+ * __scx_bpf_consume_task - Transfer a task from DSQ iteration to the local DSQ
+ * @it: DSQ iterator in progress
+ * @p: task to consume
+ *
+ * Transfer @p which is on the DSQ currently iterated by @it to the current
+ * CPU's local DSQ. For the transfer to be successful, @p must still be on the
+ * DSQ and have been queued before the DSQ iteration started. This function
+ * doesn't care whether @p was obtained from the DSQ iteration. @p just has to
+ * be on the DSQ and have been queued before the iteration started.
+ *
+ * Returns %true if @p has been consumed, %false if @p had already been consumed
+ * or dequeued.
+ */
+__bpf_kfunc bool __scx_bpf_consume_task(unsigned long it, struct task_struct *p)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct scx_dispatch_q *dsq, *kit_dsq;
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct rq *task_rq;
+	u64 kit_dsq_seq;
+
+	/* can't trust @kit, carefully fetch the values we need */
+	if (get_kernel_nofault(kit_dsq, &kit->dsq) ||
+	    get_kernel_nofault(kit_dsq_seq, &kit->dsq_seq)) {
+		scx_ops_error("invalid @it 0x%lx", it);
+		return false;
+	}
+
+	/*
+	 * @kit can't be trusted and we can only get the DSQ from @p. As we
+	 * don't know @p's rq is locked, use READ_ONCE() to access the field.
+	 * Derefing is safe as DSQs are RCU protected.
+	 */
+	dsq = READ_ONCE(p->scx.dsq);
+
+	if (unlikely(!dsq || dsq != kit_dsq))
+		return false;
+
+	if (unlikely(dsq->id == SCX_DSQ_LOCAL)) {
+		scx_ops_error("local DSQ not allowed");
+		return false;
+	}
+
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return false;
+
+	flush_dispatch_buf(dspc->rq, dspc->rf);
+
+	raw_spin_lock(&dsq->lock);
+
+	/*
+	 * Did someone else get to it? @p could have already left $dsq, got
+	 * re-enqueud, or be in the process of being consumed by someone else.
+	 */
+	if (unlikely(p->scx.dsq != dsq ||
+		     time_after64(p->scx.dsq_seq, kit_dsq_seq) ||
+		     p->scx.holding_cpu >= 0))
+		goto out_unlock;
+
+	task_rq = task_rq(p);
+
+	if (dspc->rq == task_rq) {
+		consume_local_task(dspc->rq, dsq, p);
+		return true;
+	}
+
+	if (task_can_run_on_remote_rq(p, dspc->rq))
+		return consume_remote_task(dspc->rq, dspc->rf, dsq, p, task_rq);
+
+out_unlock:
+	raw_spin_unlock(&dsq->lock);
+	return false;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_ID_FLAGS(func, __scx_bpf_consume_task)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
@@ -5797,6 +5879,7 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(str
 	INIT_LIST_HEAD(&kit->cursor.list);
 	RB_CLEAR_NODE(&kit->cursor.priq);
 	kit->cursor.flags = SCX_TASK_DSQ_CURSOR;
+	kit->self = kit;
 	kit->dsq_seq = READ_ONCE(kit->dsq->seq);
 	kit->flags = flags;
 
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -35,6 +35,7 @@ void scx_bpf_dispatch_vtime(struct task_
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+bool __scx_bpf_consume_task(unsigned long it, struct task_struct *p) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
@@ -61,6 +62,21 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 
+/*
+ * Use the following as @it when calling scx_bpf_consume_task() from whitin
+ * bpf_for_each() loops.
+ */
+#define BPF_FOR_EACH_ITER	(&___it)
+
+/* hopefully temporary wrapper to work around BPF restriction */
+static inline bool scx_bpf_consume_task(struct bpf_iter_scx_dsq *it,
+					struct task_struct *p)
+{
+	unsigned long ptr;
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), it);
+	return __scx_bpf_consume_task(ptr, p);
+}
+
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -23,6 +23,7 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
 #include <scx/common.bpf.h>
+#include <string.h>
 
 enum consts {
 	ONE_SEC_IN_NS		= 1000000000,
@@ -37,6 +38,7 @@ const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
 const volatile bool print_shared_dsq;
+const volatile u64 exp_cgid;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -121,7 +123,7 @@ struct {
 
 /* Statistics */
 u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
-u64 nr_core_sched_execed;
+u64 nr_core_sched_execed, nr_expedited;
 u32 cpuperf_min, cpuperf_avg, cpuperf_max;
 u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
@@ -260,6 +262,32 @@ static void update_core_sched_head_seq(s
 		scx_bpf_error("task_ctx lookup failed");
 }
 
+static bool consume_shared_dsq(void)
+{
+	struct task_struct *p;
+	bool consumed;
+
+	if (!exp_cgid)
+		return scx_bpf_consume(SHARED_DSQ);
+
+	/*
+	 * To demonstrate the use of scx_bpf_consume_task(), implement silly
+	 * selective priority boosting mechanism by scanning SHARED_DSQ looking
+	 * for matching comms and consume them first. This makes difference only
+	 * when dsp_batch is larger than 1.
+	 */
+	consumed = false;
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
+		if (p->cgroups->dfl_cgrp->kn->id == exp_cgid &&
+		    scx_bpf_consume_task(BPF_FOR_EACH_ITER, p)) {
+			consumed = true;
+			__sync_fetch_and_add(&nr_expedited, 1);
+		}
+	}
+
+	return consumed || scx_bpf_consume(SHARED_DSQ);
+}
+
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
@@ -268,7 +296,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 	void *fifo;
 	s32 i, pid;
 
-	if (scx_bpf_consume(SHARED_DSQ))
+	if (consume_shared_dsq())
 		return;
 
 	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
@@ -319,7 +347,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
-				scx_bpf_consume(SHARED_DSQ);
+				consume_shared_dsq();
 				return;
 			}
 			if (!cpuc->dsp_cnt)
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-E PREFIX] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -29,10 +29,11 @@ const char help_fmt[] =
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
+"  -E CGID       Expedite consumption of threads in a cgroup, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
-"  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -63,7 +64,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:Pd:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PE:d:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -86,6 +87,9 @@ int main(int argc, char **argv)
 		case 'P':
 			skel->rodata->print_shared_dsq = true;
 			break;
+		case 'E':
+			skel->rodata->exp_cgid = strtoull(optarg, NULL, 0);
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
@@ -116,10 +120,10 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64" exp=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
-		       skel->bss->nr_core_sched_execed);
+		       skel->bss->nr_core_sched_execed, skel->bss->nr_expedited);
 		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       skel->bss->cpuperf_min,

