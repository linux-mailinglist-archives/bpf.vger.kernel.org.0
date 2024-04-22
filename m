Return-Path: <bpf+bounces-27355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1B8AC651
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03FF283138
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B650246;
	Mon, 22 Apr 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVeglYmd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4284E1D5;
	Mon, 22 Apr 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773302; cv=none; b=EfFYfBqYrvpli987dpBvRZx69k+WTL/wbn69UXjgDps3lvaq2ZjoSmwS9icrmxpMHEliNdHRBoumrdkfPg9/5KDfPxfcZI1A4zMOzByzIm2HqSVvZ5PZq7OYPIJXGXPm5ZXGhiY6IZ1kJeljLroKZZ4eYr8fCx48zM2L/IF184k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773302; c=relaxed/simple;
	bh=PvX3UAI3pKBNO7+QP/77uw0Vs7P6rs6XY2pmKssYcYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUNry6D1AqZBDEq1fcxcFYGWjVP5JshXRkJcv5CGqzX9W7vnUorJk5WyiE/koWybI/HJWtQtVkZ4EVa/6wHUyR4CbJ+ApTJZswrypDmJIrFbCa3FEhztNeH86oIJomiMLEysYqD7Pwse6rBQUhr89nIUnd1/3xP7eAGalFquMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVeglYmd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2339799a12.1;
        Mon, 22 Apr 2024 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773300; x=1714378100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8U35ePrc9QgPQW1W05XfxAhRzQZ8Z2BPPc+gusk8hs=;
        b=mVeglYmdjc4e2HKuaUHRtmPa0BEyLr4el/23Yqju6hxakgS8zrxB4kU/4Z40tLLqIJ
         8O0JaqDhUFsJ8JHAa0fynl2wd05qaVcAQItUZedu1cy7GfxODFhKiAPdftlO5CBCUYCW
         f7/Z2iLN571kmq6BluADKhTBQyx699lcy79HMRIIyBjn1vmaivbNvQAzxYQ+/LZtHbjx
         T70ivWBFVH5SaXAwtbnuy2T/2YB90/mFe+CTzRVDxQhZykLypkqpo+AnZ7HLqG89hDHy
         Vehb/CivwMhmFNAFGdsxUQxP6HdEBOsOA8CyogBneF1d9WIeC/X7fcXOm3eJ1Vy9aoUr
         723A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773300; x=1714378100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8U35ePrc9QgPQW1W05XfxAhRzQZ8Z2BPPc+gusk8hs=;
        b=QarH1McH2RBGjXeefDbu/U4pAk3y6GznOiTDOy17rPwHrMpPtrneV/MvFH27TS1Ldr
         8ojXfQzSbb9uB4D8i/qwVTRKFLoTvoP9Ki8vxc9cTzUZLD2tXeWrWKdoARLw0g6RRCHz
         PeNPM0cGwSZsknOq07Qum8e9D1IQRA9BmpfGJsueFOl+hRg7w11gj+nnLkVxEN2YIlbS
         88+NdW83fTH6WYU05uHHlY4nk1Vs/x9y9RkzUBhZvRr3y+SJJomyGrtjuWy0tqDbQ1qb
         x6zjsIWZNi0/GCS5Z8qaMeqok25TYApwlAA0rrCRaKslrvycFqMjeHu7A+oResD/MMwZ
         IcBg==
X-Forwarded-Encrypted: i=1; AJvYcCWhjYwcusWAaE0uJZo12Ik/yDOlv3KNfQP/i79cpMw+vNiYyj+2c3S6ITaw7qzjLTPGPPJ5mYW6puTag3Wu37MJkMD6mglqmKSgtl7LABKlbjvqPy5qygnI0oKcgG/rLvSPOEakTagNQyjS3B3IAyE0QHWmJ47lsCfuiyAsxgCW7AfR6g==
X-Gm-Message-State: AOJu0YwvcjR9m6NjOFHk3JFoWQtyr3ZjZBq89UPhDhvr5PMpNxB31gZ4
	7ttZdOvIEF5tIHO+IO1ds0avb/qQH8CXdaj4pKWSTG9ePeHUOPy0
X-Google-Smtp-Source: AGHT+IG67lFmX36ufIM8YRR3lOsp7+DgbGzlYeIKQFqwShCOFjnLcAyOF/T7LDXTqsiUFwpz/9AzgQ==
X-Received: by 2002:a05:6a20:3d8c:b0:1ab:82fe:910b with SMTP id s12-20020a056a203d8c00b001ab82fe910bmr12453549pzi.58.1713773300194;
        Mon, 22 Apr 2024 01:08:20 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id hi2-20020a17090b30c200b002a22ddac1a1sm7118809pjb.24.2024.04.22.01.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:08:19 -0700 (PDT)
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
Subject: [PATCH v1 1/4] perf record: Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:08:27 +0800
Message-ID: <20240422080827.1918034-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse off-cpu events using parse_event(). Change the placement of
record__config_off_cpu to after record__open because we need to write
mmapped fds into BPF's perf_event_array map, also, write 
sample_id/sample_type into BPF. In record__pushfn and record__aio_pushfn, 
handle off-cpu samples using off_cpu_strip. This is because the off-cpu 
samples that we want to write to perf.data is in off-cpu samples' raw_data 
section:

regular samples:
[sample: sample_data]

off-cpu samples:
[sample: [raw_data: sample_data]]

We need to extract the real useful sample data out before writing.

Hooks record_done just before evlist__disable to stop BPF program from
outputting, otherwise, we lose some samples.

