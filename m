Return-Path: <bpf+bounces-55682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B94A84B3A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DCA4E34AE
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81729345B;
	Thu, 10 Apr 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3fKEn+P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636A290BC4
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306623; cv=none; b=qZMMpkQQepa2StCDiGLlg9uc2TNIZA3nmyMBoMtVDxABtKvL/VgDq+hyKvYQSuGxR5aojd8YNJghhKj1fWNlKhwBrtKSQHrtBITnp1nB996ZMhv/WiK+dBl8hEkyVblhsqEbpREvuulP7/lnj8LPzKMKHhavczMzG0GFjOCkYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306623; c=relaxed/simple;
	bh=pwnF8n7mqD7yk9oNBMquJdU4/lh8MdFnDzv/GA7kVio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e6G0X6EVKQ/GODO2108HDrKdPixe7vmAH/X/pbfU04jWFNmNkHpSLjFGbOb96v2R0cNPRZfZ9FYC68eXK6mkUKH8IA/qh99BQGlAHoviUT/Svm2Rkcz2J0JPZlOmhciAYe5qFcB1ug/VDUtJQJDm2rh4MtBHrwbPTD6dCArwq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3fKEn+P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229668c8659so8597715ad.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306621; x=1744911421; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpiUUvwlwp9tVCnJZ3TZUgEjsv1IVM8EEnnesVuXazs=;
        b=h3fKEn+Pz6OSFVCpDOszljZHfQXr0dLfzJkdBcKvgw+KCKrIsC8oXNEnmAsSqd9rEf
         JsmxFNiaOJRHgiYwgxRXodaSSnIs1hr5cDAri1SxncQ/BpUsvBqXNtW3IrExpseTdSz3
         QmNbeiQ+bw2+aRuD1TAt/k4m89qeFxvhZLSHgrzKwq6zPlOEMzPHk68PBwMjpPjTmoO9
         Mek7uXnINWAXZspY8ey7YOW+xQtODVaeCKzoEe07KFsCU2XTCuX7Nl8/gFGGCmDcRGpR
         T8HgJiYrvAlRIfhKkvcoqm4N3JLm7jiQbv1O7jENLfE7pvjmp/BhVIFiBT+RJ3PbpnAj
         wg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306621; x=1744911421;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpiUUvwlwp9tVCnJZ3TZUgEjsv1IVM8EEnnesVuXazs=;
        b=pgRX10SNxfRV68S3/TBc9BFJaaYKLBrRVMVTGyDnWzX3ovIALnxFr9QQTE4D5bv8pU
         nFzdwwVHsrGpTWWHrTQ8yhyJTGWuJcctWH6Ex3XPZf73JyA6QhxfKkkz93upzGnJbc5q
         tSxNRL5ubXNSaI4Bphcp3KmgTI4Xa0pkQC3pepsblExUNIISHS8O0mFT/0RPWHm6pK32
         p3p2SntWhtV5lkw9wyaSUbIzAUVoDQx6zKp54fNoSOklRto0p3CwZ7OF8iMKAyz05uQJ
         WEmhkpg2O25+tWP7LBwc5Nt//XVelsVybL65PnwqEnM36JPrTgNMd4y7eURq8oDTAZbb
         23KA==
X-Forwarded-Encrypted: i=1; AJvYcCXF7f37Y1CJDqVvEnos0rS9c1wrh0ZELgzZMRp465Cl3HgKQ8FAwgXEkuO8wGc33jBFQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02NX8Vcucb7W9yR6akNjsV8iIA3DOPi6uhnHEeLY+2Fd9jA8T
	SV6V8zhPDAsRfuHOk9iEFESRH5DvH7UARB+bnePcalAdAfGPXuw+up7gBfy85ZGoIpfoc371PbW
	arptFvQ==
X-Google-Smtp-Source: AGHT+IFwaCb2cDgkGC1n4/9Wz8pIMyxoLX83dVD19SJR7ZPEQ36S8XM3cNeUAEqdxlEjEYtd+dxtn/hNSjdL
X-Received: from plbml15.prod.google.com ([2002:a17:903:34cf:b0:227:b826:af9e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120a:b0:216:2bd7:1c2f
 with SMTP id d9443c01a7336-22be02f73bamr41067965ad.18.1744306621413; Thu, 10
 Apr 2025 10:37:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:28 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-10-irogers@google.com>
Subject: [PATCH v2 09/12] perf trace: Switch user option to use BPF filter
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

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match. Ensure adding the BPF filter forces
system-wide.

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
2.49.0.604.gff1f9ca942-goog


