Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E84BA0F3
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 14:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiBQNTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 08:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiBQNTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 08:19:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AB2AE714;
        Thu, 17 Feb 2022 05:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3E061B53;
        Thu, 17 Feb 2022 13:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4464EC340E8;
        Thu, 17 Feb 2022 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645103971;
        bh=mjItu8EXoybpFead9lQL+S9gR/JLNKvMKHR04zWTSDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWwUauMoOTYPJiFMJDUvDbFiqt3hmWHdKAKEWxHuyR102M90cstGcxpNy5lJkm3rb
         JxGYjErWupdlWw9OjRhGuWMIyk4ESJxMNBm4PMQC4ug2EZ+J6vG60+X1jeSVdJXyBT
         /xlqmU0XEFnQ73ncscG+uEmTcEqqXQdnNodN/ACse4TClNjy1xOZRA3AG4YmxpO+N7
         DfWtdP2U0VUpz28A8Js5DnasIcoNXqh19DoDBkM1wPE4jzXokPNm/hotr2WqA1hWdI
         e66/8aAuZkFn/UwRyvkvnTTyFm487R85iXnd2ySjTJyYLLSUnpV56kLPNI70Lz5ed4
         lAqsdHPYcuVQw==
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
Subject: [PATCH 1/3] perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
Date:   Thu, 17 Feb 2022 14:19:14 +0100
Message-Id: <20220217131916.50615-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217131916.50615-1-jolsa@kernel.org>
References: <20220217131916.50615-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 tools/perf/util/bpf-loader.c | 91 +++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index db61e09be585..ec27aab2bd36 100644
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
+	if (!bpf_program_hash)
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
@@ -181,20 +212,48 @@ void bpf__clear(void)
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
+	if (!bpf_program_hash)
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
+	if (!bpf_program_hash) {
+		bpf_program_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
+		if (!bpf_program_hash)
+			return -ENOMEM;
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
@@ -438,7 +497,7 @@ config_bpf_program(struct bpf_program *prog)
 	pr_debug("bpf: config '%s' is ok\n", config_str);
 
 set_priv:
-	err = bpf_program__set_priv(prog, priv, clear_prog_priv);
+	err = program_set_priv(prog, priv);
 	if (err) {
 		pr_debug("Failed to set priv for program '%s'\n", config_str);
 		goto errout;
@@ -479,7 +538,7 @@ preproc_gen_prologue(struct bpf_program *prog, int n,
 		     struct bpf_insn *orig_insns, int orig_insns_cnt,
 		     struct bpf_prog_prep_result *res)
 {
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
+	struct bpf_prog_priv *priv = program_priv(prog);
 	struct probe_trace_event *tev;
 	struct perf_probe_event *pev;
 	struct bpf_insn *buf;
@@ -630,7 +689,7 @@ static int map_prologue(struct perf_probe_event *pev, int *mapping,
 
 static int hook_load_preprocessor(struct bpf_program *prog)
 {
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
+	struct bpf_prog_priv *priv = program_priv(prog);
 	struct perf_probe_event *pev;
 	bool need_prologue = false;
 	int err, i;
@@ -706,7 +765,7 @@ int bpf__probe(struct bpf_object *obj)
 		if (err)
 			goto out;
 
-		priv = bpf_program__priv(prog);
+		priv = program_priv(prog);
 		if (IS_ERR_OR_NULL(priv)) {
 			if (!priv)
 				err = -BPF_LOADER_ERRNO__INTERNAL;
@@ -758,7 +817,7 @@ int bpf__unprobe(struct bpf_object *obj)
 	struct bpf_program *prog;
 
 	bpf_object__for_each_program(prog, obj) {
-		struct bpf_prog_priv *priv = bpf_program__priv(prog);
+		struct bpf_prog_priv *priv = program_priv(prog);
 		int i;
 
 		if (IS_ERR_OR_NULL(priv) || priv->is_tp)
@@ -814,7 +873,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 	int err;
 
 	bpf_object__for_each_program(prog, obj) {
-		struct bpf_prog_priv *priv = bpf_program__priv(prog);
+		struct bpf_prog_priv *priv = program_priv(prog);
 		struct probe_trace_event *tev;
 		struct perf_probe_event *pev;
 		int i, fd;
-- 
2.35.1

