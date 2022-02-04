Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E534AA429
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiBDXRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378008AbiBDXRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81251C06664A
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:17:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v4so1124488pjh.2
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhO24zbRwspkmY3e6DNmHdAVkmwrh2weKhKJ9ZwWK/M=;
        b=lwMuXhaWuzFPR+wTP2KVdxr1MxraV+efHd7/Q7Xv5YhCZvkAlmrk/ggJCKyqQjjb9n
         WFA8vOhWZJ2QvR/fIrPAN3aD7e2hMLLCeBKKFL2vc7AMeriQqIZhHT7faFjt30NV4+fa
         /lbrXaX8VJ+qYCCVwJrAmTkWVhHSEYg/R65hi7CCDE7lfjtodiygU8i62BemX+639+aY
         yRI59jHt5GpBdtmkkh3JUf2+p5SJI0GZHWvS8Moo56XNVRI3MY6O9ofZ2PW57WK4kq9r
         7ZrT14D3qwTeQNB1Tf/3UGimx43ExnddfXAEV0HW/+D7YXJe2btasCtH+WAFleqHbGWo
         c8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhO24zbRwspkmY3e6DNmHdAVkmwrh2weKhKJ9ZwWK/M=;
        b=bcFRGF1qi4xG6rGSyYQ2AfhCOZWVjueaWoUqZ7W0Dgdg3p9LCcVwVibWr2EGCv+Cma
         3eY2BdvTfOZarT6oAp9XWJEZ71yQ9ZDAbXi+T83w+1FVMhqtI0ZkPZwfRONv6e0woFkz
         rpFReLdTT0qzFwXhpB7er/gOgHi/dKytaBvwTzyE1oscQBOU+9x5WdMM0oosRNmPR8NI
         ZDMIX4Y1XqmWGzZj8Ao7ceW2hTT8WQ9sKfeAzJPQLikwDyE+u60HBWsoB7gxGrgOrloR
         biAx5Rry3r0F8dSyusvJ2mrkUOG7nKj0IjrzW8J+8SYk//O1Jy91J7ciizEIpNUYJVYy
         3uww==
X-Gm-Message-State: AOAM5323SZZaSUlMpeSThpg4Bm74TdO5USXg/t6TItciYF4XzG7sV8ch
        TXea6Xucl9QrhJdHQ0xwYmbExCnk37U=
X-Google-Smtp-Source: ABdhPJxDcR/vnEmwXL5UbKKldUnJGtYguSsFcMQf2D9xllc0tStKAkTbva2WNQlIvlBhVp9V3WArzg==
X-Received: by 2002:a17:902:d48e:: with SMTP id c14mr5429156plg.79.1644016647874;
        Fri, 04 Feb 2022 15:17:27 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:e4ee])
        by smtp.gmail.com with ESMTPSA id q11sm4079798pfk.149.2022.02.04.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:27 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 5/5] bpf: Convert bpf_preload.ko to use light skeleton.
Date:   Fri,  4 Feb 2022 15:17:10 -0800
Message-Id: <20220204231710.25139-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The main change is a move of the single line
  #include "iterators.lskel.h"
from iterators/iterators.c to bpf_preload_kern.c.
Which means that generated light skeleton can be used from user space or
user mode driver like iterators.c or from the kernel module.
The direct use of light skeleton from the kernel module simplifies the code,
since UMD is no longer necessary. The libbpf.a required user space and UMD. The
CO-RE in the kernel and generated "loader bpf program" used by the light
skeleton are capable to perform complex loading operations traditionally
provided by libbpf. In addition UMD approach was launching UMD process
every time bpffs has to be mounted. With light skeleton in the kernel
the bpf_preload kernel module loads bpf iterators once and pins them
multiple times into different bpffs mounts.

