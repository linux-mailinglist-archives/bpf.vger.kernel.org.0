Return-Path: <bpf+bounces-68323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04136B56B04
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D13189B2CC
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127092DF6EA;
	Sun, 14 Sep 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1G2ZHn1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C22DF128
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873494; cv=none; b=mUtNanikVPcOFgkIjICJ67t4NLNeofFbtry4st2rPHRF6wpPSPPXk+cifVxMx5YN5ddC2RTlXru+QX6ar/idLT7Jn+d3Fzya69opFE+p2E1tLCfyQCsbzKi8KBYjODEOjsPHGhhQomifzn9Wf3n7viOKds+vG91OxjoidEEr/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873494; c=relaxed/simple;
	bh=JlgboHSHKguNaU2QOWnp5UHB5sX3fZxfOjryTmxdD+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4knkK9e9iiql50yQkQFHrq8H2LzegWwA2L5+GS9ZdyRYVUcc68HJ6nXOL3B2wZATpZNSlT4XKlwSgk2llDUhr42dUJkHbhStdyzo38tnWHxUlq6MNBaCTyz1KGRRmyBZESQJHc1GYTHSmqPRDkh4wOkq/84gL9WY7LFQT6bigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1G2ZHn1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26076dd11d1so14208845ad.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873492; x=1758478292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22uGFARjbD8zUyrEDNRBQoheIZFnSju1ShckhHFhyNA=;
        b=O1G2ZHn1aKELnbJCHcHhz2PstTmyDpuMeehmkQWzhJNmUUTWcayzsGGHTqRYvkYDzX
         HW+SALWwe3nIzZhPLIYWPDLQGTjTv0YdXLbZcGxPpyysJgGmyradyD6SD1xHd9d+I9wy
         th/S0lMj4lGhI5Q4HXDllKnKHiyQOTyh59Bg62VS8FjuetMQEkwmICZdBVMyS2hyeXMx
         s0uyg280WBv/JcgLF3pXlHx/sPzVBOgFqh187fwBrVc+rk7+l8FIKavYj7zWa8U+V5nM
         ozarMgSnvs8tkD/mYX1jIAogX2Jdf/ln76ikaMNpfR+OytGxvgkoHwdqWfZmE1Rush/4
         /eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873492; x=1758478292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22uGFARjbD8zUyrEDNRBQoheIZFnSju1ShckhHFhyNA=;
        b=bvvjjhsmzmpWodE/r0NR8yP7uFgbGa9H3WsN0zyL/NmoYq6kduW1V50RpEYVvoG9Wh
         B6jinNRgrCLl9jNGhZXsBjg03+yMIfEzUh1JuCp6BGo9Lrn6UpOf5udSbJSQokzRqEko
         OJw55TlX7JkbIWCLE9A0ehzVjte6cGzPJseKuebMw14iMCRJQh3rmZhGCT/F2MYs5GDn
         belx9tQSby+sYcrS2kK51e2ZHlPsTQ9oL8NBRTB9x98GB7SgTSy0dzi9CQEmYCFNlXjr
         RNrjvRHzbeJYpQipdpeFVGJcgCKsVTiaogG4Yxgivulx8Q5GS2Lh4Clfwdj4yiDPu6BQ
         JIuA==
X-Forwarded-Encrypted: i=1; AJvYcCXqlu3RVnQ7CBxmTSg+eux2vghDN7w3R009dmaxNCy2z+SKRb/Fzdrga/HAYseVaJ/3ZeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3B0PICvzD3BLGH8KiQpL5UC57HTTxZEpfxdlVebgtd3sVX6yf
	j5QON0FzHWfyUQbjzoz0H11hkwwKNArIaqSZBteccKkT7kPSTFTrwA4I3ZYBEXrxRzeSM2M1hJb
	FFLFVm4PYKA==
