Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB1757E553
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiGVRVs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiGVRVr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6B54642
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:21:46 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGQd18Wnz67KmH;
        Sat, 23 Jul 2022 01:19:53 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:21:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 10/15] bpftool: Add opts parameter to *_parse_fds()
Date:   Fri, 22 Jul 2022 19:18:31 +0200
Message-ID: <20220722171836.2852247-11-roberto.sassu@huawei.com>
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

Add the opts parameter to prog_parse_fds(), map_parse_fds(), and the static
functions called by them, respectively prog_fd_by_nametag() and
map_fd_by_name().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/common.c | 34 +++++++++++++++++++---------------
 tools/bpf/bpftool/main.c   |  1 +
 tools/bpf/bpftool/main.h   |  6 ++++--
 tools/bpf/bpftool/map.c    |  4 ++--
 tools/bpf/bpftool/prog.c   |  4 ++--
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 17da60c83b7c..913771fcf8ec 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -723,7 +723,8 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
 
-static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
+static int prog_fd_by_nametag(void *nametag, int **fds, bool tag,
+			      const struct bpf_get_fd_opts *opts)
 {
 	unsigned int id = 0;
 	int fd, nb_fds = 0;
@@ -743,7 +744,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			return nb_fds;
 		}
 
-		fd = bpf_prog_get_fd_by_id(id);
+		fd = bpf_prog_get_fd_by_id_opts(id, opts);
 		if (fd < 0) {
 			p_err("can't get prog by id (%u): %s",
 			      id, strerror(errno));
@@ -782,7 +783,8 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 	return -1;
 }
 
-int prog_parse_fds(int *argc, char ***argv, int **fds)
+int prog_parse_fds(int *argc, char ***argv, int **fds,
+		   const struct bpf_get_fd_opts *opts)
 {
 	if (is_prefix(**argv, "id")) {
 		unsigned int id;
@@ -797,7 +799,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		(*fds)[0] = bpf_prog_get_fd_by_id(id);
+		(*fds)[0] = bpf_prog_get_fd_by_id_opts(id, opts);
 		if ((*fds)[0] < 0) {
 			p_err("get by id (%u): %s", id, strerror(errno));
 			return -1;
@@ -816,7 +818,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		return prog_fd_by_nametag(tag, fds, true);
+		return prog_fd_by_nametag(tag, fds, true, opts);
 	} else if (is_prefix(**argv, "name")) {
 		char *name;
 
@@ -829,7 +831,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		return prog_fd_by_nametag(name, fds, false);
+		return prog_fd_by_nametag(name, fds, false, opts);
 	} else if (is_prefix(**argv, "pinned")) {
 		char *path;
 
@@ -838,7 +840,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG, NULL);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG, opts);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
@@ -859,7 +861,7 @@ int prog_parse_fd(int *argc, char ***argv,
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(argc, argv, &fds);
+	nb_fds = prog_parse_fds(argc, argv, &fds, opts);
 	if (nb_fds != 1) {
 		if (nb_fds > 1) {
 			p_err("several programs match this handle");
@@ -876,7 +878,8 @@ int prog_parse_fd(int *argc, char ***argv,
 	return fd;
 }
 
-static int map_fd_by_name(char *name, int **fds)
+static int map_fd_by_name(char *name, int **fds,
+			  const struct bpf_get_fd_opts *opts)
 {
 	unsigned int id = 0;
 	int fd, nb_fds = 0;
@@ -896,7 +899,7 @@ static int map_fd_by_name(char *name, int **fds)
 			return nb_fds;
 		}
 
-		fd = bpf_map_get_fd_by_id(id);
+		fd = bpf_map_get_fd_by_id_opts(id, opts);
 		if (fd < 0) {
 			p_err("can't get map by id (%u): %s",
 			      id, strerror(errno));
@@ -934,7 +937,8 @@ static int map_fd_by_name(char *name, int **fds)
 	return -1;
 }
 
-int map_parse_fds(int *argc, char ***argv, int **fds)
+int map_parse_fds(int *argc, char ***argv, int **fds,
+		  const struct bpf_get_fd_opts *opts)
 {
 	if (is_prefix(**argv, "id")) {
 		unsigned int id;
@@ -949,7 +953,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		(*fds)[0] = bpf_map_get_fd_by_id(id);
+		(*fds)[0] = bpf_map_get_fd_by_id_opts(id, opts);
 		if ((*fds)[0] < 0) {
 			p_err("get map by id (%u): %s", id, strerror(errno));
 			return -1;
@@ -967,7 +971,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		return map_fd_by_name(name, fds);
+		return map_fd_by_name(name, fds, opts);
 	} else if (is_prefix(**argv, "pinned")) {
 		char *path;
 
@@ -976,7 +980,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP, NULL);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP, opts);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
@@ -996,7 +1000,7 @@ int map_parse_fd(int *argc, char ***argv, const struct bpf_get_fd_opts *opts)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(argc, argv, &fds);
+	nb_fds = map_parse_fds(argc, argv, &fds, opts);
 	if (nb_fds != 1) {
 		if (nb_fds > 1) {
 			p_err("several maps match this handle");
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c0f783f0f3b7..451cefc2d0da 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 88218add9e9f..13125171ac8a 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -171,10 +171,12 @@ int do_iter(int argc, char **argv) __weak;
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv,
 		  const struct bpf_get_fd_opts *opts);
-int prog_parse_fds(int *argc, char ***argv, int **fds);
+int prog_parse_fds(int *argc, char ***argv, int **fds,
+		   const struct bpf_get_fd_opts *opts);
 int map_parse_fd(int *argc, char ***argv,
 		 const struct bpf_get_fd_opts *opts);
-int map_parse_fds(int *argc, char ***argv, int **fds);
+int map_parse_fds(int *argc, char ***argv, int **fds,
+		  const struct bpf_get_fd_opts *opts);
 int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
 
 struct bpf_prog_linfo;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index bacdb17f0c6d..d921cb1a116d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -634,7 +634,7 @@ static int do_show_subset(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, NULL);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -910,7 +910,7 @@ static int do_dump(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, NULL);
 	if (nb_fds < 1)
 		goto exit_free;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 400dfc085ee5..e37af694152e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -605,7 +605,7 @@ static int do_show_subset(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(&argc, &argv, &fds);
+	nb_fds = prog_parse_fds(&argc, &argv, &fds, NULL);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -905,7 +905,7 @@ static int do_dump(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(&argc, &argv, &fds);
+	nb_fds = prog_parse_fds(&argc, &argv, &fds, NULL);
 	if (nb_fds < 1)
 		goto exit_free;
 
-- 
2.25.1

