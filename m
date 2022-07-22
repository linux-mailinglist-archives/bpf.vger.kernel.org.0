Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838E57E551
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiGVRUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiGVRUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:20:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE715593
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:20:21 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGKq32l7z67d0C;
        Sat, 23 Jul 2022 01:15:43 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:20:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 09/15] bpftool: Add opts parameter to *_parse_fd() functions
Date:   Fri, 22 Jul 2022 19:18:30 +0200
Message-ID: <20220722171836.2852247-10-roberto.sassu@huawei.com>
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

Add the opts parameter to map_parse_fd(), prog_parse_fd(), link_parse_fd()
and btf_parse_fd() at the same time, as those functions are passed to
do_pin_any().

Pass NULL to those functions, so that the current behavior does not change,
and adjust permissions in a later patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/btf.c    |  9 +++++----
 tools/bpf/bpftool/cgroup.c |  4 ++--
 tools/bpf/bpftool/common.c | 12 +++++++-----
 tools/bpf/bpftool/iter.c   |  2 +-
 tools/bpf/bpftool/link.c   | 11 ++++++-----
 tools/bpf/bpftool/main.h   |  9 ++++++---
 tools/bpf/bpftool/map.c    |  6 +++---
 tools/bpf/bpftool/net.c    |  2 +-
 tools/bpf/bpftool/prog.c   | 10 +++++-----
 9 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 0744bd1150be..ab7bf9f3cc27 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -610,7 +610,7 @@ static int do_dump(int argc, char **argv)
 			return -1;
 		}
 
-		fd = prog_parse_fd(&argc, &argv);
+		fd = prog_parse_fd(&argc, &argv, NULL);
 		if (fd < 0)
 			return -1;
 
@@ -712,7 +712,8 @@ static int do_dump(int argc, char **argv)
 	return err;
 }
 
-static int btf_parse_fd(int *argc, char ***argv)
+static int btf_parse_fd(int *argc, char ***argv,
+			const struct bpf_get_fd_opts *opts)
 {
 	unsigned int id;
 	char *endptr;
@@ -731,7 +732,7 @@ static int btf_parse_fd(int *argc, char ***argv)
 	}
 	NEXT_ARGP();
 
-	fd = bpf_btf_get_fd_by_id(id);
+	fd = bpf_btf_get_fd_by_id_opts(id, opts);
 	if (fd < 0)
 		p_err("can't get BTF object by id (%u): %s",
 		      id, strerror(errno));
@@ -982,7 +983,7 @@ static int do_show(int argc, char **argv)
 	__u32 id = 0;
 
 	if (argc == 2) {
-		fd = btf_parse_fd(&argc, &argv);
+		fd = btf_parse_fd(&argc, &argv, NULL);
 		if (fd < 0)
 			return -1;
 	}
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index cced668fb2a3..cc007ddc945b 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -490,7 +490,7 @@ static int do_attach(int argc, char **argv)
 
 	argc -= 2;
 	argv = &argv[2];
-	prog_fd = prog_parse_fd(&argc, &argv);
+	prog_fd = prog_parse_fd(&argc, &argv, NULL);
 	if (prog_fd < 0)
 		goto exit_cgroup;
 
@@ -548,7 +548,7 @@ static int do_detach(int argc, char **argv)
 
 	argc -= 2;
 	argv = &argv[2];
-	prog_fd = prog_parse_fd(&argc, &argv);
+	prog_fd = prog_parse_fd(&argc, &argv, NULL);
 	if (prog_fd < 0)
 		goto exit_cgroup;
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index d3e3c779b027..17da60c83b7c 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -297,12 +297,13 @@ int do_pin_fd(int fd, const char *name)
 	return err;
 }
 
-int do_pin_any(int argc, char **argv, int (*get_fd)(int *, char ***))
+int do_pin_any(int argc, char **argv,
+	       int (*get_fd)(int *, char ***, const struct bpf_get_fd_opts *))
 {
 	int err;
 	int fd;
 
-	fd = get_fd(&argc, &argv);
+	fd = get_fd(&argc, &argv, NULL);
 	if (fd < 0)
 		return fd;
 
@@ -847,7 +848,8 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 	return -1;
 }
 
-int prog_parse_fd(int *argc, char ***argv)
+int prog_parse_fd(int *argc, char ***argv,
+		  const struct bpf_get_fd_opts *opts)
 {
 	int *fds = NULL;
 	int nb_fds, fd;
@@ -984,7 +986,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 	return -1;
 }
 
-int map_parse_fd(int *argc, char ***argv)
+int map_parse_fd(int *argc, char ***argv, const struct bpf_get_fd_opts *opts)
 {
 	int *fds = NULL;
 	int nb_fds, fd;
@@ -1016,7 +1018,7 @@ int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
 	int err;
 	int fd;
 
-	fd = map_parse_fd(argc, argv);
+	fd = map_parse_fd(argc, argv, NULL);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index f88fdc820d23..1412be9eb298 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -34,7 +34,7 @@ static int do_pin(int argc, char **argv)
 				return -1;
 			}
 
-			map_fd = map_parse_fd(&argc, &argv);
+			map_fd = map_parse_fd(&argc, &argv, NULL);
 			if (map_fd < 0)
 				return -1;
 
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 62902d5ea1ae..b319f9769d90 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -15,7 +15,8 @@
 
 static struct hashmap *link_table;
 
