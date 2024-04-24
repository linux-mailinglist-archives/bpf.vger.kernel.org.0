Return-Path: <bpf+bounces-27622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DA8AFEA2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1877F1F243B5
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA2129A7E;
	Wed, 24 Apr 2024 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6WUGAG3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8283A1E;
	Wed, 24 Apr 2024 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926795; cv=none; b=dJCFaUPfNfgzcd44djDz9it38OKcHFRCGTl8B/EV++3Q1pEUVpGAWjQ0lpcQQa6I80cQbbMGEh6+mjYT+ro1nlAxEUCPQ/VG4HnsaGU9eGK1FSlb3okLkOiglQTB5PLh4ftdbTU3N353JUr1WeWIzlaKKxnfXE1UAMwj/IHDdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926795; c=relaxed/simple;
	bh=7x3bSn+CwYUU5fPN0SrTfXhtq2kTOomoPg+m+5zhRvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIFT1KgG7Y1bfsiKj0Znsqo/KFG2+nylGQ3w7PXI/lZU9L9UpjUyUy+/IIdQoxVgKPdZU6Bv2RN4SNC+3YJulx+4S4ZqqJlJwiz/LNmlmf0g2zL8SsB4RlmXpP24TE7UuC3tFjZrzDBxpebpPyeBfgv0vDL8L3H3I0gguCCYTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6WUGAG3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-60275a82611so1514321a12.1;
        Tue, 23 Apr 2024 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926793; x=1714531593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/LdYNrIh2jrT148K4L71/CYqd/g6GGqqQlcIzk9sFI=;
        b=e6WUGAG3ApzpNeuleawbD8btA4UlButUHsyjpnoFpZ/fTSBUqh060AvJFbmZtNdunN
         zhdylNtAmt+ZojTPBqNd+SKCh78aFEqkxb96YG4sY/ZgW0f6hSWyV4NdQyElyrmM9rNJ
         W3wQdt37J18VNN+vRB09vYZNdPXGCHb20RoRigvqD4vuxxmWKpdHrH0QwjAyeDsa509r
         xI8JnvH0ZrWqrwX1MAB5/ov1wN1Vj57Yj1rtKCRb4grsicMXfxRUeUVOSGhmllNuO0uD
         pz/NCXHlzHUH8tKCnU6iykA6SmRIWi6xN/E9MNW678DjNwxNRWmCdiLeJFJC0CF1tr+m
         lAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926793; x=1714531593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/LdYNrIh2jrT148K4L71/CYqd/g6GGqqQlcIzk9sFI=;
        b=PbeoqOjQ7aPUA6u1J/77utRmkwby0xfLv9srclG9kZ3feBYXTJXUeJgSEmcW/aM3tU
         eZK+WB0MF7ksixbe+26EK1gJoVY+HzQGMqGLfZ5om62GGlpDxm13AgSicilGNUfF+qNc
         1dQl7mFjeacOtnwIBDHVyL7IaJLDjAIYjsG4HZI9rgJK3BdJnj3BcFsrJODV2CXCwv1v
         X7lF48G64MaqmWUgGoqFqlyYrfwhmVWGSLmg0Ce5d2BOFt/EwR5XFSoSq5/BYt2pJGa7
         Xl7zVmMY1Ks5TcZftX3uyIIrjKz8Y6CWF0RqcHqgTI5pwQCWdpZfgbdWCpJRvoy4eruV
         O8Og==
X-Forwarded-Encrypted: i=1; AJvYcCU5MQhHcklo/pE6ddyKP9d5sCoy2oA3cqh2JdW+dox06vfkVoSVaC3BYaE3p6u7yuyGnM8SGuvjxHR1oiByaEMq0P2dW0UPTEtJtOAXqBDLedH35jk9DEseLHqbvAlWI8SK31xMxixIJ+32QE5Bg7L/4eyjX1mNJkdREO5/wqH3LzIYsw==
X-Gm-Message-State: AOJu0YxeqoB4pa8/+Xw53od9eAg+rYke7C6EvFlZrmeOaBvnYtkjVWKC
	i0sn1+mZNZH2WUQBCfYHwf7ggQ5j7q9EN8tLHcab6U16Z2K0JdaA
X-Google-Smtp-Source: AGHT+IF/lBJNoZ/yBJVF6QTIK+8p5RUqVNnblvxyiOIEWq5Moxf0xPjKA9tYUiHjTnUJwpffHs0cvA==
X-Received: by 2002:a05:6a20:948b:b0:1a3:52ef:cc84 with SMTP id hs11-20020a056a20948b00b001a352efcc84mr1041883pzb.60.1713926793345;
        Tue, 23 Apr 2024 19:46:33 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.143])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e604438791sm10739243plg.156.2024.04.23.19.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:46:33 -0700 (PDT)
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
Subject: [PATCH v2 1/4] perf record off-cpu: Parse off-cpu event, change config location
Date: Wed, 24 Apr 2024 10:48:02 +0800
Message-ID: <20240424024805.144759-2-howardchu95@gmail.com>
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

Parse off-cpu events using parse_event(). Change the location of
record__config_off_cpu, after record__open because we need to write
mmapped fds into BPF's perf_event_array map, also, write
sample_id/sample_type into BPF. In record__pushfn and record__aio_pushfn,
handle off-cpu samples by off_cpu_strip. This is because the off-cpu
samples that we want to write to perf.data is in off-cpu samples' raw_data
section:

regular samples:
[sample: sample_data]

off-cpu samples:
[sample: [raw_data: sample_data]]

We need to extract the useful sample data out before writing.

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
index 2ff718d3e202..3994adaf4607 100644
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
+		/* size in total */
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
+	if (rec->off_cpu && off_cpu_prepare_parse(rec->evlist)) {
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


