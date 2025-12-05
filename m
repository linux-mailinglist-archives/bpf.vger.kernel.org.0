Return-Path: <bpf+bounces-76096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745ACA5D09
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 02:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E57AC303079C
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75437126C02;
	Fri,  5 Dec 2025 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8B4iJch"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DB398FBA
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897512; cv=none; b=XkY54XhrD3zPe4nYQxtx1aqDT+nSCCNrT5nQMhJCtcOsa8/z7uqL0f/lPmLD3xpgNYm/Rvpd3Df8wXdK+7iGMhz7nru1b9pDzX+RBn/JNg1cDRy1daV2zUmzujpVi/cbuZPtagVn/AZWNhhU6mH4yHDVFLYUh45LsUR4u9sfTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897512; c=relaxed/simple;
	bh=gvSG0jtaY7/heFm/Gslk7vydXL6gPfvO6FWJa0v/rGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BN7cSCK02Q/2fFf6PEZRmuuc8rHS1+hT8mr9W5Xe2QAg1hzN7pSAQMT+80iT3EWE1HSFLpdcqchqjqHTwPIEoLuPFARnBtJWXtsjyKtf7XaFFY5Lmhlmp97fXyUEA+JjyVaRoexnk5/Kj1EHmyXHeGncLdMXdf71bTvgomKEweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8B4iJch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91FEC4CEFB;
	Fri,  5 Dec 2025 01:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764897511;
	bh=gvSG0jtaY7/heFm/Gslk7vydXL6gPfvO6FWJa0v/rGs=;
	h=From:To:Cc:Subject:Date:From;
	b=R8B4iJchtdM9LB9bMtZ0wI0yjT3z8kLfdE/xEXXtJgqNKF8t9GiOfKWQpYLjN3TTy
	 RTfmKdYaUTWB5Gi6okRasqiRrMo4r1LN5O+lmaqR00y5gvHK/6KTMlbnaAsrgYIcRH
	 7/gLLN6kaH+Je0FdfCJ6tuyIusAdUo1a0C/FMP7ftome/06bzEyvTt/xZPbEhmKnFH
	 wSu7FlpjWt8TXakDfI1UZ2ILaVLozhahWzyUCTq2j3JUpZT6LGj5Gu9i5B/GKhrOnO
	 vS8Eq823AtpUxbQzPCwwmtbrTApcT3/b3jr+rVhhgRkmY+JbtAjsW5eRP6to1J8uZ6
	 jFJouSTSJMSQg==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	qmo@kernel.org,
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
	jolsa@kernel.org
Subject: [PATCH bpf] tools: bpftool: fix truncated netlink dumps
Date: Thu,  4 Dec 2025 17:18:23 -0800
Message-ID: <20251205011823.751868-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink requires that the recv buffer used during dumps is at least
min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
get truncated. Make sure bpftool follows this requirement, avoid
missing information on systems with large pages.

Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: qmo@kernel.org
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bpf@vger.kernel.org
---
 tools/bpf/bpftool/net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index cfc6f944f7c3..7f248fc01332 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -156,7 +156,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
 	bool multipart = true;
 	struct nlmsgerr *err;
 	struct nlmsghdr *nh;
-	char buf[4096];
+	char buf[8192];
 	int len, ret;
 
 	while (multipart) {
@@ -201,6 +201,10 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
 					return ret;
 			}
 		}
+
+		if (len)
+	                fprintf(stderr, "Invalid message or trailing data in Netlink response: %d\n",
+				len);
 	}
 	ret = 0;
 done:
-- 
2.52.0


