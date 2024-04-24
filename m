Return-Path: <bpf+bounces-27623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F08E8AFEA4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2DFB23CC1
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6AA84DF9;
	Wed, 24 Apr 2024 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYpO372l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E247F490;
	Wed, 24 Apr 2024 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926802; cv=none; b=iFYCLXCXEChWIlRBO7WOylbZ9rkb9BhqWZW/RGbbDdKZy8njMI7yNEsgcDOAaHGjtuZKvpSIMXacuq8kx4EDerjvQ9uQwRjankZ1AZSk84iSuQf8MC5X8CJYZSU15gbe1wXyRC09IFnHPlRzetARbQQZwn34p9QbDtRel6e6P+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926802; c=relaxed/simple;
	bh=Q4F/mjGL04omI/F4DnqKwPCE80jizvJK5TTsS54Tu7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF0PmuCYfwVMOdmPJ51IQGunO2gp1uAC+/VVAft9IIXOmeB8Pe8qOV+BAPsw9EPKwXuTjbOJAGSu5WCKqud3R0v6c0KarHvlj5qtfF0b6IJ4faE6WXpl33icvOLO5V4RYpoEzCHBbipZyFRjx8Z5UCMlePYv/v1za/0DKzlswHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYpO372l; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3656611a12.2;
        Tue, 23 Apr 2024 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926800; x=1714531600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQkaeKT7wGrh6q9+DS5H6+jIFHlXe8EVn0EF1bUWHFE=;
        b=GYpO372lpw/n+kyKlPWdnjzGQbuhlwowl68Rqs/ZlVaFYZ04e8XkTH5Xj22prpWIdN
         HawUvFjedaRqg+rA6xehGa9rnr7WhBCcOt4BnjcQxXLO+fStfmTidIkrDqIbJkEO5KY8
         2O6M0ExR72AZ8mOPAuJpF6qe5KtYxYOZLnjztzk2vKf3r/OEhmON/efggayREclC1Cok
         RBdFX5L5L2ibtap4XHCjkGQAN0IQiCh8mw5OGD9ApGBWKI40qeMp2i6yELsdH8NO8+d5
         7fUlK1OZilNhunIROM8q3bLtTkC/NsTfx2WZ3NQ9QmyPxhZSXmMtiI71E+y/q3A9WvZ3
         wwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926800; x=1714531600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQkaeKT7wGrh6q9+DS5H6+jIFHlXe8EVn0EF1bUWHFE=;
        b=OWYnszhbnrZiKqkRj7sXE9bWEkYVw/4XfHFZcTbQDdGvyR4BV5Ct/GACI5Gctfj69i
         S+6lwDs99MXnGUaw3K64bfl5ybOqnbmoGrY+MYv+9CaeOk/GsvZlLxMRsqM9nMSa/Msn
         1RzPwIPkFCyf+pocpWhFNiW6BhN29oLKoqoFmtmIpU3nzbifGNyXLus7I+KCBF1gRnC3
         yaMIedQNtOdkj8yIEyz0ADVkXc+cka+lBtw8HATPHAxRBsHDexcUMSXflevTPiB6IF1c
         77dSEGcjN2lcv4O8lW7fJfpYPONCyWpE7dtYpPXVxJqJ9UT95Gh/f3f3hwt/2mjU1dy3
         qD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFcwzg5hgD8ICEafCvxmAj4G+ZlxejtPGbtM7gstReJ30xTnDPidQz2gyve4bRRjjmNN9cz2XsixXcd7KwVWm6HxTsL5HDG6e5AVY+jViA6w7WK525OvnlpNdwy0W8demdpG/zHhLGqQuaKvvzEQQgIOCfjuwm6tsDU6LSlF2VLsffdw==
X-Gm-Message-State: AOJu0YxRQEdjOYentGL1E5Qx8bbd7XxalJOsNMy0BiGy4cUi/1xsQLsF
	FqeJfWTbYo1BIQkdU+svIF8sJieIJ14iPpy7hj7sY8emNYqgZp6S
