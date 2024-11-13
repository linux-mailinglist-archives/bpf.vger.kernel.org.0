Return-Path: <bpf+bounces-44702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B39C6694
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6057B1F24C7B
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0417083F;
	Wed, 13 Nov 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xB2D9NgJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73814482EB
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460820; cv=none; b=TOrHmy2jc1LdVC6Dq7jFN02Kn69t2KwjkmSytJ6UTDy6kH4IcQ9jftLLS8B8sOjWDb6iO78ElbYZoz3btEWgSN79fTCiuF0Et5Y1jd4Yx4xgMOb6ojbSnhL5NzkEgL+HJbdBbz795R6a6mZe6azxC3nJzBejWuTaTCxN/mDyaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460820; c=relaxed/simple;
	bh=n9w2lHyBaHMh90Mv5ft01rkntIchm6aO8DYYWUImzSI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=IV04nT0H4JJmVSz0vRj8gFP9p90HQwD+9CY01Ds3wIaU1t1ZLR1IUtHQkzAbO2ooLOE05JbjVAR4tYcYjGpnimL1XeYN454GsybOTzljW6LGCgIkal7i1B8uPrMeINOtln/w6WVCoRXSDJlsRlHT+oLJ75h7gGHwL4wXxTURarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xB2D9NgJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso121053847b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460817; x=1732065617; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Judfv2fPoYyzswryZaW1u3soz+KrsbfIeWzwfN5wCQA=;
        b=xB2D9NgJMcRLDNFs1+xd9iqGzJXEd5wnqMARrTiq8BwrfsKWZK222nKoe1q97a253P
         cdfELhCl865cF3rCz09QuhooxMvFON6BQIObi1ZEt2J+AcvN6xlaA6NHS55BdrgPm6n3
         ikzlqug5JlhbyiFD1w/B8pcm0eYqn6/5XKNjKO6+4Nki8Pp0PjdKUVjAa1zGwx69nPbA
         0XSIKA+TVvuTb5EeFoYeVtP72t4tEqzCAcehjNX949hKujNwVs++SqyGSr5AlsKTa7EU
         dJbcJ+DnqjEtjlTrr+Gaqpa7kBnUlUX/a/rh3WM9hl3mKOi35iDs65ypuv52PcrDWrGA
         YL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460817; x=1732065617;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Judfv2fPoYyzswryZaW1u3soz+KrsbfIeWzwfN5wCQA=;
        b=hOCrFeLobn4OsGIYSuiamhO9Hkax9+dXgEy7IIm+SXcC4aaBoohsLXHUjHzwMZfPN/
         jhZMcttjq8jpcVq/VXex224VrdW3/0KSP0rc4QOsO/QPYbwhgAJl26mL1eVOiJ32Anmb
         QZrJgiFKY2NTVm6EIeNNWwS6GI7P0LLknf+1McEhfiJDtS+lzG/ydSw1qgkaG8L+/Xh/
         5kz6jRKwQ3b4uVADyhieGqC2NUkP36X1YEUWKChnpsygYiraD9O2TlPmaOr/8+lmaza8
         bEWJ+Imchu5k1f63ejSf+jnG1lLP2HfCKHS0pztuCswOkyqyEqRrMC4t1Lfwu4MOcEuO
         i/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWVgHaeGr/k4jS7bfCAqbJ73w0U0YYCy9eRM5MmbIzxBuHAbh1KwQvoJJy4joTRkyjcdJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvCCacWf7Kk6b62JdMIgIDcZwWXSrzgz6ew6dwGqBj44h7+y5
	xhQTbc5ettWi57ONyhPr18GB52z0aYK0BYHMnONKxI0Gpe/bq2VkJZV1fhAD36BYrxTb5g9EyMy
	lxTzAuw==
X-Google-Smtp-Source: AGHT+IEO2RQDDpW51F8uI7K8/e4j2gKuwfS1YS/fc40tqkrxefg7iH8J1s9ZNxLH1sj7Gl29QxIvEd5IpugF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a05:690c:4043:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6eaddff063dmr1343747b3.8.1731460817690; Tue, 12 Nov 2024
 17:20:17 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:55 -0800
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Message-Id: <20241113011956.402096-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 3/4] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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

Note, if all events fail to open then the data file will contain no
samples. This is deliberate as at the point the events are opened
there are other events, such as the dummy event for sideband data, and
these events will succeed in opening even if the user specified ones
don't. Having a mix of open and broken events leads to a problem of
identifying different sources of events.

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
 tools/perf/builtin-record.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..7e99743f7e42 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
@@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
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
+			pos->core.idx = idx++;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.47.0.277.g8800431eea-goog