Note the light skeleton cannot be used during early boot or out of kthread
since light skeleton needs a valid mm. This limitation could be lifted in the
future.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/inode.c                            |  39 ++----
 kernel/bpf/preload/Kconfig                    |   9 +-
 kernel/bpf/preload/Makefile                   |  14 +--
 kernel/bpf/preload/bpf_preload.h              |   8 +-
 kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
 kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
 .../preload/iterators/bpf_preload_common.h    |  13 --
 kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
 kernel/bpf/syscall.c                          |   2 +
 9 files changed, 72 insertions(+), 247 deletions(-)
 delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
 delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.c

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5a8d9f7467bf..4f841e16779e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -710,11 +710,10 @@ static DEFINE_MUTEX(bpf_preload_lock);
 static int populate_bpffs(struct dentry *parent)
 {
 	struct bpf_preload_info objs[BPF_PRELOAD_LINKS] = {};
-	struct bpf_link *links[BPF_PRELOAD_LINKS] = {};
 	int err = 0, i;
 
 	/* grab the mutex to make sure the kernel interactions with bpf_preload
-	 * UMD are serialized
+	 * are serialized
 	 */
 	mutex_lock(&bpf_preload_lock);
 
@@ -722,40 +721,22 @@ static int populate_bpffs(struct dentry *parent)
 	if (!bpf_preload_mod_get())
 		goto out;
 
-	if (!bpf_preload_ops->info.tgid) {
-		/* preload() will start UMD that will load BPF iterator programs */
-		err = bpf_preload_ops->preload(objs);
-		if (err)
+	err = bpf_preload_ops->preload(objs);
+	if (err)
+		goto out_put;
+	for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
+		bpf_link_inc(objs[i].link);
+		err = bpf_iter_link_pin_kernel(parent,
+					       objs[i].link_name, objs[i].link);
+		if (err) {
+			bpf_link_put(objs[i].link);
 			goto out_put;
-		for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
-			links[i] = bpf_link_by_id(objs[i].link_id);
-			if (IS_ERR(links[i])) {
-				err = PTR_ERR(links[i]);
-				goto out_put;
-			}
 		}
-		for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
-			err = bpf_iter_link_pin_kernel(parent,
-						       objs[i].link_name, links[i]);
-			if (err)
-				goto out_put;
-			/* do not unlink successfully pinned links even
-			 * if later link fails to pin
-			 */
-			links[i] = NULL;
-		}
-		/* finish() will tell UMD process to exit */
-		err = bpf_preload_ops->finish();
-		if (err)
-			goto out_put;
 	}
 out_put:
 	bpf_preload_mod_put();
 out:
 	mutex_unlock(&bpf_preload_lock);
-	for (i = 0; i < BPF_PRELOAD_LINKS && err; i++)
-		if (!IS_ERR_OR_NULL(links[i]))
-			bpf_link_put(links[i]);
 	return err;
 }
 
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index 26bced262473..9de6cfa5dbb1 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -18,10 +18,11 @@ menuconfig BPF_PRELOAD
 
 if BPF_PRELOAD
 config BPF_PRELOAD_UMD
-	tristate "bpf_preload kernel module with user mode driver"
-	depends on CC_CAN_LINK
-	depends on m || CC_CAN_LINK_STATIC
+	tristate "bpf_preload kernel module"
+	# light skeleton cannot run out of kthread without mm
+	depends on m
 	default m
 	help
-	  This builds bpf_preload kernel module with embedded user mode driver.
+	  This builds bpf_preload kernel module with embedded BPF programs for
+	  introspection in bpffs.
 endif
diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index baf47d9c7557..167534e3b0b4 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -3,16 +3,6 @@
 LIBBPF_SRCS = $(srctree)/tools/lib/bpf/
 LIBBPF_INCLUDE = $(LIBBPF_SRCS)/..
 
-userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
-	-I $(LIBBPF_INCLUDE) -Wno-unused-result
-
-userprogs := bpf_preload_umd
-
-bpf_preload_umd-objs := iterators/iterators.o
-
-$(obj)/bpf_preload_umd:
-
-$(obj)/bpf_preload_umd_blob.o: $(obj)/bpf_preload_umd
-
 obj-$(CONFIG_BPF_PRELOAD_UMD) += bpf_preload.o
-bpf_preload-objs += bpf_preload_kern.o bpf_preload_umd_blob.o
+CFLAGS_bpf_preload_kern.o += -I $(LIBBPF_INCLUDE)
+bpf_preload-objs += bpf_preload_kern.o
diff --git a/kernel/bpf/preload/bpf_preload.h b/kernel/bpf/preload/bpf_preload.h
index 2f9932276f2e..f065c91213a0 100644
--- a/kernel/bpf/preload/bpf_preload.h
+++ b/kernel/bpf/preload/bpf_preload.h
@@ -2,13 +2,13 @@
 #ifndef _BPF_PRELOAD_H
 #define _BPF_PRELOAD_H
 
-#include <linux/usermode_driver.h>
-#include "iterators/bpf_preload_common.h"
+struct bpf_preload_info {
+	char link_name[16];
+	struct bpf_link *link;
+};
 
 struct bpf_preload_ops {
-        struct umd_info info;
 	int (*preload)(struct bpf_preload_info *);
-	int (*finish)(void);
 	struct module *owner;
 };
 extern struct bpf_preload_ops *bpf_preload_ops;
diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 53736e52c1df..30207c048d36 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -2,101 +2,80 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/pid.h>
-#include <linux/fs.h>
-#include <linux/sched/signal.h>
 #include "bpf_preload.h"
+#include "iterators/iterators.lskel.h"
 
