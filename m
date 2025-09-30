Return-Path: <bpf+bounces-70005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A929BAB9F4
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042647A8C62
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C41F0E2E;
	Tue, 30 Sep 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io7zauPe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE241271A71
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212021; cv=none; b=SHYMRVpiyniHCexZbhjFLMrxdyrLLaJtaxArIh5oJ9tMviS6c2vQskVcfZCsq19fXwj0wqVnHxNLgyCMVM+NDWxno9aZoras3hU26MmLA0jEfi/9ucBBeCQw1XVqrqUVcOE2ud5ouu3rf8x50ty7oA4bpyjPbiLYgPxsjBifMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212021; c=relaxed/simple;
	bh=R5zbW5h2mVTkZ695ePmIiAB1l/JHUe56ilvlBhyPTSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vua3H73PZ6Y8QrkLubpEoqeQ4LnjYwDCepr9QgxuyLVkYT4Vjd0mYwWitAM3xFjC38UsCFnFqmoFlmiVtv2T7C8CggqcHJyWIrrY2ifdLHOOfkRAyC21KzarbyE06/cHsuZ/VPrRK2llhl+egy9BDGoEjWUdHW03Elg8opPB2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io7zauPe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550a522a49so4922357a12.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212019; x=1759816819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIx6JtRigPCSTkRZZksmLfb/7I11NxpDSXp1+H8RPCU=;
        b=io7zauPe92j8Iab3UKDNWGr9ECNd6z3ovZSzeGNv3OienplqWGBhPqRAaX+G2FbOBM
         7jKrM0acttAamBgZo7rX/m/seCs4z5XmxihPDTvlOpFHTS3KBdK5U3aEdzOYoOTQ0xHC
         8nSZOO8KzqD8GsolLJvXu+ZmK3oh7qKiLHv5aGQxPjI4zYtavJ0uw6e0fpub35EPzt9X
         akRqBnPHWB6XPn+PW7UZIEKeZLp5TkNXgeh3GSNjbCWb09LXvGGBG5KSgmpIIz0sAp29
         JTrhaEdY28DO3hAej/7l494SwIR5UAVfI0NvOcS0s5Kx52PJ1DoOTrmjgFhmYOk//hyd
         QdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212019; x=1759816819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIx6JtRigPCSTkRZZksmLfb/7I11NxpDSXp1+H8RPCU=;
        b=tSw481DyIuYCfXkz+yGvfFtk9iGcyFH64SEcQFwL8MHLnFaWVkhPbEKkiRmjqkaIU1
         MH4HuBDoAxQWyQx/VJ5RMDdX0NNJekC267KlS/gLiqgweuufLfuYCKuSE85UsiGBAQgd
         53C0uDn/YOgtez3KZB8/EojmLIAOAahAvCKKbZJOhpaj618xcl6cComENNOwSeN5HSxB
         orj1lA8D/B9LAh66ocbls9u5f4EjAQMQ1YrXRAFa7DjkmfO73D0wLkluHA5m3TbfiTW2
         fAGnteACXbYX0sNq/752Xe79s+inPIn4ph7SH7Y5lWBgRX2+Hk39R3WiIRNHKtY7avb2
         lvBQ==
X-Gm-Message-State: AOJu0YwLzl7B/aIuW0NqdZRRZtnvcj3cuQCSXJ6JMHH7p8z1h7JbqYk5
	QokWzlmo8W3bDDOKDewU7IHptSUO1C6pG9EkvM18n0eyTzvyHfTKePkz
X-Gm-Gg: ASbGncvs2DuDw8T5NZmNnErFplEdkxvNrt+p3IG7j9qvS84o3DXsujbWGNUv/VVJXYI
	MiJrTHocEPfsl6MVEQ9Q7rC1CSAjhb4dSyvzc4KwA0pXOUtYF2QkLH6O7kd0xPgRVb7KreeOFFO
	OWHB2I3CK2EqF6OUSeM3k/nztvJYUV88JL/Fw0Os7LDIbXFAG+O2kh7lHdtsX/dw52s7d5UiUEx
	I21NKGpunTfyalCjkdbpAnGiTQdTous45M/YP4yx9j9HHcBVeLMpB7T1PzFdJ3XEuzq5JGgK7J0
	XJRaaOwudt79B7HvOjuLZupwK82rq/x4sHD2fBjO/VpSTx+XmZusRhj/cQj0o00sHME4PZlDGQQ
	POs8l9PahH1SFd9pHxnZmgNh7/doDaSrgOstHSDncMeo/yvUMD9sckyk4r9nnGNOwlddAIkc+qY
	5DUjh+g62M6AIwQMftLV4zmVDMI5OEKSfzSpe+Zg==
X-Google-Smtp-Source: AGHT+IFMF0W1qCu4x4cjpNrUn5ZcQpDe9+QCy8Fcn/EjOKLeyug2Wicq+5aDDzqbHXeIKGe4nnQ0RQ==
X-Received: by 2002:a17:903:244a:b0:25c:d4b6:f117 with SMTP id d9443c01a7336-27ed4a3de3cmr218087635ad.35.1759212019034;
        Mon, 29 Sep 2025 23:00:19 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.23.00.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:00:18 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 09/11] selftests/bpf: add test case to update THP policy
Date: Tue, 30 Sep 2025 13:58:24 +0800
Message-Id: <20250930055826.9810-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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
index 0a5a43416f2f..409ffe9e18f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -207,6 +207,27 @@ static void subtest_thp_eligible(void)
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
@@ -252,6 +273,8 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("thp_eligible"))
 		subtest_thp_eligible();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index 74ad70c837ba..fc62f0c6f891 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -39,3 +39,17 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops thp_eligible_ops = {
 	.thp_get_order = (void *)thp_eligible,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_not_in_swap, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	if (type == TVA_SWAP_PAGEFAULT)
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


