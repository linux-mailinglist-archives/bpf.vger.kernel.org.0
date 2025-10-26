Return-Path: <bpf+bounces-72228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B0C0A5DC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC0564E4792
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011182765DC;
	Sun, 26 Oct 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dij3vFMF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA925785E
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473030; cv=none; b=GL4wWvInTlO8oc8pdC883usUHmvqRNLWnfEcDXC1/Z9EstboHks+gaedYhBhzHTFvCdG2wnfbsggY38flc+Usf+f8o07zm4V7JXnGHIMREQvcFkjS3TMXhSlw27elF8Dm29YsAdJYezPWxBpwOBm2cWCBN2iXY8/qSKXw92avrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473030; c=relaxed/simple;
	bh=02mAjRZzX3qpNXnaQskN3odGP+YQFzrvZyi8liAZWxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3j7a8u8oUXezeNRYBXk98+1FfIILNkocvIFpuV+0u1J4szJIfahT8te/V3sxL99K7fnY58TvndH8C/OOQuD5N+E10znqN5eaKHQsR8cRn6sSHln4SZF7BxeFalHJOm7rLwnQq8uQpoMs2cEvt0gRswXO+hATwfVnsDQrwZWJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dij3vFMF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b553412a19bso2300903a12.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761473028; x=1762077828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHI9VYRgU9NCjspHIFvlmxvN8Co/N4RqDwPEZAFmUys=;
        b=dij3vFMF6taecpPGqAO0tXFK5jntVEaUpthddL8+MT8Nxg+jmmTPYAOaTyYKOimJmj
         wLzZEPNg9d/sEn8c2SgCn2nAMSvR+HrXYx5b38zUNMlyD9dsTWXO0NUqY2WZtZXmd/+9
         penv6F1SnpmlWg0VzT8He9YsLJNX/7PGGr11slF5TSYTrBA2PH59DRzZ7GjOgiMChR9x
         2CmUPLKT206D+ltlWESZ/hy5onav/VCBmu22U1VEuNwUZMBKh/1gYq84nrH3JDvw57HJ
         O3f/6YJ92ce7FubAYNJHcMdB9puE9FKaFozZH65rVpikKooWmaUgs6kxBTfvwa26FiRz
         E59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473028; x=1762077828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHI9VYRgU9NCjspHIFvlmxvN8Co/N4RqDwPEZAFmUys=;
        b=CxhW63pE01qOWvn3bZodgrKylZ+q3zjLC4uD2uplJ5Md9inRRhVH/AR3buDtPmWvei
         c5oJhZ8UVSKg7Ja6JLmh+RcxnEw/5ceZc1/3Bp4LeAZBE0g9alfsi8ZCU79In6wgGDrg
         auQVE6UtFts50Km2wB5itGQb86vPKOKFzXe/8zSJD5aQ/dshTiHLnA6M/B8EN4+inDOr
         OLc2oiHP4kIgWvjwhzMjuTYQ7yuM72NdebNawWnkO6SmHC4czYexCW7EH4V7P5dKn5lF
         XwCKXJCrjd0/utCt3BKh2aNPwLpYL99l1ViWup4DXeqHbiZexgLDlM2XxmPZNiTq0MnJ
         mqDg==
X-Forwarded-Encrypted: i=1; AJvYcCXX85CYLPF4FtDpGHfA+4Gvow2mRgDNm1L+rN9qX7dX+LxHeQqT2nT7dmj5HRCuYjDzDMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdhbz1+YxL4upia1Fzw8bXAoTGMbhkHT4PsSsqAC5IvVfKiXIF
	HvReXNoZ+6jF3OOFzRBTZunmep92WtSt+qA0QSUrC1i0RH3LpB8n5oMD
X-Gm-Gg: ASbGncseJsXWrqzUm6B39AhY4my79ZmM4mnYnSdLuKA1j8p3evZarymuGd3um/GoS+K
	cQ6nAOI46e8XaSyrQ/+QecS4+BEt4Rln+EbeGoPapRIjyyTuSN+5QrJKwJllYlBqi/aS9QwmD0X
	YTQ1nzxH6zTKtJ1O7l7Bq16o6ouC46/n+ALHhqCMpq68G/vPORscRMgjjj95J1jwK3kPwDzf9WA
	BU260pGGc4DAhdUomCqBoo26mqTNbw84kVWr2UL6wuoWU2wdW/Gby06SWmCGG1ZwsmMZzBhpJBO
	6XEjtTiRoYE/tVey/hbh7TJ2G5ByDrkrhLeVLSIn/h2zwc3xCFLyxQ1F0CI0vySrtnLKSmoK1Fs
	ACquUiqEMor4jgeYkW2K8HGXIZaIxyd7aH3p3tD4J1LvRfTyrr4HMujvzwmzJvscpwfXRCmuls+
	TFtHmcOEEgHd+8y9QnxB8Khhi4lOGKt5gcYQLs4joWlWwo5w==
X-Google-Smtp-Source: AGHT+IE746uda5El8eN5A7OHlfO9WdCrJanAJfzhfCx4DD9HhuvTkdOEUH3TpExhAIltJaJvINgbzg==
X-Received: by 2002:a17:902:f54c:b0:294:918e:d253 with SMTP id d9443c01a7336-294918ed61bmr77101135ad.12.1761473028610;
        Sun, 26 Oct 2025 03:03:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.03.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:03:48 -0700 (PDT)
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
Subject: [PATCH v12 mm-new 10/10] selftests/bpf: add test case for BPF-THP inheritance across fork
Date: Sun, 26 Oct 2025 18:01:59 +0800
Message-Id: <20251026100159.6103-11-laoar.shao@gmail.com>
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


