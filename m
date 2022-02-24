Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D674C3060
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiBXPxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 10:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiBXPxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 10:53:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838CC17C428;
        Thu, 24 Feb 2022 07:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F64661734;
        Thu, 24 Feb 2022 15:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C30C340E9;
        Thu, 24 Feb 2022 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645717984;
        bh=n55syU/tXlapEzX4NoBEFxyvoVefYeSgGLgTfFUMav8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOmV7Lo0ztEeqpzwMFaagIJ6aguH2nu6mxkjva0+rxH/8xI3F93BzCbkjZzE6jCJd
         5eDZ2xnHWaT3lJOvNCMX3VGkQHfvTt68I/u7em4cMd+Uc9KT+PgsCVE+G0fL79qh+D
         fLcW85uUy7p1YRsQZvZ7mEdMVBdu88IVJRRaWE/MFc6Mmb5iCICaXFtsekRi9xrAld
         4+CGN2KLIYWzMk8Sg79c+sUWuNYGqGoklbRqNLUhG6EJdz6fzPw6ZWd71+pNQXQ0JK
         OtXUm+XBMl9R0LX5h7OIflDPadxaqYDmgLC9K9th18wAiv/yTg7jPIDKaSqFOucEfb
         LajHmig4L4muw==
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
Subject: [PATCH 2/2] perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
Date:   Thu, 24 Feb 2022 16:52:38 +0100
Message-Id: <20220224155238.714682-3-jolsa@kernel.org>
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

Both bpf_map__set_priv/bpf_map__priv are deprecated
and will be eventually removed.

Using hashmap to replace that functionality.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 66 ++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index b9d4278895ec..4f6173756a9d 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -27,6 +27,7 @@
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
 #include "hashmap.h"
+#include "asm/bug.h"
 
 #include <internal/xyarray.h>
 
@@ -57,6 +58,7 @@ struct bpf_perf_object {
 
 static LIST_HEAD(bpf_objects_list);
 static struct hashmap *bpf_program_hash;
+static struct hashmap *bpf_map_hash;
 
 static struct bpf_perf_object *
 bpf_perf_object__next(struct bpf_perf_object *prev)
@@ -204,6 +206,8 @@ static void bpf_program_hash_free(void)
 	bpf_program_hash = NULL;
 }
 
+static void bpf_map_hash_free(void);
+
 void bpf__clear(void)
 {
 	struct bpf_perf_object *perf_obj, *tmp;
@@ -214,6 +218,7 @@ void bpf__clear(void)
 	}
 
 	bpf_program_hash_free();
+	bpf_map_hash_free();
 }
 
 static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
@@ -976,7 +981,7 @@ bpf_map_priv__purge(struct bpf_map_priv *priv)
 }
 
 static void
-bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
+bpf_map_priv__clear(const struct bpf_map *map __maybe_unused,
 		    void *_priv)
 {
 	struct bpf_map_priv *priv = _priv;
@@ -985,6 +990,53 @@ bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
 	free(priv);
 }
 
+static void *map_priv(const struct bpf_map *map)
+{
+	void *priv;
+
+	if (IS_ERR_OR_NULL(bpf_map_hash))
+		return NULL;
+	if (!hashmap__find(bpf_map_hash, map, &priv))
+		return NULL;
+	return priv;
+}
+
+static void bpf_map_hash_free(void)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (IS_ERR_OR_NULL(bpf_map_hash))
+		return;
+
+	hashmap__for_each_entry(bpf_map_hash, cur, bkt)
+		bpf_map_priv__clear(cur->key, cur->value);
+
+	hashmap__free(bpf_map_hash);
+	bpf_map_hash = NULL;
+}
+
+static int map_set_priv(struct bpf_map *map, void *priv)
+{
+	void *old_priv;
+
+	if (WARN_ON_ONCE(IS_ERR(bpf_map_hash)))
+		return PTR_ERR(bpf_program_hash);
+
+	if (!bpf_map_hash) {
+		bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
+		if (IS_ERR(bpf_map_hash))
+			return PTR_ERR(bpf_map_hash);
+	}
+
+	old_priv = map_priv(map);
+	if (old_priv) {
+		bpf_map_priv__clear(map, old_priv);
+		return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
+	}
+	return hashmap__add(bpf_map_hash, map, priv);
+}
+
 static int
 bpf_map_op_setkey(struct bpf_map_op *op, struct parse_events_term *term)
 {
@@ -1084,7 +1136,7 @@ static int
 bpf_map__add_op(struct bpf_map *map, struct bpf_map_op *op)
 {
 	const char *map_name = bpf_map__name(map);
-	struct bpf_map_priv *priv = bpf_map__priv(map);
+	struct bpf_map_priv *priv = map_priv(map);
 
 	if (IS_ERR(priv)) {
 		pr_debug("Failed to get private from map %s\n", map_name);
@@ -1099,7 +1151,7 @@ bpf_map__add_op(struct bpf_map *map, struct bpf_map_op *op)
 		}
 		INIT_LIST_HEAD(&priv->ops_list);
 
-		if (bpf_map__set_priv(map, priv, bpf_map_priv__clear)) {
+		if (map_set_priv(map, priv)) {
 			free(priv);
 			return -BPF_LOADER_ERRNO__INTERNAL;
 		}
@@ -1440,7 +1492,7 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 	struct bpf_map_op *op;
 	const struct bpf_map_def *def;
 	const char *name = bpf_map__name(map);
-	struct bpf_map_priv *priv = bpf_map__priv(map);
+	struct bpf_map_priv *priv = map_priv(map);
 
 	if (IS_ERR(priv)) {
 		pr_debug("ERROR: failed to get private from map %s\n", name);
@@ -1660,7 +1712,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 	bool need_init = false;
 
 	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
-		struct bpf_map_priv *priv = bpf_map__priv(map);
+		struct bpf_map_priv *priv = map_priv(map);
 
 		if (IS_ERR(priv))
 			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
@@ -1696,7 +1748,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 	}
 
 	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
-		struct bpf_map_priv *priv = bpf_map__priv(map);
+		struct bpf_map_priv *priv = map_priv(map);
 
 		if (IS_ERR(priv))
 			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
@@ -1708,7 +1760,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 			if (!priv)
 				return ERR_PTR(-ENOMEM);
 
-			err = bpf_map__set_priv(map, priv, bpf_map_priv__clear);
+			err = map_set_priv(map, priv);
 			if (err) {
 				bpf_map_priv__clear(map, priv);
 				return ERR_PTR(err);
-- 
2.35.1

