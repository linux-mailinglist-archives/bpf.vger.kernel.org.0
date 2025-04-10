Return-Path: <bpf+bounces-55675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9278CA84B25
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE36D460FD1
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457FB28EA58;
	Thu, 10 Apr 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZ2je+Ut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894B28CF65
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306610; cv=none; b=kgUHk1W41zCyu/vE4e/VdrpLV0Po0qrvOqsXp7yGAhSJztXF6iqWtNbq2NyJmyjshC071EYTtUNwBHFijnIsFra5UfJ1p9UZzzwbJx5Fz78AEZV/LEf4Rco3UMR8G39UfvEP69e1aHgyQG3JNrXmNwFDvfCK+VV+cyXqMa9xXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306610; c=relaxed/simple;
	bh=G1gAgZUvOfcfqAATJ+QPOb6uS3I1bA5GRxZVqHLeqq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JMHwNxFvGPkWIp1djy/S3c6+bB1n6VHvH3Nym26rzynAKB+/kIlSdfiLOuBSAAS0ADqhQtcNxkurwgLVkZwR42kcGXBR1k+gsmF/CkJm5uQdNCOzg6iXttgwUNqgWtw3sq3FWweaqbN5rOv5Jajbeq7jEHkn3Fcus4n8lhmDyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZ2je+Ut; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso13033155ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306608; x=1744911408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBep772rAPnbEAws0gmIZzBWpvWIV/iE0VJyGXGhVdQ=;
        b=nZ2je+UtpxEcOJRbSuZk1OVhBg5siLcwYycv54wdQGkfJjDkrHZFWbpZm9hnJye/KX
         oOuZJtG89k+bnXN8h/Zt/12gxmGtxsj4PNSrkqDxmkdjj7g6vbb96IRsUo3ylccgeqIk
         aN61sgvqFWEed+KihjidyRa9rkQYNohtLOGq/doePbdJTEEtFUclUoANte8l/EaLV4o6
         UHxPQCj6D9Lkynms2mpVy+6Oktspp8z3viXLh1R17vO/Z+nH8kRo3BgD07tRy7zdAKCc
         /85VPmWfS6Tvg1owPSpaCRc/9C42hJeCcJjJ0VlzJhhhxrGfn1t/Q9eP/VQVecXsNPVF
         CXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306608; x=1744911408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBep772rAPnbEAws0gmIZzBWpvWIV/iE0VJyGXGhVdQ=;
        b=vaLNMiiWj5cI65N72V99FuX0tvr/7gI3cLuEI1alPm52AM50Vg8JUq3cOgOevLLWOk
         kI1YFogp4FtcZ3cyWXWRpCLgdGK5ePQOHug2nrtQTyrM06PgALRWRaf8HIlZom15L2H9
         4aadee92lAAMpmLdZkQSlYIb5aq+96mCkZWtwHJEVMP8uFYptOBSGQfvkSTLxOwV2MrL
         EVK997c0om2L2oI3TYvIseuhLpHB3kJoNFf3CGQE4KA0Bk36bVmid9FxjFC547X7MAUI
         loFJVZ35FI0Jcxpy/7NyFltA2121UEsT/ICKrk78oq2IcYXXQaFMFqAmljmtMzwUdLvH
         zXCg==
X-Forwarded-Encrypted: i=1; AJvYcCVl+l5Epnnf6EIxFND4pJTcVEfzKkyR1HTnt5iXCMM53UoAwjHHLDY9TspGeOvr4V6fh4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKLzYs1B1gEKY06u563T0DvqhPutLtrZBwqcUxCFWYvdwQzRg
	jBEnouOBBjDYA81r2FIMnNzESDIn8vKr9zBEZU1Lz7PB4DIa8hhbFkL8RMVX/N8a0MUj8+yFxNw
	QoFZ++A==
X-Google-Smtp-Source: AGHT+IFTo0lN/DGGBZMtGdBm9V4Gd+ZDzBjeI4vL2FnktYYk1TbWtujx99ZirSakEtrM/OA2kI73D73SRWn8
X-Received: from plal20.prod.google.com ([2002:a17:903:54:b0:215:48e7:5dc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cc:b0:21f:617a:f1b2
 with SMTP id d9443c01a7336-22b42c5bd38mr51689375ad.46.1744306608453; Thu, 10
 Apr 2025 10:36:48 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:21 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf bench evlist-open-close: Reduce scope of 2 variables
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Make 2 global variables local. Reduces ELF binary size by removing
relocations. For a no flags build, the perf binary size is reduced by
4,144 bytes on x86-64.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/evlist-open-close.c | 42 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 5a27691469ed..79cedcf94a39 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -46,25 +46,6 @@ static struct record_opts opts = {
 	.ctl_fd_ack          = -1,
 };
 
-static const struct option options[] = {
-	OPT_STRING('e', "event", &event_string, "event", "event selector. use 'perf list' to list available events"),
-	OPT_INTEGER('n', "nr-events", &nr_events,
-		     "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
-	OPT_INTEGER('i', "iterations", &iterations, "Number of iterations used to compute average (default=100)"),
-	OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide, "system-wide collection from all CPUs"),
-	OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu", "list of cpus where to open events"),
-	OPT_STRING('p', "pid", &opts.target.pid, "pid", "record events on existing process id"),
-	OPT_STRING('t', "tid", &opts.target.tid, "tid", "record events on existing thread id"),
-	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
-	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
-	OPT_END()
-};
-
-static const char *const bench_usage[] = {
-	"perf bench internals evlist-open-close <options>",
-	NULL
-};
-
 static int evlist__count_evsel_fds(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -225,6 +206,29 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const struct option options[] = {
+		OPT_STRING('e', "event", &event_string, "event",
+			   "event selector. use 'perf list' to list available events"),
+		OPT_INTEGER('n', "nr-events", &nr_events,
+			    "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
+		OPT_INTEGER('i', "iterations", &iterations,
+			    "Number of iterations used to compute average (default=100)"),
+		OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide,
+			    "system-wide collection from all CPUs"),
+		OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu",
+			   "list of cpus where to open events"),
+		OPT_STRING('p', "pid", &opts.target.pid, "pid",
+			   "record events on existing process id"),
+		OPT_STRING('t', "tid", &opts.target.tid, "tid",
+			   "record events on existing thread id"),
+		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
+		OPT_END()
+	};
+	const char *const bench_usage[] = {
+		"perf bench internals evlist-open-close <options>",
+		NULL
+	};
 	char *evstr, errbuf[BUFSIZ];
 	int err;
 
-- 
2.49.0.604.gff1f9ca942-goog


