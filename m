Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35538663198
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 21:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjAIUfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbjAIUfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 15:35:06 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62B625EE
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 12:35:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id s22-20020a17090aad9600b002271d094c82so1724774pjq.7
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8To9c/RhjeU3UhCcJpilZYbO96GcFeqlarqkyf14xk=;
        b=pBt0bIydFOwdKSVmC67SAEC38M3pJdN4Rbbk1sSIr2dLWuKG+E4cAAfIKa+hVPgR6l
         PSMauWXMYX2UXWlVwJj1DCeuZNq1JrwyrNZVSR0hHDv1QPkudW0vfVXPam8RusLj2wzi
         twBqKGWkBWo30T5upazEELk5+hstDV4f920U2q7L11Rbpgi+FsLPFzRRLRDXBX4MtcQ3
         Z8q3/1FewblD5NeUTT4cKaKavnfexeYXt4hAE5zVgo2DbZNcvLYZbYPtRbL1qHABKurK
         aPy9TiloeqQbRXNC5zkauL0/6zt5hGuvCIQ628aVBWXXlUe+UOT4ywnNnnuhT12g2vtX
         hv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8To9c/RhjeU3UhCcJpilZYbO96GcFeqlarqkyf14xk=;
        b=NUZUysPqkUBlCkt4iW2Qc+nlg8cLIh2SpoVDo4ES3Lihg1AYFEv+SYaiB2FL8HW9rq
         Xaz6q9p6w33fzfPIrK/54EKUSPaUIViKQSLJfJatvkjaayY4cvijrDR6b8fzoxh6ITsV
         ek+F80J/2fDg1b99HDuSJ/P6E6yS1MpueMpr4n8itbYiO8sKQUSi7RsruT3MKyLdUKcu
         d1CT3q4qpAqBBzHdBQpsVy77fqyi8P7BCvN4+ypqSWvx1EEHOHiEqWgmoJapRe+E6q3t
         V+FetRTGns9/ypIpQcE2W1Nv5mjkP6dI0jaOTZnkMTB2Py+hzQ1XIqDq1foFxTohUShc
         dz9w==
X-Gm-Message-State: AFqh2kr1i8Exz3kF6EMOOLUEIeYvmIFYe2y/j21yrmuf357+/j8J2tGL
        HiKMyukGp7k+1JjnHaQa075Y6z1idu43
X-Google-Smtp-Source: AMrXdXtUZRgLPxys+vegp/cuo3pBqGhpG0+QdQhR8QR3TvP33C+w+N/SXk8YCm7Y+zwyCUW76b0oO7vVLFkn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a17:90a:b288:b0:227:f19:eb19 with SMTP id
 c8-20020a17090ab28800b002270f19eb19mr507224pjr.44.1673296504559; Mon, 09 Jan
 2023 12:35:04 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:34:24 -0800
In-Reply-To: <20230109203424.1157561-1-irogers@google.com>
Message-Id: <20230109203424.1157561-4-irogers@google.com>
Mime-Version: 1.0
References: <20230109203424.1157561-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 3/3] perf bpf: Remove pre libbpf 1.0 conditional logic
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests are no longer applicable as libbpf 1.0 can be assumed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config    |  9 -----
 tools/perf/util/bpf-event.c   | 66 -----------------------------------
 tools/perf/util/bpf-loader.c  | 18 ----------
 tools/perf/util/bpf_counter.c | 18 ----------
 4 files changed, 111 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 399e03338613..2197970bd503 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -566,15 +566,6 @@ ifndef NO_LIBELF
       # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
       $(call feature_check,libbpf)
 
-      # Feature test requires libbpf 1.0 so we can assume the following:
-      CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
-      CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
-      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
-      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
-      CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
-      CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
-      CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
-
       ifdef LIBBPF_DYNAMIC
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cc7c1f90cf62..025f331b3867 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -22,72 +22,6 @@
 #include "record.h"
 #include "util/synthetic-events.h"
 
-#ifndef HAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
-struct btf *btf__load_from_kernel_by_id(__u32 id)
-{
-       struct btf *btf;
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-       int err = btf__get_from_id(id, &btf);
-#pragma GCC diagnostic pop
-
-       return err ? ERR_PTR(err) : btf;
-}
-#endif
-
-#ifndef HAVE_LIBBPF_BPF_PROG_LOAD
-LIBBPF_API int bpf_load_program(enum bpf_prog_type type,
-				const struct bpf_insn *insns, size_t insns_cnt,
-				const char *license, __u32 kern_version,
-				char *log_buf, size_t log_buf_sz);
-
-int bpf_prog_load(enum bpf_prog_type prog_type,
-		  const char *prog_name __maybe_unused,
-		  const char *license,
-		  const struct bpf_insn *insns, size_t insn_cnt,
-		  const struct bpf_prog_load_opts *opts)
-{
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	return bpf_load_program(prog_type, insns, insn_cnt, license,
-				opts->kern_version, opts->log_buf, opts->log_size);
-#pragma GCC diagnostic pop
-}
-#endif
-
-#ifndef HAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
-struct bpf_program *
-bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
-{
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	return bpf_program__next(prev, obj);
-#pragma GCC diagnostic pop
-}
-#endif
-
-#ifndef HAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
-struct bpf_map *
-bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
-{
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	return bpf_map__next(prev, obj);
-#pragma GCC diagnostic pop
-}
-#endif
-
-#ifndef HAVE_LIBBPF_BTF__RAW_DATA
-const void *
-btf__raw_data(const struct btf *btf_ro, __u32 *size)
-{
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	return btf__get_raw_data(btf_ro, size);
-#pragma GCC diagnostic pop
-}
-#endif
-
 static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 {
 	int ret = 0;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 6e9b06cf06ee..44cde27d6389 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -32,24 +32,6 @@
 
 #include <internal/xyarray.h>
 
-#ifndef HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
-int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
-			   struct bpf_insn *new_insns __maybe_unused, size_t new_insn_cnt __maybe_unused)
-{
-	pr_err("%s: not support, update libbpf\n", __func__);
-	return -ENOTSUP;
-}
-
-int libbpf_register_prog_handler(const char *sec __maybe_unused,
-                                 enum bpf_prog_type prog_type __maybe_unused,
-                                 enum bpf_attach_type exp_attach_type __maybe_unused,
-                                 const struct libbpf_prog_handler_opts *opts __maybe_unused)
-{
-	pr_err("%s: not support, update libbpf\n", __func__);
-	return -ENOTSUP;
-}
-#endif
-
 /* temporarily disable libbpf deprecation warnings */
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index eeee899fcf34..aa78a15a6f0a 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -312,24 +312,6 @@ static bool bperf_attr_map_compatible(int attr_map_fd)
 		(map_info.value_size == sizeof(struct perf_event_attr_map_entry));
 }
 
-#ifndef HAVE_LIBBPF_BPF_MAP_CREATE
-LIBBPF_API int bpf_create_map(enum bpf_map_type map_type, int key_size,
-                              int value_size, int max_entries, __u32 map_flags);
-int
-bpf_map_create(enum bpf_map_type map_type,
-	       const char *map_name __maybe_unused,
-	       __u32 key_size,
-	       __u32 value_size,
-	       __u32 max_entries,
-	       const struct bpf_map_create_opts *opts __maybe_unused)
-{
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	return bpf_create_map(map_type, key_size, value_size, max_entries, 0);
-#pragma GCC diagnostic pop
-}
-#endif
-
 static int bperf_lock_attr_map(struct target *target)
 {
 	char path[PATH_MAX];
-- 
2.39.0.314.g84b9a713c41-goog

