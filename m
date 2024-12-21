Return-Path: <bpf+bounces-47526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500E9FA237
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843B3188C876
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8A1A707A;
	Sat, 21 Dec 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irwTCG3W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B00198A0E
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809227; cv=none; b=GjqE8qvc1u7ELh510k1kysSBLE67ZxdxtON3sinW3YPGxgIeIi6Iu5PDjh0Ui40ti0PYOGAfkQ1nSJYPnmjHzORIE0JzmgMu33TrroEGeu2FINkrTtzh5Ww82/+eL3PSnp1FCgPatEu2ZSjOtBa6XrnJT2MRL8qmOV/TLkJfUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809227; c=relaxed/simple;
	bh=7fu/DFLrm5Jp+7q0HzW9A2i9nE4/DlX6NN15iJnlQ6U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jcsNrtzYHtmo/V0NSE3n+Jgj++huACt1d5TYkme+3PG1dblF8woj+8A3OBA+1k87DEJxzkByo9+TZe4bvXVsz6k9jpEQCp8FCREJOr3RvadT2BITL0j36vn6/OZ3KdLaBmvQa8nbQT/UJQE0ljkNlRcCskaYZvNHxAHRtYg1l/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irwTCG3W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f013249180so50993927b3.0
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734809225; x=1735414025; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOE3L6cGLsIo5XojcUzlg5FYQWc469qpQODvd7cISPA=;
        b=irwTCG3WRDeHuHBncr3Vh51rVKTmpdCNCjPT8SycxGJkmfLwTvvbvQaJoRNMq/301x
         udpUV2B2QU6hup6rNUeyluqFUHiETz7IUor+7H+4GGSVRJbzcibDSjUMFRriMYt9xxQM
         XViwcRgF60v3cpMLp2Xnw94iUWecrbv76wgdgyWAEVQvlcIYN7TQdn0ah0WJUh+39yAd
         78XjGSojrjTeTMvCsZHkce7DrA7kKOK5QvwM8LRfuX/EryB5BLFZ+sIKcR2coOkDtdym
         B4ow8+jOhHn8pndlEv9yRx61XwrwMPQMbNy6cRe/TK4oZGVo8nCGPj07h57lwzc6Pzv4
         rpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809225; x=1735414025;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOE3L6cGLsIo5XojcUzlg5FYQWc469qpQODvd7cISPA=;
        b=kS6uwmUDPDuU50OX5rBnfbHpo18T10guYinYJAGUb4xiVjOHf6nNkiZdcTy/AIxG4c
         3992BN4zljxMhC5ixpwSegGL6xG+mND70KB7gqO5PoCxkI+AW2Tq6ri6BGoWAghlsFp3
         tE+Ee9bANdQM7tprAEYq6HDAdKTD5ov6LRccmcUT4TKmZUGuXhFoAWuMGdnQSiTM6phe
         /LLE6RMuC0XRgvIhDcyUCiN0Fqd1Hjxh6326WfyqrEBV5EhFcUsnWKf3ZUAXnXq5JlPo
         NBISJ05aPRTnfGHpOVhjx96t8/riMiOwTdF98X/4gzNMGk+FsI3B+gp2vwwIyttiLOme
         wtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7KILo4gK1y/MQh0gMRmSNYZWJIV3CIi8KnwdJmvh/dj7j5rChRS44rL59XLlwg0obls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEXxsyPWbsr2ufEeN7c+P4em/eILPbOhV4z3it2IAgqhKXr4P
	/3vNz2+iPOeS30I2iWNxyOfdgr92/G1x76BSU+ALE03LGQ40eJ6Xv2UPH664FFc3x2h9e8BlV9r
	VbQdE7g==
X-Google-Smtp-Source: AGHT+IEGHxVmpRg7agVhGMQxTEkDH6CeIzWWB/q/lfFTYjK6su8nXsn7LYNanXrXBILQDmSYStsQKqCppo0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a2bc:ec03:1143:41ab])
 (user=irogers job=sendgmr) by 2002:a25:7453:0:b0:e38:9694:4c6e with SMTP id
 3f1490d57ef6-e5376587242mr23513276.2.1734809224969; Sat, 21 Dec 2024 11:27:04
 -0800 (PST)
