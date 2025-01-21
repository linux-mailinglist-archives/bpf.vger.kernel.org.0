Return-Path: <bpf+bounces-49345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BD5A1792E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09D2161A65
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 08:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DB1B2183;
	Tue, 21 Jan 2025 08:16:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F784145A18;
	Tue, 21 Jan 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447377; cv=none; b=rBw9mth5HGcb0YOfRNfb55GRLUgHHdLv1l2fntowAfvDu2+Bjy9me03boeSwnDyeFQLWJ57vNi5AWm49pgccHWD/LEvH/4Z1EWwTI2Qz6mrkW6G9QdAn072/+KyLU2gY3zRECCg+LBX/w68XLLCl1pkeFceaBG13Oz+1MwJiE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447377; c=relaxed/simple;
	bh=ChZvRjqZRxBLLC1/B+wLbCG1zJW5qdvJLbfpEoirLxg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qy0H9drKzB9pZ2h9fCKQALNVwz/rTJE85MqfFYhfd/0hQiDhcR/pc0D9DdC2VyE5c86puuV3r/i7jXxWcmPLu6+Vve2b+8IUQUxJ55dPsirY+HwQHEpH+I99OZqd2lsDFS6jEIHjiQiSo5hkb5fg1W7H4jlqoS11D3mJpGEPK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ycg1n54fKzgbsS;
	Tue, 21 Jan 2025 16:13:01 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 93E951401F4;
	Tue, 21 Jan 2025 16:16:12 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:16:12 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:16:10 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH] ipv4, bpf: Introduced to support the ULP to get or set sockets
Date: Tue, 21 Jan 2025 16:14:06 +0800
Message-ID: <20250121081406.3160045-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn200003.china.huawei.com (7.202.194.126)

Note that do_tcp_getsockopt and do_tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I think we can add the handling of this case.

Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 713d6f454df3..bdb5c43d6fb0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5380,6 +5380,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_CONGESTION:
 		return sol_tcp_sockopt_congestion(sk, optval, optlen, getopt);
 	case TCP_SAVED_SYN:
+	case TCP_ULP:
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
-- 
2.43.0


