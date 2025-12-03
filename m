Return-Path: <bpf+bounces-75999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD1CA1F89
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8AE3024882
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CF2F3617;
	Wed,  3 Dec 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWDKhMxB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE352DC763
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805076; cv=none; b=YesJOtgbC9k528+XkwbXF56MXDUyS1FVUTjW8jR0CCkFY7M/6uU/uOV9F6Sy+KVG/Tcf30rwgeZCqKh6jflrAvnYHqYYmRI86f9tFKZk8gU4KFh4SzAQU4shAsaZZ63XMN3KJSStjk9A0z66Uny60K06oEFzrjTq83mW87B2TgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805076; c=relaxed/simple;
	bh=mKAFHkT6+izQEBH5cRCs/EI0+Bvby3a6ay+4Sl5KAiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I08k0arWSjISncHNsu33fc/3K0PZJT8EUph2sAq7GQozKjr8QWtSmf3yUCqIYezvN3QSDk8/Dg7v9rZDNMqU2+vt0AYCJoU4CzQeiFkIDx88jXmC2U7WV14xJzjT+lkPf0pDI2ZRSsjfFDfJP9aV670+MxIVG5d88GufGiKnZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWDKhMxB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so237623b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 15:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805074; x=1765409874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m93MNuP7RIdwQJXSwqzjgM5PWSrCMee73EsIxXvaEf4=;
        b=DWDKhMxBJwSeg2cwZNGFiP0aGKizTy1MfVBKNiAzraZ/QhUXH4TL1+V0XhNZo0N8Dt
         HRe5yiZXDM04V7Dchz2YBcjgBBy/mdHBwyMzhh/sgRIIW+MQ26S/8QMiUg/dP9ox2xwR
         aJNynA6XLBY0gjzEXY7ETR2ZIr8XUwwWAznxCsG04ABigb89OovP65jUBdCFFt2jk03g
         PeH5Kl3d7CwIQQf6qQdVi3a5JJAkTwrWKKQJxIjNVnm98eODDWBkqag9E4ybOWpzwcsF
         z2S4q+CuJlkFJNsq45t1qBO2pABSTH362X0Fx5u/br6L9M1IF0xW+2mEE/wUaW4/DhwV
         jhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805074; x=1765409874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m93MNuP7RIdwQJXSwqzjgM5PWSrCMee73EsIxXvaEf4=;
        b=TWy3uKsGD5MI6lUE1ohMK24l/mofR2pqNgDIztW8eJC61mdAHUoSDj1WlOd9FHUNuK
         UVL3PG8kC8flrHb02RfvVMpWJXxN2PF+roWGyZzwkMFmVGQ0Z4IiEliFRvmhjrXNUwXG
         w8nfI8ynOJKP4HNrW9c54SsLrbHfXg7RUWFllkwmVJ12OEpeZFOLhZVLkJ3SE/yixmqg
         s10EKV2abxKSHYt7ATrfQL9cULiXC8y6DP9zE3Ya2tMkY4Qyp4Rg0euteDC5tpnpTLpk
         0U79iMOhjrZndWMu8ZwZK6tSmAMhcIRkMYIoxnyBRaR/VzkR1lq5j/d4WPeNwtJ00HLo
         hvgQ==
X-Gm-Message-State: AOJu0Yx3e7dAPPjhlE1LglFsnVOtG0rKiFRnt+F/nl84FuXOdFvbEqn6
	mg+DuRsAfl9uA/bwenBR4mmqqmwjB4EMyd119BuoTyzydDDnvgz2iwbndr7orw==
X-Gm-Gg: ASbGncsCMC5tReOfsWdYHOqNvybmokLYCWmZ0nMY/8thmt4okA9P4fGf0EdV/YoqXIz
	CBjuDYAqj1RP9omdxo3wP9B0E/dFmBof2QjMNxT2MMjaPR4bhseKReAOXvkg4oUJoIpbxL2wKsx
	tqLvOaTGR6+jv7jcwXEqxtrImqvtu4Ryw5lLLMZML6De/ACAJIDmBMhuxHJD5vJ49fi1ohpUUON
	nL7991761q+t4ijQRKcYnzsW2dNPkPK5/YU55p4r70+kIcI3V2VTzaWLxpE/GjpY+NICoM5ETse
	0UCPLxLkKoiCrw+8OOG9h/UsaeHHBXIpnv6s4igPFL2gEqAyNjTlJQKhYmEt3PhqJGzV7nie6rx
	gkmk1x4kTcvLXt602MoG/b7Abfl9UwXfxlgY+M9NRh7rZDmeXQFTbDbHvelIxv0HBY/b+cCwnrS
	84ZKFiTzYelZPT5D7ZeRb/RwgE
X-Google-Smtp-Source: AGHT+IF9HWF40hU2gQIYgJS+Zs3SF8ggrtSEs+5jev/9IYnRl5e3mrqsT9oVUctMi9LwRaiqGaN2qw==
X-Received: by 2002:a05:6a20:72aa:b0:361:3311:322e with SMTP id adf61e73a8af0-364038781e8mr1067870637.46.1764805073609;
        Wed, 03 Dec 2025 15:37:53 -0800 (PST)
Received: from localhost ([2a03:2880:ff:16::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ecf89sm114176b3a.12.2025.12.03.15.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:53 -0800 (PST)
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
Subject: [PATCH bpf-next v8 3/6] libbpf: Add support for associating BPF program with struct_ops
Date: Wed,  3 Dec 2025 15:37:45 -0800
Message-ID: <20251203233748.668365-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
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
index 706e7481bdf6..076dc6b79669 100644
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
+		return libbpf_err(-EINVAL);
+	}
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
+		return libbpf_err(-EINVAL);
+	}
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return libbpf_err(-EINVAL);
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return libbpf_err(-EINVAL);
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 65e68e964b89..e14d9e349f9c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1006,6 +1006,22 @@ LIBBPF_API int
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


