Return-Path: <bpf+bounces-65611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E5B25CEC
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6018819AD
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24326D4DD;
	Thu, 14 Aug 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIiDqes0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668E26C384;
	Thu, 14 Aug 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155878; cv=none; b=rn30jhHkiDX83d5EjGJuD4AgaF6uuQosgdzbHiZguo/mhGKULXDYYPpDGdq6spA6sqfu5pTNqJLUdZFHFVo9A87Z3EGCt5wJIhujmtVtM/YblCw47jX5fprgaDQA6vGvKRv01nWta4nQ0cA4nrAQykc82+pb8ZbswNYeuCP7eQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155878; c=relaxed/simple;
	bh=x5ISNwGpGFs3HPOinoNY/g7uQoPEdQ8+j3ZXq6MAHkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl+Q/hbwoSkyxyLviBq/7cu47yXu3ivVKg+PymofhLlIae7cgVRjxtA6EQ03fnM7/HsGsfh/CdGrCEjLL++w6j4ZI0PYk0yFWXJJJkpa/ANjC+TkACgR13t4ePfS2vsxft+wte+/E8zvV7bQ540czEGARax6HZL7tqzulxnZ/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIiDqes0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12FAC4CEF4;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155878;
	bh=x5ISNwGpGFs3HPOinoNY/g7uQoPEdQ8+j3ZXq6MAHkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIiDqes02ufk4guOt5/+Ojlnz0PFS/aORwSvigI4cXuBep6uGGvOSieGDoCVGCRg5
	 82CLpZR6C8UUhe8M28LJfDxZitY6pIF0AuQo5Gh3NBz1UzIfbkbjc0uAu8+IKwLqMY
	 gSqZPxtyysKfugxMzXTGORLSl+SiCYXsRJD5Dq4BYXdyOFTXsSVIaffKiAEYxdbU/p
	 X4MYmhC2t9iLAd6ZyB9jbO1C7fBrQphajkOfZmM+HeUJRf1vg8CSJxefpV8CQXtEJh
	 0h75jWrzQ5zumSRzeeOyWm+j+UJUJn0C7hzEGL9Xf85Ef7Y00NBJ6LHg650GXoxZiR
	 il0Gj7xzTTOig==
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
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 4/5] perf trace: Remove unused code
Date: Thu, 14 Aug 2025 00:17:53 -0700
Message-ID: <20250814071754.193265-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250814071754.193265-1-namhyung@kernel.org>
References: <20250814071754.193265-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now syscall init for augmented arguments is simplified.  Let's get rid
of dead code.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 110 -------------------------------------
 1 file changed, 110 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e1caa82bc427b68b..a7a49d8997d55594 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -470,38 +470,6 @@ static int evsel__init_syscall_tp(struct evsel *evsel)
 	return -ENOMEM;
 }
 
-static int evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
-{
-	struct syscall_tp *sc = evsel__syscall_tp(evsel);
-
-	if (sc != NULL) {
-		struct tep_format_field *syscall_id = evsel__field(tp, "id");
-		if (syscall_id == NULL)
-			syscall_id = evsel__field(tp, "__syscall_nr");
-		if (syscall_id == NULL ||
-		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
-			return -EINVAL;
-
-		return 0;
-	}
-
-	return -ENOMEM;
-}
-
-static int evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
-{
-	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
-
-	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
-}
-
-static int evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
-{
-	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
-
-	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
-}
-
 static int evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
 	if (evsel__syscall_tp(evsel) != NULL) {
@@ -5506,7 +5474,6 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
-	struct evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
 	int err = -1;
 	char bf[BUFSIZ];
@@ -5665,83 +5632,6 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	/*
-	 * If we are augmenting syscalls, then combine what we put in the
-	 * __augmented_syscalls__ BPF map with what is in the
-	 * syscalls:sys_exit_FOO tracepoints, i.e. just like we do without BPF,
-	 * combining raw_syscalls:sys_enter with raw_syscalls:sys_exit.
-	 *
-	 * We'll switch to look at two BPF maps, one for sys_enter and the
-	 * other for sys_exit when we start augmenting the sys_exit paths with
-	 * buffers that are being copied from kernel to userspace, think 'read'
-	 * syscall.
-	 */
-	if (trace.syscalls.events.bpf_output) {
-		evlist__for_each_entry(trace.evlist, evsel) {
-			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
-
-			if (raw_syscalls_sys_exit) {
-				trace.raw_augmented_syscalls = true;
-				goto init_augmented_syscall_tp;
-			}
-
-			if (trace.syscalls.events.bpf_output->priv == NULL &&
-			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
-				struct evsel *augmented = trace.syscalls.events.bpf_output;
-				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
-				    evsel__init_augmented_syscall_tp_args(augmented))
-					goto out;
-				/*
-				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
-				 * Above we made sure we can get from the payload the tp fields
-				 * that we get from syscalls:sys_enter tracefs format file.
-				 */
-				augmented->handler = trace__sys_enter;
-				/*
-				 * Now we do the same for the *syscalls:sys_enter event so that
-				 * if we handle it directly, i.e. if the BPF prog returns 0 so
-				 * as not to filter it, then we'll handle it just like we would
-				 * for the BPF_OUTPUT one:
-				 */
-				if (evsel__init_augmented_syscall_tp(evsel, evsel) ||
-				    evsel__init_augmented_syscall_tp_args(evsel))
-					goto out;
-				evsel->handler = trace__sys_enter;
-			}
-
-			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
-				struct syscall_tp *sc;
-init_augmented_syscall_tp:
-				if (evsel__init_augmented_syscall_tp(evsel, evsel))
-					goto out;
-				sc = __evsel__syscall_tp(evsel);
-				/*
-				 * For now with BPF raw_augmented we hook into
-				 * raw_syscalls:sys_enter and there we get all
-				 * 6 syscall args plus the tracepoint common
-				 * fields and the syscall_nr (another long).
-				 * So we check if that is the case and if so
-				 * don't look after the sc->args_size but
-				 * always after the full raw_syscalls:sys_enter
-				 * payload, which is fixed.
-				 *
-				 * We'll revisit this later to pass
-				 * s->args_size to the BPF augmenter (now
-				 * tools/perf/examples/bpf/augmented_raw_syscalls.c,
-				 * so that it copies only what we need for each
-				 * syscall, like what happens when we use
-				 * syscalls:sys_enter_NAME, so that we reduce
-				 * the kernel/userspace traffic to just what is
-				 * needed for each syscall.
-				 */
-				if (trace.raw_augmented_syscalls)
-					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
-				evsel__init_augmented_syscall_tp_ret(evsel);
-				evsel->handler = trace__sys_exit;
-			}
-		}
-	}
-
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
 		err = trace__record(&trace, argc-1, &argv[1]);
 		goto out;
-- 
2.51.0.rc1.167.g924127e9c0-goog


