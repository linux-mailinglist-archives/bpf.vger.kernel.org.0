Return-Path: <bpf+bounces-51316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C511A332A0
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B53A9292
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546881FFC59;
	Wed, 12 Feb 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwVcVAkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DC2036F4
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399415; cv=none; b=APn6lvgDZaQdVAqvBd9CiYi7t78iNoWg2RC1yWpxfi1FT2kvDx1t1Bv0ytP6ar6WrJ1xYCEduzvvhUSI2DzTpTCei0RXpIYCU69Vh171+ObackJUTvgT16hiH8RO+ADykL2gLOQYuHiN/90z+f7tes9bVYgNL85T1Wic5QHbFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399415; c=relaxed/simple;
	bh=VMSWxcNmO8no8BHLvLxOhA30OkINBXw7JvnooWa9Ev0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=heil3n0aVLsN2S+2iDoA4idJCJ04H1o7Yz80INv03XgOCuJ5FgccR9blfYHdSDEAUGnVAD4ISvxSBAOZCLej6Swekg5RuxW26kuLEuBbUHk6TN7myQXszbNrRXbNuY7OpBGKYx04MGAkQMVuL/eh7nVDJObmX8zX35vkqzlYf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwVcVAkh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa44233a04so535617a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399413; x=1740004213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSbEcYPaOo1Mf2YKv2LhLfOPLMl0BBUQrr31+aE8g7M=;
        b=ZwVcVAkhqLlD4gZvCjKDKd20hHDT6BBOMO+LEVO6RqsGH7EZIdVYWg4C4I/YADE9Ff
         /XEekpHIjf4KOM8EOvh+0SgB1IPZdGyWVNBf1wiAWBmG/l1QQnrW4R5v1SSGsCzU/u4F
         43z9FdkKk3sLaHdo+brKT0ths0y9xoYbc3rf8U7+oOIQ5vml77HQ518SYNWnm4wD9x4/
         Zy2/QC/WHL3WazjC/DaCUtClMTTO5xVYq810wOQKfkqosPITdsPj+fSiBTZu+X6rUYkK
         VyneeZyOTsfAP+I/skZLnJLMPwwBRqBA7OuMKe4ETh8lHWTPKdOQpjBZnSL73v5GRV6X
         h9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399413; x=1740004213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSbEcYPaOo1Mf2YKv2LhLfOPLMl0BBUQrr31+aE8g7M=;
        b=oZZtwkesSMrrm4YEy/zDXy139XejlcLPcY3g/i1HfirF5lHTdmL5l+Q7mVRSdBRtn0
         SWhZRkk3G+/srIblHv4nJt66pEm7j2K+IzXHz4CPps+nWEFxfQlhjL8m4ouPCGr/+naK
         I+vnFNYZ5W3uuAvcwQAfe05abgRmiLH4vQkez4HsRgKgOrMnE6bOBLOd9SaYq17GN2mo
         4FdZYaL+jvCUgVLNQ0y5QajEOcN/pT9WE7QjWBwwaui1QVgKJq1b8CW45r7YR1DP8YlM
         QduuDP61mskP/xYC61VzJ3hcEet0KN9EskFm0PgucazEe+xIYT4dnU4OINrF/BXrfEpn
         SF5A==
X-Forwarded-Encrypted: i=1; AJvYcCV+e1MxEduMDpT9n0Ht+Ma/PTfVp/97thCX+xlY3EGZ5cSPkp+U3RGY4i5+BwlaK24tAE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwmK2srXMYockuRmbu2zEKOSSsOrcY+w7CL9Gw0VViNhjDi5p
	a7GE6VKsStU05hu9uwYXCV/qQGoMaVJCyLq2sMYlVSm9C/34ZglcJZVW78mvbfjbnyb7jg6pPx+
	CFQ==
X-Google-Smtp-Source: AGHT+IGFKaRYCnm24tciFSPM+jbVn6VUGWLylTtEWjxKMVSlIzJwJ3A/SpYnvLm+ugPwNJmzcDUVpDjNFW4=
X-Received: from pjur15.prod.google.com ([2002:a17:90a:d40f:b0:2f6:e47c:1747])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec84:b0:2f4:f7f8:fc8b
 with SMTP id 98e67ed59e1d1-2fc0f0b05a8mr1269502a91.27.1739399413221; Wed, 12
 Feb 2025 14:30:13 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:53 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-3-ctshao@google.com>
