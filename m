Return-Path: <bpf+bounces-30051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90348CA372
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EE51F21E75
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563D13A25B;
	Mon, 20 May 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnw3AeEq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBD13A24A
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237636; cv=none; b=VA1Dg7VOxNbrunZO6bHHgIF3tyRF0aQUGbKTkaZtw7dO9OFkzUlyPQM5UCL3H9bkqZv0gxgVziVD73S7ggiDnle5ArsQ0y+vOZPWa93SYICmw/w2imhDcsR03sFDe3IDO+C09H90+pl1I2Olb6pnPrsQpgyUe9tjGFFIUecN2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237636; c=relaxed/simple;
	bh=T99aEuo7lB5fd7ns1ZsNRt0u99NUChuBc++AQ35NEN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXwt05OV4+DBAGCqFVw6VKf8ziJBqimN+qtX+aygipgcQ4ZqymNdiSbNTWeFoSVVAxg9IPASHoT38D74TRQOUafD5mL2PCF96sRxEEhaYdSrSfjfBQR173XW19Wz+1miU/1+R9yHfMfu+m1FXwEcms5UtRKDcK6MjfHjI6pj67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnw3AeEq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61df903aa05so31609767b3.3
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237633; x=1716842433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=Rnw3AeEqcBVkvOVg07zNf8PyZVJ75USQRJXvARQzhPWxMNEL4llgEXYu+PXF7K+xei
         hrFCzGHU2lKIu4grWlkoj9UG22YcyyMG0dOIf+7f/YbxSUmh/1VAak/7jR+1ahKq5hh8
         guATp96+XQP84rWeqTi5FUeD6uhhgiFlSTDUP/nzveLVAYLtRj44XI8knmfks1nE42A1
         3+TgkvJ0v8LCiq+ferTf6qAYSCqvMIn64+x9V/piCQog1FHD4f7lJ05iPDljyiLwTObn
         yjjYQLmzCn5qoODldXO+BanZFs1LvCapV+e/andyqrDq/ns6AMOKr6H8GSGBdcQbEBD4
         qwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237633; x=1716842433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=rCssTzYfinHf4T5c5kQzTqkElgvxZW5rcheRFLrKkfADcCS6OiiGsVjzZgN4YCfqoZ
         0S2g5nMG/HODE4KN1qatmkNjZvJEjZrjRjRcDHLQRO/aEULVuBXHJoAp5fPSoa5IAqxX
         wYE/wKa0CKTyBYQkWJ4mb4uCZlG04VPa9LVhqE8TpsNkFzhnTAKh7slHt3KEzWIxiK11
         +y+tJ3cMX7kCDVz0KG0brFGAJ059wppUgTbmDRHkOOPbyLizrAywdjkmCiWq/H3h6phr
         QgjO827KtuePIpUHOwRkPUJyZOsa2I87Rmr/5YmYsKqqAyPmdtG0xQZxmqWhGG8HYNGK
         2RMw==
X-Gm-Message-State: AOJu0YxzlBBqcLD0pHIipGFAkAIp5Uum0QeTfWo/ZM1PI8A6lvsVqbs7
	CQJTwLwiUkxg69AiG4pe/jaM5PZ77G+LMgRvQyIq3DeEPPVCkcb0+pbAXg==
X-Google-Smtp-Source: AGHT+IF7IpFuzRhjpHu2dLYJiW5TDyFmo7l88wdXmy537KbnjyUCqcWHS+y8ddjklI+PPg3xAFFolQ==
X-Received: by 2002:a81:ae5f:0:b0:61d:fd3e:8e8f with SMTP id 00721157ae682-622affa8b29mr405852377b3.25.1716237633377;
        Mon, 20 May 2024 13:40:33 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:33 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: Test global bpf_list_head arrays.
Date: Mon, 20 May 2024 13:40:18 -0700
Message-Id: <20240520204018.884515-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520204018.884515-1-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
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


