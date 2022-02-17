Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B454BA0E5
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiBQNUI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 08:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbiBQNUH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 08:20:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634E2AE734;
        Thu, 17 Feb 2022 05:19:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A91D1B821AD;
        Thu, 17 Feb 2022 13:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B81C340F3;
        Thu, 17 Feb 2022 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645103990;
        bh=rR7j4YmApToV2YRSuDP85+mXkntJiYfEZ6H5iwYSzI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fq+3M5303bdT8nnwZwd6StHMbYmnzty+zNmXGOyZhhOgWRNaORBj6kRFGKB6dmr6+
         6ozd59BmPk0ntm/0Np6Mmwuimuob2VS2m3st+CaS/M1GnGyJVTZsyDzYXQhyCJTy2v
         BP1B8WihX4nTQLj7aWRzuGdm70k1rQ/5te+3AlCoO5Yvq84a61SpnshVZIV7CkhVnJ
         YnbT7KMVJ8BinOYhglGJnTF3p0wgdcZfxuyMpRKO8V3qZCedsefEoDbLxMw+tOiAd5
         9L8n2sDkevjRactDrAqq9On7WICoBvwjqZusCI+Ou+586bJN7d3S7kWzy6pC3SrzqM
         j8Oxuc8ZSEhAQ==
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
Subject: [PATCH 3/3] perf tools: Rework prologue generation code
Date:   Thu, 17 Feb 2022 14:19:16 +0100
Message-Id: <20220217131916.50615-4-jolsa@kernel.org>
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

Some functions we use now for bpf prologue generation are
going to be deprecated, so reworking the current code not
to use them.

We need to replace following functions/struct:
   bpf_program__set_prep
   bpf_program__nth_fd
   struct bpf_prog_prep_result

Current code uses bpf_program__set_prep to hook perf callback
before the program is loaded and provide new instructions with
the prologue.

We workaround this by using objects's 'unloaded' programs instructions
for that specific program and load new ebpf programs with prologue
using separate bpf_prog_load calls.

We keep new ebpf program instances descriptors in bpf programs
private struct.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 6f87729817ad..03f917002c00 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -48,6 +48,7 @@ struct bpf_prog_priv {
 	struct bpf_insn *insns_buf;
 	int nr_types;
 	int *type_mapping;
+	int *proglogue_fds;
 };
 
 struct bpf_perf_object {
@@ -55,6 +56,11 @@ struct bpf_perf_object {
 	struct bpf_object *obj;
 };
 
+struct bpf_preproc_result {
+	struct bpf_insn *new_insn_ptr;
+	int new_insn_cnt;
+};
+
 static LIST_HEAD(bpf_objects_list);
 static struct hashmap *bpf_program_hash;
 static struct hashmap *bpf_map_hash;
@@ -176,14 +182,31 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 	return obj;
 }
 
