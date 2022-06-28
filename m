Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26D55EB41
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiF1Rnk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiF1Rnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE638B7
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:33 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gb12-20020a17090b060c00b001ec795458edso4875365pjb.0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A+javj1QwqDUhp1AslAqnYRqnwIz559irWdcreoSAmk=;
        b=goKVV6HIqr24yhxxHgDFaw54yMf7bIJUZ/I8NmtwIKYsir6C4k+k+mrcj6ehPNr7m6
         LQmkfEYeWJIAfn3wUGXRE+ZS/pn+GnFKWm7FFcd9DfkTpMZDUy6uMKC4TFSFb18tccJ1
         7UNHxeUNt0lLQdQhdM0b1aT6Em/vYaOUioYi14ciHJ3skjjjFzoiTTQmc/QXd5CGlyGg
         M8OXSo8yJc7NaYjZAx9c7FyokZRSNIldHK8uVNHlioSLEkRz6nyCqH3QXdISwumRAVUE
         EJIJ8kr6Y9+ajQ9pjwwN0o7MfiKNR0vgd5aXyfObUiEWG0nQxXXBjvdFLTqHptwUxoXb
         gwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A+javj1QwqDUhp1AslAqnYRqnwIz559irWdcreoSAmk=;
        b=AzsLb3WZvLiNqLRrTLKVdCtxWmG39c6Yci1iNyzCrZq3pNuCmAiyoZB4uOc9/B3urB
         UamrcJSON1/s1OSGORpwvZO53OiN0sYc0p+AhdsfFjYxbnIEYN48uxiDXwpmrDGE8YJT
         bviOn2/HnUHQbFQlozUiEbFaB9Khjz2+GAlV2Y0cJnz+vU+b1jy4l8LFTUkbixUqolTr
         L01fF2cNS1vK6GHJpSEN3sVNn6HWNSz8J91ucrUjJPCQ2yVe1OsTMP3Ls06wcE37Sfol
         zakSRV26PNrce6TAsUNJT7QGTJUpb8t5MG7VXwjNaN1DRY/GKeSd5jSz836e39ZARzE0
         4jIQ==
X-Gm-Message-State: AJIora+qu8dr7pe7n6hyITVhXyw6/VLJhB/o1F805YKA/nxE57TS+uwg
        L5YMrk85HEfQPT9Vgsi3cYQkf9MBGUnI/GtWGxgUdK8w2TeiD9dwvDSs/IXlhHzmxEC1ddH7lKa
        IuGZUDVO1lLgUQ7mb9QOZtO4o35JYoHPqA/dbL9umzELdO3pmqg==
X-Google-Smtp-Source: AGRyM1s0FFLYoj1LwUCcDDwSfy8ZUHsm9CaIFzyTB5ayvSdcMamkx+Yyna1+4akZ7GIgCHMStOt80CE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:3685:b0:1ec:f6f4:8a64 with SMTP id
 mj5-20020a17090b368500b001ecf6f48a64mr804160pjb.199.1656438212940; Tue, 28
 Jun 2022 10:43:32 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:13 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-11-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 10/11] bpftool: implement cgroup tree for BPF_LSM_CGROUP
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

$ bpftool --nomount prog loadall $KDIR/tools/testing/selftests/bpf/lsm_cgroup.o /sys/fs/bpf/x
$ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_alloc
$ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_bind
$ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_clone
$ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
$ bpftool cgroup tree
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
6        lsm_cgroup                      socket_post_create bpf_lsm_socket_post_create
8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone

$ bpftool cgroup detach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
$ bpftool cgroup tree
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/cgroup.c | 109 +++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 42421fe47a58..cced668fb2a3 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 
 #include "main.h"
 
@@ -36,6 +37,8 @@
 	"                        cgroup_inet_sock_release }"
 
 static unsigned int query_flags;
+static struct btf *btf_vmlinux;
+static __u32 btf_vmlinux_id;
 
 static enum bpf_attach_type parse_attach_type(const char *str)
 {
@@ -64,11 +67,38 @@ static enum bpf_attach_type parse_attach_type(const char *str)
 	return __MAX_BPF_ATTACH_TYPE;
 }
 
+static void guess_vmlinux_btf_id(__u32 attach_btf_obj_id)
+{
+	struct bpf_btf_info btf_info = {};
+	__u32 btf_len = sizeof(btf_info);
+	char name[16] = {};
+	int err;
+	int fd;
+
+	btf_info.name = ptr_to_u64(name);
+	btf_info.name_len = sizeof(name);
+
+	fd = bpf_btf_get_fd_by_id(attach_btf_obj_id);
+	if (fd < 0)
+		return;
+
+	err = bpf_obj_get_info_by_fd(fd, &btf_info, &btf_len);
+	if (err)
+		goto out;
+
+	if (btf_info.kernel_btf && strncmp(name, "vmlinux", sizeof(name)) == 0)
+		btf_vmlinux_id = btf_info.id;
+
+out:
+	close(fd);
+}
+
 static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 			 const char *attach_flags_str,
 			 int level)
 {
 	char prog_name[MAX_PROG_FULL_NAME];
+	const char *attach_btf_name = NULL;
 	struct bpf_prog_info info = {};
 	const char *attach_type_str;
 	__u32 info_len = sizeof(info);
@@ -84,6 +114,20 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 	}
 
 	attach_type_str = libbpf_bpf_attach_type_str(attach_type);
