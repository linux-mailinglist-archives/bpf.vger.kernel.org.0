Return-Path: <bpf+bounces-2894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B069E73666D
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43301C2097D
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C05C121;
	Tue, 20 Jun 2023 08:38:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D60BE68
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33238C433C8;
	Tue, 20 Jun 2023 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250291;
	bh=tI02N+zdwXIpS7egsOVkAi/cl+6VnbmyodziglFpAe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBlD02SbrMWo9+AwYuyLICOwSXW/ziwFR0z+TGVwQjTEng0vfZlJPbLCVAgXhnZlo
	 g77bR/Ty5coWIHTrQD7H7SGiI/B6cPglhaLJAWXiB+xcflg8ZcFWSGCBlx+HLBNbWV
	 qeQKi5tjERrFOcHMcrLCxyofqvhia/mXSKiz1vEcy20h6fZ1Jd2EGQp0eNi64zHqdS
	 cTM/sL1o8tCMcuRuDHSlWDmN6j1ocRgOKZLynodaAN47jE5PnuTovUKrMKQbERON6J
	 d2X+b2N7PsfXF0YghQf4gK2D+zN4TXt3UffHV/QugDX84QW8zeIlAQGRYDB3Rrfot1
	 fYtdsChsA2pmg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 14/24] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
Date: Tue, 20 Jun 2023 10:35:40 +0200
Message-ID: <20230620083550.690426-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for usdt_manager_attach_usdt to use uprobe_multi
link to attach to usdt probes.

The uprobe_multi support is detected before the usdt program is
loaded and its expected_attach_type is set accordingly.

If uprobe_multi support is detected the usdt_manager_attach_usdt
gathers uprobes info and calls bpf_program__attach_uprobe_opts to
create all needed uprobes.

If uprobe_multi support is not detected the old behaviour stays.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c |  12 ++++-
 tools/lib/bpf/usdt.c   | 120 ++++++++++++++++++++++++++++++-----------
 2 files changed, 99 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3d570898459e..9c7a67c5cbe8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -363,6 +363,8 @@ enum sec_def_flags {
 	SEC_SLEEPABLE = 8,
 	/* BPF program support non-linear XDP buffer */
 	SEC_XDP_FRAGS = 16,
+	/* Setup proper attach type for usdt probes. */
+	SEC_USDT = 32,
 };
 
 struct bpf_sec_def {
@@ -6799,6 +6801,10 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
+	/* special check for usdt to use uprobe_multi link */
+	if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_LINK))
+		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
 		const char *attach_name;
@@ -6867,7 +6873,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
-	load_attr.expected_attach_type = prog->expected_attach_type;
 	if (kernel_supports(obj, FEAT_PROG_NAME))
 		prog_name = prog->name;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
@@ -6903,6 +6908,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
+	/* allow prog_prepare_load_fn to change expected_attach_type */
+	load_attr.expected_attach_type = prog->expected_attach_type;
+
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
@@ -8703,7 +8711,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
-	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
+	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index f1a141555f08..33f0a2b4cc1c 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -808,6 +808,16 @@ struct bpf_link_usdt {
 		long abs_ip;
 		struct bpf_link *link;
 	} *uprobes;
+
+	bool has_uprobe_multi;
+
+	struct {
+		char *path;
+		unsigned long *offsets;
+		unsigned long *ref_ctr_offsets;
+		__u64 *cookies;
+		struct bpf_link *link;
+	} uprobe_multi;
 };
 
 static int bpf_link_usdt_detach(struct bpf_link *link)
@@ -816,19 +826,23 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
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
 
@@ -868,9 +882,15 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
 
-	free(usdt_link->spec_ids);
-	free(usdt_link->uprobes);
-	free(usdt_link);
+	if (usdt_link->has_uprobe_multi) {
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
@@ -943,11 +963,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 					  const char *usdt_provider, const char *usdt_name,
 					  __u64 usdt_cookie)
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
 
@@ -1003,16 +1025,29 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	link->usdt_man = man;
 	link->link.detach = &bpf_link_usdt_detach;
 	link->link.dealloc = &bpf_link_usdt_dealloc;
+	link->has_uprobe_multi = bpf_program__expected_attach_type(prog) == BPF_TRACE_UPROBE_MULTI;
 
-	link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
-	if (!link->uprobes) {
-		err = -ENOMEM;
-		goto err_out;
+	if (link->has_uprobe_multi) {
+		link->uprobe_multi.offsets = calloc(target_cnt, sizeof(*link->uprobe_multi.offsets));
+		link->uprobe_multi.ref_ctr_offsets = calloc(target_cnt, sizeof(*link->uprobe_multi.ref_ctr_offsets));
+		link->uprobe_multi.cookies = calloc(target_cnt, sizeof(*link->uprobe_multi.cookies));
+
+		if (!link->uprobe_multi.offsets ||
+		    !link->uprobe_multi.ref_ctr_offsets ||
+		    !link->uprobe_multi.cookies) {
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
 
@@ -1048,20 +1083,43 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 			goto err_out;
 		}
 
-		opts.ref_ctr_offset = target->sema_off;
-		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
-		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
-							      target->rel_ip, &opts);
+		if (link->has_uprobe_multi) {
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
+	if (link->has_uprobe_multi) {
+		opts_multi.cnt = target_cnt;
+		opts_multi.path = path;
+		opts_multi.offsets = link->uprobe_multi.offsets;
+		opts_multi.ref_ctr_offsets = link->uprobe_multi.ref_ctr_offsets;
+		opts_multi.cookies = link->uprobe_multi.cookies;
+
+		uprobe_link = bpf_program__attach_uprobe_multi_opts(prog, pid, NULL, NULL, &opts_multi);
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
2.41.0


