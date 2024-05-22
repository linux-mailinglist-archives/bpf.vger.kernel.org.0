Return-Path: <bpf+bounces-30339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A658CC85A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B131F21DB4
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B51487E4;
	Wed, 22 May 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXosBCvd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68641148319;
	Wed, 22 May 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414981; cv=none; b=s7bNhnllA7Xr5znOSjVvxSnYU54IrQ4WYSZXAzb2P6Tawv5P6ZBn8VAFRF1bfWstQVxKow8IipncApdI8Sx/GFcmZSjJA1iEUIwF0+L22lldLM/XXXGOxxMxVa3n+idBsfpztGcp0hS3B/OuH+v2bVHn8J+ZDdLlFMKDsar30d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414981; c=relaxed/simple;
	bh=g2LbaED2hm8TXq5ygOtsvI8bLNm/2ntxIyuanbuwyZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szpx40QkLWDGR11XlY1ziEFY09C6rr+eWzrjhk270ksTmI3mhaYOhJ0xQIEv0mPtIGhJpwy7aPhDbkzk+jJb0m6fP0+650OTWBcgMfGFajqWAUR6xJN6ZsVNOhW+8M19R17jRFKImNF/33AWV8vNtyErIDF9BwvEHqziZcUoKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXosBCvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7921BC32782;
	Wed, 22 May 2024 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414980;
	bh=g2LbaED2hm8TXq5ygOtsvI8bLNm/2ntxIyuanbuwyZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXosBCvdU/fmRy6bqCBGtzQyBuZKubysDv6ibov1FWnPsNPqWutySDKYOTT+lU+sm
	 Ha3GQY2wuNpPrTRrBibpKrBrRxkHqXfK3pvg8CTelvO1txLTTLAt/+kY9SG86JCLiO
	 JbbNVV8/5IlJOEHzenYgn6RffVfL2FMu2o6IX6yyNuabLHBPRFk5paGIExoc63xkcL
	 Eo4VFXMXAiQafUbhwGnVttz7+C1mfzyYiUtCfj+9Nw4i95zNT9QzLSPy2QT7+5r9YP
	 57CHJru5Gi3Jks37tzlWb1EDMzr1A/KynvteO2l5uZdn/7JvFMnfEYds5p3xUnQdky
	 oFiFDaXD0cWQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 5/6] perf record: Fix a potential error handling issue
Date: Wed, 22 May 2024 14:56:15 -0700
Message-ID: <20240522215616.762195-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240522215616.762195-1-namhyung@kernel.org>
References: <20240522215616.762195-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evlist is allocated at the beginning of cmd_record().  Also free-ing
thread masks should be paired with record__init_thread_masks() which is
called right before __cmd_record().

Let's change the order of these functions to release the resources
correctly in case of errors.  This is maybe fine as the process exits,
but it might be a problem if it manages some system-wide resources that
live longer than the process.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ec0b1607603..3a5a24dec356 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4258,13 +4258,13 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	evlist__delete(rec->evlist);
+	record__free_thread_masks(rec, rec->nr_threads);
+	rec->nr_threads = 0;
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
-	record__free_thread_masks(rec, rec->nr_threads);
-	rec->nr_threads = 0;
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
+	evlist__delete(rec->evlist);
 	return err;
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