X-Google-Smtp-Source: AGHT+IF8Z9K4EnFUSaYlfpVn2pahw/Hu8HZxyOI0cPtBT7B65saDGTUPHFHnzAmTWFABTscbirFncA==
X-Received: by 2002:a05:6a20:974a:b0:1ad:746:b15a with SMTP id hs10-20020a056a20974a00b001ad0746b15amr1061236pzc.47.1713926800012;
        Tue, 23 Apr 2024 19:46:40 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.143])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e604438791sm10739243plg.156.2024.04.23.19.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:46:39 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/4] perf record off-cpu: BPF perf_event_output on sched_switch
Date: Wed, 24 Apr 2024 10:48:03 +0800
Message-ID: <20240424024805.144759-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424024805.144759-1-howardchu95@gmail.com>
References: <20240424024805.144759-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_perf_event_output the off-cpu samples on sched_switch. Because most of
the time can_record() returns 0, we can't collect stacks, so when stack 
trace is collectable, store it in stack_save for later output. If we
don't do that, most of the off-cpu samples won't have a stack trace.
And since stack traces are collected in task_storage, we don't need to
worry about maps getting data overflow.

There is a threshold OUTPUT_THRESHOLD (ns) to decide the minimum off-CPU
time to trigger output, it is now set to zero. I need opinions on this
value.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 163 ++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index d877a0a9731f..81114de2436d 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -17,9 +17,13 @@
 
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
+#define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 128
+
+/* minimum offcpu time to trigger output */
+#define OUTPUT_THRESHOLD 0ULL
 
 struct tstamp_data {
-	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
 };
@@ -27,17 +31,17 @@ struct tstamp_data {
 struct offcpu_key {
 	__u32 pid;
 	__u32 tgid;
-	__u32 stack_id;
 	__u32 state;
 	__u64 cgroup_id;
 };
 
-struct {
-	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, MAX_STACKS * sizeof(__u64));
-	__uint(max_entries, MAX_ENTRIES);
-} stacks SEC(".maps");
+struct offcpu_array {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
+struct stack_array {
+	u64 array[MAX_STACKS];
+};
 
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
@@ -46,13 +50,6 @@ struct {
 	__type(value, struct tstamp_data);
 } tstamp SEC(".maps");
 
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(key_size, sizeof(struct offcpu_key));
-	__uint(value_size, sizeof(__u64));
-	__uint(max_entries, MAX_ENTRIES);
-} off_cpu SEC(".maps");
-
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
@@ -74,6 +71,34 @@ struct {
 	__uint(max_entries, 1);
 } cgroup_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, MAX_CPUS);
