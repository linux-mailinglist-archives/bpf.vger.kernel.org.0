Return-Path: <bpf+bounces-48517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A85A08669
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 06:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779B31887B9A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 05:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E02063D5;
	Fri, 10 Jan 2025 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUpduRdZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453861E2602
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486091; cv=none; b=s5o4jRvfqYVm2Bzmg+LEw1K47AEWRDoprJAuaX1/XD77izD8GMpECjtom6xQW4VyNCshwLyANwBkYA6Aa7tN7MNEh1R2TlS0+2C8avg3lPx029PqYvag6wNu8U218J+Nkbnxm8VMyuQiMTUh0J3yexp3G3H+3m5QoVBt5t1/eLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486091; c=relaxed/simple;
	bh=pL3UPttvwqAamdvk7y1fxiypCFAuCdmicaps6Vc/fw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W98sUCD3++uRLNnvSoCsGkopsZRAyJbb6PmOa2lvukJl+oAxjxQOpIuZTB9ifCo1jUu+vUhzuMbvtmxfvbmGRVDCEbp7I+EctJhI89LarTopKY01QsQsLZi1lKbmlplLSYcFH+h4NKwqR0KvO9+QThCKEDlW32FlGiIcW3g+7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUpduRdZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso3045480a91.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 21:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486088; x=1737090888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+QuW3qojkERBxFgAAtKpSC8lsmMZ0fs08nOqEMmXh4=;
        b=lUpduRdZC01LLs6qRXqCISmXHSlNARYKsTxmw2Zy/jKn17DBm++IaeBZRYIv0LpEuO
         HZjwNmwxQQ+kb9hafK/3RIut/C87GiptImMDdt1xGzLATGdFaNQ7E/kVEizm4mkUYCRm
         UnyE5KF0osJj1xpbh60oIRsTYtGgosC5SPz0CKafFmkFpESt4ck3/zlV380EIkz707YM
         TxJfrv6O915MEcfJkwKoXaCDQS8Zp16W5mKdqOKC1y5T2gZeY0BgU6hsbiP9HVRylVN8
         Ul83Oq8Cy7S8l+b1qdLjAZt0kDKE3LHKWs5TUfQb9+43WUDyMwy/rlYnTJGnHtSk3qjD
         DNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486088; x=1737090888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+QuW3qojkERBxFgAAtKpSC8lsmMZ0fs08nOqEMmXh4=;
        b=HnKa8pUSznzt1q5J0ouXurJ46qMT5zfPMkhgXISLskiN6Vtr4xTuw3iaFMnDKnwGiw
         1Virjna3jeyrMAoOLHCI3hR0YTzjZGSQS9wd2DPAGoQbgnvYYPh3ijqThEOTugtEk5a+
         9da3rR14stii7Eg2p6GOIAcKnYZutV41qptOJQ0eMNyt/a0nvO+T1xkP8CyajHYuX44e
         oDGCCDhHDEKWRDwRKuyEQL097OVBHs3UZwbxgIAAa4TaBx+jjeirIVBmaUUFfxNeKo6B
         xHl2o/G3RN15o7bfHgmxJboD7yfrWwpMP3B4LCZZ6lJwYN4RwmqfYsoaXTVYA5286E31
         wQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXYiRla3FFJOD6IUzjQYev6En3nmez91w/8IUc4I1vVMGs1wmg2Hku8+6zpNQlKB/vRwyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSY67R3pE3DcQl78os/Dhj5kRDJVqpXCFkOEyRYIlNsPuKrwI
	SbM6+MvubLtsI7VcqJykKo8RP0b4y9/qdr8TQuo6x/r+3pInDPGamTFNTwne8kCXActVRX2Jymt
	mBw==
X-Google-Smtp-Source: AGHT+IEeJFxjwEWWMJRT06FpUTerPuPKdSR7S9ijM2J6A/cHSAmNg4rsmvpRBsTzQBlTir1BIEVJZB+mAD0=
X-Received: from pjbta14.prod.google.com ([2002:a17:90b:4ece:b0:2ef:79ee:65c0])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540b:b0:2ee:d824:b559
 with SMTP id 98e67ed59e1d1-2f548f44e6bmr13360936a91.28.1736486088638; Thu, 09
 Jan 2025 21:14:48 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:42 -0800
In-Reply-To: <20250110051346.1507178-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-3-ctshao@google.com>
Subject: [PATCH v1 2/4] perf lock: Retrieve owner callstack in bpf program
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tracing owner callstack in `contention_begin()` and `contention_end()`,
and storing in `owner_lock_stat` bpf map.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 149 +++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 05da19fdab23..79b641d7beb2 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -7,6 +7,7 @@
 #include <asm-generic/errno-base.h>
 
 #include "lock_data.h"
+#include <time.h>
 
 /* for collect_lock_syms().  4096 was rejected by the verifier */
 #define MAX_CPUS  1024
