Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6D57E555
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiGVRVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiGVRVt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88A65D64
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:21:48 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGQf5Ygrz67DRW;
        Sat, 23 Jul 2022 01:19:54 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:21:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 12/15] bpftool: Add opts parameter in struct_ops functions
Date:   Fri, 22 Jul 2022 19:18:33 +0200
Message-ID: <20220722171836.2852247-13-roberto.sassu@huawei.com>
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

Propagate the opts parameter to struct_ops functions, so that the
appropriate permissions can be requested for each operation of the
struct_ops subcommand.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/struct_ops.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index e08a6ff2866c..51667db3f55f 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -130,7 +130,8 @@ static struct bpf_map_info *map_info_alloc(__u32 *alloc_len)
  *    -1: Error and the caller should abort the iteration.
  */
 static int get_next_struct_ops_map(const char *name, int *res_fd,
-				   struct bpf_map_info *info, __u32 info_len)
+				   struct bpf_map_info *info, __u32 info_len,
+				   const struct bpf_get_fd_opts *opts)
 {
 	__u32 id = info->id;
 	int err, fd;
@@ -144,7 +145,7 @@ static int get_next_struct_ops_map(const char *name, int *res_fd,
 			return -1;
 		}
 
-		fd = bpf_map_get_fd_by_id(id);
+		fd = bpf_map_get_fd_by_id_opts(id, opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
@@ -186,7 +187,8 @@ typedef int (*work_func)(int fd, const struct bpf_map_info *info, void *data,
  * Then call "func(fd, info, data, wtr)" on each struct_ops map found.
  */
 static struct res do_search(const char *name, work_func func, void *data,
-			    struct json_writer *wtr)
+			    struct json_writer *wtr,
+			    const struct bpf_get_fd_opts *opts)
 {
 	struct bpf_map_info *info;
 	struct res res = {};
@@ -201,7 +203,8 @@ static struct res do_search(const char *name, work_func func, void *data,
 
 	if (wtr)
 		jsonw_start_array(wtr);
-	while ((err = get_next_struct_ops_map(name, &fd, info, info_len)) == 1) {
+	while ((err = get_next_struct_ops_map(name, &fd, info, info_len,
+					      opts)) == 1) {
 		res.nr_maps++;
 		err = func(fd, info, data, wtr);
 		if (err)
@@ -235,7 +238,8 @@ static struct res do_search(const char *name, work_func func, void *data,
 }
 
 static struct res do_one_id(const char *id_str, work_func func, void *data,
-			    struct json_writer *wtr)
+			    struct json_writer *wtr,
+			    const struct bpf_get_fd_opts *opts)
 {
 	struct bpf_map_info *info;
 	struct res res = {};
@@ -251,7 +255,7 @@ static struct res do_one_id(const char *id_str, work_func func, void *data,
 		return res;
 	}
 
-	fd = bpf_map_get_fd_by_id(id);
+	fd = bpf_map_get_fd_by_id_opts(id, opts);
 	if (fd < 0) {
 		p_err("can't get map by id (%lu): %s", id, strerror(errno));
 		res.nr_errs++;
@@ -300,16 +304,17 @@ static struct res do_one_id(const char *id_str, work_func func, void *data,
 static struct res do_work_on_struct_ops(const char *search_type,
 					const char *search_term,
 					work_func func, void *data,
-					struct json_writer *wtr)
+					struct json_writer *wtr,
+					const struct bpf_get_fd_opts *opts)
 {
 	if (search_type) {
 		if (is_prefix(search_type, "id"))
-			return do_one_id(search_term, func, data, wtr);
+			return do_one_id(search_term, func, data, wtr, opts);
 		else if (!is_prefix(search_type, "name"))
 			usage();
 	}
 
-	return do_search(search_term, func, data, wtr);
+	return do_search(search_term, func, data, wtr, opts);
 }
 
 static int __do_show(int fd, const struct bpf_map_info *info, void *data,
@@ -344,7 +349,7 @@ static int do_show(int argc, char **argv)
 	}
 
 	res = do_work_on_struct_ops(search_type, search_term, __do_show,
-				    NULL, json_wtr);
+				    NULL, json_wtr, NULL);
 
 	return cmd_retval(&res, !!search_term);
 }
@@ -433,7 +438,7 @@ static int do_dump(int argc, char **argv)
 	d.prog_id_as_func_ptr = true;
 
 	res = do_work_on_struct_ops(search_type, search_term, __do_dump, &d,
-				    wtr);
+				    wtr, NULL);
 
 	if (!json_output)
 		jsonw_destroy(&wtr);
@@ -472,7 +477,7 @@ static int do_unregister(int argc, char **argv)
 	search_term = GET_ARG();
 
 	res = do_work_on_struct_ops(search_type, search_term,
-				    __do_unregister, NULL, NULL);
+				    __do_unregister, NULL, NULL, NULL);
 
 	return cmd_retval(&res, true);
 }
-- 
2.25.1

