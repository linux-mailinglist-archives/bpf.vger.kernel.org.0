Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497357E550
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiGVRUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiGVRUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:20:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A216389
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:20:20 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGM142kqz67LlD;
        Sat, 23 Jul 2022 01:16:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:20:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 08/15] bpftool: Add opts parameter to open_obj_pinned_any() and open_obj_pinned()
Date:   Fri, 22 Jul 2022 19:18:29 +0200
Message-ID: <20220722171836.2852247-9-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722171836.2852247-1-roberto.sassu@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Start to propagate the opts parameter from libbpf up to the bpftool
subcommand implementation, so that the appropriate permissions can be
requested depending on the operation type.

Add the bpf_get_fd_opts structure as parameter to open_obj_pinned_any() and
open_obj_pinned(), so that it can be sent to the new libbpf function
bpf_obj_get_opts().

Pass NULL as argument value, so that there is no change in the current
behavior.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/common.c | 16 +++++++++-------
 tools/bpf/bpftool/link.c   |  2 +-
 tools/bpf/bpftool/main.c   |  1 -
 tools/bpf/bpftool/main.h   |  7 +++++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 067e9ea59e3b..d3e3c779b027 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -191,7 +191,8 @@ int mount_tracefs(const char *target)
 	return err;
 }
 
-int open_obj_pinned(const char *path, bool quiet)
+int open_obj_pinned(const char *path, bool quiet,
+		    const struct bpf_get_fd_opts *opts)
 {
 	char *pname;
 	int fd = -1;
@@ -203,7 +204,7 @@ int open_obj_pinned(const char *path, bool quiet)
 		goto out_ret;
 	}
 
-	fd = bpf_obj_get(pname);
+	fd = bpf_obj_get_opts(pname, opts);
 	if (fd < 0) {
 		if (!quiet)
 			p_err("bpf obj get (%s): %s", pname,
@@ -219,12 +220,13 @@ int open_obj_pinned(const char *path, bool quiet)
 	return fd;
 }
 
-int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
+int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
+			const struct bpf_get_fd_opts *opts)
 {
 	enum bpf_obj_type type;
 	int fd;
 
-	fd = open_obj_pinned(path, false);
+	fd = open_obj_pinned(path, false, opts);
 	if (fd < 0)
 		return -1;
 
@@ -474,7 +476,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 	if (typeflag != FTW_F)
 		goto out_ret;
 
-	fd = open_obj_pinned(fpath, true);
+	fd = open_obj_pinned(fpath, true, NULL);
 	if (fd < 0)
 		goto out_ret;
 
@@ -835,7 +837,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG, NULL);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
@@ -972,7 +974,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP, NULL);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 7a20931c3250..62902d5ea1ae 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -44,7 +44,7 @@ static int link_parse_fd(int *argc, char ***argv)
 		path = **argv;
 		NEXT_ARGP();
 
-		return open_obj_pinned_any(path, BPF_OBJ_LINK);
+		return open_obj_pinned_any(path, BPF_OBJ_LINK, NULL);
 	}
 
 	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 451cefc2d0da..c0f783f0f3b7 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 5e5060c2ac04..53dfcb91ecac 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <bpf/bpf.h>
 #include <linux/bpf.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -141,8 +142,10 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
 int get_fd_type(int fd);
 const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
-int open_obj_pinned(const char *path, bool quiet);
-int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
+int open_obj_pinned(const char *path, bool quiet,
+		    const struct bpf_get_fd_opts *opts);
+int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
+			const struct bpf_get_fd_opts *opts);
 int mount_bpffs_for_pin(const char *name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
-- 
2.25.1