-extern char bpf_preload_umd_start;
-extern char bpf_preload_umd_end;
+static struct bpf_link *maps_link, *progs_link;
+static struct iterators_bpf *skel;
 
-static int preload(struct bpf_preload_info *obj);
-static int finish(void);
+static void free_links_and_skel(void)
+{
+	if (!IS_ERR_OR_NULL(maps_link))
+		bpf_link_put(maps_link);
+	if (!IS_ERR_OR_NULL(progs_link))
+		bpf_link_put(progs_link);
+	iterators_bpf__destroy(skel);
+}
+
+static int preload(struct bpf_preload_info *obj)
+{
+	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
+	obj[0].link = maps_link;
+	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
+	obj[1].link = progs_link;
+	return 0;
+}
 
-static struct bpf_preload_ops umd_ops = {
-	.info.driver_name = "bpf_preload",
+static struct bpf_preload_ops ops = {
 	.preload = preload,
-	.finish = finish,
 	.owner = THIS_MODULE,
 };
 
-static int preload(struct bpf_preload_info *obj)
+static int load_skel(void)
 {
-	int magic = BPF_PRELOAD_START;
-	loff_t pos = 0;
-	int i, err;
-	ssize_t n;
+	int err;
 
-	err = fork_usermode_driver(&umd_ops.info);
+	skel = iterators_bpf__open();
+	if (!skel)
+		return -ENOMEM;
+	err = iterators_bpf__load(skel);
 	if (err)
-		return err;
-
-	/* send the start magic to let UMD proceed with loading BPF progs */
-	n = kernel_write(umd_ops.info.pipe_to_umh,
-			 &magic, sizeof(magic), &pos);
-	if (n != sizeof(magic))
-		return -EPIPE;
-
-	/* receive bpf_link IDs and names from UMD */
-	pos = 0;
-	for (i = 0; i < BPF_PRELOAD_LINKS; i++) {
-		n = kernel_read(umd_ops.info.pipe_from_umh,
-				&obj[i], sizeof(*obj), &pos);
-		if (n != sizeof(*obj))
-			return -EPIPE;
+		goto out;
+	err = iterators_bpf__attach(skel);
+	if (err)
+		goto out;
+	maps_link = bpf_link_get_from_fd(skel->links.dump_bpf_map_fd);
+	if (IS_ERR(maps_link)) {
+		err = PTR_ERR(maps_link);
+		goto out;
 	}
-	return 0;
-}
-
-static int finish(void)
-{
-	int magic = BPF_PRELOAD_END;
-	struct pid *tgid;
-	loff_t pos = 0;
-	ssize_t n;
-
-	/* send the last magic to UMD. It will do a normal exit. */
-	n = kernel_write(umd_ops.info.pipe_to_umh,
-			 &magic, sizeof(magic), &pos);
-	if (n != sizeof(magic))
-		return -EPIPE;
-
-	tgid = umd_ops.info.tgid;
-	if (tgid) {
-		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-		umd_cleanup_helper(&umd_ops.info);
+	progs_link = bpf_link_get_from_fd(skel->links.dump_bpf_prog_fd);
+	if (IS_ERR(progs_link)) {
+		err = PTR_ERR(progs_link);
+		goto out;
 	}
 	return 0;
+out:
+	free_links_and_skel();
+	return err;
 }
 
-static int __init load_umd(void)
+static int __init load(void)
 {
 	int err;
 
-	err = umd_load_blob(&umd_ops.info, &bpf_preload_umd_start,
-			    &bpf_preload_umd_end - &bpf_preload_umd_start);
+	err = load_skel();
 	if (err)
 		return err;
-	bpf_preload_ops = &umd_ops;
+	bpf_preload_ops = &ops;
 	return err;
 }
 
-static void __exit fini_umd(void)
+static void __exit fini(void)
 {
-	struct pid *tgid;
-
 	bpf_preload_ops = NULL;
-
-	/* kill UMD in case it's still there due to earlier error */
-	tgid = umd_ops.info.tgid;
-	if (tgid) {
-		kill_pid(tgid, SIGKILL, 1);
-
-		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-		umd_cleanup_helper(&umd_ops.info);
-	}
-	umd_unload_blob(&umd_ops.info);
+	free_links_and_skel();
 }
-late_initcall(load_umd);
-module_exit(fini_umd);
+late_initcall(load);
+module_exit(fini);
 MODULE_LICENSE("GPL");
diff --git a/kernel/bpf/preload/bpf_preload_umd_blob.S b/kernel/bpf/preload/bpf_preload_umd_blob.S
deleted file mode 100644
index f1f40223b5c3..000000000000
--- a/kernel/bpf/preload/bpf_preload_umd_blob.S
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-	.section .init.rodata, "a"
-	.global bpf_preload_umd_start
-bpf_preload_umd_start:
-	.incbin "kernel/bpf/preload/bpf_preload_umd"
-	.global bpf_preload_umd_end
-bpf_preload_umd_end:
diff --git a/kernel/bpf/preload/iterators/bpf_preload_common.h b/kernel/bpf/preload/iterators/bpf_preload_common.h
deleted file mode 100644
index 8464d1a48c05..000000000000
--- a/kernel/bpf/preload/iterators/bpf_preload_common.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BPF_PRELOAD_COMMON_H
-#define _BPF_PRELOAD_COMMON_H
-
-#define BPF_PRELOAD_START 0x5555
-#define BPF_PRELOAD_END 0xAAAA
-
-struct bpf_preload_info {
-	char link_name[16];
-	int link_id;
-};
-
-#endif
diff --git a/kernel/bpf/preload/iterators/iterators.c b/kernel/bpf/preload/iterators/iterators.c
deleted file mode 100644
index 4dafe0f4f2b2..000000000000
--- a/kernel/bpf/preload/iterators/iterators.c
+++ /dev/null
@@ -1,108 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2020 Facebook */
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/resource.h>
-#include <bpf/libbpf.h>
-#include <bpf/bpf.h>
-#include <sys/mount.h>
-#include "iterators.lskel.h"
-#include "bpf_preload_common.h"
-
-int to_kernel = -1;
-int from_kernel = 0;
-
-static int __bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
-{
-	union bpf_attr attr;
-	int err;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.info.bpf_fd = bpf_fd;
-	attr.info.info_len = *info_len;
-	attr.info.info = (long) info;
-
-	err = skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
-	if (!err)
-		*info_len = attr.info.info_len;
-	return err;
-}
-
-static int send_link_to_kernel(int link_fd, const char *link_name)
-{
-	struct bpf_preload_info obj = {};
-	struct bpf_link_info info = {};
-	__u32 info_len = sizeof(info);
-	int err;
-
-	err = __bpf_obj_get_info_by_fd(link_fd, &info, &info_len);
-	if (err)
-		return err;
-	obj.link_id = info.id;
-	if (strlen(link_name) >= sizeof(obj.link_name))
-		return -E2BIG;
-	strcpy(obj.link_name, link_name);
-	if (write(to_kernel, &obj, sizeof(obj)) != sizeof(obj))
-		return -EPIPE;
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	struct iterators_bpf *skel;
-	int err, magic;
-	int debug_fd;
-
-	debug_fd = open("/dev/console", O_WRONLY | O_NOCTTY | O_CLOEXEC);
-	if (debug_fd < 0)
-		return 1;
-	to_kernel = dup(1);
-	close(1);
-	dup(debug_fd);
-	/* now stdin and stderr point to /dev/console */
-
-	read(from_kernel, &magic, sizeof(magic));
-	if (magic != BPF_PRELOAD_START) {
-		printf("bad start magic %d\n", magic);
-		return 1;
-	}
-	/* libbpf opens BPF object and loads it into the kernel */
-	skel = iterators_bpf__open_and_load();
-	if (!skel) {
-		/* iterators.skel.h is little endian.
-		 * libbpf doesn't support automatic little->big conversion
-		 * of BPF bytecode yet.
-		 * The program load will fail in such case.
-		 */
-		printf("Failed load could be due to wrong endianness\n");
-		return 1;
-	}
-	err = iterators_bpf__attach(skel);
-	if (err)
-		goto cleanup;
-
-	/* send two bpf_link IDs with names to the kernel */
-	err = send_link_to_kernel(skel->links.dump_bpf_map_fd, "maps.debug");
-	if (err)
-		goto cleanup;
-	err = send_link_to_kernel(skel->links.dump_bpf_prog_fd, "progs.debug");
-	if (err)
-		goto cleanup;
-
-	/* The kernel will proceed with pinnging the links in bpffs.
-	 * UMD will wait on read from pipe.
-	 */
-	read(from_kernel, &magic, sizeof(magic));
-	if (magic != BPF_PRELOAD_END) {
-		printf("bad final magic %d\n", magic);
-		err = -EINVAL;
-	}
-cleanup:
-	iterators_bpf__destroy(skel);
-
-	return err != 0;
-}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 08ac01acc51e..54859f584115 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2490,6 +2490,7 @@ void bpf_link_put(struct bpf_link *link)
 		bpf_link_free(link);
 	}
 }
+EXPORT_SYMBOL(bpf_link_put);
 
 static int bpf_link_release(struct inode *inode, struct file *filp)
 {
@@ -2632,6 +2633,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 
 	return link;
 }
+EXPORT_SYMBOL(bpf_link_get_from_fd);
 
 struct bpf_tracing_link {
 	struct bpf_link link;
-- 
2.30.2

