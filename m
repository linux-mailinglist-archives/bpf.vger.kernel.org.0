Return-Path: <bpf+bounces-48149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ADBA048F2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE481629D1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401716DED2;
	Tue,  7 Jan 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nng0W8Mq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9281F427B
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273364; cv=none; b=CPT4jOuNKj84YaOSLnntgQOaLTWxMk/RHddncfTAdsYeDPaCUdRp2b5fSpne/rN4B1t4BuIMCuThTmsy/5KUI45VXgklR4amDlkLBTRQI7JlUFwK5zIwU2yr/4anXM6y5LvygULL29Zq1iAmP//EScP8TOHyjHGZqH37xP37osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273364; c=relaxed/simple;
	bh=K9n/++xGPh3y4Nwa4NW0TywaOLbQoC5fwQ8AFIxOBeI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=J4fqgFXig0viffof4hKENTqq82KT1yyALLcs1LqbCiVmeRC4rU2ex5+lXOoXUOEd8CGYj+d92DAFTMs79dJqWZR9u9nWM4wl7buwDmx63EGp7y+p76qTtdbiUGS3PcvLMRU2ibFi97jQBsLNbkwY4tHrBouddIkyd5NTee38BLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nng0W8Mq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39993d8594so35940432276.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273362; x=1736878162; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCK4tac4gxTH978HKFsny7hyfeEYdVg/GMG1pWRcbRE=;
        b=nng0W8Mqycqq6zOhmt6hvjotmegsZHR04CZ/pt2uVL7L6Y8zUbiuT5zEl3yPE4Cakc
         /PKz2NUuYbpME1cx9fpcHJIKlptRwL0SIy9O4j1/9BSHJda7Saa/AcmRqM8ByasSoUu2
         xsuNBAu+pDOxJ9Buq+0BKFmfXrSyhg5J4r24s3th+VCAHdgnuyPUuXpR2N41bVnoIS0y
         96Owzo+leFXRI/BA2CRT62dvWza1J6EIDHdE30KdlD+RVI8zi08qleVJoeiaBMIzEbBs
         tYtbbvMyWaHOsW89gGQZcV+7VNJYCHfnHg3rCDRMFIJaNweR3YEladsnnZaIDc73X2y/
         wlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273362; x=1736878162;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCK4tac4gxTH978HKFsny7hyfeEYdVg/GMG1pWRcbRE=;
        b=sCfBCVzYlrOBiCzMgcMBPfkcTKcmNJpBdb93Md6UdCtJ33xVsrOi+S8veQjysczW+5
         tKsGVsu32MvroGYyvHZVrzz1CMpk2bf4SvxfwSCvx8vd5WlSP1VyeFvqku5vJtIWVcqr
         Xt10k5fg9RryGM3lcVzQI86ncZLqa+OqCsWUTxXuVWm+2WFDVshIi0r6Nzq5z31nQ/K4
         QVdnhtjWnS9BGgl9gYmCb9M+IuvFLxbS9CFo/X1km4D9BKxNw7ub7lpMudrPvt4pB7Wm
         s8WKjKJId8myvmLsB0HxJQmtkDt+yM4OIPm9Y8iugNMEi5WEKOkuZJn5uFHQVqzypmNe
         xewg==
X-Forwarded-Encrypted: i=1; AJvYcCXvPBl9kIdnJCjXdOeo/8C447UUP6z5VANIRXd0FrFKBqveq0TTICZAG/n2Ng1ibU0YWV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1O4bC3CQalS4PFEUfBvn4USDiHDBLzv7ykCu6vZnx1FEI0T4I
	m1b8jYHp0NH+b53hX4/sZ9OHi+6z7JbhiI0H5G7fyEFqweCdtLgzLh1FcayiimMHUtC6HExBEUQ
	ehsKlWA==
X-Google-Smtp-Source: AGHT+IE2VwDPvmAGHpRpdoTRTEzWLqDUDpSCUeqtBAPlzdKHsyWBG/nxoOfSsi/dHSEKLUY3/D6ugR9tVMuj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a5b:305:0:b0:e4c:35c4:cee3 with SMTP id
 3f1490d57ef6-e538c3d6749mr163782276.6.1736273361752; Tue, 07 Jan 2025
 10:09:21 -0800 (PST)
Date: Tue,  7 Jan 2025 10:08:53 -0800
In-Reply-To: <20250107180854.770470-1-irogers@google.com>
Message-Id: <20250107180854.770470-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 3/4] perf record: Skip don't fail for events that don't open
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

This is done by detecting if dummy events were implicitly added by
perf and seeing if the evlist is empty without them. This allows the
dummy event still to be recorded:
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
 tools/perf/builtin-record.c | 54 ++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df..b3f06638f3c6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -161,6 +161,7 @@ struct record {
 	struct evlist		*sb_evlist;
 	pthread_t		thread_id;
 	int			realtime_prio;
+	int			num_parsed_dummy_events;
 	bool			switch_output_event_set;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -961,7 +962,6 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -1366,6 +1366,7 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
@@ -1381,15 +1382,50 @@ static int record__open(struct record *rec)
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
+		int idx = 0, num_dummy = 0, num_non_dummy = 0,
+		    removed_dummy = 0, removed_non_dummy = 0;
+
+		/* Remove evsels that failed to open and update indices. */
+		evlist__for_each_entry_safe(evlist, tmp, pos) {
+			if (evsel__is_dummy_event(pos))
+				num_dummy++;
+			else
+				num_non_dummy++;
+
+			if (!pos->skippable)
+				continue;
+
+			if (evsel__is_dummy_event(pos))
+				removed_dummy++;
+			else
+				removed_non_dummy++;
+
+			evlist__remove(evlist, pos);
+		}
+		evlist__for_each_entry(evlist, pos) {
+			pos->core.idx = idx++;
+		}
+		/* If list is empty except implicitly added dummy events then fail. */
+		if ((num_non_dummy == removed_non_dummy) &&
+		    ((rec->num_parsed_dummy_events == 0) ||
+		     (removed_dummy >= (num_dummy - rec->num_parsed_dummy_events)))) {
+			ui__error("Failure to open any events for recording.\n");
+			rc = -1;
+			goto out;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
@@ -3975,6 +4011,7 @@ int cmd_record(int argc, const char **argv)
 	int err;
 	struct record *rec = &record;
 	char errbuf[BUFSIZ];
+	struct evsel *evsel;
 
 	setlocale(LC_ALL, "");
 
@@ -4001,6 +4038,11 @@ int cmd_record(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	evlist__for_each_entry(rec->evlist, evsel) {
+		if (evsel__is_dummy_event(evsel))
+			rec->num_parsed_dummy_events++;
+	}
+
 	err = symbol__validate_sym_arguments();
 	if (err)
 		return err;
-- 
2.47.1.613.gc27f4b7a9f-goog