After samples are collected, change sample_type of off-cpu event to
the OFFCPU_SAMPLE_TYPES for parsing correctly, it was PERF_SAMPLE_RAW and
some others, because BPF can only output to a specific type of perf_event,
which is why `evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;` is
deleted in util/evsel.c. 

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-record.c | 98 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/evsel.c     |  8 ---
 2 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2ff718d3e202..c31b23905f1b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -389,6 +389,8 @@ struct record_aio {
 static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size)
 {
 	struct record_aio *aio = to;
+	char *bf_stripped = NULL;
+	size_t stripped;
 
 	/*
 	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
@@ -404,6 +406,31 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 * from the beginning of the kernel buffer till the end of the data chunk.
 	 */
 
+	if (aio->rec->off_cpu) {
+		if (size == 0)
+			return 0;
+
+		map->core.start -= size;
+		size = map->core.end - map->core.start;
+
+		bf_stripped = malloc(size);
+
+		if (bf_stripped == NULL) {
+			pr_err("Failed to allocate off-cpu strip buffer\n");
+			return -ENOMEM;
+		}
+
+		stripped = off_cpu_strip(aio->rec->evlist, map, bf_stripped, size);
+
+		if (stripped < 0) {
+			size = (int)stripped;
+			goto out;
+		}
+
+		size = stripped;
+		buf = bf_stripped;
+	}
+
 	if (record__comp_enabled(aio->rec)) {
 		ssize_t compressed = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
 						   mmap__mmap_len(map) - aio->size,
@@ -432,6 +459,9 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 
 	aio->size += size;
 
+out:
+	free(bf_stripped);
+
 	return size;
 }
 
@@ -635,6 +665,38 @@ static int process_locked_synthesized_event(struct perf_tool *tool,
 static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
+	int err;
+	char *bf_stripped = NULL;
+	size_t stripped;
+
+	if (rec->off_cpu) {
+		/*
+		 * We'll read all the events at once without masking.
+		 * When reading the remainder from a map, the size is 0, because
+		 * start is shifted to the end so no more data is to be read.
+		 */
+		if (size == 0)
+			return 0;
+
+		map->core.start -= size;
+		/* get the total size */
+		size = map->core.end - map->core.start;
+
+		bf_stripped = malloc(size);
+
+		if (bf_stripped == NULL) {
+			pr_err("Failed to allocate off-cpu strip buffer\n");
+			return -ENOMEM;
+		}
+
+		stripped = off_cpu_strip(rec->evlist, map, bf_stripped, size);
+
+		if (stripped < 0)
+			return (int)stripped;
+
+		size = stripped;
+		bf = bf_stripped;
+	}
 
 	if (record__comp_enabled(rec)) {
 		ssize_t compressed = zstd_compress(rec->session, map, map->data,
@@ -648,7 +710,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	}
 
 	thread->samples++;
-	return record__write(rec, map, bf, size);
+	err = record__write(rec, map, bf, size);
+
+	free(bf_stripped);
+
+	return err;
 }
 
 static volatile sig_atomic_t signr = -1;
@@ -1790,6 +1856,7 @@ record__finish_output(struct record *rec)
 		if (rec->buildid_all)
 			perf_session__dsos_hit_all(rec->session);
 	}
+
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
 
 	return;
@@ -2501,6 +2568,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		}
 	}
 
+	if (rec->off_cpu) {
+		err = record__config_off_cpu(rec);
+		if (err) {
+			pr_err("record__config_off_cpu failed, error %d\n", err);
+			goto out_free_threads;
+		}
+	}
+
 	/*
 	 * Normally perf_session__new would do this, but it doesn't have the
 	 * evlist.
@@ -2764,6 +2839,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 * disable events in this case.
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
+			perf_hooks__invoke_record_done();
 			trigger_off(&auxtrace_snapshot_trigger);
 			evlist__disable(rec->evlist);
 			disabled = true;
@@ -2827,14 +2903,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	} else
 		status = err;
 
-	if (rec->off_cpu)
-		rec->bytes_written += off_cpu_write(rec->session);
-
 	record__read_lost_samples(rec);
 	record__synthesize(rec, true);
 	/* this will be recalculated during process_buildids() */
 	rec->samples = 0;
 
+	/* change to the correct sample type for parsing */
+	if (rec->off_cpu && off_cpu_change_type(rec->evlist)) {
+		pr_err("ERROR: Failed to change sample type for off-cpu event\n");
+		goto out_delete_session;
+	}
+
 	if (!err) {
 		if (!rec->timestamp_filename) {
 			record__finish_output(rec);
@@ -3198,7 +3277,7 @@ static int switch_output_setup(struct record *rec)
 	unsigned long val;
 
 	/*
-	 * If we're using --switch-output-events, then we imply its 
+	 * If we're using --switch-output-events, then we imply its
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
@@ -4221,9 +4300,14 @@ int cmd_record(int argc, const char **argv)
 	}
 
 	if (rec->off_cpu) {
-		err = record__config_off_cpu(rec);
+		char off_cpu_event[64];
+
+		snprintf(off_cpu_event, sizeof(off_cpu_event),
+			 "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
+
+		err = parse_event(rec->evlist, off_cpu_event);
 		if (err) {
-			pr_err("record__config_off_cpu failed, error %d\n", err);
+			pr_err("Failed to open off-cpu event\n");
 			goto out;
 		}
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..c08ae6a3c8d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1092,11 +1092,6 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
-{
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
-}
-
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1363,9 +1358,6 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 
-	if (evsel__is_offcpu_event(evsel))
-		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
-
 	arch__post_evsel_config(evsel, attr);
 }
 
-- 
2.44.0


