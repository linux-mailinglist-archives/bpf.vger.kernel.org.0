Return-Path: <bpf+bounces-29027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE98BF64D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2169D1F23A66
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84AD18651;
	Wed,  8 May 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR/Zu3Ma"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94D2263E
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149956; cv=none; b=o+uSR6MS7gEDoVr8FzlouI68i2iCxLJQxRfwMxsN5SFEl/YVtmLJ4eyDdXFsrj27z0loKf9CfCtW/uoj0glpdiMpTBUAcfYMXPZ4we+58VVl4Ij2YWyUkh2INanBcD9CeGUUEje3/h10ork7Gh8+P1DTBGzyL2aKIrwkWn+Chhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149956; c=relaxed/simple;
	bh=T99aEuo7lB5fd7ns1ZsNRt0u99NUChuBc++AQ35NEN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMl+1SSmKgwE4KyppNDSuGz0MUXx+gJsZ1+fr0l2EAZTGxZ2CVGNY/PUciPfG6L3QnsDOL41sYvl0aJv4LAhwJJenD/TxbU0RhjlDZPqZdjyKFBgEdjnu70emHE9U3E1IaFI1jEGpXcjP1J3GuSC9dh7pFBjfZUckceDA3hYURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR/Zu3Ma; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9539a7d70so203370b6e.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149954; x=1715754754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=CR/Zu3Mabsj0K2qlkyrRdf1VGdGas3F4ij/gg59Pq2LBVPdRrUauAKdu70195qhom0
         E9De/1YEIX97Cshz9zZkqDWJsAKXz87ZWE+fzoGVwtFrUw6s1MrZaH4Je/mrBmFfehAg
         wnPOnbiza9FuwXAvJXzF9EW2iVhFcwWCOx3BwCNxgUm/Y9O0hm9uRHU3P+VVEJhWQWvu
         dWlmnPRnKtYxXxhpd6GH6QwWuqhqU9ERzqMoVJqfH9d40yEeyXYZnsOsBPRW1OJM/hEl
         /UbHJiPjhjBtbZJlpc/w+/20fNNdAUSnK/pp7RGZK9oclPX5FeXYBaP04WrGtkbkxip+
         r5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149954; x=1715754754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=n9BA2boTOZxXnoLsCeOy4viBE5mOYTwMfBtIUdMKt572qp0vZBw/iCJ5axYQSOzk1/
         MbiYPE2kCUQw4hoonHkFRmxZ7s7sTbfNDNafnbkQ94v7fnGCVa9C4whXGdWJ0C796v/Q
         USX3t26z6b+wlrHfyN9449YABuaZr2pFgfXmnyri440heGZFzDDQ0KoIMuZy3EJCkpyq
         GocQmXmtvCBWqBThTOoYGkVntu39ZzvAl9xmCq/Z/mKnYG9CJSlQRhSLnynOvu2QseIc
         jzZniObeK+meJtXtLDUoURlcjJ0jYQAo3CXdMUO3VL5ZqbfX/TiWRohHAZzLoXyXCnlf
         /Lzg==
X-Gm-Message-State: AOJu0Yzuo7/Y3zoHAVeozzZBBKmSn547+AK1M/nrCsxFFxy1aGiRi50u
	EhgFz+ZDj6La1HkjEPVMBeBkAdR4O1CJZJOVt0WLmEoTzQQGD0a5ntZPqA==
X-Google-Smtp-Source: AGHT+IGasM8subQBEBfInGyLHbHY0lLFI9GqFYuYcl3j2VUN9u7JoaU2UleOJnQvHC4HIdGdxMGLcw==
X-Received: by 2002:a05:6808:2746:b0:3c9:6a82:4ffc with SMTP id 5614622812f47-3c984b72431mr708507b6e.12.1715149953883;
        Tue, 07 May 2024 23:32:33 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: Test global bpf_list_head arrays.
Date: Tue,  7 May 2024 23:32:18 -0700
Message-Id: <20240508063218.2806447-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
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


