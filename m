Return-Path: <bpf+bounces-47002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B519F25DC
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA21653EB
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463F1C3C1E;
	Sun, 15 Dec 2024 19:35:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC41BE251;
	Sun, 15 Dec 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291320; cv=none; b=sk/pYQ6nzXAWbEkREkMXvXi4+dkSCWp2jZADlEcWC86tMCakLFzxZEFVUxod8rs/3Hq4f39qpniMMWGeqXGSMtjCgx3YK7xgyrscypvSh0Jg4cxJM/2LInzF0q1+32pqHeCrzrccoo3lGc1F4Ldxytm3bM+YhnVMZSVik8lnIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291320; c=relaxed/simple;
	bh=5QJFnICb715EtEfnD4/BMKGHMLbpS3S4rzQYNvZ2+q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLWOfIwueQjaAUuyReG0NGGWmQvscEEjCOfkyvyPL78RV1HGjmyAbc5C9lhQMEpQVA35y1HTvfZeb3YTpBeB1rR7BVjf50kEp6mEwLrBaDeAWk+OALiLr0/WJ97O8vwRGvlrJTOxRDiaPOaOuNM0DULBLpCyFf9NMFm6lfFCkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC4631A25;
	Sun, 15 Dec 2024 11:35:44 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D27E93F528;
	Sun, 15 Dec 2024 11:35:12 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
Date: Sun, 15 Dec 2024 19:34:31 +0000
Message-Id: <20241215193436.275278-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215193436.275278-1-leo.yan@arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_perf_event_aux_pause kfunc will be used to control the Perf AUX
area to pause or resume.

An example use-case is attaching eBPF to Ftrace tracepoints.  When a
tracepoint is hit, the associated eBPF program will be executed.  The
eBPF program can invoke bpf_perf_event_aux_pause() to pause or resume
AUX trace.  This is useful for fine-grained tracing by combining
Perf and eBPF.

This commit implements the bpf_perf_event_aux_pause kfunc, and make it
pass the eBPF verifier.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/uapi/linux/bpf.h | 21 ++++++++++++++++
 kernel/bpf/verifier.c    |  2 ++
 kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..678278c91ce2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5795,6 +5795,26 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause)
+ *	Description
+ *		Pause or resume an AUX area trace associated to the perf event.
+ *
+ *		The *flags* argument is specified as the key value for
+ *		retrieving event pointer from the passed *map*.
+ *
+ *		The *pause* argument controls AUX trace pause or resume.
+ *		Non-zero values (true) are to pause the AUX trace and the zero
+ *		value (false) is for re-enabling the AUX trace.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if not found event in the events map.
+ *
+ *		**-E2BIG** if the event index passed in the *flags* parameter
+ *		is out-of-range of the map.
+ *
+ *		**-EINVAL** if the flags passed is an invalid value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6009,6 +6029,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_event_aux_pause, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09f7fa635f67..1f3acd8a7de3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9315,6 +9315,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_perf_event_output &&
 		    func_id != BPF_FUNC_skb_output &&
 		    func_id != BPF_FUNC_perf_event_read_value &&
+		    func_id != BPF_FUNC_perf_event_aux_pause &&
 		    func_id != BPF_FUNC_xdp_output)
 			goto error;
 		break;
@@ -9443,6 +9444,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_FUNC_perf_event_read:
 	case BPF_FUNC_perf_event_output:
 	case BPF_FUNC_perf_event_read_value:
+	case BPF_FUNC_perf_event_aux_pause:
 	case BPF_FUNC_skb_output:
 	case BPF_FUNC_xdp_output:
 		if (map->map_type != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 949a3870946c..a3b857f6cab4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -617,6 +617,56 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_3(bpf_perf_event_aux_pause, struct bpf_map *, map, u64, flags,
+	   u32, pause)
+{
+	unsigned long irq_flags;
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	unsigned int cpu = smp_processor_id();
+	u64 index = flags & BPF_F_INDEX_MASK;
+	struct bpf_event_entry *ee;
+	int ret = 0;
+
+	/*
+	 * Disabling interrupts avoids scheduling and race condition with
+	 * perf event enabling and disabling flow.
+	 */
+	local_irq_save(irq_flags);
+
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (index == BPF_F_CURRENT_CPU)
+		index = cpu;
+	if (unlikely(index >= array->map.max_entries)) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	ee = READ_ONCE(array->ptrs[index]);
+	if (!ee) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	perf_event_aux_pause(ee->event, pause);
+
+out:
+	local_irq_restore(irq_flags);
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_perf_event_aux_pause_proto = {
+	.func		= bpf_perf_event_aux_pause,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+};
+
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 			u64 flags, struct perf_sample_data *sd)
@@ -1565,6 +1615,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_perf_event_aux_pause:
+		return &bpf_perf_event_aux_pause_proto;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.34.1


