Return-Path: <bpf+bounces-48465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE121A08263
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1981889045
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA120013C;
	Thu,  9 Jan 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BhInhKq7"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09E203717
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459252; cv=none; b=f6Vmd1s3EfHJIAQpBAmQcD9NKO6UoQYcCtHeWZhX1jm+kPH8yPrzYgcAxG+8kBaX2HvTLG7fft7ZIHrd6tVfcO+tR+73lo1wxoDBV++LE/F9d+K4hRLyDKUvjmuueP+sFU+JND7fGS+iQCGMIbR6qCEgCimPaX5FXLDxpwpIFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459252; c=relaxed/simple;
	bh=z9lLdUKVcR/GMul2loBM03lhgrU6vv1ZtIGXOZABsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/pCl17rtYctbEkLh+2H9O5LoLltfBeOLbA2fTdijfhTj0uBg8D4oMC5ECNgXvS2A8Gdx1t2hPW/w63c2IYw0ax306oaupGCqome+XKB9QPQN8PquLT4NBVEXrPV5Ep8Zj7GYyNubkhDdoMw6AFXUPwA3FFaMHL0aOs1HBbG8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BhInhKq7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id C10B3203E39C;
	Thu,  9 Jan 2025 13:47:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C10B3203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459250;
	bh=wxQuDDioVZRxG5JbPKZ4mlETaNiZwxZoLXRs06bAe+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhInhKq7M8IUX/wZ1BqRBxZVZm9Mc9Y446HOYyRUnF3alx7rsjlasOTPk/86uRvaJ
	 ImIzZWJjjlNTTvRoMEUr0qb8o1GJ0aOBhuL7Qy3B8a03iPgMNtM4LTWeSsR2UhAs8w
	 nQxhLT94pVorXw1n5njZ2axZOAMy3D1+0WeP1JNM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 03/14] bpf: Port .btf.ext parsing functions from userspace