X-Google-Smtp-Source: AGHT+IHUUaVyR3Sp2XJw+ksKroCdXGjndb8+Z9gRmXG9v9qK2tyt4eL69sV8HloypvdfpKHoFm7p0Di2ILNy
X-Received: from plblm12.prod.google.com ([2002:a17:903:298c:b0:24c:c013:50b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37cd:b0:25b:f1f3:815f
 with SMTP id d9443c01a7336-25d2782cda6mr145994465ad.58.1757873491900; Sun, 14
 Sep 2025 11:11:31 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:03 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-4-irogers@google.com>
Subject: [PATCH v4 03/21] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
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

As an evlist may have dummy events that open when all command line
events fail we ignore dummy events when detecting if at least some
events open. This still permits the dummy event on its own to be used
as a permission check:
```
$ perf record -e dummy true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.046 MB perf.data ]
```
but allows failure when a dummy event is implicilty inserted or when
there are insufficient permissions to open it:
```
$ perf record -e LLC-prefetch-read -a true
Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
Error:
Failure to open any events for recording
```

As the first parsed event in an evlist is marked as tracking, removing
this event can remove tracking from the evlist, removing mmap events
and breaking symbolization. To avoid this, if a tracking event is
removed then the next event has tracking added.

The issue with legacy events is that on RISC-V they want the driver to
not have mappings from legacy to non-legacy config encodings for each
vendor/model due to size, complexity and difficulty to update. It was
reported that on ARM Apple-M? CPUs the legacy mapping in the driver
was broken and the sysfs/json events should always take precedent,
however, it isn't clear this is still the case. It is the case that
without working around this issue a legacy event like cycles without a
PMU can encode differently than when specified with a PMU - the
non-PMU version favoring legacy encodings, the PMU one avoiding legacy
encodings. Legacy events are also case sensitive while sysfs/json
events are not.

The patch removes events and then adjusts the idx value for each
evsel. This is done so that the dense xyarrays used for file
descriptors, etc. don't contain broken entries.

On ARM it could be common following this change to see a lot of
warnings for the cycles event due to many ARM PMUs advertising the
cycles event (ARM inconsistently have events bus_cycles and then
cycles implying CPU cycles, they also sometimes have a cpu_cycles
event). As cycles is a popular event, avoid potentially spamming users
with error messages on ARM when there are multiple cycles events in
the evlist, the error is still shown when verbose is enabled.

Prior versions without adding the tracking data and not warning for
cycles on ARM was:

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 89 ++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 37f771c9c0ec..8e289f352fc8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -986,7 +986,6 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -1391,10 +1390,27 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
+	bool removed_tracking = false;
 
 	evlist__for_each_entry(evlist, pos) {
+		if (removed_tracking) {
+			/*
+			 * Normally the head of the list has tracking enabled
+			 * for sideband data like mmaps. If this event is
+			 * removed, make sure to add tracking to the next
+			 * processed event.
+			 */
+			if (!pos->tracking) {
+				pos->tracking = true;
+				evsel__config(pos, opts, &callchain_param);
+			}
+			removed_tracking = false;
+		}
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
+			bool report_error = true;
+
 			if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
@@ -1406,15 +1422,74 @@ static int record__open(struct record *rec)
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
-			rc = -errno;
-			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
-			ui__error("%s\n", msg);
-			goto out;
+#if defined(__aarch64__) || defined(__arm__)
+			if (strstr(evsel__name(pos), "cycles")) {
+				struct evsel *pos2;
+				/*
+				 * Unfortunately ARM has many events named
+				 * "cycles" on PMUs like the system-level (L3)
+				 * cache which don't support sampling. Only
+				 * display such failures to open when there is
+				 * only 1 cycles event or verbose is enabled.
+				 */
+				evlist__for_each_entry(evlist, pos2) {
+					if (pos2 == pos)
+						continue;
+					if (strstr(evsel__name(pos2), "cycles")) {
+						report_error = false;
+						break;
+					}
+				}
+			}
+#endif
+			if (report_error || verbose > 0) {
+				ui__error("Failure to open event '%s' on PMU '%s' which will be "
+					  "removed.\n%s\n",
+					  evsel__name(pos), evsel__pmu_name(pos), msg);
+			}
+			if (pos->tracking)
+				removed_tracking = true;
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
+		bool evlist_empty = true;
+
+		/* Remove evsels that failed to open and update indices. */
+		evlist__for_each_entry_safe(evlist, tmp, pos) {
+			if (pos->skippable) {
+				evlist__remove(evlist, pos);
+				continue;
+			}
+
+			/*
+			 * Note, dummy events may be command line parsed or
+			 * added by the tool. We care about supporting `perf
+			 * record -e dummy` which may be used as a permission
+			 * check. Dummy events that are added to the command
+			 * line and opened along with other events that fail,
+			 * will still fail as if the dummy events were tool
+			 * added events for the sake of code simplicity.
+			 */
+			if (!evsel__is_dummy_event(pos))
+				evlist_empty = false;
+		}
+		evlist__for_each_entry(evlist, pos) {
+			pos->core.idx = idx++;
+		}
+		/* If list is empty then fail. */
+		if (evlist_empty) {
+			ui__error("Failure to open any events for recording.\n");
+			rc = -1;
+			goto out;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.51.0.384.g4c02a37b29-goog


