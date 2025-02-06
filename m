Return-Path: <bpf+bounces-50610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D156EA29FFE
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9A07A2975
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B62236E5;
	Thu,  6 Feb 2025 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIipaidH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F522332E;
	Thu,  6 Feb 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819107; cv=none; b=soNKuPnPeOyzLEXgpC2v4Ks/CW+ENNl6PkK8qQLXOYwBCsQijrXxN7QWqQ6mlXA6U2Y3dGlraXlCXI6EQr3PT71XqPsXjW8UWFIC0bJewgx+3/yJJSUnP1v2YSLamyT6jFZexePdJSXNbqwSYwoQf9VCGGijxyXd4vfIByDOwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819107; c=relaxed/simple;
	bh=9EkRjWheMAy8mekC0cJzarLMSq5koURKLbcnOPxpgsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MNGPlghWQUlb+NnNteixvfEVTktUarZt+XM1aXgRMCVUCtUUrZ77Q++sa/1NMxYtxxOIXp69XlPNbWd95e4hPda3ZWQOkOHUMazTOkKMuyGnSbrcBbM3VmTJpnSHRdYX/Bo5sOTPEN9LfO5kkp297KvzuisXQgBtD/OCnm2YEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIipaidH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f2339dcfdso7197285ad.1;
        Wed, 05 Feb 2025 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738819105; x=1739423905; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/W8fmlJWAbVBO0MEo0VBT59psNgtM7REfYVBIAPFhJE=;
        b=hIipaidHU7UAfGGFFhDYFVgYDcRS4ChVHt8PysxENt+uFdlFpCvrMucK3XRpgzSaVM
         5d+v592i6zU0MUCxMkp7FWs9jI/rOcPERdJgwfAAKOlfBbOgSc0yWwHJzfqBG42rcY0y
         AmZRNh5X3IJcGuhAOV/wZHBK8GBCN20JxeXtkuUWbgfFsfkWUl38RapReMn2s3d4T6yK
         T74+OrNPkchpc8XP2C1UsIuAdArIZfBzvOf0nP2f13f0NRE5+xutlMaWaI33vgvxcSyv
         btpd9cBXDz/Ve1fPAhL2ufrMtLUCmRDfR7cPX5BFpZyxet81OFqAdcp5r0NaBnzOneGx
         7W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819105; x=1739423905;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/W8fmlJWAbVBO0MEo0VBT59psNgtM7REfYVBIAPFhJE=;
        b=CLcFw/ChfY4aK+HougeyY6/AgebaT5KzoV/xoXFUHqISzBjwjPszgGadZiJ0e5GQ7H
         bpOd51I92jBfYuhfuZA3JD4VzRrNY8dilT2K2VhqhVANMJ30Tm9HYAfYe+hcNQpMTzNr
         lkktQFnqZTd/ITGs20px+///75j8g03695yXBBfuB8eg2ZEI1hRaNwKchdbqqpm1fIWd
         cFbSOF4BHGKgv3xo1kpysZeFKH82kZ1tqmBV1J+THAFEw/CX3k8VOn2F0dbsEYyJmkwk
         fOvNpiKirRZkXH93BrLi/w1s2MEwWDaAtUxNbRVTJ2zwuhsK4JJNiJKjXi6GnyPpQUfj
         CAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXRxS0SXtqJcvr9/BGUUqa3BOA8ha50pxMNOyWnlswzx40Z7FSkR9pViWF4zfnF3ClVLfKY95WCF2M+ARw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ib1olS+9MxI0VG91YYxdM8BSkc5sr9u/uZEOMEk/nH1/dq5Y
	Ow9a/i2+vcgFG6g3NmbiZmNH7bmzc7BIjW8jRGejvBbTTqfVwEuC
X-Gm-Gg: ASbGncszDKmckUt2XNkG7IrzRvi7DQqHnh+ArzjiUVqtooIlezOqfaFUXltKPu0GA5X
	wcnMCavMP6IqvV7abxsX25rGKvyjP4pv7DOgeH9sQcwBYIs5E5GPGiR1sKQuprkyaNu/5w/ace8
	ccPTfMEn803r4TNpDRNSjWKzIzwuMUxzQWwdmcf7+sS00bturDm5iITsgp+5oU1HmKEjWhk2sgd
	TNABUVXMtHG5xFlqh9EZ531LFs1SSCFBsNKK9opNU8g17oggN2bFzppMH+HRTDVcmIsL9E+cYFO
	vQn3yPA/lPz8gzOH
X-Google-Smtp-Source: AGHT+IGYkjN6YW+I9sjJjoH/i/IRj6N+2DMvrbCwMqqpTOmlbOHkNv3ZV5SYE3inhLMMg6yJNycpfw==
X-Received: by 2002:a17:902:db02:b0:216:4676:dfb5 with SMTP id d9443c01a7336-21f2f1b9572mr41080315ad.21.1738819105125;
        Wed, 05 Feb 2025 21:18:25 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36516d7esm3285165ad.13.2025.02.05.21.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2025 21:18:24 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v4 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Thu,  6 Feb 2025 13:15:56 +0800
Message-Id: <20250206051557.27913-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206051557.27913-1-chen.dylane@gmail.com>
References: <20250206051557.27913-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 18 +++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..596b27f58c58 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1680,7 +1680,23 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
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
+ * btf_fd is used to point to module's BTF, 0 means kfunc defined in vmlinux.
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
index a8b2936a1646..e93fae101efd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		libbpf_probe_bpf_kfunc;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index e142130cb83c..c7f2b2dfbcf1 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -433,6 +433,61 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
 	return true;
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
+			   const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, btf_fd, kfunc_id),
+		BPF_EXIT_INSN(),
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	char buf[4096];
+	int *fd_array = NULL;
+	size_t fd_array_cnt = 0, fd_array_cap = fd_array_cnt;
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	if (!can_probe_prog_type(prog_type))
+		return -EOPNOTSUPP;
+
+	if (btf_fd) {
+		ret = libbpf_ensure_mem((void **)&fd_array, &fd_array_cap,
+					sizeof(int), fd_array_cnt + btf_fd);
+		if (ret)
+			return ret;
+
+		/* In kernel, obtain the btf fd by means of the offset of
+		 * the fd_array, and the offset is the btf fd.
+		 */
+		fd_array[btf_fd] = btf_fd;
+	}
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, fd_array,
+			      fd_array_cnt, buf, sizeof(buf));
+	if (ret < 0) {
+		free(fd_array);
+		return libbpf_err(ret);
+	}
+
+	free(fd_array);
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
+	 * it will emit "kernel btf_id 4294967295 is not a function". If btf fd
+	 * invalid in module btf, it will emit "invalid module BTF fd specified" or
+	 * "negative offset disallowed for kernel module function call"
+	 */
+	if (ret == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
+			(strstr(buf, "invalid module BTF fd")) ||
+			(strstr(buf, "negative offset disallowed"))))
+		return 0;
+
+	return 1; /* assume supported */
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
-- 
2.43.0


