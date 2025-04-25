Return-Path: <bpf+bounces-56743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72770A9D44F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D904C511E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FE2417C2;
	Fri, 25 Apr 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0OtR/n/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6C231CB0
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617239; cv=none; b=Y3iOHnkjcyq2Hr0cUp7tvWzgrthuf06XyIom6u2S3JdQzeC/xieEJSXBVpexuArRyKah/ZgyM/6ER0uX3387p2RxvuQrMyKrnzXgxEmf1m57ODcNrjYx+gRgPdBbjdpRYG/RnwzuKRaGUGcPDw3lKFbxf0wHyZoHjAF9E91YS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617239; c=relaxed/simple;
	bh=Mowkv5qqJ/F5GpiVJf300uqyE570+zdeev7heuBS7dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cyFIVfJrjHZel5g17BZfhdT0mSQLXIqkgKc4KZK7dUxlP4yMvrXYcZprS22fhLb4zHoiEgU2eWGSl2CKmOnoGSGlrkxznPLbJR6nLAiTNPBLQqIap++unwmP4VG82XdaZXlVUvvqR47UqgS/aYC+XL9pI7gau/wNlns7DclCzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0OtR/n/; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c6eb3e0b2aso877545fac.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617236; x=1746222036; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCiBNIgyIq3tfdIckzwQPIYGTlpSc1MEqAHEJmYBsOU=;
        b=F0OtR/n/fQy9LRG4SVceUixQ2QlE6KkYITdo+2Pt7T6YykS5pU0Moo8Ahn1W953rHH
         qq7qQL5wP0Ade5NzXr9nqEG5JEkaP1KnIP277FFN7y5gOqmy59OFzAZAqd1MNcqqAmQQ
         YeFpUPWNcEiSnotllGFyOHZaaE+p+yDzjzxxauv/2TSkaAcwYeJap7oT3uhjdV1E80gH
         vLHjYK4JGUGbob3Lqj0M1GIICHKcw23LjQtMU1KIfbc/XgaqQ6xsbM6tEd/uQH9n8WDM
         C2lIBYTrFd5s5j9uDgBqz8KjvxsJEijmbSVfFiKa2aFEgkOCX4C4/dHBEaryP7SLqaT1
         Gwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617236; x=1746222036;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCiBNIgyIq3tfdIckzwQPIYGTlpSc1MEqAHEJmYBsOU=;
        b=uv9IxAtplxhMDx6uQv+fjlxLcuOSaC69HZQ5Z7+bc2MsYj4hmr7XIYRhPj3Yq1vCOY
         t/69KTEZRg8Cdr8PGMaTqk02xG2Loymj4B6ItAnvFQDggJJdB7wIw/2gFKLzKympAw78
         kXsRwgoyRNGiaDZpE1l3yCffrxN6cJSex9VWgzi8ZENoEfseLTYqJju6jpp4mKmgn3/r
         jayY7BewOIldT+dY0HDw36GmQR5PAjjNi49dylWou9LY9yqSPQ8ILkUOjcXulWcjnV3M
         e+OAAfhU/O4H/6hziDya783QndfbATKgspa9w8Lhd1Q6znVnwdjTFW3Gx6l8kLuCqb+r
         SDpA==
X-Forwarded-Encrypted: i=1; AJvYcCVePKV7uIHkUJE2NZ6GTdnKIytKUnCsHa5v6n0ZdXeurVoYlU2EWXqWPocdxqP+4q+j0TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCXU0QX9huXiPwIZC7uugCXrpULbLJEpk6EZHm8aVIV2kSv6y
	eR5CpgnYceDTcePbuCeBVVuAGmi8gvM6tcnkcVfwYWvcqmfvNlZxh5gRBnEG0hxhR/b/edbcJaJ
	Vj1RjoQ==
X-Google-Smtp-Source: AGHT+IEa2FLM10jcrrl+uJoBC09nP4IVEXI2lkCp+TFUaATjK6bauLtKrDXR6U2I/yDoVJ3h22f3O4wgOzrr
X-Received: from oabwc14.prod.google.com ([2002:a05:6871:a50e:b0:2bc:6267:d082])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:a1a7:b0:2d0:3078:e72f
 with SMTP id 586e51a60fabf-2d99dc404cdmr2537739fac.26.1745617236166; Fri, 25
 Apr 2025 14:40:36 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:05 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-8-irogers@google.com>
Subject: [PATCH v3 07/10] perf trace: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing --uid option finds user processes by scanning
/proc. Scanning /proc is inherently racy due to processes being in
/proc but then exiting before perf does the perf_event_open. When the
perf_event_open fails perf will terminate reporting errors which is a
disappointing user experience. Scanning /proc when perf starts also
cannot inform perf of new user processes starting.

The ability to filter perf events with BPF isn't new, and has been in
the perf tool for 10 years:
https://lore.kernel.org/all/1444826502-49291-8-git-send-email-wangnan0@huawei.com/
An ability to do filtering on the command line with a BPF program
that's part of perf was added 2 years ago:
https://lore.kernel.org/all/20230314234237.3008956-1-namhyung@kernel.org/
This was then extended to support uids as a way of filtering:
https://lore.kernel.org/all/20240524205227.244375-1-irogers@google.com/

This change switches the perf trace --uid option to use the BPF filter
code to avoid the inherent race and existing failures. To ensure all
processes are considered by the filter, the change forces system-wide
mode.

Using BPF has permission issues in loading the BPF program not present
in scanning /proc. As the scanning approach would miss new programs
and fail due to the race, this is considered preferable. The change
also avoids opening a perf event per PID, which is less overhead in
the kernel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ac51925ea42..1f7d2b3d8b3d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -240,6 +240,7 @@ struct trace {
 		struct ordered_events	data;
 		u64			last;
 	} oe;
+	const char		*uid_str;
 };
 
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
@@ -4401,8 +4402,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.pid;
 
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
@@ -5420,8 +5421,7 @@ int cmd_trace(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
-	OPT_STRING('u', "uid", &trace.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5762,11 +5762,19 @@ int cmd_trace(int argc, const char **argv)
 		goto out_close;
 	}
 
-	err = target__parse_uid(&trace.opts.target);
-	if (err) {
-		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
-		fprintf(trace.output, "%s", bf);
-		goto out_close;
+	if (trace.uid_str) {
+		uid_t uid = parse_uid(trace.uid_str);
+
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", trace.uid_str);
+			err = -EINVAL;
+			goto out_close;
+		}
+		err = parse_uid_filter(trace.evlist, uid);
+		if (err)
+			goto out_close;
+
+		trace.opts.target.system_wide = true;
 	}
 
 	if (!argc && target__none(&trace.opts.target))
-- 
2.49.0.850.g28803427d3-goog


