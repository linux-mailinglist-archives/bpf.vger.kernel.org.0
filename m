Return-Path: <bpf+bounces-50104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB5A22886
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6353D18874E6
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A517B425;
	Thu, 30 Jan 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6CDnoLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EF81459E4
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214851; cv=none; b=Z+9WbdtuhUqmwT/Q1ZAVoOTXMIlkKXwtXt/7G/T3M7LFxMvZSvn5GeOCTL02ThgFYwlFRiujrjPhKEcvGHI4TwgBQEqsQjExXxPT3ETHwx4x79v0clbJwxrddAiqVAo7ISjw7ELM2/pJlyC8MNsAW5PKWXe1DoY5YI4AOhsFahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214851; c=relaxed/simple;
	bh=BWJLdGUi3DR8nqjtgdxUOkT7XFxiMervC05OPrIGTOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOKBppIRG6doEkv4SKNg5wBnGicKfJSNBug9KiwZvhfufkkB+fwhREIEu+mYMdxTnmUZilKFTQWQzmiKJ3stQPgNjZ1iCki4c0jWZahXbcDlCy6PH9GdtJhaPGk9NO/e5ydxhbdJj7gCgh+HvACa/0jR3LnncWi+2E14T0qz3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6CDnoLw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso839554a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214848; x=1738819648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eoz4oz6QTxUbKv6q8SfAmVVJoB+ud0WDRT/FEIrl2tc=;
        b=E6CDnoLwG2BGXgHus8u5jjCm6cA0ecgdBDlbk82NLpIpb63CIPs9Vt/DDmqjJmrPWk
         P52uheH25g+VfqYBBiYCuNhQcec4plWadqtDCKgFeKoP3fxAY2v87t5G1zG4BXZVjlMq
         C+lXnvV3NaP8afoKqe64+PmtbfZZdJ1bPJQUnoshqPfLB6yObsikhumonNzhupOrekdb
         rl+mEEHeRzakFzSss/UNQBdB2D2rafqNdo8Lvqyi11hcKrPF69WXyPUv6JKz3TdEV6dm
         TQ6AUBszhsTrYRCLy8JXg4twJf8rREvHYCXjullA4/cPtbz0psVHSJNigfR0P9rksw/M
         Ig2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214848; x=1738819648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eoz4oz6QTxUbKv6q8SfAmVVJoB+ud0WDRT/FEIrl2tc=;
        b=lf/wyfmU9lL3BSxlyhBezeO/Q3xNK263LDOyM6V6jxiL2DDVLcrK4iUPTDiq5hl+0s
         8JwHCSttyoFF0MOYJFLtQgMsFCvu2OUjV+q6MZxpafHnl+m8YzHqN4WLYKGC3JQFidI2
         /E3D2l4lekTmYBI16QqFgweEPvZA6unGoWq4iVdWsKFGWBGfnGoTwpew2a1u+ufTE48b
         1WZpeis9kzSvlb32Urg9filsZGxA/Cn5fWUKMy8qvX2HoSasHwd900t43QQfoAoGr42L
         kXcN2JA86KAt4KhPWj5F0xvEoH+jS0E1fRjyK89djufYtjgjCfu9RCGSEut8mioYv55s
         g8yg==
X-Forwarded-Encrypted: i=1; AJvYcCVibEzWeOISdI1c0i/RZPWBQPVb4/39RN4ZsAiWv6kZbyjE2BzbTpaJ/wp88gHPMmNVswE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Rdxf2wOMh30doKV3zUbSFqQi1Wckb1msWmeqb4KFXw/+SPDu
	kNkEABJYxofnAEqYcNIKqO0Vl4km0W/8CL5k7XbLFSVlUC5F2KcyuQxfbHmnKVvtlU5xC6V00Ci
	wDA==
