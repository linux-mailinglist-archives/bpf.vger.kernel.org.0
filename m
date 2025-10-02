Return-Path: <bpf+bounces-70203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50334BB4654
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F2619E3F7D
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067ED233D88;
	Thu,  2 Oct 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Skgp20iv"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69723506F
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420167; cv=none; b=VNeBZ3f10kuJWeODWF0ojzM/iVJT8ue1jN7FR5PML8YwNHDkcX7GGf5r7ldBNB0rNrl3xiSNOEwE+k6B5rHmMs2jCPSWrKkTPVw076PsVLLy6Zd0v/fE9onyAfdhChCThm8H5Zd2YVQoQmRW+LjoIDBCdC+AbncMudeOh/GrwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420167; c=relaxed/simple;
	bh=yR0sOLGTjWX4EnBrgOkT/yLThYW1Gm1HNRAwKfyot00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1E0chWYbSFD1Bo9XiR//7A88EvblXCz4i6wRK5UZyqrPHIToI+A6H+R6ijOLDFHGS7qKAw0aNamlH0oar9XVmCsNpiMi+jjmuuMepkBkY0ijM+F7llChlCSByb0ITxQVnumutce6zLDrUmnkd2X9ijOCYDvsMxaNAxF4W7BSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Skgp20iv; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7PVQnLOkfBjJMbyjVJa00+HuYPw7rRNOSRxFp72lbU=;
	b=Skgp20ivl9p81MwYQvASWFef40VLnuvMACBdkdayeLTfVdrxAoQo8v3Ek1zZkGKSzIvkkn
	4jXbxOdKEwMLmI35jzqu57nGZ+DKuIJBPe8dQ4PiJpASg5YNiNLnCXLVpw6gYF+DMBKTRF
	2w28cXzW35DT92NdDe3EdQOruKWrIFE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 04/10] bpf: Add common attr support for prog_load
Date: Thu,  2 Oct 2025 23:48:35 +0800
Message-ID: <20251002154841.99348-5-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_PROG_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EUSERS.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 55 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2bdc0b43ec832..698c30ff99486 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6092,11 +6092,57 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
-static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+static int check_log_attrs(u64 log_buf, u32 log_size, u32 log_level,
+			   struct bpf_common_attr *common_attrs)
+{
+	if (log_buf && common_attrs->log_buf && (log_buf != common_attrs->log_buf ||
+						 log_size != common_attrs->log_size ||
+						 log_level != common_attrs->log_level))
+		return -EUSERS;
+
+	return 0;
+}
+
+static int check_prog_load_log_attrs(union bpf_attr *attr, struct bpf_common_attr *common_attrs,
+				     bool *log_common_attrs)
+{
+	int err;
+
+	err = check_log_attrs(attr->log_buf, attr->log_size, attr->log_level, common_attrs);
+	if (err)
+		return err;
+
+	if (!attr->log_buf && common_attrs->log_buf) {
+		*log_common_attrs = true;
+		attr->log_buf = common_attrs->log_buf;
+		attr->log_size = common_attrs->log_size;
+		attr->log_level = common_attrs->log_level;
+	}
+
+	return 0;
+}
+
+static int __copy_common_attr_log_true_size(bpfptr_t uattr, unsigned int size, u32 *log_true_size)
+{
+	if (size >= offsetofend(struct bpf_common_attr, log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(struct bpf_common_attr, log_true_size),
+				  log_true_size, sizeof(*log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size,
+					struct bpf_common_attr *common_attrs, bpfptr_t uattr_common,
+					unsigned int size_common, bool log_common_attrs)
 {
 	if (!attr->log_true_size)
 		return 0;
 
+	if (log_common_attrs)
+		return __copy_common_attr_log_true_size(uattr_common, size_common,
+							&attr->log_true_size);
+
 	if (size >= offsetofend(union bpf_attr, log_true_size) &&
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
 				  &attr->log_true_size, sizeof(attr->log_true_size)))
@@ -6109,6 +6155,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr common_attrs;
+	bool log_common_attrs = false;
 	union bpf_attr attr;
 	int err, ret;
 
@@ -6158,9 +6205,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
+		err = check_prog_load_log_attrs(&attr, &common_attrs, &log_common_attrs);
+		if (err)
+			break;
 		attr.log_true_size = 0;
 		err = bpf_prog_load(&attr, uattr);
-		ret = copy_prog_load_log_true_size(&attr, uattr, size);
+		ret = copy_prog_load_log_true_size(&attr, uattr, size, &common_attrs, uattr_common,
+						   size_common, log_common_attrs);
 		err = ret ? ret : err;
 		break;
 	case BPF_OBJ_PIN:
-- 
2.51.0


