Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA514EBC1C
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbiC3HxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbiC3Hw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 03:52:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4485B39
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 00:51:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d30so2813492pjk.0
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=seuVbDyzILZ/b07EAvCiHKG72LxkQnxWhofHoRNZ4T4=;
        b=M5/FVLsoFk4rOlaLEmaz6f70OkmnWTAnzVsf8mp19JOEwBE9U6i/pC0uGkNMA9Nk1G
         WH28HAuj0vjZPk0RUxmU0U0PNLGRnKXbGHG2tX4vk54xZZQ/ssglS7od1oDfJHPtK/MV
         KD8DYPlmMltix6hzu2kEgzAL2dT8szZq9/JXEPRMu3eJaHXNw/e0LxsCXMR0GRYYX5M2
         2ljrIxDn8RmYgnh0DesQQdV5B0Oji+WQ9DEurcel9ZmOzHIGDBXXAI7gAdFZkbQVaOKm
         9DPV9e5gc0a4z/J6d0buAMvBBCq++5vUkPReMUmBJ4RJBuizmxJFo+DRn1Pzp/cG+BLv
         FDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=seuVbDyzILZ/b07EAvCiHKG72LxkQnxWhofHoRNZ4T4=;
        b=6JNkeGrJPdsGPB34fYoY4hrUnfUWSuxjaenMn/y8Oq+4XtkICzaJv9MyqyeBU/AJ4N
         VLQoXNICKLGro4UGsr/OxUmYK7QsODezIhlD9vY4JbIseEr3c/qEANlKqoe3kEEjgI31
         URPxsUqFlYAnmX1GZGYMCJwA22PeA62bxuqlNDh47uPPBaam70SiW1fPcN3wv49wQJDD
         +PapGbW8S3Q0Q6M30aehfn/fp13KEdQPP2FNqYNd0IyCZXv94YhoasOTul4Wjv+nkv1R
         uOktApySxZvC6LzvTC3vbnuABdhOjbf0ZBw4jsiI0woG5JPudJNsc1zQcjLLcmzuyCg9
         8Eow==
X-Gm-Message-State: AOAM5302fxEhrh2eWO+mqhhL3BNm1GNdxRqcxTU/cLhHIEuPiu12w7fZ
        /pryWwifC+Ou6+iKWMqppkw=
X-Google-Smtp-Source: ABdhPJxXq4/+IWCx7HAa/qteEfJrpk+A7dm/2mvoI/TsSMICe7r2QK77oQkT+5IT7XLirzFOVxPhGQ==
X-Received: by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP id a8-20020a170902900800b0014fb1f95271mr33435488plp.86.1648626670001;
        Wed, 30 Mar 2022 00:51:10 -0700 (PDT)
Received: from localhost.localdomain ([125.62.117.61])
        by smtp.googlemail.com with ESMTPSA id i6-20020a633c46000000b003817d623f72sm18349741pgn.24.2022.03.30.00.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 00:51:09 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Move spintest from samples/bpf to selftests
Date:   Wed, 30 Mar 2022 13:20:51 +0530
Message-Id: <20220330075051.34326-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

According to the discussions in [1] everything from the samples/bpf
directory should be moved out or deleted.

Move the spintest program from BPF samples to BPF selftests.
There are no functional changes. BPF skeleton has been used for loading,
etc.

[1] https://lore.kernel.org/all/CAEf4BzYv3ONhy-JnQUtknzgBSK0gpm9GBJYtbAiJQe50_eX7Uw@mail.gmail.com/

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 samples/bpf/Makefile                          |  3 --
 .../selftests/bpf/prog_tests/spintest.c       | 43 +++++++------------
 .../testing/selftests/bpf/progs/test_spin.c   | 15 +++----
 3 files changed, 23 insertions(+), 38 deletions(-)
 rename samples/bpf/spintest_user.c => tools/testing/selftests/bpf/prog_tests/spintest.c (63%)
 rename samples/bpf/spintest_kern.c => tools/testing/selftests/bpf/progs/test_spin.c (86%)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 38638845db9d..570f1b0d9f00 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -23,7 +23,6 @@ tprogs-y += test_probe_write_user
 tprogs-y += trace_output
 tprogs-y += lathist
 tprogs-y += offwaketime
-tprogs-y += spintest
 tprogs-y += map_perf_test
 tprogs-y += test_overhead
 tprogs-y += test_cgrp2_array_pin
