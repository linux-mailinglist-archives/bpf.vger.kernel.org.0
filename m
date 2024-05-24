Return-Path: <bpf+bounces-30531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A38CEB88
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA782814E7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832B130A48;
	Fri, 24 May 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFeyMUOh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197F13048C
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583974; cv=none; b=m7Xq6BILUsFoHgc1BXDTlaF262PCRjV8UnVdQak8X8Lw61OCKnkPfRFFM52VlUPIwkbQyN4R24GeW9VRS9mPWwTsOqogUIHcvp4PFZ++wkfRhL4RSK6D7xt5kaIrFDoalITKxfwht2sqoIU+vlGOWoJCkI9Ek9iQ77v6y0fDdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583974; c=relaxed/simple;
	bh=T6StSA4MlJBF2S7oG9VD3Lo7lESuYYgHE4TziCebXc4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DrXBHR5iEhNeRpDCjI7UsHIK1IQub5ca9rxaJOJFi0Q3NeCJHKRSWcjX83kQuwy0j7NyL1ep+G3wZly00oSWF/fzp9SdHK7omQsh04TbuOuDWfUCX+Ok4InU3hubYStDaoJ8j8YlH9UvdNpHKs4WoAQyGxDDShauEzKVnA/5fnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFeyMUOh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df773f9471fso1125207276.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583971; x=1717188771; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5S/1+TbdrNyqVdsVMC7pvcCEQxH3ljnz+UDUM5b9Uk=;
        b=iFeyMUOh1559/P6oc3LOo4brRks+a7ARCS5P+24feQSBxLhqgKIVjZmoT8yKb52EEp
         F4UiyZyZUZnesVk9tsmfup6MfN1azSUySaMy0tW9bdRzqFOZ7PtXlxDSnk7yr4boKUoX
         oUd102CjOsKPxns0XihfEu2NDoEeq8NCmC+4C6B5Qw96uA/qS64vbo5ogzH89pp9f3qT
         tXmaj6m3Bl9bPS4O+Ss+3QmRLgyJsqI+oaiGpRXZV7XcVpHfHzrLUpB275aO5hs+94rC
         +kTyVcC8SmfgXxp4TzlL4QLZaELyL709sS+FA76TolqcHlAgr+8ogMalSJkzzVuaXf4R
         1WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583971; x=1717188771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5S/1+TbdrNyqVdsVMC7pvcCEQxH3ljnz+UDUM5b9Uk=;
        b=wX841BD4H3pjwh2qSRtBUjJqh78eBqDEtqemiGH0w2md4E7YNySqoAIIh5jTX/Q9YO
         wC4/3r3q9o3rwGTjDrjt+2yqiDhGNHdWSuzND0L0eeVrqLM9EkqICSF3O2Y6KVK6saj2
         mh54zPwcFLWXFvC3dzbHIM4CtwafgNy8N2YAdYECIQKe1hqPRsK0CUBYsyutaEn9tr4F
         13ZFKEURbXU0dFb7Oog6XawviBL0LgOThR085P6/tYcXXnOYODmHwy8RC+I4xWaspIti
         WtXhIBFY54PAZiHjBqaT6KN40/prPFpTJDzfBd0jZUKGSfqiOyhkdNXFlrDBPy+rkX5g
         1jTg==
X-Forwarded-Encrypted: i=1; AJvYcCWtD60SM0jGfoTl6i01hq28XXZh1r4X6Po5bViDOSrMpya2F+Na+Lf49ndnBNJfaf/vWwY4AWDjnYBuSF1s/VBTIvPf
X-Gm-Message-State: AOJu0YwZ/4lP95Kp1FQVoRB9/N0LBK2Efc3tsa4T+6wBtDPSFUIckgmN
	YLtRfsIxlu2S9FDKIcDnFUzcdK2yRGPwZJOLjs48DRxzTLMW27ARmCyuaIf/Jy40UN2J0zhLkT/
	aFNoNUw==
X-Google-Smtp-Source: AGHT+IEHCtPO9sX5jtzbEfu51zLGPCby+BaxuDoXVGuIQbLvlpbjy3tKFd1KXX2w/7yRvzQtPUu7PhBrqyTm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:df4:90aa:f4ac with SMTP
 id 3f1490d57ef6-df77239babemr841669276.9.1716583971616; Fri, 24 May 2024
 13:52:51 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:27 -0700
In-Reply-To: <20240524205227.244375-1-irogers@google.com>
Message-Id: <20240524205227.244375-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524205227.244375-1-irogers@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 3/3] perf top: Allow filters on events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow filters to be added to perf top events. One use is to workaround
issues with:
```
$ perf top --uid="$(id -u)"
```
which tries to scan /proc find processes belonging to the uid and can
fail in such a pid terminates between the scan and the
perf_event_open reporting:
```
Error:
The sys_perf_event_open() syscall returned with 3 (No such process) for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```
A similar filter:
```
$ perf top -e cycles:P --filter "uid == $(id -u)"
```
doesn't fail this way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a754875fa5bb..667e5102075e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,10 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--filter=<filter>::
+	Event filter.  This option should follow an event selector (-e). For
+	syntax see linkperf:perf-record[1].
+
 -E <entries>::
 --entries=<entries>::
 	Display this many functions.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..e8cbbf10d361 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1055,6 +1055,13 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
+	if (evlist__apply_filters(evlist, &counter)) {
+		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
+			counter->filter ?: "BPF", evsel__name(counter), errno,
+			str_error_r(errno, msg, sizeof(msg)));
+		goto out_err;
+	}
+
 	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
@@ -1462,6 +1469,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
+		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
-- 
2.45.1.288.g0e0cd299f1-goog


