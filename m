Return-Path: <bpf+bounces-12008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10867C6580
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A0282B65
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC4D521;
	Thu, 12 Oct 2023 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uv6JeNPi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D541D305
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:50 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1055D68
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a39444700so1521082276.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091878; x=1697696678; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTK1vjQioOgb7+3VfL3Txgo28p8CKodFJzCpLv4Rtj4=;
        b=uv6JeNPij7TT4XS0q0/yoo6k2/t4vvrRQzLGGY5rFdmj4u0CQaXGgBbB1/NaeKmhgW
         UIlozJYzTUXmPNYb86Xubwt/GdWVlm65dwXKiQtwrGxD0Q0elKxj1APbB2E00VMKJ4D8
         92taAuQSd+mrWsT6vfz/I+osKMd5YBHHLIaxf6qc/FXAR2zuYuF3YXuoVGP2Y3e+4SPA
         0ivN5hSFC4514goeouq9RPkvblO2VtaBqMOiPs6pnkI62WBMbsHCrWVNWNzcchl7dyCa
         QpKKWDod1Jkp/GWd9lI9q23HWSRjvYwSj9D+mTlK2AhkzhijkzULcXBMP9YzmioKqaZi
         a57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091878; x=1697696678;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTK1vjQioOgb7+3VfL3Txgo28p8CKodFJzCpLv4Rtj4=;
        b=k/Po38ZVvvG+pTnoQkV5MTxO92ipSBZ0JV+DR3IY7BcUl1Pw4ERbHvQLNbKfd27/CX
         K5FkQButcR6za9ps1XIxugbaUA0PWalsNNr0JTL3eBn3jMVp4Wjn/Crcq9JY3uN8Rndn
         PUApBdCmfHPMNAzX1oCt5KwRf1hX31vgDU2MbRH3RgaCujBYpbZOdzNNLpAUOvcXYHdo
         jGmva1/qhr1BRjwCgimeJz/KnbK+CYAu0uFqKkGM4OI+Mu8mgMx73MXd+dR7yPm8Gn++
         9zKyH8AkHgNNn8U1Vx61xEOpjzBwWFYwSK68pY+hs+gELeGM6ryAKOrZD62TAqp1G37+
         CBHA==
X-Gm-Message-State: AOJu0Yz3cSaTvWF/A0PXPLbRyl0YBDxtk6nfudOKayD5EbUZqyLBt8bU
	i8gPbDt9AhSvlnEP0z2nYlaRwuptkVHg
X-Google-Smtp-Source: AGHT+IE4qAyT/UaWN2Oj0ek+8QffAEjlj78Q2y4vJkbHQ2R8T+5aASA1i2KxSJKzRvjMHEsS5tZkFEiOSmvk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:abc9:0:b0:d9a:6360:485b with SMTP id
 v67-20020a25abc9000000b00d9a6360485bmr169468ybi.2.1697091877832; Wed, 11 Oct
 2023 23:24:37 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:59 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 13/13] perf machine thread: Remove exited threads by default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct thread values hold onto references to mmaps, dsos, etc. When a
thread exits it is necessary to clean all of this memory up by
removing the thread from the machine's threads. Some tools require
this doesn't happen, such as perf report if offcpu events exist or if
a task list is being generated, so add a symbol_conf value to make the
behavior optional. When an exited thread is left in the machine's
threads, mark it as exited.

This change relates to commit 40826c45eb0b ("perf thread: Remove
notion of dead threads"). Dead threads were removed as they had a
reference count of 0 and were difficult to reason about with the
reference count checker. Here a thread is removed from threads when it
exits, unless via symbol_conf the exited thread isn't remove and is
marked as exited. Reference counting behaves as it normally does.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c   |  7 +++++++
 tools/perf/util/machine.c     | 10 +++++++---
 tools/perf/util/symbol_conf.h |  3 ++-
 tools/perf/util/thread.h      | 14 ++++++++++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcedfe00f04d..749246817aed 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
 	if (ret < 0)
 		goto exit;
 
+	/*
+	 * tasks_mode require access to exited threads to list those that are in
+	 * the data file. Off-cpu events are synthesized after other events and
+	 * reference exited threads.
+	 */
+	symbol_conf.keep_exited_threads = true;
+
 	annotation_options__init(&report.annotation_opts);
 
 	ret = perf_config(report__config, &report);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6ca7500e2cf4..5cda47eb337d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
-	if (thread != NULL)
-		thread__put(thread);
-
+	if (thread != NULL) {
+		if (symbol_conf.keep_exited_threads)
+			thread__set_exited(thread, /*exited=*/true);
+		else
+			machine__remove_thread(machine, thread);
+	}
+	thread__put(thread);
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 2b2fb9e224b0..6040286e07a6 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -43,7 +43,8 @@ struct symbol_conf {
 			disable_add2line_warn,
 			buildid_mmap2,
 			guest_code,
-			lazy_load_kernel_maps;
+			lazy_load_kernel_maps,
+			keep_exited_threads;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e79225a0ea46..0df775b5c110 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -36,13 +36,22 @@ struct thread_rb_node {
 };
 
 DECLARE_RC_STRUCT(thread) {
+	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
+	/** @tid: thread ID number unique to a machine. */
 	pid_t			tid;
+	/** @ppid: parent process of the process this thread belongs to. */
 	pid_t			ppid;
 	int			cpu;
 	int			guest_cpu; /* For QEMU thread */
 	refcount_t		refcnt;
+	/**
+	 * @exited: Has the thread had an exit event. Such threads are usually
+	 * removed from the machine's threads but some events/tools require
+	 * access to dead threads.
+	 */
+	bool			exited;
 	bool			comm_set;
 	int			comm_len;
 	struct list_head	namespaces_list;
@@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
 	return &RC_CHK_ACCESS(thread)->refcnt;
 }
 
+static inline void thread__set_exited(struct thread *thread, bool exited)
+{
+	RC_CHK_ACCESS(thread)->exited = exited;
+}
+
 static inline bool thread__comm_set(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->comm_set;
-- 
2.42.0.609.gbb76f46606-goog