-static int link_parse_fd(int *argc, char ***argv)
+static int link_parse_fd(int *argc, char ***argv,
+			 const struct bpf_get_fd_opts *opts)
 {
 	int fd;
 
@@ -32,7 +33,7 @@ static int link_parse_fd(int *argc, char ***argv)
 		}
 		NEXT_ARGP();
 
-		fd = bpf_link_get_fd_by_id(id);
+		fd = bpf_link_get_fd_by_id_opts(id, opts);
 		if (fd < 0)
 			p_err("failed to get link with ID %d: %s", id, strerror(errno));
 		return fd;
@@ -44,7 +45,7 @@ static int link_parse_fd(int *argc, char ***argv)
 		path = **argv;
 		NEXT_ARGP();
 
-		return open_obj_pinned_any(path, BPF_OBJ_LINK, NULL);
+		return open_obj_pinned_any(path, BPF_OBJ_LINK, opts);
 	}
 
 	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
@@ -321,7 +322,7 @@ static int do_show(int argc, char **argv)
 	build_obj_refs_table(&refs_table, BPF_OBJ_LINK);
 
 	if (argc == 2) {
-		fd = link_parse_fd(&argc, &argv);
+		fd = link_parse_fd(&argc, &argv, NULL);
 		if (fd < 0)
 			return fd;
 		return do_show_link(fd);
@@ -385,7 +386,7 @@ static int do_detach(int argc, char **argv)
 		return 1;
 	}
 
-	fd = link_parse_fd(&argc, &argv);
+	fd = link_parse_fd(&argc, &argv, NULL);
 	if (fd < 0)
 		return 1;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 53dfcb91ecac..88218add9e9f 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -147,7 +147,8 @@ int open_obj_pinned(const char *path, bool quiet,
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
 			const struct bpf_get_fd_opts *opts);
 int mount_bpffs_for_pin(const char *name);
-int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
+int do_pin_any(int argc, char **argv,
+	       int (*get_fd)(int *, char ***, const struct bpf_get_fd_opts *));
 int do_pin_fd(int fd, const char *name);
 
 /* commands available in bootstrap mode */
@@ -168,9 +169,11 @@ int do_struct_ops(int argc, char **argv) __weak;
 int do_iter(int argc, char **argv) __weak;
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
-int prog_parse_fd(int *argc, char ***argv);
+int prog_parse_fd(int *argc, char ***argv,
+		  const struct bpf_get_fd_opts *opts);
 int prog_parse_fds(int *argc, char ***argv, int **fds);
-int map_parse_fd(int *argc, char ***argv);
+int map_parse_fd(int *argc, char ***argv,
+		 const struct bpf_get_fd_opts *opts);
 int map_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 38b6bc9c26c3..bacdb17f0c6d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -381,7 +381,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 				return -1;
 			}
 
-			fd = map_parse_fd(&argc, &argv);
+			fd = map_parse_fd(&argc, &argv, NULL);
 			if (fd < 0)
 				return -1;
 
@@ -402,7 +402,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 				p_info("Warning: updating program array via MAP_ID, make sure this map is kept open\n"
 				       "         by some process or pinned otherwise update will be lost");
 
-			fd = prog_parse_fd(&argc, &argv);
+			fd = prog_parse_fd(&argc, &argv, NULL);
 			if (fd < 0)
 				return -1;
 
@@ -1399,7 +1399,7 @@ static int do_freeze(int argc, char **argv)
 	if (!REQ_ARGS(2))
 		return -1;
 
-	fd = map_parse_fd(&argc, &argv);
+	fd = map_parse_fd(&argc, &argv, NULL);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 526a332c48e6..4c8a2831e04f 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -571,7 +571,7 @@ static int do_attach(int argc, char **argv)
 	}
 	NEXT_ARG();
 
-	progfd = prog_parse_fd(&argc, &argv);
+	progfd = prog_parse_fd(&argc, &argv, NULL);
 	if (progfd < 0)
 		return -EINVAL;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f081de398b60..400dfc085ee5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1027,7 +1027,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	if (!REQ_ARGS(3))
 		return -EINVAL;
 
-	*progfd = prog_parse_fd(&argc, &argv);
+	*progfd = prog_parse_fd(&argc, &argv, NULL);
 	if (*progfd < 0)
 		return *progfd;
 
@@ -1046,7 +1046,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	if (!REQ_ARGS(2))
 		return -EINVAL;
 
-	*mapfd = map_parse_fd(&argc, &argv);
+	*mapfd = map_parse_fd(&argc, &argv, NULL);
 	if (*mapfd < 0)
 		return *mapfd;
 
@@ -1270,7 +1270,7 @@ static int do_run(int argc, char **argv)
 	if (!REQ_ARGS(4))
 		return -1;
 
-	fd = prog_parse_fd(&argc, &argv);
+	fd = prog_parse_fd(&argc, &argv, NULL);
 	if (fd < 0)
 		return -1;
 
@@ -1542,7 +1542,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			}
 			NEXT_ARG();
 
-			fd = map_parse_fd(&argc, &argv);
+			fd = map_parse_fd(&argc, &argv, NULL);
 			if (fd < 0)
 				goto err_free_reuse_maps;
 
@@ -2233,7 +2233,7 @@ static int do_profile(int argc, char **argv)
 		return -EINVAL;
 
 	/* parse target fd */
-	profile_tgt_fd = prog_parse_fd(&argc, &argv);
+	profile_tgt_fd = prog_parse_fd(&argc, &argv, NULL);
 	if (profile_tgt_fd < 0) {
 		p_err("failed to parse fd");
 		return -1;
-- 
2.25.1

