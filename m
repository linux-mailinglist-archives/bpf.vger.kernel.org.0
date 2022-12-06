Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB056449DE
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiLFRB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 12:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiLFRBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 12:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2931A28E11;
        Tue,  6 Dec 2022 09:01:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8ADDB81AD0;
        Tue,  6 Dec 2022 17:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547EFC433D6;
        Tue,  6 Dec 2022 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670346107;
        bh=EmuU5rS1zfGvoeMsppgTx3ItF2i/8y6u/MgH6W+ky4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/Dnxhw7O+rvYEcqLL4D1qUZyYeSPl/YhHa4lkANiCdRF2Lsd2UH6YHaxUREaz3aV
         0QQmRlxYM+GzFePiyouoqeAgGayQq4EC1z4nzYoshTI2iNL9hrUClYO7UR14+6NaZD
         yXT9CwS3LPUAMY4GnA280WE8Dc38EkLpW9DBp9TA2ETDTA1UPBudhhAFENA2IdZf0n
         A6tG+6sZ2l7epAe9Yb09DmRu+CvbLomd/qpCG9psaXr90XIxpKeTq12wi65auCV5Mb
         eBtt84qcMq0feSuaI7KgUCZn7zIpXY8SKqW/nxV+OHSIpWJKmBbjHXjlEpSvAxKzMT
         Fm2sv+m6TMeqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6759D40404; Tue,  6 Dec 2022 14:01:43 -0300 (-03)
