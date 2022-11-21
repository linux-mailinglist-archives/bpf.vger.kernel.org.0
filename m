Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB43631AB3
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKUHxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKUHxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:53:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FEF1DDE6
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:53:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so10552164pjl.3
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqA7GnPEIDi0/ln9UnpZAyxUmAWvsJa7ceEccOKwVB0=;
        b=rwgDPnz7eCaF4kgAd9T7GJdBS3tW0j1x+nZ44ErKxzCxS4sj2PoNoSlmkjajdBRKlo
         ZS4g/r2LZ9LLSKP676o3Ns9xN+pYYId5xf9C+QqO7tQVOZ9npERxwB1ksmOuTxiri3tD
         ZoNhrGqYaTqRh3m72uUYjdJcYPtlpF1FdNo86FCTHKqegwdOABvpRoIGldv2NhQJ1zTy
         SEAnXARWfj9tm2P8aU6WzLuxGlzJW7BBeHc4gH2SexwIl2YNqzlrMRmRH2e0ePt4eu7D
         pPGcXv8C2uIe3m+2rHfQZqWOPF7RZCLYAD6d/tdtbOmcy69TOAed4MXTJZfkPfQ9yHK/
         jHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqA7GnPEIDi0/ln9UnpZAyxUmAWvsJa7ceEccOKwVB0=;
        b=sqCRi7JdWFXtSgnlEXQpsvNh0D0OY5bzQzhwPIjYq6j93EGrWg19Ypb4sbac/mCfFe
         krvkh3SIxJOgsLW2hkNzji6068u/rZDwdyNwtI6JKpGsoCEzPscJX5qqZWURh10bmjRq
         puiB++h5plkzVhXMKDAkq/atiGcgc/Ttlx2icx+7yDSYRq2/VDI1f6D1VhXdAiBvkan2
         qPptR/68cHIoI3IFlCGsXhQ/H8LYq4wnGH7d9qp322uLDpwLAJOibB+C9lahY/kMdhPz
         OVynwH3mDB1sW5cf3R8ltpj1/keGTPlPNyH1VsLmPEp+ifvO/jrwAkh8VnCKod+F4wCY
         gAog==
X-Gm-Message-State: ANoB5pk4BJWdPPP8t+aKLGTVHJyKk2ayzWQ9S90cijvibMv/B2EeBUBl
        sfM9JVG91nTEvrcrPcH0uTsUMg==
X-Google-Smtp-Source: AA0mqf4KqDI3Nl4B+WYlRaQBAKtK5wBcBYYTWdTMqANLoKJFCX4b2n4isZ+ndW1Wg2skpxuidX9yJw==
X-Received: by 2002:a17:902:ebc1:b0:176:a6c5:20c9 with SMTP id p1-20020a170902ebc100b00176a6c520c9mr1297669plg.57.1669017185355;
        Sun, 20 Nov 2022 23:53:05 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:53:04 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/5] perf trace: Remove unused bpf map 'syscalls'
Date:   Mon, 21 Nov 2022 07:52:37 +0000
Message-Id: <20221121075237.127706-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121075237.127706-1-leo.yan@linaro.org>
References: <20221121075237.127706-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

augmented_raw_syscalls.c defines the bpf map 'syscalls' which is
initialized by perf tool in user space to indicate which system calls
are enabled for tracing, on the other flip eBPF program relies on the
map to filter out the trace events which are not enabled.

The map also includes a field 'string_args_len[6]' which presents the
string length if the corresponding argument is a string type.

Now the map 'syscalls' is not used, bpf program doesn't use it as filter
anymore, this is replaced by using the function bpf_tail_call() and
PROG_ARRAY syscalls map.  And we don't need to explicitly set the string
length anymore, bpf_probe_read_str() is smart to copy the string and
return string length.

Therefore, it's safe to remove the bpf map 'syscalls'.

To consolidate the code, this patch removes the definition of map
'syscalls' from augmented_raw_syscalls.c and drops code for using
the map in the perf trace.

Note, since function trace__set_ev_qualifier_bpf_filter() is removed,
calling trace__init_syscall_bpf_progs() from it is also removed.  We
don't need to worry it because trace__init_syscall_bpf_progs() is
still invoked from trace__init_syscalls_bpf_prog_array_maps() for
initialization the system call's bpf program callback.

