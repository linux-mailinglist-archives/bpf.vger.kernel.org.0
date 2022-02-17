Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82074BA0E9
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiBQNT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 08:19:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiBQNT6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 08:19:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B672AED80;
        Thu, 17 Feb 2022 05:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50224B82194;
        Thu, 17 Feb 2022 13:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63905C340E8;
        Thu, 17 Feb 2022 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645103981;
        bh=UjT2kgD9baGmDbmhqizndkgeYds6jviLIAkYuMBbpMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCimiTFLnN2i7DKVexX5qAUICxFmZW+v5H6pJiNByIc/G/NGimCnSVGTLtMdN5O6U
         fiVKL6IDivQvDjohqL0KrAVhBPlFIV9pxwIu6uzFmoqQzSCU2enEvga5SLhtDll+PQ
         HOs+TGDc0177kjlAkBJLi8AH7+jph3YdcODGj4f1JlWKMFeF+M4yp957YuCtyokUek
         GrsWf9Qj8rGqS79EKRzfeLRMABHjWJfICw6BeZxC8y5Hu0G6bQqkeS4vZy/GqZ2/YL
         9EEDSap9oebPjc7O1ora1KLXdaCIbmTerszRG9fC59yoJXvf3lXuHO7gPcS2K1egMU
         kwJzSDyS5podA==
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
Subject: [PATCH 2/3] perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
Date:   Thu, 17 Feb 2022 14:19:15 +0100
Message-Id: <20220217131916.50615-3-jolsa@kernel.org>
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

Both bpf_map__set_priv/bpf_map__priv are deprecated
and will be eventually removed.

Using hashmap to replace that functionality.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 62 ++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index ec27aab2bd36..6f87729817ad 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -57,6 +57,7 @@ struct bpf_perf_object {
 
 static LIST_HEAD(bpf_objects_list);
 static struct hashmap *bpf_program_hash;
+static struct hashmap *bpf_map_hash;
 
 static struct bpf_perf_object *
 bpf_perf_object__next(struct bpf_perf_object *prev)
@@ -204,6 +205,8 @@ static void bpf_program_hash_free(void)
 	bpf_program_hash = NULL;
 }
 
+static void bpf_map_hash_free(void);
+
 void bpf__clear(void)
 {
 	struct bpf_perf_object *perf_obj, *tmp;
@@ -214,6 +217,7 @@ void bpf__clear(void)
 	}
 
 	bpf_program_hash_free();
+	bpf_map_hash_free();
 }
 
 static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
@@ -969,7 +973,7 @@ bpf_map_priv__purge(struct bpf_map_priv *priv)
 }
 
 static void
-bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
+bpf_map_priv__clear(const struct bpf_map *map __maybe_unused,
 		    void *_priv)
 {
 	struct bpf_map_priv *priv = _priv;
@@ -978,6 +982,50 @@ bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
 	free(priv);
 }
 
+static void *map_priv(const struct bpf_map *map)
+{
+	void *priv;
+
+	if (!bpf_map_hash)
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
+	if (!bpf_map_hash)
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
+	if (!bpf_map_hash) {
+		bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
+		if (!bpf_map_hash)
+			return -ENOMEM;
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
@@ -1077,7 +1125,7 @@ static int
 bpf_map__add_op(struct bpf_map *map, struct bpf_map_op *op)
 {
 	const char *map_name = bpf_map__name(map);
-	struct bpf_map_priv *priv = bpf_map__priv(map);
+	struct bpf_map_priv *priv = map_priv(map);
 
 	if (IS_ERR(priv)) {
 		pr_debug("Failed to get private from map %s\n", map_name);
@@ -1092,7 +1140,7 @@ bpf_map__add_op(struct bpf_map *map, struct bpf_map_op *op)
 		}
 		INIT_LIST_HEAD(&priv->ops_list);
 
-		if (bpf_map__set_priv(map, priv, bpf_map_priv__clear)) {
+		if (map_set_priv(map, priv)) {
 			free(priv);
 			return -BPF_LOADER_ERRNO__INTERNAL;
 		}
@@ -1432,7 +1480,7 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 	struct bpf_map_op *op;
 	const struct bpf_map_def *def;
 	const char *name = bpf_map__name(map);
-	struct bpf_map_priv *priv = bpf_map__priv(map);
+	struct bpf_map_priv *priv = map_priv(map);
 
 	if (IS_ERR(priv)) {
 		pr_debug("ERROR: failed to get private from map %s\n", name);
@@ -1652,7 +1700,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 	bool need_init = false;
 
 	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
-		struct bpf_map_priv *priv = bpf_map__priv(map);
+		struct bpf_map_priv *priv = map_priv(map);
 
 		if (IS_ERR(priv))
 			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
@@ -1688,7 +1736,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 	}
 
 	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
-		struct bpf_map_priv *priv = bpf_map__priv(map);
+		struct bpf_map_priv *priv = map_priv(map);
 
 		if (IS_ERR(priv))
 			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
@@ -1700,7 +1748,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 			if (!priv)
 				return ERR_PTR(-ENOMEM);
 
-			err = bpf_map__set_priv(map, priv, bpf_map_priv__clear);
+			err = map_set_priv(map, priv);
 			if (err) {
 				bpf_map_priv__clear(map, priv);
 				return ERR_PTR(err);
-- 
2.35.1

