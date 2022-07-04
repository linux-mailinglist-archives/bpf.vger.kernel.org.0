Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667005659BD
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGDP1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiGDP13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 11:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D8CE11;
        Mon,  4 Jul 2022 08:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82D861741;
        Mon,  4 Jul 2022 15:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C379C3411E;
        Mon,  4 Jul 2022 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656948448;
        bh=SBO5j9zc5dNFisK0fKtoA0eUNhaH5nh3Zn77jItG49Y=;
        h=From:To:Cc:Subject:Date:From;
        b=NQMF2072MscULiCWo5iV63hGtGOkyb4t8gZQvDTYG+o+lfO56hYzTRenPV78+4oWJ
         Lq3mOSbBjYRDyfF5kiY0yxBB2Y43Z7ETPYyNukMOQBCE/boF5XfeakVW5/nBoGfLjJ
         O98QjcTYI+B3d7C5oTvH+aqUutOy8jK8F3l09rVofdK5Iq4m8s64tFmxpP7fMOuSZV
         LmG67TQVweH00i3gkcPev/EohCZRZdZCCzuheXhS2+D4H+lki6ydeuQj3/Yjd9evGW
         E4EDEcaqLNRK6KBdEbDKA+O8K4g9uwsi+cZO6MpME/0wcSVIsnmr5ae8sp45vPvhH5
         TQ2mANCfKTyFQ==
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
Subject: [PATCHv2] perf tools: Convert legacy map definition to BTF-defined
Date:   Mon,  4 Jul 2022 17:27:21 +0200
Message-Id: <20220704152721.352046-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 tools/perf/tests/bpf-script-example.c | 35 ++++++++++++++++++---------
 tools/perf/util/llvm-utils.c          |  2 +-
 2 files changed, 24 insertions(+), 13 deletions(-)

v2 changes:
  - added comments to macros [Ian]
  - removed struct bpf_map_def, it's no longer needed

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index ab4b98b3165d..7981c69ed1b4 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -17,20 +17,31 @@ static void *(*bpf_map_lookup_elem)(void *map, void *key) =
 static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
 	(void *) BPF_FUNC_map_update_elem;
 
-struct bpf_map_def {
-	unsigned int type;
-	unsigned int key_size;
-	unsigned int value_size;
-	unsigned int max_entries;
-};
+/*
+ * Following macros are taken from tools/lib/bpf/bpf_helpers.h,
+ * and are used to create BTF defined maps. It is easier to take
+ * 2 simple macros, than being able to include above header in
+ * runtime.
+ *
+ * __uint - defines integer attribute of BTF map definition,
+ * Such attributes are represented using a pointer to an array,
+ * in which dimensionality of array encodes specified integer
+ * value.
+ *
+ * __type - defines pointer variable with typeof(val) type for
+ * attributes like key or value, which will be defined by the
+ * size of the type.
+ */
+#define __uint(name, val) int (*name)[val]
+#define __type(name, val) typeof(val) *name
 
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

