Return-Path: <bpf+bounces-5067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDE754E91
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EA628149E
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95379C7;
	Sun, 16 Jul 2023 12:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0979C1
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 12:11:01 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26337E7F
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666edfc50deso2105133b3a.0
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689509459; x=1692101459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv+MhhCOHnLZYDdr/NgybYn9d0iGqsoXTJSes2gd/lE=;
        b=e57NFnW7jT5YDwFSGAlcFwvw6cIxytTwV35BjhdsGSSZ0TKyZoJcKDTaLRG9YSnGQy
         x3CKJa+jjTsmy9mz0AxvFGpaxMHViDtQZ2A3o7yHcynj/o/cMj0b4R1ZwXnfs1CFgA8s
         xrVeJVDVgVFNDgwEnpmgTOceCtgjDehafNB00GNJj/ldXWeFyc7ekUUsHvKzBhpf89Cs
         aOOywAvl8WCW1WUJXunHMf7kTW0gB7IgENWBjv4ZEWbtelvoaTnacyKlFZIZMErzEX9m
         oUjrDukWO3rVi+K00na3tBTfiWSEm9D/Fn/ot1Lok3LygL44lt1u+9ap0YRVog39Xytj
         XyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689509459; x=1692101459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv+MhhCOHnLZYDdr/NgybYn9d0iGqsoXTJSes2gd/lE=;
        b=CbZkWa38f6Kl/8Z3hrJ4chvytSlTqfMZcWChyy31zGMzRMe9FAzFzlE6+MchdEEVpB
         1npN2MfPyPoZURJ+0eu+6mupgadEUl8mwyE11JMVvHRkc/R8ubqYsWk+UZUASPq02MbC
         qc26yBqapiR/Q4t8CyL7x8SDwhU1EVIn+lV0iUQGTgPaetxnzquTKSUP0/tppj+DD90p
         lT26+1HY2sEoMA7qcF+43LZ0YDUvNkR76x/ATPmhxtiaYqxmYlXVcxFVrM6mDr3MQICy
         YZaNT1VAiEVzvpvjvJteLiDjc36xiSKwfhIB+PS43zdSsOGxV1ONWlx87R549mk06HdP
         87Mw==
X-Gm-Message-State: ABy/qLZHr5BVgEerhvezMwXkKSMfT2ITdgMDKYWktH86MRhkAgODq2gZ
	pAwZvTNHiaASuVV9wZojMKQ=
X-Google-Smtp-Source: APBJJlGsZwTsSFOhNMYW7OwduSizTXokYNQQk0pNHkw43zMx6sKIi0LQ5gFHk38o6TjGJWdE5RBYbA==
X-Received: by 2002:a05:6a20:6a0d:b0:133:17f1:6436 with SMTP id p13-20020a056a206a0d00b0013317f16436mr8787175pzk.19.1689509459503;
        Sun, 16 Jul 2023 05:10:59 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:697:5400:4ff:fe82:495b])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0062cf75a9e6bsm10128730pfh.131.2023.07.16.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:10:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/4] bpf: Add cgroup_task iter
Date: Sun, 16 Jul 2023 12:10:44 +0000
Message-Id: <20230716121046.17110-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230716121046.17110-1-laoar.shao@gmail.com>
References: <20230716121046.17110-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch introduces cgroup_task iter, which allows for efficient
iteration of tasks within a specific cgroup. For example, we can effiently
get the nr_{running,blocked} of a container with this new feature.

The cgroup_task iteration serves as an alternative to task_iter in
container environments due to certain limitations associated with
task_iter.

- Firstly, task_iter only supports the 'current' pidns.
  However, since our data collector operates on the host, we may need to
  collect information from multiple containers simultaneously. Using
  task_iter would require us to fork the collector for each container,
  which is not ideal.

- Additionally, task_iter is unable to collect task information from
containers running in the host pidns.
  In our container environment, we have containers running in the host
  pidns, and we would like to collect task information from them as well.

- Lastly, task_iter does not support multiple-container pods.
  In a Kubernetes environment, a single pod may contain multiple
  containers, all sharing the same pidns. However, we are only interested
  in iterating tasks within the main container, which is not possible with
  task_iter.

To address the first issue, we could potentially extend task_iter to
support specifying a pidns other than the current one. However, for the
other two issues, extending task_iter would not provide a solution.
Therefore, we believe it is preferable to introduce the cgroup_task iter to
handle these scenarios effectively.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/btf_ids.h  |  14 ++++
 kernel/bpf/cgroup_iter.c | 151 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 00950cc03bff..559f78de8e25 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -265,6 +265,20 @@ MAX_BTF_TRACING_TYPE,
 };
 
 extern u32 btf_tracing_ids[];
+
+#ifdef CONFIG_CGROUPS
+#define BTF_CGROUP_TYPE_xxx    \
+	BTF_CGROUP_TYPE(BTF_CGROUP_TYPE_CGROUP, cgroup)		\
+	BTF_CGROUP_TYPE(BTF_CGROUP_TYPE_TASK, task_struct)
+
+enum {
+#define BTF_CGROUP_TYPE(name, type) name,
+BTF_CGROUP_TYPE_xxx
+#undef BTF_CGROUP_TYPE
+MAX_BTF_CGROUP_TYPE,
+};
+#endif
+
 extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
 
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 619c13c30e87..e5b82f05910b 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -157,7 +157,9 @@ static const struct seq_operations cgroup_iter_seq_ops = {
 	.show   = cgroup_iter_seq_show,
 };
 
