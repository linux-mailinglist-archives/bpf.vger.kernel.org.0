Return-Path: <bpf+bounces-27823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4988B2626
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B19286D54
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17614D2A2;
	Thu, 25 Apr 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j+8Y6E3S"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A714C585
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061853; cv=none; b=OHY8pUooRfXwT2NrbMnqiSHzZDelNBJ+Gwcqx5CuyAO0RFDFhNeY1sG1H/OjOUbPbP+Zx795GSFrjZ4Hj9C3EuChfnK9AWm+udGzPSShsUddWW2ySpcQgb73taKzJzoTnPMsLocTIm2bk9nazCPZ+ZqEc2hz3qIQanTwdEk8rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061853; c=relaxed/simple;
	bh=KcS379exweEq2KWZHRGsfLBKQpFGUW4DWIGIyV4JX+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtC/b8AuTCXd9VZ3OhndQdnEDb4Ci9qA9JQCSSqFZU7d1uyoccXsp+tqlN0xHgyc5BdMu6JGCzDz7M1nSIC5dXLPZddJo7uZIgCJPDdE3NtM27YfDCGGGliqT/Ocjv6E8lWwgzgwX75yFxDw9rY/kZ9IlHwZ6h1iiSKb5QMuQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j+8Y6E3S; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714061848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JGOsPDjGHcmz0dIPXvuQRmYlhGN6+V5gSa/YITOAQgQ=;
	b=j+8Y6E3SjKn4CSXvqJltr1c0SCg0GbFdmvTF5Moo3ON9VuH7SdlfnD8aEc2t2pzjEc4RFHCXZdDycHTv0OGdCsujYoGsZEfm7cUbT/1AgffNIShE5qzugT4fUzZna5lc4MeDdasVYDXt0bzhmLYRV4RDKhE+ihxYXno1gtj5ygk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5G2CFb_1714061844;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5G2CFb_1714061844)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:17:26 +0800
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
Subject: [PATCH bpf-next v1 0/2] bpf: add mrtt and srtt as ctx->args for BPF_SOCK_OPS_RTT_CB
Date: Fri, 26 Apr 2024 00:17:22 +0800
Message-Id: <20240425161724.73707-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These provides more information about tcp RTT estimation. The selftest for
BPF_SOCK_OPS_RTT_CB is extended for the added args.

changelogs
-> v1:
- extend rtt selftest for added args (suggested by Stanislav)

Philo Lu (2):
  bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
  selftests/bpf: extend BPF_SOCK_OPS_RTT_CB test for srtt and mrtt_us

 include/net/tcp.h                                |  4 ++--
 include/uapi/linux/bpf.h                         |  2 ++
 net/ipv4/tcp_input.c                             |  4 ++--
 tools/include/uapi/linux/bpf.h                   |  2 ++
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 14 ++++++++++++++
 tools/testing/selftests/bpf/progs/tcp_rtt.c      |  6 ++++++
 6 files changed, 28 insertions(+), 4 deletions(-)

--
2.32.0.3.g01195cf9f


