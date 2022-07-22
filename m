Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697257E556
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiGVRVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiGVRVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F651655B0
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:21:49 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGNk14Wtz67MfC;
        Sat, 23 Jul 2022 01:18:14 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:21:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 13/15] bpftool: Complete switch to bpf_*_get_fd_by_id_opts()
Date:   Fri, 22 Jul 2022 19:18:34 +0200
Message-ID: <20220722171836.2852247-14-roberto.sassu@huawei.com>
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

Complete the switch to the new functions bpf_*_get_fd_by_id_opts(),
accepting the additional opts parameter.

The value passed to these functions is always NULL, so that there is no
variation in the behavior.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/btf.c        | 8 ++++----
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/cgroup.c     | 4 ++--
 tools/bpf/bpftool/link.c       | 4 ++--
 tools/bpf/bpftool/map.c        | 2 +-
 tools/bpf/bpftool/prog.c       | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c3059cb3196c..2cbc777f1520 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -536,7 +536,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 	__u32 len;
 	int err;
 
-	btf_fd = bpf_btf_get_fd_by_id(btf_id);
+	btf_fd = bpf_btf_get_fd_by_id_opts(btf_id, NULL);
 	if (btf_fd < 0) {
 		p_err("can't get BTF object by id (%u): %s", btf_id, strerror(errno));
 		return false;
@@ -779,10 +779,10 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 
 		switch (type) {
 		case BPF_OBJ_PROG:
-			fd = bpf_prog_get_fd_by_id(id);
+			fd = bpf_prog_get_fd_by_id_opts(id, NULL);
 			break;
 		case BPF_OBJ_MAP:
-			fd = bpf_map_get_fd_by_id(id);
+			fd = bpf_map_get_fd_by_id_opts(id, NULL);
 			break;
 		default:
 			err = -1;
@@ -1037,7 +1037,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_btf_get_fd_by_id(id);
+		fd = bpf_btf_get_fd_by_id_opts(id, NULL);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 125798b0bc5d..8acc100c3093 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -53,7 +53,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 		goto print;
 
 	/* Get the bpf_prog's name.  Obtain from func_info. */
-	prog_fd = bpf_prog_get_fd_by_id(prog_id);
+	prog_fd = bpf_prog_get_fd_by_id_opts(prog_id, NULL);
 	if (prog_fd < 0)
 		goto print;
 
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index cc007ddc945b..ce8cf97c190f 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -78,7 +78,7 @@ static void guess_vmlinux_btf_id(__u32 attach_btf_obj_id)
 	btf_info.name = ptr_to_u64(name);
 	btf_info.name_len = sizeof(name);
 
-	fd = bpf_btf_get_fd_by_id(attach_btf_obj_id);
+	fd = bpf_btf_get_fd_by_id_opts(attach_btf_obj_id, NULL);
 	if (fd < 0)
 		return;
 
@@ -104,7 +104,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 	__u32 info_len = sizeof(info);
 	int prog_fd;
 
-	prog_fd = bpf_prog_get_fd_by_id(id);
+	prog_fd = bpf_prog_get_fd_by_id_opts(id, NULL);
 	if (prog_fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index b319f9769d90..9851c89f5798 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -99,7 +99,7 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 	__u32 len = sizeof(*info);
 	int err, prog_fd;
 
-	prog_fd = bpf_prog_get_fd_by_id(prog_id);
+	prog_fd = bpf_prog_get_fd_by_id_opts(prog_id, NULL);
 	if (prog_fd < 0)
 		return prog_fd;
 
@@ -343,7 +343,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_link_get_fd_by_id(id);
+		fd = bpf_link_get_fd_by_id_opts(id, NULL);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index bb94eb0dd9bf..103bd44cd851 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -702,7 +702,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_map_get_fd_by_id(id);
+		fd = bpf_map_get_fd_by_id_opts(id, NULL);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e37af694152e..648546342988 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -251,7 +251,7 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 		goto free_map_ids;
 
 	for (i = 0; i < prog_info.nr_map_ids; i++) {
-		map_fd = bpf_map_get_fd_by_id(map_ids[i]);
+		map_fd = bpf_map_get_fd_by_id_opts(map_ids[i], NULL);
 		if (map_fd < 0)
 			goto free_map_ids;
 
@@ -666,7 +666,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_prog_get_fd_by_id(id);
+		fd = bpf_prog_get_fd_by_id_opts(id, NULL);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
-- 
2.25.1