-BTF_ID_LIST_GLOBAL_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
+BTF_ID_LIST_GLOBAL(bpf_cgroup_btf_id, MAX_BTF_CGROUP_TYPE)
+BTF_ID(struct, cgroup)
+BTF_ID(struct, task_struct)
 
 static int cgroup_iter_seq_init(void *priv, struct bpf_iter_aux_info *aux)
 {
@@ -295,10 +297,153 @@ static struct bpf_iter_reg bpf_cgroup_reg_info = {
 	.seq_info		= &cgroup_iter_seq_info,
 };
 
+struct bpf_iter__cgroup_task {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct cgroup *, cgroup);
+	__bpf_md_ptr(struct task_struct *, task);
+};
+
+struct cgroup_task_iter_priv {
+	struct cgroup_iter_priv common;
+	struct css_task_iter it;
+	struct task_struct *task;
+};
+
+DEFINE_BPF_ITER_FUNC(cgroup_task, struct bpf_iter_meta *meta,
+		     struct cgroup *cgroup, struct task_struct *task)
+
+static int bpf_iter_attach_cgroup_task(struct bpf_prog *prog,
+				       union bpf_iter_link_info *linfo,
+				       struct bpf_iter_aux_info *aux)
+{
+	int order = linfo->cgroup.order;
+
+	if (order != BPF_CGROUP_ITER_SELF_ONLY)
+		return -EINVAL;
+
+	aux->cgroup.order = order;
+	return __bpf_iter_attach_cgroup(prog, linfo, aux);
+}
+
+static void *cgroup_task_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct cgroup_task_iter_priv *p = seq->private;
+	struct cgroup_subsys_state *css = p->common.start_css;
+	struct css_task_iter *it = &p->it;
+	struct task_struct *task;
+
+	css_task_iter_start(css, 0, it);
+	if (*pos > 0) {
+		if (p->common.visited_all)
+			return NULL;
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	++*pos;
+	p->common.terminate = false;
+	p->common.visited_all = false;
+	task = css_task_iter_next(it);
+	p->task = task;
+	return task;
+}
+
+static void *cgroup_task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct cgroup_task_iter_priv *p = seq->private;
+	struct css_task_iter *it = &p->it;
+	struct task_struct *task;
+
+	++*pos;
+	if (p->common.terminate)
+		return NULL;
+
+	task = css_task_iter_next(it);
+	p->task = task;
+	return task;
+}
+
+static int __cgroup_task_seq_show(struct seq_file *seq, struct cgroup_subsys_state *css,
+				bool in_stop)
+{
+	struct cgroup_task_iter_priv *p = seq->private;
+
+	struct bpf_iter__cgroup_task ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.meta = &meta;
+	ctx.cgroup = css ? css->cgroup : NULL;
+	ctx.task = p->task;
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, in_stop);
+	if (prog)
+		ret = bpf_iter_run_prog(prog, &ctx);
+	if (ret)
+		p->common.terminate = true;
+	return 0;
+}
+
+static int cgroup_task_seq_show(struct seq_file *seq, void *v)
+{
+	return __cgroup_task_seq_show(seq, (struct cgroup_subsys_state *)v, false);
+}
+
+static void cgroup_task_seq_stop(struct seq_file *seq, void *v)
+{
+	struct cgroup_task_iter_priv *p = seq->private;
+	struct css_task_iter *it = &p->it;
+
+	css_task_iter_end(it);
+	if (!v) {
+		__cgroup_task_seq_show(seq, NULL, true);
+		p->common.visited_all = true;
+	}
+}
+
+static const struct seq_operations cgroup_task_seq_ops = {
+	.start	= cgroup_task_seq_start,
+	.next	= cgroup_task_seq_next,
+	.stop	= cgroup_task_seq_stop,
+	.show	= cgroup_task_seq_show,
+};
+
+static const struct bpf_iter_seq_info cgroup_task_seq_info = {
+	.seq_ops		= &cgroup_task_seq_ops,
+	.init_seq_private	= cgroup_iter_seq_init,
+	.fini_seq_private	= cgroup_iter_seq_fini,
+	.seq_priv_size		= sizeof(struct cgroup_task_iter_priv),
+};
+
+static struct bpf_iter_reg bpf_cgroup_task_reg_info = {
+	.target			= "cgroup_task",
+	.feature		= BPF_ITER_RESCHED,
+	.attach_target		= bpf_iter_attach_cgroup_task,
+	.detach_target		= bpf_iter_detach_cgroup,
+	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
+	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
+	.ctx_arg_info_size	= 2,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__cgroup_task, cgroup),
+		  PTR_TO_BTF_ID_OR_NULL },
+		{ offsetof(struct bpf_iter__cgroup_task, task),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &cgroup_task_seq_info,
+};
+
 static int __init bpf_cgroup_iter_init(void)
 {
-	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
-	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
+	int ret;
+
+	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[BTF_CGROUP_TYPE_CGROUP];
+	ret = bpf_iter_reg_target(&bpf_cgroup_reg_info);
+	if (ret)
+		return ret;
+
+	bpf_cgroup_task_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[BTF_CGROUP_TYPE_CGROUP];
+	bpf_cgroup_task_reg_info.ctx_arg_info[1].btf_id = bpf_cgroup_btf_id[BTF_CGROUP_TYPE_TASK];
+	return bpf_iter_reg_target(&bpf_cgroup_task_reg_info);
 }
 
 late_initcall(bpf_cgroup_iter_init);
-- 
2.39.3


