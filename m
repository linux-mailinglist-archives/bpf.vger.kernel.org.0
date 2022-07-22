Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3A57E557
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiGVRVx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiGVRVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E16716A
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:21:49 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGNk6pfQz67MtT;
        Sat, 23 Jul 2022 01:18:14 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:21:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 14/15] bpftool: Adjust map permissions
Date:   Fri, 22 Jul 2022 19:18:35 +0200
Message-ID: <20220722171836.2852247-15-roberto.sassu@huawei.com>
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

Request a read-only file descriptor for:
- btf subcommand: dump, show (build_btf_type_table for maps);
- do_build_table_cb(), to show the path of a pinned map;
- map search by name;
- iter subcommands: pin (maps);
- map subcommands: show_subset, show, dump, lookup, getnext and pin;
- prog subcommand: show (metadata);
- struct_ops subcommands: show and dump;
- retrieve fd of inner map for update of outer map.

Request a write-only file descriptor for:
- map subcommands: update, delete, event_pipe.

Other permissions requests remain unchanged.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/btf.c           | 12 ++++++--
 tools/bpf/bpftool/common.c        | 30 +++++++++++++++++--
 tools/bpf/bpftool/iter.c          |  6 +++-
 tools/bpf/bpftool/map.c           | 48 +++++++++++++++++++++++++------
 tools/bpf/bpftool/map_perf_ring.c |  6 +++-
 tools/bpf/bpftool/prog.c          |  6 +++-
 tools/bpf/bpftool/struct_ops.c    | 32 +++++++++++++++++++--
 7 files changed, 121 insertions(+), 19 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 2cbc777f1520..4666a59d5fc6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -566,6 +566,10 @@ static int do_dump(int argc, char **argv)
 	int fd = -1;
 	int err;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (!REQ_ARGS(2)) {
 		usage();
 		return -1;
@@ -580,7 +584,7 @@ static int do_dump(int argc, char **argv)
 			return -1;
 		}
 
-		fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
+		fd = map_parse_fd_and_info(&argc, &argv, &info, &len, &opts);
 		if (fd < 0)
 			return -1;
 
