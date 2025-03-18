Return-Path: <bpf+bounces-54322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FAA6766C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D6D423430
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055320E6F8;
	Tue, 18 Mar 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iY2hQICM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194720E6E2
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308202; cv=none; b=KgwTS7GZsuqJIzN0d91rn9SlCOOQfE4+iFwgNwUgyNVpW1O6lJr3K/27lf8nCK3o+0x/NDlYKt1SNYNsq+ZSfdNL1BXPCOGBqvc17dMTbYBLrvNNpPkHMkdTRJy/Rc6N8KRhEcaj2wof0RulthXWd1DkgiWbBa4JhfABjiZ01sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308202; c=relaxed/simple;
	bh=zQ7/dHBZljjlgHP/3vaiICniOeYTB53FFv8JxKhUBgs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xbz0y96Kj/p/6VtgQhnvYiQPzH94JWG366K8Bc16cfHlfnfHYZTr8cefeB2pbH/MIyxw4z5lL25atDWn3LDRs9nnElPQEYj2MLMgKTisKQT8pXAkJrAeHMpsW7F24JujOiCBTBQEJJ0AUmQ1PpTj5kLYiQYJDbN71JkUe37mLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iY2hQICM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4923244f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308199; x=1742912999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ADSED4e0MGV34JcG66p/mu9LelpGe5lW/3uFuggSmI=;
        b=iY2hQICMsZKG9Xx1WxkW6pp5hc3oTnPPajXy7ljQLafbuymM/ngMRmGPPT5J7dltCl
         kBy0qIxcmL5YOilP1zCkd+2lRrWYXHdSQ3GdJckPElfc+YTOIWbXdKmPVsFSMGG1vALY
         POW/C8jlVS2Z/sulnxK3iNtfp7dMRWJCMpsgW/TuFkBMPlSmy73G41C+khEDxOvV3cNp
         Khd3Hcr8rwHIRyerORmHL/rZkRKtuLdTxEV/FKGIyPTqAEzfOABxC5+ME4qO3qt7N/Cg
         g2XrjpVpUA0VJvjUNMl3rRO/ZgVifb5fO4SGQS6ICtlu1Aykv5daqERCKQsXEyD/VHgz
         vBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308199; x=1742912999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ADSED4e0MGV34JcG66p/mu9LelpGe5lW/3uFuggSmI=;
        b=V+xO9T1gMXTe+X8rRCMvV4HXU72ZJoD8jGaGITLzvzPQZSiyKshA2glFce0FuZYDZw
         d/6/nLxe/OYLwH9yIHe80VNMwlGGZgZRW1sjnfAUSC/xFMEpBsXYegbK4gBfW35sTo5p
         7YruwMm9SLeX/T00vWrnrKfWg8NP+lUL+VxLHGhWSc4oNVa0gAfZMBQgXXFkkYyNCfkh
         KwVXgNRjtkCESB2N2iulWTvYzLM8ADMCUJD8rejGBSwtZznVtuWqzd2adTLLMUsHtc+e
         gqXd70yIEqI9TXfhM2twW3/XCNd3jK9BU55tBSxgKpipbghSnhRg1JyxD7hYDbf9XVCU
         kTiQ==
X-Gm-Message-State: AOJu0Yx235EpSAThzx5uhSk7ZsKro1gMOtBsYpMz2SpJsZ6haEnzma5T
	h9HD6hFmi4MLeMMF6Wu5Qei/r/1MNE+bVm7DdtTbQrQtd98A4aH8C3TDi17ib9dCY8RC+CCXkgF
	t
X-Gm-Gg: ASbGncuV/h1hhcyYX8AE2KrZszen1lv8UXraMfHobhDhR4vvTe1+ZRP4Uhr2DB7Op6j
	ivdj5ppM8HWVi9EMfRNABqARG7+S2LYNISoDYEhCZjtTZ/k+YDtpj4WKCaJVNc9JnQxNFZ4k4WR
	emv1GTn1GlwhDajZoPWwWcEUaEYOnumS1fWPaDWfL7Q+8a2qLBmYqdmWzZQSiAEOBIoD0bfu1Ka
	3zj4d13Iz6smnBb9TmsuuoG32Cms8Ww/Zs6z22sY/5GJn8an93am9TXajHFiUr/Ij8c6UP6s+hq
	Eaibt5etMedX+iutWYmdWeF2KCo3tOS5uNL1ejMcPKQGeLISAOC2bXbDXKuJNDIEjkaS
X-Google-Smtp-Source: AGHT+IHTqI2z7IL/JkPcvMGEwa8E480nMFZuxi69XNDGYWjVjbSyc0ZhlVWD+/4qDRX01M23gwNX5Q==
X-Received: by 2002:a5d:47c7:0:b0:391:4835:d888 with SMTP id ffacd0b85a97d-3996b49910dmr3741716f8f.42.1742308198684;
        Tue, 18 Mar 2025 07:29:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:58 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 13/14] libbpf: Add bpf_static_key_update() API
Date: Tue, 18 Mar 2025 14:33:17 +0000
Message-Id: <20250318143318.656785-14-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper API for BPF_STATIC_KEY_UPDATE
command in bpf() syscall.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
 tools/lib/bpf/bpf.h      | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 37 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..330d9523fc2b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1331,3 +1331,20 @@ int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
 	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
+
+int bpf_static_key_update(int map_fd, struct bpf_static_key_update_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, static_key);
+	union bpf_attr attr;
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_static_key_update_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.static_key.map_fd = map_fd;
+	attr.static_key.on = OPTS_GET(opts, on, 0);
+
+	ret = sys_bpf(BPF_STATIC_KEY_UPDATE, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..c76abfda85f8 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -704,6 +704,25 @@ struct bpf_token_create_opts {
 LIBBPF_API int bpf_token_create(int bpffs_fd,
 				struct bpf_token_create_opts *opts);
 
+struct bpf_static_key_update_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 on;
+	size_t :0;
+};
+#define bpf_static_key_update_opts__last_field on
+
+/**
+ * @brief **bpf_static_key_update()** updates the value of a static key
+ *
+ * @param map_fd FD for the static key.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_static_key_update(int map_fd,
+				     struct bpf_static_key_update_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d8b71f22f197..fc8f01d5804a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -439,4 +439,5 @@ LIBBPF_1.6.0 {
 		bpf_object__prepare;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_static_key_update;
 } LIBBPF_1.5.0;
-- 
2.34.1


