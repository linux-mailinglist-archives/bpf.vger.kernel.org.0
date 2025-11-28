Return-Path: <bpf+bounces-75731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27EC92837
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD734F943
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984E32B9A0;
	Fri, 28 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JZESVIOq"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE8329C7D;
	Fri, 28 Nov 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345975; cv=none; b=iscnTt5yqRNBvHM9nvQhBzhktsP6L60c/gr/5paz45J6CYADOlOB9IELxJhcmZ+S6Y7RIjFbUcL95thHsUz3rXq5GcDzs3qwy87WQpdwJMA5ipV3MFucjMBm7YkZQ9PTkHesbvMCThD5uxJeU+UDsRuKB2o8Q2mz3X0q/WmwIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345975; c=relaxed/simple;
	bh=k8krsWT/x0GUv66MZcxXLZX2sPNCof4Ugeu0Wu3by4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqNiYKZZqoLLfC3YRCoBBVeBGRnu8DO2A8379uGD8nKrnVEmNBuPOE7K/BDaY/m3CP47dFTLbvA1kCDsNwWZKDtNqlqJ8Os3K88gMD53+zeOAaqwpvdfoODvRbemqb8+dERXHmLVoOn4qW9TFbdID8WCLpZRUeHYQoqWZXJ8GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JZESVIOq; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764345973; x=1795881973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9rd1qnxgT5n1V9dbFcwzJdspGNvNKAJ3jsGytQQ6BM=;
  b=JZESVIOqC6XtLDzajgsfvwLwYAbKV4DJWaq5SnYkmKi0g2+Nv2CBySiA
   RyGGCfUiS3GujwxmKKkxEx4MDx18DUOORZSwfPe5hXAbrBfe30GXbHTgK
   wkPt5zb/yfg0KANS8CvBck62EvahamcGjwsgBq6oO064E5ImQoKMJWQSR
   sloTfOKElHbf12XxX+6V4IEsvo4OmV4yfBmQa2/fqT3IERXUWpD+k8cyL
   l3DsR+WoWxPrJDoe2Tkix2ytEQaAo4uvzRnSX8a31+YKETAHnlB9btU7O
   0fNXV5jIxsjjJ4Fk7rKntUF7nA8DMd0BJvHl0DrZ39h5SBjnGYjQB0awH
   g==;
X-CSE-ConnectionGUID: +ozDTOdbTJiZHwnK/xw56Q==
X-CSE-MsgGUID: r+hvZmqiST61U0979E0DJg==
X-IronPort-AV: E=Sophos;i="6.20,234,1758585600"; 
   d="scan'208";a="8032371"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 16:06:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16352]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.165:2525] with esmtp (Farcaster)
 id 7506644f-1f12-434f-b1fa-5e433dec5e2b; Fri, 28 Nov 2025 16:06:10 +0000 (UTC)
X-Farcaster-Flow-ID: 7506644f-1f12-434f-b1fa-5e433dec5e2b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:06:08 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:06:06 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, <kohei.enju@gmail.com>,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf v1 2/2] selftests/bpf: add tests for attaching invalid fd
Date: Sat, 29 Nov 2025 01:04:55 +0900
Message-ID: <20251128160504.57844-3-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251128160504.57844-1-enjuk@amazon.com>
References: <20251128160504.57844-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add test cases for situations where adding the following types of file
descriptors to a cpumap entry should fail:
- Non-BPF file descriptor (expect -EINVAL)
- Nonexistent file descriptor (expect -EBADF)

Also tighten the assertion for the expected error when adding a
non-BPF_XDP_CPUMAP program to a cpumap entry.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 .../bpf/prog_tests/xdp_cpumap_attach.c        | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index df27535995af..ad56e4370ce3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -18,7 +18,7 @@ static void test_xdp_with_cpumap_helpers(void)
 	struct bpf_cpumap_val val = {
 		.qsize = 192,
 	};
-	int err, prog_fd, prog_redir_fd, map_fd;
+	int err, prog_fd, prog_redir_fd, map_fd, bad_fd;
 	struct nstoken *nstoken = NULL;
 	__u32 idx = 0;
 
@@ -79,7 +79,22 @@ static void test_xdp_with_cpumap_helpers(void)
 	val.qsize = 192;
 	val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
 	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
-	ASSERT_NEQ(err, 0, "Add non-BPF_XDP_CPUMAP program to cpumap entry");
+	ASSERT_EQ(err, -EINVAL, "Add non-BPF_XDP_CPUMAP program to cpumap entry");
+
+	/* Try to attach non-BPF file descriptor */
+	bad_fd = open("/dev/null", O_RDONLY);
+	ASSERT_GE(bad_fd, 0, "Open /dev/null for non-BPF fd");
+
+	val.bpf_prog.fd = bad_fd;
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_EQ(err, -EINVAL, "Add non-BPF fd to cpumap entry");
+
+	/* Try to attach nonexistent file descriptor */
+	err = close(bad_fd);
+	ASSERT_EQ(err, 0, "Close non-BPF fd for nonexistent fd");
+
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_EQ(err, -EBADF, "Add nonexistent fd to cpumap entry");
 
 	/* Try to attach BPF_XDP program with frags to cpumap when we have
 	 * already loaded a BPF_XDP program on the map
-- 
2.51.0


