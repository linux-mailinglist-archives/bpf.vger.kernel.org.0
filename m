Return-Path: <bpf+bounces-52199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15AA3FBCB
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E81E443151
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099DB215F6B;
	Fri, 21 Feb 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDCLDEcF"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CD20F08F
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155794; cv=none; b=G3H/gv2EvYa4t8oZTvVKUCboCoYJmC53jRDAgezM1UQnxcOglf0PGdlwq+xaTcK0Q6sIhB1n43p0t7dQduIS/Co9vXPScFkoap4QdnfKpuqQBOgIOCCksryHuHUsEmQHUzzui/myQSnH53/fEN2f4kEWzJqZvWApj6v+xza9KVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155794; c=relaxed/simple;
	bh=pWXtRo6gHo4DEJYISY33x6GfcFgrTWBD7e3ZWdUBELE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqj+yOsD2G9UJ2zbVgNZZKDA0u3CRJh13ETlLD9csXHMm1230ZQ3Qahg6OrtjSswtUxuc7pQzCvT2poqav/3TnivYzq2/yWFwbhekDZsI9js2SFzMdFlm4onWJOSz8M3GhUmDYeoMqG6qK/4Sg8Ki0U9SXVgLc38zKoR/eKw3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDCLDEcF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740155789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vB83pcYOlAu6TvcgZccjSdqVZZ3UtGjDlwpT4jeGmb0=;
	b=kDCLDEcFzNmdb93Nm5TYmHvhLUoeyk70BPC12DJ75fHQSkmqpW/CvtrD0z0NTJBcSAKB+m
	GG72WyeMITRgC0dTq3RnT14bobqFvGdZe6N5jophG4izfinGCV9hs74j7+A9S/kb1LZ6AN
	QAx026QBlwhel5knRCgUjGlH4QrB7xE=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v8 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Sat, 22 Feb 2025 00:33:34 +0800
Message-Id: <20250221163335.262143-4-chen.dylane@linux.dev>
In-Reply-To: <20250221163335.262143-1-chen.dylane@linux.dev>
References: <20250221163335.262143-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf.h        | 19 ++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 51 +++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..c79b4475b956 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1680,7 +1680,24 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
  */
 LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
-
+/**
+ * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
+ * use of a given BPF kfunc from specified BPF program type.
+ * @param prog_type BPF program type used to check the support of BPF kfunc
+ * @param kfunc_id The btf ID of BPF kfunc to check support for
+ * @param btf_fd The module BTF FD, if kfunc is defined in kernel module,
+ * btf_fd is used to point to module's BTF, which is >= 0, and < 0 means kfunc
+ * defined in vmlinux.
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and kfunc is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
+				      int kfunc_id, int btf_fd, const void *opts);
 /**
  * @brief **libbpf_num_possible_cpus()** is a helper function to get the
  * number of possible CPUs that the host kernel supports and expects.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5a838de6f47..3bbfe13aeb6a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		libbpf_probe_bpf_kfunc;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index de2b1205b436..8efebc18a215 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -431,6 +431,57 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
 	return true;
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
+			   const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, kfunc_id),
+		BPF_EXIT_INSN(),
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	char buf[4096];
+	int fd_array[2] = {-1};
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
+
+	if (btf_fd >= 0)
+		fd_array[1] = btf_fd;
+	else
+		/* insn.off = 0, means vmlinux btf */
+		insns[0].off = 0;
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
+			      buf, sizeof(buf));
+	if (ret < 0)
+		return libbpf_err(ret);
+
+	if (ret > 0)
+		return 1; /* assume supported */
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * <name> is not allowed". If the kfunc id is invalid,
+	 * it will emit "kernel btf_id <id> is not a function". If BTF fd
+	 * invalid in module BTF, it will emit "invalid module BTF fd specified" or
+	 * "negative offset disallowed for kernel module function call". If
+	 * kfunc prog not dev buound, it will emit "metadata kfuncs require
+	 * device-bound program".
+	 */
+	if (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
+	   strstr(buf, "invalid module BTF fd") ||
+	   strstr(buf, "negative offset disallowed") ||
+	   strstr(buf, "device-bound program"))
+		return 0;
+
+	return 1;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
-- 
2.43.0


