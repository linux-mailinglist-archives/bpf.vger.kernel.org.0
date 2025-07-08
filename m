Return-Path: <bpf+bounces-62717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B56AFDB90
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843154E791D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193B233737;
	Tue,  8 Jul 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etij3xHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1443230D35
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016112; cv=none; b=N9najzwtqMZlswpRbbcmAnZKAkuxtETiqmh67PQSDcHQ6Cuem32Q2ioROYhqxC5u73tR9/WwEQ2ErRPyin8oXfBJF36AVE0VuJSFk490lhR/Ry0gfJ4mcM1ouGIugoUkPRW6Y6e0E9bL07zARDyelXNFnRjZKj2b0YtcDzUyI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016112; c=relaxed/simple;
	bh=fkKdYtfx0SOJc+q9fu2Si5Rp1LRvWnb9k1x2HbmAXXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBlbZHkzvn7lmxJWfhl6IvKdECsDChgQ8Cxpu6YaWoz2WP2ZPJyDfKF1GGclcSsLkyQuGL2Rleew52R1qfoUNn2SxHwUA0i3dsj584mzLAadg+DKl/+ft+Rxsa9daIj8ZKFoE+SYrcEBdWMKAXKtBM6glPwDDHWogVEPiDkRtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etij3xHo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3385299b3a.2
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016110; x=1752620910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=396sYJHhp+ioqbxZpYNTKS45PLHukRwCcS0LGrA1No0=;
        b=etij3xHo8dNC7AijuQ2aGhFG2D8eevZ5rieyVqs9UY7GgPMVlW1rkvrEU75MkH270a
         pYX1qHcflurHoEXDlA8K7BvTxiG8dsOKshEoC+UhHdEtcpCAMBRN9p3UUznOEiz2DfzF
         xuWqHtN3FkH99GZXwktnN9RHO5jZCNU8ZDjbh5ZctEHj4cbBzT1+7+rY+UeB3gqIyh0i
         W7W0mLdgTn0ud2woEw5dOSOXUCUIvGwQaEx/6+Zou3YvFEY/EePQwSiai1owpzUvEx5a
         i/WgSBzEQ4aWLaW0YlLkNCJHuf6p5FuLPjDgmEKQqIjH0uoYfhn5LtZh/gLN41ykoVmm
         TW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016110; x=1752620910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=396sYJHhp+ioqbxZpYNTKS45PLHukRwCcS0LGrA1No0=;
        b=emIfFK4IE/8qSXyORRAe1/02whY3Pe8Bqn7JJ1P4HweZN2u3G1lbnLgSqY0/W22CCY
         lGib0pVA61lVasLH/F0V/M1ySb5M1oxiKgbDDPSkO5ksXgR1rIlEDuUiif8O7ME1Ff5G
         qK3QSEUT/3jqNfmKKJD7TdVbLsbWr2YoiI1TrAUi1JWHz/vZnZ88NDWcP+x/2ilkPOcu
         5zYEAWO3qrZNE9o2nBlAXCeZ0F9tFL7f0ajErQyX1LgwrgX/uLA6N4rCqS9mZ6nFGB4i
         SOuxI7XA07uKg1o9zZ4hvt2zKs/7/rfVhjkv+iH783kWqSBVlm5oStBkE7yBO5Xg9l4n
         5ZDA==
X-Gm-Message-State: AOJu0YxiJ2vdjalK7pf0zZ7Q0edtKh0HDHrNZU8gd3ckMpr9P16suV51
	fLu1gtyt1ez67L8yzE2BZgkD/HG+uD5G+UWoqZhgEjQpLSz/Hew9ihAWocjniA==