Subject: [PATCH v5 2/5] perf lock: Retrieve owner callstack in bpf program
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This implements per-callstack aggregation of lock owners in addition to
per-thread.  The owner callstack is captured using `bpf_get_task_stack()`
at `contention_begin()` and it also adds a custom stackid function for the
owner stacks to be compared easily.

The owner info is kept in a hash map using lock addr as a key to handle
multiple waiters for the same lock.  At `contention_end()`, it updates the
owner lock stat based on the info that was saved at `contention_begin()`.
If there are more waiters, it'd update the owner pid to itself as
`contention_end()` means it gets the lock now.  But it also needs to check
the return value of the lock function in case task was killed by a signal
or something.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 218 +++++++++++++++++-
 1 file changed, 209 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 23fe9cc980ae..e8b113d5802a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -197,6 +197,9 @@ int data_fail;
 int task_map_full;
 int data_map_full;

+struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
+void bpf_task_release(struct task_struct *p) __ksym __weak;
+
 static inline __u64 get_current_cgroup_id(void)
 {
 	struct task_struct *task;
@@ -420,6 +423,61 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 	return pelem;
 }

+static inline s32 get_owner_stack_id(u64 *stacktrace)
+{
+	s32 *id, new_id;
+	static s64 id_gen = 1;
+
+	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
+	if (id)
+		return *id;
+
+	new_id = (s32)__sync_fetch_and_add(&id_gen, 1);
+
+	bpf_map_update_elem(&owner_stacks, stacktrace, &new_id, BPF_NOEXIST);
+
+	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
+	if (id)
+		return *id;
+
+	return -1;
+}
+
+static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
+{
+	__sync_fetch_and_add(&data->total_time, duration);
+	__sync_fetch_and_add(&data->count, count);
+
+	/* FIXME: need atomic operations */
+	if (data->max_time < duration)
+		data->max_time = duration;
+	if (data->min_time > duration)
+		data->min_time = duration;
+}
+
+static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
+{
+	struct contention_key key = {
+		.stack_id = id,
+		.pid = 0,
+		.lock_addr_or_cgroup = 0,
+	};
+	struct contention_data *data = bpf_map_lookup_elem(&owner_stat, &key);
+
+	if (!data) {
+		struct contention_data first = {
+			.total_time = duration,
+			.max_time = duration,
+			.min_time = duration,
+			.count = 1,
+			.flags = flags,
+		};
+		bpf_map_update_elem(&owner_stat, &key, &first, BPF_NOEXIST);
+	} else {
+		update_contention_data(data, duration, 1);
+	}
+}
+
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -437,6 +495,72 @@ int contention_begin(u64 *ctx)
 	pelem->flags = (__u32)ctx[1];

 	if (needs_callstack) {
+		u32 i = 0;
+		u32 id = 0;
+		int owner_pid;
+		u64 *buf;
+		struct task_struct *task;
+		struct owner_tracing_data *otdata;
+
+		if (!lock_owner)
+			goto skip_owner;
+
+		task = get_lock_owner(pelem->lock, pelem->flags);
+		if (!task)
+			goto skip_owner;
+
+		owner_pid = BPF_CORE_READ(task, pid);
+
+		buf = bpf_map_lookup_elem(&stack_buf, &i);
+		if (!buf)
+			goto skip_owner;
+		for (i = 0; i < max_stack; i++)
+			buf[i] = 0x0;
+
+		if (!bpf_task_from_pid)
+			goto skip_owner;
+
+		task = bpf_task_from_pid(owner_pid);
+		if (!task)
+			goto skip_owner;
+
+		bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
+		bpf_task_release(task);
+
+		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
+		id = get_owner_stack_id(buf);
+
+		/*
+		 * Contention just happens, or corner case `lock` is owned by process not
+		 * `owner_pid`. For the corner case we treat it as unexpected internal error and
+		 * just ignore the precvious tracing record.
+		 */
+		if (!otdata || otdata->pid != owner_pid) {
+			struct owner_tracing_data first = {
+				.pid = owner_pid,
+				.timestamp = pelem->timestamp,
+				.count = 1,
+				.stack_id = id,
+			};
+			bpf_map_update_elem(&owner_data, &pelem->lock, &first, BPF_ANY);
+		}
+		/* Contention is ongoing and new waiter joins */
+		else {
+			__sync_fetch_and_add(&otdata->count, 1);
+
+			/*
+			 * The owner is the same, but stacktrace might be changed. In this case we
+			 * store/update `owner_stat` based on current owner stack id.
+			 */
+			if (id != otdata->stack_id) {
+				update_owner_stat(id, pelem->timestamp - otdata->timestamp,
+						  pelem->flags);
+
+				otdata->timestamp = pelem->timestamp;
+				otdata->stack_id = id;
+			}
+		}
+skip_owner:
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
@@ -473,6 +597,7 @@ int contention_end(u64 *ctx)
 	struct tstamp_data *pelem;
 	struct contention_key key = {};
 	struct contention_data *data;
+	__u64 timestamp;
 	__u64 duration;
 	bool need_delete = false;

@@ -500,12 +625,94 @@ int contention_end(u64 *ctx)
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
+		struct owner_tracing_data *otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
+
+		if (!otdata)
+			goto skip_owner;
+
+		/* Update `owner_stat` */
+		update_owner_stat(otdata->stack_id, timestamp - otdata->timestamp, pelem->flags);
+
+		/* No contention is occurring, delete `lock` entry in `owner_data` */
+		if (otdata->count <= 1)
+			bpf_map_delete_elem(&owner_data, &pelem->lock);
+		/*
+		 * Contention is still ongoing, with a new owner (current task). `owner_data`
+		 * should be updated accordingly.
+		 */
+		else {
+			u32 i = 0;
+			s32 ret = (s32)ctx[1];
+			u64 *buf;
+
+			__sync_fetch_and_add(&otdata->count, -1);
+
+			buf = bpf_map_lookup_elem(&stack_buf, &i);
+			if (!buf)
+				goto skip_owner;
+			for (i = 0; i < (u32)max_stack; i++)
+				buf[i] = 0x0;
+
+			/*
+			 * `ret` has the return code of the lock function.
+			 * If `ret` is negative, the current task terminates lock waiting without
+			 * acquiring it. Owner is not changed, but we still need to update the owner
+			 * stack.
+			 */
+			if (ret < 0) {
+				s32 id = 0;
+				struct task_struct *task;
+
+				if (!bpf_task_from_pid)
+					goto skip_owner;
+
+				task = bpf_task_from_pid(otdata->pid);
+				if (!task)
+					goto skip_owner;
+
+				bpf_get_task_stack(task, buf,
+						   max_stack * sizeof(unsigned long), 0);
+				bpf_task_release(task);
+
+				id = get_owner_stack_id(buf);
+
+				/*
+				 * If owner stack is changed, update `owner_data` and `owner_stat`
+				 * accordingly.
+				 */
+				if (id != otdata->stack_id) {
+					update_owner_stat(id, pelem->timestamp - otdata->timestamp,
+							  pelem->flags);
+
+					otdata->timestamp = pelem->timestamp;
+					otdata->stack_id = id;
+				}
+			}
+			/*
+			 * Otherwise, update tracing data with the current task, which is the new
+			 * owner.
+			 */
+			else {
+				otdata->pid = pid;
+				otdata->timestamp = timestamp;
+				/*
+				 * We don't want to retrieve callstack here, since it is where the
+				 * current task acquires the lock and provides no additional
+				 * information. We simply assign -1 to invalidate it.
+				 */
+				otdata->stack_id = -1;
+			}
+		}
+	}
+skip_owner:
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
@@ -589,14 +796,7 @@ int contention_end(u64 *ctx)
 	}

 found:
-	__sync_fetch_and_add(&data->total_time, duration);
-	__sync_fetch_and_add(&data->count, 1);
-
-	/* FIXME: need atomic operations */
-	if (data->max_time < duration)
-		data->max_time = duration;
-	if (data->min_time > duration)
-		data->min_time = duration;
+	update_contention_data(data, duration, 1);

 out:
 	pelem->lock = 0;
--
2.48.1.502.g6dc24dfdaf-goog


