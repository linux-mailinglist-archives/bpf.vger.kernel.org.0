Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC7374E14
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEFDqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEFDqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA46BC061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i14so3793578pgk.5
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8VQDgK4bbf7SteTjRzzDgbvJmWKBWpnOCJuZw1upj8=;
        b=lmvfUBnxKBlKXy7BWkr66ymnhjRQicISMUmcMZ192NLeaebWYG1TEtjqk1d7y/6a19
         Y+dOhrHNwavsMoz5PENbK3j0a2aONh8rUmNANzLGRuZowW6FZrK2VTeV41PDTmWZMoxo
         p7o5sxXbNheFvoGK+TbOtTSqatnc6tZMtQC0lfeWIxHG2mqjPSsgbx+PnQr97KZqzANr
         eeF4Txv+zgEy4ZVAoVaz/GrGdnatrdjTOSoYKG+iDLlqdckj2RDzBymDAneCr1iT+fZD
         T2uBhBq23VZURg4irz4A5YNOqb60g4IgTFmvdCWlBERWgsTTzVCjMoep8zNOVzTtW5kX
         8d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8VQDgK4bbf7SteTjRzzDgbvJmWKBWpnOCJuZw1upj8=;
        b=b36fApdPC9EI5VKY9OkFSp4hbv19MvmE4Nurt147gR0WXgWqd5+ZmOgRHdDUEPQimw
         J0LlORvGgdF44m9BRmw/QsD/5tpF/fFFOyBw33quUnNVWQxfnYTzB02fZOehBDT78B6V
         UmF8auq9g7LkX/wKVetVS6YWHtK8+E9eyYeGyVbV1LN8/dcbNCirYWOS3GvMwouufisr
         rXQdGkUgsYshcij7ykmCXfzBscYg2lKUBzdoCigHzQ3gnKjT755tGd+vPXsOihjEitDN
         +MSjK7OvJuQhUuQ7YHm6K/lkGQsTGdhlmJJCRol3lRaJKwVDiH8Rul7EWTuTg1vgubmI
         Pp5g==
X-Gm-Message-State: AOAM530iNsdkrO3nIkRsyGt23dj6egOOocLQncGa+bGPqMHRc9HonOcK
        fU5vUBJQPbEIIcYJKGHvtiM=
X-Google-Smtp-Source: ABdhPJyaQWYpxV46FQybaW5bTHLuqTqAHviYB9CuOq7IfzVC0tH6R1W3sejvJoYRP+EcbfJTrdSeiw==
X-Received: by 2002:a63:10:: with SMTP id 16mr2199590pga.143.1620272720251;
        Wed, 05 May 2021 20:45:20 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:19 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 09/17] libbpf: Support for fd_idx
Date:   Wed,  5 May 2021 20:44:57 -0700
Message-Id: <20210506034505.25979-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add support for FD_IDX and make libbpf prefer that approach to loading programs
to make testing and bisection easy.
The next patch will fine tune libbpf behavior to use FEAT_FD_IDX only when
generating loader program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf.c             |  1 +
 tools/lib/bpf/libbpf.c          | 73 +++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf_internal.h |  1 +
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index bba48ff4c5c0..b96a3aba6fcc 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -252,6 +252,7 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 
 	attr.prog_btf_fd = load_attr->prog_btf_fd;
 	attr.prog_flags = load_attr->prog_flags;
+	attr.fd_array = ptr_to_u64(load_attr->fd_array);
 
 	attr.func_info_rec_size = load_attr->func_info_rec_size;
 	attr.func_info_cnt = load_attr->func_info_cnt;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5790166eee9b..371ea3b0cb59 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -175,6 +175,8 @@ enum kern_feature_id {
 	FEAT_MODULE_BTF,
 	/* BTF_KIND_FLOAT support */
 	FEAT_BTF_FLOAT,
+	/* Kernel support for FD_IDX */
+	FEAT_FD_IDX,
 	__FEAT_CNT,
 };
 
