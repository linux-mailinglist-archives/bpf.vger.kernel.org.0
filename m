Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD76ED209
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDXQG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjDXQGz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063E7EFB
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A1D561B3B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F306FC433D2;
        Mon, 24 Apr 2023 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352412;
        bh=pNRjBUNyKBNcAnDVy1rTVmvLfFVckIGQV5XaTb0Zfb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYYxnDOYVhM0aIo/brcLuIbYted4gGrHIPdR8jQlQxglDFTEfPuynIHb/Ui9KFidD
         Od1JKWk6mm9Wt4bS2wzU70TXf/9Z3/YVlGEdwVwcqdsNCfrrYNz1GMwtTuZO9vgo5R
         S2Yek1ePq2Ok1WpxUS8yeoSkfuecWfSVtEjMW6VPHnUnb8RLjOgskNE0enPFXUPDo5
         UWcgoyycl3wr8T/zPDboWqlN4FQqcPoGeoAXyr0s9OYgG8xxqW29oc0u7ZR+n5VBeB
         86cudWc5bd8/wiFFObjXxvMzqfSoJ8PB+s5nLFL8WqRYr7+EpofhT5gic0uyTCY0G0
         +JJPEA4LDe6xQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 12/20] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
Date:   Mon, 24 Apr 2023 18:04:39 +0200
Message-Id: <20230424160447.2005755-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding uprobe_multi bool to struct bpf_usdt_opts. If it's true
the usdt_manager_attach_usdt will use uprobe_multi link to attach
to usdt probes.

The bpf program for usdt probe needs to have BPF_TRACE_UPROBE_MULTI
set as expected_attach_type.

Because current uprobe is implemented through perf event interface,
it allows the pid filter for uprobes. This is not the case for
uprobe_multi link, so the pid filter is not allowed for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          |   9 ++-
 tools/lib/bpf/libbpf.h          |   2 +
 tools/lib/bpf/libbpf_internal.h |   2 +-
 tools/lib/bpf/usdt.c            | 127 ++++++++++++++++++++++++--------
 4 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 70353aaac86e..25d32aa605e8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6817,7 +6817,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
-	load_attr.expected_attach_type = prog->expected_attach_type;
 	if (kernel_supports(obj, FEAT_PROG_NAME))
 		prog_name = prog->name;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
@@ -6853,6 +6852,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
+	/* allow prog_prepare_load_fn to change expected_attach_type */
+	load_attr.expected_attach_type = prog->expected_attach_type;
+
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
@@ -11730,6 +11732,7 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 	struct bpf_object *obj = prog->obj;
 	struct bpf_link *link;
 	__u64 usdt_cookie;
+	bool uprobe_multi;
 	int err;
 
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
@@ -11766,8 +11769,10 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 	}
 
 	usdt_cookie = OPTS_GET(opts, usdt_cookie, 0);
+	uprobe_multi = OPTS_GET(opts, uprobe_multi, 0);
 	link = usdt_manager_attach_usdt(obj->usdt_man, prog, pid, binary_path,
-					usdt_provider, usdt_name, usdt_cookie);
+					usdt_provider, usdt_name, usdt_cookie,
+					uprobe_multi);
 	err = libbpf_get_error(link);
 	if (err)
 		return libbpf_err_ptr(err);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 921ab2a94cec..025feb21c2ec 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -673,6 +673,8 @@ struct bpf_usdt_opts {
 	size_t sz;
 	/* custom user-provided value accessible through usdt_cookie() */
 	__u64 usdt_cookie;
+	/* use uprobe_multi link */
+	bool uprobe_multi;
 	size_t :0;
 };
 #define bpf_usdt_opts__last_field usdt_cookie
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e4d05662a96c..5d5f61d0bcfb 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -567,7 +567,7 @@ struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
 					   const struct bpf_program *prog,
 					   pid_t pid, const char *path,
 					   const char *usdt_provider, const char *usdt_name,
-					   __u64 usdt_cookie);
+					   __u64 usdt_cookie, bool uprobe_multi);
 
 static inline bool is_pow_of_2(size_t x)
 {
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index b8402e3f9eb2..f55dbd47d29e 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -803,11 +803,20 @@ struct bpf_link_usdt {
 	size_t spec_cnt;
 	int *spec_ids;
 
+	bool has_uprobe_multi;
+
 	size_t uprobe_cnt;
 	struct {
 		long abs_ip;
 		struct bpf_link *link;
 	} *uprobes;
+	struct {
+		char **paths;
+		unsigned long *offsets;
+		unsigned long *ref_ctr_offsets;
+		__u64 *cookies;
+		struct bpf_link *link;
+	} uprobe_multi;
 };
 
 static int bpf_link_usdt_detach(struct bpf_link *link)
@@ -816,19 +825,23 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
 	struct usdt_manager *man = usdt_link->usdt_man;
 	int i;
 
-	for (i = 0; i < usdt_link->uprobe_cnt; i++) {
-		/* detach underlying uprobe link */
-		bpf_link__destroy(usdt_link->uprobes[i].link);
-		/* there is no need to update specs map because it will be
-		 * unconditionally overwritten on subsequent USDT attaches,
-		 * but if BPF cookies are not used we need to remove entry
-		 * from ip_to_spec_id map, otherwise we'll run into false
-		 * conflicting IP errors
-		 */
-		if (!man->has_bpf_cookie) {
-			/* not much we can do about errors here */
-			(void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
-						  &usdt_link->uprobes[i].abs_ip);
+	if (usdt_link->has_uprobe_multi) {
+		bpf_link__destroy(usdt_link->uprobe_multi.link);
+	} else {
+		for (i = 0; i < usdt_link->uprobe_cnt; i++) {
+			/* detach underlying uprobe link */
+			bpf_link__destroy(usdt_link->uprobes[i].link);
+			/* there is no need to update specs map because it will be
+			 * unconditionally overwritten on subsequent USDT attaches,
+			 * but if BPF cookies are not used we need to remove entry
+			 * from ip_to_spec_id map, otherwise we'll run into false
+			 * conflicting IP errors
+			 */
+			if (!man->has_bpf_cookie) {
+				/* not much we can do about errors here */
+				(void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
+							  &usdt_link->uprobes[i].abs_ip);
+			}
 		}
 	}
 
@@ -868,9 +881,16 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
 
-	free(usdt_link->spec_ids);
-	free(usdt_link->uprobes);
-	free(usdt_link);
+	if (usdt_link->has_uprobe_multi) {
+		free(usdt_link->uprobe_multi.paths);
+		free(usdt_link->uprobe_multi.offsets);
+		free(usdt_link->uprobe_multi.ref_ctr_offsets);
+		free(usdt_link->uprobe_multi.cookies);
+	} else {
+		free(usdt_link->spec_ids);
+		free(usdt_link->uprobes);
+		free(usdt_link);
+	}
 }
 
 static size_t specs_hash_fn(long key, void *ctx)
@@ -941,16 +961,22 @@ static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash
 struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
 					  pid_t pid, const char *path,
 					  const char *usdt_provider, const char *usdt_name,
-					  __u64 usdt_cookie)
+					  __u64 usdt_cookie, bool uprobe_multi)
 {
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi);
 	int i, fd, err, spec_map_fd, ip_map_fd;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	struct hashmap *specs_hash = NULL;
 	struct bpf_link_usdt *link = NULL;
 	struct usdt_target *targets = NULL;
