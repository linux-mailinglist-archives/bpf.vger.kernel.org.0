Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75A614CC8
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 15:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKAOjF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAOjE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:04 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA57120B8;
        Tue,  1 Nov 2022 07:39:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VTjllex_1667313533;
Received: from VM20210331-5.tbsite.net(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VTjllex_1667313533)
          by smtp.aliyun-inc.com;
          Tue, 01 Nov 2022 22:39:00 +0800
From:   Tao Chen <chentao.kernel@linux.alibaba.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tao Chen <chentao.kernel@linux.alibaba.com>
Subject: [PATCH] bpftool: Support use full prog name in prog subcommand
Date:   Tue,  1 Nov 2022 22:38:33 +0800
Message-Id: <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
References: <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
program names") supported show the full prog name, we can also use
the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
subcommand, such as "bpftool prog show name PROG_NAME".

Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
---
 tools/bpf/bpftool/common.c | 48 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 067e9ea..5efdedc 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -720,6 +720,40 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
 
+static bool is_invalid_prog(char *nametag, struct bpf_prog_info *info,
+				struct bpf_func_info *finfo, bool tag)
+{
+	const struct btf *prog_btf;
+	const struct btf_type *func_type;
+	const char *name;
+
+	if (tag)
+		return memcmp(nametag, info->tag, BPF_TAG_SIZE);
+
+	if (strlen(nametag) < BPF_OBJ_NAME_LEN)
+		return strncmp(nametag, info->name, BPF_OBJ_NAME_LEN);
+
+	prog_btf = btf__load_from_kernel_by_id(info->btf_id);
+	if (!prog_btf) {
+		p_err("get prog btf failed, btf_id:%u\n", info->btf_id);
+		return true;
+	}
+
+	func_type = btf__type_by_id(prog_btf, finfo->type_id);
+	if (!func_type || !btf_is_func(func_type)) {
+		p_err("func type invalid, type_id:%u\n", finfo->type_id);
+		return true;
+	}
+
+	name = btf__name_by_offset(prog_btf, func_type->name_off);
+	if (!name) {
+		p_err("func name invalid, name_off:%u\n", func_type->name_off);
+		return true;
+	}
+
+	return strncmp(nametag, name, strlen(name));
+}
+
 static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 {
 	unsigned int id = 0;
@@ -729,6 +763,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 
 	while (true) {
 		struct bpf_prog_info info = {};
+		struct bpf_func_info finfo = {};
 		__u32 len = sizeof(info);
 
 		err = bpf_prog_get_next_id(id, &id);
@@ -747,15 +782,17 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fds;
 		}
 
+		info.nr_func_info = 1;
+		info.func_info_rec_size = sizeof(finfo);
+		info.func_info = ptr_to_u64(&finfo);
+
 		err = bpf_obj_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get prog info (%u): %s",
 			      id, strerror(errno));
 			goto err_close_fd;
 		}
-
-		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
-		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
+		if (is_invalid_prog(nametag, &info, &finfo, tag)) {
 			close(fd);
 			continue;
 		}
@@ -818,12 +855,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		char *name;
 
 		NEXT_ARGP();
-
 		name = **argv;
-		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
-			p_err("can't parse name");
-			return -1;
-		}
 		NEXT_ARGP();
 
 		return prog_fd_by_nametag(name, fds, false);
-- 
2.2.1

