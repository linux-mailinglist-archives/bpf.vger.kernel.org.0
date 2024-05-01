Return-Path: <bpf+bounces-28406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD48B90D5
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F544B22A39
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DD165FC4;
	Wed,  1 May 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsSBfN/W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A376165FBA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596468; cv=none; b=RjnWHCysvElhVqUZYTg/HnGebkBsPdIqK3HBWBeEjE4KgUnzp3ZSqBB7op9SEqU9tFsB8ni6m5DxNNIuGT/AT+aM1mdn94YD8nu2DlgWENgcurF9iZ/P2QEiHKptueb2RESxpw7UPq9ZMFItBf6zkHI5chDIvE4msTXEOpkbATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596468; c=relaxed/simple;
	bh=T99aEuo7lB5fd7ns1ZsNRt0u99NUChuBc++AQ35NEN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvY6ifmQxT+v6TZi+9sGCwqnOj1xYgyWQmU91ks+sm73A1bF5/+wu6r+l2jMME/2FFrGZU0Ne5/mM+0wKruDBZTKVuBF7vnPeXgWhljyAbvOpIo9ElUrK/QZpG/ov7yQ9qMC88Omk0mYWwpvCZDx46N8OaSmNVhnoZLgmWbJr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsSBfN/W; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23db0b5dd28so297090fac.2
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596466; x=1715201266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=CsSBfN/WMosPDe2nak9q7eOeTf0citnkVDySAlA/kVbDrrPtyFkH9BNF0XM1t6l8/0
         ycNW64vIcGQ8Le7M4l8ywoh/CTKkpw22eIG9bSjS/OHl1Np9Lx2c8rD5ToDYC+QXn9hk
         yUeakN7e6GEhyjopEGZMAmmrIwdi8iLT7AzHUA+HqoRo2cWW9wwUn9ZbzSHkNDuLvj/X
         SY0XEh8D1AKksJWKpv3nAo1gp0hFqSOT8XVlvsEe36AJf3vjR1TD9YuUFux9G5J9j4x4
         H7ZLYJGbt1ZxnTi/YSnvm4CLfIip4x2M2aS5C4t44ilsQ/T1wbG8Aa82fTcHYjT2+esG
         x+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596466; x=1715201266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=u0h101urKleWvlwUawsrSVvs7mD2zYAII3dSZH5Od6nWd2mJXVBUoDHqVp0LiQqKCg
         bdWR5Dvsth/G56Em0SkwqTa1aVSd5G6iw3blJOVmDW/nqb6aXT8OB4UV5DHYVn5JF82J
         qU0vYA7/jFzUc6ws+WeL9JIlccN7pzOwd5/R7VIsuSGP/z51nQ0jNXvkrX8BqlRjH6x5
         HoH3gxaiR/eM5m+v4wqptP4nnFAS677g2Hw4MIjx2AP4Q9USZGtfX544AJykN+NY4syd
         G6ZUSszKiLsq55cFUTpHFuJaMtidPsc+0vwTZhkEu5fvKFN4JtMdlBHRw03FsL3YZHwf
         NE8w==
X-Gm-Message-State: AOJu0YxI1hjol8WJppQeb1YG7HDU/SH8xHiHLyvouwtOPIqNP9bVidp0
	S8mb8SAVcKh0Sw4/AcfOQqw/68sgzrq+Glj3zBytA1053tZ0W1tXMgaPMw==
X-Google-Smtp-Source: AGHT+IHm53OVCpQlt7gK+2OhuRUYCeoOHZLhFK9j7WjuappLVokYXMsJ1NqzymqklIirMKbpZBRfdQ==
X-Received: by 2002:a05:6871:810c:b0:221:9013:d783 with SMTP id sn12-20020a056871810c00b002219013d783mr156915oab.34.1714596465912;
        Wed, 01 May 2024 13:47:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:45 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Test global bpf_list_head arrays.
Date: Wed,  1 May 2024 13:47:29 -0700
Message-Id: <20240501204729.484085-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501204729.484085-1-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_list_heads and fields of bpf_list_heads in
nested struct types work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    | 12 ++++++
 .../testing/selftests/bpf/progs/linked_list.c | 42 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2fb89de63bd2..77d07e0a4a55 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -183,6 +183,18 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	if (!leave_in_map)
 		clear_fields(skel->maps.bss_A);
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_nested), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_nested");
+	ASSERT_OK(opts.retval, "global_list_push_pop_nested retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_array_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_array_push_pop");
+	ASSERT_OK(opts.retval, "global_list_array_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
 	if (mode == PUSH_POP)
 		goto end;
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 26205ca80679..f69bf3e30321 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -11,6 +11,22 @@
 
 #include "linked_list.h"
 
+struct head_nested_inner {
+	struct bpf_spin_lock lock;
+	struct bpf_list_head head __contains(foo, node2);
+};
+
+struct head_nested {
+	int dummy;
+	struct head_nested_inner inner;
+};
+
+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array[2] __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array_one[1] __contains(foo, node2);
+
+private(D) struct head_nested ghead_nested;
+
 static __always_inline
 int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
@@ -309,6 +325,32 @@ int global_list_push_pop(void *ctx)
 	return test_list_push_pop(&glock, &ghead);
 }
 
+SEC("tc")
+int global_list_push_pop_nested(void *ctx)
+{
+	return test_list_push_pop(&ghead_nested.inner.lock, &ghead_nested.inner.head);
+}
+
+SEC("tc")
+int global_list_array_push_pop(void *ctx)
+{
+	int r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[0]);
+	if (r)
+		return r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[1]);
+	if (r)
+		return r;
+
+	/* Arrays with only one element is a special case, being treated
+	 * just like a bpf_list_head variable by the verifier, not an
+	 * array.
+	 */
+	return test_list_push_pop(&glock_c, &ghead_array_one[0]);
+}
+
 SEC("tc")
 int map_list_push_pop_multiple(void *ctx)
 {
-- 
2.34.1