Date:   Tue, 6 Dec 2022 14:01:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y491d1wEW4TfUi5f@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49wxSIK7dJ7iTDg@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
>  Now to look at the BUILD_BPF_SKEL=1 kaboom:
> 
>  [acme@quaco perf]$ alias m
> alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> [acme@quaco perf]$ m
> make: Entering directory '/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j8' parallel build
>   <SNIP>
> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
> /home/acme/git/perf/tools/perf/util/bpf_lock_contention.c:156: undefined reference to `is_lock_function'
> collect2: error: ld returned 1 exit status

I'm adding this as a prep patch, before the 'use libtraceevent from the
system' one:

commit 8beb33f2d34d4b37c6638004fef1345bc97804fe
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Dec 6 13:49:04 2022 -0300

    machine: Adopt is_lock_function() from builtin-lock.c
    
    It is used in bpf_lock_contention.c and builtin-lock.c will be made
    CONFIG_LIBTRACEEVENT=y conditional, so move it to machine.c, that is
    always available.
    
    This makes those 4 global variables for sched and lock text start and
    end to move to 'struct machine' too, as conceivably we can have that
    info for several machine instances, say some 'perf diff' like tool.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: bpf@vger.kernel.org
    Link: http://lore.kernel.org/lkml/
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 0d280093b19a55d4..15ce6358f12799e0 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -67,11 +67,6 @@ static enum {
 	LOCK_AGGR_CALLER,
 } aggr_mode = LOCK_AGGR_ADDR;
 
-static u64 sched_text_start;
-static u64 sched_text_end;
-static u64 lock_text_start;
-static u64 lock_text_end;
-
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -854,55 +849,6 @@ static int report_lock_release_event(struct evsel *evsel,
 	return 0;
 }
 
-bool is_lock_function(struct machine *machine, u64 addr)
-{
-	if (!sched_text_start) {
-		struct map *kmap;
-		struct symbol *sym;
-
-		sym = machine__find_kernel_symbol_by_name(machine,
-							  "__sched_text_start",
-							  &kmap);
-		if (!sym) {
-			/* to avoid retry */
-			sched_text_start = 1;
-			return false;
-		}
-
-		sched_text_start = kmap->unmap_ip(kmap, sym->start);
-
-		/* should not fail from here */
-		sym = machine__find_kernel_symbol_by_name(machine,
-							  "__sched_text_end",
-							  &kmap);
-		sched_text_end = kmap->unmap_ip(kmap, sym->start);
-
-		sym = machine__find_kernel_symbol_by_name(machine,
-							  "__lock_text_start",
-							  &kmap);
-		lock_text_start = kmap->unmap_ip(kmap, sym->start);
-
-		sym = machine__find_kernel_symbol_by_name(machine,
-							  "__lock_text_end",
-							  &kmap);
-		lock_text_end = kmap->unmap_ip(kmap, sym->start);
-	}
-
-	/* failed to get kernel symbols */
-	if (sched_text_start == 1)
-		return false;
-
-	/* mutex and rwsem functions are in sched text section */
-	if (sched_text_start <= addr && addr < sched_text_end)
-		return true;
-
-	/* spinlock functions are in lock text section */
-	if (lock_text_start <= addr && addr < lock_text_end)
-		return true;
-
-	return false;
-}
-
 static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
 				  char *buf, int size)
 {
@@ -961,7 +907,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 			goto next;
 
 		sym = node->ms.sym;
-		if (sym && !is_lock_function(machine, node->ip)) {
+		if (sym && !machine__is_lock_function(machine, node->ip)) {
 			get_symbol_name_offset(node->ms.map, sym, node->ip,
 					       buf, size);
 			return 0;
@@ -1007,7 +953,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 		if (++skip <= stack_skip)
 			goto next;
 
-		if (node->ms.sym && is_lock_function(machine, node->ip))
+		if (node->ms.sym && machine__is_lock_function(machine, node->ip))
 			goto next;
 
 		hash ^= hash_long((unsigned long)node->ip, 64);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 4db9ad3d50c41ac7..f4ebb9a2e3809a7f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -153,7 +153,7 @@ int lock_contention_read(struct lock_contention *con)
 		bpf_map_lookup_elem(stack, &key, stack_trace);
 
 		/* skip lock internal functions */
-		while (is_lock_function(machine, stack_trace[idx]) &&
+		while (machine__is_lock_function(machine, stack_trace[idx]) &&
 		       idx < con->max_stack - 1)
 			idx++;
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index e3c061b1795ba377..a2346875098dca03 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -145,6 +145,4 @@ static inline int lock_contention_read(struct lock_contention *con __maybe_unuse
 
 #endif  /* HAVE_BPF_SKEL */
 
-bool is_lock_function(struct machine *machine, u64 addr);
-
 #endif  /* PERF_LOCK_CONTENTION_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 76316e459c3de9c4..803c9d1803dd26ef 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3336,3 +3336,43 @@ int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, voi
 	}
 	return err;
 }
+
+bool machine__is_lock_function(struct machine *machine, u64 addr)
+{
+	if (!machine->sched.text_start) {
+		struct map *kmap;
+		struct symbol *sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_start", &kmap);
+
+		if (!sym) {
+			/* to avoid retry */
+			machine->sched.text_start = 1;
+			return false;
+		}
+
+		machine->sched.text_start = kmap->unmap_ip(kmap, sym->start);
+
+		/* should not fail from here */
+		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
+		machine->sched.text_end = kmap->unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
+		machine->lock.text_start = kmap->unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
+		machine->lock.text_end = kmap->unmap_ip(kmap, sym->start);
+	}
+
+	/* failed to get kernel symbols */
+	if (machine->sched.text_start == 1)
+		return false;
+
+	/* mutex and rwsem functions are in sched text section */
+	if (machine->sched.text_start <= addr && addr < machine->sched.text_end)
+		return true;
+
+	/* spinlock functions are in lock text section */
+	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
+		return true;
+
+	return false;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 6267c1d6f2321128..d034ecaf89c193ea 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -56,6 +56,10 @@ struct machine {
 	struct maps	  *kmaps;
 	struct map	  *vmlinux_map;
 	u64		  kernel_start;
+	struct {
+		u64	  text_start;
+		u64	  text_end;
+	} sched, lock;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
 	union { /* Tool specific area */
@@ -212,6 +216,7 @@ static inline bool machine__is_host(struct machine *machine)
 	return machine ? machine->pid == HOST_KERNEL_ID : false;
 }
 
+bool machine__is_lock_function(struct machine *machine, u64 addr);
 bool machine__is(struct machine *machine, const char *arch);
 bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
