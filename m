Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF550BFBA
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiDVS1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiDVS1A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 14:27:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51953146D60
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:24:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so4519926edo.2
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocwAt6DfqYi7QCVnU54fBMH+5NfbHDxqyh7sWYE028Q=;
        b=i5/IrrUEmsualQBctazuOCSjHQnPXvflEOD2AaCfFszZPdDuAVExxZnnXyH2wxnyiS
         gHX0+Of11j3X1FUuT8GWOgZP1+h2snimut5EuzNWt6nyZREVcxcVZI5LGIW/6qzJjQlF
         tC6nMOYZl+H13ozyYgE56CjzxfttyAunhh4G3dCo4Kg3uTJ0ANhjXlqxP0Ucr2+JQXEU
         IpujUFBOCLRGni12dgZggmB0U/mh8Lw94uHtO4SsnME+kdcD1JmGek1RXicS3Apl6yxx
         uVVSlYRCi8CBtH90p4wAOTWEV4M4yxQ0tDZ3Tq0HSW54ijn2WsfdjFyY7byr/0LUEjw+
         vOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocwAt6DfqYi7QCVnU54fBMH+5NfbHDxqyh7sWYE028Q=;
        b=cXaalXamZ+mD7TuhQA4YNlBiMPNxSgVXeuFwkGdNrFlMEMYKaPggPLNON3W4YiqlLi
         Z6tLSnwRI5bPd5gO0zHWlKgWoOwTeHMkcgYdNxVkaRrI8amZOtPnPpUzI1unWeLqGfJm
         ioHnE6B6GaTPoYzWW49dL+c5tvayqrWp2gntJYGIGC+nZ2F5Kp9MtyG8gxH0OtMxdoIc
         6NF8Z3wcFIwkrbxJN5vfpma1HZ+dOV2fwerKvsHHAbDV9kM9nQkVGxLG8/f5w6D2+spA
         PBzjsXkIeFYoTrzkqGX6R74iF08Jen2NFUjL8COa8L0B+oH8K0qOuQ2ACBiNzGcZuhs2
         dgUQ==
X-Gm-Message-State: AOAM5307eioxneDQyJhWQglFMdFWwCjX7XofGcOpSGwB2I2TbMjxZjTv
        ulzG8s38Q+zh1Mn/LHZdUyy+PTlT/Th3Dw==
X-Google-Smtp-Source: ABdhPJwZWNrrBFHjxl7F5Tz9mzd5HBlWI4b84Bo7aYux7YLKz+jF+QfKGctTgJSJgXzLiklH0GZ48A==
X-Received: by 2002:aa7:d3c2:0:b0:425:c9f6:2ef2 with SMTP id o2-20020aa7d3c2000000b00425c9f62ef2mr597364edr.299.1650651823642;
        Fri, 22 Apr 2022 11:23:43 -0700 (PDT)
Received: from erthalion.local (dslb-178-005-225-126.178.005.pools.vodafone-ip.de. [178.5.225.126])
        by smtp.gmail.com with ESMTPSA id d11-20020a056402400b00b00423e5bdd6e3sm1152312eda.84.2022.04.22.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:23:43 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] bpf: Add bpf_link iterator
Date:   Fri, 22 Apr 2022 20:22:53 +0200
Message-Id: <20220422182254.13693-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422182254.13693-1-9erthalion6@gmail.com>
References: <20220422182254.13693-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_link iterator to traverse links via bpf_seq_file
operations. The changeset is mostly shamelessly copied from
commit a228a64fc1e4 ("bpf: Add bpf_prog iterator")

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 include/linux/bpf.h    |   1 +
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/link_iter.c | 107 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c   |  19 ++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/link_iter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7bf441563ffc..330e88fcc50e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1489,6 +1489,7 @@ void bpf_link_put(struct bpf_link *link);
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
index 000000000000..fde41d09f26b
--- /dev/null
+++ b/kernel/bpf/link_iter.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2020 Facebook */
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
index e9621cfa09f2..7d2d4cedea3f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4454,6 +4454,25 @@ struct bpf_link *bpf_link_by_id(u32 id)
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