X-Google-Smtp-Source: AGHT+IEp83k/grfwaYq18R2r97tjxPvE5EzL6rrbuFZMp0feyMOdZ7+5wQ3HO7vFOBbKXK/kNVnwCR1Bnzs=
X-Received: from pjbtc5.prod.google.com ([2002:a17:90b:5405:b0:2e2:9f67:1ca3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2749:b0:2ee:ba84:5cac
 with SMTP id 98e67ed59e1d1-2f83abab6b5mr9464321a91.7.1738214848248; Wed, 29
 Jan 2025 21:27:28 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:36 -0800
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-3-ctshao@google.com>
Subject: [PATCH v4 2/5] perf lock: Retrieve owner callstack in bpf program
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tracks lock contention by tracing owner callstacks in
`contention_begin()` and `contention_end()`, storing data in the
owner_stat BPF map. `contention_begin()` records the owner and their
callstack. `contention_end()` updates contention statistics (count,
time), decrements the waiter count, and removes the record when no
waiters remain. Statistics are also updated if the owner's callstack
changes. Note that owner and its callstack retrieval may fail.

To elaborate the process in detail:
  /*
   * In `contention_begin(), the current task is the lock waiter`. We
   * create/update `owner_data` for the given `lock` address.
  contention_begin() {
    Try to get owner task. Skip entire process if fails.
    Try to get owner stack based on task. Use empty stack if fails.
    Store owner stack into `owner_stacks` and create `stack_id`. If fail
      to store, use negative `stack_id`, which will be ignored while
      reporting in usermode.
    Retrieve `owner_tracing_data` in `owner_data` with given `lock`
      address.

    /*
     * The first case means contention just happens, or mismatched owner
     * infomation so we just drop the previous record.
     */
    if (`owner_tracing_data` does not exist ||
        the recorded owner `pid` does not match with the detected owner) {
      Create `owner_tracing_data` with info from detected owner, and
        store it in `owner_data` with key `lock` address.
    }
    /*
     * The second case means contention is on going. One more waiter is
     * joining the lock contention. Both `owner_data` and `owner_stat`
     * should be updated.
     */
    else {
      `owner_tracing_data.count`++

      Create `contention_key` with owner `stack_id` and lookup
        `contention_data` in `owner_stat`.
      if (`contention_data` does not exist) {
        Create new entry for `contention_key`:`contention_data` in
          `owner_stat`.
      }
      else {
        Update the `count` and `total_time` in existing
        `contention_data`.
      }

      Update `timestamp` and `stack_id` in `owner_tracing_data`.
    }
  }

  /*
   * In `contention_end()`, the current task will be the new owner of
   * the `lock`, if `ctx[1]` is not 0.
   */
  contention_end() {
    Lookup `owner_tracing_data` in `owner_data` with key `lock`.

    Create `contention_key` with `owner_tracing_data.stack_id` and
      lookup `contention_data` in `owner_stat`.
    if (`contention_data` does not exist) {
      Create new entry for `contention_key`:`contention_data` in
        `owner_stat`.
    }
    else {
      Update the `count` and `total_time` in existing `contention_data`.
    }

    /*
     * There is no more waiters, contention is over, delete the record.
     */
    if (`owner_tracing_data.count` <= 1) {
      delete this record in `owner_data`.
    }
    /*
     * Contention is still on going.
     */
    else {
      `owner_tracing_data.count`--

      if (`!ctx[0]`) {
        The current task exits without acquiring the lock. However we
          check for the recorded owner if the stack is changed, and
          update `onwer_data` and `owner_stat` accordingly.
      }
      else {
        The current task is the new owner, retrieve its stack, store it
          in `owner_stack` and update `owner_tracing_data`.
      }
    }
  }

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 248 +++++++++++++++++-
 1 file changed, 247 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 23fe9cc980ae..b12df873379f 100644
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
@@ -420,6 +423,26 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
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
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -437,6 +460,97 @@ int contention_begin(u64 *ctx)
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
+			goto skip_owner_begin;
+
+		task = get_lock_owner(pelem->lock, pelem->flags);
+		if (!task)
+			goto skip_owner_begin;
+
+		owner_pid = BPF_CORE_READ(task, pid);
+
+		buf = bpf_map_lookup_elem(&stack_buf, &i);
+		if (!buf)
+			goto skip_owner_begin;
+		for (i = 0; i < max_stack; i++)
+			buf[i] = 0x0;
+
+		if (bpf_task_from_pid) {
+			task = bpf_task_from_pid(owner_pid);
+			if (task) {
+				bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
+				bpf_task_release(task);
+			}
+		}
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
+				u64 duration = otdata->timestamp - pelem->timestamp;
+				struct contention_key ckey = {
+					.stack_id = id,
+					.pid = 0,
+					.lock_addr_or_cgroup = 0,
+				};
+				struct contention_data *cdata =
+					bpf_map_lookup_elem(&owner_stat, &ckey);
+
+				if (!cdata) {
+					struct contention_data first = {
+						.total_time = duration,
+						.max_time = duration,
+						.min_time = duration,
+						.count = 1,
+						.flags = pelem->flags,
+					};
+					bpf_map_update_elem(&owner_stat, &ckey, &first,
+							    BPF_NOEXIST);
+				} else {
+					__sync_fetch_and_add(&cdata->total_time, duration);
+					__sync_fetch_and_add(&cdata->count, 1);
+
+					/* FIXME: need atomic operations */
+					if (cdata->max_time < duration)
+						cdata->max_time = duration;
+					if (cdata->min_time > duration)
+						cdata->min_time = duration;
+				}
+
+				otdata->timestamp = pelem->timestamp;
+				otdata->stack_id = id;
+			}
+		}
+skip_owner_begin:
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
@@ -473,6 +587,7 @@ int contention_end(u64 *ctx)
 	struct tstamp_data *pelem;
 	struct contention_key key = {};
 	struct contention_data *data;
