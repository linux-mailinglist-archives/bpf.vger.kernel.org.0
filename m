Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C157E554
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGVRVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiGVRVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEBF655B0
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:21:47 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGMT459Yz67MpP;
        Sat, 23 Jul 2022 01:17:09 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:21:44 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 11/15] bpftool: Add opts parameter to map_parse_fd_and_info()
Date:   Fri, 22 Jul 2022 19:18:32 +0200
Message-ID: <20220722171836.2852247-12-roberto.sassu@huawei.com>
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

Add the opts parameter to map_parse_fd_and_info(), as this function is
called directly by the functions implementing bpftool subcommands, so that
it is possible to specify the right permissions for accessing a map.

Still pass a NULL pointer as argument, and adjust permissions in a later
patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/btf.c           |  2 +-
 tools/bpf/bpftool/common.c        |  5 +++--
 tools/bpf/bpftool/main.h          |  3 ++-
 tools/bpf/bpftool/map.c           | 12 ++++++------
 tools/bpf/bpftool/map_perf_ring.c |  3 ++-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index ab7bf9f3cc27..c3059cb3196c 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -580,7 +580,7 @@ static int do_dump(int argc, char **argv)
 			return -1;
 		}
 
-		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+		fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 		if (fd < 0)
 			return -1;
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 913771fcf8ec..8a2412fc4410 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1017,12 +1017,13 @@ int map_parse_fd(int *argc, char ***argv, const struct bpf_get_fd_opts *opts)
 	return fd;
 }
 
-int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
+int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len,
+			  const struct bpf_get_fd_opts *opts)
 {
 	int err;
 	int fd;
 
-	fd = map_parse_fd(argc, argv, NULL);
+	fd = map_parse_fd(argc, argv, opts);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 13125171ac8a..6c35b2149a15 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -177,7 +177,8 @@ int map_parse_fd(int *argc, char ***argv,
 		 const struct bpf_get_fd_opts *opts);
 int map_parse_fds(int *argc, char ***argv, int **fds,
 		  const struct bpf_get_fd_opts *opts);
-int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
+int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len,
+			  const struct bpf_get_fd_opts *opts);
 
 struct bpf_prog_linfo;
 #ifdef HAVE_LIBBFD_SUPPORT
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index d921cb1a116d..bb94eb0dd9bf 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -998,7 +998,7 @@ static int do_update(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 	if (fd < 0)
 		return -1;
 
@@ -1077,7 +1077,7 @@ static int do_lookup(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 	if (fd < 0)
 		return -1;
 
@@ -1128,7 +1128,7 @@ static int do_getnext(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 	if (fd < 0)
 		return -1;
 
@@ -1199,7 +1199,7 @@ static int do_delete(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 	if (fd < 0)
 		return -1;
 
@@ -1311,7 +1311,7 @@ static int do_create(int argc, char **argv)
 			if (!REQ_ARGS(2))
 				usage();
 			inner_map_fd = map_parse_fd_and_info(&argc, &argv,
-							     &info, &len);
+							     &info, &len, NULL);
 			if (inner_map_fd < 0)
 				return -1;
 			attr.inner_map_fd = inner_map_fd;
@@ -1360,7 +1360,7 @@ static int do_pop_dequeue(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, NULL);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 6b0c410152de..fa062db08c87 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -135,7 +135,8 @@ int do_event_pipe(int argc, char **argv)
 	int err, map_fd;
 
 	map_info_len = sizeof(map_info);
-	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len);
+	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
+				       NULL);
 	if (map_fd < 0)
 		return -1;
 
-- 
2.25.1

