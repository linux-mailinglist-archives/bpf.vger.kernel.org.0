Return-Path: <bpf+bounces-69325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC273B942ED
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C652A6703
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4B27A44A;
	Tue, 23 Sep 2025 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5jJkknd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA11277CB1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601138; cv=none; b=QtizRiBtUOkVCudCCbTGlYnLlfTbClL3LErDXRykvIyxf5hSmoQdhokH1WbiOd5N/YyHG+RV/6sJjIXyT+EkhSpk+1lXEdSPD5CVmU/5iH3DbxLryV3FYPDvws0+hQA1ZDcLJvSLWhi8R9zXGFgNTP0VoodC+THewZppFryEUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601138; c=relaxed/simple;
	bh=6w32qiODxVbWhu7gKe69wsxnRqgpm9MqdSFipBqSCVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8RmqlV0ip7rMNB/OMSWYiJVsfsMxoQRgY79sv7Rph3Mb2YNn+U/AdY8x98Abv3GTzodNAagovJWHx02jLc+3ZiAOTPWep/TeCMDd9GiUyU5zONLivEXAr854mm5nO7zqeJtR67o3w5s+Sl3Fa8OcDSXDnx8QWAUHsgSfInA3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5jJkknd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f86568434so3777407a12.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601136; x=1759205936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JPySr0sbcR3UAmkPCoUXEtd2Wkfd/YW7TDvRR50H+Y=;
        b=G5jJkkndNjXt86h9qXhcsTR+CmpM+cx/5Kopp0U3Fr8boKJLdc+xMBY3JE2s2Svz44
         GZGx/Bbw9x0wepV2wRf5Ty62AK+LjkCceU0TSEtMuybGs5VDbPqYFoaa2dA3VIORkBnl
         IY4AiuJ/0ns9q0asvuGAi0qwkZ+eu719pRv4Y+aMtGsFa920K78cSMc97AzPoOSmySbz
         PUOgqakeGH3ClItnPMSSkn+Y4ZUo+Y/T9S3JMsUKN/c9Xi2+kCqWvt4yKJv75cGA0ghX
         K8fNDDS5gNx+MDZtSoBg1P1ogEoqRv9Pnyc6ANpCy81woAFbI63NLKe3LMFThWlkcGhp
         FICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601136; x=1759205936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JPySr0sbcR3UAmkPCoUXEtd2Wkfd/YW7TDvRR50H+Y=;
        b=eoZSph3iD92qQJpoj6HSVWuJqE6+dvIya3evZbTxQCHvIgpDwKjzo5lYjiU6UBXSO7
         gbj1gbdU7LUFQcuT12OF9Ho+6xYNHsXpMDSZuWc6KEBDqgzrKnRcNKhSDYiLBZoxvAGJ
         tMUUGzvcHqO+AJTtqmLjhBpzNlpq0efu+l/juHE6ArK2ktEu1RmRwlZNKJ8bj3sWnlqy
         LGBaDJMae0eqQNuSkvgIO203/iDE/iEb0LAjp2vy7+GYZh1c7a5Oh1B9mMsZCacdqjSb
         iZ4cmBC6k3TK4bo4w0hYONwvjHiBFrFVJt2pPGEYdIsr8dNeLzVY9MxPZIKHSlmTYyil
         BGaA==
X-Forwarded-Encrypted: i=1; AJvYcCWv9dw/DFZm0dH6F2ZWGiEnSimYxR+56SufnRzw9KnaFovBth48fAPvBHaJocFIH4VQulU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeO+7jnOF1ed3VI0iDvnWZzUb3dD2Po26Uio78pIKT0IL250fs
	dZZHfI7TsGVqZNp7Ummdt/oFLjlGWvoow7ru5HtN6f/PIVVzRuUkw1BKcGYk8LtJyXkwVXjlIVS
	llDyuIT2Gvw==
X-Google-Smtp-Source: AGHT+IFSnInlY3g2ydnFllV4hIWP9Y/28s9CahXOafdeh3PTK6YxJIwQHG9vbLsSoat+aVgZX2h9dx6OJkOy
X-Received: from plblw8.prod.google.com ([2002:a17:903:2ac8:b0:268:11e:8271])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f547:b0:269:ae5a:e32b
 with SMTP id d9443c01a7336-27cc18532ecmr15444175ad.13.1758601136136; Mon, 22
 Sep 2025 21:18:56 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:23 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-5-irogers@google.com>
Subject: [PATCH v5 04/25] perf record: Skip don't fail for events that don't open
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
index 7ea3a11aca70..effe6802c1a3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -983,7 +983,6 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -1388,10 +1387,27 @@ static int record__open(struct record *rec)
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
@@ -1403,15 +1419,74 @@ static int record__open(struct record *rec)
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
2.51.0.534.gc79095c0ca-goog