X-Gm-Gg: ASbGncvu2Y3i5cXlczoOlGBUo6rHwJZYeX2tHRKh87ChgCZMPcK2GkrU4UlmvqFBAbI
	m0PPDi8EVAlV22dhk4VexHBW5IApFiSdLoPxxHwg6AeRa/Jb9wCuEClT8Y0+8QyIuGRLpuN5B8Q
	3ngZfs80gpEUypQk7aDbL909zYGRUUHXALCRYrq15MKnKSoav3fQL54PhKfXcSmdWnIo/QLpEBH
	z0HPiv3DhGI+LWqdMjLAgGSJZ8HUb5TuKybaoETKOxkbMQzqWpvybFJ1CtnDqWsWhufo7ehEkZI
	nyNvIb+l+ZIvtdPIRl8hLbJxrsP4U8vK/nujrWQJwDKQQqTe5qfS
X-Google-Smtp-Source: AGHT+IGbXe327O+tngFmWjkftn6Der3ad+NoGs7tvbTDiTnSTIwSAP71W3hWvNLv1zWd8gEO+JjeKQ==
X-Received: by 2002:a05:6a00:b88:b0:748:3485:b99d with SMTP id d2e1a72fcca58-74ea666191amr532448b3a.18.1752016110005;
        Tue, 08 Jul 2025 16:08:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429fddasm12607533b3a.128.2025.07.08.16.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:08:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 3/4] libbpf: Support link-based struct_ops attach with options
Date: Tue,  8 Jul 2025 16:08:24 -0700
Message-ID: <20250708230825.4159486-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708230825.4159486-1-ameryhung@gmail.com>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently libbpf supports bpf_map__attach_struct_ops() with signature:
  LIBBPF_API struct bpf_link *
  bpf_map__attach_struct_ops(const struct bpf_map *map);

To support cookie for struct_ops attachment, an additional argument is
needed. The argument is a pointer to a structure containing all the
option used for bpf_link_create.

Add the new API:
  LIBBPF_API struct bpf_link *
  bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
                                  const struct bpf_struct_ops_opts *opts);

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      |  5 +++++
 tools/lib/bpf/bpf.h      |  3 +++
 tools/lib/bpf/libbpf.c   | 14 +++++++++++++-
 tools/lib/bpf/libbpf.h   | 10 ++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..c1e66e190982 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -881,6 +881,11 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, cgroup))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_STRUCT_OPS:
+		attr.link_create.struct_ops.cookie = OPTS_GET(opts, struct_ops.cookie, 0);
+		if (!OPTS_ZEROED(opts, struct_ops))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad3..2386ad4a295c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -443,6 +443,9 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			__u64 cookie;
+		} struct_ops;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..f5b71eccd5cc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13110,10 +13110,20 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
 
 struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 {
+	return bpf_map__attach_struct_ops_opts(map, NULL);
+}
+
+struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+						 const struct bpf_struct_ops_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
 	struct bpf_link_struct_ops *link;
 	__u32 zero = 0;
 	int err, fd;
 
+	if (!OPTS_VALID(opts, bpf_struct_ops_opts))
+		return libbpf_err_ptr(-EINVAL);
+
 	if (!bpf_map__is_struct_ops(map)) {
 		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
 		return libbpf_err_ptr(-EINVAL);
@@ -13149,7 +13159,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 		return &link->link;
 	}
 
-	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	link_create_opts.struct_ops.cookie = OPTS_GET(opts, cookie, 0);
+
+	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_create_opts);
 	if (fd < 0) {
 		free(link);
 		return libbpf_err_ptr(fd);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..a4a758a8a25b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -894,6 +894,16 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 
 struct bpf_map;
 
+struct bpf_struct_ops_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u64 cookie;
+	size_t :0;
+};
+#define bpf_struct_ops_opts__last_field cookie
+
+LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+							    const struct bpf_struct_ops_opts* opts);
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1bbf77326420..6998300c766a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -439,6 +439,7 @@ LIBBPF_1.6.0 {
 		bpf_object__prepare;
 		bpf_prog_stream_read;
 		bpf_program__attach_cgroup_opts;
+		bpf_map__attach_struct_ops_opts;
 		bpf_program__func_info;
 		bpf_program__func_info_cnt;
 		bpf_program__line_info;
-- 
2.47.1