Date: Thu,  9 Jan 2025 13:43:45 -0800
Message-ID: <20250109214617.485144-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functionality to parse .btf.ext sections of elf files is currently
missing from the kernel. This code simply copies some needed functions
from tools/lib/bpf/btf.c to aid in porting to minimize changes to code
ported over from libbpf.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 247 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 58190ca724a26..907cc0b34f822 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
+ * Copyright (c) 2018 Facebook
  */
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
@@ -5717,6 +5718,252 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
+struct btf_ext_sec_setup_param {
+	__u32 off;
+	__u32 len;
+	__u32 min_rec_size;
+	struct btf_ext_info *ext_info;
+	const char *desc;
+};
+
+struct bpf_func_info_min {
+	__u32   insn_off;
+	__u32   type_id;
+};
+
+/* The minimum bpf_line_info checked by the loader */
+struct bpf_line_info_min {
+	__u32	insn_off;
+	__u32	file_name_off;
+	__u32	line_off;
+	__u32	line_col;
+};
+
+static int btf_ext_setup_info(struct btf_ext *btf_ext,
+			      struct btf_ext_sec_setup_param *ext_sec)
+{
+	const struct btf_ext_info_sec *sinfo;
+	struct btf_ext_info *ext_info;
+	__u32 info_left, record_size;
+	size_t sec_cnt = 0;
+	/* The start of the info sec (including the __u32 record_size). */
+	void *info;
+
+	if (ext_sec->len == 0)
+		return 0;
+
+	if (ext_sec->off & 0x03) {
+		pr_debug(".BTF.ext %s section is not aligned to 4 bytes\n",
+		     ext_sec->desc);
+		return -EINVAL;
+	}
+
+	info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
+	info_left = ext_sec->len;
+
+	if (btf_ext->data + btf_ext->data_size < info + ext_sec->len) {
+		pr_debug("%s section (off:%u len:%u) is beyond the end of the ELF section .BTF.ext\n",
+			 ext_sec->desc, ext_sec->off, ext_sec->len);
+		return -EINVAL;
+	}
+
+	/* At least a record size */
+	if (info_left < sizeof(__u32)) {
+		pr_debug(".BTF.ext %s record size not found\n", ext_sec->desc);
+		return -EINVAL;
+	}
+
+	/* The record size needs to meet the minimum standard */
+	record_size = *(__u32 *)info;
+	if (record_size < ext_sec->min_rec_size ||
+	    record_size & 0x03) {
+		pr_debug("%s section in .BTF.ext has invalid record size %u\n",
+			 ext_sec->desc, record_size);
+		return -EINVAL;
+	}
+
+	sinfo = info + sizeof(__u32);
+	info_left -= sizeof(__u32);
+
+	/* If no records, return failure now so .BTF.ext won't be used. */
+	if (!info_left) {
+		pr_debug("%s section in .BTF.ext has no records", ext_sec->desc);
+		return -EINVAL;
+	}
+
+	while (info_left) {
+		unsigned int sec_hdrlen = sizeof(struct btf_ext_info_sec);
+		__u64 total_record_size;
+		__u32 num_records;
+
+		if (info_left < sec_hdrlen) {
+			pr_debug("%s section header is not found in .BTF.ext\n",
+			     ext_sec->desc);
+			return -EINVAL;
+		}
+
+		num_records = sinfo->num_info;
+		if (num_records == 0) {
+			pr_debug("%s section has incorrect num_records in .BTF.ext\n",
+			     ext_sec->desc);
+			return -EINVAL;
+		}
+
+		total_record_size = sec_hdrlen + (__u64)num_records * record_size;
+		if (info_left < total_record_size) {
+			pr_debug("%s section has incorrect num_records in .BTF.ext\n",
+			     ext_sec->desc);
+			return -EINVAL;
+		}
+
+		info_left -= total_record_size;
+		sinfo = (void *)sinfo + total_record_size;
+		sec_cnt++;
+	}
+
+	ext_info = ext_sec->ext_info;
+	ext_info->len = ext_sec->len - sizeof(__u32);
+	ext_info->rec_size = record_size;
+	ext_info->info = info + sizeof(__u32);
+	ext_info->sec_cnt = sec_cnt;
+
+	return 0;
+}
+
+static int btf_ext_setup_func_info(struct btf_ext *btf_ext)
+{
+	struct btf_ext_sec_setup_param param = {
+		.off = btf_ext->hdr->func_info_off,
+		.len = btf_ext->hdr->func_info_len,
+		.min_rec_size = sizeof(struct bpf_func_info_min),
+		.ext_info = &btf_ext->func_info,
+		.desc = "func_info"
+	};
+
+	return btf_ext_setup_info(btf_ext, &param);
+}
+
+static int btf_ext_setup_line_info(struct btf_ext *btf_ext)
+{
+	struct btf_ext_sec_setup_param param = {
+		.off = btf_ext->hdr->line_info_off,
+		.len = btf_ext->hdr->line_info_len,
+		.min_rec_size = sizeof(struct bpf_line_info_min),
+		.ext_info = &btf_ext->line_info,
+		.desc = "line_info",
+	};
+
+	return btf_ext_setup_info(btf_ext, &param);
+}
+
+static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
+{
+	struct btf_ext_sec_setup_param param = {
+		.off = btf_ext->hdr->core_relo_off,
+		.len = btf_ext->hdr->core_relo_len,
+		.min_rec_size = sizeof(struct bpf_core_relo),
+		.ext_info = &btf_ext->core_relo_info,
+		.desc = "core_relo",
+	};
+
+	return btf_ext_setup_info(btf_ext, &param);
+}
+
+static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
+{
+
+	const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
+	    data_size < hdr->hdr_len) {
+		pr_debug("BTF.ext header not found");
+		return -EINVAL;
+	}
+
+	if (hdr->magic != BTF_MAGIC) {
+		pr_debug("Invalid BTF.ext magic:%x\n", hdr->magic);
+		return -EINVAL;
+	}
+
+	if (hdr->version != BTF_VERSION) {
+		pr_debug("Unsupported BTF.ext version:%u\n", hdr->version);
+		return -EOPNOTSUPP;
+	}
+
+	if (hdr->flags) {
+		pr_debug("Unsupported BTF.ext flags:%x\n", hdr->flags);
+		return -EOPNOTSUPP;
+	}
+
+	if (data_size == hdr->hdr_len) {
+		pr_debug("BTF.ext has no data\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void btf_ext__free(struct btf_ext *btf_ext)
+{
+	if (IS_ERR_OR_NULL(btf_ext))
+		return;
+	kfree(btf_ext->func_info.sec_idxs);
+	kfree(btf_ext->line_info.sec_idxs);
+	kfree(btf_ext->core_relo_info.sec_idxs);
+	kfree(btf_ext->data);
+	kfree(btf_ext);
+}
+
+static struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
+{
+	struct btf_ext *btf_ext;
+	int err;
+
+	btf_ext = kzalloc(sizeof(struct btf_ext), GFP_KERNEL);
+	if (!btf_ext)
+		return ERR_PTR(-ENOMEM);
+
+	btf_ext->data_size = size;
+	btf_ext->data = kmalloc(size, GFP_KERNEL);
+	if (!btf_ext->data) {
+		err = -ENOMEM;
+		goto done;
+	}
+	memcpy(btf_ext->data, data, size);
+
+	err = btf_ext_parse_hdr(btf_ext->data, size);
+	if (err)
+		goto done;
+
+	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	err = btf_ext_setup_func_info(btf_ext);
+	if (err)
+		goto done;
+
+	err = btf_ext_setup_line_info(btf_ext);
+	if (err)
+		goto done;
+
+	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		goto done; /* skip core relos parsing */
+
+	err = btf_ext_setup_core_relos(btf_ext);
+	if (err)
+		goto done;
+
+done:
+	if (err) {
+		btf_ext__free(btf_ext);
+		return ERR_PTR(err);
+	}
+
+	return btf_ext;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
-- 
2.47.1


