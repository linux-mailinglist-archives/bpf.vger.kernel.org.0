Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED6A4C5233
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiBYXol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiBYXok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E41BE105
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:44:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so4949692ybh.9
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=90LDKc8yXNYaFV1vYO/ZK9vfbd4VKTswsQEBzwuWgFM=;
        b=Rbjw56WAak5LEeKjlXfG5yGu0ZXkBZ9FppDt939bYveYrEXS89bN8MwjuaxDB39XVw
         VBx+xoB3vRyPlYZOYUYRMHb3S/kdssvR1uowucrPn0+RwEY601NRejBh2FuCL5afaZ96
         VsO8ItDGhDqRQ30kzTIcBGkAn7VfeUyD1eZ/As/nIX9eFrzQZw+aMjAlZv2unO/PaRMC
         x6KQYYq7T+89ARPmSXe9CpmG2DWHTWw+EYSmrRgg0mGZ1QXazzHuYl9T60h0PRd68Og5
         Y9r70hMvQPIKEnepGpbtbuXDg5REDdiGIPRUyYAAFmNnaHePZZFGODvWJzxH5rv/hxH7
         S2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=90LDKc8yXNYaFV1vYO/ZK9vfbd4VKTswsQEBzwuWgFM=;
        b=lu05ra/annM/FN8jHOBcJzIxifDxfIK5b0B1TPKgOciGyx5ctTGraK5MMSSj+KAg0T
         uA8vSjWBDwUBpyAGUGXBG3o85o5l0411OWLKJEE5E6yZ2piWn8MEiL+aZI6tZNCtq35c
         uVPzQJ+yOaWvMxO0VyVvR9Awd5KOw7RmBOUl598QMabRlvpBgiEcJPAxRV0cLhuxocKM
         Qd7bj9CjtLtjymTjIYxTynzdErAy85JAVHbw73KadOZpJWnOMQ7F/UJRQHQcMsqDqXIN
         pTT8HLKcyoQviWpmw52svcKcBBOQ8n3ciC3q3a8HV/Y8zpW4Lfj8KuQNIlFZ1mg46WLG
         Z5MQ==
X-Gm-Message-State: AOAM5321o1duFlWPvenBV3GVWd+uL06fGjchC2F0fjZjklqitBkpm95m
        d3t2zNiGM0tyV4M4XkPrRSrSm2zDwxk=
X-Google-Smtp-Source: ABdhPJySPfMxm0kIwLpGy7EfSr2+guFookXm4g7V1JmjaV2muGrmB1OVtxGnJes9Dloe8HEWWvkqymG87Qo=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:a223:0:b0:621:1238:68b1 with SMTP id
 b32-20020a25a223000000b00621123868b1mr9769008ybi.370.1645832643208; Fri, 25
 Feb 2022 15:44:03 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:38 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-9-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
iter doesn't iterate a set of kernel objects. Instead, it is supposed to
be parameterized by a cgroup id and prints only that cgroup. So one
needs to specify a target cgroup id when attaching this iter.

The target cgroup's state can be read out via a link of this iter.
Typically, we can monitor cgroup creation and deletion using sleepable
tracing and use it to create corresponding directories in bpffs and pin
a cgroup id parameterized link in the directory. Then we can read the
auto-pinned iter link to get cgroup's state. The output of the iter link
is determined by the program. See the selftest test_cgroup_stats.c for
an example.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h            |   1 +
 include/uapi/linux/bpf.h       |   6 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   6 ++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/cgroup_iter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 759ade7b24b3..3ce9b0b7ed89 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1595,6 +1595,7 @@ int bpf_obj_get_path(bpfptr_t pathname, int flags);
 
 struct bpf_iter_aux_info {
 	struct bpf_map *map;
+	u64 cgroup_id;
 };
 
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a5dbc794403d..855ad80d9983 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -91,6 +91,9 @@ union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	struct {
+		__u64	cgroup_id;
+	} cgroup;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
@@ -5887,6 +5890,9 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u64 cgroup_id;
+				} cgroup;
 			};
 		} iter;
 		struct  {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1a9be6a4b9f..52a0e4c6e96e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
new file mode 100644
index 000000000000..011d9dcd1d51
--- /dev/null
+++ b/kernel/bpf/cgroup_iter.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Google */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/cgroup.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+
+struct bpf_iter__cgroup {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct cgroup *, cgroup);
+};
+
+static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct cgroup *cgroup;
+	u64 cgroup_id;
+
+	/* Only one session is supported. */
+	if (*pos > 0)
+		return NULL;
+
+	cgroup_id = *(u64 *)seq->private;
+	cgroup = cgroup_get_from_id(cgroup_id);
+	if (!cgroup)
+		return NULL;
+
+	if (*pos == 0)
+		++*pos;
+
+	return cgroup;
+}
+
+static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static int cgroup_iter_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__cgroup ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.meta = &meta;
+	ctx.cgroup = v;
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (prog)
+		ret = bpf_iter_run_prog(prog, &ctx);
+
+	return ret;
+}
+
+static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v)
+		cgroup_put(v);
+}
+
+static const struct seq_operations cgroup_iter_seq_ops = {
+	.start  = cgroup_iter_seq_start,
+	.next   = cgroup_iter_seq_next,
+	.stop   = cgroup_iter_seq_stop,
+	.show   = cgroup_iter_seq_show,
+};
+
+BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
+
+static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	*(u64 *)priv_data = aux->cgroup_id;
+	return 0;
+}
+
+static void cgroup_iter_seq_fini(void *priv_data)
+{
+}
+
+static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
+	.seq_ops                = &cgroup_iter_seq_ops,
+	.init_seq_private       = cgroup_iter_seq_init,
+	.fini_seq_private       = cgroup_iter_seq_fini,
+	.seq_priv_size          = sizeof(u64),
+};
+
+static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
+				  union bpf_iter_link_info *linfo,
+				  struct bpf_iter_aux_info *aux)
+{
+	aux->cgroup_id = linfo->cgroup.cgroup_id;
+	return 0;
+}
+
+static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
+{
+}
+
+void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
+				 struct seq_file *seq)
+{
+	char buf[64] = {0};
+
+	cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
+	seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
+	seq_printf(seq, "cgroup_path:\t%s\n", buf);
+}
+
+int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
+				   struct bpf_link_info *info)
+{
+	info->iter.cgroup.cgroup_id = aux->cgroup_id;
+	return 0;
+}
+
+DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
+		     struct cgroup *cgroup)
+
+static struct bpf_iter_reg bpf_cgroup_reg_info = {
+	.target			= "cgroup",
+	.attach_target		= bpf_iter_attach_cgroup,
+	.detach_target		= bpf_iter_detach_cgroup,
+	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
+	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__cgroup, cgroup),
+		  PTR_TO_BTF_ID },
+	},
+	.seq_info		= &cgroup_iter_seq_info,
+};
+
+static int __init bpf_cgroup_iter_init(void)
+{
+	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
+	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
+}
+
+late_initcall(bpf_cgroup_iter_init);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a5dbc794403d..855ad80d9983 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -91,6 +91,9 @@ union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	struct {
+		__u64	cgroup_id;
+	} cgroup;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
@@ -5887,6 +5890,9 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u64 cgroup_id;
+				} cgroup;
 			};
 		} iter;
 		struct  {
-- 
2.35.1.574.g5d30c73bfb-goog

