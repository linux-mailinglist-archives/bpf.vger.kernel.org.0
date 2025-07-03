Return-Path: <bpf+bounces-62341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8BAF821E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F1D7AE52E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E32BEC28;
	Thu,  3 Jul 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFoVrW3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B32BE7D7
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575723; cv=none; b=XL7UrlXGS54WZer2YCUKiXeqObX3TZa/mH7ZDfVOSqGP1GSMaHj4ICmxALMTH/TLqAsFiG0WGD9luSuOMccw0jG+YQxng+Fi1NtwMvYV0KCtnPekf/VwTeSlTJGK9y0iHeILAF52B6J/+XLwJ+XVpjf5S56DVT+Q+4+kAfMfiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575723; c=relaxed/simple;
	bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp0iWMdPiHR/a82dBDcy6MeHwKtXrpBW4JNsclCL1J18oLLilnf6gBdDbRTpPrkC+ccfQDddTR/DkjL3TmyEAtU+fIcOqUlxfxrQAYrxEOhQrr5zhcLzwxknREVGF7oHmwbKXYdOTMV8nbw8sFrHkZ9FSkQfE98QRTczrYDkgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFoVrW3Y; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so432905a12.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575719; x=1752180519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=eFoVrW3YiDjf0zcN/aASpLvpRl1n7GX8kvobT2PM0UjXD0K/P5u+XL71jHxGiIPDa2
         qTjwmefIJWmq0VJXq/lHhcWKIFaZQupFTVaeGfhvKvdLrshh+quf5nmHx5cIex6ND8gU
         vaMebt1ZaZBTPOh90qM+Pneqe0rRcZXgk3ojYWzCplNF/EP3ekARhomJrc2O6ES2a0s5
         zV/jP3PqIXENQvzAJGp+vuiHkLbHc/jclw/RGPv3L/WxhoL+tiBd442zwfLQLc6UyDfS
         dn1RR7YQLrHkRSnit5W5YkUElOrdh1sFYgjDhPnlvlpnb2bY2I+21vWfISgqWvItruhq
         wLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575719; x=1752180519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKOuNAEbepis8hlm/kOpLpMRCe0rrTGe1whyAMiizZc=;
        b=OOrcgiwOQxadDdqpoGXfVUR4twhGCPp01ImtmwLuOAuZSqkMchyS1FrdApoTv5JzFR
         ijhViyBi5RgQSndEJA3QVyRtj3fMENJuo34hbkSQqeicCel7FdAO4C0c8Mar09X0kl1V
         6s4+jUm65OLv8EHIwWQSfOZLIQBRFrpQzNNVlI+q7fAKgKjxpHspi7QG7DFfAgKaSCXg
         ofKyGKqrAdcPtOr9D+Z9dwKLnWOpKovK3zDVsLgZMKuFIPhxAuaKGrg9L8XB/fvBWdRC
         lePSezmPoxvIql/+di5H4hUhkZ5gxmaT9gISDbu29liRWdw1JAPS4uDuI19mM2gPpaeW
         R3mA==
X-Gm-Message-State: AOJu0YzSWDWSdrsJUcWYSruM64Th20QZjmWPFgov6Fm7h7Vp66CSmH1J
	OsfAi0FffCl0YngmQ7Yb5wQEX0IK8ByQQS3L5H2K3iYw3pzE4yES1w3+PMnFSUueF9A=
X-Gm-Gg: ASbGncvbZAZ8gNHnFFhcLJHaAuVbDRC/0SXwyzJLKvDmLp7hWHfs/YCb+2JCeWVzeHc
	K9YQXsdAIZSGm+uxRHhLEu/hbD4Xnu4/YtwUXDa3YDLUaMNg+onq9y5muHj8I8xMLr7efhnZftf
	7DK4880M0+LUKZRhGCdj8yNOKR7LCHp752CzlNTnCiJzsy9/yajnCC8vD9Uxl73VNvaf1/Vblfl
	1/Mu6hHp31nT0AGEshJbSa8ud9Kr10K3rZPE86Wl76ZqKoERrmRXFfMO79Bw0INdC18h96ccX2f
	QKlyEfHsYsalQ0bzyPt7ujEhO3bATTMBlGsH0lH2LRzdCSBYWuA=
X-Google-Smtp-Source: AGHT+IEDziS1Ivdt1pGJ7+O3i4hq8UX34lSmC89eBWXRRFIZiKgmO66BoydOEzI7FdS783umOPtQ3g==
X-Received: by 2002:a05:6402:5243:b0:5fc:4023:1fd2 with SMTP id 4fb4d7f45d1cf-60fd349afe3mr14536a12.28.1751575717750;
        Thu, 03 Jul 2025 13:48:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c892csm272517a12.38.2025.07.03.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 10/12] libbpf: Introduce bpf_prog_stream_read() API
Date: Thu,  3 Jul 2025 13:48:16 -0700
Message-ID: <20250703204818.925464-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; h=from:subject; bh=iBCaZSNhEt8VX4yj84U+4N8Bh/c2LX+LaCdo41sJJv0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudM0cih2+u1qHSe9PZDmGtJPIM6jHDEAWB561WT dPVD8cyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8RyjYKD/ 9OWWtzxSuE3izHcMEuUSrBBzilsK5jtk7OEyYbauUK6SiwftymXwzmIjE94woX9hWJ5XCg9XbQgjB/ uk8SDxZywwXAqgwXz+NPECuU04jpLqGcwmuIbLdEVUp+Ly+dN0coQcQTOwv+/ezTWB2peDQTMrcBXY cWMP9FDJRw9g04wJbWnZnAX/yS6NfWmwJRGzdNdOAvayPze0p5Q1K16g0Yo2Fu7FLHO37VORVrOjVy iXG1nIPa/EOBpRgXM87JMHdxR2AWmJImy5TwEtwddmTeLGDK+J7ETTzV65Mh7pGdNqe5hTMtKQAnVD Q4Ss+m6vfye6DsbpMZ/AoRo0U8AKw1F0PaJ87ce65TJxxbtHqBypZWgRTHaLrDUyp73XVT0NclaxxF aaR91sNGQndcVUgLOMhqTw8IrNkt6TC8+MOd4Nl9+wEQ5mQSgkyWTcxggCjUurrzGUeQmaTNAaXmAf YivMn4uSiBVHzbG8i7Y8sPaHdLckUyfV0T2Y4HyI8T/IesXNxVPHidNmcq2fYpn3/8UtqXJ8LkjrAC O5SmBD88LKRmkmv6ZKmPj0n/ux2hpT423Sgbb4QHdXDTieR3w3KX9pKlLNSsmlEkhtsBGJnDD8uiO9 FakSLtPvIGVYNa0SnH4H/F3CeYdzsX3bj+I+hQYCMS997qJN3GUixAAnO90g==
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


