Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34395877E3
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiHBHeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBHeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 03:34:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287C6579;
        Tue,  2 Aug 2022 00:33:59 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lxmps5xfgzWfNV;
        Tue,  2 Aug 2022 15:29:57 +0800 (CST)
Received: from kwepemm600006.china.huawei.com (7.193.23.105) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 15:33:51 +0800
Received: from huawei.com (10.175.127.234) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 15:33:50 +0800
From:   Wenyu Liu <liuwenyu7@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <rickyman7@gmail.com>, <namhyung@gmail.com>, <nicolas@fjasle.eu>,
        <acme@redhat.com>, <alexey.v.bayduraev@linux.intel.com>,
        <masahiroy@kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <hewenliang4@huawei.com>, <yeyunfeng@huawei.com>,
        <linfeilong@huawei.com>, <liuwenyu7@huawei.com>
Subject: [PATCH] tools api fs: fix the concurrency problem for xxx__mountpoint()
Date:   Tue, 2 Aug 2022 03:37:16 -0400
Message-ID: <20220802073716.1875289-1-liuwenyu7@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The hugeltbfs__mountpoint() interface seems have a problem
in perf top,sometimes it will get a wrong path in
perf_event__synthesize_mmap_events().

There is a very small probability when using perf top
and I got entries like this:
	3.26% 	perf-1.map		[.]0x0000ffffb2993d00
	3.22%	perf-1.map		[.]0x0000ffffb28a2984
	3.26%	perf-1.map		[.]0x0000ffffb2993d00
	...	...			...
I have already installed the perf-debuginfo package.

I find out it's in perf_event__synthesize_mmap_events():
when these following code execute:

    const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
    int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
    ...	...
    if (hugetlbfs_mnt_len &&
        !strncmp(event->mmap2.filename, hugetlbfs_mnt,
                 hugetlbfs_mnt_len)) {
    		strcpy(event->mmap2.filename, anonstr);
            event->mmap2.flags |= MAP_HUGETLB;
     }

when came to the if condition:
*event->mmap2.filename = "/usr/lib64/libgpg-error.so.0.29.0"
*hugetlbfs_mnt = "/dev/hugepages"
hugetlbfs_mnt_len = 1

So it's the strlen(hugetlbfs_mnt) get a wrong result,
make it only compared the first character and resulting
the mistake.
And that make the filename in map__new() came
to "/tmp/perf-<pid>.map".

It seems xxx_mountpoint() have a concurrency problem when
it scan /proc/mounts and fill path into fs->path in
fs__read_mounts().

The hugeltbfs__mountpoint() is called for each process found
in perf_event__synthesize_mmap_events().
And the working threads is synthesize_threads_worker(),which
is created by perf_event__synthesize_threads(),threads number
equals to the cpus number.
These threads share the fs__entries and fill path into
fs->path concurrently in perf_event__synthesize_mmap_events()
but without any synchronizing measures,cause the problem.

This patch add a mutex in struct fs,and a interface
fs_fill_path() for copying the path into fs->path.
When the target fs name be found in fs__read_mounts(),
using fs_fill_path() to copy the path into fs->path,
the mutex is needed during the coping procedure.

And add memory barrier to ensure the path is completely
filled before the fs->found is set.

Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
---
 tools/lib/api/Makefile |  1 +
 tools/lib/api/fs/fs.c  | 50 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index e21e1b40b525..9f2332c07294 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -19,6 +19,7 @@ LIBFILE = $(OUTPUT)libapi.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
+CFLAGS += -lpthread
 
 ifeq ($(DEBUG),0)
 ifeq ($(CC_NO_CLANG), 0)
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 82f53d81a7a7..5de7ba1fdbc9 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -12,6 +12,9 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/mount.h>
+#include <pthread.h>
+#include <asm/barrier.h>
+#include <linux/compiler.h>
 
 #include "fs.h"
 #include "debug-internal.h"
@@ -92,6 +95,7 @@ struct fs {
 	bool			 found;
 	bool			 checked;
 	long			 magic;
+	pthread_mutex_t		 lock;
 };
 
 enum {
@@ -113,43 +117,69 @@ static struct fs fs__entries[] = {
 		.mounts	= sysfs__fs_known_mountpoints,
 		.magic	= SYSFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__PROCFS] = {
 		.name	= "proc",
 		.mounts	= procfs__known_mountpoints,
 		.magic	= PROC_SUPER_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__DEBUGFS] = {
 		.name	= "debugfs",
 		.mounts	= debugfs__known_mountpoints,
 		.magic	= DEBUGFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__TRACEFS] = {
 		.name	= "tracefs",
 		.mounts	= tracefs__known_mountpoints,
 		.magic	= TRACEFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__HUGETLBFS] = {
 		.name	= "hugetlbfs",
 		.mounts = hugetlbfs__known_mountpoints,
 		.magic	= HUGETLBFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__BPF_FS] = {
 		.name	= "bpf",
 		.mounts = bpf_fs__known_mountpoints,
 		.magic	= BPF_FS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 };
 
+static void fs_fill_path(struct fs *fs, const char *path, size_t len)
+{
+	if (len >= sizeof(fs->path))
+		len = sizeof(fs->path) - 1;
+
+	pthread_mutex_lock(&fs->lock);
+	if (fs->found) {
+		pthread_mutex_unlock(&fs->lock);
+		return;
+	}
+	strncpy(fs->path, path, len);
+	fs->path[len] = '\0';
+	/* Make sure the path is filled before fs->found is set */
+	smp_wmb();
+	fs->found = true;
+	pthread_mutex_unlock(&fs->lock);
+}
+
+
 static bool fs__read_mounts(struct fs *fs)
 {
 	bool found = false;
 	char type[100];
+	char path[PATH_MAX];
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
@@ -158,15 +188,17 @@ static bool fs__read_mounts(struct fs *fs)
 
 	while (!found &&
 	       fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
-		      fs->path, type) == 2) {
+		      path, type) == 2) {
 
-		if (strcmp(type, fs->name) == 0)
+		if (strcmp(type, fs->name) == 0) {
+			fs_fill_path(fs, path, sizeof(path) - 1);
 			found = true;
+		}
 	}
 
 	fclose(fp);
 	fs->checked = true;
-	return fs->found = found;
+	return found;
 }
 
 static int fs__valid_mount(const char *fs, long magic)
@@ -188,8 +220,7 @@ static bool fs__check_mounts(struct fs *fs)
 	ptr = fs->mounts;
 	while (*ptr) {
 		if (fs__valid_mount(*ptr, fs->magic) == 0) {
-			fs->found = true;
-			strcpy(fs->path, *ptr);
+			fs_fill_path(fs, *ptr, strlen(*ptr));
 			return true;
 		}
 		ptr++;
@@ -227,10 +258,8 @@ static bool fs__env_override(struct fs *fs)
 	if (!override_path)
 		return false;
 
-	fs->found = true;
+	fs_fill_path(fs, override_path, sizeof(fs->path) - 1);
 	fs->checked = true;
-	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
-	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
 }
 
@@ -252,8 +281,11 @@ static const char *fs__mountpoint(int idx)
 {
 	struct fs *fs = &fs__entries[idx];
 
-	if (fs->found)
+	if (READ_ONCE(fs->found)) {
+		/* Make sure the path is filled completely */
+		smp_rmb();
 		return (const char *)fs->path;
+	}
 
 	/* the mount point was already checked for the mount point
 	 * but and did not exist, so return NULL to avoid scanning again.
-- 
2.36.1

