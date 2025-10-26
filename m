Return-Path: <bpf+bounces-72227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74309C0A5D9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE3B44E2D2E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D8274FD0;
	Sun, 26 Oct 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnBkr/cp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBE261B9F
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473021; cv=none; b=oPHzhbr2A4LLRXp8aRwMDB+kQppnKwQ1gInfK2wyTNvDtL719zTHgdchlfERj4zBXUP1rUK7mbk2kMicmNJgyuZRw/A3la8xSTUudmW1PCtWhFTd4L0HRiN0ulDB17qJCRnRCmf+DaBcgq+Z434jVlzQAURawjB7HccFxUlrMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473021; c=relaxed/simple;
	bh=AZhf0bN3dMzYRxemSSdBnaN8exURAvP50px9ndo8GmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0/htzpVhLI0vQYUPW+ZbT8q3mYjne0Bbi2g4W4vt5H0p95LPQfz6svipWRnHtZaiqKeBSQm4dojrNepF/q4WuklMEFx0DXGtaig3r8Dt6BQ4/FvyQtZrl3uJyksOnUFMqvS/Gc0MZpeIxoO5Y/JfRvNTOFxQnc5e5j0UASMmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnBkr/cp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so3363876a91.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761473019; x=1762077819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4o89aqQquJfXg8DHNFFwhPZpHBrXkamiWZUkDvNw/U=;
        b=WnBkr/cpy2vZ16STTkv94HnpZhbcJDyZ1UT85HeaaGTMNX9djZ2bHw3DccFFVjyJaG
         ZE8lfC//DnnGxADz4U9cea93kNqdE9ynTFaA89P/fQQYjITdt852XPutydQcW1R0YXmK
         eBpX6dO2pveAqIBwHFRrjNTtW7enwKMA+R03Ro6vwoZaOTtkRg6jACbCovPNDfeFdpHr
         vfv4r+4ygSlyviFZgSWiAv98DUEJp+vUk9/fFdsTvVWIhepBO9PrxQk7Vx8Ev6k6wg/4
         +8RChNXN3QBSylyLlwdOcLQpotguq+Pntva0R0v1aIdUMo/qXT7cUmMKq2iXIra1ahgO
         4XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473019; x=1762077819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4o89aqQquJfXg8DHNFFwhPZpHBrXkamiWZUkDvNw/U=;
        b=lRNgn7NgkO6LLIUH224mW3l6fIhcwleeVYHqb5479Ch6Qpz7tRj/7lAU2x33/UYLmj
         xs8QbgtnZ9uoq3iZcHd2ncGeR1wwQ+H3Q/WJoUL3QxGF041a/Y0aszo7PZrZhS4I6FBH
         csMxCxHX4w0ObBHNwp5ZfrAh1I2HeNGFg4J2tnuXZq/2U89Iand2MfofvTCd2DCREUfy
         0Ic8X1nYF81yXyYU6arO3QQsymzZUHtmTrF5jNLjNHBG/DARDoMlsfGS8kHSEv37fIf+
         hnAojNgrMTCRrAjpcnj3U32HpEODkdiaQTVxkETuD4dhYCvj04z4RcXWDllhTzH/D0/k
         K/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMm2JCURTIH841DCDhegx42Z3GZWEGsWNHEci8ntzEOUYNQ/rFzstLIifAMF93/IHu+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCioLXm64e2VIhSnUw4CA/ObqGbcH6CSuangCArZDMu1I7sLra
	OHE70wtntUQa60oh0wT1Cpz2m+CFuSwfGQd/jzl+Rhh1HEONtzHq3Fjw
X-Gm-Gg: ASbGncuOfH1EGWUL3RkCjcEE95cwCKG7ZJTXe0yPLsc2MC7mYBZVJeNn1R4wnIL3EfD
	U438bfRdOzdrs0CU90kBL5RxHiw/xIH4oSSBsEvFG3afbxH4Ds7TwJzGBHE/7NlHSs5lHoNRD6p
	oJsvpsnf5bsPVCKUVwpeZS/Q28ukkYznCZdQHny3ntEOysnto4F3rD6T7T0Ftf5Q14JVnW8nzl2
	3UQ5eu0nivOpQGNiM6718DjS/2YB4h4H2kDuLJ8Miwl5CudnFjjRAnrBtB9LE33lq0SwgUGfX+d
	0FHCzOO7s1BIzlOsZom+bVLjphgUXzcqkw7S+EAWCRNzrtxkoSdwhoFi45JZ2cTG2CuMVbEx05E
	hROqC4FQUwqCm0TNrzk8U/kUQr+TMlwE3F6cyF4V3N+/ulojr49kVvFuNzJfyxURImbpcWEPR4I
	t9kALxLKzb6x+/A7aVYHFs2fyaWb5r2EVST5g=
