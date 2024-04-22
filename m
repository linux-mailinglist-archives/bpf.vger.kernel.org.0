Return-Path: <bpf+bounces-27357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA68AC657
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FC9283042
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E85029E;
	Mon, 22 Apr 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9vJWVfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AF4E1D1;
	Mon, 22 Apr 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773336; cv=none; b=gqBqO/gWjpQlrF6NTUBbKKTR+N9vFZjicDNRD9T8Nf+0nVuOp9Bzj7TDf0IqShCprUAUTrn1HF/m6Yy18WRRhwVYYFbm8dHPMsrggweDxfyKVQTy0c8kXeF595fk909BDsyIuxPkELk1aZwyX1IYSzveORl6nHB0wLYy557ibaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773336; c=relaxed/simple;
	bh=kUI808mePhRZHwg9ymVLzvgutA/xQJuf3RrktNQ3Tho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piFuO8aNqdV/PlRiC3e5CiZnfQNIcB8N6nugioMT7VmGe55/iM475M/quAp1Bx76bOjBA6BEEGkT2QqgJ6mOpuSzSmLxbvhPJ1R8JYWcGAx9qe3b9KRVRhXsG8nQPXyIQa/Aj+kYW653rSa/S1j/b2wVhlSwEwUqKJCPhoRnKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9vJWVfe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a58209b159so2544501a91.3;
        Mon, 22 Apr 2024 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773334; x=1714378134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YOWqoUrVrzd78R6ZnWxTyIXa2oV+7yQhabwhKzd1GY=;
        b=I9vJWVfeTiqwdQyCHC8jGmqDxnNUwDIA7Wcizm6vqbQuTR5wb2/wtrwCc2JCF1WAcK
         Sx/BIHCNwK+56gmPTG1Ol/dHEaXZ2NfcjnykmjdWoVNwMZ3qazGAh+Z0DAl3RBRpla5p
         8Uo5YukfvcgZIh1XiZYLsAiK7KaTMkvMTNwgfcFlEAU+LggKnprG8JW+3tQPcJ5KZJ33
         NRIijSQJ6/cNEYErm7k7yWFVtzlwG8o4mSiSuZxr2hiCg984kOmpun8AnUUFO5y30XMO
         PYncKrAR//oPfjDVYWQuIbSV7CK8HbBcxokzXk9ziMMGtlJr/GTTo/DA/MQc4rWhktkh
         57Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773334; x=1714378134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YOWqoUrVrzd78R6ZnWxTyIXa2oV+7yQhabwhKzd1GY=;
        b=LXEa6aOB7AtxsJBsmMqFjUOpeS+cqVbdsZ/AGTXsBo71C9J2gM++hYFf93z73ef1A2
         bfyohXH66K0l3bVNFeDbY/ek6IylzOwxWublbKk6O2IiuzIVivQOGPJtOjxirdBxZbP2
         z+qZohlU2a8cSEj0/11OLHq+UzbLL6eCC8N1Bzu7pO/TI9HsWEymIXnBNdby9KamSHUu
         IFWJtQuvTs5/b2lLgdi73cVzwMQSVU9hKHmKYw23Rd/BsC0iGm9VyUME0yEN9BVo3VIZ
         CjTJoIS3HQIlibTE86NyOBnP8X6FpXPhvZcf7FP1RQtOZP6UJJMzxlFjDfgbytBoTHDm
         4wDA==
X-Forwarded-Encrypted: i=1; AJvYcCWY2Ob4RIHWTeaw4ERR7WRUL+I/BoVhELi5Z58yQA177C81c1lh9wpjtH9nB5Gd5N1E5YfQJj2sBcnydmlWuK89hDLBW52ABXRtHU9m8ARyxlnFxJA1ytcbyeFjacTU3/fzcOCFpBadZJybOtdi8Cl4QzQtLMo/blXGStXMRfddWdS4UQ==
X-Gm-Message-State: AOJu0Yx2LPlEyixMmK82ftEDgj11IvlGtPttcT1OKVJBGEdiDT0l+PNr
	Kn3abvMZd+Oeu3RgyRpFupGoxPSLZ7PJsD/Y8+4FVC5CYCQR94mT