+	struct bpf_link *uprobe_link;
 	size_t target_cnt;
 	Elf *elf;
 
+	/* The uprobe_multi link does not have pid filter. */
+	if (uprobe_multi && pid >= 0)
+		return libbpf_err_ptr(-EINVAL);
+
 	spec_map_fd = bpf_map__fd(man->specs_map);
 	ip_map_fd = bpf_map__fd(man->ip_to_spec_id_map);
 
@@ -1001,19 +1027,32 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 		goto err_out;
 	}
 
+	link->has_uprobe_multi = uprobe_multi;
 	link->usdt_man = man;
 	link->link.detach = &bpf_link_usdt_detach;
 	link->link.dealloc = &bpf_link_usdt_dealloc;
 
-	link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
-	if (!link->uprobes) {
-		err = -ENOMEM;
-		goto err_out;
+	if (uprobe_multi) {
+		link->uprobe_multi.paths = calloc(target_cnt, sizeof(*link->uprobe_multi.paths));
+		link->uprobe_multi.offsets = calloc(target_cnt, sizeof(*link->uprobe_multi.offsets));
+		link->uprobe_multi.ref_ctr_offsets = calloc(target_cnt, sizeof(*link->uprobe_multi.ref_ctr_offsets));
+		link->uprobe_multi.cookies = calloc(target_cnt, sizeof(*link->uprobe_multi.cookies));
+
+		if (!link->uprobe_multi.paths || !link->uprobe_multi.offsets ||
+		    !link->uprobe_multi.ref_ctr_offsets || !link->uprobe_multi.cookies) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	} else {
+		link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
+		if (!link->uprobes) {
+			err = -ENOMEM;
+			goto err_out;
+		}
 	}
 
 	for (i = 0; i < target_cnt; i++) {
 		struct usdt_target *target = &targets[i];
-		struct bpf_link *uprobe_link;
 		bool is_new;
 		int spec_id;
 
@@ -1049,20 +1088,44 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 			goto err_out;
 		}
 
-		opts.ref_ctr_offset = target->sema_off;
-		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
-		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
-							      target->rel_ip, &opts);
+		if (uprobe_multi) {
+			link->uprobe_multi.paths[i] = (char *) path;
+			link->uprobe_multi.offsets[i] = target->rel_ip;
+			link->uprobe_multi.ref_ctr_offsets[i] = target->sema_off;
+			link->uprobe_multi.cookies[i] = spec_id;
+		} else {
+			opts.ref_ctr_offset = target->sema_off;
+			opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
+			uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
+								      target->rel_ip, &opts);
+			err = libbpf_get_error(uprobe_link);
+			if (err) {
+				pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
+					i, usdt_provider, usdt_name, path, err);
+				goto err_out;
+			}
+
+			link->uprobes[i].link = uprobe_link;
+			link->uprobes[i].abs_ip = target->abs_ip;
+			link->uprobe_cnt++;
+		}
+	}
+
+	if (uprobe_multi) {
+		opts_multi.cnt = target_cnt;
+		opts_multi.paths = (const char **) link->uprobe_multi.paths;
+		opts_multi.offsets = link->uprobe_multi.offsets;
+		opts_multi.ref_ctr_offsets = link->uprobe_multi.ref_ctr_offsets;
+		opts_multi.cookies = link->uprobe_multi.cookies;
+
+		uprobe_link = bpf_program__attach_uprobe_multi_opts(prog, NULL, NULL, &opts_multi);
 		err = libbpf_get_error(uprobe_link);
 		if (err) {
-			pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
-				i, usdt_provider, usdt_name, path, err);
+			pr_warn("usdt: failed to attach uprobe multi for '%s:%s' in '%s': %d\n",
+				usdt_provider, usdt_name, path, err);
 			goto err_out;
 		}
-
-		link->uprobes[i].link = uprobe_link;
-		link->uprobes[i].abs_ip = target->abs_ip;
-		link->uprobe_cnt++;
+		link->uprobe_multi.link = uprobe_link;
 	}
 
 	free(targets);
-- 
2.40.0