X-Google-Smtp-Source: AGHT+IEWDnNXiVyz/gd1nQI/808f4jzNUVCrA10jfGdkE98h3Ersd56GF+aeFpUTYUxm6IHK2gsQ7A==
X-Received: by 2002:a17:90a:e7d0:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-33bcf9146e9mr41622228a91.36.1761473019447;
        Sun, 26 Oct 2025 03:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.03.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:03:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
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
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 09/10] selftests/bpf: add test case to update THP policy
Date: Sun, 26 Oct 2025 18:01:58 +0800
Message-Id: <20251026100159.6103-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case exercises the BPF THP update mechanism by modifying an
existing policy. The behavior confirms that:
- EBUSY error occurs when attempting to install a BPF program on a process
  that already has an active BPF program
- Updates to currently running programs are successfully processed
- Local prog can't be updated by a global prog
- Global prog can't be updated by a local prog
- Global prog can be attached even if there's a local prog
- Local prog can't be attached if there's a global prog

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 79 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 29 +++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 2b23e2d08092..0d570cee9006 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -194,6 +194,79 @@ static void subtest_thp_eligible(void)
 	bpf_link__destroy(ops_link);
 }
 
+static void subtest_thp_policy_update(void)
+{
+	struct bpf_link *old_link, *new_link;
+	int elighble, err, pid;
+	char *ptr;
+
+	pid = getpid();
+	ptr = thp_alloc();
+
+	old_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(old_link, "attach_old_link"))
+		goto free;
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THPeligible");
+
+	/* Attach multi BPF-THP to a single process is rejected. */
+	new_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops2);
+	if (!ASSERT_NULL(new_link, "attach_new_link"))
+		goto destory_old;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THPeligible");
+
+	err = bpf_link__update_map(old_link, skel->maps.thp_eligible_ops2);
+	ASSERT_EQ(err, 0, "update_old_link");
+
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 1, "THPeligible");
+
+	/* Per process prog can't be update by a global prog */
+	err = bpf_link__update_map(old_link, skel->maps.swap_ops);
+	ASSERT_EQ(err, -EINVAL, "update_old_link");
+
+destory_old:
+	bpf_link__destroy(old_link);
+free:
+	thp_free(ptr);
+}
+
+static void subtest_thp_global_policy(void)
+{
+	struct bpf_link *local_link, *global_link;
+	int err;
+
+	local_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(local_link, "attach_local_link"))
+		return;
+
+	/* global prog can be attached even if there is a local prog */
+	global_link = bpf_map__attach_struct_ops(skel->maps.swap_ops);
+	if (!ASSERT_OK_PTR(global_link, "attach_global_link")) {
+		bpf_link__destroy(local_link);
+		return;
+	}
+
+	bpf_link__destroy(local_link);
+
+	/* local prog can't be attaached if there is a global prog */
+	local_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_NULL(local_link, "attach_new_link"))
+		goto destory_global;
+	ASSERT_EQ(errno, EBUSY, "attach_new_link");
+
+	/* global prog can't be updated by a local prog */
+	err = bpf_link__update_map(global_link, skel->maps.thp_eligible_ops);
+	ASSERT_EQ(err, -EINVAL, "update_old_link");
+
+destory_global:
+	bpf_link__destroy(global_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err = -1, pmd_order;
@@ -214,6 +287,8 @@ static int thp_adjust_setup(void)
 
 	skel->bss->pmd_order = pmd_order;
 	skel->struct_ops.thp_eligible_ops->pid = getpid();
+	skel->struct_ops.thp_eligible_ops2->pid = getpid();
+	/* swap_ops is a global prog since its pid is not set. */
 
 	err = test_thp_adjust__load(skel);
 	if (!ASSERT_OK(err, "load"))
@@ -240,6 +315,10 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("thp_eligible"))
 		subtest_thp_eligible();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
+	if (test__start_subtest("global_policy"))
+		subtest_thp_global_policy();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index b180a7f9b923..44648326819a 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -22,3 +22,32 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops thp_eligible_ops = {
 	.thp_get_order = (void *)thp_not_eligible,
 };
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(thp_eligible, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	/* THPeligible in /proc/pid/smaps is 1 */
+	if (type == TVA_SMAPS)
+		return pmd_order;
+	return pmd_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_eligible_ops2 = {
+	.thp_get_order = (void *)thp_eligible,
+};
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


