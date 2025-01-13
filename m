Return-Path: <bpf+bounces-48665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E42A0AEB8
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 06:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FD21887257
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2C230D3A;
	Mon, 13 Jan 2025 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGDb84OK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF8248C
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745792; cv=none; b=XNOzcuShAjWbMEfkAt+MZU/N06u6/gD2pmiN7HXxJJQ/BFbTFnuCiDFPcpoW/r3IWxwlW6MrP2EEedsKys5rEhWddRT1PEaMMUMNN6APwAt+gFv1BzI4tiTV3Z6sZKafL/9wUYtOFjU6RV1PyXasmcCgUGhxvLZILzdWNXwRWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745792; c=relaxed/simple;
	bh=pQOb1PSWvkn5i2/mDD/OCElWZVdAqdPQiu1a5zPnVkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4vzpgmk0/wsRpE+rHw9HXPldKqwxE3M0uYX6ogVP27195qxNZMJvBdK4XhNYL7Fn9GICcVkHUIwNWYjfmcDSTDVoiLkADS3wBQstLX2DUg/xYYbaFaNr776rlCUarixo9gQMYPqI1aTTj7wQ569rCdi21bJbhCiYi5mxreAUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGDb84OK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21655569152so73771285ad.2
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2025 21:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745790; x=1737350590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVfSqsB1425hgeh1CCvgyoytNRCKm7B7/XnFcKeLkPw=;
        b=qGDb84OKMaH8E/XPWhfu6YqFC4903e1J0YeLAVZufEHbCQITZdpsmTI3z1RspsomWK
         pAZI5NMU0b8fY7WS60l9w2ub9l3+Q7OEU9wAJnn5bQh3Vz68IC53pFP4SYmppOBMF7Be
         tzqvqJtmS5XI6/cNy1G7kf+GXpJCnJtyHNTuUBXagolnTl4cVgg9qhx+hMzeJdr7AjGI
         f2ZUS51bNbl3sOW13M0xTbFdWEsmhxJoK0OIH6bZHvXRutudk66oyVYOJ5zdy39HFlI8
         2xFR26QVT9fk24FClofRzWQi5bHhNpDTu8w1V3rglK/IYLU+we79EPn5VDpJ2xGWxfTz
         502w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745790; x=1737350590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVfSqsB1425hgeh1CCvgyoytNRCKm7B7/XnFcKeLkPw=;
        b=ssjVDiTLN4owgSDntP48WUG8WOBXNbVV0mo5oYq1wCeTa0RxFFq1QRFlV7Dy2XdRCF
         xURNS5RzqDlAs3husbtILskGHIniCtEweWCZNxDO/ty+aWCKcIeIPxapbNk2rQetRj6J
         Ukn2/x33YBT4mNs1WsHIEurf7MkTRvbKZ/WaFJzsMQHAGj42sPMh7RBKlwnyyZtjQNl/
         OMgmxT6v2RSnhyJl3J3AyoxMl4fK+k6d14YY+gOK9Y+om2O19iq4HDBB1ITiKxkI0I4u
         4QWRoEG0uwK+riYX9SCkdcqo0gYW1b+yvTV/2Dao2HSXpIL2ElI8u8qI9wYvnSz0Fk9M
         ZBvA==
X-Forwarded-Encrypted: i=1; AJvYcCXs6y/zJLFJRQobZe7zy5a/yXtxSnSCoOFuDHXYGQAGT2i844+3h97OVqSuPfwXGwUgQIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhvzuKQTx5AjriCFaU353XzyitTclwS3t8gJCjZTzhaYY6hIJ
	aJBegDLI7Hp5kLNBjpwHCdYmfUVpAGiKFG0XL4GgazVglX9mFsnArai81/CzozaJOVv1TtbUjPl
	JjQ==
X-Google-Smtp-Source: AGHT+IEZWkENHpl86IzSgwf0OFY8eoSHS59AUCniUII1KvxAtH7cndK43/Nilx8npxLdrV5enN/fkbSZh4M=
X-Received: from pgbgb2.prod.google.com ([2002:a05:6a02:4b42:b0:86d:55d8:7944])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc7:b0:216:3b31:56c2
 with SMTP id d9443c01a7336-21a83fded24mr314809615ad.53.1736745790291; Sun, 12
 Jan 2025 21:23:10 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:15 -0800
In-Reply-To: <20250113052220.2105645-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-3-ctshao@google.com>
Subject: [PATCH v2 2/4] perf lock: Retrieve owner callstack in bpf program
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
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 152 +++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 05da19fdab23..3f47fbfa237c 100644
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
 
@@ -469,12 +528,103 @@ int contention_end(u64 *ctx)
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
+		else {
+			(otdata->count)--;
+
+			// If ctx[1] is not 0, the current task terminates lock
+			// waiting without acquiring it. Owner is not changed.
+			if (ctx[1] == 0) {
+				u32 i = 0;
+				unsigned long *entries = bpf_map_lookup_elem(
+					&owner_stacks_entries, &i);
+				if (entries) {
+					for (i = 0; i < (u32)max_stack; i++)
+						entries[i] = 0x0;
+
+					bpf_get_task_stack(
+						bpf_get_current_task_btf(),
+						entries,
+						max_stack *
+							sizeof(unsigned long),
+						0);
+					bpf_map_update_elem(
+						&contention_owner_stacks,
+						&(pelem->lock), entries,
+						BPF_ANY);
+				}
+
+				otdata->pid = pid;
+				otdata->timestamp = timestamp;
+			}
+
+			bpf_map_update_elem(&contention_owner_tracing,
+					    &(pelem->lock), otdata, BPF_ANY);
+		}
+	}
+contention_end_skip_owner_callstack:
+
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
-- 
2.47.1.688.g23fc6f90ad-goog


