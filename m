Return-Path: <bpf+bounces-66517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8CB3557F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334CE1B65C02
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C42FE598;
	Tue, 26 Aug 2025 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6rND3tB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE22F7473;
	Tue, 26 Aug 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192888; cv=none; b=uslZj8GeMDha+eQ4hT2ttyhat04KD9kknqK6AqasoVg880S+Vva96apO1Jyv36DZhoOUOQekSrrOrUicpz1wmN55dZYCQkHUalkbNEoHNLmXSqzeUQJtlM2OvorKIxf5HEYBeeiR5D7YMHEUQRXEbe+X8SqTNcBsraaw+JWkzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192888; c=relaxed/simple;
	bh=u9o1RLaSnC4Tf/6g9oXiZ+oGCOQdaK14VXZ2dGmQiaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YlL5QtnYMurXUcQ5YqeXvXtZEUIv2ul2p/ncjkfxP+6adOIu4SfqYvrt1KGURd2uaqr17+H33dXIydmnpLywHDnNe6/4rVweltI6KLFDDjJxvzX4Q2L49IwUOOWERTY25M3TF0bZOzQLltnsdpLxlBfaeb98TTK7huflgBT9Q4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6rND3tB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771facea122so158613b3a.1;
        Tue, 26 Aug 2025 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192886; x=1756797686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z6Bi8t88rSpzG1T0oB52bwNWI4uzeIhbuID9C/28XE=;
        b=k6rND3tBMjnnzr8f0J9WR4YhlHrc4a2BoXvfDDJPhYGLyyZwAfsvKW3Bez8+QeAfq0
         I+8BfPh7InPqfqD2333wkmDbPv/8L01l2K7+4lLhAIs9JCkwsACy/fPQOC/yLbTjPUjj
         AO2RfwJNSHurlpt3tHbsA76DKGrFIJGV/4KMkMO2AMkZuqh4TtnxJRrd4OGnVIZaHAJR
         +/RflNi6SfRzdKEB6cNC9m4xMxfkIuCV7nPSI4Y5uFLXSgtbWsQsNHGxlv2ftbZnm76f
         c7A1H4M0qAm/IL0QeGvQCMdvF63h/rdmeS01brMG31JuWHmmujx+XqT2WWKBQbnPiRtm
         k+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192886; x=1756797686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z6Bi8t88rSpzG1T0oB52bwNWI4uzeIhbuID9C/28XE=;
        b=X5guEpBkZxv4bA9ED3Zxkuqkg0LL6T46exqEzjcSUKXd2G43Pshw3YEJySPpKRtOqe
         5Q5QODN5nai0Ur5u03U8/Ouu2Gw1WjV/bczb8O8SMaZwrpJTEDfVED/bcctg939rYqps
         cQWYtZzkKus9wgF0lrJOrDhNNHW2vxSxXsJ13MQFgetPzndJdSsPG2JKJErXrRmwtXqA
         fd/yRyFtGUgq+o6op/tSV0eLzC5ewbQ2IVK/3ni8BHyrpMl0jw2adGRZ6z5TLtA7RGgM
         P+VBIrHlud58t/iaMrkxOaxSe/mFgfwFQVMxlaHh366vH39DzVUPd6ssG14UVdLzy5rG
         Z59g==
X-Forwarded-Encrypted: i=1; AJvYcCURPdLBwLIwjsxaA+Gv7ftTR7N2/ZOUA+LhuI8PFBSdWyI24z4nlrVxTi99mBTvHe9gO32AGtzNVWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yKi9RZ9RBwy4PxI//QROwVgh5d+ODBmwDPtMZMgWk7F7ylaR
	aM0JmYLPOj8GcAxHjiKJA37nHmi0+xWyA06WPc/+IHzMexA0iH6niHIr
X-Gm-Gg: ASbGnct0y54oKlVi1gg405Qv6knwiGajPCq4ZpsBsvGEeBqHXi16ds2lGX0HyhsIwZe
	Ph07dHwSCitBHqMjHYkBMHT6CYYN3FEE4xZQfuacOXNy0Y3K+zqgaIOcrdVxzs8CDo+Bxo47C5w
	fqERKMlGHXRCDstn9VsMy54TOb13RjwcrOzSsKdjiMfEzql1xm3DAnexkqDurqyvysxoq3FW0HI
	jPkC/cuJg8wZfX9uXqb/TQYeXi9U2Z6THUApR1GCgDrCk7Zg2bLn6lcPsMPMnwK/o8+RiH1bfyv
	8JAVt7Je4+zbtu5IOeT+ZhIxoXscud0mnouOqIOxOmF12l+3ssSJYXBbTyNoN8atXCeB9lpNmwl
	i10rYXmbKqtl2WOsisEXOwbiZsCEMnJb1H779dDktTK9RoHgYewAfoEvevuEMPnhO/h+bVV7DCQ
	zbGnElhddR5oWB+g==
X-Google-Smtp-Source: AGHT+IHLwUH1ijQiPQrQUCBsEKBb4EJG1bUTZX90lI8IkidK1MmC5uPmTYLnP5pDhbJKCobTBp1VOA==
X-Received: by 2002:a05:6a00:2d20:b0:771:ecec:519b with SMTP id d2e1a72fcca58-771ecec60d4mr5472496b3a.12.1756192886218;
        Tue, 26 Aug 2025 00:21:26 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:21:25 -0700 (PDT)
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
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 07/10] selftests/bpf: add test case to update thp policy
Date: Tue, 26 Aug 2025 15:19:45 +0800
Message-Id: <20250826071948.2618-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
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
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index bf367c6e6f52..6e65d7b0eb80 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -227,6 +227,27 @@ static void subtest_thp_fork(void)
 	bpf_link__destroy(ops_link);
 }
 
+static void subtest_thp_policy_update(void)
+{
+	struct bpf_link *old_link, *new_link;
+	int err;
+
+	old_link = bpf_map__attach_struct_ops(skel->maps.thp_fork_ops);
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
@@ -308,6 +329,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy();
 	if (test__start_subtest("khugepaged_fork"))
 		subtest_thp_fork();
+	if (test__start_subtest("policy_update"))
+		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
 }
-- 
2.47.3


