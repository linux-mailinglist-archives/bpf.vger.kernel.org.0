Return-Path: <bpf+bounces-30075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CD8CA595
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036D91C20C43
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2217C6D;
	Tue, 21 May 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhsY+cCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF8125D5
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253500; cv=none; b=satIyXW5bLcrTKO9dI507ziKVuHMJhj4xfpFrCLFxZ7GChsBPcclhGc8EBbykTkcFEv/nZlKhyN0k6C07aAm5uovTj85AfWDddJQePzrhrv13OuG9plugAdGlbJ+AlTqk8+B/cEHsmR/3RRmWpw+3QM7rX//4CP8k0U1Yi3i0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253500; c=relaxed/simple;
	bh=tm50rM0/vPAY35AZcNIkh9G+ITQ1yOK+pmrR/wf9O70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sfWX3dopatvUDCP6hs3J0fvJjmH0AKDM43AubDyf4ONTErZAiAxU0fT9T+zIxJINHQ7+6AgqWhb+58QxlJdJKss8DWTFj4pfZoM52fRvshLp5ewVbGPxxfrb+vMogifV91w60M1x0yy+nkiQn+np1Oo6K6Iu30AZWlfwCsEAIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhsY+cCA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so196279987b3.1
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253498; x=1716858298; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=PhsY+cCAr7XDZ0WBjBUvM+QZ1IKYUQ15/t1EjguMDmRjuXzK8Fxb0JYaYTb6jy4asc
         1viy8m+Po4C+PbtWlDezEqkLC64x0rjoU4tZgDQOqXWejNfm3JU20EfLm6DrYBx0s7zo
         H4zK2d+T1C3UOwjzhGNBrVU0JFzgU52dGg02xzxsp6pOLmuAL3gYfaed4C71pi7eBONM
         V5ttykovbuDrw0aTLBDebOOy5yoqQ7e9tQP1NBFa9p8Jdc6nC2pY8j7KCJHo1kKteWg2
         bE7v2+N/KoWBE+gxPNRUHZ03bAPTZJqlvfT0734z7M7KAP+Ag0d1BUQA/a417IEMOVZ4
         NIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253498; x=1716858298;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=gv8gymX8K+PqhUtzVcfvkPvGdSMAjDsU7cXpFOq/k95EdA6QkDWsdlH31oSqi0yOZd
         BD210hftWAYGRU77VdsyrhO6P0NWeVwsU94k57/5To+vYwheEr4wkUIvsEuof6+rG6Cx
         37VrHVm+LyYahc2L9UpneYAiUs1G91DYX1kPUuHgSBAZ3LG5aq2i2vCHFEIOSLmrcpc+
         xmk79wi5XcWGZEdj0AbUdWUtti7VHie3lTvIJmo8ZPHxmTLvqVwdiryvSnO3AFyYA6ns
         XlPjrPpDCznC7JWTQUnIGhThAENilUdjhdhemYStGAkIciv8wB5tJh0r6TDZhnXrgtPU
         fKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXOgAQmwYymE1hI3uDyfODpqe2cns+EgaoCH+Qt9e+vGKdUbFv4mDVhe6GgJ2JIjWldPkyWS3YYPXniIE4eGEE/CLCH
X-Gm-Message-State: AOJu0YxjB7uKD0Vk1Rxgppzs8poQfzHUk2/6KexPHTR4DbqrgrL8sgQk
	gU5C+2+KFvg0styBuuNWxDuMx6iLZwrzZin9d4VHDZ4S3YVBmN3KwzezbfgiZvGFNtx1TfBNj70
	9GPK0ew==
X-Google-Smtp-Source: AGHT+IGGMNUxsCZXvQZJgIKjKb/6lz7R/hhsrwhgtgMFa+nJq21QIRiNY4KUgkjCzuVFVt4vQyYXYY0cZyvL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c83:b0:61a:d016:60ff with SMTP
 id 00721157ae682-622affabebdmr62868757b3.2.1716253497942; Mon, 20 May 2024
 18:04:57 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:39 -0700
In-Reply-To: <20240521010439.321264-1-irogers@google.com>
Message-Id: <20240521010439.321264-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 3/3] perf top: Allow filters on events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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
2.45.0.rc1.225.g2a3ae87e7f-goog