+
+	if (btf_vmlinux) {
+		if (!btf_vmlinux_id)
+			guess_vmlinux_btf_id(info.attach_btf_obj_id);
+
+		if (btf_vmlinux_id == info.attach_btf_obj_id &&
+		    info.attach_btf_id < btf__type_cnt(btf_vmlinux)) {
+			const struct btf_type *t =
+				btf__type_by_id(btf_vmlinux, info.attach_btf_id);
+			attach_btf_name =
+				btf__name_by_offset(btf_vmlinux, t->name_off);
+		}
+	}
+
 	get_prog_full_name(&info, prog_fd, prog_name, sizeof(prog_name));
 	if (json_output) {
 		jsonw_start_object(json_wtr);
@@ -95,6 +139,10 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		jsonw_string_field(json_wtr, "attach_flags",
 				   attach_flags_str);
 		jsonw_string_field(json_wtr, "name", prog_name);
+		if (attach_btf_name)
+			jsonw_string_field(json_wtr, "attach_btf_name", attach_btf_name);
+		jsonw_uint_field(json_wtr, "attach_btf_obj_id", info.attach_btf_obj_id);
+		jsonw_uint_field(json_wtr, "attach_btf_id", info.attach_btf_id);
 		jsonw_end_object(json_wtr);
 	} else {
 		printf("%s%-8u ", level ? "    " : "", info.id);
@@ -102,7 +150,13 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 			printf("%-15s", attach_type_str);
 		else
 			printf("type %-10u", attach_type);
-		printf(" %-15s %-15s\n", attach_flags_str, prog_name);
+		printf(" %-15s %-15s", attach_flags_str, prog_name);
+		if (attach_btf_name)
+			printf(" %-15s", attach_btf_name);
+		else if (info.attach_btf_id)
+			printf(" attach_btf_obj_id=%d attach_btf_id=%d",
+			       info.attach_btf_obj_id, info.attach_btf_id);
+		printf("\n");
 	}
 
 	close(prog_fd);
@@ -144,40 +198,49 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 				   int level)
 {
+	LIBBPF_OPTS(bpf_prog_query_opts, p);
+	__u32 prog_attach_flags[1024] = {0};
 	const char *attach_flags_str;
 	__u32 prog_ids[1024] = {0};
-	__u32 prog_cnt, iter;
-	__u32 attach_flags;
 	char buf[32];
+	__u32 iter;
 	int ret;
 
-	prog_cnt = ARRAY_SIZE(prog_ids);
-	ret = bpf_prog_query(cgroup_fd, type, query_flags, &attach_flags,
-			     prog_ids, &prog_cnt);
+	p.query_flags = query_flags;
+	p.prog_cnt = ARRAY_SIZE(prog_ids);
+	p.prog_ids = prog_ids;
+	p.prog_attach_flags = prog_attach_flags;
+
+	ret = bpf_prog_query_opts(cgroup_fd, type, &p);
 	if (ret)
 		return ret;
 
-	if (prog_cnt == 0)
+	if (p.prog_cnt == 0)
 		return 0;
 
-	switch (attach_flags) {
-	case BPF_F_ALLOW_MULTI:
-		attach_flags_str = "multi";
-		break;
-	case BPF_F_ALLOW_OVERRIDE:
-		attach_flags_str = "override";
-		break;
-	case 0:
-		attach_flags_str = "";
-		break;
-	default:
-		snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
-		attach_flags_str = buf;
-	}
+	for (iter = 0; iter < p.prog_cnt; iter++) {
+		__u32 attach_flags;
+
+		attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
+
+		switch (attach_flags) {
+		case BPF_F_ALLOW_MULTI:
+			attach_flags_str = "multi";
+			break;
+		case BPF_F_ALLOW_OVERRIDE:
+			attach_flags_str = "override";
+			break;
+		case 0:
+			attach_flags_str = "";
+			break;
+		default:
+			snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
+			attach_flags_str = buf;
+		}
 
-	for (iter = 0; iter < prog_cnt; iter++)
 		show_bpf_prog(prog_ids[iter], type,
 			      attach_flags_str, level);
+	}
 
 	return 0;
 }
@@ -233,6 +296,7 @@ static int do_show(int argc, char **argv)
 		printf("%-8s %-15s %-15s %-15s\n", "ID", "AttachType",
 		       "AttachFlags", "Name");
 
+	btf_vmlinux = libbpf_find_kernel_btf();
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
 		/*
 		 * Not all attach types may be supported, so it's expected,
@@ -296,6 +360,7 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 		printf("%s\n", fpath);
 	}
 
+	btf_vmlinux = libbpf_find_kernel_btf();
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
 		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

