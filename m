Return-Path: <bpf+bounces-3783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93860743776
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1031C20C16
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7DA957;
	Fri, 30 Jun 2023 08:37:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E61FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE18CC433C0;
	Fri, 30 Jun 2023 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114220;
	bh=JRI1/WGQ0U4eaP2uH9LXZN6HtzAj/Pod2zVxg7IQ3C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNL3TSYP2pB2gVkHsuzg2XEmRDsV6kvRUOuWHWWXUJgE0ZnB5h2wB/ZWSB/MNrzwQ
	 AyB1rlYmpx4O59zMxaVXSwNSrYwZDoI0RbeUSa+neI7+qQDOJaoISlF2+RIxiT7ifW
	 jVP670n7kLymsHFuwdBDr8BHmoi4IfJEfww6Wqs+Ij+VdnxxA8Kd2gH8xN80t17zuR
	 uPA5p2gb6LnZjoAoekv77I0CRr3xOpDuwj0rl77E+0BVzQFBNdpxfHu65Qj/LSus+Z
	 w+6iB2LjEKBorS0H6mg3Ve5obMylZlaZ6HNhGA0chifcAMN3eeO2V1Sg3erCPbppD3
	 GdhF8g9YZXIjQ==
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
Subject: [PATCHv3 bpf-next 16/26] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
Date: Fri, 30 Jun 2023 10:33:34 +0200
Message-ID: <20230630083344.984305-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
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
gathers uprobes info and calls bpf_program__attach_uprobe to
create all needed uprobes.

If uprobe_multi support is not detected the old behaviour stays.

Also adding usdt.s program section for sleepable usdt probes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 +++++--
 tools/lib/bpf/usdt.c   | 78 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4f61f9dc1748..e234c2e860f9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -365,6 +365,8 @@ enum sec_def_flags {
 	SEC_SLEEPABLE = 8,
 	/* BPF program support non-linear XDP buffer */
 	SEC_XDP_FRAGS = 16,
+	/* Setup proper attach type for usdt probes. */
+	SEC_USDT = 32,
 };
 
 struct bpf_sec_def {
@@ -6807,6 +6809,10 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
+	/* special check for usdt to use uprobe_multi link */
+	if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK))
+		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
 		const char *attach_name;
@@ -6875,7 +6881,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
-	load_attr.expected_attach_type = prog->expected_attach_type;
 	if (kernel_supports(obj, FEAT_PROG_NAME))
 		prog_name = prog->name;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
@@ -6911,6 +6916,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
+	/* allow prog_prepare_load_fn to change expected_attach_type */
+	load_attr.expected_attach_type = prog->expected_attach_type;
+
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
@@ -8711,7 +8719,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
-	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
+	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
+	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT|SEC_SLEEPABLE, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 9fa883ebc0bd..6ff66a8eaf85 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -809,6 +809,8 @@ struct bpf_link_usdt {
 		long abs_ip;
 		struct bpf_link *link;
 	} *uprobes;
+
+	struct bpf_link *multi_link;
 };
 
 static int bpf_link_usdt_detach(struct bpf_link *link)
@@ -817,6 +819,9 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
 	struct usdt_manager *man = usdt_link->usdt_man;
 	int i;
 
+	/* When having multi_link, uprobe_cnt is 0 */
+	bpf_link__destroy(usdt_link->multi_link);
+
 	for (i = 0; i < usdt_link->uprobe_cnt; i++) {
 		/* detach underlying uprobe link */
 		bpf_link__destroy(usdt_link->uprobes[i].link);
@@ -944,11 +949,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 					  const char *usdt_provider, const char *usdt_name,
 					  __u64 usdt_cookie)
 {
+	unsigned long *offsets = NULL, *ref_ctr_offsets = NULL;
 	int i, err, spec_map_fd, ip_map_fd;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	struct hashmap *specs_hash = NULL;
 	struct bpf_link_usdt *link = NULL;
 	struct usdt_target *targets = NULL;
+	__u64 *cookies = NULL;
 	struct elf_fd elf_fd;
 	size_t target_cnt;
 
@@ -995,10 +1002,21 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	link->link.detach = &bpf_link_usdt_detach;
 	link->link.dealloc = &bpf_link_usdt_dealloc;
 
-	link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
-	if (!link->uprobes) {
-		err = -ENOMEM;
-		goto err_out;
+	if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
+		offsets = calloc(target_cnt, sizeof(*offsets));
+		cookies = calloc(target_cnt, sizeof(*cookies));
+		ref_ctr_offsets = calloc(target_cnt, sizeof(*ref_ctr_offsets));
+
+		if (!offsets || !ref_ctr_offsets || !cookies) {
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
@@ -1039,20 +1057,48 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 			goto err_out;
 		}
 
-		opts.ref_ctr_offset = target->sema_off;
-		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
-		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
-							      target->rel_ip, &opts);
-		err = libbpf_get_error(uprobe_link);
+		if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
+			offsets[i] = target->rel_ip;
+			ref_ctr_offsets[i] = target->sema_off;
+			cookies[i] = spec_id;
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
+	if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
+		LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi,
+			.cnt = target_cnt,
+			.offsets = offsets,
+			.ref_ctr_offsets = ref_ctr_offsets,
+			.cookies = cookies,
+		);
+
+		link->multi_link = bpf_program__attach_uprobe_multi(prog, pid, path,
+								    NULL, &opts_multi);
+		err = libbpf_get_error(link->multi_link);
 		if (err) {
-			pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
-				i, usdt_provider, usdt_name, path, err);
+			pr_warn("usdt: failed to attach uprobe multi for '%s:%s' in '%s': %d\n",
+				usdt_provider, usdt_name, path, err);
 			goto err_out;
 		}
 
-		link->uprobes[i].link = uprobe_link;
-		link->uprobes[i].abs_ip = target->abs_ip;
-		link->uprobe_cnt++;
+		free(offsets);
+		free(ref_ctr_offsets);
+		free(cookies);
 	}
 
 	free(targets);
@@ -1061,6 +1107,10 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	return &link->link;
 
 err_out:
+	free(offsets);
+	free(ref_ctr_offsets);
+	free(cookies);
+
 	if (link)
 		bpf_link__destroy(&link->link);
 	free(targets);
-- 
2.41.0


