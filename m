Return-Path: <bpf+bounces-71345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85241BEF2DF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 05:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBD1189A106
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF729E11A;
	Mon, 20 Oct 2025 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7O/m3tk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624F29B78E
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930462; cv=none; b=NEf5Xzwc1XcyW0ckAt9gh8dd2jZtCYeYfDaCCLP6DRH0xpapR4JuIgQFVVc/Q7kMxwadxc7jT3tiwnSBNwFafEdtTlICHoLAX2o7Kx+hAe0tvXID0FOk5NZgJc1w7F4tAbct+XLViTM3mIFDjJHVrxT6EfW4UchmZyydfZuYy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930462; c=relaxed/simple;
	bh=02mAjRZzX3qpNXnaQskN3odGP+YQFzrvZyi8liAZWxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cq5vEsBqfYJAWKBWzm0yywURlgqnXsgILLQ+Bd8fgAkSSlsD9WuVSOYcAznZ1IzDkeoZCACcDVVG9iBddvFBopnIvqBGMW3aiYcu2ViEtV7cgI9aRw5mL6HQ3c2wZW1hWJbfX6ynu/Q9B0DY5NIi4bL39MwSEihroqn/Z6hU+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7O/m3tk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781001e3846so3617643b3a.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930460; x=1761535260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHI9VYRgU9NCjspHIFvlmxvN8Co/N4RqDwPEZAFmUys=;
        b=B7O/m3tkwTzMXZTuxvCcVEsJLu3ocq/9OuDuNuiEMbxZWt0y525dTaN4W1NNOaaPTM
         1U5O2skVyIkFCXI3J1Jdi3udwccbdPOPRA3pgb2KNRsfOVsN1IRi7JDtg0PC+jIegKbC
         5H5xvxm4y/HSiIkiVRvhVkyF/lPxxyPtw65hu8av+rZd5Jxu78l96ox+FgUwmIS2v0j4
         u2gmQao3MybBxWMXWyVle3Mmg1PhP7ppPqUzpwqXGHLPjFpx6K2QRWApSuYJwggaUqnc
         fQYj0/dCP4d3pJDRNRfFzy/oDMgVQrzxUntAbBmEJsgKoy/3JSFKEs3Ib00c7YbeEpcq
         k/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930460; x=1761535260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHI9VYRgU9NCjspHIFvlmxvN8Co/N4RqDwPEZAFmUys=;
        b=nA5WiM4R7KY5IEiaRIXjaF/gr3ByMe7UMQmonBiVEI4TqkbcfVr/rtNiTYPn85kVYf
         /qGt444+J+XZH8zjbOht9Io/elY8poRnjldRCwjgFhrqp6B4HPfVvrP8VHdrijYwQEVu
         c0xsRQFNBGfPHaiQ3j059MlBQu0oDDc5PlCcbOy4QQKjPIF3fh3EAztsaYzFCLe+RxWM
         MzI3r1uKBhwb99EUtN0hfxECGnBpWae6FTD1R2+hweaY/8L8sBfRNPEEuIIg/sBdHA2L
         EeKuU4OOpQsXxeGoIIO+zI1frNQ0MmOsmxuU/5BlU2TDHRYbdKhW4I+JBrIs7wHaiqKv
         BMqw==
X-Gm-Message-State: AOJu0YzZ3yf0eP9P+VByHUc9jnhm8k7TDSU/x2UWtRgBaeLkm5/r6xe2
	G/V1rDv94JI6jQu2kI+96bWS+9XTnfkZ7NAS468Xsra59etoQ1pxPBX2
X-Gm-Gg: ASbGnctZyQddfsNS+Fzbt+PBCcwwlhES88BXPXpeYMCiG4lZbPr55Wb4bo6tTW5j1Hv
	uyQhr6bmfyvPY+7Jop4TxfcXpSG08WYpJdx0HUMVO2FiO96XNkv6p5mevgP61Ki1fncDNPi5RRk
	7iciOiAoVZLk2hujoIpmshfXKWJzD2nKUUt++FOpZMrq5QBwyzeLi9BNMDewKk8Wa+MvhXtQBqH
	5fNEl4hFAVVazUgNfNGYfoYiWdHreVY4DxPsdGVaN/LIw9tQGITUPtH0pK7Hvj+G5nb5Q7+rHXk
	Pejk68VEBQIR2k1dDsSBgla8+fut5easiOifcuNaNbfohv5cIvI2TFdF+9EJuAsxg9l1rjvvgt5
	CduNCe3tLwIy9XPeavyNGZKaf2Zy9oUiRl2n93+TJBCXMsUgAdvm+UEF3YrMVGSC5Iy1m2vCP8p
	UqpCmH+Y4P0l1NRFINTozJ0oIszWQo13nhQs0yJBUBRRmY2Q==
X-Google-Smtp-Source: AGHT+IHTS7P4RInRCl/RZbmpnrgZ1U3ouz5pEHqmpv7QdSk7Vr1Brl+6pmiWgq6O7vs34OVAviH41g==
X-Received: by 2002:a05:6a00:2e1f:b0:781:24ec:c8fa with SMTP id d2e1a72fcca58-7a220b2af8amr12763024b3a.27.1760930460008;
        Sun, 19 Oct 2025 20:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39437sm6770459b3a.27.2025.10.19.20.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:20:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 10/10] selftests/bpf: add test case for BPF-THP inheritance across fork
Date: Mon, 20 Oct 2025 11:20:32 +0800
Message-Id: <20251020032032.3393-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that child processes correctly inherit BPF-THP policy from their
parent during fork() operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 0d570cee9006..f585e60882e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -267,6 +267,37 @@ static void subtest_thp_global_policy(void)
 	bpf_link__destroy(global_link);
 }
 
+static void subtest_thp_fork(void)
+{
+	int elighble, child, pid, status;
+	struct bpf_link *ops_link;
+	char *ptr;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		return;
+
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork"))
+		goto destroy;
+
+	if (child == 0) {
+		ptr = thp_alloc();
+		elighble = get_thp_eligible(getpid(), (unsigned long)ptr);
+		ASSERT_EQ(elighble, 0, "THPeligible");
+		thp_free(ptr);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	pid = waitpid(child, &status, 0);
+	ASSERT_EQ(pid, child, "waitpid");
+
+destroy:
+	bpf_link__destroy(ops_link);
+
+}
+
 static int thp_adjust_setup(void)
 {
 	int err = -1, pmd_order;
@@ -319,6 +350,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy_update();
 	if (test__start_subtest("global_policy"))
 		subtest_thp_global_policy();
+	if (test__start_subtest("thp_fork"))
+		subtest_thp_fork();
 
 	thp_adjust_destroy();
 }
-- 
2.47.3


