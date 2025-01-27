Return-Path: <bpf+bounces-49844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6283A1D310
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00377A084E
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7B91FCFDB;
	Mon, 27 Jan 2025 09:09:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F591FCCE6;
	Mon, 27 Jan 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968993; cv=none; b=iHzSqy0b5aIhGrTfLztTHAOYdibJWLbFzUBBO5eZqWl1I3TR3w5M549UqugDOF/F6bmiUNqLm/JB1AiPsml7jIgslU+hhWO5Z01/MLelkmDqdWdpbcw2GO/YMV0nmbGIaNOjzvhgbxnE1k1qFFopeTQbOO12hj8YdNeem8H726A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968993; c=relaxed/simple;
	bh=XJDI1RtH284Ughaa9zhcE+X7NmxYm8WZ4N2i80Ek0rY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMIIoOZIPcVtzQzVbOnhnV4IPvXzYZqi821UMeOJpRzr8oPRA01yR2R+4c9TgK2qMFe1dsGYE4t9SxuKs+QCJQWkNLkTfH9YLZ9HldZckc/32eWRAdg25o7+vhuoDSitjSF3dMzqlTg1QCl4EFNkilXHiNq0Fx/17GloPzR/L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YhMz85wTmz1JJ9V;
	Mon, 27 Jan 2025 17:08:36 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 948F1140257;
	Mon, 27 Jan 2025 17:09:42 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 17:09:42 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 17:09:40 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH 1/2] ipv4, bpf: Introduced to support the ULP to get or set sockets
Date: Mon, 27 Jan 2025 17:07:23 +0800
Message-ID: <20250127090724.3168791-2-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
References: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn200003.china.huawei.com (7.202.194.126)

Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I'm not sure why there is such a difference, but I noticed that
tcp_setsockopt is called in bpf_setsockopt.I think we can add the
handling of this case.

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


