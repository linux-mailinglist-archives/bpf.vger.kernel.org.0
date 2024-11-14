Return-Path: <bpf+bounces-44821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B85E9C80B8
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 03:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEE01F2504B
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 02:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB041E7C15;
	Thu, 14 Nov 2024 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iYMl1eo+"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFA1E009F;
	Thu, 14 Nov 2024 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551062; cv=none; b=gh6iQ9b8BuPwhjzp8am2QRUdZxgQJADkFfBD77p9+RTglQ0lQAiIX7/0ctNDpLTmFyJVAu1gi/zl6RkpvZwbnJwuwm4PGfmYAg9wKC0XrO640ne/C90BUUwk72Ti4J+NSU0OqSf8NegePYerfaX/Y8zVd7w3Gvu5j0vNnDFlZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551062; c=relaxed/simple;
	bh=DLUDdLqDtqUZbyRSdnpJxOk9J6OBNQOtHRV+Y9p81hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G78bA2RyB80k8hbzJCKDnsp3RFSO9YnH3XHN/p59QqzPmkoEBEXd2pCrAna0PktNYJWuGaBniSLqxP8ZS33lEBNoiE2UvSGd8NCphANf1nMTzLFt7dfdqu+qe1zYPpPdGsKGLbnTi22V5yanWrbVG8XNzRQBrjIyxlGsjWVB/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iYMl1eo+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=bJRnowXW1WRxGxoVT/jc+6mYnFtGS0RSbqxGPing5B8=; b=iYMl1eo+3+I42+dS
	oJhAcMA/rdLsenuRjgdpv2Q+Qa+OKU/NH9B1/golS9853C3l4RMZlL4veej2/ZNexJV8MAxs8aQFx
	ChJwF0bdTFEK5+EqbNdzDV1yaD+4JZycEPVStxR2Lap+m/eBQ4umXJqpMvxchb7wz4wnCHorhs5sx
	CsVvuIoOPJzu5XdjSnCJ82YDmOMwjIABupoe7sb6v5WrhNK1KIvZyxU8XYo6h2q353iK7vBkswFKt
	CMMTZxu73gEerlp9wiqFGSRuatP+lEtIugSa9xwkDQAZJCursmaFqGfI/NPPOiYmMsN1qOUuHdEPW
	brukEy+Z4YNthnXbDQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tBPWg-00HPvO-2U;
	Thu, 14 Nov 2024 02:24:06 +0000
From: linux@treblig.org
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	roberto.sassu@huaweicloud.com,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] umd: Remove
Date: Thu, 14 Nov 2024 02:24:00 +0000
Message-ID: <20241114022400.301175-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114022400.301175-1-linux@treblig.org>
References: <20241114022400.301175-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of the usermode driver code was removed by
commit 98e20e5e13d2 ("bpfilter: remove bpfilter")

Remove the code.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/usermode_driver.h |  19 ----
 kernel/Makefile                 |   1 -
 kernel/bpf/preload/Kconfig      |   4 -
 kernel/usermode_driver.c        | 191 --------------------------------
 4 files changed, 215 deletions(-)
 delete mode 100644 include/linux/usermode_driver.h
 delete mode 100644 kernel/usermode_driver.c

diff --git a/include/linux/usermode_driver.h b/include/linux/usermode_driver.h
deleted file mode 100644
index ad970416260d..000000000000
--- a/include/linux/usermode_driver.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __LINUX_USERMODE_DRIVER_H__
-#define __LINUX_USERMODE_DRIVER_H__
-
-#include <linux/umh.h>
-#include <linux/path.h>
-
-struct umd_info {
-	const char *driver_name;
-	struct file *pipe_to_umh;
-	struct file *pipe_from_umh;
-	struct path wd;
-	struct pid *tgid;
-};
-int umd_load_blob(struct umd_info *info, const void *data, size_t len);
-int umd_unload_blob(struct umd_info *info);
-int fork_usermode_driver(struct umd_info *info);
-void umd_cleanup_helper(struct umd_info *info);
-
-#endif /* __LINUX_USERMODE_DRIVER_H__ */
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..25d58da2a6ee 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -12,7 +12,6 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
 
-obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
 obj-$(CONFIG_VHOST_TASK) += vhost_task.o
 
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index f9b11d01c3b5..aef7b0bc96d6 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config USERMODE_DRIVER
-	bool
-	default n
-
 menuconfig BPF_PRELOAD
 	bool "Preload BPF file system with kernel specific program and map iterators"
 	depends on BPF
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
deleted file mode 100644
index 8303f4c7ca71..000000000000
--- a/kernel/usermode_driver.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * umd - User mode driver support
- */
-#include <linux/shmem_fs.h>
-#include <linux/pipe_fs_i.h>
-#include <linux/mount.h>
-#include <linux/fs_struct.h>
-#include <linux/task_work.h>
-#include <linux/usermode_driver.h>
-
-static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
-{
-	struct file_system_type *type;
-	struct vfsmount *mnt;
-	struct file *file;
-	ssize_t written;
-	loff_t pos = 0;
-
-	type = get_fs_type("tmpfs");
-	if (!type)
-		return ERR_PTR(-ENODEV);
-
-	mnt = kern_mount(type);
-	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return mnt;
-
-	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, 0700);
-	if (IS_ERR(file)) {
-		kern_unmount(mnt);
-		return ERR_CAST(file);
-	}
-
-	written = kernel_write(file, data, len, &pos);
-	if (written != len) {
-		int err = written;
-		if (err >= 0)
-			err = -ENOMEM;
-		filp_close(file, NULL);
-		kern_unmount(mnt);
-		return ERR_PTR(err);
-	}
-
-	fput(file);
-
-	/* Flush delayed fput so exec can open the file read-only */
-	flush_delayed_fput();
-	task_work_run();
-	return mnt;
-}
-
-/**
- * umd_load_blob - Remember a blob of bytes for fork_usermode_driver
- * @info: information about usermode driver
- * @data: a blob of bytes that can be executed as a file
- * @len:  The lentgh of the blob
- *
- */
-int umd_load_blob(struct umd_info *info, const void *data, size_t len)
-{
-	struct vfsmount *mnt;
-
-	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
-		return -EBUSY;
-
-	mnt = blob_to_mnt(data, len, info->driver_name);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
-
-	info->wd.mnt = mnt;
-	info->wd.dentry = mnt->mnt_root;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(umd_load_blob);
-
-/**
- * umd_unload_blob - Disassociate @info from a previously loaded blob
- * @info: information about usermode driver
- *
- */
-int umd_unload_blob(struct umd_info *info)
-{
-	if (WARN_ON_ONCE(!info->wd.mnt ||
-			 !info->wd.dentry ||
-			 info->wd.mnt->mnt_root != info->wd.dentry))
-		return -EINVAL;
-
-	kern_unmount(info->wd.mnt);
-	info->wd.mnt = NULL;
-	info->wd.dentry = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(umd_unload_blob);
-
-static int umd_setup(struct subprocess_info *info, struct cred *new)
-{
-	struct umd_info *umd_info = info->data;
-	struct file *from_umh[2];
-	struct file *to_umh[2];
-	int err;
-
-	/* create pipe to send data to umh */
-	err = create_pipe_files(to_umh, 0);
-	if (err)
-		return err;
-	err = replace_fd(0, to_umh[0], 0);
-	fput(to_umh[0]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		return err;
-	}
-
-	/* create pipe to receive data from umh */
-	err = create_pipe_files(from_umh, 0);
-	if (err) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		return err;
-	}
-	err = replace_fd(1, from_umh[1], 0);
-	fput(from_umh[1]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		fput(from_umh[0]);
-		return err;
-	}
-
-	set_fs_pwd(current->fs, &umd_info->wd);
-	umd_info->pipe_to_umh = to_umh[1];
-	umd_info->pipe_from_umh = from_umh[0];
-	umd_info->tgid = get_pid(task_tgid(current));
-	return 0;
-}
-
-static void umd_cleanup(struct subprocess_info *info)
-{
-	struct umd_info *umd_info = info->data;
-
-	/* cleanup if umh_setup() was successful but exec failed */
-	if (info->retval)
-		umd_cleanup_helper(umd_info);
-}
-
-/**
- * umd_cleanup_helper - release the resources which were allocated in umd_setup
- * @info: information about usermode driver
- */
-void umd_cleanup_helper(struct umd_info *info)
-{
-	fput(info->pipe_to_umh);
-	fput(info->pipe_from_umh);
-	put_pid(info->tgid);
-	info->tgid = NULL;
-}
-EXPORT_SYMBOL_GPL(umd_cleanup_helper);
-
-/**
- * fork_usermode_driver - fork a usermode driver
- * @info: information about usermode driver (shouldn't be NULL)
- *
- * Returns either negative error or zero which indicates success in
- * executing a usermode driver. In such case 'struct umd_info *info'
- * is populated with two pipes and a tgid of the process. The caller is
- * responsible for health check of the user process, killing it via
- * tgid, and closing the pipes when user process is no longer needed.
- */
-int fork_usermode_driver(struct umd_info *info)
-{
-	struct subprocess_info *sub_info;
-	const char *argv[] = { info->driver_name, NULL };
-	int err;
-
-	if (WARN_ON_ONCE(info->tgid))
-		return -EBUSY;
-
-	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup(info->driver_name,
-					     (char **)argv, NULL, GFP_KERNEL,
-					     umd_setup, umd_cleanup, info);
-	if (!sub_info)
-		goto out;
-
-	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
-out:
-	return err;
-}
-EXPORT_SYMBOL_GPL(fork_usermode_driver);
-
-
-- 
2.47.0


