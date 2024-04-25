Return-Path: <bpf+bounces-27825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843F8B2628
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057D2286B94
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D314D42C;
	Thu, 25 Apr 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rEMJLYxb"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8512BF22
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061862; cv=none; b=opX5naYNIWtv6XlAx58HKNtF61SS3yovfSkZYByK6My2Nu7YPKe5/1KvWiw6bDjukBHIuGlTEMe1ts4adSNerQGbH+gFfa5ZJN0i8M5PQstU5m/CzOGSQcOT5RpuaDJTc1Kcf6ifhvNrM9/QjPbiMCx6gpeIMtS9wk6CPyNIZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061862; c=relaxed/simple;
	bh=ynvrJ/6mFrLrs5tuaeV8Pv0AMZpZ5YMpTvgBFrhd854=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9NdT6gzN4eWU4YwtBNaH12GhZJoPJCGkotqQzcNhQvO/ZIneri7EdUWBPn+drXbQfIeNaZFNbKK9GBlbg7rJJ7MEJq5vtRrSeTmSQFCnhfcbCzhhWcJRtqrJKflRwjmfNd//JArpPDivve6YIGm5tMQJp46MhD5E9XEoKgsgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rEMJLYxb; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714061851; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jRx7vzvelVGhwKoWoaMEljQ/WgfrVr5yz7wXyWWk3lA=;
	b=rEMJLYxbyrBMimyNwFfYVp9OkW0FOc+ElAoATvTxHvcgR414QixHpe0MzGDuCpX+9QEoCJq7OmkU4pfDCglSNa4Yx7sdie3Awjvx1nLaUud0YNrRJ1BTwQESxGgpXaMVZtFS86y1HyZ2AlArws/gO97EgI0DRJf0zCR6Au4lBMs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5FyP2B_1714061848;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5FyP2B_1714061848)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:17:29 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	dsahern@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	laoar.shao@gmail.com,
	fred.cc@alibaba-inc.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: extend BPF_SOCK_OPS_RTT_CB test for srtt and mrtt_us
Date: Fri, 26 Apr 2024 00:17:24 +0800
Message-Id: <20240425161724.73707-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425161724.73707-1-lulie@linux.alibaba.com>
References: <20240425161724.73707-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because srtt and mrtt_us are added as args in bpf_sock_ops at
BPF_SOCK_OPS_RTT_CB, a simple check is added to make sure they are both
non-zero.

$ ./test_progs -t tcp_rtt
  #373     tcp_rtt:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 14 ++++++++++++++
 tools/testing/selftests/bpf/progs/tcp_rtt.c      |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index 8fe84da1b9b49..f2b99d95d9160 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -10,6 +10,9 @@ struct tcp_rtt_storage {
 	__u32 delivered;
 	__u32 delivered_ce;
 	__u32 icsk_retransmits;
+
+	__u32 mrtt_us;	/* args[0] */
+	__u32 srtt;	/* args[1] */
 };
 
 static void send_byte(int fd)
@@ -83,6 +86,17 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 invoked,
 		err++;
 	}
 
+	/* Precise values of mrtt and srtt are unavailable, just make sure they are nonzero */
+	if (val.mrtt_us == 0) {
+		log_err("%s: unexpected bpf_tcp_sock.args[0] (mrtt_us) %u == 0", msg, val.mrtt_us);
+		err++;
+	}
+
+	if (val.srtt == 0) {
+		log_err("%s: unexpected bpf_tcp_sock.args[1] (srtt) %u == 0", msg, val.srtt);
+		err++;
+	}
+
 	return err;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_rtt.c b/tools/testing/selftests/bpf/progs/tcp_rtt.c
index 0988d79f15877..42c729f855246 100644
--- a/tools/testing/selftests/bpf/progs/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/progs/tcp_rtt.c
@@ -10,6 +10,9 @@ struct tcp_rtt_storage {
 	__u32 delivered;
 	__u32 delivered_ce;
 	__u32 icsk_retransmits;
+
+	__u32 mrtt_us;	/* args[0] */
+	__u32 srtt;	/* args[1] */
 };
 
 struct {
@@ -55,5 +58,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 	storage->delivered_ce = tcp_sk->delivered_ce;
 	storage->icsk_retransmits = tcp_sk->icsk_retransmits;
 
+	storage->mrtt_us = ctx->args[0];
+	storage->srtt = ctx->args[1];
+
 	return 1;
 }
-- 
2.32.0.3.g01195cf9f


