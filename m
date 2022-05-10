Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85280522078
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiEJQD2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346991AbiEJQBB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:01:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3723192B7
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so33921428ejb.0
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iG6T0pgOLPq+Fg8FTHbC3MmPLtcX5GeD7tuU7htv1io=;
        b=ZE0I3RGpCbVaU9Evjqilx6ZXU4ATasTjOOcX403fVpiQE4uGwI54drHxSpdjQz5Ten
         sK3lEId9F+hGqCyP/S6yy/7z4seOHQcWrZ7ljkqPuY8XXwMmuQoMi+kMEhcpc9JF6crr
         4Cdk80iVkE0Io12GWzLg08JK9AydVzgW+BNALrmXeKKHj8Ki1s1GVC1HShgo1Hil0890
         PxQ09lYmjKhSByNo8BZQl4Phzpjs21XFdSvEMoT9BYQnnLKAyWzlWH3B4bmezUXRUmQ2
         Uek86kRHjm3Bd1tebi5cAfZma3yzBcK2DLPGgTYOcKa1k1R1bAA11JTKi9cPGnONlsSS
         xXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iG6T0pgOLPq+Fg8FTHbC3MmPLtcX5GeD7tuU7htv1io=;
        b=RQ8WP19Px46JpKwSv7+6vnPSxu+k+BVttse5ANpUydxwgfqzU+33cmRrnTXKyTrZ/N
         m2weVHW92DS7IiXCPwdosKy0DZpfStDIkFd/emSbwayLdQv7LE2fIt5OzzQmYBZERJ86
         Zwz/Z/37o7a+R6SqfUO7aiPw+/ir7N+9gfWpJIoPzxDQq2xKGQD3Nqd8XpvsfvakoPeZ
         mHes4fLmyZiMMCW3J6iz+j4gEjNlhSStnsTnPFU48Wjzzbj1AN6CUwSpReo5mxQOBkSp
         bY726ERq/pKOtRyEAxRB5GoBSpo2FdcMQVoZpz2kqne8n5T8dBYKYXKAfGcrQiFojQSO
         DWlQ==
X-Gm-Message-State: AOAM5324WVwt57riwHV6xe0MdPLznqz0AHIkrPCh+qsZN75PVS+zRQt4
        QfynRS4HDPBriPycwsj7bKq0CDq/8E0Hpg==
X-Google-Smtp-Source: ABdhPJyDh/fmD/C/gF4iDDxoGpvYj3kO3fjxHHX2cY4nvmIvwDIS4vGuCX1ruYXXf6Dg0w/n3joTzg==
X-Received: by 2002:a17:906:ed1:b0:6f4:ebc2:da8a with SMTP id u17-20020a1709060ed100b006f4ebc2da8amr19761469eji.126.1652198017273;
        Tue, 10 May 2022 08:53:37 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-011-044.094.222.pools.vodafone-ip.de. [94.222.11.44])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b0042617ba63b0sm7806088eds.58.2022.05.10.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:53:36 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: Add bpf_link iterator
Date:   Tue, 10 May 2022 17:52:30 +0200
Message-Id: <20220510155233.9815-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510155233.9815-1-9erthalion6@gmail.com>
References: <20220510155233.9815-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_link iterator to traverse links via bpf_seq_file
operations. The changeset is mostly shamelessly copied from
commit a228a64fc1e4 ("bpf: Add bpf_prog iterator")

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
Changes in v2:
    - Correct copyright

 include/linux/bpf.h    |   1 +
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/link_iter.c | 107 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c   |  19 ++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/link_iter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be94833d390a..551b7198ae8a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1544,6 +1544,7 @@ void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
+struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
 
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
 int bpf_obj_get_user(const char __user *pathname, int flags);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1a9be6a4b9f..057ba8e01e70 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
new file mode 100644
index 000000000000..fec8005a121c
--- /dev/null
+++ b/kernel/bpf/link_iter.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Red Hat, Inc. */
+#include <linux/bpf.h>
+#include <linux/fs.h>
+#include <linux/filter.h>
+#include <linux/kernel.h>
+#include <linux/btf_ids.h>
+
+struct bpf_iter_seq_link_info {
+	u32 link_id;
+};
+
+static void *bpf_link_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_iter_seq_link_info *info = seq->private;
+	struct bpf_link *link;
+
+	link = bpf_link_get_curr_or_next(&info->link_id);
+	if (!link)
+		return NULL;
+
+	if (*pos == 0)
+		++*pos;
+	return link;
+}
+
+static void *bpf_link_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_iter_seq_link_info *info = seq->private;
+
+	++*pos;
+	++info->link_id;
+	bpf_link_put((struct bpf_link *)v);
+	return bpf_link_get_curr_or_next(&info->link_id);
+}
+
+struct bpf_iter__bpf_link {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct bpf_link *, link);
+};
+
+DEFINE_BPF_ITER_FUNC(bpf_link, struct bpf_iter_meta *meta, struct bpf_link *link)
+
+static int __bpf_link_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter__bpf_link ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.meta = &meta;
+	ctx.link = v;
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, in_stop);
+	if (prog)
+		ret = bpf_iter_run_prog(prog, &ctx);
+
+	return ret;
+}
+
+static int bpf_link_seq_show(struct seq_file *seq, void *v)
+{
+	return __bpf_link_seq_show(seq, v, false);
+}
+
+static void bpf_link_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)__bpf_link_seq_show(seq, v, true);
+	else
+		bpf_link_put((struct bpf_link *)v);
+}
+
+static const struct seq_operations bpf_link_seq_ops = {
+	.start	= bpf_link_seq_start,
+	.next	= bpf_link_seq_next,
+	.stop	= bpf_link_seq_stop,
+	.show	= bpf_link_seq_show,
+};
+
+BTF_ID_LIST(btf_bpf_link_id)
+BTF_ID(struct, bpf_link)
+
+static const struct bpf_iter_seq_info bpf_link_seq_info = {
+	.seq_ops		= &bpf_link_seq_ops,
+	.init_seq_private	= NULL,
+	.fini_seq_private	= NULL,
+	.seq_priv_size		= sizeof(struct bpf_iter_seq_link_info),
+};
+
+static struct bpf_iter_reg bpf_link_reg_info = {
+	.target			= "bpf_link",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__bpf_link, link),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &bpf_link_seq_info,
+};
+
+static int __init bpf_link_iter_init(void)
+{
+	bpf_link_reg_info.ctx_arg_info[0].btf_id = *btf_bpf_link_id;
+	return bpf_iter_reg_target(&bpf_link_reg_info);
+}
+
+late_initcall(bpf_link_iter_init);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e0aead17dff4..50164d324eaf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4680,6 +4680,25 @@ struct bpf_link *bpf_link_by_id(u32 id)
 	return link;
 }
 
+struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
+{
+	struct bpf_link *link;
+
+	spin_lock_bh(&link_idr_lock);
+again:
+	link = idr_get_next(&link_idr, id);
+	if (link) {
+		link = bpf_link_inc_not_zero(link);
+		if (IS_ERR(link)) {
+			(*id)++;
+			goto again;
+		}
+	}
+	spin_unlock_bh(&link_idr_lock);
+
+	return link;
+}
+
 #define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_id
 
 static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
-- 
2.32.0