+	__u64 timestamp;
 	__u64 duration;
 	bool need_delete = false;
 
@@ -500,12 +615,143 @@ int contention_end(u64 *ctx)
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
+		u64 owner_time;
+		struct contention_key ckey = {};
+		struct contention_data *cdata;
+		struct owner_tracing_data *otdata;
+
+		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
+		if (!otdata)
+			goto skip_owner_end;
+
+		/* Update `owner_stat` */
+		owner_time = timestamp - otdata->timestamp;
+		ckey.stack_id = otdata->stack_id;
+		cdata = bpf_map_lookup_elem(&owner_stat, &ckey);
+
+		if (!cdata) {
+			struct contention_data first = {
+				.total_time = owner_time,
+				.max_time = owner_time,
+				.min_time = owner_time,
+				.count = 1,
+				.flags = pelem->flags,
+			};
+			bpf_map_update_elem(&owner_stat, &ckey, &first, BPF_NOEXIST);
+		} else {
+			__sync_fetch_and_add(&cdata->total_time, owner_time);
+			__sync_fetch_and_add(&cdata->count, 1);
+
+			/* FIXME: need atomic operations */
+			if (cdata->max_time < owner_time)
+				cdata->max_time = owner_time;
+			if (cdata->min_time > owner_time)
+				cdata->min_time = owner_time;
+		}
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
+			u64 *buf;
+
+			__sync_fetch_and_add(&otdata->count, -1);
+
+			buf = bpf_map_lookup_elem(&stack_buf, &i);
+			if (!buf)
+				goto skip_owner_end;
+			for (i = 0; i < (u32)max_stack; i++)
+				buf[i] = 0x0;
+
+			/*
+			 * ctx[1] has the return code of the lock function.
+			 * If ctx[1] is not 0, the current task terminates lock waiting without
+			 * acquiring it. Owner is not changed, but we still need to update the owner
+			 * stack.
+			 */
+			if (!ctx[1]) {
+				s32 id = 0;
+				struct task_struct *task = NULL;
+
+				if (bpf_task_from_pid)
+					task = bpf_task_from_pid(otdata->pid);
+
+				if (task) {
+					bpf_get_task_stack(task, buf,
+							   max_stack * sizeof(unsigned long), 0);
+					bpf_task_release(task);
+				}
+
+				id = get_owner_stack_id(buf);
+
+				/*
+				 * If owner stack is changed, update `owner_data` and `owner_stat`
+				 * accordingly.
+				 */
+				if (id != otdata->stack_id) {
+					u64 duration = otdata->timestamp - pelem->timestamp;
+					struct contention_key ckey = {
+						.stack_id = id,
+						.pid = 0,
+						.lock_addr_or_cgroup = 0,
+					};
+					struct contention_data *cdata =
+						bpf_map_lookup_elem(&owner_stat, &ckey);
+
+					if (!cdata) {
+						struct contention_data first = {
+							.total_time = duration,
+							.max_time = duration,
+							.min_time = duration,
+							.count = 1,
+							.flags = pelem->flags,
+						};
+						bpf_map_update_elem(&owner_stat, &ckey, &first,
+								    BPF_NOEXIST);
+					} else {
+						__sync_fetch_and_add(&cdata->total_time, duration);
+						__sync_fetch_and_add(&cdata->count, 1);
+
+						/* FIXME: need atomic operations */
+						if (cdata->max_time < duration)
+							cdata->max_time = duration;
+						if (cdata->min_time > duration)
+							cdata->min_time = duration;
+					}
+
+					otdata->timestamp = pelem->timestamp;
+					otdata->stack_id = id;
+				}
+			}
+			/*
+			 * If ctx[1] is 0, then update tracinng data with the current task, which is
+			 * the new owner.
+			 */
+			else {
+				otdata->pid = pid;
+				otdata->timestamp = timestamp;
+
+				bpf_get_task_stack(bpf_get_current_task_btf(), buf,
+						   max_stack * sizeof(unsigned long), 0);
+				otdata->stack_id = get_owner_stack_id(buf);
+			}
+		}
+	}
+skip_owner_end:
+
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
-- 
2.48.1.362.g079036d154-goog


