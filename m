Return-Path: <bpf+bounces-73470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFB2C32535
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61272346D3A
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D533B6E4;
	Tue,  4 Nov 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXHks1ch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B1338917
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277222; cv=none; b=aKRbVOZEner7XKUVzuXHnf1Dr4qUpus1X6obbEkvriuve2mLfewtKAdlbB79lVM52DP/4UzVRTBaQnLgRUJyFCTWLIoRzZsyZEsTEEQxBqP/qoIMqzAGv8YVrrYDF2zAlYpBPCZfeXCaLjgEJufyHRUAU64AcxObnwOFZkvIBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277222; c=relaxed/simple;
	bh=KqLqZBvH45LKRDSedglfIUXsMROUfT5BTfxXMkNEnm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FORJxVz5jw4zDz0lBZW4dqoIR5buuznXQKKwZ88u8Vnm+pCt3q6KVSBsjs6iBMR2P9p4Lbnq8Gr/IrR/uEaXjXCAyCx1eAU2avTOOmrXzqo2uQkagjBI56M4Ki5ToLN2mNRTWgjNZq8h/edpxEjdueDKJ+mbyUKrbeso39FfoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXHks1ch; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ba4874edb5dso244223a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277220; x=1762882020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb7XJ8TSy1Vf4n4X78XpP9OaXI4f3MxneVooXIatUQI=;
        b=ZXHks1chYZrvHc8J3v3Nj+W957cfyZfdOKvcLyNA+qeOohbVcDWz4Zs10Qutx5kZ76
         52AJrQ51t+Yvrh6axYQpy7f8Kc6o5JAVyzkT4TVmRoBhoz6VTulw4lKbscLcO2H+yLJT
         2KkiMJF6RbYStauthgP+XyW58FCblG/KnsQPCa8W3BCmxf/YIN7AAD0/1KYL+yp2ZzzG
         X05p0LgQ2k34qxoiWi9uAvaOqRmc+JXiuIVoMeUnPlGZkdCySYKK4on6sri2DpC9JuFs
         Xh9ZXiUYDGhXgob7GLsFMRLjJbG87dQgYEq2dPU9zDOSB+McJfndF4FdzWvqUdOTl9aR
         N0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277220; x=1762882020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb7XJ8TSy1Vf4n4X78XpP9OaXI4f3MxneVooXIatUQI=;
        b=VE+A2qTM21ZfmMK1zYKtElZ1MD2ILdGGyoTvR4513+Y2fZn2DD5KYm6rc6XNhSwqr/
         f7/vRVs2WTOT5Fd+j9hXV/K1X2vvfmTufcAwoEyAMQP4nwtZpPkQE7ff8m0XuOUHikwM
         IMj8utVvNtjfsRDrG6L3+osWcog17Lw0TjxnNZ3Z+rkn7mn2k6wIKBjvL69K+cI0YAfl
         ZFFqqrbSEkl70BAFKB0QD7ZpzpfVMEItz9IUrGT6JkFE3+1NNEFVHwnso7aKVvCmWPFw
         FtF5n14pcFqOexZ5xeJgyl+LB50qIQ0R4UerrRXHVeTeOM5pSfER23eSvMFnmjySC5cX
         FX5A==
X-Gm-Message-State: AOJu0YytYFb8aUcOwxPpkrIhDBsX4Rf9ZnwzjJy/9kpxEdSzoXAgEhqW
	58KScmHEXBurTBVkP0oQHW7CcOLM+l+q7l2aEVoyeFDAt4mTkRcSkYHVDQe63g==
X-Gm-Gg: ASbGncv4iAUnPSAam4hJS/qElCoVBZcUi/u3mCZkdOac1Gqs0YQ+Ho8fWgqyb1kyOA8
	YeX6xTxDPpAVA5rNrb3B28LDfQJXKqBMrxPliGaJ7UEB5r3NUIBBVhfy1sgjU1UkH19PApFEcH1
	PdhkB9GX3uXS44vOrXcolk8sqFG/Q125kpquhXZY8NuPlyJj/Twkd8KIO1XjShulSfKH1i6kVVg
	bhumV7qN20n5aP5eGDJhYGAPie6APmN3b698XcbMjANnwf+ImNJixGFN7UTUEt4R886+yVzNCFq
	8ObDKtjb+TERJzzdMBKY5pFqP2i/9Qr00yjn69wP0u+Q9BCqXI7HDbQA3OrvYrOlZ28ZNdGOr+X
	QHxQmxWyMBEMlAX2cL8BN/wEQmd6o7NsveGZTkY8nuozbYmdVRrbBgYqWFl0GAZCh2RO64/P6Da
	PjFQ==
X-Google-Smtp-Source: AGHT+IFZYOrfvBxjGDMmEH/OfNCYHeReUXl7kAuuUHbWYEWGrLFOIz9b8xGnbToCq7s7uTF3zlbYFw==
X-Received: by 2002:a05:6a20:939f:b0:340:6a50:7e9d with SMTP id adf61e73a8af0-34f8611555amr64995637.54.1762277219858;
        Tue, 04 Nov 2025 09:26:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3d00117sm3520037b3a.31.2025.11.04.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:59 -0800 (PST)
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
Subject: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF program with struct_ops
Date: Tue,  4 Nov 2025 09:26:49 -0800
Message-ID: <20251104172652.1746988-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
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
 tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 88 insertions(+)

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
index fbe74686c97d..260e1feaa665 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+				  struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	int prog_fd;
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
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return -EINVAL;
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..45720b7c2aaa 100644
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
+ * @return error code; or 0 if no error occurred.
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