+} offcpu_output SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct offcpu_array));
+	__uint(max_entries, 1);
+} offcpu_data SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct stack_array));
+	__uint(max_entries, 1);
+} stack_frame SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct stack_array);
+} stack_save SEC(".maps");
+
 /* new kernel task_struct definition */
 struct task_struct___new {
 	long __state;
@@ -96,6 +121,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+u64 sample_id, sample_type;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -182,50 +209,130 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline bool check_bounds(int index)
+{
+	if (index >= 0 && index < MAX_OFFCPU_LEN)
+		return true;
+
+	return false;
+}
+
+static inline int copy_stack(struct stack_array *from,
+			     struct offcpu_array *to, int n)
+{
+	int max_stacks = MAX_STACKS, len = 0;
+
+	if (!from)
+		return len;
+
+	for (int i = 0; i < max_stacks && from->array[i]; ++i) {
+		if (check_bounds(n + 2 + i)) {
+			to->array[n + 2 + i] = from->array[i];
+			++len;
+		}
+	}
+	return len;
+}
+
 static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 			struct task_struct *next, int state)
 {
 	__u64 ts;
-	__u32 stack_id;
 	struct tstamp_data *pelem;
-
+	struct stack_array *frame, *stack_save_p;
 	ts = bpf_ktime_get_ns();
+	int zero = 0, len = 0, size;
 
 	if (!can_record(prev, state))
 		goto next;
 
-	stack_id = bpf_get_stackid(ctx, &stacks,
-				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
+	frame = bpf_map_lookup_elem(&stack_frame, &zero);
+	if (frame)
+		len = bpf_get_stack(ctx, frame->array, MAX_STACKS * sizeof(u64),
+				    BPF_F_USER_STACK) / sizeof(u64);
+
+	/* save stacks if collectable */
+	if (len > 0) {
+		stack_save_p = bpf_task_storage_get(&stack_save, prev, NULL,
+						    BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (stack_save_p)
+			for (int i = 0; i < len && i < MAX_STACKS; ++i)
+				stack_save_p->array[i] = frame->array[i];
+	}
 
 	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+
 	if (!pelem)
 		goto next;
 
 	pelem->timestamp = ts;
 	pelem->state = state;
-	pelem->stack_id = stack_id;
 
 next:
 	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
 
+	stack_save_p = bpf_task_storage_get(&stack_save, next, NULL, 0);
+
 	if (pelem && pelem->timestamp) {
 		struct offcpu_key key = {
 			.pid = next->pid,
 			.tgid = next->tgid,
-			.stack_id = pelem->stack_id,
 			.state = pelem->state,
 			.cgroup_id = needs_cgroup ? get_cgroup_id(next) : 0,
 		};
-		__u64 delta = ts - pelem->timestamp;
-		__u64 *total;
 
-		total = bpf_map_lookup_elem(&off_cpu, &key);
-		if (total)
-			*total += delta;
-		else
-			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		__u64 delta = ts - pelem->timestamp;
 
+		struct offcpu_array *data = bpf_map_lookup_elem(&offcpu_data, &zero);
+
+		if (data && delta >= OUTPUT_THRESHOLD) {
+			int n = 0;
+			int ip_pos = -1;
+
+			if (sample_type & PERF_SAMPLE_IDENTIFIER && check_bounds(n))
+				data->array[n++] = sample_id;
+			if (sample_type & PERF_SAMPLE_IP && check_bounds(n)) {
+				ip_pos = n;
+				data->array[n++] = 0;  /* will be updated */
+			}
+			if (sample_type & PERF_SAMPLE_TID && check_bounds(n))
+				data->array[n++] = (u64)key.pid << 32 | key.tgid;
+			if (sample_type & PERF_SAMPLE_TIME && check_bounds(n))
+				data->array[n++] = pelem->timestamp;
+			if (sample_type & PERF_SAMPLE_ID && check_bounds(n))
+				data->array[n++] = sample_id;
+			if (sample_type & PERF_SAMPLE_CPU && check_bounds(n))
+				data->array[n++] = 0;
+			if (sample_type & PERF_SAMPLE_PERIOD && check_bounds(n))
+				data->array[n++] = delta;
+			if (sample_type & PERF_SAMPLE_CALLCHAIN && check_bounds(n + 2)) {
+				len = 0;
+
+				/* data->array[n] is callchain->nr (updated later) */
+				data->array[n + 1] = PERF_CONTEXT_USER;
+				data->array[n + 2] = 0;
+
+				len = copy_stack(stack_save_p, data, n);
+
+				/* update length of callchain */
+				data->array[n] = len + 1;
+
+				/* update sample ip with the first callchain entry */
+				if (ip_pos >= 0)
+					data->array[ip_pos] = data->array[n + 2];
+
+				/* calculate sample callchain data->array length */
+				n += len + 2;
+			}
+			if (sample_type & PERF_SAMPLE_CGROUP && check_bounds(n))
+				data->array[n++] = key.cgroup_id;
+
+			size = n * sizeof(u64);
+			if (size >= 0 && size <= MAX_OFFCPU_LEN * sizeof(u64))
+				bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU,
+						      data, size);
+		}
 		/* prevent to reuse the timestamp later */
 		pelem->timestamp = 0;
 	}
-- 
2.44.0