X-Google-Smtp-Source: AGHT+IFCOjRIFdGtEDgDePhaaz9c1QAeRRqmE0j/uLnYZT22Hw8WLLxAEOToxc3ZMMghs4oHeXg6kQ==
X-Received: by 2002:a17:90a:d704:b0:2a2:b308:1371 with SMTP id y4-20020a17090ad70400b002a2b3081371mr7354259pju.43.1713773334054;
        Mon, 22 Apr 2024 01:08:54 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090b278e00b002ad0ba85c7asm3490372pjb.3.2024.04.22.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:08:53 -0700 (PDT)
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
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 3/4] perf record: Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:09:14 +0800
Message-ID: <20240422080914.1919018-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because we need to extract real sample data from raw_data, an
off_cpu_strip function is needed. In off_cpu_strip, we read events one by
one, stripping actual samples from raw data. After stripping is done, a
stripped buffer will be written to the perf.data(or compressed).

The size is end - start without masking, because masking will be handled
by perf_mmap__read_event(). Also, there's no need to call
perf_mmap__consume() as it will be called in perf_mmap__push(). We read
all the data at once, so start will be moved to end, when
perf_mmap__push() is called in pushfn the second time, size will be zero,
just returns directly.

Hook record_done instead of record_end to off_cpu_finish.

Although moving record_end hook is also fine because currently, only
off-cpu is using these hooks, technically record doesn't end when we need
to turn off BPF output, so it may confuse if moved. The reason why there's
an additional off_cpu_change_type is that it cannot be put into
off_cpu_finish because there are still samples to be read(which requires
sample_type to stay PERF_SAMPLE_RAW), and it cannot be hooked to
record_end because it has to be put before record__finish_output.


Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c     | 245 +++++++++++++-----------------
 tools/perf/util/off_cpu.h         |  14 +-
 tools/perf/util/perf-hooks-list.h |   1 +
 3 files changed, 121 insertions(+), 139 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 6af36142dc5a..df1f02938099 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -12,6 +12,9 @@
 #include "util/thread_map.h"
 #include "util/cgroup.h"
 #include "util/strlist.h"
+#include "util/mmap.h"
+#include "util/sample.h"
+#include <perf/mmap.h>
 #include <bpf/bpf.h>
 
 #include "bpf_skel/off_cpu.skel.h"
@@ -23,51 +26,6 @@
 
 static struct off_cpu_bpf *skel;
 
-struct off_cpu_key {
-	u32 pid;
-	u32 tgid;
-	u32 stack_id;
-	u32 state;
-	u64 cgroup_id;
-};
-
-union off_cpu_data {
-	struct perf_event_header hdr;
-	u64 array[1024 / sizeof(u64)];
-};
-
-static int off_cpu_config(struct evlist *evlist)
-{
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
-
-	if (evname == NULL)
-		return -ENOMEM;
-
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
-	}
-
-	evsel->core.attr.freq = 1;
-	evsel->core.attr.sample_period = 1;
-	/* off-cpu analysis depends on stack trace */
-	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
-
-	evlist__add(evlist, evsel);
-
-	free(evsel->name);
-	evsel->name = evname;
-
-	return 0;
-}
-
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
@@ -125,18 +83,29 @@ static void check_sched_switch_args(void)
 	btf__free(btf);
 }
 
+int off_cpu_change_type(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL)
+		return -1;
+
+	evsel->core.attr.sample_type = OFFCPU_SAMPLE_TYPES;
+
+	return 0;
+}
+
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		    struct record_opts *opts)
 {
 	int err, fd, i;
 	int ncpus = 1, ntasks = 1, ncgrps = 1;
+	u64 sid = 0;
 	struct strlist *pid_slist = NULL;
 	struct str_node *pos;
-
-	if (off_cpu_config(evlist) < 0) {
-		pr_err("Failed to config off-cpu BPF event\n");
-		return -1;
-	}
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
 
 	skel = off_cpu_bpf__open();
 	if (!skel) {
@@ -250,7 +219,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	}
 
 	if (evlist__first(evlist)->cgrp) {
-		struct evsel *evsel;
 		u8 val = 1;
 
 		skel->bss->has_cgroup = 1;
@@ -272,6 +240,25 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		goto out;
+	}
+
+	if (evsel->core.id)
+		sid = evsel->core.id[0];
+
+	skel->bss->sample_id = sid;
+	skel->bss->sample_type = OFFCPU_SAMPLE_TYPES;
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		bpf_map__update_elem(skel->maps.offcpu_output,
+				     &pcpu.cpu, sizeof(int),
+				     xyarray__entry(evsel->core.fd, pcpu.cpu, 0),
+				     sizeof(__u32), BPF_ANY);
+	}
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
@@ -279,7 +266,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	}
 
 	if (perf_hooks__set_hook("record_start", off_cpu_start, evlist) ||
-	    perf_hooks__set_hook("record_end", off_cpu_finish, evlist)) {
+	    perf_hooks__set_hook("record_done", off_cpu_finish, evlist)) {
 		pr_err("Failed to attach off-cpu skeleton\n");
 		goto out;
 	}
