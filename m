Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC6E4C3063
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiBXPx2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 10:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiBXPx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 10:53:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B331768EE;
        Thu, 24 Feb 2022 07:52:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC56B826E6;
        Thu, 24 Feb 2022 15:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F097DC340E9;
        Thu, 24 Feb 2022 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645717974;
        bh=F4B7NFz9O/AImD8t6k14afQUAbBcNtoV7Q8whGE42BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EeywNKUH6h2996oP6wWhEg+LGKCRrgFB+rLpe10CkDRvKlu/zDU6QfuVQwWrhfQhX
         UQmtz293qTN80adgnHCR9PPchreiURKTZgA6vu1ZjAimSLuIfHKYX12PtYBJUlnDTo
         /ofLE4LV//VO6dO67Z+S9EZAVSeYqtDpaVAWLcXHpmsb4hqgDo/IySd30Kul1FkXFY
         GdfWi7JoShwp8abeN+fQt2AtQ3Bf0pGOayx4Gu4g+r4155h4Yw9yxQGws97//svsZ2
         LSoTrIrt1ENXj2gwsZpq3KW6ksM5O5MYHSaIqO53jak7xbLS4EGOdIcirGLOPgzD9x
         anJpmYNiBGvag==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
Date:   Thu, 24 Feb 2022 16:52:37 +0100
Message-Id: <20220224155238.714682-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224155238.714682-1-jolsa@kernel.org>
References: <20220224155238.714682-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both bpf_program__set_priv/bpf_program__priv are deprecated
and will be eventually removed.

Using hashmap to replace that functionality.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 98 ++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index efd9c703b5cc..b9d4278895ec 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -26,6 +26,7 @@
 #include "util.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
+#include "hashmap.h"
 
 #include <internal/xyarray.h>
 
@@ -55,6 +56,7 @@ struct bpf_perf_object {
 };
 
 static LIST_HEAD(bpf_objects_list);
+static struct hashmap *bpf_program_hash;
 
 static struct bpf_perf_object *
 bpf_perf_object__next(struct bpf_perf_object *prev)
@@ -173,6 +175,35 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 	return obj;
 }
 
+static void
+clear_prog_priv(const struct bpf_program *prog __maybe_unused,
+		void *_priv)
+{
+	struct bpf_prog_priv *priv = _priv;
+
+	cleanup_perf_probe_events(&priv->pev, 1);
+	zfree(&priv->insns_buf);
+	zfree(&priv->type_mapping);
+	zfree(&priv->sys_name);
+	zfree(&priv->evt_name);
+	free(priv);
+}
+
+static void bpf_program_hash_free(void)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (IS_ERR_OR_NULL(bpf_program_hash))
+		return;
+
+	hashmap__for_each_entry(bpf_program_hash, cur, bkt)
+		clear_prog_priv(cur->key, cur->value);
+
+	hashmap__free(bpf_program_hash);
+	bpf_program_hash = NULL;
+}
+
 void bpf__clear(void)
 {
 	struct bpf_perf_object *perf_obj, *tmp;
@@ -181,20 +212,55 @@ void bpf__clear(void)
 		bpf__unprobe(perf_obj->obj);
 		bpf_perf_object__close(perf_obj);
 	}
+
+	bpf_program_hash_free();
 }
 
-static void
-clear_prog_priv(struct bpf_program *prog __maybe_unused,
-		void *_priv)
+static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
 {
-	struct bpf_prog_priv *priv = _priv;
+	return (size_t) __key;
+}
 
-	cleanup_perf_probe_events(&priv->pev, 1);
-	zfree(&priv->insns_buf);
-	zfree(&priv->type_mapping);
-	zfree(&priv->sys_name);
-	zfree(&priv->evt_name);
-	free(priv);
+static bool ptr_equal(const void *key1, const void *key2,
+			  void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+static void *program_priv(const struct bpf_program *prog)
+{
+	void *priv;
+
+	if (IS_ERR_OR_NULL(bpf_program_hash))
+		return NULL;
+	if (!hashmap__find(bpf_program_hash, prog, &priv))
+		return NULL;
+	return priv;
+}
+
+static int program_set_priv(struct bpf_program *prog, void *priv)
+{
+	void *old_priv;
+
+	/*
+	 * Should not happen, we warn about it in the
+	 * caller function - config_bpf_program
+	 */
+	if (IS_ERR(bpf_program_hash))
+		return PTR_ERR(bpf_program_hash);
+
+	if (!bpf_program_hash) {
+		bpf_program_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
+		if (IS_ERR(bpf_program_hash))
+			return PTR_ERR(bpf_program_hash);
+	}
+
+	old_priv = program_priv(prog);
+	if (old_priv) {
+		clear_prog_priv(prog, old_priv);
+		return hashmap__set(bpf_program_hash, prog, priv, NULL, NULL);
+	}
+	return hashmap__add(bpf_program_hash, prog, priv);
 }
 
 static int
@@ -438,7 +504,7 @@ config_bpf_program(struct bpf_program *prog)
 	pr_debug("bpf: config '%s' is ok\n", config_str);
 
 set_priv:
-	err = bpf_program__set_priv(prog, priv, clear_prog_priv);
+	err = program_set_priv(prog, priv);
 	if (err) {
 		pr_debug("Failed to set priv for program '%s'\n", config_str);
 		goto errout;
@@ -479,7 +545,7 @@ preproc_gen_prologue(struct bpf_program *prog, int n,
 		     struct bpf_insn *orig_insns, int orig_insns_cnt,
 		     struct bpf_prog_prep_result *res)
 {
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
+	struct bpf_prog_priv *priv = program_priv(prog);
 	struct probe_trace_event *tev;
 	struct perf_probe_event *pev;
 	struct bpf_insn *buf;
@@ -630,7 +696,7 @@ static int map_prologue(struct perf_probe_event *pev, int *mapping,
 
 static int hook_load_preprocessor(struct bpf_program *prog)
 {
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
+	struct bpf_prog_priv *priv = program_priv(prog);
 	struct perf_probe_event *pev;
 	bool need_prologue = false;
 	int err, i;
@@ -706,7 +772,7 @@ int bpf__probe(struct bpf_object *obj)
 		if (err)
 			goto out;
 
-		priv = bpf_program__priv(prog);
+		priv = program_priv(prog);
 		if (IS_ERR_OR_NULL(priv)) {
 			if (!priv)
 				err = -BPF_LOADER_ERRNO__INTERNAL;
@@ -758,7 +824,7 @@ int bpf__unprobe(struct bpf_object *obj)
 	struct bpf_program *prog;
 
 	bpf_object__for_each_program(prog, obj) {
-		struct bpf_prog_priv *priv = bpf_program__priv(prog);
+		struct bpf_prog_priv *priv = program_priv(prog);
 		int i;
 
 		if (IS_ERR_OR_NULL(priv) || priv->is_tp)
@@ -814,7 +880,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 	int err;
 
 	bpf_object__for_each_program(prog, obj) {
-		struct bpf_prog_priv *priv = bpf_program__priv(prog);
+		struct bpf_prog_priv *priv = program_priv(prog);
 		struct probe_trace_event *tev;
 		struct perf_probe_event *pev;
 		int i, fd;
-- 
2.35.1

