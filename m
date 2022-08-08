Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3642E58CA2A
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiHHOIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbiHHOIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8F11469
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3075B80EAF
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB2AC433D6;
        Mon,  8 Aug 2022 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967714;
        bh=tvoonCVkEcQXrDvihrwNK1EdUBcLBF4/LkMYkioETHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcIBkkF/URwlf7NQGt40MEWOOy0BI94FBIcBz2Qwm2TIsBnFBOZxLnSzMxnsD7J2z
         LHtNxP8zMZ57hVYG2sinTC+IYvcK+dlRWErOh50BSeF74xS+kNL0zygHgPVOp7ZrBp
         l7S5SB0LO9L9tcw8ovqipJ8hRqMHbY965TFlPqBFeloOyPcbQd7LPpNRJn8JyykZ+I
         zShI3HTbTGi5YjQCFPHQ+IQziMLH15pWLpkara5U+VR9ajLrePKBSdTRvQen9lfHrM
         NFqzpcE/5Me3aoNw0+wQl6NkzHqE8QTkvf9jUiCSbjCLS+kGutyv1HHPT+cXkQQMQo
         xCVcOmJEoq6hQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 11/17] bpf: Add support to create tracing multi link
Date:   Mon,  8 Aug 2022 16:06:20 +0200
Message-Id: <20220808140626.422731-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new link to allow to attach program to multiple
function BTF IDs.

New fields are added to bpf_attr::link_create to pass
array of BTF IDs:

  struct {
    __aligned_u64   btf_ids;        /* addresses to attach */
    __u32           btf_ids_cnt;    /* addresses count */
  } multi;

The new link code will load these IDs into bpf_tramp_id
object and resolve their ips.

The resolve itself is done as per Andrii's suggestion:

  - lookup all names for given IDs
  - store and sort them by name
  - go through all kallsyms symbols and use bsearch
    to find it in provided names
  - if name is found, store the address for the name
  - resort the names array based on ID

If there are multi symbols of the same name the first one
will be used to resolve the address.

The link is using bpf_trampoline_multi_attach interface
to attach this IDs to the program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h   |   5 +
 include/uapi/linux/bpf.h       |   5 +
 kernel/bpf/syscall.c           |   2 +
 kernel/trace/bpf_trace.c       | 240 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   5 +
 5 files changed, 257 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..7825f9b0d9c3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -747,6 +747,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -793,6 +794,10 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fb6bc2c5e9e8..b4b3a47d5324 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1017,6 +1017,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_PERF_EVENT = 7,
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
+	BPF_LINK_TYPE_TRACING_MULTI = 10,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1503,6 +1504,10 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__aligned_u64	btf_ids;	/* addresses to attach */
+				__u32		btf_ids_cnt;	/* addresses count */
+			} tracing_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2e4765c7e6d4..2b51787e8899 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4604,6 +4604,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (is_tracing_multi(prog->expected_attach_type))
+			ret = bpf_tracing_multi_attach(prog, attr);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..07a91a32e566 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2593,3 +2593,243 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return 0;
 }
 #endif
