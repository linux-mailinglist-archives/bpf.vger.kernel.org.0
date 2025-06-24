Return-Path: <bpf+bounces-61347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D3AE5A68
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2CA1B68389
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276501F5827;
	Tue, 24 Jun 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVxr8fql"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5C1F4628
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734790; cv=none; b=R3Ai2Et6cWy+hcBwZfDJ+ijswe/RbWBvk41U3Ar7YqhnOGoWbyWCkg6e0QAPgWRt5tYUbIQVky9lo+v/V/4ehmMHOqDxUvW6VNMU9UOVIkToLQd29Rxh4l6FZqrDEBx6GbmeW4GJXfJMun1UxnZEOPnfcBpHhd7amSdGELueTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734790; c=relaxed/simple;
	bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3GZcRc3m2DgheuY7TE5NW6pet1rhLep+Fw+qP7VYZS6O8M/McmNbFwHQ4S4ARXGDSpzebBRiIdk3qn5mqbYOE71WvreYo9lm8H8nyuP1TXyMswSp5Ju5hQKBHOhEJbpesZ3fSepiGrjH7SYIS1IXZXkL/9zjp03uD2e4ZYhdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVxr8fql; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso10226719a12.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734787; x=1751339587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=kVxr8fqlAswRe6R/Jc3PMWeHGG3+jw4I49nwVHkW/UCwozjZISsUPzzIbvuoiZihsh
         urifeozRNjCRVAirGkUPiQtaMJ6lf1GflXrbWVLUAKY8tEkKEda9Xn7Ub5+oFnh9jUoM
         poHyxEbqIj6u28JQpHTZyiAWADX7j66KrItrVlvg/iwT4gAuc1bganQnEmW1RgA9c+Hk
         LPgTr1PIkyTWVRiLQPHZPmCzhEjHMKlyegSSJNYBeSL3D74udgmh2wJ+qadTm0T1qRN0
         upYnNPbkGwhxlsqyIZ+f1A3AREMTjZ9sTE7pqPBq2ZS1yy4XJc/CniMCadDqkZbI8MNR
         C0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734787; x=1751339587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=kRCqdBV9xY6ZttTPyYOdRDEiefx3GT/GyyKoGeZhTMf7cDCEOvOefQOh6JwKiof28d
         yo55RHcojVhI7i+FdxOD59fHSRVwhsN1Oy59C2Ruc7L95NOxwORLJHWkxB89Yg8lKRKT
         yNV5AUHGtH/R2ojDD2Dgk4AtERxCNK63nekTVXctKS/2VGsRvp8Jw3tn+4kk7PMNTetN
         xvRizxEvf/m2f31izHbI5gYp4gUKZj3Jg4Z0yRZVsrlzbauFWEkJ+0uzicbIBF7bzoEs
         75OQYkQMry6+99Q149/amDAZWxyk1QXtVezlUhv0OqsLxcZWxz5XnjmVcT9FMbFKCikV
         +/4w==
X-Gm-Message-State: AOJu0Yyb4cQYD3tS5OQmXUIN6vwuqzMH5RgoFQDXc48rPgMRi1PREgBO
	nuoOBuJwYHRwizCv4qOMv0cqWJ0EkFFEQFR9UER6vsUrQPzQCdyY2VocLreER83lK7e7eQ==
X-Gm-Gg: ASbGnctxSImz738Rnb0d29h8olLYocQ4z0OOGKyYP5tdDaD9BWZQgOIGriWhham4mk/
	PI/yp+K0FjXtOLziGZz3r+n/AIeSdWln/X0Cz8VF8wPtE/HouAEd+mUncBQOmwftcrJuV0AizO7
	US1fN6dZTn252RhIhw3+JVdQ1J1+3ysbYwiTws/YIk2IRKKeu15q5G7DECcYWIXzVZzSIRKdMoB
	s50t7u6mBsbozF4u1LYdmSRbxajd82wLVS8d2YKEDDwRbgxkJGWO0shMzOwpCBrOYrQOx1ff2u4
	9RpNRkKthwVaN1upIU02N+lcgs7G0v9i5c0eBcoRKmQ7uZsn