@@ -288,6 +290,7 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+	int *fd_array;
 };
 
 struct bpf_struct_ops {
@@ -4238,6 +4241,29 @@ static int probe_module_btf(void)
 	return !err;
 }
 
+static int probe_kern_fd_idx(void)
+{
+	struct bpf_load_program_attr attr;
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_0, BPF_PSEUDO_MAP_IDX, 0),
+		BPF_EXIT_INSN(),
+	};
+	int err;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr.insns = insns;
+	attr.insns_cnt = ARRAY_SIZE(insns);
+	attr.license = "GPL";
+
+	err = bpf_load_program_xattr(&attr, NULL, 0);
+	if (err >= 0) {
+		close(err);
+		return 0;
+	}
+	return errno == EPROTO;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -4288,6 +4314,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_FLOAT] = {
 		"BTF_KIND_FLOAT support", probe_kern_btf_float,
 	},
+	[FEAT_FD_IDX] = {
+		"prog_load with fd_idx", probe_kern_fd_idx,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
@@ -6368,19 +6397,34 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 
 		switch (relo->type) {
 		case RELO_LD64:
-			insn[0].src_reg = BPF_PSEUDO_MAP_FD;
-			insn[0].imm = obj->maps[relo->map_idx].fd;
+			if (kernel_supports(FEAT_FD_IDX)) {
+				insn[0].src_reg = BPF_PSEUDO_MAP_IDX;
+				insn[0].imm = relo->map_idx;
+			} else {
+				insn[0].src_reg = BPF_PSEUDO_MAP_FD;
+				insn[0].imm = obj->maps[relo->map_idx].fd;
+			}
 			break;
 		case RELO_DATA:
-			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
 			insn[1].imm = insn[0].imm + relo->sym_off;
-			insn[0].imm = obj->maps[relo->map_idx].fd;
+			if (kernel_supports(FEAT_FD_IDX)) {
+				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
+				insn[0].imm = relo->map_idx;
+			} else {
+				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+				insn[0].imm = obj->maps[relo->map_idx].fd;
+			}
 			break;
 		case RELO_EXTERN_VAR:
 			ext = &obj->externs[relo->sym_off];
 			if (ext->type == EXT_KCFG) {
-				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
-				insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+				if (kernel_supports(FEAT_FD_IDX)) {
+					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
+					insn[0].imm = obj->kconfig_map_idx;
+				} else {
+					insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+					insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+				}
 				insn[1].imm = ext->kcfg.data_off;
 			} else /* EXT_KSYM */ {
 				if (ext->ksym.type_id) { /* typed ksyms */
@@ -7106,6 +7150,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.fd_array = prog->fd_array;
 
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd = bpf_object__btf_fd(prog->obj);
@@ -7296,6 +7341,7 @@ static int
 bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
 	struct bpf_program *prog;
+	int *fd_array = NULL;
 	size_t i;
 	int err;
 
@@ -7306,6 +7352,14 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			return err;
 	}
 
+	if (kernel_supports(FEAT_FD_IDX) && obj->nr_maps) {
+		fd_array = malloc(sizeof(int) * obj->nr_maps);
+		if (!fd_array)
+			return -ENOMEM;
+		for (i = 0; i < obj->nr_maps; i++)
+			fd_array[i] = obj->maps[i].fd;
+	}
+
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
@@ -7315,10 +7369,15 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			continue;
 		}
 		prog->log_level |= log_level;
+		prog->fd_array = fd_array;
 		err = bpf_program__load(prog, obj->license, obj->kern_version);
-		if (err)
+		prog->fd_array = NULL;
+		if (err) {
+			free(fd_array);
 			return err;
+		}
 	}
+	free(fd_array);
 	return 0;
 }
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ee426226928f..2d4f4a995f35 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -249,6 +249,7 @@ struct bpf_prog_load_params {
 	__u32 log_level;
 	char *log_buf;
 	size_t log_buf_sz;
+	int *fd_array;
 };
 
 int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr);
-- 
2.30.2

