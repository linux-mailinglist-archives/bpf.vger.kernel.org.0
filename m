Return-Path: <bpf+bounces-70205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759CBB465A
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247737A31D1
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF12367D6;
	Thu,  2 Oct 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6vVNP4V"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5F22F74E
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420171; cv=none; b=hp+w7PuaUMvQv2U9yhW0q44u3u2cXgbK9qDiNwgFgBA20RwcjU7+zu8YgKRX/iH0Sc4lI+RxMbNYTWlA/ul4Nh61zDrwp/C8AYfL4LHSYnSxPGCTfIIQHsV8cDGs8qmcRJkUN2y4Opi3dO42gRxdWvbyFRt3tfyMobieBXvuuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420171; c=relaxed/simple;
	bh=EGjLZ3DtcSB37AYIo0Ix3IiJZhlvOzVoMi9M1z8BcAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs3LN50SmftWterSTnDB8FLid74Zu987E/jhbJaDVm0+AuiMkaIXa1kr05kf3l8VJ7Kaue0ZI/DQcge/1g9HrXk+iBd+OEfskdqTgiIGkEdpVFnrVdUo4aJO3sU6jO+e8yVeVXUVxgBRwIEUlaMCzALp+l8bcJdMVKYpVDIT1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6vVNP4V; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZvFOwfGZcoP009ddFHKSCpQzl3KGD3t+dSsQzMzeiQ=;
	b=o6vVNP4VEIrZTwfSkCSsvs9tns1myR9UV7Dh+wIB/hWmPsMhCbKJKw41g9myadb+auVlxy
	tofnAKbHfR3c4m+akQcr3DAlHKxpl1iusd2HbcQPsdr3szYg7oqan5HiHdY85Uz7M5oR2A
	GyqY5BA/348C0QCItXrQlkY7yOB1lbk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 06/10] bpf: Add common attr support for btf_load
Date: Thu,  2 Oct 2025 23:48:37 +0800
Message-ID: <20251002154841.99348-7-leon.hwang@linux.dev>
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
'union bpf_attr' for BPF_BTF_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EUSERS.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3bdcd6c065039..fc1b5c8c5e82f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6151,11 +6151,37 @@ static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, un
 	return 0;
 }
 
-static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+static int check_btf_load_log_attrs(union bpf_attr *attr, struct bpf_common_attr *common_attrs,
+				    bool *log_common_attrs)
+{
+	int err;
+
+	err = check_log_attrs(attr->btf_log_buf, attr->btf_log_size, attr->btf_log_level,
+			      common_attrs);
+	if (err)
+		return err;
+
+	if (!attr->btf_log_buf && common_attrs->log_buf) {
+		*log_common_attrs = true;
+		attr->btf_log_buf = common_attrs->log_buf;
+		attr->btf_log_size = common_attrs->log_size;
+		attr->btf_log_level = common_attrs->log_level;
+	}
+
+	return 0;
+}
+
+static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size,
+				       struct bpf_common_attr *common_attrs, bpfptr_t uattr_common,
+				       unsigned int size_common, bool log_common_attrs)
 {
 	if (!attr->btf_log_true_size)
 		return 0;
 
+	if (log_common_attrs)
+		return __copy_common_attr_log_true_size(uattr_common, size_common,
+							&attr->btf_log_true_size);
+
 	if (size >= offsetofend(union bpf_attr, btf_log_true_size) &&
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
 				  &attr->btf_log_true_size, sizeof(attr->btf_log_true_size)))
@@ -6270,9 +6296,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
+		err = check_btf_load_log_attrs(&attr, &common_attrs, &log_common_attrs);
+		if (err)
+			break;
 		attr.btf_log_true_size = 0;
 		err = bpf_btf_load(&attr, uattr);
-		ret = copy_btf_load_log_true_size(&attr, uattr, size);
+		ret = copy_btf_load_log_true_size(&attr, uattr, size, &common_attrs, uattr_common,
+						  size_common, log_common_attrs);
 		err = ret ? ret : err;
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
-- 
2.51.0


