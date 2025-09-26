Return-Path: <bpf+bounces-69821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8BBA32E7
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03CE17B5D4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA329D289;
	Fri, 26 Sep 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVora+UU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD92BDC3D
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879312; cv=none; b=ACtaPDRx4MDYno8+uPS2xTqgUFRbPOJl8CVK/XBD7yDYfhw533zhp2S9ViYIfihzWp3sYpXvPKn9LQYBN0mJYV1bQj3d0AIgNZ/Ku7LuIgef9dX7hgICtPczOEge4G5zrGRKQfWV6HqaBY2It+OWMz/V16w/0Jb5GZDWtjWHByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879312; c=relaxed/simple;
	bh=zrlWjexRS+e6cnuSCMRZ3/yt6yu9oHpAebCTZ9vSuDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itXIeGfdo7/zsAFDWe2m4Vbu//WovJuDMfuShB4hA6h94EzfltEv+ieo1J+3hXFso2zum4otMVamWpOlkRTHFHFvwapAeRUacoNpbENqqzf4bYpSXidCNW4pbOZslMBARETsrmGKlzn6ssfSNJK1fgWkrOvoOXYPuJQlbAaVq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVora+UU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1407358a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879310; x=1759484110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw7WNnQLHMUa0Yn2DLPfVIa+t6BCCpmxXRHnFLCbq0M=;
        b=NVora+UUFXjQA9a6jq4f8i1ID4HKYlAjXIzCMjvNJ8PkLP//n0Iu0L9CK352sg9XbS
         Z8D4pBWGZKt1Kjhb9O6fBiBDHp0O/SYsRs6gdxO6R02mRnQ5m0lG5pDM4UChnH1+jUJw
         bzX5V9YiFycDZGiXZLyQG9KyPUERRKqDApjBr7kzmaAKVm9IPDTjxagBvV3nXRJW0k7t
         PTGCv5Bakkx1iG5DFsN8dKD8Bx144kY7iZf5VgOyShNTKYDJROav6usuYe3b/bQOnrmc
         b3TIsz0fsXFBsDjPaZzjV6Rw64+N+wgWNGo+n+gnBBDxAaeOgEga9bWJmKvfapWSzT/H
         HVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879310; x=1759484110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw7WNnQLHMUa0Yn2DLPfVIa+t6BCCpmxXRHnFLCbq0M=;
        b=l+3Pybt7jzff07/UiNeAivFErpeHBJA4uRWXyh3xfTiHveUVGS2uUZrnjYRgXJ91zv
         P59wEJ5FXyRYpIy5zTM2Iz58xmDguddXjBqs9BSEdCe6hF9NRLR5/Se1AVTRis8jJqgR
         BLdTZVYN3u8kLdCMjoqeLo/hbLV2QNGELa92BNndlm42MPNBvHB7S0hYFNdnkQkk8A84
         ct4Ra0rqyPwJ75j97dMjPKZOLWpBqQsZL2xWk7csAvotAe5/juMAMFknzSj11vhCu22N
         NrcBr6pIFhEuHgciTMX/E+4YZ8IE8Gdaq0RKgNwkcJavC8YzbggoJjTHOim5pqbsY/6h
         crcw==
X-Gm-Message-State: AOJu0Yw5gnN6IbD3hx8Iu+udXbOCSa7sqEifxaCx7Doq6Uiq/7ra/0Zj
	+w9XzgjZDQXs7EpU1TdrJ3ayKSX20/uhCLErNiTMnO80Zui9I6PzoH7q
X-Gm-Gg: ASbGnctGny9LvOW5yo7XY4Z+4Ch1azDtF3sdnEvHjAaYmC5PXNX+z+m1v3riXSkojII
	o66DAGMDREt46l5MOtBSrUHMM8gIfX9iYiSwLF1KMIFzeTw6fbGZjhY68anhoxqf17q4F0tHiGQ
	rbIs9QKnVrLzrT1gVRNMuX9NRlYmpazDmH2yatE7h7AbBKpiP43OFEFzv3fNz1fqn73MVwnu/wt
	+AXA7HDhiWda9L141AO4iJFVueQtxBY9OUekgSnPKqvRuOHc2mVoIrmIt+JVAcNnTZ1NkKAnGTq
	JuencWUKw4ncKSLiNtV7gwawNmYVHfD8jYgSH9GbTPVEbeyuWX5d/NVcd2z68UO3Ba3EpoINMow
	YxVUzpJCDKAg857X0malQcba0hy7OdF3ehTRjKCZXOwFOMmuWZGMgkZ0L2FNVj5mG39kcWFyNtN
	G/v0GuO7+Dx0d/
X-Google-Smtp-Source: AGHT+IEEuMzIy4jcfzpCO06+83GzrwWygKfi3d1uaHoYRS3Fbpuh2MpzvVbrFawoF8VwJAU/udjvNw==
X-Received: by 2002:a17:903:37ce:b0:278:f46b:d496 with SMTP id d9443c01a7336-27ed4a6085amr60657335ad.55.1758879310067;
        Fri, 26 Sep 2025 02:35:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:35:09 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 10/12] selftests/bpf: add test case to update THP policy
Date: Fri, 26 Sep 2025 17:33:41 +0800
Message-Id: <20250926093343.1000-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case exercises the BPF THP update mechanism by modifying an
existing policy. The behavior confirms that:
- EBUSY error occurs when attempting to install a new BPF program while
  another is active
- Updates to currently running programs are successfully processed

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 23 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 14 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index b14f57040654..72b2ec31025a 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -208,6 +208,27 @@ static void subtest_thp_eligible(void)
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
+	new_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_NULL(new_link, "attach_new_link"))
+		goto destory_old;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	err = bpf_link__update_map(old_link, skel->maps.thp_eligible_ops);
+	ASSERT_EQ(err, 0, "update_old_link");
+
+destory_old:
+	bpf_link__destroy(old_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err = -1, pmd_order;
@@ -253,6 +274,8 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("thp_eligible"))
 		subtest_thp_eligible();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index ed8c510693a0..8f3bc4768edc 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -39,3 +39,17 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops thp_eligible_ops = {
 	.thp_get_order = (void *)thp_eligible,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_not_in_swap, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	if (tva_type == TVA_SWAP_PAGEFAULT)
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


