Return-Path: <bpf+bounces-27363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EB8AC736
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E4A1C218A0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5850279;
	Mon, 22 Apr 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv+V8GmX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235B1CAA1;
	Mon, 22 Apr 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775005; cv=none; b=HFLT/yVBgCm9y34d/LsBBiU95w/pYARzyIuIoeBxZc4qHaul7r6JyO1a1hao/JgnCluLMkOoW1JhkE8LUEkpgDDCu+0UHnoER+oaSBjITZV7rkrwywwcfimDM4D81FwPsNha0AiuQru+P4u1mh9xpQg5nGBkRCXH8ndEgevVoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775005; c=relaxed/simple;
	bh=LdGPKWSdxBqCVkcC4Xb/Utabt+QS/J2yF5sdnMasMKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rE4mYOD5+TBqlahfJQJpsAoRfpjrAfWudqi3TccSoPSSSr2xfe2Kd+CcrwKiT0WWVfjfYXzgr5ATbaehC+K6Wj7NWLmLLAJqUZUTaSt6IUPETovnRkLE9ru+F8EUbxJ2x8nLK/7/s/gtZY7PVzEdxuKzQN9L42qhzaPpHWxHA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv+V8GmX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so28417885ad.0;
        Mon, 22 Apr 2024 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713775003; x=1714379803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cw3bWmhYT7Pl8nwAcJrztKLEKkt9wnRRADXIvvrBpA=;
        b=Wv+V8GmX6pd5vnm+nv5Hi9T7AdIQ7gHbrNBwqsesiKmMfsBqvc/roRWKNaIzvnpv7z
         /kfWRBgHrwjqDIAeBtiXVPNiqs5UMD1iBWqulcT6Q2ORGBvuWDWGW03bp80ZuMesU0z1
         XCLhwMJvBfnd4NeOSd66SdfQcWZ8d0qTDTrxGjFo/kgRrrLG/eIDlqu+o8FC0d40on8k
         zYQ96sywh1KmUlVXHueKqjgXtOuA0kVF4kj1Xh7BSk7AdEiK9MyTV5rJbFciTloVU3c7
         emq8w5zJ5v3br0mHfV6aR0MYDatHC4NJgnz3h37cn895TSKtClxmqIwGyRDOQ9zbpDpt
         mePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775003; x=1714379803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cw3bWmhYT7Pl8nwAcJrztKLEKkt9wnRRADXIvvrBpA=;
        b=iuqbeBZRV0t/XWIeW46LIj5WBE5FcfXSVey+0y6oTd20FpmlsP7VAOG2AjL18wnX56
         1GPE3cWCJZbrpjVp7WWeMA73T7vgU0vgspVwHCx9K0rQYrh1FHelQxxx/6EIcN8tXkE5
         sZHdTiVLVGRlSyrVn+bRr/Mz6U1G1DmwgvZGiikzuIPOaRA3gj/36icgQAVCup6jcFPd
         oosunCnjqwp98I5dMLBZQ9yAzFLDiNyJJQ7tX4+T/cYbPd/GCkhPKMplwqRYId/tSQ0z
         1OEEY7qrooE8fIFaodL/x2asxtAR9EzQrproDBwCkEdVj0E7LDto3p/HNjWv3OpcOaXu
         eC+A==
X-Forwarded-Encrypted: i=1; AJvYcCWUx/9gRXZ1Mng+IaXj+K4eibkwvEYrFttFFu028VyewBe1RbFWM1iur0xNXxEPY50ubd47k+m8uq6KSPeqJwQveGDRUV2VwCvV3Zf+G4xwn68yht9C0pgMRrgudNT9G8uH4LnigCcmLCSfrdHC+c0X/Mt1jBKIolo1vJ2TacuNCc2/hQ==
X-Gm-Message-State: AOJu0YzkHTZFMCItEvfsbtwHan6g20ls+IhZkxVFSkhFRKQFdwCSQe88
	Bz/kz7oJSEuu78dBaGRTnPr/V3bx3sG0gVrdMZ2E380nJEUvDBSn
X-Google-Smtp-Source: AGHT+IFfFmqDZZx5FZTAbuntO5d72bekKOfzKoSWmvEXCyvM10IgS9AJ7Od/6Y9n2/9va4PCQ/kxtw==
X-Received: by 2002:a17:903:25cf:b0:1e0:2977:9dfc with SMTP id jc15-20020a17090325cf00b001e029779dfcmr10128223plb.55.1713775002775;
        Mon, 22 Apr 2024 01:36:42 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e89827e2e8sm6990545plb.305.2024.04.22.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:36:42 -0700 (PDT)
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
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 2/4] perf record: Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:37:03 +0800
Message-ID: <20240422083703.1931281-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_perf_event_output the off-cpu sample on sched_switch. Because most of
the time can_record() returns 0, therefore we can't collect stacks, when
stack trace is collectable, store it in stack_save for later output. If we
don't do that, most of the off-cpu samples won't have a stack trace.
Because we don't collect total off-cpu time, and stack traces are collected
in task_storage, we don't need to worry about maps getting overflow.

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