@@ -291,105 +278,91 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	return -1;
 }
 
-int off_cpu_write(struct perf_session *session)
+ssize_t off_cpu_strip(struct evlist *evlist, struct mmap *mp, char *dst, size_t size)
 {
-	int bytes = 0, size;
-	int fd, stack;
-	u64 sample_type, val, sid = 0;
+	/*
+	 * In this function, we read events one by one,
+	 * stripping actual samples from raw data.
+	 * The size is end - start without masking,
+	 * because masking will be handled by
+	 * perf_mmap__read_event()
+	 */
+
+	union perf_event *event, tmp;
+	u64 sample_type = OFFCPU_SAMPLE_TYPES;
+	size_t written = 0, event_sz, write_sz, raw_sz_aligned, offset = 0;
+	void *src;
+	int err = 0, n = 0;
+	struct perf_sample sample;
 	struct evsel *evsel;
-	struct perf_data_file *file = &session->data->file;
-	struct off_cpu_key prev, key;
-	union off_cpu_data data = {
-		.hdr = {
-			.type = PERF_RECORD_SAMPLE,
-			.misc = PERF_RECORD_MISC_USER,
-		},
-	};
-	u64 tstamp = OFF_CPU_TIMESTAMP;
-
-	skel->bss->enabled = 0;
 
-	evsel = evlist__find_evsel_by_str(session->evlist, OFFCPU_EVENT);
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
 	if (evsel == NULL) {
 		pr_err("%s evsel not found\n", OFFCPU_EVENT);
-		return 0;
-	}
-
-	sample_type = evsel->core.attr.sample_type;
-
-	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
-		pr_err("not supported sample type: %llx\n",
-		       (unsigned long long)sample_type);
 		return -1;
 	}
 
