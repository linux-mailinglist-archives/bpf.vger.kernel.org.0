Return-Path: <bpf+bounces-30420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D328CD94E
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FD0B21197
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC281723;
	Thu, 23 May 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2D63vQw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA2763F2
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486142; cv=none; b=qHffClVBSMFIJ/emP9gVv9eL9ciLOQJIgCHYKNVFeSNxdE0XBGIhJPNs4LJNelAInUUaOnBsi1/jCQg4Mvv+sdflZptfc+RuvqRArpreFSKCyfJUzXCZerwr0AbuSB2pEUivNhtZyqbr7VYnaZhLUVgrqF2VSXher40Bzj7Hn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486142; c=relaxed/simple;
	bh=pnfwEmhJaGJnnF5pQds6sqgpSop4ID4OueH53SaCbNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItSbxpNwmroAvUoEOk+tYjgP1phYZJPCZenEA9A4GsMEn6NG7RFaYwQnX6KRlJImlA7vJYYMkl8QVLNZBtHPhxjCdKFmqI6tKzCOFqVpBmvBD0ISuTUU4oYggjm8GZ7FI9sG9uYVkg/kD3+vP64d0fFxbKGAKXLCrgcbSH7pPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2D63vQw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627f5b7b75bso9804717b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486140; x=1717090940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3VSzMOsCVcU1vd0IqZVW+SxoJr/0Bn4dYKhvg3D3Hk=;
        b=e2D63vQwayuA7Xumn+hRbd14sVxU9mU+Qkf6tJC0lgJv8/iznRVxmEovs4A9YSpN/x
         9mLTg73pykCT49N9ct49x9mlorGbsm9sqMJxSlP4n0KF+lZMiawcj2SawVUFL3D0J/mV
         w0xmMdLOd/WZRrP/4Y04kkm9/y06DwmmovrLvpgqNTu1ObGJfH5M+uyyaU7pIrA0Aksv
         g/4V1pvFCYYZwvF58fPjxpLp7Ho8p35ZKAxDPWTwRn4ZiMd3cr1bQz4VUiXbn+cA+ymQ
         lfAFcbKI/FtTF/nrw0AwkaEPNw1YQHrXFUIZBAgZqflaAPfQMqp9eMmRexi/NB2S47vB
         yniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486140; x=1717090940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3VSzMOsCVcU1vd0IqZVW+SxoJr/0Bn4dYKhvg3D3Hk=;
        b=xUjjsMNR8xakLZnrLRSoQrzYZeBZKhXCrW89z7JPitLLK5hUXT2kcb5c/qD7TFqqa3
         4E/jrrm3pvn0QNCXx/Ol6vONxNJYfhbfytd6l/cjaeBH8dGsONZ/uEUml5g+Ym22abo9
         F/zM5wvZD9ASjqFE8A06H50inPeXh46V2NIZKejKBoHYAkorKAUv2RlrMNfWm6z7xpwL
         MuKM67nJnfB6gRiPtWRPAgIBWFWzih2AYG51n5uBHeHcUY+Vk1mQKDPpmCRR/MpmBh7I
         Hdbj6EPVLX6kL1jNEF35rlToKb9dq74rP0PAP7IXLsLy3VTXDKrK8L4vOshLhFKSO0lV
         0CDQ==
X-Gm-Message-State: AOJu0YzxE0BrYgCzRaFPrLWcDm789cTIiyBQGpM/dbOsSzLRpJ+JPb35
	FwbKtwMkla+B29QYgHaV2P1H2H6NDAB5n///GtD+2V8Ih1duzhnve7t2zQ==
X-Google-Smtp-Source: AGHT+IGa0ExyWcX7eFVT9z0nWb503IWwGU073NA0AJ+N3/BtbHiWr2NT6MIgCf4qIYCkogdQOpC+2Q==
X-Received: by 2002:a05:690c:c99:b0:618:88d1:f15f with SMTP id 00721157ae682-627fb1ca4c5mr23859287b3.0.1716486139899;
        Thu, 23 May 2024 10:42:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 9/9] selftests/bpf: Test global bpf_list_head arrays.
Date: Thu, 23 May 2024 10:42:02 -0700
Message-Id: <20240523174202.461236-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_list_heads and fields of bpf_list_heads in
nested struct types work correctly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


