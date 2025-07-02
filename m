Return-Path: <bpf+bounces-62046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B3AF0924
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B831D4A2B24
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862E1DED57;
	Wed,  2 Jul 2025 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikJm76TC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C4AD51
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426280; cv=none; b=XosMh9hCgl+O7b1W3CDy6ZW87TZtoBHjBLNnMEU0dHTz1JV4ccNJhrIzw+L8rTZdKhHsVTh8AgCf/Xf80b/qw92Q8oxt376+19RwOugzri+d8+v3QngRvMhN1in+Mfwno7umoECriysscUy50Gz0TA4XxYDYHVkSDH2KuRPLbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426280; c=relaxed/simple;
	bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJoXPQk0T6Psop6ldJYhqxoU0NWTyIkyF+pt2GY4kyBTynT7wa/YPk8TW9Ees44w/wf82AR7J1wRgawL1lBPfIFIteQPfbt928+yQRmzWK9+A+h4uYiDrEmJVDmRwdhMBrFJika4R29s1cEizsu1B2PtRbuZ2atFnCU6jThlkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikJm76TC; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad574992fcaso670937566b.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426277; x=1752031077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=ikJm76TC459kLKwXBYTBl8uItE9yRzdWQSQG3xGXzWmKUjzh3D0NQ3cjJbFmEfklET
         5IviAHHrmcO8x8k7sxF3dlphXR8V6+if3HQEo+bzvew2iMp0VfqgdHZyQoYqDIUmgqYa
         /ed25oAG+EfbSBN1381u0bBAlddllTukgJfdFl+eBUMYfn4cu/kkPDCQ12PWdgK4ocZ2
         obAXKwvDDKY9zPAkvMkNdxhwLGlO3FHspjnTk00NWX90aZNSx4GtOllO8xwq+T2pPQRY
         1bnzCWtoQ5Tw2oq2ag8gPHS9eIto2N+Ozpbb3lP3tWzpUvpX0lASjScIik6BBE0vgdwm
         fq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426277; x=1752031077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=GIvnE6COVfUoFun5qNKFS6FM69UvJDEEmKOiz/xWwM6jCpllDo6hzKZAVXf0AlmQDw
         0osjuOk2BqpaMIEM+GfGcaU0cI4GbESbCM70P9kbByLXxsHzpIhxB6PusnNQzBR4XjGX
         ia7wAgypvrHRU86dfIyD9kVj+kdCww4b4ff3HS86OsFIyMSUfJHCd/eYRFtI0Dg/qpI5
         l8ibocSixpIqfhdn+FnC0Q/GPs3RvgiTJyPSAwSwlWogBj+jZuy3rebMe0ZdT9DUeR4X
         a/EO9SDbN11Y88BOhAoKpCsJ1u+lNLYBFpRZ0ztzhbchC3WYjpxdN2Go2ir5RNQ/Qc86
         gBKA==
X-Gm-Message-State: AOJu0YxApWuSBq4fWJUKxob29TPG0B8a5L12/BCSNS4cygIy6jpLswF0
	v2PKgFwJE95/3DYjV/Cn2rBgZOzXTPR0uwyPrhPbCosXvnScwj2gPwI/t+IeUPfWHHY=
X-Gm-Gg: ASbGncveJLFpQlqKNfxZ0XLLfHuKixSx2R0dPL65QHWWo5DilHsWg5mN64sZOii9tNo
	v6GTqtAwvBCbsH9TBAx0D0EQiElACnXiS35pFUkeLG3s67C2jldTpwZg/IlUoUwe0u7zaJmnAqo
	ATrcgZwj5C4AMY4IqRILOVYOy92O2eNLNDdGUSGqWJsLJ75p/wGE1AKdcMX9G8sBkk2BQLHA9GC
	nwosgVk0aCBriUckeX7CN+GeLBY3PvqutBsPMxl/vn11mEBSYRY5NBENTA03z55Do28Gi8ArXeB
	QVUBStKawXUeJS72DqErs/ip/280mUacEyp7hU7lkhRAlKFQ9yw=
X-Google-Smtp-Source: AGHT+IEIhfNPh6d9Ie8ITg3LtIICAOEgQbzoUP6JVYfeyDxfhE7H6G0KqQybOajTA1I9f9rgflfILw==
X-Received: by 2002:a17:906:ceca:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae3c2bb51e3mr91703866b.33.1751426276460;
        Tue, 01 Jul 2025 20:17:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1625sm984121066b.152.2025.07.01.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/12] libbpf: Introduce bpf_prog_stream_read() API
Date: Tue,  1 Jul 2025 20:17:35 -0700
Message-ID: <20250702031737.407548-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; h=from:subject; bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFR0cih2+u1qHSe9PZDmGtJPIM6jHDEAWB561WT dPVD8cyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8Ryr0/D/ 4gXyUscWYgy9AOD+X+RaByiRyAt5IDJFRhA3RSrsVGYnP3hpsTPQ0HfX/e9SsT3TOpdGYFsUwY2/TS ujcdj1EclW3lbxWETbpcUHsbPav3iuIdZHq6gmxOMirrkffalzbocdy22XxnU0hyQlPi5x+9l8Hzka Va4deC8de/WBr4Gu5z3/jtpj9EDuuSPAtjVsG5zUuQy/e10+pkuOPomHs2N/+alNl381aelLFCm2xc qMcnZzbfBssH1AB7qrUAK+vS+XqzRKIxz77BSRM2Rm4Y2EqSKoKoKq2Oxe7O5G02f7k49ET/qV5WWB 4yBUMQiaW0WQEK0Uzc9+cs1P3qWEgtQ3MMBzsDNjaiEPDmsEwU7bCPjHEZFSL+nNm7rAAdiBy5ggcM RzESz4WD179SKEdKKRKGUyOmxzpddjZ/kLF8XKInwawfq4L7bxYkSqP4YIGNzgAl1pNQANU1/7gDEH 1Zl4+jba3S/W3W8NWM/YhoMMk9AJVUDQzXETimJG+BG50nyTuPnwrnDzyAUzZA6lGbTfimJd6TxvMp 7u9Cyg6k9KPaHL96eFMFxM861y8HgoI7EOYWxlhcxo1/DN4TEHrQbCDO1rDPppirPTgXUiUZxrUP7Y O2yCeXp3Jt1De+zAy2B50ONl5P8z/+dysI5NuUizR15lMDvAtIr9CJxWkuUw==
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


