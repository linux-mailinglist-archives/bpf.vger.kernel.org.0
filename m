Return-Path: <bpf+bounces-55681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF0A84B33
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824CE19E8666
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A5290BCD;
	Thu, 10 Apr 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZODvNjD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE8290BAA
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306621; cv=none; b=o1FdrfsyKC+GnEA9nMXRc9BKpoftvd99qpDy1jBXjWjSxzmYR7tOXhuH95dSkaySfThhMEeYYydjs+qkEwgogQKyOPZQxTGhRpjQUFCxz4AUCgAzH/JeYwYbk3a+YFF7vRTBhZeNyuSMuctEiLbQQvfXcpTLLzM7gSUzFm7qmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306621; c=relaxed/simple;
	bh=s5GHscAETkUAKivN7aAi7TLoUIfwAcyInliqpu10XeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iar/ksxoWGh8inWap2Oud2PF/Z7JIozQXkocrhGBWL2GQLlk2tYi2NyFoyOmCSA3G+9ugu+J6DZx7rn3XFaGvpBTyOVxhPLGejHV3FQmLlqb6uf+xSjm+/YnGo/+OMaY2IKkCrgxoD+xAbpLarw5ZQRnB6gYLsqpz3buOFpIqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZODvNjD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22650077995so15012065ad.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306619; x=1744911419; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYG+riLDNowuBXALSOK3FRVNiACEEuoxpGzRk7BH3E=;
        b=IZODvNjDHhp0hVT1YiiOpynOIh0lai1bmUA25aAwSe2DiF8tmSDoMXP+6IA6TfJe7C
         alnO7R1SeMQzjnn0HlRsMCKP73WXdV6cgSXQjUgXLLRXx5nGSR6MB8AT1sfWlQRuv8Dj
         n/vN7pZAamWmH0eGWnQhZXedti7u1FWP+CncjYUf7CIzdFEnu89O/efi02OBzBYhEmGX
         vVnyKcsEDULqUM/IeuGouj8GXqvNqAjwy9/PtYS2kBoFVWFDvz+2eNzT+MqfOSWwuKVK
         iLKBK2qGw0JJNe+3FacBkw9AJiI1SSntNucpFhum3zS5fgckYb0QYoaKZ6DeaFWEgtA6
         3h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306619; x=1744911419;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYG+riLDNowuBXALSOK3FRVNiACEEuoxpGzRk7BH3E=;
        b=o6uwPXaswni2zTtWmCjD8oqKwgaU+I5Le0ZnoH92c+XZImedCKq8lXj1uq0l27QA1t
         Ayva3Ev3EXVSTPu8Yog+iG3JGSSDngsqvArAlSA4GenzuQeDcJvwuO+9cRNt7rGLNxdd
         zbqdMPM3yeHusbCVpzsVpgrIugdpxW3MhJ6G7OFPTUxH854oibdLxs1k4+vGcl+Hvsk6
         oKuOFmAsNV8kTVsqGkJxVCeTY90SlhotjVjZ7JYENKcU6Zc4pn9lZs5oNkKeBPevq0AP
         Ldhesv288kD7jbs9/m9nV9Nr9gSiUM2/MjmoBwu/+MK4xgnq1OsnwUg0yN06mVVXnHnS
         L7+w==
X-Forwarded-Encrypted: i=1; AJvYcCU45p1dTbLjza3nzNIxFNQM3gwOKSu7r27p6N+aXO01vh1XX5K5ezQXhLM/v5HgV2dAChI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mr6pj6ehzAqbpji2xO7y/vZsFSxPgGY/i2eBXWh2YGIXtKdr
	8nn2TZMREk2nb7AdplGJFdzjCEfmfGZmc4mFmJuWOuFEYVjeLtT9Yl8sSK/2YtlHqckL0C5Z8hf
	64qye1Q==
X-Google-Smtp-Source: AGHT+IGzIUP6D1cwLaSTj/gUi3pDoC4nLxOcZuHx9s7cibZ6nls36gURzWSfZGyGYDQBNmN1hxObG/FtTqx1
X-Received: from plge17.prod.google.com ([2002:a17:902:cf51:b0:223:242b:480a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:948:b0:224:10a2:cad5
 with SMTP id d9443c01a7336-22b2eda468bmr66678385ad.10.1744306619427; Thu, 10
 Apr 2025 10:36:59 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:27 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf top: Switch user option to use BPF filter
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
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f..9a7af69b7c73 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -642,7 +642,7 @@ static void *display_thread_tui(void *arg)
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		hists->uid_filter_str = top->record_opts.target.uid_str;
+		hists->uid_filter_str = top->uid_str;
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
@@ -1566,7 +1566,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1757,15 +1757,17 @@ int cmd_top(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	status = target__parse_uid(target);
-	if (status) {
-		int saved_errno = errno;
-
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__error("%s\n", errbuf);
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
 
-		status = -saved_errno;
-		goto out_delete_evlist;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
 	}
 
 	if (target__none(target))
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 4db3d1bd686c..b06e10a116bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -88,9 +88,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else if (target->tid)
 		ret += SNPRINTF(bf + ret, size - ret, " (target_tid: %s",
 				target->tid);
-	else if (target->uid_str != NULL)
+	else if (top->uid_str != NULL)
 		ret += SNPRINTF(bf + ret, size - ret, " (uid: %s",
-				target->uid_str);
+				top->uid_str);
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..04ff926846be 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -48,6 +48,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	const char	   *uid_str;
 
 	struct {
 		struct ordered_events	*in;
-- 
2.49.0.604.gff1f9ca942-goog