After:

  # perf trace -e examples/bpf/augmented_raw_syscalls.c,open* --max-events 10 perf stat --quiet sleep 0.001
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libelf.so.1", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libdw.so.1", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libunwind.so.8", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libunwind-aarch64.so.8", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libcrypto.so.3", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libslang.so.2", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libperl.so.5.34", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3

  # perf trace -e examples/bpf/augmented_raw_syscalls.c --max-events 10 perf stat --quiet sleep 0.001
  ... [continued]: execve())             = 0
  brk(NULL)                               = 0xaaaab1d28000
  faccessat(-100, "/etc/ld.so.preload", 4) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
  close(3</usr/lib/aarch64-linux-gnu/libcrypto.so.3>) = 0
  openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
  read(3</usr/lib/aarch64-linux-gnu/libcrypto.so.3>, 0xfffff33f70d0, 832) = 832
  munmap(0xffffb5519000, 28672)           = 0
  munmap(0xffffb55b7000, 32880)           = 0
  mprotect(0xffffb55a6000, 61440, PROT_NONE) = 0

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c                    | 101 ------------------
 .../examples/bpf/augmented_raw_syscalls.c     |  17 ---
 2 files changed, 118 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 071e7598391f..543c379d2a57 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -122,7 +122,6 @@ struct trace {
 	struct syscalltbl	*sctbl;
 	struct {
 		struct syscall  *table;
-		struct bpf_map  *map;
 		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
 			struct bpf_map  *sys_enter,
 					*sys_exit;
@@ -1224,16 +1223,6 @@ struct syscall {
 	struct syscall_arg_fmt *arg_fmt;
 };
 
-/*
- * Must match what is in the BPF program:
- *
- * tools/perf/examples/bpf/augmented_raw_syscalls.c
- */
-struct bpf_map_syscall_entry {
-	bool	enabled;
-	u16	string_args_len[RAW_SYSCALL_ARGS_NUM];
-};
-
 /*
  * We need to have this 'calculated' boolean because in some cases we really
  * don't know what is the duration of a syscall, for instance, when we start
@@ -3259,7 +3248,6 @@ static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 
 static void trace__set_bpf_map_syscalls(struct trace *trace)
 {
-	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
 	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
 	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
 }
@@ -3339,80 +3327,6 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->syscalls.unaugmented_prog);
 }
 
-static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
-{
-	struct syscall *sc = trace__syscall_info(trace, NULL, id);
-	int arg = 0;
-
-	if (sc == NULL)
-		goto out;
-
-	for (; arg < sc->nr_args; ++arg) {
-		entry->string_args_len[arg] = 0;
-		if (sc->arg_fmt[arg].scnprintf == SCA_FILENAME) {
-			/* Should be set like strace -s strsize */
-			entry->string_args_len[arg] = PATH_MAX;
-		}
-	}
-out:
-	for (; arg < 6; ++arg)
-		entry->string_args_len[arg] = 0;
-}
-static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
-{
-	int fd = bpf_map__fd(trace->syscalls.map);
-	struct bpf_map_syscall_entry value = {
-		.enabled = !trace->not_ev_qualifier,
-	};
-	int err = 0;
-	size_t i;
-
-	for (i = 0; i < trace->ev_qualifier_ids.nr; ++i) {
-		int key = trace->ev_qualifier_ids.entries[i];
-
-		if (value.enabled) {
-			trace__init_bpf_map_syscall_args(trace, key, &value);
-			trace__init_syscall_bpf_progs(trace, key);
-		}
-
-		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
-static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
-{
-	int fd = bpf_map__fd(trace->syscalls.map);
-	struct bpf_map_syscall_entry value = {
-		.enabled = enabled,
-	};
-	int err = 0, key;
-
-	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		if (enabled)
-			trace__init_bpf_map_syscall_args(trace, key, &value);
-
-		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
-static int trace__init_syscalls_bpf_map(struct trace *trace)
-{
-	bool enabled = true;
-
-	if (trace->ev_qualifier_ids.nr)
-		enabled = trace->not_ev_qualifier;
-
-	return __trace__init_syscalls_bpf_map(trace, enabled);
-}
-
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
@@ -3627,16 +3541,6 @@ static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
 {
 }
 
-static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
-{
-	return 0;
-}
-
-static int trace__init_syscalls_bpf_map(struct trace *trace __maybe_unused)
-{
-	return 0;
-}
-
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace __maybe_unused,
 							    const char *name __maybe_unused)
 {
@@ -3670,8 +3574,6 @@ static bool trace__only_augmented_syscalls_evsels(struct trace *trace)
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
-	if (trace->syscalls.map)
-		return trace__set_ev_qualifier_bpf_filter(trace);
 	if (trace->syscalls.events.sys_enter)
 		return trace__set_ev_qualifier_tp_filter(trace);
 	return 0;
@@ -4045,9 +3947,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_mem;
 
-	if (trace->syscalls.map)
-		trace__init_syscalls_bpf_map(trace);
-
 	if (trace->syscalls.prog_array.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
 
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 4203f92c063b..9a03189d33d3 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -37,23 +37,6 @@ struct __augmented_syscalls__ {
 	__uint(max_entries, __NR_CPUS__);
 } __augmented_syscalls__ SEC(".maps");
 
-/*
- * string_args_len: one per syscall arg, 0 means not a string or don't copy it,
- * 		    PATH_MAX for copying everything, any other value to limit
- * 		    it a la 'strace -s strsize'.
- */
-struct syscall {
-	bool	enabled;
-	__u16	string_args_len[6];
-};
-
-struct syscalls {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, int);
-	__type(value, struct syscall);
-	__uint(max_entries, 512);
-} syscalls SEC(".maps");
-
 /*
  * What to augment at entry?
  *
-- 
2.34.1

