Return-Path: <bpf+bounces-70833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198ABD59A5
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2BA3B2C71
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E262C235D;
	Mon, 13 Oct 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vLiNPVXC"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D649659
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377727; cv=none; b=CoGiGe64eY8obZPgTXS0B4EG3XiM5Rxmzx6pqIjEG4S/dzjBqcU4P//zPr+D4oMjsepkZ2rffsf9nYJ1SLBHHihTgXdth+gxYJviTOVc5fp4dH90GwI9LVsGLvXU4iU9dUsygt9245a9tSihkbRyVK/A68W6jTJUXoWML/MgE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377727; c=relaxed/simple;
	bh=JZ3RCEqrx9zVV7MZr9JKbsHGFEy/s3pgNDFLa15OMyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm52wr0tRQXwWhebk4qNMorB1MDWb4IRNGvJU7ZPbRbbgT0gXX5Wrn8rCpMAav8sZ+jQcL0sE3jHZlJQTnJxmXYZ0y2wzBpgeMb0h3OyVQU9or3uCQw/V6sd61hck3Iqxh+Wa0Bg50v8onJGjhKHvxTZhggypzFiNzlYjMdW+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vLiNPVXC; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760377713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WmnP6ICbEec27+qyu/CiHrrXy+wQUjaQxBTOOdzmdE=;
	b=vLiNPVXCYKIdbovrJm/KfG9lusZ7EzIPIrmZDWtPqLWh1Mf3MhswaTlD6Yxu4nUtuu2AGZ
	4+Xm0sq5jF8eDtmDopOviMJJgttQsxs2qzVEauY3O71Kg4Sp+w+BV8p4Oz1++JDINztbTk
	FzaGCHEmIxGUjFlv9RP+nJb66DmOivM=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next RFC 2/2] bpf: Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 01:47:21 +0800
Message-ID: <20251013174721.2681091-3-chen.dylane@linux.dev>
In-Reply-To: <20251013174721.2681091-1-chen.dylane@linux.dev>
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As Alexei noted, get_perf_callchain() return values may be reused
if a task is preempted after the BPF program enters migrate disable
mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
stack-allocated memory of bpf_perf_callchain_entry is used here.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e6e40f22826..1a51a2ea159 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -31,6 +31,11 @@ struct bpf_stack_map {
 	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
 };
 
+struct bpf_perf_callchain_entry {
+	u64 nr;
+	u64 ip[PERF_MAX_STACK_DEPTH];
+};
+
 static inline bool stack_map_use_build_id(struct bpf_map *map)
 {
 	return (map->map_flags & BPF_F_STACK_BUILD_ID);
@@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	struct bpf_perf_callchain_entry entry = { 0 };
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,12 +320,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, NULL, 0, kernel, user, max_depth,
-				   false, false);
-
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry, 0,
+				   kernel, user, max_depth, false, false);
 
 	return __bpf_get_stackid(map, trace, flags);
 }
@@ -412,6 +414,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
+	struct bpf_perf_callchain_entry entry = { 0 };
 	bool kernel = !user;
 	int err = -EINVAL;
 	u64 *ips;
@@ -451,8 +454,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, NULL, 0, kernel, user, max_depth,
-					   crosstask, false);
+		trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry, 0,
+					   kernel, user, max_depth, crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
-- 
2.48.1


