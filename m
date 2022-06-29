Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733FD55FE77
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiF2L1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiF2L1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 07:27:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7D366A6;
        Wed, 29 Jun 2022 04:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB56FB82343;
        Wed, 29 Jun 2022 11:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B185C34114;
        Wed, 29 Jun 2022 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656502045;
        bh=d8fjuT3pd7hIQJq1AFo2eymVUFBUfxy1qu/mD9lhdxk=;
        h=From:To:Cc:Subject:Date:From;
        b=cM8Cvdpwlsn3+VkDI0sK6h6jFUU2crrlKxYh8zvrzD1c1OK2241S8+3ZSsOwyKBKl
         DTH+dmQRoD8EfaYb/G6CIjItInHmrtAjo15/pWkMe3jg9j3ArsV+ofDv0QuNsk/NKE
         iUjrjrMZLQg/cpoZN0ajyt4P5g+FW2jWeDKrMtK3on6+Gxi7RbfYLv9xgdtpdaK5tU
         GxGJMpfOUMhYzVJqA2y3pw8MXkWRUUry2biigTyKPL9SMe0XRJUGUTjA9dxVlEexvJ
         nFK9StaxABJJyKwA1mm2zS4W4XXWUhvxFEuHb4fCNTot3hDSzSWzMEMOFWyT3vrWEU
         b7iux245oDV8A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] perf tools: Convert legacy map definition to  BTF-defined
Date:   Wed, 29 Jun 2022 13:27:17 +0200
Message-Id: <20220629112717.125927-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The libbpf is switching off support for legacy map definitions [1],
which will break the perf llvm tests.

Moving the base source map definition to BTF-defined, so we need
to use -g compile option for to add debug/BTF info.

[1] https://lore.kernel.org/bpf/20220627211527.2245459-1-andrii@kernel.org/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/bpf-script-example.c | 15 +++++++++------
 tools/perf/util/llvm-utils.c          |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index ab4b98b3165d..065a4ac5d8e5 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -24,13 +24,16 @@ struct bpf_map_def {
 	unsigned int max_entries;
 };
 
+#define __uint(name, val) int (*name)[val]
+#define __type(name, val) typeof(val) *name
+
 #define SEC(NAME) __attribute__((section(NAME), used))
-struct bpf_map_def SEC("maps") flip_table = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 1,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} flip_table SEC(".maps");
 
 SEC("func=do_epoll_wait")
 int bpf_func__SyS_epoll_pwait(void *ctx)
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 96c8ef60f4f8..2dc797007419 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -25,7 +25,7 @@
 		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
 
 struct llvm_param llvm_param = {
 	.clang_path = "clang",
-- 
2.35.3