X-Google-Smtp-Source: AGHT+IEaAfquhY8X6LIdrqR/opwmHJaBqKWK8PEscPlaSADzC4LgQ5ZQAVKWiM9nstcE41ADhqH37A==
X-Received: by 2002:a17:907:9404:b0:ade:4593:d7cd with SMTP id a640c23a62f3a-ae0579bc240mr1481623266b.13.1750734786797;
        Mon, 23 Jun 2025 20:13:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a3545e4bsm97978166b.151.2025.06.23.20.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/12] libbpf: Introduce bpf_prog_stream_read() API
Date: Mon, 23 Jun 2025 20:12:50 -0700
Message-ID: <20250624031252.2966759-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; h=from:subject; bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWe0cih2+u1qHSe9PZDmGtJPIM6jHDEAWB561WT dPVD8cyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8RyuWOD/ 91cTqHryWIx7+pnHv0PVlu4gGbzzQ5xrmEHqB36JpntVQog6O0mKO86JH0fGZ0TnJ5/cvqDCHcqKx/ WX2juG6gvMCiq9QQVj0eQjbi9agNRQx0OtOxW6JlrVVbh9vfqe+lGsmqdQiGBEfBuW0Fv3iL4PZBVq H034iIfTyubuiGC7PTaNLrNogXCxwErCkCe7IRv3PM0/uRz6aXD5iYMR+SQMW8ZFUPE0xkBMX/qnlW RdPFZpdUoZyJ3reUHsDMOQwHSpKQ1bUtxBm5sG5v8uoK+92G/FovhBRzZdjRViUirgNbCcMhBiL5Dv 9poaFrsY1k3wuUbH0KuyOImuIBJCLkL0DYVeuolua5iDrnZSe+F2pZNqdKuk1RUTd6sOurdUXiZfLQ JS76CIxb54eqaE7fV/HTOtQrto9YUL0hSlIuG+WKwzjRlBgzo4Mirt1DK99QWqQobZ5mGt0RCSnk6I qBtL0RXgLAXFfELUl+CaViW6ULSfHCXhIykd19tLW/xbQfZYuCLX8hCssqEs9tFLG1YrzoOHUQLfAf jwlc++bQ4bHWkzAW9lVW2saG2xfx1nygXrdrn5SCs5CHRnLgNDcClxfzEjeKO1vq+RMQ3kJypl0Fjf TS+Z0dJbEN25niQqsgAS4O0kGaHpR1qfurIO2atBxIWdheAvtAYj1QoVhRiw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a libbpf API so that users can read data from a given BPF
stream for a BPF prog fd. For now, only the low-level syscall wrapper
is provided, we can add a bpf_program__* accessor as a follow up if
needed.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf.c      | 20 ++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6eb421ccf91b..ab40dbf9f020 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1375,3 +1375,23 @@ int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
 	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
+
+int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
+			 struct bpf_prog_stream_read_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_stream_read);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_prog_stream_read_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_stream_read.stream_buf = ptr_to_u64(buf);
+	attr.prog_stream_read.stream_buf_len = buf_len;
+	attr.prog_stream_read.stream_id = stream_id;
+	attr.prog_stream_read.prog_fd = prog_fd;
+
+	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 1342564214c8..7252150e7ad3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -709,6 +709,27 @@ struct bpf_token_create_opts {
 LIBBPF_API int bpf_token_create(int bpffs_fd,
 				struct bpf_token_create_opts *opts);
 
+struct bpf_prog_stream_read_opts {
+	size_t sz;
+	size_t :0;
+};
+#define bpf_prog_stream_read_opts__last_field sz
+/**
+ * @brief **bpf_prog_stream_read** reads data from the BPF stream of a given BPF
+ * program.
+ *
+ * @param prog_fd FD for the BPF program whose BPF stream is to be read.
+ * @param stream_id ID of the BPF stream to be read.
+ * @param buf Buffer to read data into from the BPF stream.
+ * @param buf_len Maximum number of bytes to read from the BPF stream.
+ * @param opts optional options, can be NULL
+ *
+ * @return The number of bytes read, on success; negative error code, otherwise
+ * (errno is also set to the error code)
+ */
+LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
+				    struct bpf_prog_stream_read_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c7fc0bde5648..1bbf77326420 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -437,6 +437,7 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
 		bpf_object__prepare;
+		bpf_prog_stream_read;
 		bpf_program__attach_cgroup_opts;
 		bpf_program__func_info;
 		bpf_program__func_info_cnt;
-- 
2.47.1


