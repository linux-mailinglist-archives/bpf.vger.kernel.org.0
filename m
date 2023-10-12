Return-Path: <bpf+bounces-12005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C387C657C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F335C1C20CB5
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F64D50F;
	Thu, 12 Oct 2023 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfjQ5C7J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7ED52A
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:41 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F86196
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a4f656f751so10145377b3.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091870; x=1697696670; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/6/O/gRte1zMhmeMtD4ohISB3aWdPXWc8V2/IjDG4=;
        b=MfjQ5C7JEOErhS+sVyt+9BIu5x/F+EcfbqxY16YvfH+Baa1uydnkaaaYfeNb++GAhe
         w1jyj9CRpk9NtQvcuVy0u8EgsYvvICa06QNJGL60h6i1fNgf6a6eec6bbWSHgn9MylgN
         ctHoEn3sNsfj17CE9duwG0Bt25OAZbgB5aOLWOMaeZIxRP1wm1cyCvbm4lnSbrqK6J7T
         FjjHz3WCelmLYsstXYwiICf40c9lSzvWP+JzzaATTDQuiHLMs8ZhSdTHGTz5Fk3VVVEV
         labXbkeucDueh9576aAAymNQDILXk4SL3yfSOXvYg7Wk8wqWmtjhHPUjLgpuc1NODLkv
         KcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091870; x=1697696670;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/6/O/gRte1zMhmeMtD4ohISB3aWdPXWc8V2/IjDG4=;
        b=ePZ5Yr66RdMNtTCwvvDM6hGSWBN4lhyOg0FnDaRKUcao2gCGkBY806DCW0+8/alRLW
         Lvbb2RBNTjYsLGGqbV8FX3iiXa02RMSyNzEsvBmEv9+03gRAiyVIl9T1iPAO7h/J3NkO
         cs2v5pxcansR8lxZ5Ei+vmX5sr8/Zu3HkQql8CwKg84XsfPgUnVWaFqhtimgre3hHA9S
         9xl1Dqsml4lM8HKGWcQ17boLY/GvGIgIRDa34gpyKK8biWhajy8ZAZVHSUUptahJ5eK5
         plOfJ6c1Og1RAynEM4i7lNu82eU57d2zwO4M0+8Afoh+t8+voaZ4Qbu+dlPt6JReFn7W
         dMkg==
X-Gm-Message-State: AOJu0YzyGQR2JJqARA9NTY5MQ3ImPdd8f63JT0Ba0kQJ2BrtkEq+Pd/L
	AgdLfciU85qlrUAqpJEjwxCoaNj1yDS4
X-Google-Smtp-Source: AGHT+IHw9CWAC8FY76ZB7h38HkJJCF9yox3JXqj1NldAlfSd6AeHsF169JHHn8w35OGyvCUjrw3Xt+ij0Xpl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:4005:0:b0:5a7:be34:345 with SMTP id
 l5-20020a814005000000b005a7be340345mr175704ywn.6.1697091870082; Wed, 11 Oct
 2023 23:24:30 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:56 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 10/13] perf record: Lazy load kernel symbols
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
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
changed it so that loading a kernel dso would cause the symbols for
the dso to be eagerly loaded. For perf record this is overhead as the
symbols won't be used. Add a symbol_conf to control the behavior and
disable it for perf record and perf inject.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   | 4 ++++
 tools/perf/builtin-record.c   | 2 ++
 tools/perf/util/event.c       | 4 ++--
 tools/perf/util/symbol_conf.h | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c8cf2fdd9cff..1539fb18c749 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2265,6 +2265,10 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+
+	/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
+	symbol_conf.lazy_load_kernel_maps = true;
+
 #ifndef HAVE_JITDUMP
 	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
 #endif
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..8ec818568662 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 # undef set_nobuild
 #endif
 
+	/* Disable eager loading of kernel symbols that adds overhead to perf record. */
+	symbol_conf.lazy_load_kernel_maps = true;
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
 	rec->evlist = evlist__new();
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 923c0fb15122..68f45e9e63b6 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		maps = machine__kernel_maps(machine);
-		load_map = true;
+		load_map = !symbol_conf.lazy_load_kernel_maps;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
 		maps = machine__kernel_maps(machine);
-		load_map = true;
+		load_map = !symbol_conf.lazy_load_kernel_maps;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
 	} else {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0b589570d1d0..2b2fb9e224b0 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -42,7 +42,8 @@ struct symbol_conf {
 			inline_name,
 			disable_add2line_warn,
 			buildid_mmap2,
-			guest_code;
+			guest_code,
+			lazy_load_kernel_maps;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.42.0.609.gbb76f46606-goog