Date: Sat, 21 Dec 2024 11:26:53 -0800
In-Reply-To: <20241221192654.94344-1-irogers@google.com>
Message-Id: <20241221192654.94344-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221192654.94344-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 3/4] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Whilst for many tools it is an expected behavior that failure to open
a perf event is a failure, ARM decided to name PMU events the same as
legacy events and then failed to rename such events on a server uncore
SLC PMU. As perf's default behavior when no PMU is specified is to
open the event on all PMUs that advertise/"have" the event, this
yielded failures when trying to make the priority of legacy and
sysfs/json events uniform - something requested by RISC-V and ARM. A
legacy event user on ARM hardware may find their event opened on an
uncore PMU which for perf record will fail. Arnaldo suggested skipping
such events which this patch implements. Rather than have the skipping
conditional on running on ARM, the skipping is done on all
architectures as such a fundamental behavioral difference could lead
to problems with tools built/depending on perf.

An example of perf record failing to open events on x86 is:
```
$ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
"dmesg | grep -i perf" may provide additional information.

Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
"dmesg | grep -i perf" may provide additional information.

Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]

$ perf report --stats
Aggregated stats:
               TOTAL events:      17255
                MMAP events:        284  ( 1.6%)
                COMM events:       1961  (11.4%)
                EXIT events:          1  ( 0.0%)
                FORK events:       1960  (11.4%)
              SAMPLE events:         87  ( 0.5%)
               MMAP2 events:      12836  (74.4%)
             KSYMBOL events:         83  ( 0.5%)
           BPF_EVENT events:         36  ( 0.2%)
      FINISHED_ROUND events:          2  ( 0.0%)
            ID_INDEX events:          1  ( 0.0%)
          THREAD_MAP events:          1  ( 0.0%)
             CPU_MAP events:          1  ( 0.0%)
           TIME_CONV events:          1  ( 0.0%)
       FINISHED_INIT events:          1  ( 0.0%)
cycles stats:
              SAMPLE events:         87
```

If all events fail to open then the perf record will fail:
```
$ perf record -e LLC-prefetch-read true
Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
Error:
Failure to open any events for recording
```

This is done by detecting if a dummy event was added by perf and
seeing if the evlist is empty without it. This allows the dummy event
still to be recorded:
```
$ perf record -e dummy true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.046 MB perf.data ]
```
but fail when inserted:
```
$ perf record -e LLC-prefetch-read -a true
Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
Error:
Failure to open any events for recording
```

The issue with legacy events is that on RISC-V they want the driver to
not have mappings from legacy to non-legacy config encodings for each
vendor/model due to size, complexity and difficulty to update. It was
reported that on ARM Apple-M? CPUs the legacy mapping in the driver
was broken and the sysfs/json events should always take precedent,
however, it isn't clear this is still the case. It is the case that
without working around this issue a legacy event like cycles without a
PMU can encode differently than when specified with a PMU - the
non-PMU version favoring legacy encodings, the PMU one avoiding legacy
encodings.

The patch removes events and then adjusts the idx value for each
evsel. This is done so that the dense xyarrays used for file
descriptors, etc. don't contain broken entries. As event opening
happens relatively late in the record process, use of the idx value
before the open will have become corrupted, so it is expected there
are latent bugs hidden behind this change - the change is best
effort. As the only vendor that has broken event names is ARM, this
will principally effect ARM users. They will also experience warning
messages like those above because of the uncore PMU advertising legacy
event names.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/builtin-record.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df..7415036c1724 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -171,6 +171,7 @@ struct record {
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
+	bool			dummy_event_added;
 	const char		*filter_action;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
@@ -961,7 +962,7 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-
+		int evlist_entries_before =  evlist->core.nr_entries;
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -973,6 +974,8 @@ static int record__config_tracking_events(struct record *rec)
 		if (!evsel)
 			return -ENOMEM;
 
+		rec->dummy_event_added = evlist->core.nr_entries > evlist_entries_before;
+
 		/*
 		 * Enable the tracking event when the process is forked for
 		 * initial_delay, immediately for system wide.
@@ -1366,6 +1369,7 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
@@ -1381,15 +1385,33 @@ static int record__open(struct record *rec)
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
-			rc = -errno;
 			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
-			ui__error("%s\n", msg);
-			goto out;
+			ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
+				  evsel__name(pos), evsel__pmu_name(pos), msg);
+			pos->skippable = true;
+			skipped = true;
+		} else {
+			pos->supported = true;
 		}
-
-		pos->supported = true;
 	}
 
+	if (skipped) {
+		struct evsel *tmp;
+		int idx = 0;
+
+		evlist__for_each_entry_safe(evlist, tmp, pos) {
+			if (pos->skippable)
+				evlist__remove(evlist, pos);
+		}
+		evlist__for_each_entry(evlist, pos) {
+			pos->core.idx = idx++;
+		}
+		if (idx == 0 || (idx == 1 && rec->dummy_event_added)) {
+			ui__error("Failure to open any events for recording.\n");
+			rc = -1;
+			goto out;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.47.1.613.gc27f4b7a9f-goog