+static void close_prologue_programs(struct bpf_prog_priv *priv)
+{
+	struct perf_probe_event *pev;
+	int i, fd;
+
+	if (!priv->need_prologue)
+		return;
+	pev = &priv->pev;
+	for (i = 0; i < pev->ntevs; i++) {
+		fd = close(priv->proglogue_fds[i]);
+		if (fd != -1)
+			close(fd);
+	}
+}
+
 static void
 clear_prog_priv(const struct bpf_program *prog __maybe_unused,
 		void *_priv)
 {
 	struct bpf_prog_priv *priv = _priv;
 
+	close_prologue_programs(priv);
 	cleanup_perf_probe_events(&priv->pev, 1);
 	zfree(&priv->insns_buf);
+	zfree(&priv->proglogue_fds);
 	zfree(&priv->type_mapping);
 	zfree(&priv->sys_name);
 	zfree(&priv->evt_name);
@@ -539,8 +562,8 @@ static int bpf__prepare_probe(void)
 
 static int
 preproc_gen_prologue(struct bpf_program *prog, int n,
-		     struct bpf_insn *orig_insns, int orig_insns_cnt,
-		     struct bpf_prog_prep_result *res)
+		     const struct bpf_insn *orig_insns, int orig_insns_cnt,
+		     struct bpf_preproc_result *res)
 {
 	struct bpf_prog_priv *priv = program_priv(prog);
 	struct probe_trace_event *tev;
@@ -588,7 +611,6 @@ preproc_gen_prologue(struct bpf_program *prog, int n,
 
 	res->new_insn_ptr = buf;
 	res->new_insn_cnt = prologue_cnt + orig_insns_cnt;
-	res->pfd = NULL;
 	return 0;
 
 errout:
@@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
 	struct bpf_prog_priv *priv = program_priv(prog);
 	struct perf_probe_event *pev;
 	bool need_prologue = false;
-	int err, i;
+	int i;
 
 	if (IS_ERR_OR_NULL(priv)) {
 		pr_debug("Internal error when hook preprocessor\n");
@@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
 		return 0;
 	}
 
+	/*
+	 * Do not load programs that need prologue, because we need
+	 * to add prologue first, check bpf_object__load_prologue.
+	 */
+	bpf_program__set_autoload(prog, false);
+
 	priv->need_prologue = true;
 	priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
 	if (!priv->insns_buf) {
@@ -734,6 +762,13 @@ static int hook_load_preprocessor(struct bpf_program *prog)
 		return -ENOMEM;
 	}
 
+	priv->proglogue_fds = malloc(sizeof(int) * pev->ntevs);
+	if (!priv->proglogue_fds) {
+		pr_debug("Not enough memory: alloc prologue fds failed\n");
+		return -ENOMEM;
+	}
+	memset(priv->proglogue_fds, -1, sizeof(int) * pev->ntevs);
+
 	priv->type_mapping = malloc(sizeof(int) * pev->ntevs);
 	if (!priv->type_mapping) {
 		pr_debug("Not enough memory: alloc type_mapping failed\n");
@@ -742,13 +777,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
 	memset(priv->type_mapping, -1,
 	       sizeof(int) * pev->ntevs);
 
-	err = map_prologue(pev, priv->type_mapping, &priv->nr_types);
-	if (err)
-		return err;
-
-	err = bpf_program__set_prep(prog, priv->nr_types,
-				    preproc_gen_prologue);
-	return err;
+	return map_prologue(pev, priv->type_mapping, &priv->nr_types);
 }
 
 int bpf__probe(struct bpf_object *obj)
@@ -855,6 +884,66 @@ int bpf__unprobe(struct bpf_object *obj)
 	return ret;
 }
 
+static int bpf_object__load_prologue(struct bpf_object *obj)
+{
+	const struct bpf_insn *orig_insns;
+	struct bpf_preproc_result res;
+	struct perf_probe_event *pev;
+	struct bpf_program *prog;
+	int orig_insns_cnt;
+
+	bpf_object__for_each_program(prog, obj) {
+		struct bpf_prog_priv *priv = program_priv(prog);
+		int err, i, fd;
+
+		if (IS_ERR_OR_NULL(priv)) {
+			pr_debug("bpf: failed to get private field\n");
+			return -BPF_LOADER_ERRNO__INTERNAL;
+		}
+
+		if (!priv->need_prologue)
+			continue;
+
+		/*
+		 * For each program that needs prologue we do following:
+		 *
+		 * - take its current instructions and use them
+		 *   to generate the new code with prologue
+		 *
+		 * - load new instructions with bpf_prog_load
+		 *   and keep the fd in proglogue_fds
+		 *
+		 * - new fd will be used bpf__foreach_event
+		 *   to connect this program with perf evsel
+		 */
+		orig_insns = bpf_program__insns(prog);
+		orig_insns_cnt = bpf_program__insn_cnt(prog);
+
+		pev = &priv->pev;
+		for (i = 0; i < pev->ntevs; i++) {
+			err = preproc_gen_prologue(prog, i, orig_insns,
+						   orig_insns_cnt, &res);
+			if (err)
+				return err;
+
+			fd = bpf_prog_load(bpf_program__get_type(prog),
+					   bpf_program__name(prog), "GPL",
+					   res.new_insn_ptr,
+					   res.new_insn_cnt, NULL);
+			if (fd < 0) {
+				char bf[128];
+
+				libbpf_strerror(-errno, bf, sizeof(bf));
+				pr_debug("bpf: load objects with prologue failed: err=%d: (%s)\n",
+					 -errno, bf);
+				return -errno;
+			}
+			priv->proglogue_fds[i] = fd;
+		}
+	}
+	return 0;
+}
+
 int bpf__load(struct bpf_object *obj)
 {
 	int err;
@@ -866,7 +955,7 @@ int bpf__load(struct bpf_object *obj)
 		pr_debug("bpf: load objects failed: err=%d: (%s)\n", err, bf);
 		return err;
 	}
-	return 0;
+	return bpf_object__load_prologue(obj);
 }
 
 int bpf__foreach_event(struct bpf_object *obj,
@@ -901,13 +990,10 @@ int bpf__foreach_event(struct bpf_object *obj,
 		for (i = 0; i < pev->ntevs; i++) {
 			tev = &pev->tevs[i];
 
-			if (priv->need_prologue) {
-				int type = priv->type_mapping[i];
-
-				fd = bpf_program__nth_fd(prog, type);
-			} else {
+			if (priv->need_prologue)
+				fd = priv->proglogue_fds[i];
+			else
 				fd = bpf_program__fd(prog);
-			}
 
 			if (fd < 0) {
 				pr_debug("bpf: failed to get file descriptor\n");
-- 
2.35.1

