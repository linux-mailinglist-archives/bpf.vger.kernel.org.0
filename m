Return-Path: <bpf+bounces-51140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD9A309D0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AEE3A9A9A
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A21FBC9C;
	Tue, 11 Feb 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N893Nvpl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FC1B86F7;
	Tue, 11 Feb 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272755; cv=none; b=p5/QP0BVhlyQcvOEOHAJTvhLsACNvr5TngLvfW5zXGHD0BSELa9Wn//lu8dNCUf5h+1+4aSN5OnHjIe1Hw4xOuMQxe/f1dH6gXfSpOgVZvJTDp/LnNmBk+LDGoF1FR6v5U5hoXomwPPjI3XrZ+fEuxhumn46RTD0C1xESFjGMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272755; c=relaxed/simple;
	bh=y8ELDPuckWJAamg8YXHf5rEE5nKBYaZTu4XtGqS++/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LL82xoHJc+EFl0zQa50v+KQPALdZOFYY7m6J/uUiQ4sBs5isvvQPjt5pVd+iwqU+8Bh8EpGqIzj0TJBZioaZcD0EFyC8nJtcI+BZVOJTi4HeRt18RJJ2oW97kaIQr1h5cwWFN4WO0LcFMiY09mewOds4CD2DQ56hQvg/sXI992M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N893Nvpl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f4a4fbb35so72363245ad.0;
        Tue, 11 Feb 2025 03:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272753; x=1739877553; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9qqVJUNRDLguHfLkaPdkiYrBVSWgx5xHm1O/LOeWjk=;
        b=N893NvplQo4HtmPyYNlZegZyI8fkj+wn11qdrnOKVknZoekC5Ost9JVAb7JNFZskO5
         XJXmFROTRvtcpJHjWiQSTUqIjZhG7rRx6wzC/vNk1UwopoN/0gqRXgfJ1n55JmxQ9kYO
         yjRPUyjq7nX8VseIdr+YzUzj1t/WHGjiVSA1VlY9me3mBOMSw/7h4MFlgvr/aAp3JOD4
         WQOIzJD9qKZacq5yre9gENp41jjpBrVh4jEwMpqHEK+Ej13hl7MQMqd6AOMlFTEHDkRw
         ynzJbY9Y3PR3xBCvOBgAGJw5ThSIGXBO1s7C+q1M6FlVXaIgia11fKiHscBHWfLN/HoW
         7q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272753; x=1739877553;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9qqVJUNRDLguHfLkaPdkiYrBVSWgx5xHm1O/LOeWjk=;
        b=DJpRt79mWiGVURy6Et4bah7vdW8PKncDEGw2m+xwpxq9tipExR359O0ZHex7X8udeJ
         Y8N7G1buHaXpmUX1xXndDAe7eyU4+lfQKCRDlYxJlGHVVETNsyvvUdMtCzUxskl1tDe5
         zo45AxwTq2nEySeBF42OCXlaOeVcDFAMnoQ1k0LlICxVOnqREmYRT1wtiP3IQmBF9fos
         c7QrgPjJ6bMWEWV83IAmiT09gwLjQPcObnys4BAMJAjazkbsocscLQlUUqtGyZ2hfMQY
         hu5mTs8VzgeWfwJQLnijTUu8zGz8LtnvXDoQf88TerMyJqwZ6N2OLZAQp3zl3Ezoj6J4
         8QVw==
X-Forwarded-Encrypted: i=1; AJvYcCUCE4MkNS6MQ7EbMjrywq/KMZTqLLtPO6DzRV0RFXMmY6HSBGvscpVtAHUnc4C03jf8SUrmh4+c38thVlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0K3VsVlWxZnfZlwochgB9kDa3QOI38T8YZhfrKxRiXgsbvqQ
	Yq9u5DHhxfGwzcRpsfqo3ddW+KwHzEkG57/pt5fAo4zmuHkozwIq
X-Gm-Gg: ASbGncunogOOE6TLwR9MmgUi/8Z44XShb+5GcJYk4YdAHKmuz+SKHfp4MNQ3lqDWhKT
	RNYoAJZ2x1Rh9i0VHwS/hzG09Atrus4MjrTjqID94AZD2NB5eQljBz6YqvxJ8ty2R9Zl0uHW/By
	J65aSzZXrCCHfEUJaav96a81pp6T/TKxQYxQ9LF0ioZt08FaFwMs+IRfa1kLgF/32Sj7OPxgO22
	BnwBCE3NN0noXfp2a17hUb7FHSy8+HlytL+Jd/Hgkeq8UotZBmfGXjy1i78zukMGMH0TCMbn4Hk
	/4GPel/hNjo9l1R8
X-Google-Smtp-Source: AGHT+IHYlJbaE2N1s6X9zSdFY8flgxe0tilzwqRxJmPHS4O107BNxDVHWjeVJDD0JzTMWrtXXLbRJw==
X-Received: by 2002:a17:902:f544:b0:21f:3352:8f64 with SMTP id d9443c01a7336-21fb6f4c598mr40345675ad.26.1739272752558;
        Tue, 11 Feb 2025 03:19:12 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f7f33dd79sm45783795ad.114.2025.02.11.03.19.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 03:19:12 -0800 (PST)
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
	chen.dylane@gmail.com,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v6 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Tue, 11 Feb 2025 19:18:58 +0800
Message-Id: <20250211111859.6029-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211111859.6029-1-chen.dylane@gmail.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 19 +++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 48 +++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..e796e38cf255 100644
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
+ * btf_fd is used to point to module's BTF, which is >= 0, and -1 means kfunc
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
index 8ed92ea922b3..ab5591c385de 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
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
+		return -EOPNOTSUPP;
+
+	if (btf_fd >= 0) {
+		fd_array[1] = btf_fd;
+	} else if (btf_fd == -1) {
+		/* insn.off = 0, means vmlinux btf */
+		insns[0].off = 0;
+	} else {
+		return libbpf_err(-EINVAL);
+	}
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
+			      buf, sizeof(buf));
+	if (ret < 0)
+		return libbpf_err(ret);
+
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


