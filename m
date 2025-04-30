Return-Path: <bpf+bounces-57070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF77AA51F1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BF14A16A8
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FEC26462A;
	Wed, 30 Apr 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZbMJvq7M"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8B2620E8
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031631; cv=none; b=YL/gejA/9iCJrzxuD9Ou6hoHoqfpDTmT/COz9wvlXv/GgYQHbIGKzQRKoNwpI1kA/v84VV6pMgZ8zPQgunVI2pJhxk+sUxJJ5OCagJwQKAY631Kag3ZfuyokmPjnXuV/GsJsANLu1x58+5q/7XEn5zlYByJONOzxNBTfQOpswoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031631; c=relaxed/simple;
	bh=cZBrAbeX5IT6YCCfasFvUYVkaCKs3khXkqTan3lrTb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/Jj+wozHBx/Qsj8v9Z1avGG9xM1j/fPjAf0NwfltIDVO+WUNxOYt+tC+LfSggiUgF5DleXwuieroGzD715ehhIFrrjaD3jaTRPr8iOCbr/Yfrf6L3z8wV7LStHNGPFaBKthVrqT6OsSqw+Sqa1gGPT4Ice9m9DPbCjcfNNE9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZbMJvq7M; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746031626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvDxFe99tlP67W9rJgqWgbLX4neeNVtGZon90RdKFIc=;
	b=ZbMJvq7MrNufKBtpXGIdWfjZD9z/b619WpdYi0gmr081ARrX13VtRJVZcFkXmcvrnZi8Z1
	DPS6P4rqq+ARW/PmoBHXTbLKRsdzy/93pVxv3M7h70An1Cr5PUkmsKtbD/EQdMDcO8IHlo
	82jSnavdI8DofvoG+qIk7rIJvnIbD7I=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [RFC PATCH bpf-next 1/2] libbpf: Try get fentry func addr from available_filter_functions_addr
Date: Thu,  1 May 2025 00:46:07 +0800
Message-Id: <20250430164608.3790552-2-chen.dylane@linux.dev>
In-Reply-To: <20250430164608.3790552-1-chen.dylane@linux.dev>
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Try to get the real kernel func addr from available_filter_functions_addr,
in case of the function name is optimized by the compiler and a suffix
such as ".isra.0" is added, which will be used in the next patch.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/bpf.c            |  1 +
 tools/lib/bpf/bpf.h            |  1 +
 tools/lib/bpf/gen_loader.c     |  1 +
 tools/lib/bpf/libbpf.c         | 53 ++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 07ee73cdf9..7016e47a70 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1577,6 +1577,7 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		__aligned_u64	fentry_func;
 		/* The fd_array_cnt can be used to pass the length of the
 		 * fd_array array. In this case all the [map] file descriptors
 		 * passed in this array will be bound to the program, even if
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f..639a6b54e8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -312,6 +312,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
+	attr.fentry_func = OPTS_GET(opts, fentry_func, 0);
 
 	if (log_level) {
 		attr.log_buf = ptr_to_u64(log_buf);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d..b3340bcf7b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -83,6 +83,7 @@ struct bpf_prog_load_opts {
 	__u32 attach_btf_id;
 	__u32 attach_prog_fd;
 	__u32 attach_btf_obj_fd;
+	__u64 fentry_func;
 
 	const int *fd_array;
 
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 113ae4abd3..d90874b746 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1023,6 +1023,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	attr.kern_version = 0;
 	attr.insn_cnt = tgt_endian((__u32)insn_cnt);
 	attr.prog_flags = tgt_endian(load_attr->prog_flags);
+	attr.fentry_func = tgt_endian(load_attr->fentry_func);
 
 	attr.func_info_rec_size = tgt_endian(load_attr->func_info_rec_size);
 	attr.func_info_cnt = tgt_endian(load_attr->func_info_cnt);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 37d563e140..624e75cf2f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7456,6 +7456,50 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 }
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
+static const char *tracefs_available_filter_functions_addrs(void);
+
+static void try_get_fentry_func_addr(const char *func_name, struct bpf_prog_load_opts *load_attr)
+{
+	const char *available_functions_file = tracefs_available_filter_functions_addrs();
+	char sym_name[500];
+	FILE *f;
+	char *suffix;
+	int ret;
+	unsigned long long sym_addr;
+
+	f = fopen(available_functions_file, "re");
+	if (!f) {
+		pr_warn("failed to open %s: %s\n", available_functions_file, errstr(errno));
+		return;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%llx %499s%*[^\n]\n", &sym_addr, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+
+		if (ret != 2) {
+			pr_warn("failed to parse available_filter_functions_addrs entry: %d\n",
+				ret);
+			goto cleanup;
+		}
+
+		if (strcmp(func_name, sym_name) == 0) {
+			load_attr->fentry_func = sym_addr;
+			break;
+		}
+		/* find [func_name] optimized by compiler like [func_name].isra.0 */
+		suffix = strstr(sym_name, ".");
+		if (suffix && strncmp(sym_name, func_name,
+					strlen(sym_name) - strlen(suffix)) == 0) {
+			load_attr->fentry_func = sym_addr;
+			break;
+		}
+	}
+
+cleanup:
+	fclose(f);
+}
 
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
@@ -7504,6 +7548,15 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.prog_ifindex = prog->prog_ifindex;
 	load_attr.expected_attach_type = prog->expected_attach_type;
 
+	if (load_attr.expected_attach_type == BPF_TRACE_FENTRY ||
+		load_attr.expected_attach_type == BPF_TRACE_FEXIT) {
+		const char *func_name;
+
+		func_name = strchr(prog->sec_name, '/');
+		if (func_name)
+			try_get_fentry_func_addr(++func_name, &load_attr);
+	}
+
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd = btf__fd(obj->btf);
-- 
2.43.0