@@ -178,6 +179,9 @@ int data_fail;
 int task_map_full;
 int data_map_full;
 
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
 static inline __u64 get_current_cgroup_id(void)
 {
 	struct task_struct *task;
@@ -407,6 +411,60 @@ int contention_begin(u64 *ctx)
 	pelem->flags = (__u32)ctx[1];
 
 	if (needs_callstack) {
+		u32 i = 0;
+		int owner_pid;
+		unsigned long *entries;
+		struct task_struct *task;
+		cotd *data;
+
+		if (!lock_owner)
+			goto contention_begin_skip_owner_callstack;
+
+		task = get_lock_owner(pelem->lock, pelem->flags);
+		if (!task)
+			goto contention_begin_skip_owner_callstack;
+
+		owner_pid = BPF_CORE_READ(task, pid);
+
+		entries = bpf_map_lookup_elem(&owner_stacks_entries, &i);
+		if (!entries)
+			goto contention_begin_skip_owner_callstack;
+		for (i = 0; i < max_stack; i++)
+			entries[i] = 0x0;
+
+		task = bpf_task_from_pid(owner_pid);
+		if (task) {
+			bpf_get_task_stack(task, entries,
+					   max_stack * sizeof(unsigned long),
+					   0);
+			bpf_task_release(task);
+		}
+
+		data = bpf_map_lookup_elem(&contention_owner_tracing,
+					   &(pelem->lock));
+
+		// Contention just happens, or corner case `lock` is owned by
+		// process not `owner_pid`.
+		if (!data || data->pid != owner_pid) {
+			cotd first = {
+				.pid = owner_pid,
+				.timestamp = pelem->timestamp,
+				.count = 1,
+			};
+			bpf_map_update_elem(&contention_owner_tracing,
+					    &(pelem->lock), &first, BPF_ANY);
+			bpf_map_update_elem(&contention_owner_stacks,
+					    &(pelem->lock), entries, BPF_ANY);
+		}
+		// Contention is going on and new waiter joins.
+		else {
+			__sync_fetch_and_add(&data->count, 1);
+			// TODO: Since for owner the callstack would change at
+			// different time, We should check and report if the
+			// callstack is different with the recorded one in
+			// `contention_owner_stacks`.
+		}
+contention_begin_skip_owner_callstack:
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
@@ -443,6 +501,7 @@ int contention_end(u64 *ctx)
 	struct tstamp_data *pelem;
 	struct contention_key key = {};
 	struct contention_data *data;
+	__u64 timestamp;
 	__u64 duration;
 	bool need_delete = false;
 
@@ -469,12 +528,100 @@ int contention_end(u64 *ctx)
 			return 0;
 		need_delete = true;
 	}
-	duration = bpf_ktime_get_ns() - pelem->timestamp;
+	timestamp = bpf_ktime_get_ns();
+	duration = timestamp - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		__sync_fetch_and_add(&time_fail, 1);
 		goto out;
 	}
 
+	if (needs_callstack && lock_owner) {
+		u64 owner_contention_time;
+		unsigned long *owner_stack;
+		struct contention_data *cdata;
+		cotd *otdata;
+
+		otdata = bpf_map_lookup_elem(&contention_owner_tracing,
+					     &(pelem->lock));
+		owner_stack = bpf_map_lookup_elem(&contention_owner_stacks,
+						  &(pelem->lock));
+		if (!otdata || !owner_stack)
+			goto contention_end_skip_owner_callstack;
+
+		owner_contention_time = timestamp - otdata->timestamp;
+
+		// Update `owner_lock_stat` if `owner_stack` is
+		// available.
+		if (owner_stack[0] != 0x0) {
+			cdata = bpf_map_lookup_elem(&owner_lock_stat,
+						    owner_stack);
+			if (!cdata) {
+				struct contention_data first = {
+					.total_time = owner_contention_time,
+					.max_time = owner_contention_time,
+					.min_time = owner_contention_time,
+					.count = 1,
+					.flags = pelem->flags,
+				};
+				bpf_map_update_elem(&owner_lock_stat,
+						    owner_stack, &first,
+						    BPF_ANY);
+			} else {
+				__sync_fetch_and_add(&cdata->total_time,
+						     owner_contention_time);
+				__sync_fetch_and_add(&cdata->count, 1);
+
+				/* FIXME: need atomic operations */
+				if (cdata->max_time < owner_contention_time)
+					cdata->max_time = owner_contention_time;
+				if (cdata->min_time > owner_contention_time)
+					cdata->min_time = owner_contention_time;
+			}
+		}
+
+		// `pid` in `otdata` is not lock owner anymore, delete
+		// this entry.
+		bpf_map_delete_elem(&contention_owner_stacks, &(otdata->pid));
+
+		//  No contention is going on, delete `lock` in
+		//  `contention_owner_tracing` and
+		//  `contention_owner_stacks`
+		if (otdata->count <= 1) {
+			bpf_map_delete_elem(&contention_owner_tracing,
+					    &(pelem->lock));
+			bpf_map_delete_elem(&contention_owner_stacks,
+					    &(pelem->lock));
+		}
+		// Contention is still going on, with a new owner
+		// (current task). `otdata` should be updated accordingly.
+		// If ctx[1] is not 0, the current task terminate lock waiting
+		// without acquiring it.
+		else if (ctx[1] == 0) {
+			unsigned long *entries;
+			u32 i = 0;
+
+			otdata->pid = pid;
+			otdata->timestamp = timestamp;
+			(otdata->count)--;
+			bpf_map_update_elem(&contention_owner_tracing,
+					    &(pelem->lock), otdata, BPF_ANY);
+
+			entries =
+				bpf_map_lookup_elem(&owner_stacks_entries, &i);
+			if (!entries)
+				goto contention_end_skip_owner_callstack;
+			for (i = 0; i < (u32)max_stack; i++)
+				entries[i] = 0x0;
+
+			bpf_get_task_stack(bpf_get_current_task_btf(), entries,
+					   max_stack * sizeof(unsigned long),
+					   0);
+			bpf_map_update_elem(&contention_owner_stacks,
+					    &(pelem->lock), entries, BPF_ANY);
+		}
+	}
+contention_end_skip_owner_callstack:
+
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
-- 
2.47.1.688.g23fc6f90ad-goog