@@ -753,6 +757,10 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 	int err;
 	int fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	while (true) {
 		switch (type) {
 		case BPF_OBJ_PROG:
@@ -782,7 +790,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 			fd = bpf_prog_get_fd_by_id_opts(id, NULL);
 			break;
 		case BPF_OBJ_MAP:
-			fd = bpf_map_get_fd_by_id_opts(id, NULL);
+			fd = bpf_map_get_fd_by_id_opts(id, &opts);
 			break;
 		default:
 			err = -1;
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 8a2412fc4410..dd58054bcce7 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -28,6 +28,7 @@
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 #include <bpf/btf.h>
+#include <bpf/libbpf_internal.h> /* OPTS_GET */
 
 #include "main.h"
 
@@ -303,7 +304,11 @@ int do_pin_any(int argc, char **argv,
 	int err;
 	int fd;
 
-	fd = get_fd(&argc, &argv, NULL);
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
+	fd = get_fd(&argc, &argv, &opts);
 	if (fd < 0)
 		return fd;
 
@@ -474,10 +479,14 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 	int fd, err = 0;
 	char *path;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (typeflag != FTW_F)
 		goto out_ret;
 
-	fd = open_obj_pinned(fpath, true, NULL);
+	fd = open_obj_pinned(fpath, true, &opts);
 	if (fd < 0)
 		goto out_ret;
 
@@ -886,6 +895,10 @@ static int map_fd_by_name(char *name, int **fds,
 	void *tmp;
 	int err;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, search_opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	while (true) {
 		struct bpf_map_info info = {};
 		__u32 len = sizeof(info);
@@ -899,7 +912,7 @@ static int map_fd_by_name(char *name, int **fds,
 			return nb_fds;
 		}
 
-		fd = bpf_map_get_fd_by_id_opts(id, opts);
+		fd = bpf_map_get_fd_by_id_opts(id, &search_opts);
 		if (fd < 0) {
 			p_err("can't get map by id (%u): %s",
 			      id, strerror(errno));
@@ -918,6 +931,17 @@ static int map_fd_by_name(char *name, int **fds,
 			continue;
 		}
 
+		if (OPTS_GET(opts, flags, 0) != BPF_F_RDONLY) {
+			close(fd);
+
+			fd = bpf_map_get_fd_by_id_opts(id, opts);
+			if (fd < 0) {
+				p_err("can't get map by id (%u): %s",
+				      id, strerror(errno));
+				goto err_close_fds;
+			}
+		}
+
 		if (nb_fds > 0) {
 			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
 			if (!tmp) {
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 1412be9eb298..40b3f8fddd90 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -18,6 +18,10 @@ static int do_pin(int argc, char **argv)
 	struct bpf_link *link;
 	int err = -1, map_fd = -1;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (!REQ_ARGS(2))
 		usage();
 
@@ -34,7 +38,7 @@ static int do_pin(int argc, char **argv)
 				return -1;
 			}
 
-			map_fd = map_parse_fd(&argc, &argv, NULL);
+			map_fd = map_parse_fd(&argc, &argv, &opts);
 			if (map_fd < 0)
 				return -1;
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 103bd44cd851..e2936b0046ba 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -334,6 +334,10 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 		      void *key, void *value, __u32 key_size, __u32 value_size,
 		      __u32 *flags, __u32 **value_fd)
 {
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (!*argv) {
 		if (!key && !value)
 			return 0;
@@ -381,7 +385,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 				return -1;
 			}
 
-			fd = map_parse_fd(&argc, &argv, NULL);
+			fd = map_parse_fd(&argc, &argv, &opts);
 			if (fd < 0)
 				return -1;
 
@@ -629,12 +633,16 @@ static int do_show_subset(int argc, char **argv)
 	int nb_fds, i;
 	int err = -1;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	fds = malloc(sizeof(int));
 	if (!fds) {
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds, NULL);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, &opts);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -673,6 +681,10 @@ static int do_show(int argc, char **argv)
 	int err;
 	int fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (show_pinned) {
 		map_table = hashmap__new(hash_fn_for_key_as_id,
 					 equal_fn_for_key_as_id, NULL);
@@ -702,7 +714,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_map_get_fd_by_id_opts(id, NULL);
+		fd = bpf_map_get_fd_by_id_opts(id, &opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
@@ -902,6 +914,10 @@ static int do_dump(int argc, char **argv)
 	int *fds = NULL;
 	int err = -1;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (argc != 2)
 		usage();
 
@@ -910,7 +926,7 @@ static int do_dump(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds, NULL);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, &opts);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -995,10 +1011,14 @@ static int do_update(int argc, char **argv)
 	void *key, *value;
 	int fd, err;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_WRONLY,
+	);
+
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, &opts);
 	if (fd < 0)
 		return -1;
 
@@ -1074,10 +1094,14 @@ static int do_lookup(int argc, char **argv)
 	int err;
 	int fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, &opts);
 	if (fd < 0)
 		return -1;
 
@@ -1125,10 +1149,14 @@ static int do_getnext(int argc, char **argv)
 	int err;
 	int fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, &opts);
 	if (fd < 0)
 		return -1;
 
@@ -1196,10 +1224,14 @@ static int do_delete(int argc, char **argv)
 	int err;
 	int fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_WRONLY,
+	);
+
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, &opts);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index fa062db08c87..8bc513d6eb55 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -125,6 +125,10 @@ int do_event_pipe(int argc, char **argv)
 	};
 	struct bpf_map_info map_info = {};
 	LIBBPF_OPTS(perf_buffer_raw_opts, opts);
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, map_opts,
+		.flags = BPF_F_WRONLY,
+	);
+
 	struct event_pipe_ctx ctx = {
 		.all_cpus = true,
 		.cpu = -1,
@@ -136,7 +140,7 @@ int do_event_pipe(int argc, char **argv)
 
 	map_info_len = sizeof(map_info);
 	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
-				       NULL);
+				       &map_opts);
 	if (map_fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 648546342988..371a6510b2ed 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -227,6 +227,10 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 	int ret;
 	__u32 i;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	memset(&prog_info, 0, sizeof(prog_info));
 	prog_info_len = sizeof(prog_info);
 	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
@@ -251,7 +255,7 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 		goto free_map_ids;
 
 	for (i = 0; i < prog_info.nr_map_ids; i++) {
-		map_fd = bpf_map_get_fd_by_id_opts(map_ids[i], NULL);
+		map_fd = bpf_map_get_fd_by_id_opts(map_ids[i], &opts);
 		if (map_fd < 0)
 			goto free_map_ids;
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 51667db3f55f..5a93f14e2b6a 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -10,6 +10,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_internal.h> /* OPTS_GET */
 
 #include "json_writer.h"
 #include "main.h"
@@ -136,6 +137,10 @@ static int get_next_struct_ops_map(const char *name, int *res_fd,
 	__u32 id = info->id;
 	int err, fd;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, search_opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	while (true) {
 		err = bpf_map_get_next_id(id, &id);
 		if (err) {
@@ -145,7 +150,7 @@ static int get_next_struct_ops_map(const char *name, int *res_fd,
 			return -1;
 		}
 
-		fd = bpf_map_get_fd_by_id_opts(id, opts);
+		fd = bpf_map_get_fd_by_id_opts(id, &search_opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
@@ -163,6 +168,19 @@ static int get_next_struct_ops_map(const char *name, int *res_fd,
 
 		if (info->type == BPF_MAP_TYPE_STRUCT_OPS &&
 		    (!name || !strcmp(name, info->name))) {
+			if (OPTS_GET(opts, flags, 0) != BPF_F_RDONLY) {
+				close(fd);
+
+				fd = bpf_map_get_fd_by_id_opts(id, opts);
+				if (fd < 0) {
+					if (errno == ENOENT)
+						continue;
+					p_err("can't get map by id (%u): %s",
+					      id, strerror(errno));
+					return -1;
+				}
+			}
+
 			*res_fd = fd;
 			return 1;
 		}
@@ -340,6 +358,10 @@ static int do_show(int argc, char **argv)
 	const char *search_type = NULL, *search_term = NULL;
 	struct res res;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (argc && argc != 2)
 		usage();
 
@@ -349,7 +371,7 @@ static int do_show(int argc, char **argv)
 	}
 
 	res = do_work_on_struct_ops(search_type, search_term, __do_show,
-				    NULL, json_wtr, NULL);
+				    NULL, json_wtr, &opts);
 
 	return cmd_retval(&res, !!search_term);
 }
@@ -411,6 +433,10 @@ static int do_dump(int argc, char **argv)
 	struct btf_dumper d = {};
 	struct res res;
 
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts,
+		.flags = BPF_F_RDONLY,
+	);
+
 	if (argc && argc != 2)
 		usage();
 
@@ -438,7 +464,7 @@ static int do_dump(int argc, char **argv)
 	d.prog_id_as_func_ptr = true;
 
 	res = do_work_on_struct_ops(search_type, search_term, __do_dump, &d,
-				    wtr, NULL);
+				    wtr, &opts);
 
 	if (!json_output)
 		jsonw_destroy(&wtr);
-- 
2.25.1

