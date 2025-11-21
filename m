Return-Path: <bpf+bounces-75266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA22C7BEEA
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 264CE367C17
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE5311C3F;
	Fri, 21 Nov 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TooVriJO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E112D5C74
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766839; cv=none; b=JBdaI2gMhgdJnnL0aItT07x7HBfyNA7KICVRu9I6/8snQBIt4+QNo5NRNoa2ypiceAzZGHpLdtJanGbRCewQJ6Ph7ypL+YFDv/fz0jFNmAyRWMa0Njt4mRFNyV+p5aiYGKVOhZuSLiU5aDcJV/m/uq0zqESzc3WC3eDYRSJI3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766839; c=relaxed/simple;
	bh=nuadBieIRqkX2X2xKigInlacOaV8KUksUNbusE6Cd0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZY+gjFnJYhkbV3c8V1SAaMkXZyqoxOFEd6x7qk2ulYs97VHe9wELXGGfwgum2yvx2H3cI1apRoa0VOD/xcVRTT/Rv8jgPQBVzPfu5uMiqleHiHr153kzRyNkci1+NEXRaawc3ShJWGeBE4IkZyXumaSmzh9U5CUAz1RNB1S24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TooVriJO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so3106078b3a.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766837; x=1764371637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnoROxKfUGaKnMycvDbpiyKb0bwKma4edMq84tq9sMQ=;
        b=TooVriJO9C3Y2YLwV7xNPQLp27/07mc0Viw92eGZbezMZEVcDnZyuYiB1cUgQyh17W
         gPpJZdAU6+tnF+UUx+33nbZg9535nBYycdgo1Y7zdWaYY1v0XCWRjvch5oYemu1syySn
         IIN9qncMUZuo9GR+yxnTeVKItJmOx3OVt6jTLG9g1C8+HNMbcxfySPok/lfhZtbUiU7H
         32jT3UK894tdpXeuDnt3+lQsOI1B7NvLJyeSzrFTeR2FXvDvBtsegea0djLjiDU7R8cn
         Ear8RfqfCVTOOKSVKXo2ss4QdiH9IAQz4O4HZR4n2ggaigdqqim2ELTLNLRqTFOaRFRQ
         JzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766837; x=1764371637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnoROxKfUGaKnMycvDbpiyKb0bwKma4edMq84tq9sMQ=;
        b=HcSdNSGPx7WWtMoiL0/YHZ7fzomNlRHW7SAXwSm7RihBmk+0uY5N+//bS3/sNClPEZ
         ayBT/z/SBkJxBRAy01FBEmE/n4bYuCcnTPfiQy4xvijq/WyCDIlu1wfry7ahY1qzOxUQ
         zEzInDmrFOnVIh30WTKgqSGJyrFeehr5rQWH1aOAVpjIaUwnwyrDEXRJIA9jFY2cTAge
         iYaHwtaEmMZO9aQOubAVzZ5vGq55s0o1TV9LVpg1YMRtOIa33Qxi/QWq8GlgG5gnOWSs
         KDfCCZ0pdHnlj1l5VJ0b3hF68uJc6mgIzMtwG5r8Q0LhCT7rPOhTkSQ+33YzphlKDotv
         BokQ==
X-Gm-Message-State: AOJu0YwXH2AO5pm3vzVL0j/Gd+AVrj4rhIIUYuuCjSmR6cLyIREhQ2+4
	ZpJXuK8V6P32FEdFSGUJmabpAqx39zq8ahbodUMb73F8NdU85+07OitiKPQ+ew==
X-Gm-Gg: ASbGncsqOnHGEEzJNr+rSAdPD7iN3z+TUC2DY7zO/0XIVNZUrxuyU+OOuNoUKasswUH
	7nVTwFPpAwIJAhqPwds9YkDkWiFi7JInRFeAfPLa5qlAH0dUXJIrYU93hLaP+lXXYecEI903QpM
	n7+9pfPV2zWLasSOu0lgkOrBvaGC/iraGNCDbBz0Quy+RVPB31RRf/qUpEB9culk/OSAPO71oKG
	b97wOWie0W7MMmIwBN2yFzB2+xJ62LJKWSYnmGjoFUpQNZxVJ5N8Ng7rIdQCm1A+FNESj5I2sIL
	Wh5IwBqBaBOsyUmIst5XH6RbNcN8BMLWtGG/N7f3ust3433iViLDC7byd8CVesnuWYWKVoAJg7O
	247hzPWr6oKuUDy+qHpSDy0+OV9942KyrLzE59Wg+PQrwY0Dn4RWPTbkyPYf6+c9Hd0LadwPSMS
	f2OJC8PtkAqYAj/fUlgLfMpnzj
X-Google-Smtp-Source: AGHT+IE4bNQtdSaRmfKsxwlEdULVL8SfzjIXFqHjwRZ4C/P7oP8bPeIjIRf0NZVSFqAf6+/0/PET6w==
X-Received: by 2002:a05:6a00:845:b0:7ab:4fce:fa1c with SMTP id d2e1a72fcca58-7c58c2ab130mr4199808b3a.1.1763766837265;
        Fri, 21 Nov 2025 15:13:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed076244sm7034583b3a.7.2025.11.21.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:56 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF program with struct_ops
Date: Fri, 21 Nov 2025 15:13:49 -0800
Message-ID: <20251121231352.4032020-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121231352.4032020-1-ameryhung@gmail.com>
References: <20251121231352.4032020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
command in the bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 89 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b66f5fbfbbb2..21b57a629916 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+			      struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_assoc_struct_ops);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_assoc_struct_ops.map_fd = map_fd;
+	attr.prog_assoc_struct_ops.prog_fd = prog_fd;
+	attr.prog_assoc_struct_ops.flags = OPTS_GET(opts, flags, 0);
+
+	err = sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..1f9c28d27795 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_assoc_struct_ops_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_assoc_struct_ops_opts__last_field flags
+
+/**
+ * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog_fd FD for the BPF program
+ * @param map_fd FD for the struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+					 struct bpf_prog_assoc_struct_ops_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 706e7481bdf6..1d5424276d8b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14137,6 +14137,37 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+				  struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	int prog_fd, map_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
+			prog->name);
+		return -EINVAL;
+	}
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
+		return -EINVAL;
+	}
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return -EINVAL;
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..8866e5bf7b0c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1003,6 +1003,22 @@ LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
 
+struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
+
+/**
+ * @brief **bpf_program__assoc_struct_ops()** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog BPF program
+ * @param map struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0, on success; negative error code, otherwise
+ */
+LIBBPF_API int
+bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+			      struct bpf_prog_assoc_struct_ops_opts *opts);
+
 /**
  * @brief **bpf_object__find_map_by_name()** returns BPF map of
  * the given name, if it exists within the passed BPF object
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..84fb90a016c9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_prog_assoc_struct_ops;
+		bpf_program__assoc_struct_ops;
 } LIBBPF_1.6.0;
-- 
2.47.3


