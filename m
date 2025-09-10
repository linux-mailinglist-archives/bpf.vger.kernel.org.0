Return-Path: <bpf+bounces-67980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31AB50BC6
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45905E6296
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057325B663;
	Wed, 10 Sep 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfAv13T4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2C236A8B;
	Wed, 10 Sep 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472388; cv=none; b=mGEQpL8BJA5NtMCB18aQ7Oc+7uGy1FoVuLFNHr2dHCrYbzVkOuU5WqSclB5xAllgg71c/hQ5xmDPLlUHptJ+3l1XoY6UsBgrvBgAE5Echh+zhKafIzo9dZnB33HA0gAss7dh9DN5Icvpb8D1EcRFhnER/bSB8lKATebcp+WKod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472388; c=relaxed/simple;
	bh=lMxJL3GxzyDfLSDYH9Pd0r3UezB2TAufRRyQOJQYgnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewvYo3p3qHA46keY/8vufzTuUg5vSLQwPJ4Tb9JKqRw6t1Q8t9akOhCBCoyZoSN3gpz7L6hzuGNRGxzFFwnPap7g8jHt+TdDJUs5pCagN8Y8DgBIjjCcHmUGC6FeUBFB1FYzF+72ovRXkmldEQEjLrEt1CQS08K3cnz0qvbTklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfAv13T4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso4849134a91.0;
        Tue, 09 Sep 2025 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472386; x=1758077186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5izMNdfd73NjWTxfs35XyMLWkMq0RaZ+XCNp0b8x8Kw=;
        b=LfAv13T4lm4bJpOoUh1nblC2tUQcsALj5i4FNEba3/7/1jQeSR55KWegT3E82/vFsk
         bUAXkjzJwJ50viFupPMu2LAc21dMegkr5yzeX/JxP4GiQ6zJZlPDO6pwV23W8hZkYKCK
         0ADwh5ynsraGsUPeFVxQDA5sNpLdMwTgpm2wS+YlEjxEGXTtP9/gP46HuCPNMGkio9h4
         M8orIS14YLKHQNigZO9di2NN4JH3zt1YwCNMjh/IkyJsgjf8F1KRGZodY2f3s6mJfV6L
         6/nzs/x91elXJd1W2N++1K+HckDoG7AYSUtTb0Zck4Y2a+I92JTPP9ypuh25Xmj4oPQV
         KIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472386; x=1758077186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5izMNdfd73NjWTxfs35XyMLWkMq0RaZ+XCNp0b8x8Kw=;
        b=sWCuh59xmwOuDHvHGMuZxc9T02AHQ/5rrx6vGhRZdaGDKANkJ1doCyogQi3nrSoUbl
         xx2HlmiYf9B81m3f/EHo6VS4Axa8BSSm7Okn76dXLJjcPlUyNhEEiBJ06Km9EWyUj8IP
         yz4UrBSKQ7sDggKyQRxSbfCC3WehymWdLsesvjUAv12w7lZzuRLm44FuSRBfhiCTw6Xa
         MwbSMU0Y3jDLeF+xD8ZvMIDGvk/IuHRI7UtdFaMjZaCQpDB0D81ZivRh+YF12TRx4aGP
         ah8RpIp5oE9cZShLUBfgGwdQwV/r9/gunxd+YroRUYUa6C/iSnPJDm7RIPy1CRW4H/tD
         d4gg==
X-Forwarded-Encrypted: i=1; AJvYcCWXxrSFFETf4D0ieo7t47OWN0wOPd2BOdrFD2ng1SNbMaikqVjfWlDanJiOMfTXHg3l83bLTrK6wiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJJJsTbn2e9m6ej6sZIqQW17V9FYDELanPnjnZimko99dfUn3
	6uJ2jIJ7LTzOK281lq75qpOjV3YGBVlB1m1iVG2pkIW3YliNPcCUjHv5
X-Gm-Gg: ASbGncvJXsuVpUDUtW2sddW/mVT5S5w94V/0BCpUlQNqXw/4SkTwMFQdqrjsjXZ8OuF
	c7GB3/lMZzFRtsFlZX8HpHZJZEKRMgOXMWDy/UUe4bASUBDZ/33NOyRh2JUK7tFR70BU3JJx63l
	8xEtFjvTj1gmER/bhEPsQaYKHVmGPEKsIJ82a/LvPTlS3DnAsBn4x8b/aJ02dloFmjEM0OiuElS
	sGUhB49c5bIGPTZudbRZTBjzcjovHrYKNoPc5SuJYwTdlQ+l/WJV0JgN0o/bpQ5QVqPvkmR/Q86
	sWe8ENiglJOChaLGUYROhzN9/RXXx3sUgd2bTgyE1+VWbG5hVSSYJU2NPzuvMbSHKpyqdhF/hIZ
	u78MpkilcG7TKDFo2LASpRiu58m9f5ijDb0LT+oIrxFmsfP38u0GqOjF7rq9S2IgEFmJfw7fQOB
	ArcXw=
X-Google-Smtp-Source: AGHT+IFFA0J2u8h5eHEE1sSFtoBvIFpNlDK+fp3zE2M7+Wt2ZAEF90FvfrIig1YTqzYNg1uq2BvfSw==
X-Received: by 2002:a17:90b:2688:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-32d43eff94fmr16672053a91.9.1757472386262;
        Tue, 09 Sep 2025 19:46:26 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.46.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:46:25 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 08/10] selftests/bpf: add test case to update THP policy
Date: Wed, 10 Sep 2025 10:44:45 +0800
Message-Id: <20250910024447.64788-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EBUSY is returned when attempting to install a new BPF program while one is
already running, though updates to existing programs are permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 23 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 14 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index a4a34ee28301..30172f2ee5d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -170,6 +170,27 @@ static void subtest_thp_policy(void)
 	bpf_link__destroy(ops_link);
 }
 
+static void subtest_thp_policy_update(void)
+{
+	struct bpf_link *old_link, *new_link;
+	int err;
+
+	old_link = bpf_map__attach_struct_ops(skel->maps.swap_ops);
+	if (!ASSERT_OK_PTR(old_link, "attach_old_link"))
+		return;
+
+	new_link = bpf_map__attach_struct_ops(skel->maps.khugepaged_ops);
+	if (!ASSERT_NULL(new_link, "attach_new_link"))
+		goto destory_old;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	err = bpf_link__update_map(old_link, skel->maps.khugepaged_ops);
+	ASSERT_EQ(err, 0, "update_old_link");
+
+destory_old:
+	bpf_link__destroy(old_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err, cgrp_fd, cgrp_id, pmd_order;
@@ -249,6 +270,8 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("alloc_in_khugepaged"))
 		subtest_thp_policy();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index 93c7927e827a..175e65c5899f 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -98,3 +98,17 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops khugepaged_ops = {
 	.thp_get_order = (void *)alloc_in_khugepaged,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_not_in_swap, struct vm_area_struct *vma, enum bpf_thp_vma_type vma_type,
+	     enum tva_type tva_type, unsigned long orders)
+{
+	if (tva_type == TVA_SWAP)
+		return 0;
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops swap_ops = {
+	.thp_get_order = (void *)alloc_not_in_swap,
+};
-- 
2.47.3