+
+struct bpf_tracing_multi_link {
+	struct bpf_link link;
+	enum bpf_attach_type attach_type;
+	struct bpf_tramp_prog tp;
+	struct bpf_tramp_id *id;
+};
+
+static void bpf_tracing_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
+}
+
+static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	bpf_tramp_id_put(tr_link->id);
+	kfree(tr_link);
+}
+
+static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
+					       struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
+}
+
+static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
+						 struct bpf_link_info *info)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	info->tracing.attach_type = tr_link->attach_type;
+	return 0;
+}
+
+static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
+	.release = bpf_tracing_multi_link_release,
+	.dealloc = bpf_tracing_multi_link_dealloc,
+	.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
+	.fill_link_info = bpf_tracing_multi_link_fill_link_info,
+};
+
+static int check_multi_prog_type(struct bpf_prog *prog)
+{
+	if (prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
+	    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI)
+		return -EINVAL;
+	return 0;
+}
+
+static int btf_ids_cmp(const void *a, const void *b)
+{
+	const u32 *x = a;
+	const u32 *y = b;
+
+	if (*x == *y)
+		return 0;
+	return *x < *y ? -1 : 1;
+}
+
+struct resolve_id {
+	const char *name;
+	void *addr;
+	u32 id;
+};
+
+static int rid_name_cmp(const void *a, const void *b)
+{
+	const struct resolve_id *x = a;
+	const struct resolve_id *y = b;
+
+	return strcmp(x->name, y->name);
+}
+
+static int rid_id_cmp(const void *a, const void *b)
+{
+	const struct resolve_id *x = a;
+	const struct resolve_id *y = b;
+
+	if (x->id == y->id)
+		return 0;
+	return x->id < y->id ? -1 : 1;
+}
+
+struct kallsyms_data {
+	struct resolve_id *rid;
+	u32 cnt;
+	u32 found;
+};
+
+static int kallsyms_callback(void *data, const char *name,
+			     struct module *mod, unsigned long addr)
+{
+	struct kallsyms_data *args = data;
+	struct resolve_id *rid, id = {
+		.name = name,
+	};
+
+	rid = bsearch(&id, args->rid, args->cnt, sizeof(*rid), rid_name_cmp);
+	if (rid && !rid->addr) {
+		rid->addr = (void *) addr;
+		args->found++;
+	}
+	return args->found == args->cnt ? 1 : 0;
+}
+
+static int bpf_tramp_id_resolve(struct bpf_tramp_id *id, struct bpf_prog *prog)
+{
+	struct kallsyms_data args;
+	const struct btf_type *t;
+	struct resolve_id *rid;
+	const char *name;
+	struct btf *btf;
+	int err = 0;
+	u32 i;
+
+	btf = prog->aux->attach_btf;
+	if (!btf)
+		return -EINVAL;
+
+	rid = kcalloc(id->cnt, sizeof(*rid), GFP_KERNEL);
+	if (!rid)
+		return -ENOMEM;
+
+	err = -EINVAL;
+	for (i = 0; i < id->cnt; i++) {
+		t = btf_type_by_id(btf, id->id[i]);
+		if (!t)
+			goto out_free;
+
+		name = btf_name_by_offset(btf, t->name_off);
+		if (!name)
+			goto out_free;
+
+		rid[i].name = name;
+		rid[i].id = id->id[i];
+	}
+
+	sort(rid, id->cnt, sizeof(*rid), rid_name_cmp, NULL);
+
+	args.rid = rid;
+	args.cnt = id->cnt;
+	args.found = 0;
+	kallsyms_on_each_symbol(kallsyms_callback, &args);
+
+	sort(rid, id->cnt, sizeof(*rid), rid_id_cmp, NULL);
+
+	for (i = 0; i < id->cnt; i++) {
+		if (!rid[i].addr) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		/* all the addresses must be ftrace managed */
+		if (!ftrace_location((unsigned long) rid[i].addr)) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		id->addr[i] = rid[i].addr;
+	}
+	err = 0;
+out_free:
+	kfree(rid);
+	return err;
+}
+
+int bpf_tracing_multi_attach(struct bpf_prog *prog,
+			     const union bpf_attr *attr)
+{
+	void __user *uids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
+	u32 cnt_size, cnt = attr->link_create.tracing_multi.btf_ids_cnt;
+	struct bpf_tracing_multi_link *link = NULL;
+	struct bpf_link_primer link_primer;
+	struct bpf_tramp_id *id = NULL;
+	int err = -EINVAL;
+
+	if (check_multi_prog_type(prog))
+		return -EINVAL;
+	if (!cnt || !uids)
+		return -EINVAL;
+
+	id = bpf_tramp_id_alloc(cnt);
+	if (!id)
+		return -ENOMEM;
+
+	err = -EFAULT;
+	cnt_size = cnt * sizeof(id->id[0]);
+	if (copy_from_user(id->id, uids, cnt_size))
+		goto out_free_id;
+
+	id->cnt = cnt;
+	id->obj_id = btf_obj_id(prog->aux->attach_btf);
+
+	/* Sort user provided BTF ids, so we can use memcmp
+	 * and bsearch on top of it later.
+	 */
+	sort(id->id, cnt, sizeof(u32), btf_ids_cmp, NULL);
+
+	err = bpf_tramp_id_resolve(id, prog);
+	if (err)
+		goto out_free_id;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		err = -ENOMEM;
+		goto out_free_id;
+	}
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
+		      &bpf_tracing_multi_link_lops, prog);
+	link->attach_type = prog->expected_attach_type;
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err) {
+		kfree(link);
+		goto out_free_id;
+	}
+
+	link->id = id;
+	link->tp.cookie = 0;
+	link->tp.prog = prog;
+
+	err = bpf_trampoline_multi_attach(&link->tp, id);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		return err;
+	}
+	return bpf_link_settle(&link_primer);
+out_free_id:
+	bpf_tramp_id_put(id);
+	return err;
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 94d623affd5f..4969f31471d5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1017,6 +1017,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_PERF_EVENT = 7,
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
+	BPF_LINK_TYPE_TRACING_MULTI = 10,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1503,6 +1504,10 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__aligned_u64	btf_ids;	/* addresses to attach */
+				__u32		btf_ids_cnt;	/* addresses count */
+			} tracing_multi;
 		};
 	} link_create;
 
-- 
2.37.1

