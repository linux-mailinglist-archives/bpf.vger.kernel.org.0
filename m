Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55BF6157A7
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 03:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKBCgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 22:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiKBCgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 22:36:09 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347AE0B6;
        Tue,  1 Nov 2022 19:36:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VTlT0PP_1667356551;
Received: from VM20210331-5.tbsite.net(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VTlT0PP_1667356551)
          by smtp.aliyun-inc.com;
          Wed, 02 Nov 2022 10:36:04 +0800
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
Subject: [RESEND PATCH] bpftool: Support use full prog name in prog subcommand
Date:   Wed,  2 Nov 2022 10:35:49 +0800
Message-Id: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
X-Mailer: git-send-email 2.2.1
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
 tools/bpf/bpftool/common.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 8727765..5d61f26 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -720,6 +720,40 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
 
+static bool is_invalid_name(char *nametag, struct bpf_prog_info *info,
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
 	char prog_name[MAX_PROG_FULL_NAME];
@@ -730,6 +764,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 
 	while (true) {
 		struct bpf_prog_info info = {};
+		struct bpf_func_info finfo = {};
 		__u32 len = sizeof(info);
 
 		err = bpf_prog_get_next_id(id, &id);
@@ -748,6 +783,10 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fds;
 		}
 
+		info.nr_func_info = 1;
+		info.func_info_rec_size = sizeof(finfo);
+		info.func_info = ptr_to_u64(&finfo);
+
 		err = bpf_obj_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get prog info (%u): %s",
@@ -755,7 +794,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fd;
 		}
 
-		if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
+		if (is_invalid_name(nametag, &info, &finfo, tag)) {
 			close(fd);
 			continue;
 		}
@@ -829,10 +868,6 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		NEXT_ARGP();
 
 		name = **argv;
-		if (strlen(name) > MAX_PROG_FULL_NAME - 1) {
-			p_err("can't parse name");
-			return -1;
-		}
 		NEXT_ARGP();
 
 		return prog_fd_by_nametag(name, fds, false);
-- 
2.2.1