@@ -86,7 +85,6 @@ test_probe_write_user-objs := test_probe_write_user_user.o
 trace_output-objs := trace_output_user.o
 lathist-objs := lathist_user.o
 offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
-spintest-objs := spintest_user.o $(TRACE_HELPERS)
 map_perf_test-objs := map_perf_test_user.o
 test_overhead-objs := test_overhead_user.o
 test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
@@ -144,7 +142,6 @@ always-y += tcbpf1_kern.o
 always-y += tc_l2_redirect_kern.o
 always-y += lathist_kern.o
 always-y += offwaketime_kern.o
-always-y += spintest_kern.o
 always-y += map_perf_test_kern.o
 always-y += test_overhead_tp_kern.o
 always-y += test_overhead_raw_tp_kern.o
diff --git a/samples/bpf/spintest_user.c b/tools/testing/selftests/bpf/prog_tests/spintest.c
similarity index 63%
rename from samples/bpf/spintest_user.c
rename to tools/testing/selftests/bpf/prog_tests/spintest.c
index 0d7e1e5a8658..15b436fb3f9a 100644
--- a/samples/bpf/spintest_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/spintest.c
@@ -6,45 +6,34 @@
 #include <sys/resource.h>
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
+#include <test_progs.h>
 #include "trace_helpers.h"
+#include "test_spin.skel.h"
 
-int main(int ac, char **argv)
+void test_spin(void)
 {
-	char filename[256], symbol[256];
 	struct bpf_object *obj = NULL;
 	struct bpf_link *links[20];
 	long key, next_key, value;
 	struct bpf_program *prog;
+	struct test_spin *skel;
 	int map_fd, i, j = 0;
 	const char *section;
 	struct ksym *sym;
+	char symbol[256];
+	int err;
 
-	if (load_kallsyms()) {
-		printf("failed to process /proc/kallsyms\n");
-		return 2;
-	}
+	err = load_kallsyms();
+	if (!ASSERT_OK(err, "load_kallsyms"))
+		return;
+	skel = test_spin__open_and_load();
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		obj = NULL;
-		goto cleanup;
-	}
+	if (!ASSERT_OK_PTR(skel, "test_spin__open_and_load"))
+		return;
 
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd = bpf_object__find_map_fd_by_name(obj, "my_map");
-	if (map_fd < 0) {
-		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
-		goto cleanup;
-	}
+	map_fd = bpf_map__fd(skel->maps.my_map);
 
-	bpf_object__for_each_program(prog, obj) {
+	bpf_object__for_each_program(prog, skel->obj) {
 		section = bpf_program__section_name(prog);
 		if (sscanf(section, "kprobe/%s", symbol) != 1)
 			continue;
@@ -52,7 +41,8 @@ int main(int ac, char **argv)
 		/* Attach prog only when symbol exists */
 		if (ksym_get_addr(symbol)) {
 			links[j] = bpf_program__attach(prog);
-			if (libbpf_get_error(links[j])) {
+			err = libbpf_get_error(links[j]);
+			if (!ASSERT_OK(err, "bpf_program__attach")) {
 				fprintf(stderr, "bpf_program__attach failed\n");
 				links[j] = NULL;
 				goto cleanup;
@@ -89,5 +79,4 @@ int main(int ac, char **argv)
 		bpf_link__destroy(links[j]);
 
 	bpf_object__close(obj);
-	return 0;
 }
diff --git a/samples/bpf/spintest_kern.c b/tools/testing/selftests/bpf/progs/test_spin.c
similarity index 86%
rename from samples/bpf/spintest_kern.c
rename to tools/testing/selftests/bpf/progs/test_spin.c
index 455da77319d9..531783fe6cb9 100644
--- a/samples/bpf/spintest_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_spin.c
@@ -4,14 +4,14 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <linux/version.h>
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/perf_event.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, long);
@@ -27,8 +27,8 @@ struct {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
-	__uint(key_size, sizeof(u32));
-	__uint(value_size, PERF_MAX_STACK_DEPTH * sizeof(u64));
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, PERF_MAX_STACK_DEPTH * sizeof(__u64));
 	__uint(max_entries, 10000);
 } stackmap SEC(".maps");
 
@@ -66,4 +66,3 @@ SEC("kprobe/__htab_percpu_map_update_elem")PROG(p16)
 SEC("kprobe/htab_map_alloc")PROG(p17)
 
 char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.35.1