-	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
-		if (evsel->core.id)
-			sid = evsel->core.id[0];
-	}
+	/* for writing sample time*/
+	if (sample_type & PERF_SAMPLE_IDENTIFIER)
+		++n;
+	if (sample_type & PERF_SAMPLE_IP)
+		++n;
+	if (sample_type & PERF_SAMPLE_TID)
+		++n;
+
+	/* no need for perf_mmap__consume(), it will be handled by perf_mmap__push() */
+	while ((event = perf_mmap__read_event(&mp->core)) != NULL) {
+		event_sz = event->header.size;
+		write_sz = event_sz;
+		src = event;
+
+		if (event->header.type == PERF_RECORD_SAMPLE) {
+			err = evlist__parse_sample(evlist, event, &sample);
+			if (err) {
+				pr_err("Failed to parse off-cpu sample\n");
+				return -1;
+			}
 
-	fd = bpf_map__fd(skel->maps.off_cpu);
-	stack = bpf_map__fd(skel->maps.stacks);
-	memset(&prev, 0, sizeof(prev));
+			if (sample.raw_data && evsel->core.id) {
+				bool flag = false;
 
-	while (!bpf_map_get_next_key(fd, &prev, &key)) {
-		int n = 1;  /* start from perf_event_header */
-		int ip_pos = -1;
+				for (u32 i = 0; i < evsel->core.ids; i++) {
+					if (sample.id == evsel->core.id[i]) {
+						flag = true;
+						break;
+					}
+				}
+				if (flag) {
+					memcpy(&tmp, event, event_sz);
 
-		bpf_map_lookup_elem(fd, &key, &val);
+					/* raw data has extra bits for alignment, discard them */
+					raw_sz_aligned = sample.raw_size - sizeof(u32);
+					memcpy(tmp.sample.array, sample.raw_data, raw_sz_aligned);
 
-		if (sample_type & PERF_SAMPLE_IDENTIFIER)
-			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_IP) {
-			ip_pos = n;
-			data.array[n++] = 0;  /* will be updated */
-		}
-		if (sample_type & PERF_SAMPLE_TID)
-			data.array[n++] = (u64)key.pid << 32 | key.tgid;
-		if (sample_type & PERF_SAMPLE_TIME)
-			data.array[n++] = tstamp;
-		if (sample_type & PERF_SAMPLE_ID)
-			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_CPU)
-			data.array[n++] = 0;
-		if (sample_type & PERF_SAMPLE_PERIOD)
-			data.array[n++] = val;
-		if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-			int len = 0;
-
-			/* data.array[n] is callchain->nr (updated later) */
-			data.array[n + 1] = PERF_CONTEXT_USER;
-			data.array[n + 2] = 0;
-
-			bpf_map_lookup_elem(stack, &key.stack_id, &data.array[n + 2]);
-			while (data.array[n + 2 + len])
-				len++;
-
-			/* update length of callchain */
-			data.array[n] = len + 1;
-
-			/* update sample ip with the first callchain entry */
-			if (ip_pos >= 0)
-				data.array[ip_pos] = data.array[n + 2];
-
-			/* calculate sample callchain data array length */
-			n += len + 2;
-		}
-		if (sample_type & PERF_SAMPLE_CGROUP)
-			data.array[n++] = key.cgroup_id;
+					write_sz = sizeof(struct perf_event_header) +
+							  raw_sz_aligned;
+
+					/* without this we'll have out of order events */
+					if (sample_type & PERF_SAMPLE_TIME)
+						tmp.sample.array[n] = sample.time;
 
-		size = n * sizeof(u64);
-		data.hdr.size = size;
-		bytes += size;
+					tmp.header.size = write_sz;
+					tmp.header.type = PERF_RECORD_SAMPLE;
+					tmp.header.misc = PERF_RECORD_MISC_USER;
 
-		if (perf_data_file__write(file, &data, size) < 0) {
-			pr_err("failed to write perf data, error: %m\n");
-			return bytes;
+					src = &tmp;
+				}
+			}
 		}
+		if (offset + event_sz > size || written + write_sz > size)
+			break;
 
-		prev = key;
-		/* increase dummy timestamp to sort later samples */
-		tstamp++;
+		memcpy(dst, src, write_sz);
+
+		dst += write_sz;
+		written += write_sz;
+		offset += event_sz;
 	}
-	return bytes;
+
+	return written;
 }
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..03d2f29cbb47 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -20,7 +20,9 @@ struct record_opts;
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		    struct record_opts *opts);
-int off_cpu_write(struct perf_session *session);
+ssize_t off_cpu_strip(struct evlist *evlist, struct mmap *mp,
+		      char *dst, size_t size);
+int off_cpu_change_type(struct evlist *evlist);
 #else
 static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
 				  struct target *target __maybe_unused,
@@ -28,8 +30,14 @@ static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
 {
 	return -1;
 }
-
-static inline int off_cpu_write(struct perf_session *session __maybe_unused)
+static inline ssize_t off_cpu_strip(struct evlist *evlist __maybe_unused,
+				    struct mmap *mp __maybe_unused,
+				    char *dst __maybe_unused,
+				    size_t size __maybe_unused)
+{
+	return -1;
+}
+static inline int off_cpu_change_type(struct evlist *evlist __maybe_unused)
 {
 	return -1;
 }
diff --git a/tools/perf/util/perf-hooks-list.h b/tools/perf/util/perf-hooks-list.h
index 2867c07ee84e..1ce4d44ace35 100644
--- a/tools/perf/util/perf-hooks-list.h
+++ b/tools/perf/util/perf-hooks-list.h
@@ -1,3 +1,4 @@
 PERF_HOOK(record_start)
 PERF_HOOK(record_end)
+PERF_HOOK(record_done)
 PERF_HOOK(test)
-- 
2.44.0


