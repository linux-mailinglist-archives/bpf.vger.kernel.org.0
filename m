Return-Path: <bpf+bounces-49343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDFDA1790A
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88583A71E6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E61B4233;
	Tue, 21 Jan 2025 08:08:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C2145A18;
	Tue, 21 Jan 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446898; cv=none; b=i/Y4X6Tw/HQhp6GqJ+hs6j86NAN42QNoeXs/TXSng77SsglmJl0NVZzoejyjymqPph3jzbS4cexuEZ+CgKwipe/Q5KIMp7WZU88ne5kqA6vcxbWooTadg+V+o7YZVOC9mKZ3gxqkOA/cC0vtEntt7NcIGgzFFlXu5FsUnGeDl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446898; c=relaxed/simple;
	bh=HAJv06eZ8aKJ6PDM7sxA5oy9XJW1Xbep8C8bLLUK3No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hti4n3g7I5xx86ugIJZpjUC2mSUj87VIQ+w7Rq/E4jtjqyZCJzTLZEzMBKooUPasbT7Yyjuw33LnIbN+ZfV4qdr9L4YmeUeknFJE/l0EYJmDmZSwfKg7cqhcfxAgyKI9OC6nGD48XC0DWXnZ2FZF3maUX9IVmnPhiboGtYAYvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ycfwj2bXwz20pNC;
	Tue, 21 Jan 2025 16:08:37 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 326921402C3;
	Tue, 21 Jan 2025 16:08:12 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:08:11 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:08:10 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH] ipv4, bpf: Introduced to support the ULP to modify sockets during setopt
Date: Tue, 21 Jan 2025 16:05:47 +0800
Message-ID: <20250121080547.3159934-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn200003.china.huawei.com (7.202.194.126)

Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I think we can add the handling of this case.

Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 713d6f454df3..f23d3f87e690 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5383,6 +5383,10 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
+	case TCP_ULP:
+		if (getopt)
+			return -EINVAL;
+		break;
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
-- 
2.43.0


