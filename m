Return-Path: <bpf+bounces-66891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F23B3AC41
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E6BA0426C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7E3101AA;
	Thu, 28 Aug 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miLotIu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987162D2497
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414801; cv=none; b=OJJ9EXAChoROhh9rRpX/hrmeCRsh5cC54OvfSu8LbxPCPuPlzh69aDh0hfJY6bzysaeRn0jKlVomxpSIeH5Z9ABg9w0igxV84P2qIb/JC+vDW0YqzC8AnCK+WDtkVzJxv089Z8HlJDeXIcq+uekTW7VLFtr9OXUCWz60v1Qu/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414801; c=relaxed/simple;
	bh=bkFLIgb3XzTi3FJgAJDSMWc3DMl8sUpNxvauOKGR1GY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=avcOZp/NLepHWCWuh0xE5tYPaPMGOSCfX0OyHEEK676c6Tiu3dXnIRURP9gSfrcjewKM0ooAKaoqLPpmkCmy9Fw7gxdVLJCprVoe8IeAuwFQA1xNyCnU7YW7FTlwTM7Ha3jWe+ZHiGdwBEL6y7G+SeiZI26W0ujQPjhibUWan5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miLotIu6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173a00e8so1099614a12.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414799; x=1757019599; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGbtAanHwJsYpi+gKw0B1Q2WKIP+LOp/w/vCdXt5U2M=;
        b=miLotIu6NY+j84lU3g3OBJ0p29dLbElMaOJoMO35hiFnAFRLs+W3ldmKXfhwnKC5u8
         btI8ZNN+RflAAEEFWJxdjFQBMSVuR1zAuzOg9hd8woStrdwGbGBoAh0TLIcgCT9YiKWJ
         Vd6Im9fVsCLlJU1FUX2e4pnJMG6UcPI1EUEqJsiu3+MB4UoEWAF9Nq2Efad7GNrBBFZK
         +WC4pKlXDgQ/1ynCFVot46gVvh5My/e9e36kaJbCXQ08Q6OHZjdJobOJXXdAWDm+uSo9
         OEoCREGaGl3vkkvNYCNE6f+HsLrNMD01gWzjDza0vJClVKM/3JOXRUfEl6V434zxs8iz
         qM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414799; x=1757019599;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGbtAanHwJsYpi+gKw0B1Q2WKIP+LOp/w/vCdXt5U2M=;
        b=uKz1ieb64aLH5t5MdsjT5pWLrR8rlX8Gv3oWVfmshOQaSMOWFS6ga+kbxwCUgLbLA2
         ntGs1J6TkBoOaJVy8gjlu6IDNfk4qgP0hXYdNgeBJqndKZYKHaZuWmElDueiIs7pZ+jG
         3AKKCZ9/ndd1rSEu32mAMBELQ220McfNosaIxpSJfy5tVF0bHv9jfCIMcmden+npyXuP
         uHkfmUWbC+qUKJiKAjMrWt+zWipWXiKHl3TsAwK+2CwS5d4moSYSH75JtOh5a/2DPwyy
         yXCzAjCdqDp9tzwmxhPf43czHndf5biiU5tKDBmpRffR3UxVgFkTISKHtITsWf7jj7vB
         YJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDrN0MsQE6qMG9ey01j/na/h1AlWhJ2r8EIzLoBW+AAOslk4AJ1Qfm/O2lxDGO6bvko7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo837zrIz738L6gSqhGm81QLDpdSxLfNKwh0yhTVpjw/ODxyKq
	EWxDxf+F8WSbNaIZloM1/CZVkiDlxN8zWYNfJCyGeomDptZkF4cj1cDH+embdwL/r/vIm8mwojm
	SAU4tGQwXMw==
X-Google-Smtp-Source: AGHT+IFdefyLQO34sj4A1ixWXECAeiZq7r2EzcLpSXDbi9TBCsVPHSuMdwiB179fhnpzEKaalL2UMyJUPrrA
X-Received: from pjbsg6.prod.google.com ([2002:a17:90b:5206:b0:327:7070:5b73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:240:1b13:45a0
 with SMTP id adf61e73a8af0-24340acc9cemr38604838637.2.1756414798865; Thu, 28
 Aug 2025 13:59:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:18 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-4-irogers@google.com>
Subject: [PATCH v3 03/15] perf record: Skip don't fail for events that don't open
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
2.51.0.318.gd7df087d1a-goog


