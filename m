Return-Path: <bpf+bounces-23214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4B86EDC6
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F5F1C22104
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFC53AC;
	Sat,  2 Mar 2024 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egFPxj/z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA26AB9
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342379; cv=none; b=qJENd7DL8hPxZAG3+EgTa+6VaDz60kiH3TciM63knxKa9OGnIhOb8NZ8Gk6DHml60XzTpZHy+Bt090JmtPw/dSiYA5ttJhcTVZXhMa/bWLFMTatH7f4hFLjBfCuTeR6xnPUqyzwpd2y0SvaCynUbO25Vepu+zJ1Yhb5MSmJCKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342379; c=relaxed/simple;
	bh=u/1jTp2CttH5gxlhCHQfZKsq9FO8kAJbKLWIR91fUBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xplq2iGus/1LPDQ3dccqNd1LnKw2Eiex1zxz0yIKA6WExkXc2qX1THArj5X8Pylsxb6k9lcftB89sGZw8rn8wEKvsVGzwwkBGSvEXcFICMiseOqqp9XyDXy/rE7woprUgESX70c7pe7W0yAlqu8g5z5KITgzWaxA8CGjKMR+8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egFPxj/z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d23d301452so28605581fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342376; x=1709947176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ghBbmU7JgmzNE0IDgqQ93JxAVATdz4P5/PxXkAkYZ4=;
        b=egFPxj/zEzpaKUXUrqHU56/kNhb1xfMM2LZnMleI/Zy4yCEvSfBHWTQs2Yyz/KAQ1x
         QACiHGDTMC5oWTnTDurHBeIwGSxbNQy59KIFoeX/jFGSZ/Ggnyy38D1MJZIwU1u6/F7r
         17WyAq2h5biQYibU7VYDMOd/vgjBoMg5awhgkrWC4fvXKUrjdYYYsGAv9M3YhHGGBJEX
         10L/yuOh8gSb0r/dlUIUf01YOmZWQhv3zTMJmeBm83Jt83ye+h7mxYflAvwCsRMt6iTx
         K8abxiXooxuLM1ZbpYWY4VROXhYuP9hrA9oxowF6az3EuX4pl1fktv2Bn76ngdYwcJv9
         KAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342376; x=1709947176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ghBbmU7JgmzNE0IDgqQ93JxAVATdz4P5/PxXkAkYZ4=;
        b=RSI2DYl8N7TJyaCBTopM/+eG5u8EXZQ6lZocLDv8uG7sciBuzShbzuWiX16rxqgoeb
         8vHACF9WrEi7rv8xGkWUXSrCwtn/JNkgEYgxl9xlmEx3ytB2H8tins7SvjDhqstLRanz
         e2/9v0EcZwGTdC7OIm2RkfNQ531P3TsYZScw3s0e9UAzUMExkaI98OBYutavWM16Glli
         /U+9pT+h6v7hMLX3AtW3J9S44yfMYLxFAEPpujePiEZShe607mbhbNfiWhp3yM6K1hZ8
         zuz7GaNepcmTIBu5kK4YBXjDnn6XFYzfUq7F77VKP5JSRJHNecUi6u55kVGkB88AIcaY
         l5mg==
X-Gm-Message-State: AOJu0YwC/5gvMPLr9dk5yxIhuoGIIopRsydx2HjiBDCIz91iLhrgIjcr
	QMLbFxGyM5Nd7D39JYNHSPBy1S+wyBbzdwBasyNU96hqIss9U/l+fRFpkYO3
X-Google-Smtp-Source: AGHT+IF2PpXr5476Y7hicTLds97Adp0NKs91UzW7FpffnBlOfg/n2q7ZvHlZN/aCpKgim9tfC5Ckig==
X-Received: by 2002:a2e:860d:0:b0:2d3:1dcc:3b25 with SMTP id a13-20020a2e860d000000b002d31dcc3b25mr2575644lji.10.1709342375808;
        Fri, 01 Mar 2024 17:19:35 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:35 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 01/15] libbpf: allow version suffixes (___smth) for struct_ops types
Date: Sat,  2 Mar 2024 03:19:06 +0200
Message-ID: <20240302011920.15302-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E.g. allow the following struct_ops definitions:

    struct bpf_testmod_ops___v1 { int (*test)(void); };
    struct bpf_testmod_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v1 a = { .test = ... }
    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v2 b = { .test = ... }

Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
resolved as 'struct bpf_testmod_ops' from kernel BTF.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c2979f1b471..e2a4c409980b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
@@ -958,8 +958,12 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	const struct btf_member *kern_data_member;
 	struct btf *btf;
 	__s32 kern_vtype_id, kern_type_id;
+	char tname[256];
 	__u32 i;
 
+	snprintf(tname, sizeof(tname), "%.*s",
+		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
+
 	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
 					&btf, mod_btf);
 	if (kern_type_id < 0) {
-- 
2.43.0


