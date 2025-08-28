Return-Path: <bpf+bounces-66789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D9B393F9
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC533682210
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE727F195;
	Thu, 28 Aug 2025 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bG+tmdaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7C27F4CE
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363363; cv=none; b=uMn/JDZKYbMwGqZCP68L+XXMjU7ShGcsmUPuwBV5xOxkXvAJSxed50s4SLlmvQ3c3sdhx4iHeT2iSY0Gt6hxGxsjW/4bJWZRAap00gWiQev5gx/eI3pikBrM5fEbyGkOrQ8eEBQRKPkk0zu97u6wkL6xO7hbePzTmA7k0qitNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363363; c=relaxed/simple;
	bh=w5HwRxXSuHh4BDKXY9Y6GlrpJNniZlSMRpcNiRBVfG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ueXHPwg/AUVTWomLHOeeoTyXpT6mKVUlC3hbz3LftJ+sCPjpE6dcar24MXVm+IK8UcRyvzV/MuizEC2bzaM/LtjFHU++OtEIlr2b5fm7ewOco+bYvGWcsYajjWHWL/TJS9XsXGoroVSaJOW5WvO4hqJJThTvCX7uEIFdz4hz00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bG+tmdaT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47173afd90so1093677a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363361; x=1756968161; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7723aLTTbwpk0OKE69im1j64z90sr+KFrAxNNuGIC9A=;
        b=bG+tmdaT+j7mezc8JtvpOoJxCelepjWZYmQbMyPynCuoI3XWbtH7lCpm4kICLLxHAk
         HiXWu6trsLvVUI0ZPFsL0brNGwi5oN6STvBxysMI0hEumTa31n3loqzPxDEyyd8ZfOrW
         /4nkIYRHypfERQxBEURnbDiC9G2aV4R3VCLrCmVRaTSnVLN7xFK7NSBUFGM3gp1yIBxi
         w58vMwRP8mqUxjw71kL6kTsj/D1M+Rq+Aut4+WHUjNsreQSD/4V2wUV9IiCjxFx126Uf
         sG7+6QB78j8cHzOjtTrd9/Lg4ziC+vCxPA0YDSNDlffrM3PDiZH6I7b1k7ojjFp/zgBW
         vFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363361; x=1756968161;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7723aLTTbwpk0OKE69im1j64z90sr+KFrAxNNuGIC9A=;
        b=gNcncluRjugX4NFa70+NxSDJ3Gd5NFLq0KxXyGAJYLGiPC8BZAdgxqVuVYkP0JG2e1
         bRXigC/kaxHrAWqxrZY7wbvYsyznFH5Xq1Ec1BXkF5LD43Efnn/PBB6aif12RKzHjOOL
         W/xv3XFTmZTVMfB+lvCfutB+jGQ0IGeU7osVPi/7rSunhIsDuUZaAwpvzWtRWq5VXwsi
         HLipRJP662g9Kg2NewaxqSXX22m+FuD/3zhDMflk4lTrG1aN56gp+sNJzIjTzb5Kjhtf
         3aV4iMwdKySCESeCP8osawPiYs/UfqS872oEJrFbg8uh4Zirxt2GFK3b4VeBWumfb8HQ
         l8hw==
X-Forwarded-Encrypted: i=1; AJvYcCVwqaJBfHlvHW1pm5pyX+bxTv1Qo6p6qPWO97lt5I6rMZ7m5FMvjllOlj9yZjf7OyxLWuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylI8qp285OIOlNn5F0UjOgo6X5vQPfUf4fztZMy0dLLCHUNxnb
	93zjlHT1DRw9x6ZgbRv8IRRhCy4uLArK3ANDnyeNZxsYZMRwRlWyeZLxpWWseCQ8n3bJs2yqqiq
	zaCHWmnkTWg==
X-Google-Smtp-Source: AGHT+IFbeAHU4OfT7gfZLVQ6IVB7cMnzl//AdU/jfgdD59GY8JAAK7VcBqvHEzl3NBqbXX+gXwVBcUpKBUCD
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:240:6a8d:5f1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2284:b0:248:cd0b:3443
 with SMTP id d9443c01a7336-248cd0b37f3mr41062975ad.12.1756363361200; Wed, 27
 Aug 2025 23:42:41 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:21 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-4-irogers@google.com>
Subject: [PATCH v1 03/13] perf record: Skip don't fail for events that don't open
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
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

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Prior versions without adding the tracking data and not warning for
cycles on ARM was:
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
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
2.51.0.268.g9569e192d0-goog


